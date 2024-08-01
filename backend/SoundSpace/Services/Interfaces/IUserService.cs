using SoundSpace.Dtos.UserDtos;

namespace SoundSpace.Services.Interfaces
{
    public interface IUserService
    {
        void CreateUser(CreateUserDto input);
        void UpdateUser(UpdateUserDto input);
        void DeleteUser();
        UserDto GetUser();
    }
}
