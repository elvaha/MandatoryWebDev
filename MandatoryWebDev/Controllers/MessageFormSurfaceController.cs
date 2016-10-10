﻿using MandatoryWebDev.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Umbraco.Web.Mvc;

namespace MandatoryWebDev.Controllers
{
    public class MessageFormSurfaceController : SurfaceController
    {
        // GET: MessageFormSurface
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult PostMessage(MessageFormModelView model)
        {
            return RedirectToCurrentUmbracoPage();
        }
    }
}