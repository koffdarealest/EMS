using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Business.Commons;
using EMS.Data.Entities;

namespace EMS.Business.Dtos
{
    public class NotificationRecipientDto : BaseDto<long>
    {
        public bool IsRead { get; set; }
        public long NotificationId { get; set; }
        public long UserId { get; set; }

        public NotificationDto? Notification { get; set; }
        public UserDto? User { get; set; }
    }
}
