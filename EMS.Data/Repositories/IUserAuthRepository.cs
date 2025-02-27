using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Entities;

namespace EMS.Data.Repositories
{
    public interface IUserAuthRepository
    {
        Task<UserAuth> ValidateCredentialsAsync(string username, string password);
        Task<UserAuth> GetUserAuthByUsernameAsync(string username);
        Task<UserAuth> CreateUserAuthAsync(UserAuth userAuth);
    }
}
