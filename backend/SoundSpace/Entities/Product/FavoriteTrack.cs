using SoundSpace.Entities.Auth;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace SoundSpace.Entities.Product
{
    public class FavoriteTrack
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        // Mối quan hệ với User
        [ForeignKey("User")]
        public int UserId { get; set; }
        public User User { get; set; }

        // Mối quan hệ với Track
        [ForeignKey("Track")]
        public int TrackId { get; set; }
        public Track Track { get; set; }
    }
}
