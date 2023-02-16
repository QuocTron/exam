using ExamManagement.Data.Infrastructures;
using ExamManagement.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamManagement.Data.Repositories
{
    public interface ISemesterRepository : IRepository<Semester>
    {
        Semester GetByCode(string code);
        IEnumerable<Semester> GetSemesters();
    }
    public class SemesterRepository : RepositoryBase<Semester>, ISemesterRepository
    {
        public SemesterRepository(IDbFactory dbFactory) : base(dbFactory)
        {
        }

        public Semester GetByCode(string code)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Semester> GetSemesters()
        {
            return DbContext.Semesters.Where(c => c.Deleted == false);
        }
    }
}
