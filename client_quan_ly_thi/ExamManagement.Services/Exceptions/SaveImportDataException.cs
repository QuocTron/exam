using System;

namespace ExamManagement.Services.Exceptions
{
    public class SaveImportDataException : Exception
    {
        public SaveImportDataException()
        {
        }

        public SaveImportDataException(string message)
            : base(message)
        {
        }

        public SaveImportDataException(string message, Exception inner)
            : base(message, inner)
        {
        }
    }
}
