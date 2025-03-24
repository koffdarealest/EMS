﻿using EMS.Business.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EMS.Business.Services
{
    public interface IActivityLogService
    {
        Task<ActivityLogDto> CreateActivityLogAsync(ActivityLogDto activityLogDto);
        Task<ICollection<ActivityLogDto>> GetActivityLogsAsync(long userId);
    }
}
