using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Commons;
using EMS.Data.Enums;

namespace EMS.Data.Entities
{
    public class User : BaseEntity<long>
    {
        public Role Role { get; set; }
        public required string Fullname { get; set; }
        public DateOnly Birth { get; set; }
        public Gender Gender { get; set; }
        public string? Address { get; set; }
        public required string Phone { get; set; }
        public Duty Duty { get; set; }
        public DateOnly JoinedAt { get; set; }
        public string? Avatar { get; set; } 
        public long? DepartmentId { get; set; }

        public virtual Department? Department { get; set; }

        public virtual ICollection<Attendance> Attendances { get; set; } = new List<Attendance>();
        public virtual ICollection<LeaveBalance> LeaveBalances { get; set; } = new List<LeaveBalance>();
        public virtual ICollection<LeaveRequest> LeaveRequests { get; set; } = new List<LeaveRequest>();
        public virtual ICollection<Bonus> Bonuses { get; set; } = new List<Bonus>();
        public virtual ICollection<Salary> Salaries { get; set; } = new List<Salary>();
        public virtual ICollection<SalaryPayment> SalaryPayments { get; set; } = new List<SalaryPayment>();
        public virtual ICollection<ActivityLog> ActivityLogs { get; set; } = new List<ActivityLog>();
        public virtual ICollection<NotificationRecipient> NotificationRecipients { get; set; } = new List<NotificationRecipient>();
        public virtual ICollection<Notification> Notifications { get; set; } = new List<Notification>();
    }
}
