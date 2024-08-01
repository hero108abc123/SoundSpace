using Microsoft.VisualBasic;
using System.ComponentModel.DataAnnotations;

namespace SoundSpace.Utils
{
    public class IntegerRangeAttribute : ValidationAttribute
    {
        public int[] AllowableValues { get; set; }

        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            if (value == null || AllowableValues?.Contains((int)value) == true)
            {
                return ValidationResult.Success;
            }
            var msg = $"Please select one of the following values: {string.Join(", ", AllowableValues.Select(i => i.ToString()).ToArray() ?? new string[] { "No values are allowed."})}.";
            if (!string.IsNullOrEmpty(ErrorMessage)) 
            {
                msg = ErrorMessage;
            }

            return new ValidationResult(msg);
        }
    }
}
