namespace ExamManagement.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class MapWithHieu : DbMigration
    {
        public override void Up()
        {
            AlterColumn("dbo.MatrixDetails", "Factor", c => c.Int());
        }
        
        public override void Down()
        {
            AlterColumn("dbo.MatrixDetails", "Factor", c => c.Int(nullable: false));
        }
    }
}
