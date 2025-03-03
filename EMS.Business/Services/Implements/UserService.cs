using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using EMS.Business.Dtos;
using EMS.Business.Exceptions;
using EMS.Data.Entities;
using EMS.Data.Pagination;
using EMS.Data.Repositories;

namespace EMS.Business.Services.Implements
{
    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;
        private readonly IMapper _mapper;
        private readonly IUserAuthService _userAuthService;

        public UserService(IUserRepository userRepository, IMapper mapper, IUserAuthService userAuthService)
        {
            _userRepository = userRepository;
            _mapper = mapper;
            _userAuthService = userAuthService;
        }

        public async Task<UserDto> CreateUserAsync(UserDto userDto)
        {
            var user = _mapper.Map<User>(userDto);
            var createdUser = await _userRepository.CreateUserAsync(user);
            return userDto;
        }

        public async Task<UserDto> CreateUserAsync(UserDto userDto, string username, string password)
        {
            if (await _userAuthService.IsExistUsername(username))
            {
                throw new UsernameAlreadyExistException("Username is already exist");
            }

            var user = _mapper.Map<User>(userDto);
            var createdUser = await _userRepository.CreateUserAsync(user);
            
            if (createdUser == null)
            {
                return null;
            }

            await _userAuthService.CreateUserAuthAsync(createdUser.Id, username, password);
            return userDto;
        }

        public async Task<PaginatedList<UserDto>> GetPaginatedUsersAsync(string searchTerm, int? departmentId, int? gender, DateOnly? joinDate, int pageIndex, int pageSize)
        {
            var paginatedUsers = await _userRepository.GetUsersAsync(searchTerm, departmentId, gender, joinDate, pageIndex, pageSize);
            var userDtos = _mapper.Map<List<UserDto>>(paginatedUsers);
            return new PaginatedList<UserDto>(userDtos, paginatedUsers.TotalCount, pageIndex, pageSize);
        }

        public async Task<UserDto> GetUserByIdAsync(long id, bool isIncludeDepartment)
        {
            var user = await _userRepository.GetUserByIdAsync(id, isIncludeDepartment);
            var userDto = _mapper.Map<UserDto>(user);
            userDto.DepartmentDto = _mapper.Map<DepartmentDto>(user.Department);
            return userDto;
        }

        public async Task<UserDto> UpdateUserAsync(UserDto userDto)
        {
            var user = _mapper.Map<User>(userDto);
            var updatedUser = await _userRepository.UpdateUserAsync(user);
            return _mapper.Map<UserDto>(updatedUser);
        }

        public async Task<UserDto> DeleteUserByIdAsync(long? id, long? deletedBy)
        {
            if (!id.HasValue || !deletedBy.HasValue)
            {
                throw new ArgumentNullException("Id is null");
            }
            return _mapper.Map<UserDto>(await _userRepository.DeleteUserAsync(id.Value, deletedBy.Value));
        }
    }
}
