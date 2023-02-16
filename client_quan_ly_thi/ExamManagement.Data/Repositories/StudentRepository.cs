using ExamManagement.Data.Infrastructures;
using ExamManagement.Entities;
using System.Collections.Generic;
using System.Linq;

namespace ExamManagement.Data.Repositories
{
    public interface IStudentRepository : IRepository<Student>
    {
        Student GetByCode(string code);
    }

    public class StudentRepository : RepositoryBase<Student>, IStudentRepository
    {
        public StudentRepository(IDbFactory dbFactory)
            : base(dbFactory)
        {
        }

        public Student GetByCode(string code)
        {
            return DbContext.Students.FirstOrDefault(s => s.Code == code);
        }
    }
}
