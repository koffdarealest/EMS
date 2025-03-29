using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EMS.Business.Redis.Data
{
    public class UserSessionData
    {
        public List<int> FilteredEmployees { get; set; } = new List<int>();
        public string OpenedTab { get; set; }
    }
}
