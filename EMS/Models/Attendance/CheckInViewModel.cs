using EMS.Business.Dtos;
using EMS.Data.Enums;

namespace EMS.Models.Attendance
{
    public class CheckInViewModel
    {
        public long? UserId { get; set; }
        public bool IsCheckedIn { get; set; }
        public DateTime? CheckIn { get; set; }
        public DateTime? CheckOut { get; set; }
        public AttendanceStatus Status { get; set; }
        public string? CheckImage { get; set; }
        public UserDto? User { get; set; }
        public double WorkedHours => CheckIn.HasValue
            ? ((CheckOut.HasValue ? CheckOut.Value : DateTime.Now) - CheckIn.Value).TotalHours
            : 0;
    }
}
