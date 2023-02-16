using System;

namespace ExamManagement.APIs.ViewModels
{
    public class UserViewModel
    {
        public int Id { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string Name { get; set; }
        public DateTime? CreateDate { get; set; }
        public bool? Deleted { get; set; }
        public bool? LogOut { get; set; }
        public DateTime? LastActivity { get; set; }
        public DateTime? LastLogIn { get; set; }
        public DateTime? LastPasswordChanged { get; set; }
        public DateTime? LastLogOut { get; set; }
        public string Salt { get; set; }
        public string Comment { get; set; }
        public bool? BuildInUser { get; set; }
    }
}