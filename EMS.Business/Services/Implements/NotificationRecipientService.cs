using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using EMS.Business.Dtos;
using EMS.Data.Entities;
using EMS.Data.Repositories;

namespace EMS.Business.Services.Implements
{
    public class NotificationRecipientService : INotificationRecipientService
    {
        private readonly INotificationRecipientRepository _notificationRecipientRepository;
        private readonly IMapper _mapper;

        public NotificationRecipientService(INotificationRecipientRepository notificationRecipientRepository, IMapper mapper)
        {
            _notificationRecipientRepository = notificationRecipientRepository;
            _mapper = mapper;
        }

        public async Task<ICollection<NotificationRecipientDto>> CreateNotificationRecipientsAsync(List<NotificationRecipientDto> notificationRecipients)
        {
            var notificationRecipientEntities = _mapper.Map<List<NotificationRecipient>>(notificationRecipients);
            var createdNotificationRecipientEntities = await _notificationRecipientRepository.CreateAsync(notificationRecipientEntities);
            return _mapper.Map<ICollection<NotificationRecipientDto>>(createdNotificationRecipientEntities);
        }

        public async Task<ICollection<NotificationRecipientDto>> GetNotificationsByUserIdAsync(long userId)
        {
            var notificationRecipientEntities = await _notificationRecipientRepository.GetNotificationsByUserIdAsync(userId);
            return _mapper.Map<ICollection<NotificationRecipientDto>>(notificationRecipientEntities);
        }

        public async Task<int> GetUnreadNotificationsCountAsync(long userId)
        {
            return await _notificationRecipientRepository.GetUnreadNotificationsCountAsync(userId);
        }

        public async Task MarkAllAsReadAsync(long userId)
        {
            await _notificationRecipientRepository.MarkAllAsReadAsync(userId);
        }
    }
}
