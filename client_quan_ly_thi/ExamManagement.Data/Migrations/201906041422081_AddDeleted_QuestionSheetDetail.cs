namespace ExamManagement.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddDeleted_QuestionSheetDetail : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.QuestionSheetDetails", "Deleted", c => c.Boolean(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.QuestionSheetDetails", "Deleted");
        }
    }
}
