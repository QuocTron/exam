namespace ExamManagement.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddIdsForQuestionSheet : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.QuestionSheets", "StudentId", c => c.Int(nullable: false));
            AddColumn("dbo.QuestionSheets", "ShiftId", c => c.Int());
            AddColumn("dbo.QuestionSheets", "ShiftSubjectId", c => c.Long(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.QuestionSheets", "ShiftSubjectId");
            DropColumn("dbo.QuestionSheets", "ShiftId");
            DropColumn("dbo.QuestionSheets", "StudentId");
        }
    }
}
