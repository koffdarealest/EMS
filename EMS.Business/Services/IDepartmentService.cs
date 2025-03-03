using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Business.Dtos;

namespace EMS.Business.Services
{
    public interface IDepartmentService
    {
        Task<DepartmentDto> CreateDepartmentAsync(DepartmentDto department);
        Task<ICollection<DepartmentDto>> GetDepartmentsAsync();
        Task<DepartmentDto> GetDepartmentByIdAsync(int id);
    }
}
