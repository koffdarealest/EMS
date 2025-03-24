using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using EMS.Business.Dtos;
using EMS.Data.Entities;
using EMS.Data.Repositories;
using Microsoft.VisualBasic;

namespace EMS.Business.Services.Implements
{
    public class NotificationService : INotificationService
    {
        private readonly INotificationRepository _notificationRepository;
        private readonly IMapper _mapper;

        public NotificationService(INotificationRepository notificationRepository, IMapper mapper)
        {
            _notificationRepository = notificationRepository;
            _mapper = mapper;
        }

        public async Task<NotificationDto> CreateNotificationAsync(NotificationDto dto)
        {
            var notification = await _notificationRepository.CreateAsync(_mapper.Map<Notification>(dto));
            return _mapper.Map<NotificationDto>(notification);
        }
    }
}
