using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using EMS.Data.Repositories;

namespace EMS.Business.Services.Implements
{
    public class LeaveBalanceService : ILeaveBalanceService
    {
        private readonly ILeaveBalanceRepository _leaveBalanceRepository;
        private readonly IMapper _mapper;

        public LeaveBalanceService(ILeaveBalanceRepository leaveBalanceRepository, IMapper mapper)
        {
            _leaveBalanceRepository = leaveBalanceRepository;
            _mapper = mapper;
        }
    }
}
