using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using EMS.Business.Dtos;
using EMS.Business.Exceptions;
using EMS.Data.Entities;
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

        public async Task<DepartmentDto> CreateDepartmentAsync(DepartmentDto department)
        {
            if (await _departmentRepository.IsExistDepartmentName(department.Name))
            {
                throw new DepartmentNameAlreadyExistException();
            }
            var departmentEntity = _mapper.Map<Department>(department);
            departmentEntity = await _departmentRepository.CreateDepartmentAsync(departmentEntity);
            return _mapper.Map<DepartmentDto>(departmentEntity);
        }

        public async Task<DepartmentDto> GetDepartmentByIdAsync(int id)
        {
            var department = await _departmentRepository.GetDepartmentByIdAsync(id);
            return _mapper.Map<DepartmentDto>(department);
        }
    }
}
