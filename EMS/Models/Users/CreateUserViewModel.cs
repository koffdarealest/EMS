using System.ComponentModel.DataAnnotations;
using EMS.Data.Enums;
using EMS.Models.Validations;

namespace EMS.Models.Users
{
    public class CreateUserViewModel
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
        [JoinAtBeforeNow]
        public DateOnly JoinedAt { get; set; }
        public string? Avatar { get; set; }
        public long? DepartmentId { get; set; }
        public Role Role { get; set; }
        [Required(ErrorMessage = "Username is required")]
        public string Username { get; set; }
        [Required(ErrorMessage = "Password is required")]
        public string Password { get; set; }
    }
}
