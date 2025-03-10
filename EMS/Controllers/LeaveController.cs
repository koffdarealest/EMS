using EMS.Business.Services;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using EMS.Business.Dtos;
using EMS.Data.Enums;
using EMS.Models.Leaves;
using Microsoft.AspNetCore.Authorization;

namespace EMS.Controllers
{
    public class LeaveController : Controller
    {
        private readonly ILeaveRequestService _leaveRequestService;
        private readonly ILeaveBalanceService _leaveBalanceService;

        public LeaveController(ILeaveRequestService leaveRequestService, ILeaveBalanceService leaveBalanceService)
        {
            _leaveRequestService = leaveRequestService;
            _leaveBalanceService = leaveBalanceService;
        }

        public async Task<IActionResult> Index()
        {
            if (!User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Login", "Auth");
            }
            if (User.IsInRole("Admin"))
            {
                var leaveRequests = await _leaveRequestService.GetLeaveRequestsAsync(l => l.User);
                return View(leaveRequests);
            }
            if (User.IsInRole("Employee"))
            {
                var userId = long.Parse(HttpContext.User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
                var leaveRequests = await _leaveRequestService.GetLeaveRequestsByUserIdAsync(userId, l => l.User);
                return View(leaveRequests);
            }
            return View(new List<LeaveRequestDto>());
        }

        public IActionResult CreateRequest()
        {
            var userId = long.Parse(HttpContext.User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
            CreateLeaveRequestViewModel model = new CreateLeaveRequestViewModel
            {
                Fullname = HttpContext.User.FindFirst(ClaimTypes.Name)?.Value
            };
            return View(model);
        }

        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Approve(long? id, bool isApprove, int? numOfDay, string type)
        {
            if (!id.HasValue && !numOfDay.HasValue)
            {
                return BadRequest();
            }

            try
            {
                var requestDto = await _leaveRequestService.ApproveRequestByIdAsync(id.Value, isApprove, numOfDay.Value, type);
                return RedirectToAction("Index");
            } 
            catch (Exception ex)
            {
                return NotFound();
            }
        }

        [HttpPost]
        public async Task<IActionResult> CreateRequest(CreateLeaveRequestViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            if (model.From > model.To)
            {
                ModelState.AddModelError("From", "From date must be less than To date");
                return View(model);
            }

            var userId = long.Parse(HttpContext.User.FindFirst(ClaimTypes.NameIdentifier)?.Value);

            LeaveRequestDto dto = new LeaveRequestDto
            {
                UserId = userId,
                Type = model.Type,
                Reason = model.Reason,
                From = model.From,
                To = model.To.AddHours(23).AddMinutes(59).AddSeconds(59),
                Status = LeaveRequestStatus.Pending,
            };

            try
            {
                await _leaveRequestService.CreateLeaveRequestAsync(dto);
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                return View(model);
            }
        }

        
    }
}
