using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using EMS.Business.Dtos;
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
            return _mapper.Map<UserDto>(userAuth?.User);
        }

        public async Task<bool> CreateUserAsync()
        {
            _userAuthRepository.CreateUserAuthAsync(new UserAuth
            {
                UserId = 1,
                Username = "admin",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("111")
            });
            return true;
        }
    }
}
