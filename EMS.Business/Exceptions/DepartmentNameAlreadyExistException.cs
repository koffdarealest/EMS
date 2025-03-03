using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EMS.Business.Exceptions
{
    public class DepartmentNameAlreadyExistException : Exception
    {
        public DepartmentNameAlreadyExistException(string message = "Department name is already exist") : base(message)
        {
        }
    }
}
