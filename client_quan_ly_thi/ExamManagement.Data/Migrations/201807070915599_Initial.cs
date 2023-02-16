namespace ExamManagement.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class Initial : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Answers",
                c => new
                    {
                        Id = c.Long(nullable: false, identity: true),
                        QuestionId = c.Long(),
                        Content = c.String(),
                        Order = c.Int(),
                        Correct = c.Boolean(nullable: false),
                        Interchange = c.Boolean(nullable: false),
                        SelectedTimes = c.Int(),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Questions", t => t.QuestionId)
                .Index(t => t.QuestionId);
            
            CreateTable(
                "dbo.Questions",
                c => new
                    {
                        Id = c.Long(nullable: false, identity: true),
                        Content = c.String(),
                        Interchange = c.Boolean(nullable: false),
                        SubjectiveDifficulty = c.Decimal(precision: 18, scale: 10),
                        ObjectiveDifficulty = c.Decimal(nullable: false, precision: 18, scale: 10),
                        SelectedTimes = c.Int(),
                        CorrectTimes = c.Int(),
                        ChapterId = c.Int(nullable: false),
                        CreateDate = c.DateTime(),
                        UpdateDate = c.DateTime(),
                        Mark = c.Decimal(precision: 18, scale: 10),
                        Duration = c.Int(),
                        ParentId = c.Long(nullable: false),
                        Audio = c.Boolean(nullable: false),
                        Discrimination = c.Decimal(precision: 18, scale: 10),
                        ManagementOrder = c.Int(),
                        SubjectId = c.Int(),
                        ListenedTimes = c.Int(),
                        Validated = c.Boolean(nullable: false),
                        Deleted = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Chapters", t => t.ChapterId, cascadeDelete: true)
                .Index(t => t.ChapterId);
            
            CreateTable(
                "dbo.Chapters",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(),
                        Content = c.String(),
                        Order = c.Int(),
                        ParentId = c.Int(),
                        SubjectId = c.Int(),
                        ManagementOrder = c.Int(),
                        Validated = c.Boolean(nullable: false),
                        Deleted = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Chapters", t => t.ParentId)
                .ForeignKey("dbo.Subjects", t => t.SubjectId)
                .Index(t => t.ParentId)
                .Index(t => t.SubjectId);
            
            CreateTable(
                "dbo.Subjects",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Code = c.String(),
                        Name = c.String(),
                        FacultyId = c.Int(),
                        ManagementOrder = c.Short(),
                        Validated = c.Boolean(nullable: false),
                        Deleted = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Faculties", t => t.FacultyId)
                .Index(t => t.FacultyId);
            
            CreateTable(
                "dbo.Faculties",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(),
                        Comment = c.String(),
                        Deleted = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.ShiftSubjects",
                c => new
                    {
                        Id = c.Long(nullable: false, identity: true),
                        ShiftId = c.Int(),
                        SubjectId = c.Int(),
                        MatrixId = c.Int(),
                        SubjectCode = c.String(),
                        SubjectName = c.String(),
                        GroupCode = c.String(),
                        SubGroupCode = c.String(),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Matrices", t => t.MatrixId)
                .ForeignKey("dbo.Shifts", t => t.ShiftId)
                .ForeignKey("dbo.Subjects", t => t.SubjectId)
                .Index(t => t.ShiftId)
                .Index(t => t.SubjectId)
                .Index(t => t.MatrixId);
            
            CreateTable(
                "dbo.Matrices",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        ExamId = c.Int(),
                        CreateDate = c.DateTime(),
                        Name = c.String(),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.MatrixDetails",
                c => new
                    {
                        Id = c.Long(nullable: false, identity: true),
                        MatrixId = c.Int(nullable: false),
                        ChapterId = c.Int(nullable: false),
                        Quantity = c.Int(nullable: false),
                        Excluded = c.String(),
                        Factor = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Matrices", t => t.MatrixId, cascadeDelete: true)
                .Index(t => t.MatrixId);
            
            CreateTable(
                "dbo.Shifts",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(),
                        StartTime = c.DateTime(nullable: false),
                        EndTime = c.DateTime(nullable: false),
                        Activated = c.Boolean(nullable: false),
                        ActivateTime = c.DateTime(),
                        Duration = c.Short(),
                        Ended = c.Boolean(nullable: false),
                        EndDate = c.DateTime(),
                        ExamId = c.Int(),
                        QuestionSheetCreated = c.Boolean(nullable: false),
                        Desktop = c.Boolean(nullable: false),
                        Deleted = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Exams", t => t.ExamId)
                .Index(t => t.ExamId);
            
            CreateTable(
                "dbo.Exams",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(),
                        CreateDate = c.DateTime(),
                        Desktop = c.Boolean(nullable: false),
                        Deleted = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.ShiftSubjectStudents",
                c => new
                    {
                        ShiftSubjectId = c.Long(nullable: false),
                        StudentId = c.Int(nullable: false),
                        QuestionSheetId = c.Long(),
                        LogIn = c.Boolean(nullable: false),
                        LastLogIn = c.DateTime(),
                        LastLogOut = c.DateTime(),
                    })
                .PrimaryKey(t => new { t.ShiftSubjectId, t.StudentId })
                .ForeignKey("dbo.QuestionSheets", t => t.QuestionSheetId)
                .ForeignKey("dbo.ShiftSubjects", t => t.ShiftSubjectId, cascadeDelete: true)
                .ForeignKey("dbo.Students", t => t.StudentId, cascadeDelete: true)
                .Index(t => t.ShiftSubjectId)
                .Index(t => t.StudentId)
                .Index(t => t.QuestionSheetId);
            
            CreateTable(
                "dbo.QuestionSheets",
                c => new
                    {
                        Id = c.Long(nullable: false, identity: true),
                        Name = c.String(),
                        CreateDate = c.DateTime(),
                        Approved = c.Boolean(nullable: false),
                        Started = c.Boolean(nullable: false),
                        Completed = c.Boolean(nullable: false),
                        ExtraTime = c.Byte(nullable: false),
                        ExtraTimeReason = c.String(),
                        Mark = c.Decimal(precision: 18, scale: 10),
                        NumberOfCorrect = c.Short(),
                        Total = c.Short(),
                        Difficulty = c.Decimal(precision: 18, scale: 10),
                        UserId = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.QuestionSheetDetails",
                c => new
                    {
                        QuestionSheetId = c.Long(nullable: false),
                        QuestionId = c.Long(nullable: false),
                        Order = c.Short(),
                        AnswerId = c.Long(),
                        Correct = c.Boolean(),
                        CreateDate = c.DateTime(),
                        UpdateDate = c.DateTime(),
                        ListenTimes = c.Byte(),
                        Desktop = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => new { t.QuestionSheetId, t.QuestionId })
                .ForeignKey("dbo.Questions", t => t.QuestionId, cascadeDelete: true)
                .ForeignKey("dbo.QuestionSheets", t => t.QuestionSheetId, cascadeDelete: true)
                .Index(t => t.QuestionSheetId)
                .Index(t => t.QuestionId);
            
            CreateTable(
                "dbo.Students",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Code = c.String(),
                        LastName = c.String(),
                        FirstName = c.String(),
                        ClassName = c.String(),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.Semesters",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(),
                        Comment = c.String(),
                        Deleted = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.Users",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Username = c.String(),
                        Password = c.String(),
                        Salt = c.String(),
                        Name = c.String(),
                        CreateDate = c.DateTime(),
                        LogOut = c.Boolean(nullable: false),
                        LastActivity = c.DateTime(),
                        LastLogIn = c.DateTime(),
                        LastPasswordChanged = c.DateTime(),
                        LastLogOut = c.DateTime(),
                        Comment = c.String(),
                        BuildInUser = c.Boolean(nullable: false),
                        Deleted = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.Id);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.ShiftSubjects", "SubjectId", "dbo.Subjects");
            DropForeignKey("dbo.ShiftSubjectStudents", "StudentId", "dbo.Students");
            DropForeignKey("dbo.ShiftSubjectStudents", "ShiftSubjectId", "dbo.ShiftSubjects");
            DropForeignKey("dbo.ShiftSubjectStudents", "QuestionSheetId", "dbo.QuestionSheets");
            DropForeignKey("dbo.QuestionSheetDetails", "QuestionSheetId", "dbo.QuestionSheets");
            DropForeignKey("dbo.QuestionSheetDetails", "QuestionId", "dbo.Questions");
            DropForeignKey("dbo.ShiftSubjects", "ShiftId", "dbo.Shifts");
            DropForeignKey("dbo.Shifts", "ExamId", "dbo.Exams");
            DropForeignKey("dbo.ShiftSubjects", "MatrixId", "dbo.Matrices");
            DropForeignKey("dbo.MatrixDetails", "MatrixId", "dbo.Matrices");
            DropForeignKey("dbo.Subjects", "FacultyId", "dbo.Faculties");
            DropForeignKey("dbo.Chapters", "SubjectId", "dbo.Subjects");
            DropForeignKey("dbo.Questions", "ChapterId", "dbo.Chapters");
            DropForeignKey("dbo.Chapters", "ParentId", "dbo.Chapters");
            DropForeignKey("dbo.Answers", "QuestionId", "dbo.Questions");
            DropIndex("dbo.QuestionSheetDetails", new[] { "QuestionId" });
            DropIndex("dbo.QuestionSheetDetails", new[] { "QuestionSheetId" });
            DropIndex("dbo.ShiftSubjectStudents", new[] { "QuestionSheetId" });
            DropIndex("dbo.ShiftSubjectStudents", new[] { "StudentId" });
            DropIndex("dbo.ShiftSubjectStudents", new[] { "ShiftSubjectId" });
            DropIndex("dbo.Shifts", new[] { "ExamId" });
            DropIndex("dbo.MatrixDetails", new[] { "MatrixId" });
            DropIndex("dbo.ShiftSubjects", new[] { "MatrixId" });
            DropIndex("dbo.ShiftSubjects", new[] { "SubjectId" });
            DropIndex("dbo.ShiftSubjects", new[] { "ShiftId" });
            DropIndex("dbo.Subjects", new[] { "FacultyId" });
            DropIndex("dbo.Chapters", new[] { "SubjectId" });
            DropIndex("dbo.Chapters", new[] { "ParentId" });
            DropIndex("dbo.Questions", new[] { "ChapterId" });
            DropIndex("dbo.Answers", new[] { "QuestionId" });
            DropTable("dbo.Users");
            DropTable("dbo.Semesters");
            DropTable("dbo.Students");
            DropTable("dbo.QuestionSheetDetails");
            DropTable("dbo.QuestionSheets");
            DropTable("dbo.ShiftSubjectStudents");
            DropTable("dbo.Exams");
            DropTable("dbo.Shifts");
            DropTable("dbo.MatrixDetails");
            DropTable("dbo.Matrices");
            DropTable("dbo.ShiftSubjects");
            DropTable("dbo.Faculties");
            DropTable("dbo.Subjects");
            DropTable("dbo.Chapters");
            DropTable("dbo.Questions");
            DropTable("dbo.Answers");
        }
    }
}
