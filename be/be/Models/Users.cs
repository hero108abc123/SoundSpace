﻿namespace be.Models
{
    public class Users
    {
        public int UserID { get; set; }

        public String Email { get; set; }

        public string Password { get; set; }

        public string DisplayName { get; set; }

        public int Age { get; set; }

        public string Gender { get; set; }

        public ICollection<Playlist> Playlists { get; set; }
        public ICollection<Likes> Likes { get; set; }
    }
}