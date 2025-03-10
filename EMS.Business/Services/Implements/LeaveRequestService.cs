using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using EMS.Business.Dtos;
using EMS.Data.Entities;
using EMS.Data.Enums;
using EMS.Data.Repositories;

namespace EMS.Business.Services.Implements
{
    public class LeaveRequestService : ILeaveRequestService
    {
        private readonly ILeaveRequestRepository _leaveRequestRepository;
        private readonly IMapper _mapper;
        private readonly ILeaveBalanceRepository _leaveBalanceRepository;

        public LeaveRequestService(ILeaveRequestRepository leaveRequestRepository, IMapper mapper, ILeaveBalanceRepository leaveBalanceRepository)
        {
            _leaveRequestRepository = leaveRequestRepository;
            _mapper = mapper;
            _leaveBalanceRepository = leaveBalanceRepository;
        }

        public async Task<LeaveRequestDto> CreateLeaveRequestAsync(LeaveRequestDto dto)
        {
            return _mapper.Map<LeaveRequestDto>(await _leaveRequestRepository.CreateAsync(_mapper.Map<LeaveRequest>(dto)));
        }

        public async Task<ICollection<LeaveRequestDto>> GetLeaveRequestsAsync(params Expression<Func<LeaveRequest, object>>[] includes)
        {
            return _mapper.Map<ICollection<LeaveRequestDto>>(await _leaveRequestRepository.GetLeaveRequestsAsync(includes));
        }

        public async Task<ICollection<LeaveRequestDto>> GetLeaveRequestsByUserIdAsync(long userId, params Expression<Func<LeaveRequest, object>>[] includes)
        {
            return _mapper.Map<ICollection<LeaveRequestDto>>(await _leaveRequestRepository.GetLeaveRequestsByUserIdAsync(userId, includes));
        }

        public async Task<LeaveRequestDto> ApproveRequestByIdAsync(long id, bool isApprove, int numOfDays, string type)
        {
            var leaveRequest = await _leaveRequestRepository.GetByIdAsync(id);
            leaveRequest.Status = isApprove ? LeaveRequestStatus.Approved : LeaveRequestStatus.Rejected;
            if (isApprove)
            {
                var leaveBalance = await _leaveBalanceRepository.UpdateLeaveBalance(leaveRequest.UserId, numOfDays, type);
            }
            return _mapper.Map<LeaveRequestDto>(await _leaveRequestRepository.UpdateAsync(leaveRequest));
        }
    }
}
