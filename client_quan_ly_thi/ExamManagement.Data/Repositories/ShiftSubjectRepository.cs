using ExamManagement.Data.Infrastructures;
using ExamManagement.Entities;
using System.Collections.Generic;
using System.Linq;

namespace ExamManagement.Data.Repositories
{
    public interface IShiftSubjectRepository : IRepository<ShiftSubject>
    {
        ShiftSubject GetSingleByShiftAndSubject(int shiftId, int subjectId);
        IEnumerable<ShiftSubject> getShiftSubjectByShiftIdsAndMatrixIds(IEnumerable<int> matrixIds, IEnumerable<int?> shiftIds);
    }

    public class ShiftSubjectRepository : RepositoryBase<ShiftSubject>, IShiftSubjectRepository
    {
        public ShiftSubjectRepository(IDbFactory dbFactory)
            : base(dbFactory)
        {
        }

        public IEnumerable<ShiftSubject> getShiftSubjectByShiftIdsAndMatrixIds(IEnumerable<int> matrixIds, IEnumerable<int?> shiftIds)
        {
            var shiftSubjects = from matrixId in matrixIds
                                join shiftSubject in DbContext.ShiftSubjects
                                    on matrixId equals shiftSubject.MatrixId
                                join shiftId in shiftIds
                                    on shiftSubject.ShiftId equals shiftId
                                select shiftSubject;
            return shiftSubjects;
        }

        // TODO: Consider to remove this unused method.
        public ShiftSubject GetSingleByShiftAndSubject(int shiftId, int subjectId)
        {
            var shiftsubject = DbContext.ShiftSubjects
                .FirstOrDefault(s => s.ShiftId == shiftId && s.SubjectId == subjectId);
            return shiftsubject;
        }
    }
}
