using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using AspNetVstsSample.Web.Models;

namespace AspNetVstsSample.Web.Pages_Samples
{
    public class CreateModel : PageModel
    {
        private readonly AspNetVstsSample.Web.Models.AspNetVstsSampleDbContext _context;

        public CreateModel(AspNetVstsSample.Web.Models.AspNetVstsSampleDbContext context)
        {
            _context = context;
        }

        public IActionResult OnGet()
        {
            return Page();
        }

        [BindProperty]
        public Sample Sample { get; set; }

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }

            _context.Samples.Add(Sample);
            await _context.SaveChangesAsync();

            return RedirectToPage("./Index");
        }
    }
}