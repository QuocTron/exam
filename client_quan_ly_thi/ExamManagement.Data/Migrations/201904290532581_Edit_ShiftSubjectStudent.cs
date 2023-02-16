namespace ExamManagement.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class Edit_ShiftSubjectStudent : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.ShiftSubjectStudents", "InsertTime", c => c.DateTime(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.ShiftSubjectStudents", "InsertTime");
        }
    }
}
