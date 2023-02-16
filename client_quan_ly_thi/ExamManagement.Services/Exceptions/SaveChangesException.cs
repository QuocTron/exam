using System;

namespace ExamManagement.Services.Exceptions
{
    public class SaveChangesException : Exception
    {
        public SaveChangesException()
        {
        }

        public SaveChangesException(string message)
            : base(message)
        {
        }

        public SaveChangesException(string message, Exception inner)
            : base(message, inner)
        {
        }
    }
}
