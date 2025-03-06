using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using EMS.Business.Dtos;
using EMS.Data.Entities;

namespace EMS.Business.Services
{
    public interface ISalaryService
    {
        Task<SalaryDto> CreateSalaryAsync(SalaryDto salaryDto);
        Task<SalaryDto> DeleteSalaryAsync(long value, long? deletedBy);
        Task<ICollection<SalaryDto>> GetSalariesAsync();
        Task<SalaryDto> GetSalaryByIdAsync(long id, params Expression<Func<Salary, object>>[] includes);
        Task<SalaryDto> UpdateSalaryAsync(SalaryDto salaryDto);
    }
}
