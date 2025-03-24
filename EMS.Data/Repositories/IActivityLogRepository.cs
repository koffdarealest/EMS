using EMS.Data.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EMS.Data.Repositories
{
    public interface IActivityLogRepository
    {
        Task<ActivityLog> AddAsync(ActivityLog activityLog);
        Task<ICollection<ActivityLog>> GetAllByIdAsync(long userId);
    }
}
