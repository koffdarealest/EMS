using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EMS.Business.Exceptions
{
    public class UsernameAlreadyExistException : Exception
    {
        public UsernameAlreadyExistException(string message = "Username is already exist") : base(message)
        {
        }
    }
}
