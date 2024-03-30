namespace soundspace.Models
{
    public class Like
    {

        public int UserID { get; set; }

        public int TrackID { get; set; }

        public User User { get; set; }

        public Track Track { get; set; }
    }
}
