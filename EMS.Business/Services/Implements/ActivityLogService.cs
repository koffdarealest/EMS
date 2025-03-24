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
    public class ActivityLogService : IActivityLogService
    {
        private readonly IActivityLogRepository _activityLogRepository;
        private readonly IMapper _mapper;

        public ActivityLogService(IActivityLogRepository activityLogRepository, IMapper mapper)
        {
            _activityLogRepository = activityLogRepository;
            _mapper = mapper;
        }

        public async Task<ActivityLogDto> CreateActivityLogAsync(ActivityLogDto activityLogDto)
        {
            var activityLog = _mapper.Map<ActivityLog>(activityLogDto);

            var result = await _activityLogRepository.AddAsync(activityLog);
            return _mapper.Map<ActivityLogDto>(result);
        }

        public async Task<ICollection<ActivityLogDto>> GetActivityLogsAsync(long userId)
        {
            var activityLogs = await _activityLogRepository.GetAllByIdAsync(userId);
            return _mapper.Map<ICollection<ActivityLogDto>>(activityLogs);
        }
    }
}
