using Microsoft.AspNetCore.Mvc;
using Microsoft.Build.Framework;
using System.ComponentModel.DataAnnotations.Schema;

namespace Proiect.Models
{
    public class PendingUserGroup
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ID { get; set; }
        public string? User_ID { get; set; }
        public int? Group_ID { get; set; }
        virtual public ApplicationUser? User { get; set; }
        virtual public Group? Group { get; set; }
    }
}
