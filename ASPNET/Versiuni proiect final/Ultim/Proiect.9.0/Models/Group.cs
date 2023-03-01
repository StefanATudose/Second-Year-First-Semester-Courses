using Microsoft.AspNetCore.Mvc.Rendering;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Proiect.Models
{
    public class Group
    {
        [Key]
        public int Group_ID { get; set; }
        [Required (ErrorMessage = "The group MUST have a name!")]
        [MaxLength (20, ErrorMessage = "Group name CANNOT exceed 20 characters!")]
        public string? Name { get; set; }
        [MaxLength (200, ErrorMessage = "Group description CANNOT exceed 200 characters!")]
        public string? Description { get; set; }
        public DateTime Gr_CreatedDate { get; set; }

        [Required(ErrorMessage = "The group MUST have a category!")]
        public int? Categ_ID { get; set; }

        public virtual Category? Category { get; set; }
        virtual public ICollection <UserGroup>? UserGroups { get; set; }
        virtual public ICollection <Message>? Messages { get; set; }
        virtual public ICollection<PendingUserGroup>? PendingUserGroups { get; set; }

        [NotMapped]
        public IEnumerable <SelectListItem>? Categ { get; set; }
    }
}
