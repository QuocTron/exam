using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ExamManagement.Data.Infrastructures;
using ExamManagement.Entities;

namespace ExamManagement.Data.Repositories
{
    public interface IChapterRepository : IRepository<Chapter>
    {
    }

    public class ChapterRepository : RepositoryBase<Chapter>, IChapterRepository
    {
        public ChapterRepository(IDbFactory dbFactory)
            : base(dbFactory)
        {
        }
        
    }
}
