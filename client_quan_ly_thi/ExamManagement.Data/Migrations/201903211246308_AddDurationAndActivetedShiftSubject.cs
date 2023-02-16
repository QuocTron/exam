namespace ExamManagement.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddDurationAndActivetedShiftSubject : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.ShiftSubjects", "Duration", c => c.Short());
            AddColumn("dbo.ShiftSubjects", "Activated", c => c.Boolean(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.ShiftSubjects", "Activated");
            DropColumn("dbo.ShiftSubjects", "Duration");
        }
    }
}
