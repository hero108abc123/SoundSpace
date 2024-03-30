using soundspace.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Migrations.Operations;

namespace soundspace.Data
{
    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options)
        {
            
        }


        public DbSet<User> Users { get; set; }

        public DbSet<Artist> Artists { get; set; }

        public DbSet<Album> Albums { get; set; }

        public DbSet<Track> Tracks { get; set; }

        public DbSet<Playlist> Playlists { get; set; }

        public DbSet<Like> Likes { get; set; }
        public DbSet<TrackPlaylist> TrackPlaylists { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Like>()
                .HasKey(l => new { l.UserID, l.TrackID });
            modelBuilder.Entity<Like>()
                .HasOne(u => u.User)
                .WithMany(l => l.Likes)
                .HasForeignKey(u => u.UserID);
            modelBuilder.Entity<Like>()
                .HasOne(t => t.Track)
                .WithMany(l => l.Likes)
                .HasForeignKey(t => t.TrackID);


            modelBuilder.Entity<TrackPlaylist>()
               .HasKey(tp => new { tp.PlaylistID, tp.TrackID });
            modelBuilder.Entity<TrackPlaylist>()
                .HasOne(p => p.Playlist)
                .WithMany(tp => tp.TrackPlaylists)
                .HasForeignKey(p => p.PlaylistID);
            modelBuilder.Entity<TrackPlaylist>()
                .HasOne(t => t.Track)
                .WithMany(l => l.TrackPlaylists)
                .HasForeignKey(t => t.TrackID);

        }
    }
}
