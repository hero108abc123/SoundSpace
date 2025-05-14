using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SoundSpace.Services.Interfaces.Product;

namespace SoundSpace.Controllers.Product
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class PlaylistFollowController : ApiControllerBase
    {
        private readonly IPlaylistFollowService _playlistFollowService;

        public PlaylistFollowController(ILogger<PlaylistFollowController> logger, IPlaylistFollowService playlistFollowService) : base(logger)
        {
            _playlistFollowService = playlistFollowService;
        }

        [HttpPost("follow/{playlistId}")]
        public async Task<IActionResult> FollowPlaylist(int playlistId)
        {
            try
            {
                await _playlistFollowService.FollowPlaylistAsync(playlistId);
                return Ok(new { message = "Playlist followed successfully!" });
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpDelete("unfollow/{playlistId}")]
        public async Task<IActionResult> UnfollowPlaylist(int playlistId)
        {
            try
            {
                await _playlistFollowService.UnfollowPlaylistAsync(playlistId);
                return Ok(new { message = "Playlist unfollowed successfully!" });
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpGet("is-following/{playlistId}")]
        public async Task<IActionResult> IsFollowingPlaylist(int playlistId)
        {
            try
            {
                bool isFollowing = await _playlistFollowService.IsFollowingPlaylistAsync(playlistId);
                return Ok(new { isFollowing });
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

    }
}