using soundspace.Data;
using soundspace.Models;

namespace soundspace
{
    public class Seed
    {
        private readonly DataContext dataContext;
        public Seed(DataContext dataContext)
        {
            this.dataContext = dataContext;
        }

        public void SeedDataContext()
        {
            
        }
    }
}
