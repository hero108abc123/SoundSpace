namespace be.Models
{
    public class Playlist
    {
        public int PlaylistID { get; set; }

        public Users User { get; set; }
        public String Title { get; set; }
        public DateTime CreationDate { get; set;}

        public ICollection<TrackPlaylist> TrackPlaylist { get; }
    }
}
