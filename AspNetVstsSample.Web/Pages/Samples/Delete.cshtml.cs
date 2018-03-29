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
    public class DeleteModel : PageModel
    {
        private readonly AspNetVstsSample.Web.Models.AspNetVstsSampleDbContext _context;

        public DeleteModel(AspNetVstsSample.Web.Models.AspNetVstsSampleDbContext context)
        {
            _context = context;
        }

        [BindProperty]
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

        public async Task<IActionResult> OnPostAsync(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            Sample = await _context.Samples.FindAsync(id);

            if (Sample != null)
            {
                _context.Samples.Remove(Sample);
                await _context.SaveChangesAsync();
            }

            return RedirectToPage("./Index");
        }
    }
}
