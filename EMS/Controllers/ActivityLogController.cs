using EMS.Business.Services;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using EMS.Models.ActivityLogs;
using Microsoft.AspNetCore.Authorization;

namespace EMS.Controllers
{
    public class ActivityLogController : Controller
    {
        private readonly IActivityLogService _activityLogService;

        public ActivityLogController(IActivityLogService activityLogService)
        {
            _activityLogService = activityLogService;
        }

        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Index()
        {
            var userId = long.Parse(HttpContext.User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
            var activityLogs = await _activityLogService.GetActivityLogsAsync(userId);
            var viewModel = new List<ActivityListViewModel>();

            foreach (var activityLog in activityLogs)
            {
                viewModel.Add(new ActivityListViewModel
                {
                    Id = activityLog.Id,
                    Detail = activityLog.Detail,
                    CreatedDate = activityLog.CreatedAt.Value
                });
            }

            return View(viewModel);
        }
    }
}
