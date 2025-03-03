using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using EMS.Business.Dtos;
using EMS.Business.Exceptions;
using EMS.Data.Entities;
using EMS.Data.Repositories;

namespace EMS.Business.Services.Implements
{
    public class UserAuthService : IUserAuthService
    {
        private readonly IUserAuthRepository _userAuthRepository;
        private readonly IMapper _mapper;

        public UserAuthService(IUserAuthRepository userAuthRepository, IMapper mapper)
        {
            _userAuthRepository = userAuthRepository;
            _mapper = mapper;
        }

        public async Task<UserDto> ValidateCredentialsAsync(string username, string password)
        {
            var userAuth = await _userAuthRepository.ValidateCredentialsAsync(username, password);
            if (userAuth != null)
            {
                if (userAuth.User.IsDeleted)
                {
                    throw new DeletedResourceException("Your account has been deleted");
                }
            }
            return _mapper.Map<UserDto>(userAuth?.User);
        }

        public async Task<long> CreateUserAuthAsync(long createdUserId, string username, string password)
        {
            var userAuth = new UserAuth
            {
                UserId = createdUserId,
                Username = username,
                PasswordHash = BCrypt.Net.BCrypt.HashPassword(password)
            };
            var createdUserAuth = await _userAuthRepository.CreateUserAuthAsync(userAuth);
            return createdUserAuth.UserId;
        }
        public async Task<bool> IsExistUsername(string username)
        {
            return await _userAuthRepository.IsExistUsername(username);
        }
    }
}
