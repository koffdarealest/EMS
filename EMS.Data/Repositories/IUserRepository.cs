using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Entities;
using EMS.Data.Pagination;

namespace EMS.Data.Repositories
{
    public interface IUserRepository
    {
        Task<PaginatedList<User>> GetUsersAsync(int pageIndex, int pageSize);
        Task<User> GetUserByIdAsync(long userId);
        Task<User> CreateUserAsync(User user);
        Task<User> UpdateUserAsync(User user);
        Task<User> DeleteUserAsync(long userId);
    }
}
