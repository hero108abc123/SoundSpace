using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using SoundSpace.Dbcontexts;
using SoundSpace.Dtos.AuthDtos;
using SoundSpace.Entities;
using SoundSpace.Exceptions;
using SoundSpace.Services.Interfaces;
using SoundSpace.Utils;


namespace SoundSpace.Services.Implements
{
    public class AuthService : IAuthService
    {
        private readonly ILogger _logger;
        private readonly ApplicationDbContext _dbContext;
        private readonly IConfiguration _configuration;
        public AuthService(
            ILogger<UserService> logger,
            ApplicationDbContext dbContext,
            IConfiguration configuration)
        {
            _configuration = configuration;
            _logger = logger;
            _dbContext = dbContext;
            
        }

        public void checkEmail(EmailValidDto input)
        {
            var emailFind = _dbContext.Accounts.FirstOrDefault(a => a.Email == input.Email);
            if (emailFind == null)
            {
                throw new UserFriendlyException($"Email not found!");
            }
        }

        public void Create(CreateAccountDto input)
        {
            if (_dbContext.Accounts.Any(a => a.Email == input.Email))
            {
                throw new UserFriendlyException($"The account name \"{input.Email}\" already exists!");
            }
            _dbContext.Accounts.Add(new Account
            {
                Email = input.Email,
                Password = PasswordHasher.HashPassword(input.Password),
            });
            _dbContext.SaveChanges();
        }

        public string Login(LoginDto input)
        {
            var user = _dbContext.Accounts.FirstOrDefault(a => a.Email == input.Email);
            if (user == null)
            {
                throw new UserFriendlyException($"User not found!");
            }

            if (PasswordHasher.VerifyPassword(input.Password, user.Password))
            {
                var authSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["JWT:Secret"]));
                var claims = new List<Claim>
                {
                    new Claim(ClaimTypes.Name, user.AccountId.ToString()),
                    new Claim("userId", user.AccountId.ToString()),
                    new Claim("userEmail", user.Email),
                };

                var token = new JwtSecurityToken(
                    issuer: _configuration["JWT:ValidIssuer"],
                    audience: _configuration["JWT:ValidAudience"],
                    expires: DateTime.Now.AddSeconds(_configuration.GetValue<int>("JWT:Expires")),
                    claims: claims,
                    signingCredentials: new SigningCredentials(authSigningKey, SecurityAlgorithms.HmacSha256)
                ) ;

                return new JwtSecurityTokenHandler().WriteToken(token);
            }
            else
            {
                throw new UserFriendlyException($"Wrong password!");
            }
        }

    }
}
