namespace EMS.Models.Salaries
{
    public class EditSalaryViewModel
    {
        public long Id { get; set; }
        public decimal Basic { get; set; }
        public decimal Allowance { get; set; }
        public DateTime EffectiveAt { get; set; }
        public long UserId { get; set; }
        public string? Fullname { get; set; }
    }
}
