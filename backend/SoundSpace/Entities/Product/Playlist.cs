using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using SoundSpace.Entities.Auth;

namespace SoundSpace.Entities.Product
{
    public class Playlist
    {

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int PlaylistId { get; set; }
        public string Title { get; set; }
        public string Image { get; set; }
        public ICollection<TrackPlaylist> Tracks { get; set; } = new List<TrackPlaylist>();

        public ICollection<PlaylistFollow> Followers { get; set; } = new List<PlaylistFollow>();

        [ForeignKey("User")]
        public int CreateBy { get; set; }
        public User User { get; set; }
    }
}
