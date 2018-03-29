using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace AspNetVstsSample.Web.Models
{
    public class AspNetVstsSampleDbContext : DbContext
    {
        public AspNetVstsSampleDbContext(DbContextOptions<AspNetVstsSampleDbContext> options)
                : base(options)
        {
        }

        public DbSet<Sample> Samples { get; set; }
    }
}
