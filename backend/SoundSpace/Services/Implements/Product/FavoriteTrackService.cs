using Microsoft.EntityFrameworkCore;
using SoundSpace.Dbcontexts;
using SoundSpace.Entities.Product;
using SoundSpace.Exceptions;
using SoundSpace.Services.Implements.Auth;
using SoundSpace.Services.Interfaces.Product;
using SoundSpace.Utils;

namespace SoundSpace.Services.Implements.Product
{
    public class FavoriteTrackService : IFavoriteTrackService
    {
        private readonly ILogger _logger;
        private readonly ApplicationDbContext _dbContext;
        private readonly IHttpContextAccessor _httpContextAccessor;
        public FavoriteTrackService(ILogger<FavoriteTrackService> logger, ApplicationDbContext dbContext, IHttpContextAccessor httpContextAccessor)
        {
            _dbContext = dbContext;
            _logger = logger;
            _httpContextAccessor = httpContextAccessor;
        }

        public async Task AddFavoriteTrackAsync(int trackId)
        {
            int currentUserId = CommonUntils.GetCurrentUserId(_httpContextAccessor);
            var favoriteTrack = await _dbContext.FavoriteTracks
                .FirstOrDefaultAsync(ft => ft.UserId == currentUserId && ft.TrackId == trackId);
            if (favoriteTrack != null)
            {
                throw new UserFriendlyException("Track này đã nằm trong danh sách yêu thích của bạn!");
            }
            var newFavoriteTrack = new FavoriteTrack
            {
                UserId = currentUserId,
                TrackId = trackId
            };
            await _dbContext.FavoriteTracks.AddAsync(newFavoriteTrack);
            await _dbContext.SaveChangesAsync();
        }

        public async Task RemoveFavoriteTrackAsync(int trackId)
        {
            int currentUserId = CommonUntils.GetCurrentUserId(_httpContextAccessor);
            var favoriteTrack = await _dbContext.FavoriteTracks
                .FirstOrDefaultAsync(ft => ft.UserId == currentUserId && ft.TrackId == trackId);
            if (favoriteTrack == null)
            {
                throw new UserFriendlyException("Track này không nằm trong danh sách yêu thích của bạn!");
            }
            _dbContext.FavoriteTracks.Remove(favoriteTrack);
            await _dbContext.SaveChangesAsync();
        }

        // Đếm số lượng người yêu thích một bài hát
        public async Task<int> GetFavoriteCountAsync(int trackId)
        {
            return await _dbContext.FavoriteTracks.CountAsync(f => f.TrackId == trackId);
        }

        public async Task<bool> IsFavoriteTrackAsync(int trackId)
        {
            int currentUserId = CommonUntils.GetCurrentUserId(_httpContextAccessor);

            return await _dbContext.FavoriteTracks
                .AnyAsync(ft => ft.UserId == currentUserId && ft.TrackId == trackId);
        }

    }
}
