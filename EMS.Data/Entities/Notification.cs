using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Commons;

namespace EMS.Data.Entities
{
    public class Notification : BaseEntity<long>
    {
        public string? Title { get; set; }
        public string? Message { get; set; }
        public long SenderId { get; set; }
        public long DepartmentId { get; set; }

        public virtual User? User { get; set; }
        public virtual Department? Department { get; set; }
    }
}
