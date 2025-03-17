using Microsoft.EntityFrameworkCore;
using SoundSpace.Dbcontexts;
using SoundSpace.Entities.Product;
using SoundSpace.Exceptions;
using SoundSpace.Services.Interfaces.Product;
using SoundSpace.Utils;

namespace SoundSpace.Services.Implements.Product
{
    public class TrackPlaylistService : ITrackPlaylistService
    {
        private readonly ApplicationDbContext _dbContext;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public TrackPlaylistService(ApplicationDbContext dbContext, IHttpContextAccessor httpContextAccessor)
        {
            _dbContext = dbContext;
            _httpContextAccessor = httpContextAccessor;
        }

        public async Task AddTrackToPlaylistAsync(int playlistId, int trackId)
        {
            var playlist = await _dbContext.Playlists.Include(p => p.Tracks).FirstOrDefaultAsync(p => p.PlaylistId == playlistId);
            if (playlist == null)
            {
                throw new UserFriendlyException("Playlist not found");
            }

            var track = await _dbContext.Tracks.FirstOrDefaultAsync(t => t.TrackId == trackId);
            if (track == null)
            {
                throw new UserFriendlyException("Track not found");
            }

            if (!playlist.Tracks.Any(t => t.TrackId == trackId))
            {
                playlist.Tracks.Add(new TrackPlaylist { PlaylistId = playlistId, TrackId = trackId });
                if (playlist.Image == null)
                {
                    playlist.Image = track.Image;
                }
                await _dbContext.SaveChangesAsync();
            }
        }

        public async Task RemoveTrackFromPlaylistAsync(int playlistId, int trackId)
        {
            var playlist = await _dbContext.Playlists.Include(p => p.Tracks).FirstOrDefaultAsync(p => p.PlaylistId == playlistId);
            if (playlist == null)
            {
                throw new UserFriendlyException("Playlist not found");
            }

            var trackToRemove = playlist.Tracks.FirstOrDefault(t => t.TrackId == trackId);
            if (trackToRemove == null)
            {
                throw new UserFriendlyException("Track not found in playlist");
            }

            _dbContext.TrackPlaylists.Remove(trackToRemove);
            await _dbContext.SaveChangesAsync();

            if (playlist.Tracks.Any())
            {
                var newFirstTrack = await _dbContext.TrackPlaylists
                    .Where(tp => tp.PlaylistId == playlistId)
                    .OrderBy(tp => tp.TrackId) // Assuming TrackId represents order
                    .Select(tp => tp.Track.Image)
                    .FirstOrDefaultAsync();
                playlist.Image = newFirstTrack;
            }
            else
            {
                playlist.Image = null;
            }
            await _dbContext.SaveChangesAsync();
        }

        public async Task RemoveAllTracksFromPlaylistAsync(int playlistId)
        {
            var playlist = await _dbContext.Playlists.Include(p => p.Tracks).FirstOrDefaultAsync(p => p.PlaylistId == playlistId);
            if (playlist == null)
            {
                throw new UserFriendlyException("Playlist not found");
            }

            _dbContext.TrackPlaylists.RemoveRange(playlist.Tracks);
            playlist.Image = null;
            await _dbContext.SaveChangesAsync();
        }

        public async Task<int> GetTrackCountInPlaylistAsync(int playlistId)
        {
            return await _dbContext.TrackPlaylists.CountAsync(tp => tp.PlaylistId == playlistId);
        }
    }
}
