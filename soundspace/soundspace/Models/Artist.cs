namespace soundspace.Models
{
    public class Artist
    {
        public int ArtistID { get; set; }

        public string Name { get; set; }

        public string Genre { get; set; }

        public ICollection<Track> Tracks { get; set; }
    }
}
