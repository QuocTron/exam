using ExamManagement.Data.Infrastructures;
using ExamManagement.Entities;
using System.Collections.Generic;
using System;
using System.Linq;

namespace ExamManagement.Data.Repositories
{
    public interface IQuestionRepository : IRepository<Question>
    {
    }

    public class QuestionRepository : RepositoryBase<Question>, IQuestionRepository
    {
        public QuestionRepository(IDbFactory dbFactory)
            : base(dbFactory)
        {
        }
    }
}
