using ExamManagement.Data.Infrastructures;
using ExamManagement.Entities;

namespace ExamManagement.Data.Repositories
{
    public interface IExamRepository : IRepository<Exam>
    {
    }

    public class ExamRepository : RepositoryBase<Exam>, IExamRepository
    {
        public ExamRepository(IDbFactory dbFactory)
            : base(dbFactory)
        {
        }
    }
}
