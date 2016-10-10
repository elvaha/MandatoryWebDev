using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace MandatoryWebDev.Models
{
    public class MessageFormModelView
    {
        [Required]
        public string UserName { get; set; }
        [Required]
        public string Message { get; set; }

    }
}