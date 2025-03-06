using EMS.Business.Dtos;
using EMS.Business.Services;
using EMS.Models.Salaries;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace EMS.Controllers
{
    public class SalaryController : Controller
    {
        private readonly ISalaryService _salaryService;
        private readonly ISalaryPaymentService _salaryPaymentService;
        private readonly IUserService _userService;

        public SalaryController(ISalaryService salaryService, ISalaryPaymentService salaryPaymentService, IUserService userService)
        {
            _salaryService = salaryService;
            _salaryPaymentService = salaryPaymentService;
            _userService = userService;
        }

        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Index()
        {
            IEnumerable<SalaryDto> salaries = await _salaryService.GetSalariesAsync();
            return View(salaries);
        }

        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Create(long? userId)
        {
            ViewData["Users"] = await _userService.GetEmployeesAsync();
            var model = new CreateSalaryViewModel();
            if (userId.HasValue)
            {
                model.UserId = userId.Value;
            }
            return View(model);
        }

        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Edit(long? id)
        {
            if (!id.HasValue)
            {
                return NotFound();
            }

            var salary = await _salaryService.GetSalaryByIdAsync(id.Value, s => s.User);

            if (salary == null)
            {
                return NotFound();
            }

            var model = new EditSalaryViewModel
            {
                Id = salary.Id,
                Basic = salary.Basic,
                Allowance = salary.Allowance,
                EffectiveAt = salary.EffectiveAt,
                UserId = salary.UserId,
                Fullname = salary.User.Fullname
            };

            return View(model);
        }

        [HttpPost]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Create(CreateSalaryViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            var salaryDto = new SalaryDto
            {
                Basic = model.Basic,
                Allowance = model.Allowance,
                EffectiveAt = model.EffectiveAt,
                UserId = model.UserId
            };

            await _salaryService.CreateSalaryAsync(salaryDto);
            return RedirectToAction("Index");
        }

        [HttpPost]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Edit(EditSalaryViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            var salaryDto = new SalaryDto
            {
                Id = model.Id,
                Basic = model.Basic,
                Allowance = model.Allowance,
                EffectiveAt = model.EffectiveAt,
                UserId = model.UserId
            };

            try
            {
                await _salaryService.UpdateSalaryAsync(salaryDto);
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                ModelState.AddModelError(string.Empty, ex.Message);
                return View(model);
            }
        }

        [HttpPost]
        [Authorize(Roles = "Admin")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Delete(long? id)
        {
            var userId = long.Parse(HttpContext.User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
            if (!id.HasValue)
            {
                return NotFound();
            }

            try
            {
                var salaryDeleted = await _salaryService.DeleteSalaryAsync(id.Value, userId);
                return RedirectToAction("Index");
            }
            catch (ArgumentNullException)
            {
                return NotFound();
            }
            catch (Exception ex)
            {
                ModelState.AddModelError(string.Empty, ex.Message);
                return RedirectToAction("Index");
            }
        }
    }
}
