using Microsoft.EntityFrameworkCore;
using SoundSpace.Dbcontexts;
using SoundSpace.Dtos.Auth.UserDtos;
using SoundSpace.Dtos.Product.Song;
using SoundSpace.Entities.Product;
using SoundSpace.Exceptions;
using SoundSpace.Services.Interfaces.Auth;
using SoundSpace.Services.Interfaces.Product;
using SoundSpace.Utils;

namespace SoundSpace.Services.Implements.Product
{
    public class TrackService : ITrackService
    {
        private readonly ILogger _logger;
        private readonly ApplicationDbContext _dbContext;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IFavoriteTrackService _favoriteTrackService;
        private readonly IUserFollowService _userFollowService;

        public TrackService(ILogger<TrackService> logger, ApplicationDbContext dbContext, IHttpContextAccessor httpContextAccessor, IFavoriteTrackService favoriteTrackService, IUserFollowService userFollowService)
        {
            _dbContext = dbContext;
            _logger = logger;
            _httpContextAccessor = httpContextAccessor;
            _favoriteTrackService = favoriteTrackService;
            _userFollowService = userFollowService;
        }

        public async Task CreateTrackAsync(AddTrackDto input)
        {
            if (_dbContext.Tracks.Any(t => t.Title == input.Title))
            {
                throw new UserFriendlyException($"Track \"{input.Title}\" already exists");
            }

            int currentUserId = CommonUntils.GetCurrentUserId(_httpContextAccessor);

            var currentUser = await _dbContext.Users
                .Where(u => u.UserId == currentUserId)
                .Select(u => u.DisplayName)
                .FirstOrDefaultAsync();


            string imagePath = null;
            string audioPath = null;

            if (input.Image != null)
            {
                imagePath = await UploadFile.SaveFileAsync(input.Image, "Tracks", "Images");
            }

            if (input.Source != null)
            {
                audioPath = await UploadFile.SaveFileAsync(input.Source, "Tracks", "Source");
            }


            var track = _dbContext.Tracks.Add(new Track
            {
                Title = input.Title,
                ArtistId = currentUserId,
                Image = imagePath,
                Source = audioPath,
                Album = input.Album,
            });
            await _dbContext.SaveChangesAsync();
        }

        public async Task DeleteTrackAsync(int trackId)
        {
            var track = await _dbContext.Tracks.FirstOrDefaultAsync(t => t.TrackId == trackId);
            if (track != null)
            {
                UploadFile.DeleteFile(track.Image, "Tracks", "Images");
                UploadFile.DeleteFile(track.Source, "Tracks", "Sources");

                _dbContext.Tracks.Remove(track);
                await _dbContext.SaveChangesAsync();
            }
            else
            {
                throw new UserFriendlyException("Track not found");
            }
        }

        public async Task UpdateTrackAsync(UpdateTrackDto input)
        {
            string imagePath = null;
            string audioPath = null;

            if (input.Image != null)
            {
                imagePath = await UploadFile.SaveFileAsync(input.Image, "Tracks", "Images");
            }

            if (input.Source != null)
            {
                audioPath = await UploadFile.SaveFileAsync(input.Source, "Tracks", "Sources");
            }

            var track = await _dbContext.Tracks.FirstOrDefaultAsync(t => t.TrackId == input.Id);
            if (track != null)
            {
                if (await _dbContext.Tracks
                    .AnyAsync(t => t.Title == input.Title && t.TrackId != input.Id))
                {
                    throw new UserFriendlyException("Track already exists");
                }

                UploadFile.DeleteFile(track.Image, "Tracks", "Images");
                UploadFile.DeleteFile(track.Source, "Tracks", "Sources");

                track.Title = input.Title;
                track.Image = imagePath;
                track.Source = audioPath;
                track.Album = input.Album;
                await _dbContext.SaveChangesAsync();
            }
            else
            {
                throw new UserFriendlyException("Track not found");
            }
        }

        public async Task<TrackDto> GetTrackAsync(int trackId)
        {
            var track = await _dbContext.Tracks.Include(t => t.Artist).FirstOrDefaultAsync(t => t.TrackId == trackId);
            if (track == null)
            {
                throw new UserFriendlyException("Track not found");
            }
            int favoriteCount = await _favoriteTrackService.GetFavoriteCountAsync(trackId);
            return new TrackDto
            {
                TrackId = track.TrackId,
                Title = track.Title,
                Artist = track.Artist.DisplayName,
                Image = UploadFile.GetFileUrl(track.Image, _httpContextAccessor),
                Source = UploadFile.GetFileUrl(track.Source, _httpContextAccessor),
                Album = track.Album,
                Favorite = favoriteCount
            };
        }

