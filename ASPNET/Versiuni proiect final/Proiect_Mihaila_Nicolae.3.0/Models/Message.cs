using System.ComponentModel.DataAnnotations;

namespace Proiect.Models
{
    public class Message
    {
        [Key]
        public int Message_ID { get; set; }
        [Required (ErrorMessage = "Message must not be empty!")]
        [MaxLength (100, ErrorMessage = "The length of the message cannot exceed 100 characters!")]
        public string? Text { get; set; }

        [Required (ErrorMessage = "The message NEEDS to have an author!")]
        public string? User_ID { get; set; }
        [Required (ErrorMessage = "The message MUST belong to a group!")]
        public int? Group_ID { get; set; }
        public DateTime CreatedDate { get; set; }

        virtual public ApplicationUser? User { get; set; }
        virtual public Group? Group { get; set; }

    }
}
