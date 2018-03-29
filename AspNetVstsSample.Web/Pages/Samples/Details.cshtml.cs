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
    public class DetailsModel : PageModel
    {
        private readonly AspNetVstsSample.Web.Models.AspNetVstsSampleDbContext _context;

        public DetailsModel(AspNetVstsSample.Web.Models.AspNetVstsSampleDbContext context)
        {
            _context = context;
        }

        public Sample Sample { get; set; }

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            Sample = await _context.Samples.SingleOrDefaultAsync(m => m.Id == id);

            if (Sample == null)
            {
                return NotFound();
            }
            return Page();
        }
    }
}
