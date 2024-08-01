using SoundSpace.Dtos.AuthDtos;

namespace SoundSpace.Services.Interfaces
{
    public interface IAuthService
    {
        void Create(CreateAccountDto input);
        string Login(LoginDto input);
        void checkEmail(EmailValidDto input);
    }
}
