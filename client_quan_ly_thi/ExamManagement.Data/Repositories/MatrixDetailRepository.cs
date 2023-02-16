using ExamManagement.Data.Infrastructures;
using ExamManagement.Entities;
using System.Collections.Generic;
using System.Linq;

namespace ExamManagement.Data.Repositories
{
    public interface IMatrixDetailRepository : IRepository<MatrixDetail>
    {
    }

    public class MatrixDetailRepository : RepositoryBase<MatrixDetail>, IMatrixDetailRepository
    {
        public MatrixDetailRepository(IDbFactory dbFactory)
            : base(dbFactory)
        {
        }
    }
}
