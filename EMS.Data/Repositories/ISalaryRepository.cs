using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Entities;

namespace EMS.Data.Repositories
{
    public interface ISalaryRepository
    {
        Task<ICollection<Salary>> GetSalariesAsync();
        Task<Salary> CreateSalaryAsync(Salary salary);
        Task<Salary> GetSalaryByIdAsync(long id, Expression<Func<Salary, object>>[] includes);
        Task<Salary> UpdateSalaryAsync(Salary salary);
        Task<Salary> DeleteSalaryAsync(long value, long? deletedBy);
        Task<List<Salary>> GetSalariesByListUserId(List<long> selectedUsers);
    }
}
