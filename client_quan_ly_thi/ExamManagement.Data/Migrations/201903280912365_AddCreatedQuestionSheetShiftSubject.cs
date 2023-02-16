namespace ExamManagement.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddCreatedQuestionSheetShiftSubject : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.ShiftSubjects", "CreatedQuestionSheet", c => c.Boolean(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.ShiftSubjects", "CreatedQuestionSheet");
        }
    }
}
