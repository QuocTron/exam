using ExamManagement.Data.Infrastructures;
using ExamManagement.Services.Exceptions;
using System;
using System.Collections.Generic;

namespace ExamManagement.Businesses.Infrastructures
{
    public interface IBusinessBase<T> where T : class
    {
        /// <summary>
        /// Get all entity from database.
        /// </summary>
        /// <returns>List of entiy</returns>
        IEnumerable<T> GetAll();

        /// <summary>
        /// Get one entity by id.
        /// </summary>
        /// <param name="id">Entity id</param>
        /// <returns>Entity</returns>
        T GetSingleById(long id);

        /// <summary>
        /// Insert new entity into database.
        /// </summary>
        /// <param name="entity">Entity object</param>
        void Create(T entity);
        
        /// <summary>
        /// Update entity information.
        /// </summary>
        /// <param name="entity">Entity object</param>
        void Update(T entity);

        /// <summary>
        /// Delete entity by id.
        /// </summary>
        /// <param name="id">Entity id</param>
        void Delete(int id);

        /// <summary>
        /// Save changes in dbContext.
        /// </summary>
        void Save();
    }

    public abstract class BusinessBase<T> : IBusinessBase<T> where T : class
    {
        private readonly IRepository<T> _repository;
        private readonly IUnitOfWork _unitOfWork;

        protected BusinessBase(IRepository<T> repository, IUnitOfWork unitOfWork)
        {
            _repository = repository;
            _unitOfWork = unitOfWork;
        }
        
        /// <summary>
        /// Get all entity from database.
        /// </summary>
        /// <returns>List of entiy</returns>
        public virtual IEnumerable<T> GetAll()
        {
            return _repository.GetAll();
        }

        /// <summary>
        /// Get one entity by id.
        /// </summary>
        /// <param name="id">Entity id</param>
        /// <returns>Entity</returns>
        public virtual T GetSingleById(long id)
        {
            return _repository.GetSingleById(id);
        }

        /// <summary>
        /// Insert new entity into database.
        /// </summary>
        /// <param name="entity">Entity object</param>
        public virtual void Create(T entity)
        {
            _repository.Create(entity);
        }

        /// <summary>
        /// Update entity information.
        /// </summary>
        /// <param name="entity">Entity object</param>
        public abstract void Update(T entity);

        /// <summary>
        /// Delete entity by id.
        /// </summary>
        /// <param name="id">Entity id</param>
        public virtual void Delete(int id)
        {
            var entity = _repository.GetSingleById(id);
            _repository.Delete(entity);
        }

        /// <summary>
        /// Save changes in dbContext.
        /// </summary>
        public void Save()
        {
            try
            {
                _unitOfWork.Commit();
            }
            catch (Exception e)
            {
                throw new SaveChangesException("Lỗi lưu dữ liệu. ", e);
            }
        }
    }
}
