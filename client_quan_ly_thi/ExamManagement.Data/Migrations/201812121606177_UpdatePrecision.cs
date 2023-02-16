namespace ExamManagement.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class UpdatePrecision : DbMigration
    {
        public override void Up()
        {
            AlterColumn("dbo.Questions", "SubjectiveDifficulty", c => c.Decimal(precision: 18, scale: 10));
            AlterColumn("dbo.Questions", "ObjectiveDifficulty", c => c.Decimal(nullable: false, precision: 18, scale: 10));
            AlterColumn("dbo.Questions", "Mark", c => c.Decimal(precision: 18, scale: 10));
            AlterColumn("dbo.Questions", "Discrimination", c => c.Decimal(precision: 18, scale: 10));
            AlterColumn("dbo.QuestionSheets", "Mark", c => c.Decimal(precision: 18, scale: 10));
            AlterColumn("dbo.QuestionSheets", "Difficulty", c => c.Decimal(precision: 18, scale: 10));
        }
        
        public override void Down()
        {
            AlterColumn("dbo.QuestionSheets", "Difficulty", c => c.Decimal(precision: 18, scale: 2));
            AlterColumn("dbo.QuestionSheets", "Mark", c => c.Decimal(precision: 18, scale: 2));
            AlterColumn("dbo.Questions", "Discrimination", c => c.Decimal(precision: 18, scale: 2));
            AlterColumn("dbo.Questions", "Mark", c => c.Decimal(precision: 18, scale: 2));
            AlterColumn("dbo.Questions", "ObjectiveDifficulty", c => c.Decimal(nullable: false, precision: 18, scale: 2));
            AlterColumn("dbo.Questions", "SubjectiveDifficulty", c => c.Decimal(precision: 18, scale: 2));
        }
    }
}
