using SoundSpace.Entities.Product;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SoundSpace.Entities.Auth
{
    public class User
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int UserId { get; set; }

        public string DisplayName { get; set; }

        public int Age { get; set; }

        public string Gender { get; set; }

        public string Image { get; set; }

        public ICollection<Playlist> Playlists { get; set; } = new List<Playlist>();

        // Danh sách người đang theo dõi User này
        public ICollection<UserFollow> Followers { get; set; } = new List<UserFollow>();

        // Danh sách người User này đang theo dõi
        public ICollection<UserFollow> Following { get; set; } = new List<UserFollow>();
        // Danh sách bài hát do User đăng
        public ICollection<Track> Tracks { get; set; } = new List<Track>();

        public ICollection<FavoriteTrack> FavoriteTracks { get; set; } = new List<FavoriteTrack>();

        public ICollection<PlaylistFollow> PlaylistFollows { get; set; } = new List<PlaylistFollow>();

    }
}
