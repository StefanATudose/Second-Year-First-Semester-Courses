using Microsoft.AspNetCore.Mvc.Rendering;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Examen.Models
{
    public class Ticket
    {
        [Key]
        public int Id { get; set; }
        [Required(ErrorMessage = "Titlul este obligatoriu")]
        [MaxLength(10, ErrorMessage = "Titlu poate avea maxim 10 caractere")]
        public string? TitluBilet { get; set; }

        [Required(ErrorMessage = "Pretul este obligatoriu")]
        [Range(0, 1000000000, ErrorMessage = "Pretul biletului trebuie sa fie pozitiv")]    //daca am timp de facut cu custom validation
        public int? Pret { get; set; }

        [Required(ErrorMessage = "Data este obligatorie")]
        [DataType(DataType.DateTime)]
        [CustomValidation (typeof(Ticket), "ValidareDataBilet")]
        public DateTime Data { get; set; }
        [Required(ErrorMessage = "Biletul trebuie sa aiba film")]
        public int? MovieId { get; set; }
        virtual public Movie? Movie { get; set; }

        [NotMapped]
        public IEnumerable <SelectListItem>? Filme { get; set; }


        static public ValidationResult ValidareDataBilet(DateTime? data)
        {
            if (data == null)
                return new ValidationResult("Introduceti o data!!!!!!");
            if (data <= DateTime.Now)
                return new ValidationResult("Introduceti o data din viitor pentru ca nu puteti vedea un film din trecut!!!");
            return ValidationResult.Success;
        }
    }
}
