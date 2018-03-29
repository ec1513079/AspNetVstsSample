using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace AspNetVstsSample.Web.Pages
{
    public class ExceptionSampleModel : PageModel
    {
        public void OnGet()
        {
            throw new Exception("Occurred Sample Exception in 'ExceptionSampleModel'");
        }
    }
}