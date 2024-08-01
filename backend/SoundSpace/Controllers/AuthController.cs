using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SoundSpace.Dtos.AuthDtos;
using SoundSpace.Services.Interfaces;
using SoundSpace.Utils;

namespace SoundSpace.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ApiControllerBase
    {
        private readonly IAuthService _authService;
        public AuthController( 
            IAuthService userService,
            ILogger<AuthController> logger) : base(logger)
        {
            _authService = userService;
        }

        [HttpPost("create")]
        public IActionResult CreateAccount(CreateAccountDto input)
        {
            try
            {
                _authService.Create(input);
                return Ok();

            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }
        [HttpPost("login")]
         public IActionResult Login(LoginDto input)
        {
            try
            {
                string token = _authService.Login(input);
                return Ok(new { token });
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpPost("email-valid")]
        public IActionResult EmailValid(EmailValidDto input)
        {
            try
            {
                _authService.checkEmail(input);
                return Ok();
            }
            catch(Exception ex)
            {
                return ReturnException(ex);
            }
        }
    }
}
 