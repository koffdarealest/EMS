using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Business.Dtos;

namespace EMS.Business.Services
{
    public interface ISalaryPaymentService
    {
        Task<List<SalaryPaymentDto>> CreatePaymentsByListUserIdAsync(List<long> selectedUsers);
        Task<List<SalaryPaymentDto>> GetSalaryPaymentsByThisMonthAsync(DateTime selectedTime);
    }
}