        public async Task<List<TrackDto>> GetAllTracksAsync()
        {
            var tracks = await _dbContext.Tracks
                .Include(t => t.Artist)
                .ToListAsync();

            var trackDtos = new List<TrackDto>();
            foreach (var track in tracks)
            {
                int favoriteCount = await _favoriteTrackService.GetFavoriteCountAsync(track.TrackId);
                trackDtos.Add(new TrackDto
                {
                    TrackId = track.TrackId,
                    Title = track.Title,
                    Artist = track.Artist.DisplayName,
                    Image = UploadFile.GetFileUrl(track.Image, _httpContextAccessor),
                    Source = UploadFile.GetFileUrl(track.Source, _httpContextAccessor),
                    Album = track.Album,
                    Favorite = favoriteCount
                });
            }

            return trackDtos;
        }

        public async Task<ArtistDto> GetArtistByTrackAsync(int trackId)
        {
            var track = await _dbContext.Tracks
                .Include(t => t.Artist)
                .FirstOrDefaultAsync(t => t.TrackId == trackId);

            if (track?.Artist == null)
            {
                throw new UserFriendlyException("Track or Artist not found");
            }

            // Lấy số lượng followers và following song song để tối ưu tốc độ
            var followersTask = await _userFollowService.GetFollowersCountAsync(track.Artist.UserId);
            var followingTask = await _userFollowService.GetFollowingCountAsync(track.Artist.UserId);

            return new ArtistDto
            {
                Id = track.Artist.UserId,
                DisplayName = track.Artist.DisplayName,
                Image = UploadFile.GetFileUrl(track.Artist.Image, _httpContextAccessor),
                FollowersCount = followersTask,
                FollowingCount = followingTask
            };
        }


        public async Task<List<TrackDto>> GetTracksFromFollowingAsync()
        {
            int currentUserId = CommonUntils.GetCurrentUserId(_httpContextAccessor);

            var followingIds = await _dbContext.UserFollows
                .Where(uf => uf.FollowerId == currentUserId)
                .Select(uf => uf.FollowingId)
                .ToListAsync();

            var tracks = await _dbContext.Tracks
                .Where(t => followingIds.Contains(t.ArtistId))
                .Include(t => t.Artist) // Ensure Artist is included
                .ToListAsync();

            var trackDtos = new List<TrackDto>();
            foreach (var track in tracks)
            {
                int favoriteCount = await _favoriteTrackService.GetFavoriteCountAsync(track.TrackId);
                trackDtos.Add(new TrackDto
                {
                    TrackId = track.TrackId,
                    Title = track.Title,
                    Artist = track.Artist.DisplayName,
                    Image = UploadFile.GetFileUrl(track.Image, _httpContextAccessor),
                    Source = UploadFile.GetFileUrl(track.Source, _httpContextAccessor),
                    Album = track.Album,
                    Favorite = favoriteCount
                });
            }

            return trackDtos;
        }

        public async Task<List<TrackDto>> GetTracksFromNotFollowingAsync()
        {
            int currentUserId = CommonUntils.GetCurrentUserId(_httpContextAccessor);

            var followingIds = await _dbContext.UserFollows
                .Where(uf => uf.FollowerId == currentUserId)
                .Select(uf => uf.FollowingId)
                .ToListAsync();

            var tracks = await _dbContext.Tracks
                .Where(t => !followingIds.Contains(t.ArtistId) && t.ArtistId != currentUserId)
                .Include(t => t.Artist) // Ensure Artist is included
                .ToListAsync();

            var trackDtos = new List<TrackDto>();
            foreach (var track in tracks)
            {
                int favoriteCount = await _favoriteTrackService.GetFavoriteCountAsync(track.TrackId);
                trackDtos.Add(new TrackDto
                {
                    TrackId = track.TrackId,
                    Title = track.Title,
                    Artist = track.Artist.DisplayName,
                    Image = UploadFile.GetFileUrl(track.Image, _httpContextAccessor),
                    Source = UploadFile.GetFileUrl(track.Source, _httpContextAccessor),
                    Album = track.Album,
                    Favorite = favoriteCount
                });
            }

            return trackDtos;
        }

