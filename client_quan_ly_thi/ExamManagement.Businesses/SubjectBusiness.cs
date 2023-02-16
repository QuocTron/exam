using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ExamManagement.Businesses.Infrastructures;
using ExamManagement.Data.Infrastructures;
using ExamManagement.Data.Repositories;
using ExamManagement.Entities;

namespace ExamManagement.Businesses
{
    public interface ISubjectBusiness : IBusinessBase<Subject>
    {
        IEnumerable<Subject> GetAllSubject();
    }
    public class SubjectBusiness: BusinessBase<Subject>, ISubjectBusiness
    {
        private readonly ISubjectRepository _subjectRepository;
        public SubjectBusiness(
            ISubjectRepository subjectRepository,
            IUnitOfWork unitOfWork) : base(subjectRepository, unitOfWork)
        {
            _subjectRepository = subjectRepository;
        }
        public override void Update(Subject entity)
        {
            throw new NotImplementedException();
        }
        public IEnumerable<Subject> GetAllSubject()
        {
            return _subjectRepository.GetSubjects();
        }
    }
}
