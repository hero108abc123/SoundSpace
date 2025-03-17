using Microsoft.EntityFrameworkCore;
using SoundSpace.Dbcontexts;
using SoundSpace.Entities.Product;
using SoundSpace.Exceptions;
using SoundSpace.Services.Interfaces.Product;
using SoundSpace.Utils;

namespace SoundSpace.Services.Implements.Product
{
    public class PlaylistFollowService : IPlaylistFollowService
    {
        private readonly ILogger _logger;
        private readonly ApplicationDbContext _dbContext;
        private readonly IHttpContextAccessor _httpContextAccessor;
        public PlaylistFollowService(ILogger<PlaylistFollowService> logger, ApplicationDbContext dbContext, IHttpContextAccessor httpContextAccessor)
        {
            _dbContext = dbContext;
            _logger = logger;
            _httpContextAccessor = httpContextAccessor;
        }

        // Theo dõi Playlist
        public async Task FollowPlaylistAsync(int playlistId)
        {
            int currentUserId = CommonUntils.GetCurrentUserId(_httpContextAccessor);

            var existingFollow = await _dbContext.PlaylistFollows
                .FirstOrDefaultAsync(pf => pf.UserId == currentUserId && pf.PlaylistId == playlistId);

            if (existingFollow != null)
            {
                throw new UserFriendlyException("Bạn đã theo dõi playlist này!");
            }

            var newFollow = new PlaylistFollow
            {
                UserId = currentUserId,
                PlaylistId = playlistId
            };

            await _dbContext.PlaylistFollows.AddAsync(newFollow);
            await _dbContext.SaveChangesAsync();
        }

        // Bỏ theo dõi Playlist
        public async Task UnfollowPlaylistAsync(int playlistId)
        {
            int currentUserId = CommonUntils.GetCurrentUserId(_httpContextAccessor);

            var existingFollow = await _dbContext.PlaylistFollows
                .FirstOrDefaultAsync(pf => pf.UserId == currentUserId && pf.PlaylistId == playlistId);

            if (existingFollow == null)
            {
                throw new UserFriendlyException("Bạn chưa theo dõi playlist này!");
            }

            _dbContext.PlaylistFollows.Remove(existingFollow);
            await _dbContext.SaveChangesAsync();
        }

        // Đếm số người theo dõi Playlist
        public async Task<int> GetFollowersCountAsync(int playlistId)
        {
            return await _dbContext.PlaylistFollows.CountAsync(pf => pf.PlaylistId == playlistId);
        }
    }
}
