using System.ComponentModel.DataAnnotations;

namespace ProiectFinall.Models
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

        [Required]
        public int Categ_ID { get; set; }
    }
}
