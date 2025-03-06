using EMS.Data.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Business.Commons;

namespace EMS.Business.Dtos
{
    public class BonusDto : BaseDto<long>
    {
        public bool IsPenalty { get; set; }
        public decimal Amount { get; set; }
        public string? Reason { get; set; }
        public long UserId { get; set; }

        public UserDto? User { get; set; }
    }
}
