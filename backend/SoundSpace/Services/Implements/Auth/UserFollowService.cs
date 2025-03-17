using Microsoft.EntityFrameworkCore;
using SoundSpace.Dbcontexts;
using SoundSpace.Dtos.Product.Song;
using SoundSpace.Entities.Auth;
using SoundSpace.Exceptions;
using SoundSpace.Services.Interfaces.Auth;
using SoundSpace.Utils;

namespace SoundSpace.Services.Implements.Auth
{
    public class UserFollowService : IUserFollowService
    {
        private readonly ILogger _logger;
        private readonly ApplicationDbContext _dbContext;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public UserFollowService(ILogger<UserFollowService> logger, ApplicationDbContext dbContext, IHttpContextAccessor httpContextAccessor)
        {
            _dbContext = dbContext;
            _logger = logger;
            _httpContextAccessor = httpContextAccessor;
        }

        public async Task FollowUserAsync(int targetUserId)
        {
            int currentUserId = CommonUntils.GetCurrentUserId(_httpContextAccessor);

            if (currentUserId == targetUserId)
            {
                throw new UserFriendlyException("Bạn không thể theo dõi chính mình!");
            }

            bool alreadyFollowing = await _dbContext.UserFollows.AnyAsync(uf => uf.FollowerId == currentUserId && uf.FollowingId == targetUserId);

            if (alreadyFollowing)
            {
                throw new UserFriendlyException("Bạn đã theo dõi người này!");
            }

            var follow = new UserFollow
            {
                FollowerId = currentUserId,
                FollowingId = targetUserId
            };

            await _dbContext.UserFollows.AddAsync(follow);
            await _dbContext.SaveChangesAsync();
        }

        public async Task UnfollowUserAsync(int targetUserId)
        {
            int currentUserId = CommonUntils.GetCurrentUserId(_httpContextAccessor);

            var follow = await _dbContext.UserFollows
                .FirstOrDefaultAsync(uf => uf.FollowerId == currentUserId && uf.FollowingId == targetUserId);

            if (follow == null)
            {
                throw new UserFriendlyException("Bạn chưa theo dõi người này!");
            }

            _dbContext.UserFollows.Remove(follow);
            await _dbContext.SaveChangesAsync();
        }

        public async Task<int> GetFollowersCountAsync(int userId)
        {
            return await _dbContext.UserFollows.CountAsync(uf => uf.FollowingId == userId);
        }

        public async Task<int> GetFollowingCountAsync(int userId)
        {
            return await _dbContext.UserFollows.CountAsync(uf => uf.FollowerId == userId);
        }

        public async Task<List<ArtistDto>> GetUnfollowedArtistsAsync()
        {
            int currentUserId = CommonUntils.GetCurrentUserId(_httpContextAccessor);

            // Lấy danh sách ID của các nghệ sĩ mà user đã theo dõi
            var followedArtistIds = await _dbContext.UserFollows
                .Where(uf => uf.FollowerId == currentUserId)
                .Select(uf => uf.FollowingId)
                .ToListAsync();

            // Lấy danh sách nghệ sĩ chưa được theo dõi (ngoại trừ chính user)
            var artists = await _dbContext.Users
                .Where(u => !followedArtistIds.Contains(u.UserId) && u.UserId != currentUserId)
                .ToListAsync();

            // Lấy số lượng followers và following bằng cách chạy song song các task
            var artistDtos = await Task.WhenAll(artists.Select(async u => new ArtistDto
            {
                Id = u.UserId,
                DisplayName = u.DisplayName,
                Image = UploadFile.GetFileUrl(u.Image, _httpContextAccessor),
                FollowersCount = await GetFollowersCountAsync(u.UserId),
                FollowingCount = await GetFollowingCountAsync(u.UserId)
            }));

            return artistDtos.ToList();
        }

        public async Task<List<ArtistDto>> GetFollowedArtistsAsync()
        {
            int currentUserId = CommonUntils.GetCurrentUserId(_httpContextAccessor);

            // Lấy danh sách ID của các nghệ sĩ mà user đang theo dõi
            var followedArtistIds = await _dbContext.UserFollows
                .Where(uf => uf.FollowerId == currentUserId)
                .Select(uf => uf.FollowingId)
                .ToListAsync();

            // Lấy danh sách thông tin nghệ sĩ đã theo dõi
            var artists = await _dbContext.Users
                .Where(u => followedArtistIds.Contains(u.UserId))
                .ToListAsync();

            // Lấy số lượng followers và following bằng cách chạy so  u => new ArtistDto
            var artistDtos = await Task.WhenAll(artists.Select(async u => new ArtistDto
            {
                Id = u.UserId,
                DisplayName = u.DisplayName,
                Image = UploadFile.GetFileUrl(u.Image, _httpContextAccessor),
                FollowersCount = await GetFollowersCountAsync(u.UserId),
                FollowingCount = await GetFollowingCountAsync(u.UserId)
            }));

            return artistDtos.ToList();
        }


    }

}
