using System.ComponentModel.DataAnnotations;

namespace SoundSpace.Dtos.Product.Song
{
    public class UpdateTrackDto
    {
        public int  Id{ get; set; }
        private string _title;
        [StringLength(30, ErrorMessage = "Track title must be between 3 and 30 characters long.", MinimumLength = 3)]
        public string Title
        {
            get => _title;
            set => _title = value?.Trim();
        }

        [Required(ErrorMessage = "Track image is required.")]
        public IFormFile Image { get; set; }  // Hỗ trợ upload file ảnh

        [Required(ErrorMessage = "Track source (MP3) is required.")]
        public IFormFile Source { get; set; }

        private string _album;
        [StringLength(30, ErrorMessage = "Album must be between 3 and 30 characters long.", MinimumLength = 3)]
        public string Album
        {
            get => _album;
            set => _album = value?.Trim();
        }

        private string _lyric;
        [Required]
        public string Lyric
        {
            get => _lyric;
            set => _lyric = value?.Trim();
        }
    }
}
