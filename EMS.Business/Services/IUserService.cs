using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Business.Dtos;
using EMS.Data.Pagination;

namespace EMS.Business.Services
{
    public interface IUserService
    {
        Task<UserDto> CreateUserAsync(UserDto userDto);
        Task<UserDto> CreateUserAsync(UserDto userDto, string username, string password);
        Task<PaginatedList<UserDto>> GetPaginatedUsersAsync(string searchTerm, int? departmentId, int? gender, DateOnly? joinDate, int pageIndex, int pageSize);
        Task<UserDto> GetUserByIdAsync(long id, bool isIncludeDepartment);
        Task<UserDto> UpdateUserAsync(UserDto userDto);
        Task<UserDto> DeleteUserByIdAsync(long? id, long? deletedBy);
    }
}
