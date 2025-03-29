using EMS.Business.Redis.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EMS.Business.Redis
{
    public interface IRedisService
    {
        Task<string> GetAsync(string key);
        Task SaveSessionAsync(string userId, UserSessionData sessionData);
        Task SetAsync(string key, string value);
        Task<UserSessionData?> GetSessionAsync(string userId);
    }
}
