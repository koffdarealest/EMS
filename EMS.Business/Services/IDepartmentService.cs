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
        Task<ICollection<DepartmentDto>> GetDepartmentsAsync();
    }
}
