using EMS.Data.Enums;

namespace EMS.Models.Leaves
{
    public class CreateLeaveRequestViewModel
    {
        public string? Fullname { get; set; }
        public LeaveType Type { get; set; }
        public string? Reason { get; set; }
        public DateTime From { get; set; }
        public DateTime To { get; set; }
    }
}
