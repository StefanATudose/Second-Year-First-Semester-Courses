using System.ComponentModel.DataAnnotations;

namespace Examen.Models
{
    public class Movie
    {
        [Key]
        public int Id { get; set; }
        [Required(ErrorMessage = "Denumirea este obligatorie")]
        public string? DenFilm { get; set; }

        virtual public ICollection<Ticket>? Tickets { get; set; }
    }
}
