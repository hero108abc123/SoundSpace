using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SoundSpace.Services.Interfaces.Product;

namespace SoundSpace.Controllers.Product
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class FavoriteTrackController : ApiControllerBase
    {
        private readonly IFavoriteTrackService _favoriteTrackService;

        public FavoriteTrackController(ILogger<FavoriteTrackController> logger, IFavoriteTrackService favoriteTrackService) : base(logger)
        {
            _favoriteTrackService = favoriteTrackService;
        }

        [HttpPost("add/{trackId}")]
        public async Task<IActionResult> AddFavoriteTrack(int trackId)
        {
            try
            {
                await _favoriteTrackService.AddFavoriteTrackAsync(trackId);
                return Ok(new { message = "Track added to favorites successfully!" });
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpDelete("remove/{trackId}")]
        public async Task<IActionResult> RemoveFavoriteTrack(int trackId)
        {
            try
            {
                await _favoriteTrackService.RemoveFavoriteTrackAsync(trackId);
                return Ok(new { message = "Track removed from favorites successfully!" });
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }
    }
}
