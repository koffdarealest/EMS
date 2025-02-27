using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Commons;

namespace EMS.Data.Entities
{
    public class ActivityLog : BaseEntity<long>
    {
        public string? Detail { get; set; }
        public long UserId { get; set; }

        public virtual User? User { get; set; }
    }
}
