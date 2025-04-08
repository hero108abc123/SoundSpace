using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SoundSpace.Entities.Auth
{
    public class RevokedToken
    {
        [Key]
        public int Id { get; set; }
        [Required]
        public string Token { get; set; }
        [Required]
        public DateTime RevokedAt { get; set; }

        // 🔥 Thêm khóa ngoại (Foreign Key)
        [Required]
        public int AccountId { get; set; }

        [ForeignKey("AccountId")]
        public Account Account { get; set; }
    }
}
