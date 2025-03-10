using EMS.Data.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace EMS.Data.Repositories
{
    public interface ILeaveRequestRepository
    {
        Task<LeaveRequest> CreateAsync(LeaveRequest leaveRequest);
        Task<ICollection<LeaveRequest>> GetLeaveRequestsAsync(params Expression<Func<LeaveRequest, object>>[] includes);
        Task<ICollection<LeaveRequest>> GetLeaveRequestsByUserIdAsync(long userId, params Expression<Func<LeaveRequest, object>>[] includes);
        Task<LeaveRequest> GetByIdAsync(long? id);
        Task<LeaveRequest> UpdateAsync(LeaveRequest leaveRequest);
    }
}
