using System.Security.Claims;
using EMS.Business.Dtos;
using EMS.Business.Services;
using EMS.Hubs;
using EMS.Models.Notifications;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.OutputCaching;
using Microsoft.AspNetCore.SignalR;
using Microsoft.IdentityModel.Tokens;

namespace EMS.Controllers
{
    public class NotificationController : Controller
    {
        private readonly IDepartmentService _departmentService;
        private readonly IHubContext<NotificationHub> _notificationHubContext;
        private readonly INotificationService _notificationService;
        private readonly INotificationRecipientService _notificationRecipientService;
        private readonly IUserService _userService;

        public NotificationController(IDepartmentService departmentService,
            IHubContext<NotificationHub> notificationHubContext,
            INotificationService notificationService,
            INotificationRecipientService notificationRecipientService,
            IUserService userService)
        {
            _departmentService = departmentService;
            _notificationHubContext = notificationHubContext;
            _notificationService = notificationService;
            _notificationRecipientService = notificationRecipientService;
            _userService = userService;
        }

        [Authorize]
        public async Task<IActionResult> Index()
        {
            var departments = await _departmentService.GetDepartmentsAsync();
            ViewBag.Departments = departments;
            return View();
        }

        [Authorize]
        [HttpPost]
        public async Task<IActionResult> Send(CreateNotificationViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            var userId = long.Parse(HttpContext.User.FindFirst(ClaimTypes.NameIdentifier)?.Value);

            var dto = new NotificationDto
            {
                Message = model.Message,
                UserId = userId,
                Title = model.Title,
            };

            if (model.DepartmentId.IsNullOrEmpty())
            {
                return BadRequest();
            }
            
            
            if (model.DepartmentId.Equals("all"))
            {
                var notification = await _notificationService.CreateNotificationAsync(dto);
                List<long> userIds = await _userService.GetUserIdsAsync();
                userIds.Remove(userId);
                List<NotificationRecipientDto> notificationRecipients = new List<NotificationRecipientDto>();

                foreach (var id in userIds)
                {
                    notificationRecipients.Add(new NotificationRecipientDto
                    {
                        NotificationId = notification.Id,
                        UserId = id,
                        IsRead = false
                    });
                }

                await _notificationRecipientService.CreateNotificationRecipientsAsync(notificationRecipients);

                await _notificationHubContext.Clients.All.SendAsync(
                    "ReceiveMessage", 
                    HttpContext.User.FindFirst(ClaimTypes.Name)?.Value, 
                    notification.Title, 
                    notification.Message,
                    DateTime.Now.ToString());
                return RedirectToAction("Index");
            }
            else if (long.TryParse(model.DepartmentId, out long departmentId))
            {
                dto.DepartmentId = departmentId;
                var notification = await _notificationService.CreateNotificationAsync(dto);
                var userIds = await _userService.GetUserIdsByDepartmentIdAsync(departmentId);
                if (userIds.Contains(userId))
                {
                    userIds.Remove(userId);
                }

                var notificationRecipients = new List<NotificationRecipientDto>();
                foreach (var id in userIds)
                {
                    notificationRecipients.Add(new NotificationRecipientDto
                    {
                        NotificationId = notification.Id,
                        UserId = id,
                        IsRead = false
                    });
                }

                await _notificationRecipientService.CreateNotificationRecipientsAsync(notificationRecipients);

                await _notificationHubContext.Clients.Groups(departmentId.ToString()).SendAsync(
                    "ReceiveMessage",
                    HttpContext.User.FindFirst(ClaimTypes.Name)?.Value,
                    notification.Title,
                    notification.Message,
                    DateTime.Now.ToString());
            }
            else
            {
                return BadRequest();
            }

            return RedirectToAction("Index");
        }

        [Authorize]
        public async Task<IActionResult> GetNotifications()
        {
            var userId = long.Parse(HttpContext.User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
            var notifications = await _notificationRecipientService.GetNotificationsByUserIdAsync(userId);
            var result = notifications.Select(n => new
            {
                n.Id,
                n.IsRead,
                n.NotificationId,
                n.UserId,
                n.CreatedAt,
                Notification = n.Notification != null ? new
                {
                    n.Notification.Title,
                    n.Notification.Message,
                    SenderName = n.Notification.User.Fullname != null ? n.Notification.User.Fullname : "Unknown"
                } : null
            }).ToList();
            return Json(result);
        }

        [Authorize]
        public async Task<IActionResult> GetUnreadNotificationsCount()
        {
            var userId = long.Parse(HttpContext.User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
            var count = await _notificationRecipientService.GetUnreadNotificationsCountAsync(userId);
            return Json(new
            {
                count
            });
        }

        [Authorize]
        [HttpPost]
        public async Task<IActionResult> MarkAllAsRead()
        {
            var userId = long.Parse(HttpContext.User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
            await _notificationRecipientService.MarkAllAsReadAsync(userId);
            return Ok();
        }
    }
}
