
using EMS.Business.Commons;
using EMS.Data.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EMS.Business.Dtos
{
    public class LeaveBalanceDto : BaseDto<long>
    {
        public int Year { get; set; }
        public int RemainingDay { get; set; }
        public int RemainingSickDay { get; set; }
        public long UserId { get; set; }
        public UserDto? User { get; set; }
    }
}
