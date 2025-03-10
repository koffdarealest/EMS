using System.Runtime.InteropServices.JavaScript;
using System.Security.Claims;
using EMS.Business.Clouds;
using EMS.Business.Dtos;
using EMS.Business.Exceptions;
using EMS.Business.Services;
using EMS.Data.Enums;
using EMS.Data.Pagination;
using EMS.Models;
using EMS.Models.Users;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.OutputCaching;

namespace EMS.Controllers
{
    public class UserController : Controller
    {
        private readonly IUserService _userService;
        private readonly IDepartmentService _departmentService;
        private readonly IAzureBlobAvatarService _azureBlobAvatarService;


        public UserController(IUserService userService, IDepartmentService departmentService, IAzureBlobAvatarService azureBlobAvatarService)
        {
            _userService = userService;
            _departmentService = departmentService;
            _azureBlobAvatarService = azureBlobAvatarService;
        }

        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Index(string searchTerm, int? departmentId, int? gender, DateOnly? joinDate,
            int pageIndex = 1, int pageSize = 10)
        {
            var employees = await GetEmployeesAsync(searchTerm, departmentId, gender, joinDate, pageIndex, pageSize);
            var departments = await GetDepartmentsAsync();
            ViewData["DepartmentNames"] = departments.ToDictionary(d => d.Id, d => d.Name);
            await LoadDepartmentsAsync();
            return View(employees);
        }

        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Create()
        {
            await LoadDepartmentsAsync();
            return View();
        }

