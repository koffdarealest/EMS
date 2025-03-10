using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using EMS.Business.Dtos;
using EMS.Data.Entities;
using EMS.Data.Enums;
using EMS.Data.Repositories;

namespace EMS.Business.Services.Implements
{
    public class AttendanceService : IAttendanceService
    {
        private readonly IAttendanceRepository _attendanceRepository;
        private readonly IMapper _mapper;

        public AttendanceService(IAttendanceRepository attendanceRepository, IMapper mapper)
        {
            _attendanceRepository = attendanceRepository;
            _mapper = mapper;
        }

        public async Task<bool> IsCheckInToday(long? userId)
        {
            if (!userId.HasValue)
            {
                throw new ArgumentNullException(nameof(userId));
            }
            return await _attendanceRepository.IsCheckInToday(userId.Value);
        }

        public async Task<AttendanceDto> GetTodayAttendanceByUserIdAsync(long userId)
        {
            return _mapper.Map<AttendanceDto>(await _attendanceRepository.GetTodayAttendanceByUserIdAsync(userId));
        }

        public async Task<AttendanceDto> CheckInAsync(long userId, string imageUrl)
        {
            var attendance = new AttendanceDto()
            {
                UserId = userId,
                CheckIn = DateTime.Now,
                CheckInImage = imageUrl,
                Status = AttendanceStatus.Working
            };
            return _mapper.Map<AttendanceDto>(await _attendanceRepository.AddAsync(_mapper.Map<Attendance>(attendance)));
        }

        public async Task<AttendanceDto> CheckOutAsync(long userId, string imageUrl)
        {
            var attendance = await _attendanceRepository.GetTodayAttendanceByUserIdAsync(userId);
            if (attendance == null)
            {
                throw new ArgumentNullException(nameof(attendance));
            }
            attendance.CheckOut = DateTime.Now;
            attendance.CheckOutImage = imageUrl;
            attendance.Status = AttendanceStatus.Present;
            return _mapper.Map<AttendanceDto>(await _attendanceRepository.CheckOutUpdateAsync(attendance));
        }

        public async Task<ICollection<AttendanceDto>> GetAttendancesByDateAsync(DateTime selectedDate)
        {
            return _mapper.Map<ICollection<AttendanceDto>>(await _attendanceRepository.GetAttendancesByDateAsync(selectedDate));
        }

        public async Task<AttendanceDto> GetAttendanceByIdAsync(long value, params Expression<Func<Attendance, object>>[] includes)
        {
            return _mapper.Map<AttendanceDto>(await _attendanceRepository.GetByIdAsync(value, includes));
        }

        public async Task<AttendanceDto> UpdateAttendanceAsync(AttendanceDto attendanceDto)
        {
            if (attendanceDto.CheckOut < attendanceDto.CheckIn)
            {
                throw new ArgumentException("Check out time must be greater than check in time");
            }
            return _mapper.Map<AttendanceDto>(await _attendanceRepository.UpdateAsync(_mapper.Map<Attendance>(attendanceDto)));
        }
    }
}
