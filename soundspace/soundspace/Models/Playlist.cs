namespace soundspace.Models
{
    public class Playlist
    {
        public int PlaylistID { get; set; }

        public User User { get; set; }
        public String Title { get; set; }
        public DateTime CreationDate { get; set;}

        public ICollection<TrackPlaylist> TrackPlaylists { get; set; }
    }
}
