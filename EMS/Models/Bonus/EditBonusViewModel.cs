namespace EMS.Models.Bonus
{
    public class EditBonusViewModel
    {
        public long Id { get; set; }
        public bool IsPenalty { get; set; }
        public decimal Amount { get; set; }
        public string? Reason { get; set; }
        public long UserId { get; set; }
        public string? Avatar { get; set; }
        public string? Fullname { get; set; }
    }
}
