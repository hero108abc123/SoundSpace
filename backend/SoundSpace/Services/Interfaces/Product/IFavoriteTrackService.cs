namespace SoundSpace.Services.Interfaces.Product
{
    public interface IFavoriteTrackService
    {
        Task AddFavoriteTrackAsync(int trackId);
        Task RemoveFavoriteTrackAsync(int trackId);
        Task<int> GetFavoriteCountAsync(int trackId);
    }
}
