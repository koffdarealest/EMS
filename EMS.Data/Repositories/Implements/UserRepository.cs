using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Contexts;
using EMS.Data.Entities;
using EMS.Data.Pagination;
using Microsoft.EntityFrameworkCore;

namespace EMS.Data.Repositories.Implements
{
    public class UserRepository : IUserRepository
    {
        private readonly SqlServerContext _context;

        public UserRepository(SqlServerContext context)
        {
            _context = context;
        }

        public Task<PaginatedList<User>> GetUsersAsync(int pageIndex, int pageSize)
        {
            throw new NotImplementedException();
        }

        public async Task<User> GetUserByIdAsync(long userId)
        {
            return await _context.Users.FindAsync(userId);
        }

        public async Task<User> CreateUserAsync(User user)
        {
            await _context.Users.AddAsync(user);
            await _context.SaveChangesAsync();
            return user;
        }

        public async Task<User> UpdateUserAsync(User user)
        {
            _context.Users.Update(user);
            await _context.SaveChangesAsync();
            return user;
        }

        public async Task<User> DeleteUserAsync(long userId)
        {
            var user = await _context.Users.FindAsync(userId);
            if (user == null)
            {
                return null;
            }
            else
            {
                user.IsDeleted = true;
                _context.Users.Update(user);
                await _context.SaveChangesAsync();
                return user;
            }
        }
    }
}
