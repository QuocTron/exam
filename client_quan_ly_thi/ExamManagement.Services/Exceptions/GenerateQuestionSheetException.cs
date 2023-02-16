using System;

namespace ExamManagement.Services.Exceptions
{
    public class GenerateQuestionSheetException : Exception
    {
        public GenerateQuestionSheetException()
        {
        }

        public GenerateQuestionSheetException(string message)
            : base(message)
        {
        }

        public GenerateQuestionSheetException(string message, Exception inner)
            : base(message, inner)
        {
        }
    }
}
