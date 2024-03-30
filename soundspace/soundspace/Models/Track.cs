namespace soundspace.Models
{
    public class Track
    {
        public int TrackID { get; set; }

        public string Title { get; set; }

        public Artist Artist { get; set; }

        public Album Album { get; set; }

        public TimeOnly Duration { get; set; }
        public DateTime ReleaseDate { get; set;}

        public ICollection<Like> Likes { get; set; }

        public ICollection<TrackPlaylist> TrackPlaylists { get; set; }
    }
}
