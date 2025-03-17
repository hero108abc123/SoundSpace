namespace SoundSpace.Services.Interfaces.Product
{
    public interface IPlaylistFollowService
    {
        Task FollowPlaylistAsync(int playlistId);
        Task UnfollowPlaylistAsync(int playlistId);
        Task<int> GetFollowersCountAsync(int playlistId);
    }
}
