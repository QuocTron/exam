using ExamManagement.Data.Infrastructures;
using ExamManagement.Entities;

namespace ExamManagement.Data.Repositories
{
    public interface IAnswerRepository : IRepository<Answer>
    {
    }

    public class AnswerRepository : RepositoryBase<Answer>, IAnswerRepository
    {
        public AnswerRepository(IDbFactory dbFactory)
            : base(dbFactory)
        {
        }
    }
}
