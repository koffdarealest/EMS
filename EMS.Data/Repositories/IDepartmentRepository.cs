using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Entities;

namespace EMS.Data.Repositories
{
    public interface IDepartmentRepository
    {
        Task<ICollection<Department>> GetDepartmentsAsync();
        Task<Department> CreateDepartmentAsync(Department department);
        Task<bool> IsExistDepartmentName(string name);
        Task<Department> GetDepartmentByIdAsync(int id);
    }
}
