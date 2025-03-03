using EMS.Data.Enums;
using System.ComponentModel.DataAnnotations;

namespace EMS.Models
{
    public class EditUserViewModel
    {
        public long Id { get; set; }
        [Required(ErrorMessage = "Fullname is required")]
        public required string Fullname { get; set; }
        public DateOnly Birth { get; set; }
        public Gender Gender { get; set; }
        public string? Address { get; set; }
        [Phone]
        [Required(ErrorMessage = "Phone is required")]
        public required string Phone { get; set; }
        public Duty Duty { get; set; }
        public DateOnly JoinedAt { get; set; }
        public string? Avatar { get; set; }
        public long? DepartmentId { get; set; }
        public Role Role { get; set; }
    }
}
