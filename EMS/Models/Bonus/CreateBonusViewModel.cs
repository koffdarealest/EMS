using EMS.Business.Dtos;

namespace EMS.Models.Bonus
{
    public class CreateBonusViewModel
    {
        public bool IsPenalty { get; set; }
        public decimal Amount { get; set; }
        public string? Reason { get; set; }
        public long UserId { get; set; }
        public string? Avatar { get; set; }
        public string? Fullname { get; set; }
    }
}
