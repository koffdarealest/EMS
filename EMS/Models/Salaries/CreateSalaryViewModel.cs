namespace EMS.Models.Salaries
{
    public class CreateSalaryViewModel
    {
        public decimal Basic { get; set; }
        public decimal Allowance { get; set; }
        public DateTime EffectiveAt { get; set; }
        public long UserId { get; set; }
    }
}
