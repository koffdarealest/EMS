using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Business.Commons;
using EMS.Data.Commons;

namespace EMS.Business.Dtos
{
    public class DepartmentDto : BaseDto<long>
    {
        public string Name { get; set; }
    }
}
