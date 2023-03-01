using Microsoft.AspNetCore.Identity;
namespace Proiect.Models
{
    public class ApplicationUser : IdentityUser         ///de adaugat constrangeri mai tarziu
    {
        public string? LastName { get; set; }
        public string? FirstName { get; set; }
        virtual public ICollection <UserGroup>? UserGroups { get; set; }
        virtual public ICollection <Message>? Messages { get; set; }
    }
}
