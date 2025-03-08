using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Business.Commons;
using EMS.Data.Entities;
using EMS.Data.Enums;

namespace EMS.Business.Dtos
{
    public class AttendanceDto : BaseDto<long>
    {
        public DateTime? CheckIn { get; set; }
        public DateTime? CheckOut { get; set; }
        public AttendanceStatus Status { get; set; }
        public long UserId { get; set; }
        public string? CheckInImage { get; set; }
        public string? CheckOutImage { get; set; }
        public UserDto? User { get; set; }
        public double WorkedHours => CheckIn.HasValue
            ? ((CheckOut.HasValue ? CheckOut.Value : DateTime.Now) - CheckIn.Value).TotalHours
            : 0;
    }
}
