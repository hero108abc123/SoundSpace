using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SoundSpace.Dtos.UserDtos;
using SoundSpace.Services.Interfaces;

namespace SoundSpace.Controllers
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
        public IActionResult CreateUser(CreateUserDto input)
        {
            try
            {
                _userService.CreateUser(input);
                return Ok();
            }catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }


        [Authorize]
        [HttpGet("get-user")]
        public IActionResult GetUser()
        {
            try
            {
                var user = _userService.GetUser();
                return Ok(user);
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }


        [Authorize]
        [HttpPut("update")]
        public IActionResult UpdateUser(UpdateUserDto input)
        {
            try
            {
                _userService.UpdateUser(input);
                return Ok();
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }


        [Authorize]
        [HttpDelete("delete")]
        public IActionResult DeleteUser()
        {
            try
            {
                _userService.DeleteUser();
                return Ok();
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

    }
}
