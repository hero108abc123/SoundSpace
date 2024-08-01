using AutoMapper;
using SoundSpace.Dtos.UserDtos;
using SoundSpace.Entities;

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
