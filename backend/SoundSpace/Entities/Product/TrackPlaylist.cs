using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SoundSpace.Entities.Product
{
    public class TrackPlaylist
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        [ForeignKey("Playlist")]
        public int PlaylistId { get; set; }
        public Playlist Playlist { get; set; }
        [ForeignKey("Track")]
        public int TrackId { get; set; }
        public Track Track { get; set; }
    }

}
