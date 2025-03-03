using System.ComponentModel.DataAnnotations;

namespace EMS.Models.Validations
{
    public class JoinAtBeforeNowAttribute : ValidationAttribute
    {
        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            if (value is DateOnly date)
            {
                if (date > DateOnly.FromDateTime(DateTime.Now))
                {
                    return new ValidationResult("JoinedAt must be before now");
                }
            }
            return ValidationResult.Success;
        }
    }
}
