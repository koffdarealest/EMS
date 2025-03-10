using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Commons;
using EMS.Data.Enums;

namespace EMS.Data.Entities
{
    public class LeaveRequest : BaseEntity<long>
    {
        public LeaveType Type { get; set; }
        public string? Reason { get; set; }
        public DateTime From
        {
            get => _from;
            set
            {
                _from = value;
                UpdateTotalDays();
            }
        }
        public DateTime To
        {
            get => _to;
            set
            {
                _to = value;
                UpdateTotalDays();
            }
        }

        public int TotalDays { get; private set; }
        public LeaveRequestStatus Status { get; set; }
        public long? ApprovedBy { get; set; }
        public long UserId { get; set; }

        public virtual User? User { get; set; }

        private DateTime _from;
        private DateTime _to;

        public void UpdateTotalDays()
        {
            TotalDays = (int)(To - From).TotalDays + 1;
        }
    }
}
