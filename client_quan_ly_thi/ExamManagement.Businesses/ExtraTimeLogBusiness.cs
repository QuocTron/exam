using ExamManagement.Businesses.Infrastructures;
using ExamManagement.Data.Infrastructures;
using ExamManagement.Data.Repositories;
using ExamManagement.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamManagement.Businesses
{
    public interface IExtraTimeLogBusiness : IBusinessBase<ExtraTimeLog>
    {
        IEnumerable<ExtraTimeLog> GetExtraTimeLogsByQuestionSheetId(long id);
    }

    class ExtraTimeLogBusiness : BusinessBase<ExtraTimeLog>, IExtraTimeLogBusiness
    {
        IExtratimeLogRepository _extraTimeLogRepository;

        public ExtraTimeLogBusiness(IExtratimeLogRepository extraTimeLogRepository, IUnitOfWork unitOfWork)
            : base(extraTimeLogRepository, unitOfWork)
        {
            _extraTimeLogRepository = extraTimeLogRepository;
        }

        public IEnumerable<ExtraTimeLog> GetExtraTimeLogsByQuestionSheetId(long id)
        {
            return _extraTimeLogRepository.GetMulti(ext => ext.QuestionSheetId == id);
        }

        public override void Update(ExtraTimeLog entity)
        {
            throw new NotImplementedException();
        }
    }
}
