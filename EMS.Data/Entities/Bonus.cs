using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Commons;

namespace EMS.Data.Entities
{
    public class Bonus : BaseEntity<long>
    {
        public bool IsPenalty { get; set; }
        public decimal Amount { get; set; }
        public string? Reason { get; set; }
        public long UserId { get; set; }

        public virtual User? User { get; set; }
    }
}
