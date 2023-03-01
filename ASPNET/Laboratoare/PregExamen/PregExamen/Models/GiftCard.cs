using Microsoft.AspNetCore.Mvc.Rendering;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PregExamen.Models
{
    public class GiftCard
    {
        [Key]
        public int Id { get; set; }

        [Required(ErrorMessage = "Denumirea este obligatorie")]
        public string? Denumire { get; set; }
        [Required(ErrorMessage = "Desc obligatiorie")]
        public string? Descriere { get; set; }

        [Required(ErrorMessage = "Data expirare obligatorie")]
        [DataType(DataType.DateTime)]
        [CustomValidation(typeof(GiftCard), "ValidareData")]
        public DateTime? DataExp { get; set; }

        [Required(ErrorMessage = "Procent obligatoriu")]
        [Range(1, 100, ErrorMessage = "Valoarea procentului sa fie intre 1 si 100!") ]
        public int? Procent { get; set; }

        [Required(ErrorMessage = "Brand obligatoriu")]
        public int? BrandId { get; set; }

        virtual public Brand? Brand { get; set; }

        [NotMapped]
        public IEnumerable<SelectListItem>? Brands { get; set; }
    }
}
