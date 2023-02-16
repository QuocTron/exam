using ExamManagement.Data.Infrastructures;
using ExamManagement.Entities;
using System.Data.SqlClient;
using System.Linq;

namespace ExamManagement.Data.Repositories
{
    public interface IShiftRepository : IRepository<Shift>
    {
        Shift GetByName(string name);
        byte GetMaxExtraTime(int shiftId);
        string GetResultById(int shiftId);
    }

    public class ShiftRepository : RepositoryBase<Shift>, IShiftRepository
    {
        public ShiftRepository(IDbFactory dbFactory)
            : base(dbFactory)
        {
        }

        public Shift GetByName(string name)
        {
            return DbContext.Shifts.FirstOrDefault(s => s.Name == name);
        }

        public byte GetMaxExtraTime(int shiftId)
        {
            var shiftSubjectIds = DbContext.ShiftSubjects
                .Where(s => s.ShiftId == shiftId)
                .Select(s => s.Id);

            var questionSheetIds = DbContext.ShiftSubjectStudents
                .Where(s => shiftSubjectIds.Contains(s.ShiftSubjectId))
                .Select(s => s.QuestionSheetId);

            var extraTimes = DbContext.QuestionSheets.Where(q => questionSheetIds.Contains(q.Id)).Select(q => q.ExtraTime).ToList();

            return extraTimes.Max();
        }

        public string GetResultById(int shiftId)
        {
            var parameter = new SqlParameter("@ShiftId",shiftId);
            var jsonReturned = DbContext.Database.SqlQuery<string>("exec GetResultById @ShiftId", parameter).ToList();
            var combinedJson = string.Join("", jsonReturned);

            return combinedJson;
        }
    }
}
