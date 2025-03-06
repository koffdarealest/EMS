using Microsoft.AspNetCore.Mvc;

namespace EMS.Controllers
{
    [Route("Payment")]
    public class SalaryPaymentController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
