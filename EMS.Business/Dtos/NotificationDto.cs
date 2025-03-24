using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Business.Commons;
using EMS.Data.Entities;

namespace EMS.Business.Dtos
{
    public class NotificationDto : BaseDto<long>
    {
        public string? Title { get; set; }
        public string? Message { get; set; }
        public long UserId { get; set; }
        public long? DepartmentId { get; set; }

        public UserDto? User { get; set; }
        public DepartmentDto? Department { get; set; }
    }
}
