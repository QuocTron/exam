namespace ExamManagement.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class DeleteTimeShift : DbMigration
    {
        public override void Up()
        {
            DropColumn("dbo.Shifts", "StartTime");
            DropColumn("dbo.Shifts", "EndTime");
            DropColumn("dbo.Shifts", "Activated");
            DropColumn("dbo.Shifts", "ActivateTime");
            DropColumn("dbo.Shifts", "Duration");
            DropColumn("dbo.Shifts", "Ended");
            DropColumn("dbo.Shifts", "EndDate");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Shifts", "EndDate", c => c.DateTime());
            AddColumn("dbo.Shifts", "Ended", c => c.Boolean(nullable: false));
            AddColumn("dbo.Shifts", "Duration", c => c.Short());
            AddColumn("dbo.Shifts", "ActivateTime", c => c.DateTime());
            AddColumn("dbo.Shifts", "Activated", c => c.Boolean(nullable: false));
            AddColumn("dbo.Shifts", "EndTime", c => c.DateTime(nullable: false));
            AddColumn("dbo.Shifts", "StartTime", c => c.DateTime(nullable: false));
        }
    }
}
