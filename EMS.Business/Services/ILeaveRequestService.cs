using EMS.Business.Dtos;
using EMS.Data.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace EMS.Business.Services
{
    public interface ILeaveRequestService
    {
        Task<LeaveRequestDto> CreateLeaveRequestAsync(LeaveRequestDto dto);
        Task<ICollection<LeaveRequestDto>> GetLeaveRequestsAsync(params Expression<Func<LeaveRequest, object>>[] includes);
        Task<ICollection<LeaveRequestDto>> GetLeaveRequestsByUserIdAsync(long userId, params Expression<Func<LeaveRequest, object>>[] includes);
        Task<LeaveRequestDto> ApproveRequestByIdAsync(long id, bool isApprove, int numOfDays, string type);
    }
}
