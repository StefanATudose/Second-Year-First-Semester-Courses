using System.ComponentModel.DataAnnotations;

namespace ProiectFinall.Models
{
    public class Role
    {
        [Key]
        public int Role_ID { get; set; }
        [Required (ErrorMessage = "The role MUST be identified by a name!")]
        public string Role_Name { get; set; }
         
        ///vedem daca chiar e nevoie aici de drepturi de editare pe care le schimba adminul sau putem face
        ///asta direct cum afisam butoanele din backend
    }
}
