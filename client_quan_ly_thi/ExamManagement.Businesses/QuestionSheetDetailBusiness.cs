using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ExamManagement.Entities;
using ExamManagement.Data.Repositories;
using ExamManagement.Businesses.Infrastructures;
using ExamManagement.Data.Infrastructures;

namespace ExamManagement.Businesses
{
    public interface IQuestionSheetDetailBusiness : IBusinessBase<QuestionSheetDetail>
    {
        /// <summary>
        /// filter question sheet details by question of id and return
        /// </summary>
        /// <param name="questionSheetId">question sheet of id</param>
        /// <returns></returns>
        IEnumerable<QuestionSheetDetail> GetQuestionSheetDetailListByQuestionSheetId(long questionSheetId);
    }
    public class QuestionSheetDetailBusiness : BusinessBase<QuestionSheetDetail>, IQuestionSheetDetailBusiness
    {
        private readonly IQuestionSheetDetailRepository _questionSheetDetailRepository;
        public QuestionSheetDetailBusiness
            (
                IQuestionSheetDetailRepository questionSheetDetailRepository,
                IUnitOfWork unitOfWork
            ) : base(questionSheetDetailRepository, unitOfWork)
        {
            _questionSheetDetailRepository = questionSheetDetailRepository;
        }

        public IEnumerable<QuestionSheetDetail> GetQuestionSheetDetailListByQuestionSheetId(long questionSheetId)
        {
            var questionSheetDetails = _questionSheetDetailRepository.GetMulti(qsd => (qsd.QuestionSheetId == questionSheetId) && (qsd.Question.Deleted==false));
            return questionSheetDetails;
        }

        public override void Update(QuestionSheetDetail entity)
        {
            throw new NotImplementedException();
        }
    }
}
