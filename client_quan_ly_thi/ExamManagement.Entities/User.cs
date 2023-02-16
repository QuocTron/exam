using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace ExamManagement.Entities
{
    public class User
    {
        public int Id { get; set; }
        [StringLength(50)]
        public string Username { get; set; }
        [StringLength(128)]
        public string Password { get; set; }
        [StringLength(50)]
        public string Salt { get; set; }
        [StringLength(50)]
        public string Name { get; set; }
        public DateTime? CreateDate { get; set; }
        public bool LogOut { get; set; }
        public DateTime? LastActivity { get; set; }
        public DateTime? LastLogIn { get; set; }
        public DateTime? LastPasswordChanged { get; set; }
        public DateTime? LastLogOut { get; set; }
        [StringLength(100)]
        public string Comment { get; set; }
        public bool BuildInUser { get; set; }
        [StringLength(10)]
        public string FacultyId { get; set; }

        [StringLength(10)]
        public string SubjectId { get; set; }
        public bool Deleted { get; set; }

        public ICollection<Role> Roles { get; set; }
        public User()
        {
            Roles = new HashSet<Role>();
        }
    }
}