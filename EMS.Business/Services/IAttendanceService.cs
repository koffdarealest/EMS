using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using EMS.Business.Dtos;
using EMS.Data.Entities;

namespace EMS.Business.Services
{
    public interface IAttendanceService
    {
        Task<AttendanceDto> CheckInAsync(long userId, string imageUrl);
        Task<AttendanceDto> CheckOutAsync(long userId, string imageUrl);
        Task<AttendanceDto> GetTodayAttendanceByUserIdAsync(long userId);
        Task<bool> IsCheckInToday(long? userId);
        Task<ICollection<AttendanceDto>> GetAttendancesByDateAsync(DateTime selectedDate);
        Task<AttendanceDto> GetAttendanceByIdAsync(long value, params Expression<Func<Attendance, object>>[] includes);
        Task<AttendanceDto> UpdateAttendanceAsync(AttendanceDto attendanceDto);
    }
}
