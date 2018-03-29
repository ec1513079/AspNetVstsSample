using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using AspNetVstsSample.Web.Models;

namespace AspNetVstsSample.Web.Pages_Samples
{
    public class IndexModel : PageModel
    {
        private readonly AspNetVstsSample.Web.Models.AspNetVstsSampleDbContext _context;

        public IndexModel(AspNetVstsSample.Web.Models.AspNetVstsSampleDbContext context)
        {
            _context = context;
        }

        public IList<Sample> Sample { get;set; }

        public async Task OnGetAsync()
        {
            Sample = await _context.Samples.ToListAsync();
        }
    }
}
