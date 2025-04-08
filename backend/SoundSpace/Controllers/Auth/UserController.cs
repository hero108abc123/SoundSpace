using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SoundSpace.Dtos.Auth.UserDtos;
using SoundSpace.Services.Interfaces.Auth;

namespace SoundSpace.Controllers.Auth
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ApiControllerBase
    {
        private readonly IUserService _userService;
        public UserController(
            IUserService userService,
            ILogger<UserController> logger) : base(logger)
        {
            _userService = userService;
        }

        [HttpPost("create")]
        public async Task<IActionResult> CreateUserAsync([FromForm] CreateUserDto input)
        {
            try
            {
                await _userService.CreateUserAsync(input);
                return Ok(new { message = "User created successfully!" });
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [Authorize]
        [HttpGet("get-user")]
        public async Task<IActionResult> GetUserAsync()
        {
            try
            {
                var user = await _userService.GetUserAsync();
                return Ok(user);
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [Authorize]
        [HttpPut("update")]
        public async Task<IActionResult> UpdateUserAsync(UpdateUserDto input)
        {
            try
            {
                await _userService.UpdateUserAsync(input);
                return Ok(new { message = "User updated successfully!" });
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [Authorize]
        [HttpDelete("delete")]
        public async Task<IActionResult> DeleteUserAsync()
        {
            try
            {
                await _userService.DeleteUserAsync();
                return Ok(new { message = "User deleted successfully!" });
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }
    }
}
