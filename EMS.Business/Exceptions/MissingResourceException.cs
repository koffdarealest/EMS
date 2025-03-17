using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EMS.Business.Exceptions
{
    public class MissingResourceException : Exception
    {
        public MissingResourceException(string message = "Resource is missing") : base(message)
        {
        }
    }
}
