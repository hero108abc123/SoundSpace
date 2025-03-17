using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace SoundSpace.Entities.Auth
{
    public class UserFollow
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        [ForeignKey("Follower")]
        public int FollowerId { get; set; }
        public User Follower { get; set; } // Người đang theo dõi

        [ForeignKey("Following")]
        public int FollowingId { get; set; }
        public User Following { get; set; } // Người được theo dõi
    }
}
