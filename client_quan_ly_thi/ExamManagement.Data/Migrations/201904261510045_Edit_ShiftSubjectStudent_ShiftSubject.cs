namespace ExamManagement.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class Edit_ShiftSubjectStudent_ShiftSubject : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.ShiftSubjects", "StateActivate", c => c.Byte());
            AddColumn("dbo.ShiftSubjectStudents", "StateExam", c => c.Byte());
            DropColumn("dbo.ShiftSubjects", "Activated");
        }
        
        public override void Down()
        {
            AddColumn("dbo.ShiftSubjects", "Activated", c => c.Boolean(nullable: false));
            DropColumn("dbo.ShiftSubjectStudents", "StateExam");
            DropColumn("dbo.ShiftSubjects", "StateActivate");
        }
    }
}
