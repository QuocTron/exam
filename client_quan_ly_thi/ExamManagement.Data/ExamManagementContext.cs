
using ExamManagement.Entities;
using System.Data.Entity;

namespace ExamManagement.Data
{
    public class ExamManagementContext : DbContext
    {
        public ExamManagementContext()
            : base("ExamManagementContext")
        {
            Configuration.LazyLoadingEnabled = false;

            //Database.SetInitializer(new DBInitializer());
        }

        public DbSet<Shift> Shifts { get; set; }
        public DbSet<Question> Questions { get; set; }
        public DbSet<Answer> Answers { get; set; }
        public DbSet<QuestionSheetDetail> QuestionSheetDetails { get; set; }
        public DbSet<MatrixDetail> MatrixDetails { get; set; }
        public DbSet<PaperQuestionSheet> PaperQuestionSheets { get; set; }
        public DbSet<PaperQuestionSheetDetail> PaperQuestionSheetDetails { get; set; }
        public DbSet<PaperShiftSubject> PaperShiftSubjects { get; set; }
        public DbSet<QuestionSheet> QuestionSheets { get; set; }
        public DbSet<Exam> Exams { get; set; }
        public DbSet<Faculty> Faculties { get; set; }
        public DbSet<Semester> Semesters { get; set; }
        public DbSet<Subject> Subjects { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Chapter> Chapters { get; set; }
        public DbSet<Student> Students { get; set; }
        public DbSet<Matrix> Matrices { get; set; }
        public DbSet<ShiftSubject> ShiftSubjects { get; set; }
        public DbSet<ShiftSubjectStudent> ShiftSubjectStudents { get; set; }
        public DbSet<MarkRounding> MarkRoundings { get; set; }
        public DbSet<ExtraTimeLog> ExtraTimeLogs { get; set; }

        protected override void OnModelCreating(DbModelBuilder builder)
        {
            builder.Entity<PaperQuestionSheet>().Property(i => i.ObjectiveDifficulty).HasPrecision(18, 10);
            builder.Entity<Question>().Property(i => i.SubjectiveDifficulty).HasPrecision(18, 10);
            builder.Entity<Question>().Property(i => i.ObjectiveDifficulty).HasPrecision(18, 10);
            builder.Entity<Question>().Property(i => i.Mark).HasPrecision(18, 10);
            builder.Entity<Question>().Property(i => i.Discrimination).HasPrecision(18, 10);
            builder.Entity<QuestionSheet>().Property(i => i.Mark).HasPrecision(18, 10);
            builder.Entity<QuestionSheet>().Property(i => i.Difficulty).HasPrecision(18, 10);
        }
    }
}
