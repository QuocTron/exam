using ExamManagement.Data.Infrastructures;
using ExamManagement.Entities;
using System.Collections.Generic;
using System.Linq;

namespace ExamManagement.Data.Repositories
{
    public interface IShiftSubjectStudentRepository : IRepository<ShiftSubjectStudent>
    {
        IEnumerable<ShiftSubjectStudent> GetSSSListByCodeAndShiftId(string code, long shiftId);
        IEnumerable<ShiftSubjectStudent> GetSSSListByCodeAndSSId(string code, long shiftSubjectId);
        IEnumerable<ShiftSubjectStudent> GetSSSListByCodeAndExamId(string code, long examId);
    }

    public class ShiftSubjectStudentRepository : RepositoryBase<ShiftSubjectStudent>, IShiftSubjectStudentRepository
    {
        public ShiftSubjectStudentRepository(IDbFactory dbFactory)
            : base(dbFactory)
        {
        }

        public IEnumerable<ShiftSubjectStudent> GetSSSListByCodeAndExamId(string code, long examId)
        {
            var shiftSubjectStudents = DbContext.ShiftSubjectStudents.Where(sss => sss.Student.Code.Equals(code) && 
                                        sss.ShiftSubject.Shift.ExamId == examId);
            return shiftSubjectStudents;
        }

        public IEnumerable<ShiftSubjectStudent> GetSSSListByCodeAndShiftId(string code, long shiftId)
        {
            var shiftSubjectStudents = DbContext.ShiftSubjectStudents.Where(sss => sss.Student.Code.Equals(code) &&
                                        sss.ShiftSubject.ShiftId == shiftId);
            return shiftSubjectStudents;
        }

        public IEnumerable<ShiftSubjectStudent> GetSSSListByCodeAndSSId(string code, long shiftSubjectId)
        {
            var shiftSubjectStudents = DbContext.ShiftSubjectStudents.Where(sss => sss.Student.Code.Equals(code) &&
                                        sss.ShiftSubjectId == shiftSubjectId);
            return shiftSubjectStudents;
        }
    }
}
