using System;
using System.Collections.Generic;
using ExamManagement.Entities;
using ExamManagement.Businesses.Infrastructures;
using ExamManagement.Data.Infrastructures;
using ExamManagement.Data.Repositories;

namespace ExamManagement.Businesses
{
    public interface IMarkRoundingBusiness : IBusinessBase<MarkRounding>
    {
        /// <summary>
        /// Get all MarkRounding
        /// </summary>
        /// <returns>MarkRounding list</returns>
        IEnumerable<MarkRounding> GetAllMarkRoundings();

        void SelectMarkRounding(long id);
    }
    public class MarkRoundingBusiness : BusinessBase<MarkRounding>, IMarkRoundingBusiness
    {
        private readonly IMarkRoundingRepository _repository;
        public MarkRoundingBusiness(IMarkRoundingRepository repository, IUnitOfWork unitOfWork) : base(repository, unitOfWork)
        {
            _repository = repository;
        }

        public IEnumerable<MarkRounding> GetAllMarkRoundings()
        {
            return _repository.GetMarkRoundings();
        }

        public override void Update(MarkRounding entity)
        {
            throw new NotImplementedException();
        }

        public void SelectMarkRounding(long id)
        {
            var markRoundingUsing = _repository.GetUsingMarkRounding();
            var marRounding = _repository.GetSingleById(id);
            if(markRoundingUsing != null)
            {
                markRoundingUsing.Using = false;
            }

            if(marRounding != null)
            {
                marRounding.Using = true;
            }
        }
    }
}
