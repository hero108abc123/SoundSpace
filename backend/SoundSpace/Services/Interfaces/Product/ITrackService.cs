using SoundSpace.Dtos.Product.Song;
using System.Threading.Tasks;

namespace SoundSpace.Services.Interfaces.Product
{
    public interface ITrackService
    {
        Task CreateTrackAsync(AddTrackDto input);
        Task DeleteTrackAsync(int trackId);
        Task UpdateTrackAsync(UpdateTrackDto input);
        Task<TrackDto> GetTrackAsync(int trackId);
        Task<List<TrackDto>> GetAllTracksAsync();

        Task<ArtistDto> GetArtistByTrackAsync(int trackId);

        Task<List<TrackDto>> GetTracksFromFollowingAsync();

        Task<List<TrackDto>> GetTracksFromNotFollowingAsync();
        Task<List<TrackDto>> GetFavoriteTracksAsync();
        Task<List<TrackDto>> GetUnfavoritedTracksAsync();
        Task<List<TrackDto>> GetMyTracksAsync();
        Task<List<TrackDto>> GetTracksByUserIdAsync(int userId);
    }
}
