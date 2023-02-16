using ExamManagement.Data.Infrastructures;
using ExamManagement.Entities;

namespace ExamManagement.Data.Repositories
{
    public interface IQuestionSheetRepository : IRepository<QuestionSheet>
    {
    }

    public class QuestionSheetRepository : RepositoryBase<QuestionSheet>, IQuestionSheetRepository
    {
        public QuestionSheetRepository(IDbFactory dbFactory)
            : base(dbFactory)
        {
        }
    }
}
