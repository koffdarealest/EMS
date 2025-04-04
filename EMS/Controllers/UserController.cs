﻿using System.Runtime.InteropServices.JavaScript;
using System.Security.Claims;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;
using EMS.Business.Clouds;
using EMS.Business.Dtos;
using EMS.Business.Exceptions;
using EMS.Business.Redis;
using EMS.Business.Redis.Data;
using EMS.Business.Services;
using EMS.Data.Enums;
using EMS.Data.Pagination;
using EMS.Models;
using EMS.Models.Users;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.OutputCaching;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;

namespace EMS.Controllers
{
    public class UserController : Controller
    {
        private readonly IUserService _userService;
        private readonly IDepartmentService _departmentService;
        private readonly IAzureBlobAvatarService _azureBlobAvatarService;
        private readonly IActivityLogService _activityLogService;
        private readonly IRedisService _redisService;

        public UserController(IUserService userService, IDepartmentService departmentService, IAzureBlobAvatarService azureBlobAvatarService, 
            IActivityLogService activityLogService, IRedisService redisService)
        {
            _userService = userService;
            _departmentService = departmentService;
            _azureBlobAvatarService = azureBlobAvatarService;
            _activityLogService = activityLogService;
            _redisService = redisService;
        }

        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Index(string searchTerm, int? departmentId, int? gender, DateOnly? joinDate,
            int pageIndex = 1, int pageSize = 10)
        {
            //var employees = await GetEmployeesAsync(searchTerm, departmentId, gender, joinDate, pageIndex, pageSize);
            PaginatedList<UserDto> employees = new PaginatedList<UserDto>(new List<UserDto>(), 0, pageIndex, pageSize);
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

        [HttpGet]
        public async Task<IActionResult> Search(string searchTerm, long? departmentId, int? gender, DateTime? joinedAt,
            int pageIndex = 1, int pageSize = 10)
        {
            var listUsers = await _userService.SearchUsersAsync(searchTerm, departmentId, gender, joinedAt, pageIndex, pageSize);

            return Json(new
            {
                users = listUsers,
                pageIndex = listUsers.PageIndex,
                totalPages = listUsers.TotalPages
            });
        }

        [HttpGet]
        public async Task<IActionResult> BackupUser()
        {
            var users = await _userService.GetAllUserForBackup();

            var json = JsonSerializer.Serialize(users, new JsonSerializerOptions { WriteIndented = true });
            var fileName = $"users_backup_{DateTime.Now:yyyyMMddHHmmss}.json";

            return File(Encoding.UTF8.GetBytes(json), "application/json", fileName);
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
                var createdUserDto = await _userService.CreateUserAsync(userDto, user.Username, user.Password);
                var userId = long.Parse(HttpContext.User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
                var activityLogDto = new ActivityLogDto
                {
                    UserId = userId,
                    Detail = $"Create user {createdUserDto.Id}"
                };
                await _activityLogService.CreateActivityLogAsync(activityLogDto);
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
                var editedUserDto = await _userService.UpdateUserAsync(userDto);
                var userId = long.Parse(HttpContext.User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
                var activityLogDto = new ActivityLogDto
                {
                    UserId = userId,
                    Detail = $"Edit user {editedUserDto.Id}"
                };
                await _activityLogService.CreateActivityLogAsync(activityLogDto);
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
                var activityLogDto = new ActivityLogDto
                {
                    UserId = userId,
                    Detail = $"Delete user {user.Id}"
                };
                await _activityLogService.CreateActivityLogAsync(activityLogDto);
            }
            catch (ArgumentNullException ex) 
            {
                return NotFound();
            }
            return RedirectToAction(nameof(Index));
        }

        [HttpPost("save-session")]
        public async Task<IActionResult> SaveSession([FromBody] UserSessionData sessionData)
        {
            string userId = HttpContext.User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (userId.IsNullOrEmpty())
            {
                return NoContent();
            }
            else
            {
                await _redisService.SaveSessionAsync(userId, sessionData);
                return Ok(new {message = "Session save successfully"});
            }

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
