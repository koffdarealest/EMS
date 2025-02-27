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
    public class UserAuthRepository : IUserAuthRepository
    {
        private readonly SqlServerContext _context;

        public UserAuthRepository(SqlServerContext context)
        {
            _context = context;
        }

        public async Task<bool> ValidateCredentialsAsync(string username, string password)
        {
            string hashedPassword = BCrypt.Net.BCrypt.HashPassword(password);
            var user = await GetUserAuthByUsernameAsync(username);
            if (user == null)
            {
                return false;
            }
            return BCrypt.Net.BCrypt.Verify(password, user.PasswordHash);
        }

        public async Task<UserAuth> GetUserAuthByUsernameAsync(string username)
        {
            return await _context.UserAuths
                .Include(ua => ua.User)
                .FirstOrDefaultAsync(ua => ua.Username == username);
        }

        public async Task<UserAuth> CreateUserAuthAsync(UserAuth userAuth)
        {
            await _context.UserAuths.AddAsync(userAuth);
            await _context.SaveChangesAsync();
            return userAuth;
        }
    }
}
