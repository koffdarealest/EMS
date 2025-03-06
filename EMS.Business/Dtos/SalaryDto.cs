using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Business.Commons;
using EMS.Data.Entities;

namespace EMS.Business.Dtos
{
    public class SalaryDto : BaseDto<long>
    {
        public decimal Basic { get; set; }
        public decimal Allowance { get; set; }
        public DateTime EffectiveAt { get; set; }
        public long UserId { get; set; }
        public UserDto? User { get; set; }
    }
}
