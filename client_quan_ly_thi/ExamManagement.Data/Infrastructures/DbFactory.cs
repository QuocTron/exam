using System;

namespace ExamManagement.Data.Infrastructures
{
    public interface IDbFactory : IDisposable
    {
        ExamManagementContext Init();
    }

    public class DbFactory : Disposable, IDbFactory
    {
        private ExamManagementContext _dbContext;

        public ExamManagementContext Init()
        {
            return _dbContext ?? (_dbContext = new ExamManagementContext());
        }

        protected override void DisposeCore()
        {
            _dbContext?.Dispose();
        }
    }
}