using ExamManagement.Entities;

namespace ExamManagement.Businesses.Infrastructures.EntityExtensions
{
    public static class ExamExtensions
    {
        public static void Update(this Exam examDest, Exam examSrc)
        {
            examDest.Name = examSrc.Name;
            examDest.CreateDate = examSrc.CreateDate;
            examDest.Deleted = examSrc.Deleted;
            examDest.Shifts = examSrc.Shifts;
        }
    }
}
