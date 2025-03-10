using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Entities;

namespace EMS.Data.Repositories
{
    public interface ILeaveBalanceRepository
    {
        Task<LeaveBalance> CreateAsync(LeaveBalance leaveBalance);
        Task<LeaveBalance> UpdateLeaveBalance(long userId, int numOfDays, string type);
    }
}
