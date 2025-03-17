using AutoMapper;
using SoundSpace.Dtos.Auth.UserDtos;
using SoundSpace.Entities.Auth;

namespace SoundSpace.Helper
{
    public class MappingProfiles : Profile
    {
        public MappingProfiles()
        {
            CreateMap<User, UserDto>();
            CreateMap<UserDto, User>();
        }
    }
}
