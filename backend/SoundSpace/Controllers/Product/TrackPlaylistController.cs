using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SoundSpace.Services.Interfaces.Product;

namespace SoundSpace.Controllers.Product
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class TrackPlaylistController : ApiControllerBase
    {
        private readonly ITrackPlaylistService _trackPlaylistService;

        public TrackPlaylistController(ILogger<TrackPlaylistController> logger, ITrackPlaylistService trackPlaylistService) : base(logger)
        {
            _trackPlaylistService = trackPlaylistService;
        }

        [HttpPost("add/{trackId}/{playlistId}")]
        public async Task<IActionResult> AddTrackToPlaylist(int trackId, int playlistId)
        {
            try
            {
                await _trackPlaylistService.AddTrackToPlaylistAsync(trackId, playlistId);
                return Ok(new { message = "Track added to playlist successfully!" });
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpDelete("remove/{trackId}/{playlistId}")]
        public async Task<IActionResult> RemoveTrackFromPlaylist(int trackId, int playlistId)
        {
            try
            {
                await _trackPlaylistService.RemoveTrackFromPlaylistAsync(trackId, playlistId);
                return Ok(new { message = "Track removed from playlist successfully!" });
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }
    }
}