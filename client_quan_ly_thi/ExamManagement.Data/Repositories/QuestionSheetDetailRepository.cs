using ExamManagement.Data.Infrastructures;
using ExamManagement.Entities;

namespace ExamManagement.Data.Repositories
{
    public interface IQuestionSheetDetailRepository : IRepository<QuestionSheetDetail>
    {
    }

    public class QuestionSheetDetailRepository : RepositoryBase<QuestionSheetDetail>, IQuestionSheetDetailRepository
    {
        public QuestionSheetDetailRepository(IDbFactory dbFactory)
            : base(dbFactory)
        {
        }
    }
}