        public async Task<IActionResult> Detail(long? id)
        {
            if (User.IsInRole("Employee"))
            {
                var userId = long.Parse(HttpContext.User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
                if (id != userId)
                {
                    return RedirectToAction("Detail", "User", new { id = userId });
                }
            }

            if (id == null)
            {
                return NotFound();
            }

            if (!User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Login", "Auth");
            }

            var user = await _userService.GetUserByIdAsync(id.Value, u => u.Department, u => u.Bonuses, u => u.Salaries, u => u.LeaveBalance);
            if (user != null)
            {
                var currentSalary = user.Salaries
                    .Where(s => s.EffectiveAt <= DateTime.Today && s.IsDeleted == false)
                    .OrderByDescending(s => s.EffectiveAt)
                    .FirstOrDefault();
                var notDeletedBonuses = user.Bonuses.Where(b => !b.IsDeleted).ToList();
                var userDetail = new UserDetailViewModel
                {
                    Id = user.Id,
                    Gender = user.Gender,
                    Fullname = user.Fullname,
                    Phone = user.Phone,
                    Birth = user.Birth,
                    Address = user.Address,
                    Duty = user.Duty,
                    DepartmentName = user.Department.Name,
                    JoinedAt = user.JoinedAt,
                    Role = user.Role,
                    Avatar = user.Avatar,
                    Bonuses = notDeletedBonuses,
                    ActiveSalary = currentSalary,
                    LeaveBalance = user.LeaveBalance,
                };
                return View(userDetail);
            }
            else
            {
                return NotFound();
            }
        }

        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Edit(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var user = await _userService.GetUserByIdAsync(id.Value);

            if (user != null)
            {
                var userEdit = new EditUserViewModel
                {
                    Id = user.Id,
                    Fullname = user.Fullname,
                    Phone = user.Phone,
                    Birth = user.Birth,
                    Address = user.Address,
                    Duty = user.Duty,
                    DepartmentId = user.DepartmentId,
                    JoinedAt = user.JoinedAt,
                    Role = user.Role,
                    Avatar = user.Avatar,
                    Gender = user.Gender
                };
                await LoadDepartmentsAsync();
                return View(userEdit);
            }
            else
            {
                return NotFound();
            }
        }


        [Authorize(Roles = "Admin")]
        [HttpPost]
        public async Task<IActionResult> Create(CreateUserViewModel user, IFormFile? avatarFile)
        {
            if (!ModelState.IsValid)
            {
                await LoadDepartmentsAsync();
                return View(user);
            }

            string? avatarUrl = null;
            if (avatarFile != null && avatarFile.Length > 0)
            {
                using var stream = avatarFile.OpenReadStream();
                string fileName = $"{Guid.NewGuid()}_{avatarFile.FileName}";
                avatarUrl = await _azureBlobAvatarService.UploadAvatarAsync(stream, fileName);
            }

            UserDto userDto = new UserDto
            {
                Fullname = user.Fullname,
                Phone = user.Phone,
                Birth = user.Birth,
                Gender = user.Gender,
                Address = user.Address,
                Duty = user.Duty,
                DepartmentId = user.DepartmentId,
                JoinedAt = user.JoinedAt,
                Avatar = avatarUrl,
                Role = user.Role
            };

            try
            {
                await _userService.CreateUserAsync(userDto, user.Username, user.Password);
                return RedirectToAction(nameof(Index));
            }
            catch (UsernameAlreadyExistException e)
            {
                ModelState.AddModelError("usernameError", e.Message);
                await LoadDepartmentsAsync();
                return View(user);
            }
            catch (Exception e)
            {
                ModelState.AddModelError(string.Empty, e.Message);
                await LoadDepartmentsAsync();
                return View(user);
            }
        }

        [Authorize(Roles = "Admin")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(long id, EditUserViewModel user, IFormFile? avatarFile)
        {
            if (!ModelState.IsValid)
            {
                await LoadDepartmentsAsync();
                return View(user);
            }

            UserDto userDto = new UserDto
            {
                Id = id,
                Fullname = user.Fullname,
                Phone = user.Phone,
                Birth = user.Birth,
                Address = user.Address,
                Duty = user.Duty,
                DepartmentId = user.DepartmentId,
                JoinedAt = user.JoinedAt,
                Role = user.Role,
                Gender = user.Gender,
                Avatar = user.Avatar
            };

            string? avatarUrl = null;
            if (avatarFile != null && avatarFile.Length > 0)
            {
                using var stream = avatarFile.OpenReadStream();
                string fileName = $"{Guid.NewGuid()}_{avatarFile.FileName}";
                avatarUrl = await _azureBlobAvatarService.UploadAvatarAsync(stream, fileName);
                userDto.Avatar = avatarUrl;
            }

            try
            {
                await _userService.UpdateUserAsync(userDto);
                return RedirectToAction("Detail", new { id = id });
            }
            catch (Exception e)
            {
                ModelState.AddModelError(string.Empty, e.Message);
                await LoadDepartmentsAsync();
                return View(user);
            }   

        }

        [Authorize(Roles = "Admin")]
        [HttpPost]
        public async Task<IActionResult> Delete(long? id)
        {
            var userId = long.Parse(HttpContext.User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
            if (id == null)
            {
                return NotFound();
            }
            try
            {
                var user = await _userService.DeleteUserByIdAsync(id, userId);
            }
            catch (ArgumentNullException ex) 
            {
                return NotFound();
            }
            return RedirectToAction(nameof(Index));
        }

        private async Task<PaginatedList<UserDto>> GetEmployeesAsync(string searchTerm, int? departmentId, int? gender,
            DateOnly? joinDate, int pageIndex, int pageSize)
        {
            return await _userService.GetPaginatedUsersAsync(searchTerm, departmentId, gender, joinDate, pageIndex,
                pageSize);
        }

        private async Task<ICollection<DepartmentDto>> GetDepartmentsAsync()
        {
            return await _departmentService.GetDepartmentsAsync();
        }

        private async Task<ICollection<DepartmentDto>> LoadDepartmentsAsync()
        {
            var departments = await GetDepartmentsAsync();
            if (departments == null)
            {
                ViewData["Departments"] = new SelectList(Enumerable.Empty<object>(), "Id", "Name");
            }
            else
            {
                ViewData["Departments"] = new SelectList(departments, "Id", "Name");
            }
            return departments;
        }
    }
}
