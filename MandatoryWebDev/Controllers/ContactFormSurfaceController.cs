using MandatoryWebDev.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Umbraco.Web.Mvc;

namespace MandatoryWebDev.Controllers
{
    public class ContactFormSurfaceController : SurfaceController
    {
        // GET: ContactFormSurface
        public ActionResult Index()
        {
            return PartialView("ContactForm", new ContactFormModelView());
        }

        [HttpPost]
        public ActionResult HandleFormSubmit(ContactFormModelView model)
        {
            if (!ModelState.IsValid)
            {
                return CurrentUmbracoPage();
            }
            else
            {
                return RedirectToCurrentUmbracoPage();
            }
        }
    }
}