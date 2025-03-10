using EMS.Business.Dtos;
using EMS.Data.Enums;

namespace EMS.Models.Users
{
    public class UserDetailViewModel
    {
        public long Id { get; set; }
        public string? Avatar { get; set; }
        public string Fullname { get; set; } = string.Empty;
        public DateOnly Birth { get; set; }
        public Gender Gender { get; set; }
        public string Phone { get; set; } = string.Empty;
        public string? Address { get; set; }
        public Duty Duty { get; set; }
        public string DepartmentName { get; set; } = "N/A";
        public DateOnly JoinedAt { get; set; }
        public Role Role { get; set; }
        public ICollection<BonusDto> Bonuses { get; set; } = new List<BonusDto>();
        public SalaryDto? ActiveSalary { get; set; }
        public ICollection<LeaveRequestDto> LeaveRequests { get; set; } = new List<LeaveRequestDto>();
        public LeaveBalanceDto? LeaveBalance { get; set; }
    }
}
