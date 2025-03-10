using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Contexts;
using EMS.Data.Entities;
using Microsoft.EntityFrameworkCore;

namespace EMS.Data.Repositories.Implements
{
    public class LeaveBalanceRepository : ILeaveBalanceRepository
    {
        private readonly SqlServerContext _context;

        public LeaveBalanceRepository(SqlServerContext context)
        {
            _context = context;
        }

        public async Task<LeaveBalance> CreateAsync(LeaveBalance leaveBalance)
        {
            _context.LeaveBalances.Add(leaveBalance);
            await _context.SaveChangesAsync();
            return leaveBalance;
        }

        public async Task<LeaveBalance> UpdateLeaveBalance(long userId, int numOfDays, string type)
        {
            var leaveBalance = await _context.LeaveBalances
                .Where(l => l.UserId == userId && l.IsDeleted == false && l.Year == DateTime.Now.Year)
                .FirstOrDefaultAsync();

            if (leaveBalance == null)
            {
                return null;
            }

            switch (type)
            {
                case "Annual":
                    leaveBalance.RemainingDay -= numOfDays;
                    break;
                case "Sick":
                    leaveBalance.RemainingSickDay -= numOfDays;
                    break;
                default:
                    break;
            }

            _context.LeaveBalances.Update(leaveBalance);
            await _context.SaveChangesAsync();
            return leaveBalance;
        }
    }
}
