namespace ExamManagement.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class UpdateShiftSubject : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.ShiftSubjects", "StartTime", c => c.DateTime());
            AddColumn("dbo.ShiftSubjects", "EndTime", c => c.DateTime());
            AddColumn("dbo.ShiftSubjects", "Ended", c => c.Boolean());
        }
        
        public override void Down()
        {
            DropColumn("dbo.ShiftSubjects", "Ended");
            DropColumn("dbo.ShiftSubjects", "EndTime");
            DropColumn("dbo.ShiftSubjects", "StartTime");
        }
    }
}
