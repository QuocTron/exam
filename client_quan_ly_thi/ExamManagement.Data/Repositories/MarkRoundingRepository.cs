using System.Collections.Generic;
using System.Linq;
using ExamManagement.Entities;
using ExamManagement.Data.Infrastructures;

namespace ExamManagement.Data.Repositories
{
    public interface IMarkRoundingRepository : IRepository<MarkRounding>
    {
        IEnumerable<MarkRounding> GetMarkRoundings();
        MarkRounding GetUsingMarkRounding();
    }
    public class MarkRoundingRepository : RepositoryBase<MarkRounding>, IMarkRoundingRepository
    {
        public MarkRoundingRepository(IDbFactory dbFactory) : base(dbFactory)
        {
        }

        public IEnumerable<MarkRounding> GetMarkRoundings()
        {
            return DbContext.MarkRoundings.Select(c=>c);
        }

        public MarkRounding GetUsingMarkRounding()
        {
            return DbContext.MarkRoundings.Single(mr => mr.Using);
        }
    }
}
