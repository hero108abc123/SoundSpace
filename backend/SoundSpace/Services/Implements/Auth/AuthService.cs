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
                throw new UserFriendlyException("User not found!");
            }

            if (!PasswordHasher.VerifyPassword(input.Password, user.Password))
            {
                throw new UserFriendlyException("Wrong password!");
            }

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
                expires: DateTime.UtcNow.AddSeconds(_configuration.GetValue<int>("JWT:Expires")),
                claims: claims,
                signingCredentials: new SigningCredentials(authSigningKey, SecurityAlgorithms.HmacSha256)
            );

            var newToken = new JwtSecurityTokenHandler().WriteToken(token);

            // 🔥 Xóa token cũ của user khi đăng nhập lại
            var oldTokens = await _dbContext.RevokedTokens.Where(rt => rt.AccountId == user.AccountId).ToListAsync();
            if (oldTokens.Any())
            {
                _dbContext.RevokedTokens.RemoveRange(oldTokens);
                await _dbContext.SaveChangesAsync();
            }

            return newToken;
        }


        public async Task LogoutAsync(string token)
        {
            var jwtHandler = new JwtSecurityTokenHandler();
            if (!jwtHandler.CanReadToken(token))
            {
                throw new UserFriendlyException("Invalid token format.");
            }

            var jwtToken = jwtHandler.ReadJwtToken(token);
            var userIdClaim = jwtToken.Claims.FirstOrDefault(c => c.Type == "userId");

            if (userIdClaim == null)
            {
                throw new UserFriendlyException("Invalid token, user ID not found.");
            }

            if (!int.TryParse(userIdClaim.Value, out int accountId))
            {
                throw new UserFriendlyException("Invalid user ID format.");
            }

            var existingToken = await _dbContext.RevokedTokens
                .FirstOrDefaultAsync(rt => rt.Token == token);

            if (existingToken != null)
            {
                throw new UserFriendlyException("Token has already been revoked.");
            }

            await _dbContext.RevokedTokens.AddAsync(new RevokedToken
            {
                Token = token,
                RevokedAt = DateTime.UtcNow,
                AccountId = accountId  // 🔥 Lưu AccountId vào DB
            });

            await _dbContext.SaveChangesAsync();
            _logger.LogInformation($"User logged out, token revoked: {token}");
        }


    }
}
