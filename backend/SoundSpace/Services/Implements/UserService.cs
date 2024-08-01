using SoundSpace.Dbcontexts;
using SoundSpace.Dtos.UserDtos;
using SoundSpace.Entities;
using SoundSpace.Exceptions;
using SoundSpace.Services.Interfaces;
using SoundSpace.Utils;

namespace SoundSpace.Services.Implements
{
    public class UserService : IUserService
    {
        private readonly ILogger _logger;
        private readonly ApplicationDbContext _dbContext;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public UserService(ILogger<UserService> logger, ApplicationDbContext dbContext, IHttpContextAccessor httpContextAccessor)
        {
            _dbContext = dbContext;
            _logger = logger;
            _httpContextAccessor = httpContextAccessor;
        }
        public void CreateUser(CreateUserDto input)
        {

            
            if(_dbContext.Users.Any(u => u.DisplayName == input.DisplayName))
            {
                throw new UserFriendlyException($"User \"{input.DisplayName}\" already exists");
            }
            var user = _dbContext.Users.Add(new User
            {
                DisplayName = input.DisplayName,
                Age = input.Age,
                Gender = input.Gender,
            });
            _dbContext.SaveChanges();
        }

        public void DeleteUser()
        {
            int currentUserId = CommonUntils.GetCurrentUserId(_httpContextAccessor);
            var user = _dbContext.Users.FirstOrDefault((u) => u.UserId == currentUserId);
            if(user != null)
            {
                _dbContext.Users.Remove(user);
                _dbContext.SaveChanges();
            }
            else
                throw new UserFriendlyException("User not found");
        }

        public UserDto GetUser()
        {
            int currentUserId = CommonUntils.GetCurrentUserId(_httpContextAccessor);
            var user = _dbContext.Users.FirstOrDefault((u) => u.UserId == currentUserId);
            if(user != null)
            {
                var result = new UserDto
                {
                    Id = user.UserId,
                    DisplayName = user.DisplayName,
                    Age = user.Age,
                    Gender = user.Gender,
                };
                return result;
            }
            throw new UserFriendlyException($"User not found!");
            
        }

        public void UpdateUser(UpdateUserDto input)
        {
            int currentUserId = CommonUntils.GetCurrentUserId(_httpContextAccessor);
            var user = _dbContext.Users.FirstOrDefault(u => u.UserId == currentUserId);
            if(user != null)
            {
                if (_dbContext.Users
                    .Any(u => u.DisplayName == input.DisplayName && u.UserId != currentUserId))
                {
                    throw new UserFriendlyException("Something wrong!");
                }
                user.DisplayName = input.DisplayName;
                _dbContext.SaveChanges();
            }
            else
                throw new UserFriendlyException("User not found");

        }
    }
}
