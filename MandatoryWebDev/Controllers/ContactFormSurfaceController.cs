using MandatoryWebDev.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Umbraco.Core.Models;
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
            IContent contactForm = Services.ContentService.CreateContent(model.Name, CurrentPage.Id, "ContactForm");

            contactForm.SetValue("name", model.Name);
            contactForm.SetValue("email", model.Email);
            contactForm.SetValue("subject", model.Subject);
            contactForm.SetValue("message", model.Messsage);

            Services.ContentService.SaveAndPublishWithStatus(contactForm);
            return RedirectToCurrentUmbracoPage();
        }
    }
}