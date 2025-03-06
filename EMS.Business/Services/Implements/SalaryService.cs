using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using EMS.Business.Dtos;
using EMS.Data.Entities;
using EMS.Data.Repositories;

namespace EMS.Business.Services.Implements
{
    public class SalaryService : ISalaryService
    {
        private readonly ISalaryRepository _salaryRepository;
        private readonly IMapper _mapper;

        public SalaryService(ISalaryRepository salaryRepository, IMapper mapper)
        {
            _salaryRepository = salaryRepository;
            _mapper = mapper;
        }

        public async Task<ICollection<SalaryDto>> GetSalariesAsync()
        {
            var salaries = await _salaryRepository.GetSalariesAsync();
            return _mapper.Map<ICollection<SalaryDto>>(salaries);
        }

        public async Task<SalaryDto> CreateSalaryAsync(SalaryDto salaryDto)
        {
            var salary = _mapper.Map<Salary>(salaryDto);
            var createdSalary = await _salaryRepository.CreateSalaryAsync(salary);
            return _mapper.Map<SalaryDto>(createdSalary);
        }

        public async Task<SalaryDto> GetSalaryByIdAsync(long id, params Expression<Func<Salary, object>>[] includes)
        {
            var salary = await _salaryRepository.GetSalaryByIdAsync(id, includes);
            return _mapper.Map<SalaryDto>(salary);
        }

        public async Task<SalaryDto> UpdateSalaryAsync(SalaryDto salaryDto)
        {
            var salary = _mapper.Map<Salary>(salaryDto);
            var updatedSalary = await _salaryRepository.UpdateSalaryAsync(salary);
            return _mapper.Map<SalaryDto>(updatedSalary);
        }

        public async Task<SalaryDto> DeleteSalaryAsync(long value, long? deletedBy)
        {
            if (!deletedBy.HasValue)
            {
                throw new ArgumentNullException(nameof(deletedBy));
            }
            var salary = await _salaryRepository.DeleteSalaryAsync(value, deletedBy);
            return _mapper.Map<SalaryDto>(salary);
        }
    }
}
