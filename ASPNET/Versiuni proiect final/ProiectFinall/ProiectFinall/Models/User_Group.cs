using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.CompilerServices;

namespace ProiectFinall.Models
{
    [PrimaryKey(nameof(User_ID), nameof(Group_ID))]
    public class User_Group
    {
        public int User_ID { get; set; }
        public int Group_ID { get; set; }
        public int? Moderator { get; set; } //asta se poate schimba in functie de cum decidem sa implementam functia de moderare
    }
}
