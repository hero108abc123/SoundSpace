using SoundSpace.Entities.Auth;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SoundSpace.Entities.Product

{
    public class Track
    {

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int TrackId { get; set; }
        public string Title { get; set; }
        public string Image { get; set; }
        public string Source { get; set; }
        public string Album { get; set; }
        public string Lyric { get; set; }

        // Mối quan hệ 1-1 với User (người đăng bài hát)
        [ForeignKey("User")]
        public int ArtistId { get; set; }
        public User Artist { get; set; }

        public ICollection<TrackPlaylist> Playlists { get; set; } = new List<TrackPlaylist>();

        public ICollection<FavoriteTrack> Favorite { get; set; } = new List<FavoriteTrack>();



    }
}
