using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ExamManagement.Entities;

namespace ExamManagement.Data
{
    public class DBInitializer: DropCreateDatabaseAlways<ExamManagementContext>
    {
        protected override void Seed(ExamManagementContext context)
        {
            //BEGIN SEED SEMESTER
            IList<Semester> semesters = new List<Semester>();
            semesters.Add(new Semester()
            {
                Name = "1A",
                Deleted = false
            });
            semesters.Add(new Semester()
            {
                Name = "1B",
                Deleted = false
            });
            semesters.Add(new Semester()
            {
                Name = "2A",
                Deleted = false
            });
            semesters.Add(new Semester()
            {
                Name = "2B",
                Deleted = false
            });
            context.Semesters.AddRange(semesters);
            //END SEED SEMESTER

            //BEGIN SEED MARK ROUNDING
            IList<MarkRounding> markRoundings = new List<MarkRounding>();
            markRoundings.Add(new MarkRounding()
            {
                Name = "Thập phân (0.1; 0.2;...)",
                Code = "DECIMAL",
                Using = true//Default
            });
            markRoundings.Add(new MarkRounding()
            {
                Name = "0.5",
                Code = "HALF",
                Using = false
            });
            markRoundings.Add(new MarkRounding()
            {
                Name = "0.25",
                Code = "QUARTER",
                Using = false
            });
            markRoundings.Add(new MarkRounding()
            {
                Name = "Nguyên (1; 2;...)",
                Code = "INT",
                Using = false
            });
            context.MarkRoundings.AddRange(markRoundings);

            base.Seed(context);
        }
    }
}
