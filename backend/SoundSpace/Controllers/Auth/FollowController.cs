using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SoundSpace.Dtos.Product.Song;
using SoundSpace.Services.Interfaces.Auth;

namespace SoundSpace.Controllers.Auth
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class FollowController : ApiControllerBase
    {
        private readonly IUserFollowService _userFollowService;
        public FollowController(ILogger<FollowController> logger, IUserFollowService userFollowService) : base(logger)
        {
            _userFollowService = userFollowService;
        }

        [HttpPost("follow/{targetUserId}")]
        public async Task<IActionResult> FollowUser(int targetUserId)
        {
            try
            {
                await _userFollowService.FollowUserAsync(targetUserId);
                return Ok(new { message = "Đã theo dõi!" });
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }
        [HttpDelete("unfollow/{targetUserId}")]
        public async Task<IActionResult> UnfollowUser(int targetUserId)
        {
            try
            {
                await _userFollowService.UnfollowUserAsync(targetUserId);
                return Ok(new { message = "Đã bỏ theo dõi!" });
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpGet("get-followed-artists")]
        public async Task<IActionResult> GetFollowedArtists()
        {
            try
            {
                List<ArtistDto> artists = await _userFollowService.GetFollowedArtistsAsync();
                return Ok(artists);
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpGet("get-unfollowed-artists")]
        public async Task<IActionResult> GetUnfollowedArtists()
        {
            try
            {
                List<ArtistDto> artists = await _userFollowService.GetUnfollowedArtistsAsync();
                return Ok(artists);
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

    }
}
