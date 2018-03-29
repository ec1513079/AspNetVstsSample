using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace AspNetVstsSample.Web.Models.Seeds
{
    public static class SeedData
    {
        public static void Initialize(IServiceProvider serviceProvider)
        {
            using (var context = new AspNetVstsSampleDbContext(
                serviceProvider.GetRequiredService<DbContextOptions<AspNetVstsSampleDbContext>>()))
            {
                // Look for any movies.
                if (context.Samples.Any())
                {
                    return;   // DB has been seeded
                }

                context.Samples.AddRange(
                    new Sample
                    {
                        Title = "Test Title by Seeding",
                        Detail = "Test Detail by Seeding"
                    }
                );
                context.SaveChanges();
            }
        }
    }
}
