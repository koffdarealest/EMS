using EMS.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using EMS.Business.Dtos;
using EMS.Business.Services;
using EMS.Data.Enums;

namespace EMS.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly IUserAuthService _userService;

        public HomeController(ILogger<HomeController> logger, IUserAuthService userService)
        {
            _logger = logger;
            _userService = userService;
        }

        public IActionResult Index()
        {
            return View();
        }

        public async Task<IActionResult> Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }


    }
}
