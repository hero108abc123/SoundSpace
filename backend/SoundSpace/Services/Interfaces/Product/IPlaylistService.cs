using SoundSpace.Dtos.Product.Playlist;
using SoundSpace.Dtos.Product.Song;

namespace SoundSpace.Services.Interfaces.Product
{
    public interface IPlaylistService
    {
        Task CreatePlaylistAsync(AddPlaylistDto input);
        Task DeletePlaylistAsync(int playlistId);
        Task UpdatePlaylistAsync(UpdatePlaylistDto input);
        Task<PlaylistDto> GetPlaylistAsync(int playlistId);
        Task<List<PlaylistDto>> GetAllPlaylistsAsync();
        Task<List<TrackDto>> GetTracksFromPlaylistAsync(int playlistId);
        Task<List<PlaylistDto>> GetUnfollowedPlaylistsAsync();
        Task<List<PlaylistDto>> GetFollowedPlaylistsAsync();
        Task<List<PlaylistDto>> GetPlaylistsByUserIdAsync(int userId);
        Task<List<PlaylistDto>> GetOwnPlaylistsAsync();
        Task<List<PlaylistDto>> GetPlaylistsFromFollowingAsync();
        Task<List<PlaylistDto>> GetPlaylistsFromNotFollowingAsync();


    }
}
