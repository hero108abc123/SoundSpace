using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SoundSpace.Dtos.Auth.AuthDtos;
using SoundSpace.Services.Implements.Auth;
using SoundSpace.Services.Interfaces.Auth;
using SoundSpace.Utils;

namespace SoundSpace.Controllers.Auth
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ApiControllerBase
    {
        private readonly IAuthService _authService;
        public AuthController(
            IAuthService authService,
            ILogger<AuthController> logger) : base(logger)
        {
            _authService = authService;
        }

        [HttpPost("create")]
        public async Task<IActionResult> CreateAccountAsync([FromBody] CreateAccountDto input)
        {
            try
            {
                await _authService.CreateAsync(input);
                return Ok(new { message = "Account created successfully!" });
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpPost("login")]
        public async Task<IActionResult> LoginAsync([FromBody] LoginDto input)
        {
            try
            {
                string token = await _authService.LoginAsync(input);
                return Ok(new { token });
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpPost("email-valid")]
        public async Task<IActionResult> EmailValidAsync([FromBody] EmailValidDto input)
        {
            try
            {
                await _authService.CheckEmailAsync(input);
                return Ok(new { message = "Email exists." });
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpPost("logout")]
        [Authorize] // Chỉ cho phép người dùng có token hợp lệ
        public async Task<IActionResult> Logout()
        {
            try
            {
                var token = Request.Headers["Authorization"].FirstOrDefault()?.Split(" ").Last();
                if (string.IsNullOrEmpty(token))
                {
                    return BadRequest(new { message = "Token is required!" });
                }

                await _authService.LogoutAsync(token);

                return Ok(new { message = "Logged out successfully!" });
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

    }
}
