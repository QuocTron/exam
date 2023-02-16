using ExamManagement.Data.Infrastructures;
using ExamManagement.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamManagement.Data.Repositories
{
    public interface IExtratimeLogRepository : IRepository<ExtraTimeLog>
    {
    }

    class ExtraTimeLogRepository : RepositoryBase<ExtraTimeLog>, IExtratimeLogRepository
    {
        public ExtraTimeLogRepository(IDbFactory dbFactory) : base(dbFactory)
        {
        }
    }
}
