namespace be.Models
{
    public class TrackPlaylist
    {

        public int TrackID { get; set; }

        public int PlaylistID { get; set;}

        public Playlist Playlist { get; set;}

        public Track Track { get; set; }
    }
}
