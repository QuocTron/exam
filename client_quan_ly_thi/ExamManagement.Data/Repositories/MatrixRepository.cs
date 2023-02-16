using ExamManagement.Data.Infrastructures;
using ExamManagement.Entities;
using System.Collections.Generic;
using System.Linq;

namespace ExamManagement.Data.Repositories
{
    public interface IMatrixRepository : IRepository<Matrix>
    {
        Matrix GetByName(string name);
        void DeleteDetails(int id);
        IEnumerable<MatrixDetail> GetDetails(int id);
    }

    public class MatrixRepository : RepositoryBase<Matrix>, IMatrixRepository
    {
        public MatrixRepository(IDbFactory dbFactory)
            : base(dbFactory)
        {
        }

        public void DeleteDetails(int id)
        {
            var matrixDetails = DbContext.MatrixDetails.Where(c=>c.MatrixId == id);

            if (matrixDetails == null)
            {
                return;
            }
            DbContext.MatrixDetails.RemoveRange(matrixDetails);
        }


        public IEnumerable<MatrixDetail> GetDetails(int id)
        {
            return DbContext.MatrixDetails.Where(c => c.MatrixId == id);
        }
        public Matrix GetByName(string name)
        {
            return DbContext.Matrices.FirstOrDefault(m => m.Name == name);
        }
    }
}
