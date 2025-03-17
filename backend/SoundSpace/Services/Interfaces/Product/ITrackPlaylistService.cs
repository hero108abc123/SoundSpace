using SoundSpace.Dtos.Product.Playlist;

namespace SoundSpace.Services.Interfaces.Product
{
    public interface ITrackPlaylistService
    {
        Task AddTrackToPlaylistAsync(int trackId, int playlistId);
        Task RemoveTrackFromPlaylistAsync(int trackId, int playlistId);
        Task RemoveAllTracksFromPlaylistAsync(int playlistId);
        Task<int> GetTrackCountInPlaylistAsync(int playlistId);
        

    }
}
