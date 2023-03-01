using System.ComponentModel.DataAnnotations;

namespace PregExamen.Models
{
    public class Brand
    {
        [Key]
        public int Id { get; set; }
        [Required(ErrorMessage = "Nume obligatoriu")]
        public string? Nume { get; set; }

        virtual public ICollection <GiftCard>? GiftCards { get; set; }
    }
}
