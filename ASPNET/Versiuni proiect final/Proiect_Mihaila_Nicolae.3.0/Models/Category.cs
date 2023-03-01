using System.ComponentModel.DataAnnotations;

namespace Proiect.Models
{
    public class Category
    {
        [Key]
        public int Categ_ID { get; set; }
        [Required (ErrorMessage = "The category must have a name!")]
        public string Categ_Name { get; set; }

    }
}
