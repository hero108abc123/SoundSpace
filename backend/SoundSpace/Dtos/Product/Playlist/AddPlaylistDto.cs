using System.ComponentModel.DataAnnotations;

namespace SoundSpace.Dtos.Product.Playlist
{
    public class AddPlaylistDto
    {
        private string _title;
        [Required]
        [StringLength(30, ErrorMessage = "Playlist title must be between 3 and 30 characters long.", MinimumLength = 3)]
        public string Title
        {
            get => _title;
            set => _title = value?.Trim();
        }
    }
}
