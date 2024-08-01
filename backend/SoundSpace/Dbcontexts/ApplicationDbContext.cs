using Microsoft.EntityFrameworkCore;
using SoundSpace.Entities;

namespace SoundSpace.Dbcontexts
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        { 
            
        }

        public DbSet<User> Users { get; set; }
        
        public DbSet<Account> Accounts { get; set; }
    }
}
