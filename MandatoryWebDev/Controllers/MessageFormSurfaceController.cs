using MandatoryWebDev.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Umbraco.Web.Mvc;
using Umbraco.Core.Models;

namespace MandatoryWebDev.Controllers
{
    public class MessageFormSurfaceController : SurfaceController
    {
        // GET: MessageFormSurface
        public ActionResult Index()
        {
            return PartialView("MessageForm", new MessageFormModelView());
        }

        [HttpPost]
        public ActionResult PostMessage(MessageFormModelView model)
        {
            var member = umbraco.cms.businesslogic.member.Member.GetCurrentMember();
            IContent boardMessage = Services.ContentService.CreateContent(model.Title, CurrentPage.Id, "BoardMessage");

            boardMessage.SetValue("publisher", member.LoginName);
            boardMessage.SetValue("date", DateTime.Now);
            boardMessage.SetValue("content", model.Content);
            boardMessage.SetValue("title", model.Title);

            Services.ContentService.SaveAndPublishWithStatus(boardMessage);
            return RedirectToCurrentUmbracoPage();
        }
    }
}