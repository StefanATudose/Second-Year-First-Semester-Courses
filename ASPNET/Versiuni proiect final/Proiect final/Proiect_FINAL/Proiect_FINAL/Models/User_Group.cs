using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.CompilerServices;

namespace Proiect_FINAL.Models
{
    public class User_Group
    {
        [Key, Column(Order = 1) ]
        public int User_ID { get; set; }
        [Key, Column(Order = 2) ]
        public int Group_ID { get; set; }
        public int? Moderator { get; set; } //asta se poate schimba in functie de cum decidem sa implementam functia de moderare
    }
}
