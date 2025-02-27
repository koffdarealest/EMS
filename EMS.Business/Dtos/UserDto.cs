using EMS.Data.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EMS.Business.Dtos
{
    public class UserDto
    {
        public long Id { get; set; }
        public required string Fullname { get; set; }
        public DateOnly Birth { get; set; }
        public Gender Gender { get; set; }
        public string? Address { get; set; }
        public required string Phone { get; set; }
        public Duty Duty { get; set; }
        public DateOnly JoinedAt { get; set; }
        public string? Avatar { get; set; }
        public long? DepartmentId { get; set; }
        public Role Role { get; set; }
    }
}
