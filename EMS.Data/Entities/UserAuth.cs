using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EMS.Data.Entities
{
    public class UserAuth
    {
        public long UserId { get; set; }
        public string Username { get; set; }
        public string PasswordHash { get; set; }

        public virtual User? User { get; set; }
    }
}
