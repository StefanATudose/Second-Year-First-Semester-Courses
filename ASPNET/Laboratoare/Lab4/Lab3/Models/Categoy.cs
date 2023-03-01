using System.ComponentModel.DataAnnotations;

namespace Lab3.Models
{
    public class Categoy
    {
        [Key]
        public int CategoryID { get; set; }
        public string CategoryName { get; set; }
    }
}
