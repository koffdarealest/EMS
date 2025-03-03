using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EMS.Business.Exceptions
{
    public class DeletedResourceException : Exception
    {
        public DeletedResourceException(string message) : base(message)
        {
        }
    }
}
