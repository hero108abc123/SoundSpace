using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SoundSpace.Dtos.Product.Song;
using SoundSpace.Services.Interfaces.Product;

namespace SoundSpace.Controllers.Product
{
    [Route("api/[controller]")]
    [ApiController]
    public class TrackController : ApiControllerBase
    {
        private readonly ITrackService _trackService;
        public TrackController(ILogger<TrackController> logger, ITrackService trackService) : base(logger)
        {
            _trackService = trackService;
        }


        [Authorize]
        [HttpPost("add-track")]
        public async Task<IActionResult> CreateTrack([FromForm] AddTrackDto input)
        {
            try
            {
                await _trackService.CreateTrackAsync(input);
                return Ok(new { message = "Track added successfully!" });
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }


        [Authorize]
        [HttpDelete("delete-track")]
        public async Task<IActionResult> DeleteTrack(int trackId)
        {
            try
            {
                await _trackService.DeleteTrackAsync(trackId);
                return Ok(new { message = "Track deleted successfully!" });
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpGet("get-track")]

        public async Task<IActionResult> GetTrack(int trackId)
        {
            try
            {
                var track = await _trackService.GetTrackAsync(trackId);
                return Ok(track);
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpGet("get-all-tracks")]

        public async Task<IActionResult> GetAllTracks()
        {
            try
            {
                var tracks = await _trackService.GetAllTracksAsync();
                return Ok(tracks);
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [Authorize]
        [HttpPut("update-track")]

        public async Task<IActionResult> UpdateTrack([FromForm] UpdateTrackDto input)
        {
            try
            {
                await _trackService.UpdateTrackAsync(input);
                return Ok(new { message = "Track updated successfully!" });
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpGet("get-artist")]
        public async Task<IActionResult> GetArtist(int trackId)
        {
            try
            {
                var artist = await _trackService.GetArtistByTrackAsync(trackId);
                return Ok(artist);
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [Authorize]
        [HttpGet("get-track-from-following")]
        public async Task<IActionResult> GetTracksFromFollowing()
        {
            try
            {
                var tracks = await _trackService.GetTracksFromFollowingAsync();
                return Ok(tracks);
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }
        
        [Authorize]
        [HttpGet("get-track-from-nonfollowing")]
        public async Task<IActionResult> GetTracksFromNonFollowing()
        {
            try
            {
                var tracks = await _trackService.GetTracksFromNotFollowingAsync();
                return Ok(tracks);
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [Authorize]
        [HttpGet("get-favorite-tracks")]
        public async Task<IActionResult> GetFavoriteTracks()
        {
            try
            {
                var tracks = await _trackService.GetFavoriteTracksAsync();
                return Ok(tracks);
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [Authorize]
        [HttpGet("get-unfavorited-tracks")]
        public async Task<IActionResult> GetUnfavoritedTracks()
        {
            try
            {
                var tracks = await _trackService.GetUnfavoritedTracksAsync();
                return Ok(tracks);
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [Authorize]
        [HttpGet("get-my-tracks")]
        public async Task<IActionResult> GetMyTracks()
        {
            try
            {
                var tracks = await _trackService.GetMyTracksAsync();
                return Ok(tracks);
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [Authorize]
        [HttpGet("get-tracks-by-user/{userId}")]
        public async Task<IActionResult> GetTracksByUserId(int userId)
        {
            try
            {
                var tracks = await _trackService.GetTracksByUserIdAsync(userId);
                return Ok(tracks);
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }
    }
}
