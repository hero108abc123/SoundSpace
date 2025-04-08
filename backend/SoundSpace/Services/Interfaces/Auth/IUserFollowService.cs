using SoundSpace.Dtos.Product.Song;

namespace SoundSpace.Services.Interfaces.Auth
{
    public interface IUserFollowService
    {
        Task FollowUserAsync(int targetUserId);
        Task UnfollowUserAsync(int targetUserId);
        Task<int> GetFollowersCountAsync(int userId);
        Task<int> GetFollowingCountAsync(int userId);
        Task<List<ArtistDto>> GetFollowedArtistsAsync();
        Task<List<ArtistDto>> GetUnfollowedArtistsAsync();
        Task<List<ArtistDto>> GetFollowersAsync();

    }
}
