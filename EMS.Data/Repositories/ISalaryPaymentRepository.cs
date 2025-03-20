using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Entities;

namespace EMS.Data.Repositories
{
    public interface ISalaryPaymentRepository
    {
        Task<List<SalaryPayment>> CreateAsync(List<SalaryPayment> salaryPayments);
        Task<List<SalaryPayment>> GetSalaryPaymentsByThisMonth(DateTime selectedTime);
        Task<SalaryPayment> UpdateAsync(long id, string status);
        Task<ICollection<SalaryPayment>> GetAllAsync();
    }
}
