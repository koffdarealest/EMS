using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Business.Dtos;

namespace EMS.Business.Services
{
    public interface IUserAuthService
    {
        Task<UserDto> ValidateCredentialsAsync(string username, string password);
        Task<bool> CreateUserAsync();
    }
}
