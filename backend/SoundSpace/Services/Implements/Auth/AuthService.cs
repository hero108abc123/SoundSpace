using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using SoundSpace.Dbcontexts;
using SoundSpace.Entities;
using SoundSpace.Exceptions;
using SoundSpace.Utils;
using SoundSpace.Dtos.Auth.AuthDtos;
using SoundSpace.Services.Interfaces.Auth;
using SoundSpace.Entities.Auth;
using Microsoft.EntityFrameworkCore;


namespace SoundSpace.Services.Implements.Auth
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

        public async Task CheckEmailAsync(EmailValidDto input)
        {
            var emailFind = await _dbContext.Accounts.FirstOrDefaultAsync(a => a.Email == input.Email);
            if (emailFind == null)
            {
                throw new UserFriendlyException($"Email not found!");
            }
        }

        public async Task CreateAsync(CreateAccountDto input)
        {
            if (await _dbContext.Accounts.AnyAsync(a => a.Email == input.Email))
            {
                throw new UserFriendlyException($"The account name \"{input.Email}\" already exists!");
            }

            await _dbContext.Accounts.AddAsync(new Account
            {
                Email = input.Email,
                Password = PasswordHasher.HashPassword(input.Password),
            });

            await _dbContext.SaveChangesAsync();
        }

        public async Task<string> LoginAsync(LoginDto input)
        {
            var user = await _dbContext.Accounts.FirstOrDefaultAsync(a => a.Email == input.Email);
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
                );

                return new JwtSecurityTokenHandler().WriteToken(token);
            }
            else
            {
                throw new UserFriendlyException($"Wrong password!");
            }
        }

        public async Task LogoutAsync(string token)
        {
            // Hiện tại, logout với JWT chỉ là hành động client-side,
            // nhưng nếu bạn lưu token trong danh sách block, hãy thêm logic vào đây.
            _logger.LogInformation($"User logged out with token: {token}");
        }

    }
}
