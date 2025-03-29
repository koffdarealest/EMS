using System.Runtime.CompilerServices;
using EMS.Business.Services;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using EMS.Business.Clouds;
using EMS.Models.Attendance;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.OutputCaching;
using EMS.Business.Dtos;
using Microsoft.AspNetCore.RateLimiting;

namespace EMS.Controllers
{
    public class AttendanceController : Controller
    {
        private readonly IAttendanceService _attendanceService;
        private readonly IUserService _userService;
        private readonly IAzureBlobCheckService _azureBlobCheckService;

        public AttendanceController(IAttendanceService attendanceService, IUserService userService, IAzureBlobCheckService azureBlobCheckService)
        {
            _attendanceService = attendanceService;
            _userService = userService;
            _azureBlobCheckService = azureBlobCheckService;
        }

        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Index(DateTime? date)
        {
            var selectedDate = date ?? DateTime.Today;
            if (selectedDate > DateTime.Today)
            {
                ViewBag.SelectedDate = selectedDate;
                return View(new List<AttendanceDto>());
            }
            var attendances = await _attendanceService.GetAttendancesByDateAsync(selectedDate);
            ViewBag.SelectedDate = selectedDate;
            return View(attendances);
        }

        public async Task<IActionResult> Edit(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var attendance = await _attendanceService.GetAttendanceByIdAsync(id.Value, u => u.User);
            if (attendance == null)
            {
                return NotFound();
            }

            EditAttendanceViewModel editAttendanceViewModel = new EditAttendanceViewModel
            {
                Id = attendance.Id,
                UserId = attendance.UserId,
                CheckIn = attendance.CheckIn,
                CheckOut = attendance.CheckOut,
                Status = attendance.Status,
                Fullname = attendance.User?.Fullname
            };

            return View(editAttendanceViewModel);
        }

        public async Task<IActionResult> CheckIn()
        {
            if (!User.Identity.IsAuthenticated)
            {
                return Forbid();
            }

            var userId = long.Parse(HttpContext.User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
            CheckInViewModel checkInViewModel = new CheckInViewModel
            {
                UserId = userId
            };

            try
            {
                var attendanceToday = await _attendanceService.GetTodayAttendanceByUserIdAsync(userId);
                if (attendanceToday != null)
                {
                    checkInViewModel.IsCheckedIn = attendanceToday.CheckIn.HasValue;
                    checkInViewModel.CheckIn = attendanceToday.CheckIn;
                    checkInViewModel.CheckOut = attendanceToday.CheckOut;
                    checkInViewModel.Status = attendanceToday.Status;
                }
            }
            catch (ArgumentNullException ex)
            {
                return BadRequest(ex.Message);
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
            return View(checkInViewModel);
        }

        public async Task<IActionResult> UserDetail(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }
            var attendances = await _attendanceService.GetAttendancesByUserIdThisMonthAsync(id.Value);
            return View(attendances);
        }

        [HttpPost]
        [EnableRateLimiting("AttendanceConcurrency")]
        public async Task<IActionResult> SubmitCheck([FromBody] CheckInRequestModel model)
        {
            if (model == null || string.IsNullOrEmpty(model.ImageData))
                return BadRequest(new { success = false, message = "Invalid Data!" });

            var userId = long.Parse(HttpContext.User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
            if (userId == null)
            {
                return BadRequest(new { success = false, message = "Cannot find user information!" });
            }
            var attendance = await _attendanceService.GetTodayAttendanceByUserIdAsync(userId);

            if (!model.IsCheckOut && attendance != null && attendance.CheckIn.HasValue)
            {
                return BadRequest(new { success = false, message = "Already check-in!" });
            }
            if (model.IsCheckOut && (attendance == null || attendance.CheckOut.HasValue))
            {
                return BadRequest(new { success = false, message = "You have completed your check today." });
            }

            var imageBytes = Convert.FromBase64String(model.ImageData.Split(',')[1]);
            var fileName = $"{userId}_{DateTime.UtcNow:yyyyMMdd_HHmmss}.jpg";
            var fileStream = new MemoryStream(imageBytes);

            var imageUrl = await _azureBlobCheckService.UploadCheckPhotoAsync(fileStream, fileName);

            if (string.IsNullOrEmpty(imageUrl))
            {
                return StatusCode(500, new { success = false, message = "Can't save image!" });
            }

            if (!model.IsCheckOut)
            {
                await _attendanceService.CheckInAsync(userId, imageUrl);
            }
            else
            {
                await _attendanceService.CheckOutAsync(userId, imageUrl);
            }
            return Ok(new { success = true });
        }

        [HttpPost]
        public async Task<IActionResult> Edit(EditAttendanceViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            var attendanceDto = new AttendanceDto
            {
                Id = model.Id,
                UserId = model.UserId,
                CheckIn = model.CheckIn,
                CheckOut = model.CheckOut,
                Status = model.Status
            };

            try
            {
                await _attendanceService.UpdateAttendanceAsync(attendanceDto);
                return RedirectToAction("Index", new {date = model.CheckIn});
            }
            catch (ArgumentException ex)
            {
                ModelState.AddModelError(string.Empty, ex.Message);
                return View(model);
            }
            catch (Exception ex)
            {
                ModelState.AddModelError(string.Empty, ex.Message);
                return View(model);
            }
        }

    }
}
