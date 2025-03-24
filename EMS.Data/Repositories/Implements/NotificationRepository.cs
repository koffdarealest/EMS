using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Contexts;
using EMS.Data.Entities;

namespace EMS.Data.Repositories.Implements
{
    public class NotificationRepository : INotificationRepository
    {
        private readonly SqlServerContext _context;

        public NotificationRepository(SqlServerContext context)
        {
            _context = context;
        }

        public async Task<Notification> CreateAsync(Notification notification)
        {
            await _context.Notifications.AddAsync(notification);
            await _context.SaveChangesAsync();
            return notification;
        }
    }
}
