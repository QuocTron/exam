namespace ExamManagement.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddExtraTimeLog : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.ExtraTimeLogs",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Reason = c.String(maxLength: 100),
                        ExtraTime = c.Short(nullable: false),
                        QuestionSheetId = c.Long(),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.QuestionSheets", t => t.QuestionSheetId)
                .Index(t => t.QuestionSheetId);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.ExtraTimeLogs", "QuestionSheetId", "dbo.QuestionSheets");
            DropIndex("dbo.ExtraTimeLogs", new[] { "QuestionSheetId" });
            DropTable("dbo.ExtraTimeLogs");
        }
    }
}
