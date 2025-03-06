using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using EMS.Data.Repositories;

namespace EMS.Business.Services.Implements
{
    public class SalaryPaymentService : ISalaryPaymentService
    {
        private readonly ISalaryPaymentRepository _salaryPaymentRepository;
        private readonly IMapper _mapper;

        public SalaryPaymentService(ISalaryPaymentRepository salaryPaymentRepository, IMapper mapper)
        {
            _salaryPaymentRepository = salaryPaymentRepository;
            _mapper = mapper;
        }
    }
}
