using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Entities;
using EMS.Data.Repositories;
using OfficeOpenXml;
using OfficeOpenXml.Style;

namespace EMS.Business.Services.Implements
{
    public class ReportService : IReportService
    {
        private readonly IUserRepository _userRepository;
        private readonly ISalaryPaymentRepository _salaryPaymentRepository;
        private readonly IAttendanceRepository _attendanceRepository;

        public ReportService(IUserRepository userRepository, IAttendanceRepository attendanceRepository,
            ISalaryPaymentRepository salaryPaymentRepository)
        {
            _userRepository = userRepository;
            _attendanceRepository = attendanceRepository;
            _salaryPaymentRepository = salaryPaymentRepository;
        }

        public async Task<byte[]> GenerateEmployeeReport()
        {
            var employees = await _userRepository.GetEmployeesAsync(u => u.Department);

            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
            using (var package = new ExcelPackage())
            {
                var worksheet = package.Workbook.Worksheets.Add("EMS_Employees");
                worksheet.Cells[2, 2].Value = "DEPARTMENT";
                worksheet.Cells[2, 3].Value = "DUTY";
                worksheet.Cells[2, 4].Value = "GENDER";
                worksheet.Cells[2, 5].Value = "NUM OF EMP";
                using (var range = worksheet.Cells[2, 2, 2, 5])
                {
                    range.Style.Font.Bold = true;
                    range.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    range.Style.Fill.BackgroundColor.SetColor(Color.LightGray);
                }

                var groupedData = employees
                    .GroupBy(e => new { e.Department, e.Duty, e.Gender })
                    .Select(g => new
                    {
                        g.Key.Department,
                        g.Key.Duty,
                        g.Key.Gender,
                        Count = g.Count()
                    })
                    .ToList();
                int row = 3;
                foreach (var e in groupedData)
                {
                    worksheet.Cells[row, 2].Value = e.Department.Name;
                    worksheet.Cells[row, 3].Value = e.Duty;
                    worksheet.Cells[row, 4].Value = e.Gender;
                    worksheet.Cells[row, 5].Value = e.Count;
                    row++;
                }
                worksheet.Cells["B:Z"].AutoFitColumns();
                return package.GetAsByteArray();
            }
        }

        public async Task<byte[]> GenerateSalaryReport(string timePeriod, int? month, int? quarter, int? year)
        {
            var salaryPayments = await _salaryPaymentRepository.GetAllAsync();
            var salaryData = new List<SalaryPayment>();
            if (timePeriod.Equals("monthly") && month.HasValue)
            {
                salaryData = salaryPayments
                    .Where(s => s.PaidAt.Value.Month == month.Value && s.PaidAt.Value.Year == year.Value).ToList();
            }
            else if (timePeriod.Equals("quarterly") && quarter.HasValue)
            {
                var quarterMonths = quarter switch
                {
                    1 => new[] { 1, 2, 3 },
                    2 => new[] { 4, 5, 6 },
                    3 => new[] { 7, 8, 9 },
                    4 => new[] { 10, 11, 12 },
                    _ => Array.Empty<int>()
                };

                salaryData = salaryPayments
                    .Where(s => quarterMonths.Contains(s.PaidAt.Value.Month) && s.PaidAt.Value.Year == year.Value).ToList();
            }

            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
            using (var package = new ExcelPackage())
            {
                ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("EMS_Salaries");
                //var worksheet = package.Workbook.Worksheets.Add("EMS_Salaries");
                worksheet.Cells["B2"].Value = "Salary Report";
                worksheet.Cells["B2:H2"].Merge = true;
                worksheet.Cells["B2"].Style.Font.Size = 16;
                worksheet.Cells["B2"].Style.Font.Bold = true;
                worksheet.Cells["B2"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

                worksheet.Cells[3, 2].Value = "ID";
                worksheet.Cells[3, 3].Value = "Employee";
                worksheet.Cells[3, 4].Value = "Paid At";
                worksheet.Cells[3, 5].Value = "Total Salary";
                worksheet.Cells[3, 6].Value = "Total Bonus";
                worksheet.Cells[3, 7].Value = "Total Penalty";
                worksheet.Cells[3, 8].Value = "Total Paid";

                using (var range = worksheet.Cells[3, 2, 3, 8])
                {
                    range.Style.Font.Bold = true;
                    range.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    range.Style.Fill.BackgroundColor.SetColor(Color.LightGray);
                }
                
                int row = 4;
                foreach (var s in salaryData)
                {
                    worksheet.Cells[row, 2].Value = s.Id;
                    worksheet.Cells[row, 3].Value = s.User.Fullname;
                    worksheet.Cells[row, 4].Value = s.PaidAt.Value.ToString("dd/MM/yyyy");
                    worksheet.Cells[row, 5].Value = s.TotalSalary;
                    worksheet.Cells[row, 6].Value = s.TotalBonus;
                    worksheet.Cells[row, 7].Value = s.TotalPenalty;
                    worksheet.Cells[row, 8].Value = s.TotalPaid;
                    row++;
                }
                worksheet.Cells["B:Z"].AutoFitColumns();
                return package.GetAsByteArray();
            }
        }

        public async Task<byte[]> GenerateAttendanceReport(int? month, int? year)
        {
            var attendances = await _attendanceRepository.GetAllAsync();
            var attendanceData = new List<Attendance>();
            if (month.HasValue && year.HasValue)
            {
                attendanceData = attendances
                    .Where(a => a.CheckOut.Value.Month == month.Value && a.CheckOut.Value.Year == year.Value).ToList();
            }

            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
            using (var package = new ExcelPackage())
            {
                ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("EMS_Attendances");
                worksheet.Cells["B2"].Value = "Attendance Report";
                worksheet.Cells["B2:F2"].Merge = true;
                worksheet.Cells["B2"].Style.Font.Size = 16;
                worksheet.Cells["B2"].Style.Font.Bold = true;
                worksheet.Cells["B2"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

                worksheet.Cells[3, 2].Value = "ID";
                worksheet.Cells[3, 3].Value = "Employee";
                worksheet.Cells[3, 4].Value = "Check In";
                worksheet.Cells[3, 5].Value = "Check Out";
                worksheet.Cells[3, 6].Value = "Status";

                using (var range = worksheet.Cells[3, 2, 3, 6])
                {
                    range.Style.Font.Bold = true;
                    range.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    range.Style.Fill.BackgroundColor.SetColor(Color.LightGray);
                }

                int row = 4;
                foreach (var a in attendanceData)
                {
                    worksheet.Cells[row, 2].Value = a.Id;
                    worksheet.Cells[row, 3].Value = a.User.Fullname;
                    worksheet.Cells[row, 4].Value = a.CheckIn.Value.ToString("dd/MM/yyyy HH:mm");
                    worksheet.Cells[row, 5].Value = a.CheckOut.Value.ToString("dd/MM/yyyy HH:mm");
                    worksheet.Cells[row, 6].Value = a.Status;
                    row++;
                }
                worksheet.Cells["B:Z"].AutoFitColumns();
                return package.GetAsByteArray();
            }
        }
    }
}
