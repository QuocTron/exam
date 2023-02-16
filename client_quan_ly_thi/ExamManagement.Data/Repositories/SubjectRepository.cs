using ExamManagement.Data.Infrastructures;
using ExamManagement.Entities;
using System.Collections.Generic;
using System.Linq;
using System;

namespace ExamManagement.Data.Repositories
{
    public interface ISubjectRepository : IRepository<Subject>
    {
        Subject GetByCode(string code);
        IEnumerable<Subject> GetSubjectsByShift(int shiftId);
        IEnumerable<Subject> GetSubjects();
    }

    public class SubjectRepository : RepositoryBase<Subject>, ISubjectRepository
    {
        public SubjectRepository(IDbFactory dbFactory)
            : base(dbFactory)
        {
        }

        public Subject GetByCode(string code)
        {
            return DbContext.Subjects.SingleOrDefault(s => s.Code == code);
        }

        public IEnumerable<Subject> GetSubjectsByShift(int shiftId)
        {
            var subjectIds = DbContext.ShiftSubjects
                .Where(s => s.ShiftId == shiftId)
                .Select(s => s.SubjectId)
                .ToList();

            return DbContext.Subjects.Where(s => subjectIds.Contains(s.Id));
        }
        public IEnumerable<Subject> GetSubjects()
        {
            return DbContext.Subjects.Where(c => c.Deleted == false);
        }
    }
}
