using EMS.Data.Contexts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Entities;
using System.Linq.Expressions;
using Microsoft.EntityFrameworkCore;

namespace EMS.Data.Repositories.Implements
{
    public class LeaveRequestRepository : ILeaveRequestRepository
    {
        private readonly SqlServerContext _context;

        public LeaveRequestRepository(SqlServerContext context)
        {
            _context = context;
        }

        public async Task<LeaveRequest> CreateAsync(LeaveRequest leaveRequest)
        {
            _context.LeaveRequests.Add(leaveRequest);
            await _context.SaveChangesAsync();
            return leaveRequest;
        }

        public async Task<ICollection<LeaveRequest>> GetLeaveRequestsAsync(params Expression<Func<LeaveRequest, object>>[] includes)
        {
            IQueryable<LeaveRequest> query = _context.LeaveRequests
                .Where(l => l.IsDeleted == false);

            foreach (var include in includes)
            {
                query = query.Include(include);
            }

            return await query.ToListAsync();
        }

        public async Task<ICollection<LeaveRequest>> GetLeaveRequestsByUserIdAsync(long userId, params Expression<Func<LeaveRequest, object>>[] includes)
        {
            IQueryable<LeaveRequest> query = _context.LeaveRequests
                .Where(l => l.UserId == userId && l.IsDeleted == false);

            foreach (var include in includes)
            {
                query = query.Include(include);
            }

            return await query.ToListAsync();
        }

        public async Task<LeaveRequest> GetByIdAsync(long? id)
        {
            return await _context.LeaveRequests
                .Where(l => l.Id == id && l.IsDeleted == false)
                .FirstOrDefaultAsync();
        }

        public async Task<LeaveRequest> UpdateAsync(LeaveRequest leaveRequest)
        {
            _context.LeaveRequests.Update(leaveRequest);
            await _context.SaveChangesAsync();
            return leaveRequest;
        }
    }
}
