using Microsoft.EntityFrameworkCore;
using SoundSpace.Dbcontexts;
using SoundSpace.Dtos.Product.Playlist;
using SoundSpace.Dtos.Product.Song;
using SoundSpace.Entities.Product;
using SoundSpace.Exceptions;
using SoundSpace.Services.Interfaces.Product;
using SoundSpace.Utils;
using System.Diagnostics;

namespace SoundSpace.Services.Implements.Product
{
    public class PlaylistService : IPlaylistService
    {
        private readonly ILogger _logger;
        private readonly ApplicationDbContext _dbContext;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IPlaylistFollowService _playlistFollowService;
        private readonly ITrackPlaylistService _trackPlaylistService;
        private readonly IFavoriteTrackService _favoriteTrackService;

        public PlaylistService(ILogger<PlaylistService> logger, ApplicationDbContext dbContext, IHttpContextAccessor httpContextAccessor, IPlaylistFollowService playlistFollowService, ITrackPlaylistService trackPlaylistService, IFavoriteTrackService favoriteTrackService)
        {
            _logger = logger;
            _dbContext = dbContext;
            _httpContextAccessor = httpContextAccessor;
            _playlistFollowService = playlistFollowService;
            _trackPlaylistService = trackPlaylistService;
            _favoriteTrackService = favoriteTrackService;
        }

        public async Task CreatePlaylistAsync(AddPlaylistDto input)
        {
            int currentUserId = CommonUntils.GetCurrentUserId(_httpContextAccessor);

            var playlist = new Playlist
            {
                Title = input.Title,
                CreateBy = currentUserId,
                Image = string.Empty
            };

            _dbContext.Playlists.Add(playlist);
            await _dbContext.SaveChangesAsync();
        }

        public async Task UpdatePlaylistAsync(UpdatePlaylistDto input)
        {
            var playlist = await _dbContext.Playlists.Include(p => p.Tracks).FirstOrDefaultAsync(p => p.PlaylistId == input.PlaylistId);
            if (playlist == null)
            {
                throw new UserFriendlyException("Playlist not found");
            }

            playlist.Title = input.Title;
            await _dbContext.SaveChangesAsync();
        }

        public async Task DeletePlaylistAsync(int playlistId)
        {
            var playlist = await _dbContext.Playlists.Include(p => p.Tracks).FirstOrDefaultAsync(p => p.PlaylistId == playlistId);
            if (playlist == null)
            {
                throw new UserFriendlyException("Playlist not found");
            }
            _trackPlaylistService.RemoveAllTracksFromPlaylistAsync(playlistId);
            _dbContext.Playlists.Remove(playlist);
            await _dbContext.SaveChangesAsync();
        }

        public async Task<PlaylistDto> GetPlaylistAsync(int playlistId)
        {
            var playlist = await _dbContext.Playlists.FirstOrDefaultAsync(p => p.PlaylistId == playlistId);
            if (playlist == null)
            {
                throw new UserFriendlyException("Playlist not found");
            }

            var followerCount = await _playlistFollowService.GetFollowersCountAsync(playlistId);
            var trackCount = await _trackPlaylistService.GetTrackCountInPlaylistAsync(playlistId);

            return new PlaylistDto
            {
                Id = playlist.PlaylistId,
                Title = playlist.Title,
                CreateBy = playlist.User.DisplayName,
                Image = UploadFile.GetFileUrl(playlist.Image, _httpContextAccessor),
                Follower = followerCount,
                TrackCount = trackCount
            };
        }

        public async Task<List<PlaylistDto>> GetAllPlaylistsAsync()
        {
            var playlists = await _dbContext.Playlists
                .Include(p => p.User)
                .ToListAsync();
            if (playlists == null)
            {
                throw new UserFriendlyException("Playlist not found");
            }

            var playlistDtos = new List<PlaylistDto>();
            foreach (var playlist in playlists)
            {
                int followerCount = await _playlistFollowService.GetFollowersCountAsync(playlist.PlaylistId);
                int trackCount = await _trackPlaylistService.GetTrackCountInPlaylistAsync(playlist.PlaylistId);
                playlistDtos.Add(new PlaylistDto
                {
                    Id = playlist.PlaylistId,
                    Title = playlist.Title,
                    CreateBy = playlist.User.DisplayName,
                    Image = UploadFile.GetFileUrl(playlist.Image, _httpContextAccessor),
                    Follower = followerCount,
                    TrackCount = trackCount
                });
            }

            return playlistDtos;

            
        }


