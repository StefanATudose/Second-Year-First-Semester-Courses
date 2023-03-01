using System.ComponentModel.DataAnnotations;

namespace Proiect_FINAL.Models
{
    public class User
    {
        [Key]
        public int User_ID { get; set; }
        public string Last_Name { get; set; }
        public string First_Name { get; set; }
        [Required(ErrorMessage = "An email adress is required!")]
        [EmailAddress (ErrorMessage = "The email adress MUST be valid!")]
        public string Email { get; set; }
        public DateTime Register_Date { get; set; }
        [Required(ErrorMessage = "The user MUST have a role!")]
        public int Role_ID { get; set; }
    }
}
