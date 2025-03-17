using SoundSpace.Dtos.Auth.AuthDtos;

namespace SoundSpace.Services.Interfaces.Auth
{
    public interface IAuthService
    {
        Task CheckEmailAsync(EmailValidDto input);
        Task CreateAsync(CreateAccountDto input);
        Task<string> LoginAsync(LoginDto input);
        Task LogoutAsync(string token);
    }
}