        public async Task<List<TrackDto>> GetTracksFromPlaylistAsync(int playlistId)
        {
            var tracks = await _dbContext.TrackPlaylists
                .Where(tp => tp.PlaylistId == playlistId)
                .Include(tp => tp.Track)
                .ThenInclude(t => t.Artist)
                .ToListAsync();
            if (tracks == null)
            {
                throw new UserFriendlyException("Track not found");
            }

            var trackDtos = new List<TrackDto>();
            foreach (var track in tracks)
            {
                int favoriteCount = await _favoriteTrackService.GetFavoriteCountAsync(track.TrackId);
                trackDtos.Add(new TrackDto
                {
                    TrackId = track.TrackId,
                    Title = track.Track.Title,
                    Artist = track.Track.Artist?.DisplayName ?? "Unknown", // Tránh lỗi null
                    Image = UploadFile.GetFileUrl(track.Track.Image, _httpContextAccessor),
                    Source = UploadFile.GetFileUrl(track.Track.Source, _httpContextAccessor),
                    Album = track.Track.Album,
                    Favorite = favoriteCount
                });
            }

            return trackDtos;
        }

        public async Task<List<PlaylistDto>> GetFollowedPlaylistsAsync()
        {
            var userId = CommonUntils.GetCurrentUserId(_httpContextAccessor);
            var playlists = await _dbContext.PlaylistFollows
                .Where(pf => pf.UserId == userId)
                .Include(pf => pf.Playlist)
                .ToListAsync();

            if (playlists == null)
            {
                throw new UserFriendlyException("Playlist not found");
            }

            var playlistDtos = new List<PlaylistDto>();
            foreach (var playlist in playlists)
            {
                int followerCount = await _playlistFollowService.GetFollowersCountAsync(playlist.PlaylistId);
                int trackCount = await _trackPlaylistService.GetTrackCountInPlaylistAsync(playlist.PlaylistId);
                playlistDtos.Add(new PlaylistDto
                {
                    Id = playlist.PlaylistId,
                    Title = playlist.Playlist.Title,
                    CreateBy = playlist.Playlist.User.DisplayName,
                    Image = UploadFile.GetFileUrl(playlist.Playlist.Image, _httpContextAccessor),
                    Follower = followerCount,
                    TrackCount = trackCount
                });
            }

            return playlistDtos;
        }

        public async Task<List<PlaylistDto>> GetUnfollowedPlaylistsAsync()
        {
            var userId = CommonUntils.GetCurrentUserId(_httpContextAccessor);
            var followedPlaylistIds = await _dbContext.PlaylistFollows
                .Where(pf => pf.UserId == userId)
                .Select(pf => pf.PlaylistId)
                .ToListAsync();



            var playlists = await _dbContext.Playlists
                .Where(p => !followedPlaylistIds.Contains(p.PlaylistId))
                .Include(p => p.User)
                .ToListAsync();

            if (playlists == null)
            {
                throw new UserFriendlyException("Playlist not found");
            }

            var playlistDtos = new List<PlaylistDto>();
            foreach (var playlist in playlists)
            {
                int followerCount = await _playlistFollowService.GetFollowersCountAsync(playlist.PlaylistId);
                int trackCount = await _trackPlaylistService.GetTrackCountInPlaylistAsync(playlist.PlaylistId);
                playlistDtos.Add(new PlaylistDto
                {
                    Id = playlist.PlaylistId,
                    Title = playlist.Title,
                    CreateBy = playlist.User.DisplayName,
                    Image = UploadFile.GetFileUrl(playlist.Image, _httpContextAccessor),
                    Follower = followerCount,
                    TrackCount = trackCount
                });
            }

            return playlistDtos;
        }

        public async Task<List<PlaylistDto>> GetOwnPlaylistsAsync()
        {
            var userId = CommonUntils.GetCurrentUserId(_httpContextAccessor);
            var playlists = await _dbContext.Playlists
                .Where(p => p.CreateBy == userId)
                .Include(p => p.User)
                .ToListAsync();

            if (playlists == null)
            {
                throw new UserFriendlyException("Playlist not found");
            }

            var playlistDtos = new List<PlaylistDto>();
            foreach (var playlist in playlists)
            {
                int followerCount = await _playlistFollowService.GetFollowersCountAsync(playlist.PlaylistId);
                int trackCount = await _trackPlaylistService.GetTrackCountInPlaylistAsync(playlist.PlaylistId);
                playlistDtos.Add(new PlaylistDto
                {
                    Id = playlist.PlaylistId,
                    Title = playlist.Title,
                    CreateBy = playlist.User.DisplayName,
                    Image = UploadFile.GetFileUrl(playlist.Image, _httpContextAccessor),
                    Follower = followerCount,
                    TrackCount = trackCount
                });
            }

            return playlistDtos;
        }

