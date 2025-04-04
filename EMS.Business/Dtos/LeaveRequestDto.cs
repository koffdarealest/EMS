﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Business.Commons;
using EMS.Data.Entities;
using EMS.Data.Enums;

namespace EMS.Business.Dtos
{
    public class LeaveRequestDto : BaseDto<long>
    {
        public LeaveType Type { get; set; }
        public string? Reason { get; set; }
        public DateTime From { get; set; }
        public DateTime To { get; set; }
        public int TotalDays { get; set; }
        public LeaveRequestStatus Status { get; set; }
        public long? ApprovedBy { get; set; }
        public long UserId { get; set; }

        public UserDto? User { get; set; }
    }
}
