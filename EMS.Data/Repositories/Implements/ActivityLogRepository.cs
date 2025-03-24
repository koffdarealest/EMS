using EMS.Data.Contexts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Entities;
using Microsoft.EntityFrameworkCore;

namespace EMS.Data.Repositories.Implements
{
    public class ActivityLogRepository : IActivityLogRepository
    {
        private readonly SqlServerContext _context;

        public ActivityLogRepository(SqlServerContext context)
        {
            _context = context;
        }

        public async Task<ActivityLog> AddAsync(ActivityLog activityLog)
        {
            var result = await _context.ActivityLogs.AddAsync(activityLog);
            await _context.SaveChangesAsync();
            return result.Entity;
        }

        public async Task<ICollection<ActivityLog>> GetAllByIdAsync(long userId)
        {
            return await _context.ActivityLogs
                .Where(x => x.UserId == userId)
                .ToListAsync();
        }
    }
}
