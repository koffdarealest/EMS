using EMS.Data.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EMS.Data.Repositories
{
    public interface INotificationRecipientRepository
    {
        Task<ICollection<NotificationRecipient>> CreateAsync(List<NotificationRecipient> notificationRecipientEntities);
        Task<ICollection<NotificationRecipient>> GetNotificationsByUserIdAsync(long userId);
        Task<int> GetUnreadNotificationsCountAsync(long userId);
        Task MarkAllAsReadAsync(long userId);
    }
}
