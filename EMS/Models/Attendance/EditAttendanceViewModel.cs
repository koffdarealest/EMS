using EMS.Data.Enums;

namespace EMS.Models.Attendance
{
    public class EditAttendanceViewModel
    {
        public long Id { get; set; }
        public DateTime? CheckIn { get; set; }
        public DateTime? CheckOut { get; set; }
        public AttendanceStatus Status { get; set; }
        public long UserId { get; set; }
        public string? Fullname { get; set; }
    }
}
