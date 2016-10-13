using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Umbraco.Web.Mvc;

namespace MandatoryWebDev.Controllers
{
    public class LoginSurfaceController : SurfaceController
    {
        // GET: LoginSuface
        public ActionResult Logout()
        {
            Members.Logout();
            return Redirect("/");
        }
    }
}