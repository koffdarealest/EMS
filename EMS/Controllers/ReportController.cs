using EMS.Business.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace EMS.Controllers
{
    [Authorize(Roles = "Admin")]
    public class ReportController : Controller
    {
        private readonly IReportService _reportService;

        public ReportController(IReportService reportService)
        {
            _reportService = reportService;
        }
        public IActionResult Index()
        {
            return View();
        }

        public async Task<IActionResult> Generate(string reportType, string timePeriod, int? month, int? quarter,
            int? year)
        {
            if (!year.HasValue)
            {
                return BadRequest("Year is required.");
            }
            if (reportType == "employee")
            {
                var fileContents = await _reportService.GenerateEmployeeReport();
                var fileName = $"Employee_Report_{DateTime.Now:yyyyMMddHHmmss}.xlsx";
                return File(fileContents, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName);
            }
            else if (reportType == "salary")
            {
                string fileName = "";
                var fileContents = await _reportService.GenerateSalaryReport(timePeriod, month, quarter, year);
                if (timePeriod == "monthly")
                {
                    if (!month.HasValue)
                    {
                        return BadRequest("Month is required for monthly report.");
                    }
                    fileName = $"Salary_Report_{DateTime.Now:yyyyMMddHHmmss}_Month_{month}_.xlsx";
                    return File(fileContents, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName);
                }
                else if (timePeriod == "quarterly")
                {
                    if (!quarter.HasValue)
                    {
                        return BadRequest("Quarter is required for quarterly report.");
                    }
                    fileName = $"Salary_Report_{DateTime.Now:yyyyMMddHHmmss}_Quarter_{quarter}_.xlsx";
                    return File(fileContents, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName);
                }
                //var fileName = $"Salary_Report_{DateTime.Now:yyyyMMddHHmmss}.xlsx";
                //return File(fileContents, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName);
            }
            else if (reportType == "attendance")
            {
                string fileName = "";
                var fileContents = await _reportService.GenerateAttendanceReport(month, year);
                if (!month.HasValue)
                {
                    return BadRequest("Month is required for attendance report.");
                }
                fileName = $"Attendance_Report_{DateTime.Now:yyyyMMddHHmmss}_Month_{month}_.xlsx";
                return File(fileContents, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName);
            }
            return BadRequest("Invalid report type.");
        }
    }
}
