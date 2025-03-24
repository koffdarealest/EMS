﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
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
        private readonly ILeaveBalanceRepository _leaveBalanceRepository;

        public UserService(IUserRepository userRepository, IMapper mapper, IUserAuthService userAuthService, ILeaveBalanceRepository leaveBalanceRepository)
        {
            _userRepository = userRepository;
            _mapper = mapper;
            _userAuthService = userAuthService;
            _leaveBalanceRepository = leaveBalanceRepository;
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

            LeaveBalanceDto leaveBalanceDto = new LeaveBalanceDto
            {
                Year = DateTime.Now.Year,
                RemainingDay = 12,
                RemainingSickDay = 30,
                UserId = createdUser.Id
            };
            await _leaveBalanceRepository.CreateAsync(_mapper.Map<LeaveBalance>(leaveBalanceDto));
            await _userAuthService.CreateUserAuthAsync(createdUser.Id, username, password);
            return _mapper.Map<UserDto>(createdUser);
        }

        public async Task<PaginatedList<UserDto>> GetPaginatedUsersAsync(string searchTerm, int? departmentId, int? gender, DateOnly? joinDate, int pageIndex, int pageSize)
        {
            var paginatedUsers = await _userRepository.GetUsersAsync(searchTerm, departmentId, gender, joinDate, pageIndex, pageSize);
            var userDtos = _mapper.Map<List<UserDto>>(paginatedUsers);
            return new PaginatedList<UserDto>(userDtos, paginatedUsers.TotalCount, pageIndex, pageSize);
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

        public async Task<ICollection<UserDto>> GetEmployeesAsync(params Expression<Func<User, object>>[] includes)
        {
            var employees = await _userRepository.GetEmployeesAsync(includes);
            return _mapper.Map<ICollection<UserDto>>(employees);
        }

        public async Task<UserDto> GetUserByIdAsync(long userId, params Expression<Func<User, object>>[] includes)
        {
            var user = await _userRepository.GetUserByIdAsync(userId, includes);
            return _mapper.Map<UserDto>(user);
        }

        public async Task<PaginatedList<UserDto>> SearchUsersAsync(string searchTerm, long? departmentId, int? gender, DateTime? joinedAt, int pageIndex,
            int pageSize)
        {
            var queryable = _userRepository.GetQueryableUsers();
            if (!string.IsNullOrEmpty(searchTerm))
                queryable = queryable.Where(u => u.Fullname.Contains(searchTerm));

            if (departmentId.HasValue)
                queryable = queryable.Where(u => u.DepartmentId == departmentId);

            if (gender.HasValue)
                queryable = queryable.Where(u => (int)u.Gender == gender);

            //if (joinedAt.HasValue)
            //    queryable = queryable.Where(u => u.JoinedAt == DateOnly.FromDateTime(joinedAt.Value));

            var users = await PaginatedList<User>.CreateAsync(queryable, pageIndex, pageSize);
            var userDtos = _mapper.Map<List<UserDto>>(users);
            return new PaginatedList<UserDto>(userDtos, users.TotalCount, pageIndex, pageSize);
        }

        public async Task<List<long>> GetUserIdsAsync()
        {
            return await _userRepository.GetUserIdsAsync();
        }

        public async Task<List<long>> GetUserIdsByDepartmentIdAsync(long departmentId)
        {
            return await _userRepository.GetUserIdsByDepartmentIdAsync(departmentId);
        }
    }
}
