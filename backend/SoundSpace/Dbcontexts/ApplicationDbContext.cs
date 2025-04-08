using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure.Internal;
using SoundSpace.Entities.Auth;
using SoundSpace.Entities.Product;

namespace SoundSpace.Dbcontexts
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        { 
            
        }
        public DbSet<Track> Tracks { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Account> Accounts { get; set; }
        public DbSet<UserFollow> UserFollows { get; set; }
        public DbSet<Playlist> Playlists { get; set; }
        public DbSet<PlaylistFollow> PlaylistFollows { get; set; }
        public DbSet<TrackPlaylist> TrackPlaylists { get; set; }
        public DbSet<FavoriteTrack> FavoriteTracks { get; set; }
        public DbSet<RevokedToken> RevokedTokens { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Quan hệ 1-n giữa User và Track
            modelBuilder.Entity<Track>()
                .HasOne(t => t.Artist)
                .WithMany(u => u.Tracks)
                .HasForeignKey(t => t.ArtistId)
                .OnDelete(DeleteBehavior.Cascade); // Xóa User -> Xóa Track của họ

            // Quan hệ 1-n giữa User và Playlist
            modelBuilder.Entity<Playlist>()
                .HasOne(p => p.User)
                .WithMany(u => u.Playlists)
                .HasForeignKey(p => p.CreateBy)
                .OnDelete(DeleteBehavior.Cascade); // Xóa User -> Xóa Playlist của họ

            // Quan hệ nhiều-nhiều giữa Playlist và Track
            modelBuilder.Entity<TrackPlaylist>()
                .HasKey(tp => new { tp.PlaylistId, tp.TrackId });

            modelBuilder.Entity<TrackPlaylist>()
                .HasOne(tp => tp.Playlist)
                .WithMany(p => p.Tracks)
                .HasForeignKey(tp => tp.PlaylistId)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<TrackPlaylist>()
                .HasOne(tp => tp.Track)
                .WithMany(t => t.Playlists)
                .HasForeignKey(tp => tp.TrackId)
                .OnDelete(DeleteBehavior.Restrict);

            // Quan hệ nhiều-nhiều giữa User và User (Follow)
            modelBuilder.Entity<UserFollow>()
                .HasKey(uf => new { uf.FollowerId, uf.FollowingId });

            modelBuilder.Entity<UserFollow>()
                .HasOne(uf => uf.Follower)
                .WithMany(u => u.Following)
                .HasForeignKey(uf => uf.FollowerId)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<UserFollow>()
                .HasOne(uf => uf.Following)
                .WithMany(u => u.Followers)
                .HasForeignKey(uf => uf.FollowingId)
                .OnDelete(DeleteBehavior.Restrict);

            // Quan hệ nhiều-nhiều giữa User và Playlist (User Follow Playlist)
            modelBuilder.Entity<PlaylistFollow>()
                .HasKey(pf => new { pf.UserId, pf.PlaylistId });

            modelBuilder.Entity<PlaylistFollow>()
                .HasOne(pf => pf.User)
                .WithMany(u => u.PlaylistFollows)
                .HasForeignKey(pf => pf.UserId)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<PlaylistFollow>()
                .HasOne(pf => pf.Playlist)
                .WithMany(p => p.Followers)
                .HasForeignKey(pf => pf.PlaylistId)
                .OnDelete(DeleteBehavior.Restrict);

            // Quan hệ nhiều-nhiều giữa User và Track (Favorite Tracks)
            modelBuilder.Entity<FavoriteTrack>()
                .HasKey(ft => new { ft.UserId, ft.TrackId });

            modelBuilder.Entity<FavoriteTrack>()
                .HasOne(ft => ft.User)
                .WithMany(u => u.FavoriteTracks)
                .HasForeignKey(ft => ft.UserId)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<FavoriteTrack>()
                .HasOne(ft => ft.Track)
                .WithMany(t => t.Favorite)
                .HasForeignKey(ft => ft.TrackId)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<RevokedToken>()
                .HasOne(rt => rt.Account)
                .WithMany()  // Nếu Account có danh sách RevokedTokens thì dùng `.WithMany(a => a.RevokedTokens)`
                .HasForeignKey(rt => rt.AccountId)
                .OnDelete(DeleteBehavior.Cascade); // Khi xóa Account, xóa luôn token bị thu hồi

        }
    }
}
