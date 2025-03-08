using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Contexts;
using EMS.Data.Entities;
using Microsoft.EntityFrameworkCore;

namespace EMS.Data.Repositories.Implements
{
    public class AttendanceRepository : IAttendanceRepository
    {
        private readonly SqlServerContext _context;

        public AttendanceRepository(SqlServerContext context)
        {
            _context = context;
        }

        public async Task<bool> IsCheckInToday(long userId)
        {
            return await _context.Attendances
                .AnyAsync(a =>
                    a.UserId == userId &&
                    a.CheckIn.HasValue &&
                    a.CheckIn.Value.Date == DateTime.Today &&
                    a.IsDeleted == false);
        }

        public async Task<Attendance> GetTodayAttendanceByUserIdAsync(long userId)
        {
            return await _context.Attendances
                .Include(a => a.User)
                .FirstOrDefaultAsync(a =>
                    a.UserId == userId &&
                    a.CheckIn.HasValue &&
                    a.CheckIn.Value.Date == DateTime.Today &&
                    a.IsDeleted == false);
        }

        public async Task<Attendance> AddAsync(Attendance attendance)
        {
            await _context.Attendances.AddAsync(attendance);
            await _context.SaveChangesAsync();
            return attendance;
        }

        public async Task<Attendance> CheckOutUpdateAsync(Attendance attendance)
        {
            _context.Entry(attendance).CurrentValues.SetValues(attendance);

            _context.Entry(attendance).Property(a => a.CreatedAt).IsModified = false;
            _context.Entry(attendance).Property(a => a.CreatedBy).IsModified = false;
            _context.Entry(attendance).Property(a => a.DeletedAt).IsModified = false;
            _context.Entry(attendance).Property(a => a.DeletedBy).IsModified = false;
            _context.Entry(attendance).Property(a => a.IsDeleted).IsModified = false;
            await _context.SaveChangesAsync();
            return attendance;
        }

        public async Task<ICollection<Attendance>> GetAttendancesByDateAsync(DateTime selectedDate)
        {
            return await _context.Attendances
                .Include(a => a.User)
                .Where(a =>
                    a.CheckIn.HasValue &&
                    a.CheckIn.Value.Date == selectedDate.Date &&
                    a.IsDeleted == false)
                .ToListAsync();
        }

        public async Task<Attendance> GetByIdAsync(long value, params Expression<Func<Attendance, object>>[] includes)
        {
            var query = _context.Attendances.AsQueryable();
            foreach (var include in includes)
            {
                query = query.Include(include);
            }
            return await query.FirstOrDefaultAsync(a => a.Id == value && a.IsDeleted == false);
        }

        public async Task<Attendance> UpdateAsync(Attendance attendance)
        {
            var attendanceExist = await _context.Attendances.FindAsync(attendance.Id);
            if (attendanceExist == null)
            {
                return null;
            }

            _context.Entry(attendanceExist).CurrentValues.SetValues(attendance);

            _context.Entry(attendanceExist).Property(a => a.CheckInImage).IsModified = false;
            _context.Entry(attendanceExist).Property(a => a.CheckOutImage).IsModified = false;

            _context.Entry(attendanceExist).Property(a => a.CreatedAt).IsModified = false;
            _context.Entry(attendanceExist).Property(a => a.CreatedBy).IsModified = false;
            _context.Entry(attendanceExist).Property(a => a.DeletedAt).IsModified = false;
            _context.Entry(attendanceExist).Property(a => a.DeletedBy).IsModified = false;
            _context.Entry(attendanceExist).Property(a => a.IsDeleted).IsModified = false;
            await _context.SaveChangesAsync();
            return attendanceExist;
        }
    }
}
