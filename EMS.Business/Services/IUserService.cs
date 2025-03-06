using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using EMS.Business.Dtos;
using EMS.Data.Entities;
using EMS.Data.Pagination;

namespace EMS.Business.Services
{
    public interface IUserService
    {
        Task<UserDto> CreateUserAsync(UserDto userDto);
        Task<UserDto> CreateUserAsync(UserDto userDto, string username, string password);
        Task<PaginatedList<UserDto>> GetPaginatedUsersAsync(string searchTerm, int? departmentId, int? gender, DateOnly? joinDate, int pageIndex, int pageSize);
        Task<UserDto> UpdateUserAsync(UserDto userDto);
        Task<UserDto> DeleteUserByIdAsync(long? id, long? deletedBy);
        Task<ICollection<UserDto>> GetEmployeesAsync();
        Task<UserDto> GetUserByIdAsync(long userId, params Expression<Func<User, object>>[] includes);
    }
}
