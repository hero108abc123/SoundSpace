using SoundSpace.Dtos.Auth.UserDtos;

namespace SoundSpace.Services.Interfaces.Auth
{
    public interface IUserService
    {
        Task CreateUserAsync(CreateUserDto input);
        Task DeleteUserAsync();
        Task<UserDto> GetUserAsync();
        Task UpdateUserAsync(UpdateUserDto input);
    }

}
