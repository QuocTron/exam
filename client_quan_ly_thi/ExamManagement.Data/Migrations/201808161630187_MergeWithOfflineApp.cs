namespace ExamManagement.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class MergeWithOfflineApp : DbMigration
    {
        public override void Up()
        {
            DropForeignKey("dbo.Chapters", "ParentId", "dbo.Chapters");
            DropIndex("dbo.Chapters", new[] { "ParentId" });
            CreateTable(
                "dbo.PaperShiftSubjects",
                c => new
                    {
                        Id = c.Long(nullable: false, identity: true),
                        ShiftId = c.Int(),
                        SubjectId = c.Int(),
                        MatrixId = c.Int(),
                        Deleted = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Matrices", t => t.MatrixId)
                .ForeignKey("dbo.Shifts", t => t.ShiftId)
                .Index(t => t.ShiftId)
                .Index(t => t.MatrixId);
            
            CreateTable(
                "dbo.PaperQuestionSheets",
                c => new
                    {
                        Id = c.Long(nullable: false, identity: true),
                        Name = c.String(maxLength: 200),
                        CreateDate = c.DateTime(),
                        ExportDate = c.DateTime(),
                        TestDate = c.DateTime(),
                        Duration = c.Int(),
                        Exported = c.Boolean(),
                        PaperShiftSubjectId = c.Long(),
                        ObjectiveDifficulty = c.Decimal(precision: 18, scale: 2),
                        Total = c.Int(),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.PaperShiftSubjects", t => t.PaperShiftSubjectId)
                .Index(t => t.PaperShiftSubjectId);
            
            CreateTable(
                "dbo.PaperQuestionSheetDetails",
                c => new
                    {
                        PaperQuestionSheetId = c.Long(nullable: false),
                        QuestionId = c.Long(nullable: false),
                        Order = c.Int(),
                    })
                .PrimaryKey(t => new { t.PaperQuestionSheetId, t.QuestionId })
                .ForeignKey("dbo.PaperQuestionSheets", t => t.PaperQuestionSheetId, cascadeDelete: true)
                .Index(t => t.PaperQuestionSheetId);
            
            CreateTable(
                "dbo.Roles",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(maxLength: 50),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.RoleUsers",
                c => new
                    {
                        Role_Id = c.Int(nullable: false),
                        User_Id = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.Role_Id, t.User_Id })
                .ForeignKey("dbo.Roles", t => t.Role_Id, cascadeDelete: true)
                .ForeignKey("dbo.Users", t => t.User_Id, cascadeDelete: true)
                .Index(t => t.Role_Id)
                .Index(t => t.User_Id);
            
            AddColumn("dbo.Matrices", "SubjectId", c => c.Int());
            AddColumn("dbo.Exams", "UserId", c => c.Int());
            AddColumn("dbo.Students", "Name", c => c.String(maxLength: 50));
            AddColumn("dbo.Users", "FacultyId", c => c.String(maxLength: 10));
            AddColumn("dbo.Users", "SubjectId", c => c.String(maxLength: 10));
            AlterColumn("dbo.Chapters", "Name", c => c.String(maxLength: 100));
            AlterColumn("dbo.Chapters", "Content", c => c.String(maxLength: 1000));
            AlterColumn("dbo.Subjects", "Code", c => c.String(maxLength: 12));
            AlterColumn("dbo.Subjects", "Name", c => c.String(maxLength: 100));
            AlterColumn("dbo.Faculties", "Name", c => c.String(maxLength: 100));
            AlterColumn("dbo.Faculties", "Comment", c => c.String(maxLength: 100));
            AlterColumn("dbo.Matrices", "Name", c => c.String(maxLength: 100));
            AlterColumn("dbo.Shifts", "Name", c => c.String(maxLength: 50));
            AlterColumn("dbo.Exams", "Name", c => c.String(maxLength: 50));
            AlterColumn("dbo.QuestionSheets", "Name", c => c.String(maxLength: 100));
            AlterColumn("dbo.QuestionSheets", "ExtraTimeReason", c => c.String(maxLength: 100));
            AlterColumn("dbo.QuestionSheets", "UserId", c => c.Int());
            AlterColumn("dbo.QuestionSheetDetails", "Correct", c => c.Boolean(nullable: false));
            AlterColumn("dbo.Students", "Code", c => c.String(maxLength: 100));
            AlterColumn("dbo.Students", "LastName", c => c.String(maxLength: 50));
            AlterColumn("dbo.Students", "FirstName", c => c.String(maxLength: 50));
            AlterColumn("dbo.Users", "Username", c => c.String(maxLength: 50));
            AlterColumn("dbo.Users", "Password", c => c.String(maxLength: 128));
            AlterColumn("dbo.Users", "Salt", c => c.String(maxLength: 50));
            AlterColumn("dbo.Users", "Name", c => c.String(maxLength: 50));
            AlterColumn("dbo.Users", "Comment", c => c.String(maxLength: 100));
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.RoleUsers", "User_Id", "dbo.Users");
            DropForeignKey("dbo.RoleUsers", "Role_Id", "dbo.Roles");
            DropForeignKey("dbo.PaperShiftSubjects", "ShiftId", "dbo.Shifts");
            DropForeignKey("dbo.PaperQuestionSheets", "PaperShiftSubjectId", "dbo.PaperShiftSubjects");
            DropForeignKey("dbo.PaperQuestionSheetDetails", "PaperQuestionSheetId", "dbo.PaperQuestionSheets");
            DropForeignKey("dbo.PaperShiftSubjects", "MatrixId", "dbo.Matrices");
            DropIndex("dbo.RoleUsers", new[] { "User_Id" });
            DropIndex("dbo.RoleUsers", new[] { "Role_Id" });
            DropIndex("dbo.PaperQuestionSheetDetails", new[] { "PaperQuestionSheetId" });
            DropIndex("dbo.PaperQuestionSheets", new[] { "PaperShiftSubjectId" });
            DropIndex("dbo.PaperShiftSubjects", new[] { "MatrixId" });
            DropIndex("dbo.PaperShiftSubjects", new[] { "ShiftId" });
            AlterColumn("dbo.Users", "Comment", c => c.String());
            AlterColumn("dbo.Users", "Name", c => c.String());
            AlterColumn("dbo.Users", "Salt", c => c.String());
            AlterColumn("dbo.Users", "Password", c => c.String());
            AlterColumn("dbo.Users", "Username", c => c.String());
            AlterColumn("dbo.Students", "FirstName", c => c.String());
            AlterColumn("dbo.Students", "LastName", c => c.String());
            AlterColumn("dbo.Students", "Code", c => c.String());
            AlterColumn("dbo.QuestionSheetDetails", "Correct", c => c.Boolean());
            AlterColumn("dbo.QuestionSheets", "UserId", c => c.Int(nullable: false));
            AlterColumn("dbo.QuestionSheets", "ExtraTimeReason", c => c.String());
            AlterColumn("dbo.QuestionSheets", "Name", c => c.String());
            AlterColumn("dbo.Exams", "Name", c => c.String());
            AlterColumn("dbo.Shifts", "Name", c => c.String());
            AlterColumn("dbo.Matrices", "Name", c => c.String());
            AlterColumn("dbo.Faculties", "Comment", c => c.String());
            AlterColumn("dbo.Faculties", "Name", c => c.String());
            AlterColumn("dbo.Subjects", "Name", c => c.String());
            AlterColumn("dbo.Subjects", "Code", c => c.String());
            AlterColumn("dbo.Chapters", "Content", c => c.String());
            AlterColumn("dbo.Chapters", "Name", c => c.String());
            DropColumn("dbo.Users", "SubjectId");
            DropColumn("dbo.Users", "FacultyId");
            DropColumn("dbo.Students", "Name");
            DropColumn("dbo.Exams", "UserId");
            DropColumn("dbo.Matrices", "SubjectId");
            DropTable("dbo.RoleUsers");
            DropTable("dbo.Roles");
            DropTable("dbo.PaperQuestionSheetDetails");
            DropTable("dbo.PaperQuestionSheets");
            DropTable("dbo.PaperShiftSubjects");
            CreateIndex("dbo.Chapters", "ParentId");
            AddForeignKey("dbo.Chapters", "ParentId", "dbo.Chapters", "Id");
        }
    }
}
