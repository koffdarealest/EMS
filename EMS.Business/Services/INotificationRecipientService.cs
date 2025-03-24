using EMS.Business.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EMS.Business.Services
{
    public interface INotificationRecipientService
    {
        Task<ICollection<NotificationRecipientDto>> CreateNotificationRecipientsAsync(List<NotificationRecipientDto> notificationRecipients);
        Task<ICollection<NotificationRecipientDto>> GetNotificationsByUserIdAsync(long userId);
        Task<int> GetUnreadNotificationsCountAsync(long userId);
        Task MarkAllAsReadAsync(long userId);
    }
}