        public async Task<List<PlaylistDto>> GetPlaylistsByUserIdAsync(int userId)
        {
            var playlists = await _dbContext.Playlists
                .Where(p => p.CreateBy == userId)
                .Include(p => p.User)
                .ToListAsync();

            if (playlists == null)
            {
                throw new UserFriendlyException("Playlist not found");
            }

            var playlistDtos = new List<PlaylistDto>();
            foreach (var playlist in playlists)
            {
                int followerCount = await _playlistFollowService.GetFollowersCountAsync(playlist.PlaylistId);
                int trackCount = await _trackPlaylistService.GetTrackCountInPlaylistAsync(playlist.PlaylistId);
                playlistDtos.Add(new PlaylistDto
                {
                    Id = playlist.PlaylistId,
                    Title = playlist.Title,
                    CreateBy = playlist.User.DisplayName,
                    Image = UploadFile.GetFileUrl(playlist.Image, _httpContextAccessor),
                    Follower = followerCount,
                    TrackCount = trackCount
                });
            }

            return playlistDtos;
        }
        public async Task<List<PlaylistDto>> GetPlaylistsFromFollowingAsync()
        {
            int currentUserId = CommonUntils.GetCurrentUserId(_httpContextAccessor);

            // Lấy danh sách ID của những người mà user đang theo dõi
            var followingIds = await _dbContext.UserFollows
                .Where(uf => uf.FollowerId == currentUserId)
                .Select(uf => uf.FollowingId)
                .ToListAsync();

            // Lấy danh sách bài hát của những người đó
            var playlists = await _dbContext.Playlists
                .Where(p => followingIds.Contains(p.CreateBy)) // Chỉ lấy track của những người mình follow
                .ToListAsync();

            if (playlists == null)
            {
                throw new UserFriendlyException("Playlist not found");
            }

            var playlistDtos = new List<PlaylistDto>();
            foreach (var playlist in playlists)
            {
                int followerCount = await _playlistFollowService.GetFollowersCountAsync(playlist.PlaylistId);
                int trackCount = await _trackPlaylistService.GetTrackCountInPlaylistAsync(playlist.PlaylistId);
                playlistDtos.Add(new PlaylistDto
                {
                    Id = playlist.PlaylistId,
                    Title = playlist.Title,
                    CreateBy = playlist.User.DisplayName,
                    Image = UploadFile.GetFileUrl(playlist.Image, _httpContextAccessor),
                    Follower = followerCount,
                    TrackCount = trackCount
                });
            }

            return playlistDtos;
        }

        public async Task<List<PlaylistDto>> GetPlaylistsFromNotFollowingAsync()
        {
            int currentUserId = CommonUntils.GetCurrentUserId(_httpContextAccessor);

            // Lấy danh sách ID của những người mà user đang theo dõi
            var followingIds = await _dbContext.UserFollows
                .Where(uf => uf.FollowerId == currentUserId)
                .Select(uf => uf.FollowingId)
                .ToListAsync();

            // Lấy danh sách bài hát của những người user chưa follow
            var playlists = await _dbContext.Playlists
                .Where(p => !followingIds.Contains(p.CreateBy) && p.CreateBy != currentUserId) // Loại bỏ những người đã follow & chính user
                .ToListAsync();

            if (playlists == null)
            {
                throw new UserFriendlyException("Playlist not found");
            }

            var playlistDtos = new List<PlaylistDto>();
            foreach (var playlist in playlists)
            {
                int followerCount = await _playlistFollowService.GetFollowersCountAsync(playlist.PlaylistId);
                int trackCount = await _trackPlaylistService.GetTrackCountInPlaylistAsync(playlist.PlaylistId);
                playlistDtos.Add(new PlaylistDto
                {
                    Id = playlist.PlaylistId,
                    Title = playlist.Title,
                    CreateBy = playlist.User.DisplayName,
                    Image = UploadFile.GetFileUrl(playlist.Image, _httpContextAccessor),
                    Follower = followerCount,
                    TrackCount = trackCount
                });
            }

            return playlistDtos;
        }


    }
}
