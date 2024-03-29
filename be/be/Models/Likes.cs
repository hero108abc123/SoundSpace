namespace be.Models
{
    public class Likes
    {

        public int UserID { get; set; }

        public int TrackID { get; set; }

        public Users User { get; set; }

        public Track Track { get; set; }
    }
}
