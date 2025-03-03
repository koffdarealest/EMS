using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using EMS.Business.Dtos;
using EMS.Data.Repositories;

namespace EMS.Business.Services.Implements
{
    public class DepartmentService : IDepartmentService
    {
        private readonly IDepartmentRepository _departmentRepository;
        private readonly IMapper _mapper;

        public DepartmentService(IDepartmentRepository departmentRepository, IMapper mapper)
        {
            _departmentRepository = departmentRepository;
            _mapper = mapper;    
        }

        public async Task<ICollection<DepartmentDto>> GetDepartmentsAsync()
        {
            return _mapper.Map<ICollection<DepartmentDto>>(await _departmentRepository.GetDepartmentsAsync());
        }
    }
}
