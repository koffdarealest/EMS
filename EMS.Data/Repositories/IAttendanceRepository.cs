using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Entities;

namespace EMS.Data.Repositories
{
    public interface IAttendanceRepository
    {
        Task<bool> IsCheckInToday(long userId);
        Task<Attendance> GetTodayAttendanceByUserIdAsync(long userId);
        Task<Attendance> AddAsync(Attendance attendance);
        Task<Attendance> CheckOutUpdateAsync(Attendance attendance);
        Task<ICollection<Attendance>> GetAttendancesByDateAsync(DateTime selectedDate);
        Task<Attendance> GetByIdAsync(long value, Expression<Func<Attendance, object>>[] includes);
        Task<Attendance> UpdateAsync(Attendance attendance);
    }
}
