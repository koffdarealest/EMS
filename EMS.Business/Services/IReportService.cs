using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EMS.Business.Services
{
    public interface IReportService
    {
        Task<byte[]> GenerateAttendanceReport(int? month, int? year);
        Task<byte[]> GenerateEmployeeReport();
        Task<byte[]> GenerateSalaryReport(string timePeriod, int? month, int? quarter, int? year);
    }
}
