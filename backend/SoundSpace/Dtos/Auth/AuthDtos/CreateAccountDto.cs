using System.ComponentModel.DataAnnotations;

namespace SoundSpace.Dtos.Auth.AuthDtos
{
    public class CreateAccountDto
    {
        private string _email;

        [Required]
        [StringLength(30, ErrorMessage = "Email must be between 3 and 30 characters long.", MinimumLength = 3)]
        public string Email
        {
            get => _email;
            set => _email = value?.Trim();
        }

        private string _password;

        [Required]
        [StringLength(30, ErrorMessage = "Password must be between 3 and 30 characters long.", MinimumLength = 3)]
        public string Password
        {
            get => _password;
            set => _password = value?.Trim();
        }
    }
}
