using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Threading.Tasks;
using EMS.Business.Redis.Data;
using StackExchange.Redis;

namespace EMS.Business.Redis
{
    public class RedisService : IRedisService
    {
        private readonly IDatabase _redis;

        public RedisService(IConnectionMultiplexer connectionMultiplexer)
        {
            _redis = connectionMultiplexer.GetDatabase();
        }

        public async Task<string> GetAsync(string key)
        {
            return await _redis.StringGetAsync(key);
        }

        public async Task SetAsync(string key, string value)
        {
            await _redis.StringSetAsync(key, value);
        }

        public async Task SaveSessionAsync(string userId, UserSessionData sessionData)
        {
            string jsonData = JsonSerializer.Serialize(sessionData);
            await _redis.StringSetAsync($"session:{userId}", jsonData, TimeSpan.FromMinutes(2));
        }

        public async Task<UserSessionData?> GetSessionAsync(string userId)
        {
            string jsonData = await _redis.StringGetAsync($"session:{userId}");
            return string.IsNullOrEmpty(jsonData) ? null : JsonSerializer.Deserialize<UserSessionData>(jsonData);
        }
    }
}
