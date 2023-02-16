using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using ExamManagement.Businesses.Infrastructures;
using ExamManagement.Data.Infrastructures;
using ExamManagement.Data.Repositories;
using ExamManagement.Entities;

namespace ExamManagement.Businesses
{
    public interface IQuestionBusiness : IBusinessBase<Question>
    {
        IEnumerable<Question> GetMulti(Expression<Func<Question, bool>> p);
    }

    public class QuestionBusiness : BusinessBase<Question>, IQuestionBusiness
    {
        IQuestionRepository _questionRepository;
        public QuestionBusiness(IQuestionRepository questionRepository, IUnitOfWork unitOfWork)
            : base(questionRepository, unitOfWork)
        {
            _questionRepository = questionRepository;
        }

        public IEnumerable<Question> GetMulti(Expression<Func<Question, bool>> p)
        {
            return _questionRepository.GetMulti(p);
        }

        public override void Update(Question entity)
        {
            throw new System.NotImplementedException();
        }
    }
}
