using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Contexts;
using EMS.Data.Entities;
using Microsoft.EntityFrameworkCore;

namespace EMS.Data.Repositories.Implements
{
    public class NotificationRecipientRepository : INotificationRecipientRepository
    {
        private readonly SqlServerContext _context;

        public NotificationRecipientRepository(SqlServerContext context)
        {
            _context = context;
        }

        public async Task<ICollection<NotificationRecipient>> CreateAsync(List<NotificationRecipient> notificationRecipientEntities)
        {
            await _context.NotificationRecipients.AddRangeAsync(notificationRecipientEntities);
            await _context.SaveChangesAsync();
            return notificationRecipientEntities;
        }

        public async Task<ICollection<NotificationRecipient>> GetNotificationsByUserIdAsync(long userId)
        {
            var notificationRecipientEntities = await _context.NotificationRecipients
                .Where(nr => nr.UserId == userId)
                .Include(nr => nr.Notification)
                .ThenInclude(n => n.User)
                .OrderByDescending(nr => nr.CreatedAt)
                .ToListAsync();

            return notificationRecipientEntities;
        }

        public async Task<int> GetUnreadNotificationsCountAsync(long userId)
        {
            return await _context.NotificationRecipients
                .CountAsync(nr => nr.UserId == userId && !nr.IsRead);
        }

        public async Task MarkAllAsReadAsync(long userId)
        {
            var notificationRecipientEntities = await _context.NotificationRecipients
                .Where(nr => nr.UserId == userId && !nr.IsRead)
                .ToListAsync();
            notificationRecipientEntities.ForEach(nr => nr.IsRead = true);
            await _context.SaveChangesAsync();
        }
    }
}
