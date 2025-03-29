using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Entities;
using EMS.Data.Pagination;

namespace EMS.Data.Repositories
{
    public interface IUserRepository
    {
        Task<PaginatedList<User>> GetUsersAsync(string searchTerm, int? departmentId, int? gender, DateOnly? joinDate, int pageIndex, int pageSize);
        Task<ICollection<User>> GetUsersAsync();
        IQueryable<User> GetQueryableUsers();
        Task<User> GetUserByIdAsync(long userId, params Expression<Func<User, object>>[] includes);
        Task<User> CreateUserAsync(User user);
        Task<User> UpdateUserAsync(User user);
        Task<User> DeleteUserAsync(long userId);
        Task<User> DeleteUserAsync(long userId, long deletedBy);
        Task<ICollection<User>> GetEmployeesAsync(params Expression<Func<User, object>>[] includes);
        Task<ICollection<User>> GetUsersByIds(List<long> selectedUsers);
        Task<List<long>> GetUserIdsAsync();
        Task<List<long>> GetUserIdsByDepartmentIdAsync(long departmentId);
        Task<List<User>> GetAllForBackup();
    }
}
