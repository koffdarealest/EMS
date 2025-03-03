using EMS.Business.Dtos;
using EMS.Business.Exceptions;
using EMS.Business.Services;
using EMS.Models.Departments;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace EMS.Controllers
{
    public class DepartmentController : Controller
    {
        private readonly IDepartmentService _departmentService;
        private readonly IUserService _userService;

        public DepartmentController(IDepartmentService departmentService, IUserService userService)
        {
            _departmentService = departmentService;
            _userService = userService;
        }

        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Index()
        {
            IEnumerable<DepartmentDto> departments = await _departmentService.GetDepartmentsAsync();
            return View(departments);
        }

        public IActionResult Create()
        {
            return View();
        }

        public async Task<IActionResult> Detail(int? id)
        {
            if (id == null)
                return NotFound();

            DepartmentDto department = await _departmentService.GetDepartmentByIdAsync(id.Value);
            if (department == null)
                return NotFound();

            return View(department);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Create(CreateDepartmentViewModel model)
        {
            if (ModelState.IsValid)
            {
                DepartmentDto department = new DepartmentDto
                {
                    Name = model.Name
                };

                try
                {
                    await _departmentService.CreateDepartmentAsync(department);
                    return RedirectToAction("Index");
                }
                catch (DepartmentNameAlreadyExistException ex)
                {
                    ModelState.AddModelError("Name", ex.Message);
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError(string.Empty, ex.Message);
                }
            }
            return View(model);
        }
    }
}
