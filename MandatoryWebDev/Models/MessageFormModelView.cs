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
        public string Title { get; set; }
        [Required]
        public string Content { get; set; }
    }
}