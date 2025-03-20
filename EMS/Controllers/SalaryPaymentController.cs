using System.Globalization;
using EMS.Business.Dtos;
using EMS.Business.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace EMS.Controllers
{
    public class SalaryPaymentController : Controller
    {
        private readonly ISalaryPaymentService _salaryPaymentService;
        private readonly IUserService _userService;

        public SalaryPaymentController(ISalaryPaymentService salaryPaymentService, IUserService userService)
        {
            _salaryPaymentService = salaryPaymentService;
            _userService = userService;
        }

        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Index(string time)
        {
            DateTime selectedTime;

            if (string.IsNullOrEmpty(time) ||
                !DateTime.TryParseExact(time, "yyyy-MM", null, DateTimeStyles.None, out selectedTime))
            {
                selectedTime = DateTime.Now;
            }

            var salaryPayments = await _salaryPaymentService.GetSalaryPaymentsByThisMonthAsync(selectedTime);
            return View(salaryPayments);
        }

        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Create()
        {
            var employee = await _userService.GetEmployeesAsync(u => u.Department);
            return View(employee);
        }

        [HttpPost]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> CreatePayment(List<long> selectedUsers)
        {
            if (selectedUsers == null || selectedUsers.Count == 0)
            {
                return RedirectToAction("Create");
            }

            await _salaryPaymentService.CreatePaymentsByListUserIdAsync(selectedUsers);
            return RedirectToAction("Index");
        }

        [HttpPost]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> UpdateStatus(long id, string status)
        {
            if (status == "Paid" || status == "Canceled")
            {
                await _salaryPaymentService.UpdateStatusAsync(id, status);
                return Ok();
            }
            else
            {
                return BadRequest("Invalid status");
            }
        }
    }
}
