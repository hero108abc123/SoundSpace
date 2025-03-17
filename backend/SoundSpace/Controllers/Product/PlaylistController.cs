using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SoundSpace.Dtos.Product.Playlist;
using SoundSpace.Services.Interfaces.Product;

namespace SoundSpace.Controllers.Product
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class PlaylistController : ApiControllerBase
    {
        private readonly IPlaylistService _playlistService;

        public PlaylistController(ILogger<PlaylistController> logger, IPlaylistService playlistService) : base(logger)
        {
            _playlistService = playlistService;
        }

        [HttpPost("create")]
        public async Task<IActionResult> CreatePlaylist([FromForm] AddPlaylistDto input)
        {
            try
            {
                await _playlistService.CreatePlaylistAsync(input);
                return Ok(new { message = "Playlist created successfully!" });
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpDelete("delete/{playlistId}")]
        public async Task<IActionResult> DeletePlaylist(int playlistId)
        {
            try
            {
                await _playlistService.DeletePlaylistAsync(playlistId);
                return Ok(new { message = "Playlist deleted successfully!" });
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpPut("update")]
        public async Task<IActionResult> UpdatePlaylist([FromForm] UpdatePlaylistDto input)
        {
            try
            {
                await _playlistService.UpdatePlaylistAsync(input);
                return Ok(new { message = "Playlist updated successfully!" });
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpGet("get/{playlistId}")]
        public async Task<IActionResult> GetPlaylist(int playlistId)
        {
            try
            {
                var playlist = await _playlistService.GetPlaylistAsync(playlistId);
                return Ok(playlist);
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpGet("get-all")]
        public async Task<IActionResult> GetAllPlaylists()
        {
            try
            {
                var playlists = await _playlistService.GetAllPlaylistsAsync();
                return Ok(playlists);
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpGet("get-tracks/{playlistId}")]
        public async Task<IActionResult> GetTracksFromPlaylist(int playlistId)
        {
            try
            {
                var tracks = await _playlistService.GetTracksFromPlaylistAsync(playlistId);
                return Ok(tracks);
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpGet("get-unfollowed-playlist")]
        public async Task<IActionResult> GetUnfollowedPlaylists()
        {
            try
            {
                var playlists = await _playlistService.GetUnfollowedPlaylistsAsync();
                return Ok(playlists);
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpGet("get-followed-playlist")]
        public async Task<IActionResult> GetFollowedPlaylists()
        {
            try
            {
                var playlists = await _playlistService.GetFollowedPlaylistsAsync();
                return Ok(playlists);
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpGet("get-playlists-by-userid/{userId}")]
        public async Task<IActionResult> GetPlaylistsByUserId(int userId)
        {
            try
            {
                var playlists = await _playlistService.GetPlaylistsByUserIdAsync(userId);
                return Ok(playlists);
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpGet("get-my-playlists")]
        public async Task<IActionResult> GetOwnPlaylists()
        {
            try
            {
                var playlists = await _playlistService.GetOwnPlaylistsAsync();
                return Ok(playlists);
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpGet("get-playlist-from-following")]
        public async Task<IActionResult> GetPlaylistsFromFollowing()
        {
            try
            {
                var playlists = await _playlistService.GetPlaylistsFromFollowingAsync();
                return Ok(playlists);
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpGet("get-playlist-from-unfollowing")]
        public async Task<IActionResult> GetPlaylistsFromUnfollowing()
        {
            try
            {
                var playlists = await _playlistService.GetPlaylistsFromNotFollowingAsync();
                return Ok(playlists);
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }
    }
}
