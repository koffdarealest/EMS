﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Commons;
using EMS.Data.Enums;

namespace EMS.Data.Entities
{
    public class Attendance : BaseEntity<long>
    {
        public DateTime? CheckIn { get; set; }
        public DateTime? CheckOut { get; set; }
        public AttendanceStatus Status { get; set; }
        public long UserId { get; set; }
        public string? CheckInImage { get; set; }
        public string? CheckOutImage { get; set; }
        public virtual User? User { get; set; }

        [NotMapped]
        public double WorkedHours => CheckIn.HasValue
            ? ((CheckOut.HasValue ? CheckOut.Value : DateTime.Now) - CheckIn.Value).TotalHours
            : 0;
    }
}
