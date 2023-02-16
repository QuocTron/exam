namespace ExamManagement.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddValidateToFaculty : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Faculties", "Validated", c => c.Boolean(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.Faculties", "Validated");
        }
    }
}
