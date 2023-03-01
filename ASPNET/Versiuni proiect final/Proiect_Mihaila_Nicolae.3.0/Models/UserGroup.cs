using Microsoft.AspNetCore.Mvc;
using Microsoft.Build.Framework;

namespace Proiect.Models
{
    public class UserGroup
    {
        public string? User_ID { get; set; }
        public int ? Group_ID { get; set; }
        virtual public ApplicationUser? User { get; set; }
        virtual public Group? Group { get; set; }

        public int Moderator { get; set; }
    }
}
