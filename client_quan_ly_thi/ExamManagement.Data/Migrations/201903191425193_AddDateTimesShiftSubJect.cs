namespace ExamManagement.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddDateTimesShiftSubJect : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.ShiftSubjects", "EndDate", c => c.DateTime());
            AddColumn("dbo.ShiftSubjects", "ActivateTime", c => c.DateTime());
        }
        
        public override void Down()
        {
            DropColumn("dbo.ShiftSubjects", "ActivateTime");
            DropColumn("dbo.ShiftSubjects", "EndDate");
        }
    }
}
