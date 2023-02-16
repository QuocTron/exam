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
    public interface ISemesterBusiness : IBusinessBase<Semester>
    {
        /// <summary>
        /// Get all semester
        /// </summary>
        /// <returns>Semester list</returns>
        IEnumerable<Semester> GetAllSemesters();
    }
    public class SemesterBusiness : BusinessBase<Semester>, ISemesterBusiness
    {
        private readonly ISemesterRepository _repository;
        public SemesterBusiness(ISemesterRepository repository, IUnitOfWork unitOfWork) : base(repository, unitOfWork)
        {
            _repository = repository;
        }

        public IEnumerable<Semester> GetAllSemesters()
        {
            return _repository.GetSemesters();
        }

        public override void Update(Semester entity)
        {
            var semester = _repository.GetSingleByCondition(se => se.Id == entity.Id);
        }
    }
}
