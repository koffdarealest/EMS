using EMS.Business.Dtos;
using EMS.Business.Services;
using EMS.Models.Bonus;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace EMS.Controllers
{
    public class BonusController : Controller
    {
        private readonly IBonusService _bonusService;
        private readonly IUserService _userService;

        public BonusController(IBonusService bonusService, IUserService userService)
        {
            _bonusService = bonusService;
            _userService = userService;
        }

        public IActionResult Index()
        {
            return View();
        }

        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Create(long? userId)
        {
            if (!userId.HasValue)
            {
                return NotFound();
            }

            var user = await _userService.GetUserByIdAsync(userId.Value);
            
            if (user == null)
            {
                return NotFound();
            }
            
            CreateBonusViewModel model = new CreateBonusViewModel
            {
                UserId = user.Id,
                Fullname = user.Fullname,
                Avatar = user.Avatar
            };

            return View(model);
        }

        public async Task<IActionResult> Edit(long? id)
        {
            if (!id.HasValue)
            {
                return NotFound();
            }

            var bonus = await _bonusService.GetBonusByIdAsync(id.Value);

            if (bonus == null)
            {
                return NotFound();
            }

            EditBonusViewModel model = new EditBonusViewModel
            {
                Id = bonus.Id,
                UserId = bonus.UserId,
                Fullname = bonus.User.Fullname,
                Avatar = bonus.User.Avatar,
                Amount = bonus.Amount,
                Reason = bonus.Reason,
                IsPenalty = bonus.IsPenalty
            };

            return View(model);
        }

        [HttpPost]
        [Authorize(Roles = "Admin")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(CreateBonusViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            var bonusDto = new BonusDto
            {
                IsPenalty = model.IsPenalty,
                Amount = model.Amount,
                Reason = model.Reason,
                UserId = model.UserId,
            };

            try
            {
                await _bonusService.CreateBonusAsync(bonusDto);
                return RedirectToAction("Detail", "User", new {id = model.UserId});
            }
            catch (Exception ex)
            {
                ModelState.AddModelError(string.Empty, ex.Message);
                return View(model);
            }
            return View(model);
        }

        [HttpPost]
        [Authorize(Roles = "Admin")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(EditBonusViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            var bonusDto = new BonusDto
            {
                Id = model.Id,
                IsPenalty = model.IsPenalty,
                Amount = model.Amount,
                Reason = model.Reason,
                UserId = model.UserId,
            };

            try
            {
                await _bonusService.UpdateBonusAsync(bonusDto);
                return RedirectToAction("Detail", "User", new { id = model.UserId });
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
                var bonusDeleted = await _bonusService.DeleteBonusAsync(id.Value, userId);
                return RedirectToAction("Detail", "User", new { id = bonusDeleted.UserId });
            }
            catch (ArgumentNullException ex)
            {
                return NotFound();
            }
        }
    }
}
