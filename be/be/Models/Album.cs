﻿namespace be.Models
{
    public class Album
    {
        public int AlbumID { get; set; }

        public string Title { get; set; }

        public Artist ArtistID { get; set; }

        public string Genre { get; set;}

        public DateTime ReleaseDate { get; set; }

        public ICollection<Track> Tracks { get; set; }
    }
}