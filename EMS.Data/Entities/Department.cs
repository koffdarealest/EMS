using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Commons;

namespace EMS.Data.Entities
{
    public class Department : BaseEntity<long>
    {
        public required string Name { get; set; }

        public virtual ICollection<User> Users { get; set; } = new List<User>();
    }
}
