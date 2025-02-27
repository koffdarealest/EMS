using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Commons;

namespace EMS.Data.Entities
{
    public class NotificationRecipient : BaseEntity<long>
    {
        public bool IsRead { get; set; }
        public long NotificationId { get; set; }
        public long UserId { get; set; }

        public virtual Notification? Notification { get; set; }
        public virtual User? User { get; set; }
    }
}