        public async Task<List<TrackDto>> GetFavoriteTracksAsync()
        {
            int currentUserId = CommonUntils.GetCurrentUserId(_httpContextAccessor);

            var favoriteTracks = await _dbContext.FavoriteTracks
                .Where(ft => ft.UserId == currentUserId)
                .Include(ft => ft.Track)
                .ThenInclude(t => t.Artist)
                .ToListAsync();

            var trackDtos = new List<TrackDto>();
            foreach (var ft in favoriteTracks)
            {
                int favoriteCount = await _favoriteTrackService.GetFavoriteCountAsync(ft.Track.TrackId);
                trackDtos.Add(new TrackDto
                {
                    TrackId = ft.Track.TrackId,
                    Title = ft.Track.Title,
                    Artist = ft.Track.Artist.DisplayName,
                    Image = UploadFile.GetFileUrl(ft.Track.Image, _httpContextAccessor),
                    Source = UploadFile.GetFileUrl(ft.Track.Source, _httpContextAccessor),
                    Album = ft.Track.Album,
                    Favorite = favoriteCount
                });
            }

            return trackDtos;
        }

        public async Task<List<TrackDto>> GetMyTracksAsync()
        {
            int currentUserId = CommonUntils.GetCurrentUserId(_httpContextAccessor);

            var tracks = await _dbContext.Tracks
                .Where(t => t.ArtistId == currentUserId)
                .Include(t => t.Artist) // Ensure Artist is included
                .ToListAsync();

            var trackDtos = new List<TrackDto>();
            foreach (var track in tracks)
            {
                int favoriteCount = await _favoriteTrackService.GetFavoriteCountAsync(track.TrackId);
                trackDtos.Add(new TrackDto
                {
                    TrackId = track.TrackId,
                    Title = track.Title,
                    Artist = track.Artist.DisplayName,
                    Image = UploadFile.GetFileUrl(track.Image, _httpContextAccessor),
                    Source = UploadFile.GetFileUrl(track.Source, _httpContextAccessor),
                    Album = track.Album,
                    Favorite = favoriteCount
                });
            }

            return trackDtos;
        }

        public async Task<List<TrackDto>> GetTracksByUserIdAsync(int userId)
        {
            var tracks = await _dbContext.Tracks
                .Where(t => t.ArtistId == userId)
                .Include(t => t.Artist) // Ensure Artist is included
                .ToListAsync();

            var trackDtos = new List<TrackDto>();
            foreach (var track in tracks)
            {
                int favoriteCount = await _favoriteTrackService.GetFavoriteCountAsync(track.TrackId);
                trackDtos.Add(new TrackDto
                {
                    TrackId = track.TrackId,
                    Title = track.Title,
                    Artist = track.Artist.DisplayName,
                    Image = UploadFile.GetFileUrl(track.Image, _httpContextAccessor),
                    Source = UploadFile.GetFileUrl(track.Source, _httpContextAccessor),
                    Album = track.Album,
                    Favorite = favoriteCount
                });
            }

            return trackDtos;
        }

        public async Task<List<TrackDto>> GetUnfavoritedTracksAsync()
        {
            int currentUserId = CommonUntils.GetCurrentUserId(_httpContextAccessor);

            // Lấy danh sách ID bài hát đã được yêu thích
            var favoriteTrackIds = await _dbContext.FavoriteTracks
                .Where(ft => ft.UserId == currentUserId)
                .Select(ft => ft.TrackId)
                .ToListAsync();

            // Lấy danh sách bài hát chưa có trong danh sách yêu thích
            var tracks = await _dbContext.Tracks
                .Where(t => !favoriteTrackIds.Contains(t.TrackId)) // Lọc các bài hát chưa được yêu thích
                .Include(t => t.Artist) // Đảm bảo truy xuất dữ liệu Artist
                .ToListAsync();

            // Fetch favorite counts asynchronously
            var trackDtos = new List<TrackDto>();
            foreach (var track in tracks)
            {
                int favoriteCount = await _favoriteTrackService.GetFavoriteCountAsync(track.TrackId);
                trackDtos.Add(new TrackDto
                {
                    TrackId = track.TrackId,
                    Title = track.Title,
                    Artist = track.Artist?.DisplayName ?? "Unknown", // Tránh lỗi null
                    Image = UploadFile.GetFileUrl(track.Image, _httpContextAccessor),
                    Source = UploadFile.GetFileUrl(track.Source, _httpContextAccessor),
                    Album = track.Album,
                    Favorite = favoriteCount
                });
            }

            return trackDtos;
        }

    }
}
