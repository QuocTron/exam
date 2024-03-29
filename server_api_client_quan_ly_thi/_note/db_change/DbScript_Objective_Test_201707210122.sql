USE [master]
GO
/****** Object:  Database [ObjectiveTest]    Script Date: 21/07/2017 1:21:38 AM ******/
CREATE DATABASE [ObjectiveTest]
GO
ALTER DATABASE [ObjectiveTest] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ObjectiveTest].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ObjectiveTest] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ObjectiveTest] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ObjectiveTest] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ObjectiveTest] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ObjectiveTest] SET ARITHABORT OFF 
GO
ALTER DATABASE [ObjectiveTest] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ObjectiveTest] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ObjectiveTest] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ObjectiveTest] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ObjectiveTest] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ObjectiveTest] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ObjectiveTest] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ObjectiveTest] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ObjectiveTest] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ObjectiveTest] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ObjectiveTest] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ObjectiveTest] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ObjectiveTest] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ObjectiveTest] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ObjectiveTest] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ObjectiveTest] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ObjectiveTest] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ObjectiveTest] SET RECOVERY FULL 
GO
ALTER DATABASE [ObjectiveTest] SET  MULTI_USER 
GO
ALTER DATABASE [ObjectiveTest] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ObjectiveTest] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ObjectiveTest] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ObjectiveTest] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ObjectiveTest] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ObjectiveTest', N'ON'
GO
ALTER DATABASE [ObjectiveTest] SET QUERY_STORE = OFF
GO
USE [ObjectiveTest]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [ObjectiveTest]
GO
/****** Object:  Table [dbo].[Questions]    Script Date: 21/07/2017 1:21:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questions](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Content] [nvarchar](max) NULL,
	[Interchange] [bit] NOT NULL,
	[SubjectiveDifficulty] [decimal](18, 10) NULL,
	[ObjectiveDifficulty] [decimal](18, 10) NOT NULL,
	[SelectedTimes] [int] NULL,
	[CorrectTimes] [int] NULL,
	[ChapterId] [int] NOT NULL,
	[CreateDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[Mark] [decimal](18, 10) NULL,
	[Duration] [int] NULL,
	[ParentId] [bigint] NOT NULL,
	[Audio] [bit] NOT NULL,
	[Discrimination] [decimal](18, 10) NULL,
	[ManagementOrder] [int] NULL,
	[SubjectId] [int] NULL,
	[ListenedTimes] [int] NULL,
	[Validated] [bit] NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_CauHoi] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestionSheetDetails]    Script Date: 21/07/2017 1:21:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionSheetDetails](
	[QuestionSheetId] [bigint] NOT NULL,
	[QuestionId] [bigint] NOT NULL,
	[Order] [smallint] NULL,
	[AnswerId] [bigint] NULL,
	[Correct] [bit] NOT NULL,
	[CreateDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[ListenTimes] [tinyint] NULL,
	[Desktop] [bit] NOT NULL,
 CONSTRAINT [PK_ChiTietDeThi] PRIMARY KEY CLUSTERED 
(
	[QuestionSheetId] ASC,
	[QuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[QuestionV]    Script Date: 21/07/2017 1:21:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[QuestionV]
as
SELECT        Id, [Content], Interchange, SubjectiveDifficulty, SelectedTimes, CorrectTimes, Deleted, ChapterId, CreateDate, UpdateDate, Mark, Duration, ParentId, Audio, Discrimination, ManagementOrder, SubjectId, 
                         ListenedTimes, ObjectiveDifficulty
FROM            dbo.Questions
WHERE        (Id IN
                             (SELECT        QuestionId
                               FROM            dbo.QuestionSheetDetails))





GO
/****** Object:  Table [dbo].[Answers]    Script Date: 21/07/2017 1:21:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Answers](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[QuestionId] [bigint] NULL,
	[Content] [nvarchar](max) NULL,
	[Order] [int] NULL,
	[Correct] [bit] NOT NULL,
	[Interchange] [bit] NOT NULL,
	[SelectedTimes] [int] NULL,
 CONSTRAINT [PK_CauTraLoi] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[AnswersV]    Script Date: 21/07/2017 1:21:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[AnswersV]
as
SELECT        Id, QuestionId, [Content], [Order], Correct, Interchange, SelectedTimes
FROM            dbo.Answers
WHERE        (Id IN
                             (SELECT        AnswerId
                               FROM            dbo.QuestionSheetDetails))




GO
/****** Object:  View [dbo].[QuestionsV]    Script Date: 21/07/2017 1:21:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[QuestionsV]
as
SELECT        Id, [Content], Interchange, SubjectiveDifficulty, SelectedTimes, CorrectTimes, Deleted, ChapterId, CreateDate, UpdateDate, Mark, Duration, ParentId, Audio, Discrimination, ManagementOrder, SubjectId, 
                         ListenedTimes, ObjectiveDifficulty
FROM            dbo.Questions
WHERE        (Id IN
                             (SELECT        QuestionId
                               FROM            dbo.QuestionSheetDetails))





GO
/****** Object:  Table [dbo].[Chapters]    Script Date: 21/07/2017 1:21:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chapters](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Content] [nvarchar](1000) NULL,
	[Order] [int] NULL,
	[ParentId] [int] NULL,
	[SubjectId] [int] NULL,
	[ManagementOrder] [int] NULL,
	[Validated] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_Phan] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exams]    Script Date: 21/07/2017 1:21:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exams](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[UserId] [int] NULL,
	[Desktop] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_DotThi] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Faculties]    Script Date: 21/07/2017 1:21:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faculties](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Comment] [nvarchar](100) NULL,
	[Validated] [bit] NOT NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_Khoa] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Matrices]    Script Date: 21/07/2017 1:21:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Matrices](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SubjectId] [int] NULL,
	[CreateDate] [datetime] NULL,
	[Name] [nvarchar](100) NULL,
 CONSTRAINT [PK_YeuCauRutTrich] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MatrixDetails]    Script Date: 21/07/2017 1:21:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MatrixDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MatrixId] [int] NOT NULL,
	[ChapterId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Excluded] [nvarchar](1000) NULL,
 CONSTRAINT [PK_ChiTietYeuCauRutTrich_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaperQuestionSheetDetails]    Script Date: 21/07/2017 1:21:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaperQuestionSheetDetails](
	[PaperQuestionSheetId] [bigint] NOT NULL,
	[QuestionId] [bigint] NOT NULL,
	[Order] [int] NULL,
 CONSTRAINT [PK_PaperQuestionSheetDetails] PRIMARY KEY CLUSTERED 
(
	[PaperQuestionSheetId] ASC,
	[QuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaperQuestionSheets]    Script Date: 21/07/2017 1:21:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaperQuestionSheets](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[CreateDate] [datetime] NULL,
	[ExportDate] [datetime] NULL,
	[TestDate] [datetime] NULL,
	[Duration] [int] NULL,
	[Exported] [bit] NULL,
	[PaperShiftSubjectId] [bigint] NULL,
	[ObjectiveDifficulty] [decimal](18, 10) NULL,
	[Total] [int] NULL,
 CONSTRAINT [PK_PaperQuestionSheets] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaperShiftSubjects]    Script Date: 21/07/2017 1:21:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaperShiftSubjects](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ShiftId] [int] NULL,
	[SubjectId] [int] NULL,
	[MatrixId] [int] NULL,
 CONSTRAINT [PK_PaperShiftSubjects] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestionSheets]    Script Date: 21/07/2017 1:21:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionSheets](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[CreateDate] [datetime] NULL,
	[Approved] [bit] NOT NULL,
	[Started] [bit] NOT NULL,
	[Completed] [bit] NOT NULL,
	[ExtraTime] [tinyint] NOT NULL,
	[ExtraTimeReason] [nvarchar](100) NULL,
	[Mark] [decimal](18, 2) NULL,
	[NumberOfCorrect] [smallint] NULL,
	[Total] [smallint] NULL,
	[Difficulty] [decimal](18, 10) NULL,
	[UserId] [int] NULL,
 CONSTRAINT [PK_DeThi] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 21/07/2017 1:21:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Quyen] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shifts]    Script Date: 21/07/2017 1:21:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shifts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[Activated] [bit] NOT NULL,
	[ActivateTime] [datetime] NULL,
	[Duration] [smallint] NULL,
	[Ended] [bit] NOT NULL,
	[EndDate] [datetime] NULL,
	[ExamId] [int] NULL,
	[QuestionSheetCreated] [bit] NOT NULL,
	[Desktop] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_CaThi] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShiftSubjects]    Script Date: 21/07/2017 1:21:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShiftSubjects](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ShiftId] [int] NULL,
	[SubjectId] [int] NULL,
	[MatrixId] [int] NULL,
 CONSTRAINT [PK_CaThi_MonHoc] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShiftSubjectStudents]    Script Date: 21/07/2017 1:21:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShiftSubjectStudents](
	[ShiftSubjectId] [bigint] NOT NULL,
	[StudentId] [int] NOT NULL,
	[QuestionSheetId] [bigint] NULL,
	[LogIn] [bit] NOT NULL,
	[LastLogIn] [datetime] NULL,
	[LastLogOut] [datetime] NULL,
 CONSTRAINT [PK_CaThi_MonHoc_SinhVien] PRIMARY KEY CLUSTERED 
(
	[ShiftSubjectId] ASC,
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 21/07/2017 1:21:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](100) NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_SinhVien] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subjects]    Script Date: 21/07/2017 1:21:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subjects](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](12) NULL,
	[Name] [nvarchar](100) NULL,
	[FacultyId] [int] NULL,
	[ManagementOrder] [smallint] NULL,
	[Validated] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_MonHoc] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 21/07/2017 1:21:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_ChiTietQuyen] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 21/07/2017 1:21:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NULL,
	[Password] [nvarchar](128) NULL,
	[Salt] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LogOut] [bit] NOT NULL,
	[LastActivity] [datetime] NULL,
	[LastLogIn] [datetime] NULL,
	[LastLogOut] [datetime] NULL,
	[LastPasswordChanged] [datetime] NULL,
	[Comment] [nvarchar](100) NULL,
	[BuildInUser] [bit] NOT NULL,
	[FacultyId] [nchar](10) NULL,
	[SubjectId] [nchar](10) NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_NguoiDung] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Chapters] ADD  CONSTRAINT [DF_Chapters_validated]  DEFAULT ((1)) FOR [Validated]
GO
ALTER TABLE [dbo].[Chapters] ADD  CONSTRAINT [DF_Phan_XoaTam]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Exams] ADD  CONSTRAINT [DF_DotThi_NgayTao]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Exams] ADD  CONSTRAINT [DF_Exams_Desktop]  DEFAULT ((0)) FOR [Desktop]
GO
ALTER TABLE [dbo].[Faculties] ADD  CONSTRAINT [DF_Faculties_validated]  DEFAULT ((1)) FOR [Validated]
GO
ALTER TABLE [dbo].[Faculties] ADD  CONSTRAINT [DF_Khoa_XoaTam]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[PaperQuestionSheets] ADD  CONSTRAINT [DF_PaperQuestionSheets_Exported]  DEFAULT ((0)) FOR [Exported]
GO
ALTER TABLE [dbo].[Questions] ADD  CONSTRAINT [DF_CauHoi_HoanVi]  DEFAULT ((1)) FOR [Interchange]
GO
ALTER TABLE [dbo].[Questions] ADD  CONSTRAINT [DF_CauHoi_DoKho]  DEFAULT ((0.5)) FOR [SubjectiveDifficulty]
GO
ALTER TABLE [dbo].[Questions] ADD  CONSTRAINT [DF_CauHoi_SoLanDuocThi]  DEFAULT ((0)) FOR [SelectedTimes]
GO
ALTER TABLE [dbo].[Questions] ADD  CONSTRAINT [DF_CauHoi_SoLanDung]  DEFAULT ((0)) FOR [CorrectTimes]
GO
ALTER TABLE [dbo].[Questions] ADD  CONSTRAINT [DF_CauHoi_NgayTao]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Questions] ADD  CONSTRAINT [DF_CauHoi_NgaySua]  DEFAULT (getdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[Questions] ADD  CONSTRAINT [DF_Questions_validated]  DEFAULT ((1)) FOR [Validated]
GO
ALTER TABLE [dbo].[Questions] ADD  CONSTRAINT [DF_CauHoi_XoaTam]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[QuestionSheetDetails] ADD  CONSTRAINT [DF_QuestionSheetDetails_Desktop]  DEFAULT ((0)) FOR [Desktop]
GO
ALTER TABLE [dbo].[QuestionSheets] ADD  CONSTRAINT [DF_QuestionSheets_Approved]  DEFAULT ((0)) FOR [Approved]
GO
ALTER TABLE [dbo].[QuestionSheets] ADD  CONSTRAINT [DF_QuestionSheets_Started]  DEFAULT ((0)) FOR [Started]
GO
ALTER TABLE [dbo].[QuestionSheets] ADD  CONSTRAINT [DF_QuestionSheets_Completed]  DEFAULT ((0)) FOR [Completed]
GO
ALTER TABLE [dbo].[Shifts] ADD  CONSTRAINT [DF_Shifts_Activated]  DEFAULT ((0)) FOR [Activated]
GO
ALTER TABLE [dbo].[Shifts] ADD  CONSTRAINT [DF_Shifts_Ended]  DEFAULT ((0)) FOR [Ended]
GO
ALTER TABLE [dbo].[Shifts] ADD  CONSTRAINT [DF_Shifts_QuestionSheetCreated]  DEFAULT ((0)) FOR [QuestionSheetCreated]
GO
ALTER TABLE [dbo].[Shifts] ADD  CONSTRAINT [DF_Shifts_Desktop]  DEFAULT ((0)) FOR [Desktop]
GO
ALTER TABLE [dbo].[Shifts] ADD  CONSTRAINT [DF_Shifts_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[ShiftSubjectStudents] ADD  CONSTRAINT [DF_ShiftSubjectStudents_LogIn]  DEFAULT ((0)) FOR [LogIn]
GO
ALTER TABLE [dbo].[ShiftSubjectStudents] ADD  CONSTRAINT [DF_ShiftSubjectStudents_LastLogIn]  DEFAULT ((0)) FOR [LastLogIn]
GO
ALTER TABLE [dbo].[ShiftSubjectStudents] ADD  CONSTRAINT [DF_ShiftSubjectStudents_LastLogOut]  DEFAULT ((0)) FOR [LastLogOut]
GO
ALTER TABLE [dbo].[Subjects] ADD  CONSTRAINT [DF_Subjects_validated]  DEFAULT ((1)) FOR [Validated]
GO
ALTER TABLE [dbo].[Subjects] ADD  CONSTRAINT [DF_MonHoc_XoaTam]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Answers]  WITH CHECK ADD  CONSTRAINT [FK_CauTraLoi_CauHoi] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Questions] ([Id])
GO
ALTER TABLE [dbo].[Answers] CHECK CONSTRAINT [FK_CauTraLoi_CauHoi]
GO
ALTER TABLE [dbo].[Chapters]  WITH CHECK ADD  CONSTRAINT [FK_Phan_MonHoc] FOREIGN KEY([SubjectId])
REFERENCES [dbo].[Subjects] ([Id])
GO
ALTER TABLE [dbo].[Chapters] CHECK CONSTRAINT [FK_Phan_MonHoc]
GO
ALTER TABLE [dbo].[MatrixDetails]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietYeuCauRutTrich_YeuCauRutTrich1] FOREIGN KEY([MatrixId])
REFERENCES [dbo].[Matrices] ([Id])
GO
ALTER TABLE [dbo].[MatrixDetails] CHECK CONSTRAINT [FK_ChiTietYeuCauRutTrich_YeuCauRutTrich1]
GO
ALTER TABLE [dbo].[PaperQuestionSheetDetails]  WITH CHECK ADD  CONSTRAINT [FK_PaperQuestionSheetDetails_PaperQuestionSheets] FOREIGN KEY([PaperQuestionSheetId])
REFERENCES [dbo].[PaperQuestionSheets] ([Id])
GO
ALTER TABLE [dbo].[PaperQuestionSheetDetails] CHECK CONSTRAINT [FK_PaperQuestionSheetDetails_PaperQuestionSheets]
GO
ALTER TABLE [dbo].[PaperQuestionSheets]  WITH CHECK ADD  CONSTRAINT [FK_PaperQuestionSheets_PaperShiftSubjects] FOREIGN KEY([PaperShiftSubjectId])
REFERENCES [dbo].[PaperShiftSubjects] ([Id])
GO
ALTER TABLE [dbo].[PaperQuestionSheets] CHECK CONSTRAINT [FK_PaperQuestionSheets_PaperShiftSubjects]
GO
ALTER TABLE [dbo].[PaperShiftSubjects]  WITH CHECK ADD  CONSTRAINT [FK_PaperShiftSubjects_Matrices] FOREIGN KEY([MatrixId])
REFERENCES [dbo].[Matrices] ([Id])
GO
ALTER TABLE [dbo].[PaperShiftSubjects] CHECK CONSTRAINT [FK_PaperShiftSubjects_Matrices]
GO
ALTER TABLE [dbo].[PaperShiftSubjects]  WITH CHECK ADD  CONSTRAINT [FK_PaperShiftSubjects_Shifts] FOREIGN KEY([ShiftId])
REFERENCES [dbo].[Shifts] ([Id])
GO
ALTER TABLE [dbo].[PaperShiftSubjects] CHECK CONSTRAINT [FK_PaperShiftSubjects_Shifts]
GO
ALTER TABLE [dbo].[Questions]  WITH CHECK ADD  CONSTRAINT [FK_CauHoi_Phan] FOREIGN KEY([ChapterId])
REFERENCES [dbo].[Chapters] ([Id])
GO
ALTER TABLE [dbo].[Questions] CHECK CONSTRAINT [FK_CauHoi_Phan]
GO
ALTER TABLE [dbo].[QuestionSheetDetails]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietDeThi_CauHoi] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Questions] ([Id])
GO
ALTER TABLE [dbo].[QuestionSheetDetails] CHECK CONSTRAINT [FK_ChiTietDeThi_CauHoi]
GO
ALTER TABLE [dbo].[QuestionSheetDetails]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietDeThi_DeThi] FOREIGN KEY([QuestionSheetId])
REFERENCES [dbo].[QuestionSheets] ([Id])
GO
ALTER TABLE [dbo].[QuestionSheetDetails] CHECK CONSTRAINT [FK_ChiTietDeThi_DeThi]
GO
ALTER TABLE [dbo].[Shifts]  WITH CHECK ADD  CONSTRAINT [FK_CaThi_DotThi] FOREIGN KEY([ExamId])
REFERENCES [dbo].[Exams] ([Id])
GO
ALTER TABLE [dbo].[Shifts] CHECK CONSTRAINT [FK_CaThi_DotThi]
GO
ALTER TABLE [dbo].[ShiftSubjects]  WITH CHECK ADD  CONSTRAINT [FK_CaThi_MonHoc_CaThi] FOREIGN KEY([ShiftId])
REFERENCES [dbo].[Shifts] ([Id])
GO
ALTER TABLE [dbo].[ShiftSubjects] CHECK CONSTRAINT [FK_CaThi_MonHoc_CaThi]
GO
ALTER TABLE [dbo].[ShiftSubjects]  WITH CHECK ADD  CONSTRAINT [FK_CaThi_MonHoc_MonHoc] FOREIGN KEY([SubjectId])
REFERENCES [dbo].[Subjects] ([Id])
GO
ALTER TABLE [dbo].[ShiftSubjects] CHECK CONSTRAINT [FK_CaThi_MonHoc_MonHoc]
GO
ALTER TABLE [dbo].[ShiftSubjects]  WITH CHECK ADD  CONSTRAINT [FK_CaThi_MonHoc_YeuCauRutTrich] FOREIGN KEY([MatrixId])
REFERENCES [dbo].[Matrices] ([Id])
GO
ALTER TABLE [dbo].[ShiftSubjects] CHECK CONSTRAINT [FK_CaThi_MonHoc_YeuCauRutTrich]
GO
ALTER TABLE [dbo].[ShiftSubjectStudents]  WITH CHECK ADD  CONSTRAINT [FK_CaThi_MonHoc_SinhVien_CaThi_MonHoc] FOREIGN KEY([ShiftSubjectId])
REFERENCES [dbo].[ShiftSubjects] ([Id])
GO
ALTER TABLE [dbo].[ShiftSubjectStudents] CHECK CONSTRAINT [FK_CaThi_MonHoc_SinhVien_CaThi_MonHoc]
GO
ALTER TABLE [dbo].[ShiftSubjectStudents]  WITH CHECK ADD  CONSTRAINT [FK_CaThi_MonHoc_SinhVien_DeThi] FOREIGN KEY([QuestionSheetId])
REFERENCES [dbo].[QuestionSheets] ([Id])
GO
ALTER TABLE [dbo].[ShiftSubjectStudents] CHECK CONSTRAINT [FK_CaThi_MonHoc_SinhVien_DeThi]
GO
ALTER TABLE [dbo].[ShiftSubjectStudents]  WITH CHECK ADD  CONSTRAINT [FK_CaThi_MonHoc_SinhVien_SinhVien] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Students] ([Id])
GO
ALTER TABLE [dbo].[ShiftSubjectStudents] CHECK CONSTRAINT [FK_CaThi_MonHoc_SinhVien_SinhVien]
GO
ALTER TABLE [dbo].[Subjects]  WITH CHECK ADD  CONSTRAINT [FK_MonHoc_Khoa] FOREIGN KEY([FacultyId])
REFERENCES [dbo].[Faculties] ([Id])
GO
ALTER TABLE [dbo].[Subjects] CHECK CONSTRAINT [FK_MonHoc_Khoa]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietQuyen_NguoiDung] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_ChiTietQuyen_NguoiDung]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietQuyen_Quyen] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_ChiTietQuyen_Quyen]
GO
/****** Object:  StoredProcedure [dbo].[Answers_Insert]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Answers_Insert]

/*
Author:   			Nguyen Dinh Anh
Created: 			2011-3-9
Last Modified: 		2011-3-9
*/

@QuestionId bigint,
@Content nvarchar(max),
@Order int,
@Correct bit,
@Interchange bit

-- WITH ENCRYPTION
AS

INSERT INTO 	[dbo].[Answers] 
(

				[QuestionId],
				[Content],
				[Order],
				[Correct],
				[Interchange]
) 

VALUES 
(
				@QuestionId,
				@Content,
				@Order,
				@Correct,
				@Interchange
				
)










GO
/****** Object:  StoredProcedure [dbo].[Answers_SelectBy_QuestionId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[Answers_SelectBy_QuestionId]

/*
Author:   			Pham Phu Thanh Sang
Created: 			2010-11-13
Last Modified: 		2010-11-13
*/

@QuestionId bigint
-- WITH ENCRYPTION
AS


SELECT
		[Id],
		[QuestionId],
		[Content],
		[Order],
		[Correct],
		[Interchange]
		
FROM
		[dbo].[Answers]
		
WHERE
		[QuestionId] = @QuestionId
ORDER BY [Order]










GO
/****** Object:  StoredProcedure [dbo].[Answers_Update]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Answers_Update]

/*
Author:   			Nguyen Dinh Anh
Created: 			2011-3-9
Last Modified: 		2011-3-9
*/
	
@Id bigint, 
@QuestionId bigint, 
@Content nvarchar(max), 
@Order int, 
@Correct bit, 
@Interchange bit 

-- WITH ENCRYPTION
AS

UPDATE 		[dbo].[Answers] 

SET
			[QuestionId] = @QuestionId,
			[Content] = @Content,
			[Order] = @Order,
			[Correct] = @Correct,
			[Interchange] = @Interchange
			
WHERE
			[Id] = @Id 











GO
/****** Object:  StoredProcedure [dbo].[CaculateMark]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CaculateMark] @questionSheetId BIGINT
AS
    BEGIN
        UPDATE  dbo.QuestionSheetDetails
        SET     dbo.QuestionSheetDetails.Correct = dbo.Answers.Correct
        FROM    dbo.QuestionSheetDetails
                JOIN dbo.Answers ON dbo.Answers.Id = dbo.QuestionSheetDetails.AnswerId
        WHERE   dbo.QuestionSheetDetails.QuestionSheetId = @questionSheetId;

        DECLARE @numberOfCorrect INT;
	
        SET @numberOfCorrect = ( SELECT   COUNT(*)
                           FROM     dbo.QuestionSheetDetails
                           WHERE    QuestionSheetId = @questionSheetId
                                    AND Correct = 1 );
        UPDATE  dbo.QuestionSheets
        SET     NumberOfCorrect = @numberOfCorrect ,
                Mark = ROUND(( @numberOfCorrect / ( Total * 1.0 / 10 ) ) * 2, 0)
                / 2 ,
                Completed = 1
        WHERE   dbo.QuestionSheets.Id = @questionSheetId;
		SELECT @numberOfCorrect AS NumberOfCorrect, 'updated' AS UpdateCorrectCompleted, Mark AS Mark
		FROM dbo.QuestionSheets WHERE Id = @questionSheetId
    END;



GO
/****** Object:  StoredProcedure [dbo].[CalculateUserSheet]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[CalculateUserSheet]
	@questionSheetId BIGINT
AS
BEGIN
	DECLARE @mark INT, @numberOfCorrect INT, @total int

	UPDATE dbo.QuestionSheetDetails
	SET dbo.QuestionSheetDetails.Correct = dbo.Answers.Correct
	FROM dbo.QuestionSheetDetails JOIN dbo.Answers ON dbo.Answers.Id = dbo.QuestionSheetDetails.AnswerId
	WHERE QuestionSheetId = @questionSheetId 

	SET @total = (SELECT COUNT(*) FROM dbo.QuestionSheetDetails WHERE QuestionSheetId = @questionSheetId)
	SET @numberOfCorrect = (SELECT COUNT(*) FROM dbo.QuestionSheetDetails WHERE QuestionSheetId = @questionSheetId AND Correct = 1)
	SET @mark = ROUND(( @numberOfCorrect / ( @total * 1.0 / 10 ) ), 0)

	UPDATE dbo.QuestionSheets 
	SET Mark = @mark, Completed = 1
	WHERE Id = @questionSheetId
	
	SELECT @total AS Total, @numberOfCorrect AS  NumberOfCorrect, @mark AS Mark
END



GO
/****** Object:  StoredProcedure [dbo].[Chapter_SelectBy_ParentId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Chapter_SelectBy_ParentId]

/*
Author:   			Hoang Van Hieu
Created: 			2015-05-25
Last Modified: 		2017-05-25
*/

@ParentId int
-- WITH ENCRYPTION
AS


SELECT
		*
FROM
		[dbo].[Chapters]
		
WHERE
		ParentId = @ParentId
		and Deleted = 'False' And validated =1
ORDER BY ManagementOrder



GO
/****** Object:  StoredProcedure [dbo].[Chapter_SelectBy_SubjectId_ParentId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Chapter_SelectBy_SubjectId_ParentId]

/*
Author:   			Hoang Van Hieu
Created: 			2016-06-06
Last Modified: 		2017-05-05
*/

@SubjectId int,
@ParentId int
-- WITH ENCRYPTION
AS


SELECT
		*
		
FROM
		[dbo].[Chapters]
		
WHERE
		[SubjectId] = @SubjectId
	AND	[ParentId] = @ParentId
	AND  Deleted = 'False' And validated =1

ORDER BY [Order], Name




GO
/****** Object:  StoredProcedure [dbo].[Chapter_SelectBy_SubjectId_ParentId_QuestionDelted]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Chapter_SelectBy_SubjectId_ParentId_QuestionDelted]

/*
Author:   			Hoang Van Hieu
Created: 			2017-06-02
Last Modified: 		2017-06-02
*/

@SubjectId int,
@ParentId int
-- WITH ENCRYPTION
AS

SELECT  P.Id, P.Name, P.ManagementOrder,P.ParentId , Count(P.Id) as 'SoCauHoi'

FROM 
	
	[dbo].[Subjects] MH
	JOIN [dbo].[Chapters] P ON P.SubjectId = MH.Id
	JOIN [dbo].[Questions] CH ON CH.ChapterId = P.Id

WHERE 
	
	CH.Deleted = 'true' AND CH.validated =1
	AND MH.Id = @SubjectId


GROUP BY P.Id, P.Name, P.ManagementOrder, P.ParentId



GO
/****** Object:  StoredProcedure [dbo].[Chapters_Insert]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author:   			Hoang Van Hieu
Created: 			2017-05-05
Last Modified: 		2017-05-05
*/
CREATE PROCEDURE [dbo].[Chapters_Insert]
@SubjectId int,
@Name nvarchar(100),
@Content nvarchar(1000),
@Order int,
@ParentId int,
@Deleted bit

AS
INSERT INTO 	[dbo].[Chapters] 
(
				[SubjectId],
				[Name],
				[Content],
				[Order],
				[ParentId],
				[Deleted],
				[ManagementOrder]
) 
VALUES 
(
				
				@SubjectId,
				@Name,
				@Content,
				@Order,
				@ParentId,
				@Deleted,
				(select  (isnull(count(ManagementOrder),0)+1) from Chapters where SubjectId = @SubjectId)		
)





GO
/****** Object:  StoredProcedure [dbo].[Chapters_Restore]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- RESTORE PHAN
CREATE PROCEDURE [dbo].[Chapters_Restore]	
@Id int

AS
UPDATE 
	Questions
SET
	Deleted = 'False'

WHERE 
Id IN (SELECT Id 
					FROM Chapters
					WHERE Id = @Id
					and Deleted = 'True'
					)
	and Deleted = 'True';

UPDATE 
	Chapters
SET 
	Deleted = 'False'
WHERE 
	Id = @Id
	and Deleted = 'True';











GO
/****** Object:  StoredProcedure [dbo].[Chapters_SelectAll]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- SELECT ALL PHAN
CREATE PROCEDURE [dbo].[Chapters_SelectAll]

AS
SELECT
		[Id],
		[SubjectId],
		[Name],
		[Content],
		[Order],
		[ParentId],
		[Deleted]	
FROM
		[dbo].[Chapters]











GO
/****** Object:  StoredProcedure [dbo].[Chapters_SelectOne]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Chapters_SelectOne]

/*
Author:   			Nguyen Bao Quoc
Created: 			2011-3-9
Last Modified: 		2011-3-9
*/

@Id int
-- WITH ENCRYPTION
AS


SELECT
		[Id],
		[SubjectId],
		[Name],
		[Content],
		[Order],
		[ParentId],
		[Deleted],
		[ManagementOrder]
		
FROM
		[dbo].[Chapters]
		
WHERE
		[Id] = @Id












GO
/****** Object:  StoredProcedure [dbo].[Chapters_SelectOneByName]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Chapters_SelectOneByName]

/*
Author:   			Nguyen Bao Quoc
Created: 			2011-3-9
Last Modified: 		2011-3-9
*/

@SubjectId int,
@ParentId int,
@Name nvarchar(100)
-- WITH ENCRYPTION
AS


SELECT	*
FROM	[dbo].[Chapters]
WHERE	[SubjectId] = @SubjectId
	AND [ParentId] = @ParentId
	AND	Lower([Name]) = Lower(@Name)
	AND validated =1




GO
/****** Object:  StoredProcedure [dbo].[Chapters_Update]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- UPDATE PHAN
CREATE PROCEDURE [dbo].[Chapters_Update]
@Id int, 
@SubjectId int, 
@Name nvarchar(250), 
@Content nvarchar(max), 
@Order int, 
@ParentId int, 
@Deleted bit 

AS
UPDATE 		[dbo].[Chapters] 
SET
			[SubjectId] = @SubjectId,
			[Name] = @Name,
			[Content] = @Content,
			[Order] = @Order,
			[ParentId] = @ParentId,
			[Deleted] = @Deleted	
WHERE
			[Id] = @Id











GO
/****** Object:  StoredProcedure [dbo].[ChapterSelectBySubjectId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ChapterSelectBySubjectId]

/*
Author:   			Nguyen Bao Quoc
Created: 			2011-3-9
Last Modified: 		2011-3-9
*/

@SubjectId int
-- WITH ENCRYPTION
AS


SELECT
		*
		
FROM
		[dbo].[Chapters]
		
WHERE
		SubjectId = @SubjectId
		AND Deleted = 'False' And validated =1

ORDER BY [ManagementOrder]



GO
/****** Object:  StoredProcedure [dbo].[CheckLoginByStudentCode]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckLoginByStudentCode]
    @studentCode NVARCHAR(100)
AS
    BEGIN
        SELECT dbo.Exams.[Name] AS ExamName,
		dbo.Shifts.Id AS ShiftId,
	dbo.Shifts.[Name] AS ShiftName,
	dbo.Shifts.StartTime,
	dbo.Shifts.EndTime,
	dbo.Shifts.Duration,
	dbo.Subjects.[Name] AS SubjectName,
	dbo.Students.Code AS StudentCode,
	dbo.Students.[Name] AS StudentName,
	dbo.QuestionSheets.ExtraTime,
	dbo.ShiftSubjectStudents.ShiftSubjectId,
	dbo.ShiftSubjectStudents.QuestionSheetId,
	dbo.ShiftSubjectStudents.StudentId
FROM dbo.ShiftSubjectStudents
	JOIN dbo.Students ON Students.Id = ShiftSubjectStudents.StudentId
	JOIN dbo.QuestionSheets ON QuestionSheets.Id = ShiftSubjectStudents.QuestionSheetId
	JOIN dbo.ShiftSubjects ON ShiftSubjects.Id = ShiftSubjectStudents.ShiftSubjectId
	JOIN dbo.Shifts ON Shifts.Id = ShiftSubjects.ShiftId
	JOIN dbo.Subjects ON Subjects.Id = ShiftSubjects.SubjectId
	JOIN dbo.Exams ON Exams.Id = Shifts.ExamId
WHERE
	dbo.Students.Code = @studentCode
	AND dbo.Shifts.Activated = 1
    END;




GO
/****** Object:  StoredProcedure [dbo].[CheckStudentCode]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckStudentCode]
    @studentCode NVARCHAR(100)
AS
    BEGIN
        SELECT  dbo.Students.Id
        FROM    dbo.Students
        WHERE   dbo.Students.Code = @studentCode;
    END;




GO
/****** Object:  StoredProcedure [dbo].[CheckStudentHasLogin]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckStudentHasLogin]
	@studentCode NVARCHAR(100)
AS
BEGIN
	SELECT dbo.Students.Code
	FROM dbo.Students JOIN dbo.ShiftSubjectStudents ON ShiftSubjectStudents.StudentId = Students.Id
	WHERE dbo.Students.Code = @studentCode AND dbo.ShiftSubjectStudents.[LogIn] = 0
END




GO
/****** Object:  StoredProcedure [dbo].[CheckSubjectBySubjectIdAndName]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[CheckSubjectBySubjectIdAndName]
@Id int,
@Name nvarchar(100)
AS
SELECT * FROM Subjects
WHERE Id = @Id AND Name =@Name




GO
/****** Object:  StoredProcedure [dbo].[CompletedQuestionSheet]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CompletedQuestionSheet] @questionSheetId BIGINT
AS
    BEGIN
        SELECT  Completed
        FROM    dbo.QuestionSheets
        WHERE   Id = @questionSheetId;
    END;




GO
/****** Object:  StoredProcedure [dbo].[DeleteTemporaryQuestion]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DeleteTemporaryQuestion]
@Id Bigint
AS
UPDATE  Questions SET Deleted ='true', validated =0
WHERE Id =@Id




GO
/****** Object:  StoredProcedure [dbo].[Exams_Delete]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Exams_Delete]
	@Id int,
	@Deleted bit
AS
UPDATE [dbo].[Exams]
   SET [Deleted] = @Deleted
 WHERE [Id] = @Id





GO
/****** Object:  StoredProcedure [dbo].[Exams_Insert]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Exams_Insert]

@Name nvarchar(100),
@CreateDate datetime,
@UserId int,
@Deleted bit

-- WITH ENCRYPTION
AS

INSERT INTO 	[dbo].[Exams] 
(
				[Name],
				[CreateDate],
				[UserId],
				[Deleted],
				[Desktop]
) 

VALUES 
(
				@Name,
				@CreateDate,
				@UserId,
				@Deleted,
				1
)





GO
/****** Object:  StoredProcedure [dbo].[Exams_SelectAll]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Exams_SelectAll]

/*
Author:   			Nguyen Bao Quoc
Created: 			2011-3-9
Last Modified: 		2011-3-9
*/
-- WITH ENCRYPTION
AS


SELECT
		Id, Name as TenDotThi, UserId, CreateDate, Deleted, N'Chi tiết đợt thi' as ShiftOfExam
		
FROM
		[dbo].[Exams] where Deleted = 'false' and Desktop =1




GO
/****** Object:  StoredProcedure [dbo].[Exams_SelectByName]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Exams_SelectByName]

@Name nvarchar(100)

AS


SELECT
		Id, Name as TenDotThi, UserId, CreateDate, Deleted
		
FROM
		[dbo].[Exams] Where Name =@Name





GO
/****** Object:  StoredProcedure [dbo].[Exams_Update]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Exams_Update]
	@Id int,
	@Name nvarchar(100),
	@Deleted bit
AS
UPDATE [dbo].[Exams]
   SET [Name] = @Name
      ,[Deleted] = @Deleted
 WHERE [Id] = @Id




GO
/****** Object:  StoredProcedure [dbo].[Faculties_Insert]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Faculties_Insert]

/*
Author:   			Hoang Van Hieu
Created: 			2017-05-05
Last Modified: 		2017-05-05
*/

@Name nvarchar(100),
@Deleted bit

-- WITH ENCRYPTION
AS

INSERT INTO 	[dbo].[Faculties] 
(
				[Name],
				[Deleted]
) 

VALUES 
(
				@Name,
				@Deleted
				
)











GO
/****** Object:  StoredProcedure [dbo].[Faculties_Retore]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Faculties_Retore]

/*
Author:   			Hoang Van Hieu
Created: 			2016-09-29
Last Modified: 		2016-09-29
*/
	
@Id int

-- WITH ENCRYPTION
AS
BEGIN
	UPDATE Faculties SET Deleted =0 where Id =@Id;
	UPDATE Subjects SET Deleted =0 where FacultyId = @Id;
	UPDATE Chapters SET Deleted = 0 WHERE SubjectId in (Select Id from Subjects WHERE FacultyId =@Id)
	UPDATE Questions SET Deleted = 0
	WHERE SubjectId in (Select Id from Subjects WHERE FacultyId =@Id)
END;				
		



GO
/****** Object:  StoredProcedure [dbo].[Faculties_SelectAll]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Faculties_SelectAll]

/*
Author:   			Nguyen Bao Quoc
Created: 			2011-3-9
Last Modified: 		2011-3-9
*/
-- WITH ENCRYPTION
AS


SELECT
		[Id],
		[Name],
		[Deleted]
		
FROM
		[dbo].[Faculties]
WHERE Deleted = 'false'












GO
/****** Object:  StoredProcedure [dbo].[Faculties_SelectOne]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Faculties_SelectOne]

/*
Author:   			Hoang Van Hieu
Created: 			2016-09-29
Last Modified: 		2016-09-29
*/

@Id int
-- WITH ENCRYPTION
AS


SELECT
		*
		
FROM
		[dbo].[Faculties]
		
WHERE
		[Id] = @Id




GO
/****** Object:  StoredProcedure [dbo].[Faculties_SelectOneByName]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Faculties_SelectOneByName]

/*
Author:   			Nguyen Bao Quoc
Created: 			2011-3-8
Last Modified: 		2011-3-8
*/

@Name nvarchar(100)
-- WITH ENCRYPTION
AS


SELECT
		*		
FROM
		[dbo].[Faculties]
		
WHERE
		lower([Name]) =  lower(@Name)
		and Deleted = 'False'











GO
/****** Object:  StoredProcedure [dbo].[Faculties_Update]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Faculties_Update]

/*
Author:   			Hoang Van Hieu
Created: 			2016-09-29
Last Modified: 		2016-09-29
*/
	
@Id int, 
@Name nvarchar(250), 
@Deleted bit,
@Comment nvarchar(100) 

-- WITH ENCRYPTION
AS
BEGIN
	IF(@Deleted ='false')
		BEGIN
		UPDATE 		[dbo].[Faculties] 
		SET
					[Name] = @Name,
					[Comment] = @Comment
		WHERE
					[Id] = @Id
		END
	ELSE
		BEGIN
			UPDATE Faculties SET Deleted ='true' where Id =@Id;
			UPDATE Subjects SET Deleted ='true'where FacultyId = @Id;
			UPDATE Chapters SET Deleted = 'true'WHERE SubjectId in (Select Id from Subjects WHERE FacultyId =@Id)
			UPDATE Questions SET Deleted = 'true'
			WHERE SubjectId in (Select Id from Subjects WHERE FacultyId =@Id)
		END

END;




GO
/****** Object:  StoredProcedure [dbo].[Faculty_Delete]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Faculty_Delete]

/*
Author:   			Hoang Van Hieu
Created: 			2016-09-29
Last Modified: 		2016-09-29
*/

@Id int
As
	BEGIN
		Update Faculties Set validated = 1, Deleted =1
		WHERE Id =@Id
	END





GO
/****** Object:  StoredProcedure [dbo].[Faculty_Delete_By_Id]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Faculty_Delete_By_Id]
@FacultyId int
AS
BEGIN
	DELETE FROM [dbo].[QuestionSheetDetails]
			WHERE QuestionId IN( SELECT Id FROM Questions WHERE SubjectId IN (SELECT Id From Subjects WHERE FacultyId =@FacultyId))

	DELETE  FROM Answers 
	WHERE QuestionId IN( SELECT Id FROM Questions WHERE SubjectId IN (SELECT Id From Subjects WHERE FacultyId =@FacultyId))

	DELETE FROM Questions
	WHERE SubjectId IN (SELECT Id From Subjects WHERE FacultyId =@FacultyId)

	DELETE FROM MatrixDetails 
	WHERE ChapterId In (SELECT Id FROM Chapters WHERE SubjectId IN (SELECT Id From Subjects WHERE FacultyId =@FacultyId))

	DELETE FROM ShiftSubjectStudents
	WHERE ShiftSubjectId IN (SELECT Id FROM ShiftSubjects WHERE SubjectId IN (SELECT Id From Subjects WHERE FacultyId =@FacultyId))

	DELETE FROM ShiftSubjects
	WHERE SubjectId IN (SELECT Id From Subjects WHERE FacultyId =@FacultyId)

	DELETE FROM Matrices
	WHERE SubjectId IN  (SELECT Id From Subjects WHERE FacultyId =@FacultyId)

	DELETE FROM Chapters
	WHERE SubjectId IN (SELECT Id From Subjects WHERE FacultyId =@FacultyId)

	DELETE FROM Subjects
	WHERE FacultyId =@FacultyId

	DELETE FROM Faculties
	WHERE Id =@FacultyId

END




GO
/****** Object:  StoredProcedure [dbo].[Faculty_SelectBy_QuestionDelete]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Faculty_SelectBy_QuestionDelete]

/*
Author:   			HOANG VAN HIEU
Created: 			2017-02-06
Last Modified: 		2017-02-06
*/

AS

SELECT  K.Id, K.Name , Count(K.Id) as 'SoCauHoi'

FROM 

	[dbo].[Faculties] K
	JOIN [dbo].[Subjects] MH ON MH.FacultyId =  K.Id
	JOIN [dbo].[Chapters] P ON P.SubjectId = MH.Id
	JOIN [dbo].[Questions] CH ON CH.ChapterId = P.Id

WHERE 
	
	CH.Deleted = 'true'OR K.Deleted ='true' OR MH.Deleted ='true' OR P.Deleted ='true' And CH.validated =0

GROUP BY K.Id, K.Name




GO
/****** Object:  StoredProcedure [dbo].[GenerateExam]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GenerateExam] 
	@number int, 
	@subjectId int
AS
BEGIN
	SELECT TOP (@number) Id FROM dbo.Questions WHERE SubjectId = @subjectId ORDER BY NEWID()
END



GO
/****** Object:  StoredProcedure [dbo].[GetAnswerByQuestionId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAnswerByQuestionId] @questionId BIGINT
AS
    BEGIN
        IF ( ( SELECT   Interchange
               FROM     dbo.Questions
               WHERE    Id = @questionId
             ) = 1 )
            BEGIN
                SELECT  QuestionId ,
                        Id ,
                        Content ,
                        [Order]
                FROM    dbo.Answers
                WHERE   QuestionId = @questionId
                ORDER BY NEWID();
            END;
        ELSE
            BEGIN
                SELECT  QuestionId ,
                        Id ,
                        Content ,
                        [Order]
                FROM    dbo.Answers
                WHERE   QuestionId = @questionId
                ORDER BY [Order];
            END;
    END;




GO
/****** Object:  StoredProcedure [dbo].[GetMark]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetMark]
	@questionSheetId BIGINT
AS
BEGIN
	SELECT Mark, NumberOfCorrect, Total 
	FROM dbo.QuestionSheets
	WHERE Id = @questionSheetId
END



GO
/****** Object:  StoredProcedure [dbo].[GetMatrixDetailByMatrixId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetMatrixDetailByMatrixId]
@MatrixId int
AS
	SELECT * FROM MatrixDetails WHERE MatrixId = @MatrixId




GO
/****** Object:  StoredProcedure [dbo].[GetNameFacultyBySubjectId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetNameFacultyBySubjectId]
@SubjectId int
AS
BEGIN
	DECLARE @Name nvarchar(50);
	SET @Name =(Select f.Name FROM Faculties f join Subjects s On s.FacultyId = f.Id where s.Id = @SubjectId)
	Select @Name		
END



GO
/****** Object:  StoredProcedure [dbo].[GetPaperQuestionSheetsByPaperShiftSubjectId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[GetPaperQuestionSheetsByPaperShiftSubjectId]
@PaperShiftSubjectId int
AS
 SELECT * FROM PaperQuestionSheets WHERE PaperShiftSubjectId = @PaperShiftSubjectId




GO
/****** Object:  StoredProcedure [dbo].[GetQuantityQuestionSheetAdvByMarkAndAnswerIdAndQuestionId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[GetQuantityQuestionSheetAdvByMarkAndAnswerIdAndQuestionId]

@Mark decimal(18,10),
@Answer BigInt,
@QuestionId BigInt
As
select ISNULL(COUNT(AnswerId),0) from QuestionSheetDetails QD Join QuestionSheets QS ON QD.QuestionSheetId = QS.Id 
where QS.Mark >@Mark And QD.AnswerId =@Answer And QD.QuestionId =@QuestionId 
Group By AnswerId




GO
/****** Object:  StoredProcedure [dbo].[GetQuantityQuestionSheetBelByMarkAndAnswerIdAndQuestionId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROC [dbo].[GetQuantityQuestionSheetBelByMarkAndAnswerIdAndQuestionId]

@Mark decimal(18,10),
@Answer BigInt,
@QuestionId BigInt
As
select ISNULL(COUNT(AnswerId),0) from QuestionSheetDetails QD Join QuestionSheets QS ON QD.QuestionSheetId = QS.Id 
where QS.Mark <@Mark And QD.AnswerId =@Answer And QD.QuestionId =@QuestionId 
Group By AnswerId




GO
/****** Object:  StoredProcedure [dbo].[GetQuestionContent]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetQuestionContent] @questionId BIGINT
AS
    BEGIN
        SELECT  Content ,
                Audio
        FROM    dbo.Questions
        WHERE Id=@questionId
    END;




GO
/****** Object:  StoredProcedure [dbo].[GetQuestionIdByParentId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetQuestionIdByParentId]

/*
Author:   			Haong Van Hieu
Created: 			2017-05-27
Last Modified: 		2017-05-30
*/

@ParentId bigint
-- WITH ENCRYPTION
AS


SELECT
		Id
FROM
		[dbo].[Questions]
		
WHERE
		[ParentId] = @ParentId
		and Deleted = 'False' and ParentId != Id
ORDER BY Id


GO
/****** Object:  StoredProcedure [dbo].[GetQuestionSheetByStudentCode]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ca thi đã dc kích hoạt và ca thi đó chưa kết thúc và xóa tạm bằng false hoặc null
-- sinh viên đó phải tồn tại trong database
--đề thi đó đã dc bắt đầu làm và chưa hoàn thành và dc chấp thuận

CREATE PROCEDURE [dbo].[GetQuestionSheetByStudentCode]
    @studentCode VARCHAR(50)
AS
    BEGIN
        SELECT DISTINCT
                --QuestionSheetDetails.QuestionSheetId ,
                dbo.QuestionSheetDetails.QuestionId ,
				dbo.Questions.Content AS QuestionContent,
				QuestionSheetDetails.[Order] AS OrderQuestion,
                dbo.QuestionSheetDetails.AnswerId AS AnswerCurrentChoose ,
				dbo.Answers.Id AS AnswerId,
				dbo.Answers.[Order] AS AnswerOrder,
				dbo.Answers.Content AS AnswerContent,
                dbo.Questions.ParentId ,
				dbo.Chapters.[Name] AS ChapterName,
                dbo.QuestionSheetDetails.ListenTimes AS ListenTimes ,
                dbo.QuestionSheetDetails.Correct,
				dbo.Questions.Audio
        FROM    dbo.ShiftSubjectStudents
                JOIN dbo.ShiftSubjects ON ShiftSubjects.Id = ShiftSubjectStudents.ShiftSubjectId
				JOIN dbo.Subjects ON Subjects.Id = ShiftSubjects.SubjectId
                JOIN dbo.Shifts ON Shifts.Id = ShiftSubjects.ShiftId
                JOIN dbo.Students ON Students.Id = ShiftSubjectStudents.StudentId
                JOIN dbo.QuestionSheets ON QuestionSheets.Id = ShiftSubjectStudents.QuestionSheetId
                JOIN dbo.QuestionSheetDetails ON QuestionSheetDetails.QuestionSheetId = QuestionSheets.Id
                JOIN dbo.Questions ON Questions.Id = QuestionSheetDetails.QuestionId
				JOIN dbo.Chapters ON Chapters.Id = Questions.ChapterId
                JOIN dbo.Answers ON Answers.QuestionId = Questions.Id
        WHERE   dbo.Students.Code = @studentCode
                AND dbo.Shifts.Activated = 'true' --ca thi dc kích hoạt
                AND ( dbo.Shifts.Ended = 'false'
                      OR dbo.Shifts.Ended IS NULL
                    ) -- ca thi chưa kết thúc
                AND ( dbo.Shifts.Deleted = 'false'
                      OR dbo.Shifts.Deleted IS NULL
                    ) --ca thi không bị xóa
                AND dbo.QuestionSheets.Approved = 'true' -- đề thi đó đã được duyệt
                AND dbo.QuestionSheets.[Started] = 'true' -- đề thi đó đã bắt đầu
		GROUP BY dbo.QuestionSheetDetails.QuestionId ,
					Questions.ParentId,
					dbo.Questions.Content,
					dbo.QuestionSheetDetails.[Order],
					dbo.QuestionSheetDetails.AnswerId,
					dbo.Answers.Id,
					dbo.Answers.[Order],
					dbo.Answers.Content,
					dbo.Chapters.[Name],
					dbo.QuestionSheetDetails.ListenTimes,
					dbo.QuestionSheetDetails.Correct,
					dbo.Questions.Audio
		ORDER BY dbo.QuestionSheetDetails.[Order];
    END;

	




GO
/****** Object:  StoredProcedure [dbo].[GetRemainingTimeByQuestionSheetId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRemainingTimeByQuestionSheetId]
    @questionSheetId BIGINT ,
    @shiftId BIGINT
AS
    BEGIN
        DECLARE @endTime DATETIME ,
            @extraTime INT;
        SET @extraTime = ( SELECT    ExtraTime
                                  FROM      dbo.QuestionSheets
                                  WHERE     Id = @questionSheetId
                                );
        SET @endTime = DATEADD(MINUTE, @extraTime,
                                       ( SELECT EndTime
                                         FROM   dbo.Shifts
                                         WHERE  Id = @shiftId
                                       ));
        SELECT  DATEDIFF(SECOND, GETDATE(), @endTime) AS [Duration];
    END;




GO
/****** Object:  StoredProcedure [dbo].[GetResult]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetResult] @questionSheetId BIGINT
AS
    BEGIN
        SELECT  [Order] ,
                Correct
        FROM    dbo.QuestionSheetDetails
        WHERE   QuestionSheetId = @questionSheetId;
    END;




GO
/****** Object:  StoredProcedure [dbo].[GetReviewQuestion]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetReviewQuestion] 
	@questionSheetId BIGINT
AS
BEGIN
	SELECT dbo.QuestionSheetDetails.QuestionId ,
		   dbo.QuestionSheetDetails.AnswerId AS AnswerCurrentChoose,
		   dbo.Answers.Id AS AnswerId,
		   dbo.Answers.[Order] AS AnswerOrder,
           dbo.QuestionSheetDetails.[Order] AS QuestionOrder,
		   dbo.Chapters.Name AS ChapterName
	FROM dbo.QuestionSheetDetails JOIN dbo.Answers ON Answers.QuestionId = QuestionSheetDetails.QuestionId
	JOIN dbo.Questions ON Questions.Id = Answers.QuestionId
	JOIN dbo.Chapters ON Chapters.Id = Questions.ChapterId
	WHERE QuestionSheetId = @questionSheetId
END 



GO
/****** Object:  StoredProcedure [dbo].[GetSubjectAndQuantityQuestionShiftByShiftId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSubjectAndQuantityQuestionShiftByShiftId]

/*
Author:   			Hoang Van Hieu
Created: 			2017-06-07
Last Modified: 		2017-06-07
*/
@ShiftId int

AS

BEGIN
	
				SELECT  PSS.Id, S.Name,PSS.MatrixId,PSS.SubjectId, Count(PSS.Id)-1 as 'SoDeThi',N'Thêm đề thi' as 'TaoDeThi', N'Xem đề thi' as 'ListQuestionSheet'
				FROM 

					[dbo].[PaperShiftSubjects] PSS
					left JOIN [dbo].[PaperQuestionSheets] PQS ON PQS.PaperShiftSubjectId =  PSS.Id
					left JOIN [dbo].[Subjects] S ON PSS.SubjectId = S.Id
				WHERE PSS.ShiftId = @ShiftId
				GROUP BY PSS.Id,S.Name,PSS.MatrixId,PSS.SubjectId
END





GO
/****** Object:  StoredProcedure [dbo].[InsertUser]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[InsertUser]
           @Username nvarchar(50),
           @Passwoed nvarchar(128),
           @Name nvarchar(50),
           @CreateDate datetime,
		   @Deleted bit,
		   @Comment nvarchar(100),
		   @FacultyId int,
		   @SubjectID int
AS
INSERT INTO [dbo].[Users]
           ([Username]
           ,[Password]
           ,[Name]
           ,[CreateDate]
		   ,[Deleted]
		   ,[Comment]
		   ,[LastPasswordChanged]
		   ,[LastActivity]
		   ,[LastLogIn]
		   ,[LastLogOut]
		   ,[FacultyId]
		   ,[SubjectId]
           )
     VALUES
           (@Username,
           @Passwoed,
           @Name,
           @CreateDate,
		   @Deleted,
		   @Comment,
		   @CreateDate,
		   @CreateDate,
		   @CreateDate,
		   @CreateDate,
		   @FacultyId,
		   @SubjectID
           )






GO
/****** Object:  StoredProcedure [dbo].[ListQuestionDeleted_SelectBy_ChapterId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ListQuestionDeleted_SelectBy_ChapterId]

/*
Author:   			Nguyen Dinh Anh
Created: 			2011-06-07
Last Modified: 		2011-06-07
*/

@ChapterId int
-- WITH ENCRYPTION
AS


SELECT
		*
FROM
		[dbo].[Questions]
		
WHERE
		[ChapterId] = @ChapterId
		and Deleted = 'true' AND validated =1
ORDER BY [Id]



GO
/****** Object:  StoredProcedure [dbo].[ListQuestionDeleted_SelectBy_ChapterId_ParentId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ListQuestionDeleted_SelectBy_ChapterId_ParentId]

/*
Author:   			Nguyen Dinh Anh
Created: 			2011-06-07
Last Modified: 		2011-06-07
*/

@ChapterId int,
@ParentId int
-- WITH ENCRYPTION
AS


SELECT
		*
FROM
		[dbo].[Questions]
		
WHERE
		([ChapterId] = @ChapterId
		or [ParentId] = @ParentId)
		and Deleted = 'true'
ORDER BY [Id]





GO
/****** Object:  StoredProcedure [dbo].[Login]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Login]
	@Username NVARCHAR(50),
	@Password NVARCHAR(128)
AS
	SELECT *  FROM Users
	WHERE @Username = Username
	AND @Password = Password




GO
/****** Object:  StoredProcedure [dbo].[LoginSuccess]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[LoginSuccess]
	@shiftSubjectId BIGINT,
	@studentId BIGINT,
	@questionSheetId BIGINT
AS
BEGIN
	IF EXISTS(SELECT s.QuestionSheetId ,
                     s.ShiftSubjectId ,
                     s.StudentId FROM dbo.ShiftSubjectStudents s 
					WHERE ShiftSubjectId = @shiftSubjectId AND StudentId = @studentId AND QuestionSheetId = @questionSheetId)
		BEGIN 
				UPDATE dbo.ShiftSubjectStudents
				SET LogIn = 1 --true/ chuyển trạng thái đã đăng nhập
				WHERE ShiftSubjectId = @shiftSubjectId AND StudentId = @studentId 
					AND QuestionSheetId = @questionSheetId
				SELECT 'true' AS Result
		END
	ELSE
		BEGIN 
			SELECT 'false' AS Result
		END

END




GO
/****** Object:  StoredProcedure [dbo].[LogOut]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LogOut]
	@shiftSubjectId BIGINT,
	@questionSheetId BIGINT,
	@studentId BIGINT
AS
BEGIN
	IF EXISTS(SELECT s.QuestionSheetId ,
                     s.ShiftSubjectId ,
                     s.StudentId FROM dbo.ShiftSubjectStudents s 
					WHERE ShiftSubjectId = @shiftSubjectId AND StudentId = @studentId AND QuestionSheetId = @questionSheetId)
		BEGIN 
				UPDATE dbo.ShiftSubjectStudents
				SET LogIn = 0 --false/ chuyển trạng thái đã đăng xuất
				WHERE ShiftSubjectId = @shiftSubjectId AND StudentId = @studentId 
					AND QuestionSheetId = @questionSheetId
				SELECT 'true' AS Result
		END
	ELSE
		BEGIN 
			SELECT 'false' AS Result
		END
END




GO
/****** Object:  StoredProcedure [dbo].[Matrices_SelectMax]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Matrices_SelectMax]

@Matrices int
/*
Author:   			Hoang Van Hieu
Created: 			2017-05-05
Last Modified: 		2017-05-05
*/
AS

DECLARE @Max int

SELECT
		@Max = MAX([Id])
FROM
		[dbo].[Matrices]

IF(@Max IS NULL) SELECT 0
ELSE SELECT @Max




GO
/****** Object:  StoredProcedure [dbo].[MatricesInsert]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Matrices table
CREATE PROC [dbo].[MatricesInsert]
	@SubjectId INT,
	@CreateDate DATETIME,
	@Name NVARCHAR(100)
AS
BEGIN
	INSERT INTO dbo.Matrices
	        ( SubjectId, CreateDate, Name )
	VALUES  ( @SubjectId, -- SubjectId - int
	          @CreateDate, -- CreateDate - datetime
	          @Name  -- Name - nvarchar(100)
	          )
END





GO
/****** Object:  StoredProcedure [dbo].[MatricesSelectAll]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[MatricesSelectAll]
	@Id BIGINT
AS
BEGIN
	SELECT * FROM dbo.Matrices
END




GO
/****** Object:  StoredProcedure [dbo].[MatricesSelectById]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MatricesSelectById]
	@Id BIGINT
AS
BEGIN
	SELECT * FROM dbo.Matrices WHERE Id = @Id
END





GO
/****** Object:  StoredProcedure [dbo].[MatricesUpdate]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MatricesUpdate]
	@Id BIGINT,
	@SubjectId INT,
	@CreateDate DATETIME,
	@Name NVARCHAR(100)
AS
BEGIN
	UPDATE dbo.Matrices
	SET SubjectId = @SubjectId, CreateDate = CreateDate, [Name] = @Name
	WHERE Id = @Id
END





GO
/****** Object:  StoredProcedure [dbo].[MatrixDetailInsert]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- MatrixDetail
CREATE PROC [dbo].[MatrixDetailInsert]
	@MatrixId BIGINT,
	@ChapterId INT,
	@Quantity INT,
	@Excluded NVARCHAR(1000)
AS
BEGIN
	INSERT INTO dbo.MatrixDetails
	        ( MatrixId ,
	          ChapterId ,
	          Quantity ,
	          Excluded
	        )
	VALUES  ( @MatrixId , -- MatrixId - bigint
	          @ChapterId , -- ChapterId - int
	          @Quantity , -- Quantity - int
	          @Excluded  -- Excluded - nvarchar(1000)
	        )
END





GO
/****** Object:  StoredProcedure [dbo].[MatrixDetailSelectById]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MatrixDetailSelectById]
	@Id INT
AS
BEGIN
	SELECT * FROM dbo.MatrixDetails WHERE Id = @Id
END





GO
/****** Object:  StoredProcedure [dbo].[MatrixDetailUpdate]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MatrixDetailUpdate]
	@Id INT,
	@MatrixId BIGINT,
	@ChapterId INT,
	@Quantity INT,
	@Excluded NVARCHAR(1000)
AS
BEGIN
	UPDATE dbo.MatrixDetails
	SET MatrixId = @MatrixId, ChapterId = @ChapterId, Quantity = @Quantity, Excluded = @Excluded
	WHERE Id = @Id
END





GO
/****** Object:  StoredProcedure [dbo].[PaperQuestionSheetDetailsInsert]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PaperQuestionSheetDetailsInsert]
@PaperQuestionSheetId int,
@QuestionId int,
@Order int
AS
	INSERT INTO [dbo].[PaperQuestionSheetDetails]
			   ([PaperQuestionSheetId]
			   ,[QuestionId]
			   ,[Order])
		 VALUES
			   (@PaperQuestionSheetId,
			   @QuestionId,
			   @Order)





GO
/****** Object:  StoredProcedure [dbo].[PaperQuestionSheetDetailsSelectByQuestionSheetId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PaperQuestionSheetDetailsSelectByQuestionSheetId]
@QuestionSheetId int
AS
	select PaperQuestionSheetId, QuestionId from PaperQuestionSheetDetails where PaperQuestionSheetId =@QuestionSheetId
	ORDER BY [Order]





GO
/****** Object:  StoredProcedure [dbo].[PaperQuestionSheetsInsert]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[PaperQuestionSheetsInsert]
@Name		nvarchar(100),
@Total int,
@ObjectiveDifficulty decimal(18,10),
@CreateDate datetime,
@ExportDate dateTime,
@TestDate	datetime,
@Duration	int,
@Exported	bit,
@PaperShiftSubjectId int
AS 

INSERT INTO [dbo].[PaperQuestionSheets]
           ([Name]
           ,[CreateDate]
           ,[ExportDate]
           ,[TestDate]
           ,[Duration]
           ,[Exported]
           ,[PaperShiftSubjectId]
		   ,[ObjectiveDifficulty]
		   ,[Total])
     VALUES
           (@Name,
     		@CreateDate, 
			@ExportDate, 
			@TestDate,	
			@Duration,	
			@Exported,	
			@PaperShiftSubjectId,
			@ObjectiveDifficulty,
			@Total)




GO
/****** Object:  StoredProcedure [dbo].[Question_Delete]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Question_Delete]

@Id bigint
-- WITH ENCRYPTION
AS

update Questions set Deleted = 'true', validated =0 where Id = @Id Or ParentId = @Id



GO
/****** Object:  StoredProcedure [dbo].[Question_Delete_Temporary]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Question_Delete_Temporary]

@Id bigint
-- WITH ENCRYPTION
AS

update Questions set Deleted = 'true' where Id = @Id Or ParentId = @Id


















GO
/****** Object:  StoredProcedure [dbo].[Question_Restore]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[Question_Restore]

/*
Author:   			Pham Phu Thanh Sang
Created: 			2010-11-13
Last Modified: 		2010-11-13
*/
	
@Id bigint

-- WITH ENCRYPTION
AS

UPDATE 		[dbo].[Question] 

SET
		Deleted = 'False'
			
WHERE
		[Id] = @Id
		and Deleted = 'True'





GO
/****** Object:  StoredProcedure [dbo].[Question_SelectBy_ChapterId_ParentId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[Question_SelectBy_ChapterId_ParentId]

/*
Author:   			Hoang Van Hieu
Created: 			2017-05-30
Last Modified: 		2017-05-30
*/

@ChapterId int,
@ParentId bigint
-- WITH ENCRYPTION
AS


SELECT
		*
FROM
		[dbo].[Questions]
		
WHERE
		[ChapterId] = @ChapterId
		and [ParentId] = @ParentId
		and Deleted = 'False'
ORDER BY [Id]




GO
/****** Object:  StoredProcedure [dbo].[Question_SelectBy_SubjectId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Question_SelectBy_SubjectId]

/*
Author:   			Hoang Van Hieu
Created: 			2017-05-28
Last Modified: 		2011-05-30
*/

@SubjectId int
-- WITH ENCRYPTION
AS


SELECT
		DISTINCT CH.*
FROM
		[dbo].[Questions] CH
		JOIN [dbo].[Chapters] P ON P.Id = CH.ChapterId		
WHERE
		P.SubjectId = @SubjectId
ORDER BY CH.Id





GO
/****** Object:  StoredProcedure [dbo].[Question_SelectSoCauHoiCon]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[Question_SelectSoCauHoiCon]

/*
Author:   			Le Xuan Manh
Created: 			2010-12-10
Last Modified: 		2010-12-10
*/

@Id bigint
-- WITH ENCRYPTION
AS

SELECT
	
		count(ParentId) as sl
FROM
		[dbo].[Questions]
		
WHERE
		[ParentId] = @Id




GO
/****** Object:  StoredProcedure [dbo].[QuestionDeletedByParentId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[QuestionDeletedByParentId]
@ParentId int
as
select * from Questions 
where ParentId = @ParentId and Id != @ParentId And Deleted ='true'
Order By Id




GO
/****** Object:  StoredProcedure [dbo].[QuestionIdList_SelectBy_FacultyId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[QuestionIdList_SelectBy_FacultyId]
@FacultyId int
AS
SELECT
		DISTINCT CH.*
FROM
		[dbo].[Questions] CH
		JOIN [dbo].[Chapters] P ON P.Id = CH.ChapterId
		JOIN [dbo].[Subjects] S ON S.Id = P.SubjectId	
WHERE
		S.FacultyId = @FacultyId
ORDER BY Id





GO
/****** Object:  StoredProcedure [dbo].[QuestionIdList_SelectBy_SubjectId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[QuestionIdList_SelectBy_SubjectId]

/*
Author:   			Hoang Van Hieu
Created: 			2017-05-28
Last Modified: 		2011-05-30
*/

@SubjectId int
-- WITH ENCRYPTION
AS


SELECT
		DISTINCT CH.Id
FROM
		[dbo].[Questions] CH
		JOIN [dbo].[Chapters] P ON P.Id = CH.ChapterId	
WHERE
		P.SubjectId = @SubjectId
ORDER BY CH.Id





GO
/****** Object:  StoredProcedure [dbo].[Questions_COUNT]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Questions_COUNT]
@ChapterId int
AS
SELECT COUNT(Id) AS QuestionQuantity
  FROM [dbo].[Questions]
  where [ChapterId] = @ChapterId
		and Deleted = 'False' and ParentId =-1 OR [ChapterId] = @ChapterId
		and Deleted = 'False' and ParentId = Id  






GO
/****** Object:  StoredProcedure [dbo].[Questions_Delete_SelectBy_ParentId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Questions_Delete_SelectBy_ParentId]

/*
Author:   			Nguyen Dinh Anh
Created: 			2011-06-20
Last Modified: 		2011-06-20
*/

@ParentId bigint
-- WITH ENCRYPTION
AS


SELECT
		*
FROM
		[dbo].[Questions]
		
WHERE
		[ParentId] = @ParentId
		and Deleted = 'True'
ORDER BY Id













GO
/****** Object:  StoredProcedure [dbo].[Questions_FlagAsDeleted]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Questions_FlagAsDeleted]

/*
Author:   			Pham Phu Thanh Sang
Created: 			2010-11-13
Last Modified: 		2010-11-13
*/
	
@Id bigint

-- WITH ENCRYPTION
AS

UPDATE 		[dbo].[Questions] 

SET
		Deleted = 'True'
			
WHERE
		[Id] = @Id
		and Deleted = 'False'












GO
/****** Object:  StoredProcedure [dbo].[Questions_Insert]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Questions_Insert]
@Content nvarchar(max),
@Interchange bit,
@SubjectiveDifficulty decimal(18,10),
@SelectedTimes int,
@CorrectTimes int,
@Deleted bit,
@ChapterId int,
@CreateDate datetime,
@UpdateDate datetime,
@Mark decimal(18,10),
@Duration int,
@ParentId bigint,
@Discrimination decimal(18,10),
@SubjectId int,
@Audio bit
AS

INSERT INTO 	Questions
(
				Content,
				Interchange,
				SubjectiveDifficulty,
				ObjectiveDifficulty,
				SelectedTimes,
				CorrectTimes,
				Deleted,
				ChapterId,
				CreateDate,
				UpdateDate,
				Mark,
				Duration,
				ParentId,
				Discrimination,
				SubjectId,
				ManagementOrder,
				Audio
				
) 
VALUES 
(
				@Content,
				@Interchange,
				@SubjectiveDifficulty,
				0.5,
				@SelectedTimes,
				@CorrectTimes,
				@Deleted,
				@ChapterId,
				@CreateDate,
				@UpdateDate,
				@Mark,
				@Duration,
				@ParentId,
				@Discrimination,
				@SubjectId,
				(select  (isnull(count(ManagementOrder),0)+1) from Questions where SubjectId = @SubjectId),
				@Audio
)





GO
/****** Object:  StoredProcedure [dbo].[Questions_Paging]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Questions_Paging]
	@PageNumber int
as
	select TOP(@PageNumber*2) * from Questions










GO
/****** Object:  StoredProcedure [dbo].[Questions_Restore]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Questions_Restore]

/*
Author:   			Pham Phu Thanh Sang
Created: 			2010-11-13
Last Modified: 		2010-11-13
*/
	
@Id bigint

-- WITH ENCRYPTION
AS

UPDATE 		[dbo].[Questions] 

SET
		Deleted = 'False'
			
WHERE
		[Id] = @Id
		and Deleted = 'True'












GO
/****** Object:  StoredProcedure [dbo].[Questions_Select_NumberOfChildQuestions]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Questions_Select_NumberOfChildQuestions]

/*
Author:   			Le Xuan Manh
Created: 			2010-12-10
Last Modified: 		2010-12-10
*/

@Id bigint
-- WITH ENCRYPTION
AS

SELECT
	
		count(ParentId) as sl
FROM
		[dbo].[Questions]
		
WHERE
		[ParentId] = (@Id)










GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectAll]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Questions_SelectAll]

/*
Author:   			Nguyen Dinh Anh
Created: 			2011-3-8
Last Modified: 		2011-3-8
*/
-- WITH ENCRYPTION
AS


SELECT          Content,
				Interchange,
				SubjectiveDifficulty,
				ObjectiveDifficulty,
				SelectedTimes,
				CorrectTimes,
				Deleted,
				ChapterId,
				CreateDate,
				UpdateDate,
				Mark,
				Duration,
				ParentId
		
FROM
		[dbo].[CauHoi]















GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectAll_Deleted]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Questions_SelectAll_Deleted]

/*
Author:   			Nguyen Dinh Anh
Created: 			2011-3-8
Last Modified: 		2011-3-8
*/
-- WITH ENCRYPTION
AS


SELECT
		*
FROM
		[dbo].[Questions]
WHERE
		Deleted = 'True'
ORDER BY [Id]












GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectAllId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



Create PROCEDURE [dbo].[Questions_SelectAllId]

/*
Author:   			Nguyen Dinh Anh
Created: 			2011-3-8
Last Modified: 		2011-3-8
*/
-- WITH ENCRYPTION
AS


SELECT          Id
		
FROM
		[dbo].[Questions]





GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_ChapterId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Questions_SelectBy_ChapterId]

/*
Author:   			Hoang Van Hieu
Created: 			2017-05-29
Last Modified: 		2017-05-29
*/

@ChapterId int
-- WITH ENCRYPTION
AS


SELECT
		*
FROM
		[dbo].[Questions]
		
WHERE
		[ChapterId] = @ChapterId
		and Deleted = 'False' and ParentId =-1 OR [ChapterId] = @ChapterId
		and Deleted = 'False' and ParentId = Id OR [ChapterId] = @ChapterId
		and Deleted = 'False'
ORDER BY [Id]





GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_ChapterId_Paging]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Questions_SelectBy_ChapterId_Paging]

@ChapterId int,
@PageNumber INT,   
@PageSize INT  
-- WITH ENCRYPTION
AS
 DECLARE @Start INT, @End INT  
 BEGIN TRANSACTION GetDataSet   
 SET @Start = (((@PageNumber - 1) * @PageSize) + 1)   

 SET @End = (@Start + @PageSize - 1)   
 
 CREATE TABLE #TemporaryTable (   
  Row INT IDENTITY(1,1) PRIMARY KEY,   
	[Id] [bigint],
	[Content] [nvarchar](max) NULL,
	[Interchange] [bit] NULL,
	[SubjectiveDifficulty] [decimal](18, 10) NULL,
	[ObjectiveDifficulty] [decimal](18, 10) NULL,
	[SelectedTimes] [int] NULL,
	[CorrectTimes] [int] NULL,
	[Deleted] [bit] NULL,
	[ChapterId] [int] NOT NULL,
	[CreateDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[Mark] [decimal](18, 10) NULL,
	[Duration] [int] NULL,
	[ParentId] [bigint] NULL,
	[Discrimination] [int] NULL,
	[ManagementOrder] [int] NULL
 )   
 INSERT INTO #TemporaryTable   
  SELECT Id,Content,Interchange,SubjectiveDifficulty,SelectedTimes,SelectedTimes,CorrectTimes,Deleted,ChapterId,CreateDate,UpdateDate,
  Mark,Duration,ParentId,Discrimination,ManagementOrder FROM [Questions]  where ChapterId =@ChapterId
   
 SELECT    Id,Content,Interchange,SubjectiveDifficulty,SelectedTimes,SelectedTimes,CorrectTimes,Deleted,ChapterId,CreateDate,UpdateDate,
  Mark,Duration,ParentId,Discrimination,ManagementOrder
  FROM #TemporaryTable   
  WHERE (Row >= @Start) AND (Row <= @End) AND [ChapterId] = @ChapterId
		and Deleted = 'False'
	ORDER BY [Id]  
 DROP TABLE #TemporaryTable   
 COMMIT TRANSACTION GetDataSet   
 RETURN 0   
ErrorHandler:   
ROLLBACK TRANSACTION GetDataSet   
RETURN @@ERROR 











GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_ChapterId_ParentId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Questions_SelectBy_ChapterId_ParentId]

/*
Author:   			Pham Phu Thanh Sang
Created: 			2010-11-13
Last Modified: 		2010-11-13
*/

@ChapterId int,
@ParentId bigint
-- WITH ENCRYPTION
AS


SELECT
		*
FROM
		[dbo].[Questions]
		
WHERE
		[ChapterId] = @ChapterId
		and [ParentId] = @ParentId
		and Deleted = 'False'
ORDER BY [Id]












GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_Date]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Questions_SelectBy_Date]

/*
Author:   			Nguyen Dinh Anh
Created: 			2011-07-07
Last Modified: 		2011-07-07
*/

@StartTime varchar(100),
@EndTime varchar(100)
-- WITH ENCRYPTION
AS

SELECT CH.*
FROM [dbo].Questions CH
WHERE CH.CreateDate BETWEEN @StartTime AND @EndTime










GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_ParentId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Questions_SelectBy_ParentId]

/*
Author:   			Haong Van Hieu
Created: 			2017-05-27
Last Modified: 		2017-05-30
*/

@ParentId bigint
-- WITH ENCRYPTION
AS


SELECT
		*
FROM
		[dbo].[Questions]
		
WHERE
		[ParentId] = @ParentId
		and Deleted = 'False' and ParentId != Id
ORDER BY Id









GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_SubjectCode]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Questions_SelectBy_SubjectCode]

/*
Author:   			Nguyen Dinh Anh
Created: 			2011-03-25
Last Modified: 		2011-03-25
*/

@SubjectId int,
@SubjectCode int
-- WITH ENCRYPTION
AS


SELECT
		DISTINCT CH.*
FROM
		[dbo].[Questions] CH
		JOIN [dbo].[Chapters] P ON P.Id = CH.Id
WHERE
		P.SubjectId = @SubjectCode
ORDER BY Id












GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectMax_IdQuestions]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Questions_SelectMax_IdQuestions]

/*
Author:   			Hoang Van Hieu
Created: 			2017-05-05
Last Modified: 		2017-05-05
*/

@ChapterId int
-- WITH ENCRYPTION
AS

DECLARE @Max int

SELECT
		@Max = MAX([Id])
FROM
		[dbo].[Questions]
		
WHERE
		[ChapterId] = @ChapterId

IF(@Max IS NULL) SELECT 0
ELSE SELECT @Max






GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectOne]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[Questions_SelectOne]

/*
Author:   			Nguyen Dinh Anh
Created: 			2011-3-8
Last Modified: 		2011-3-8
*/

@Id bigint
-- WITH ENCRYPTION
AS


SELECT
				Id,
				Content,
				Interchange,
				SubjectiveDifficulty,
				ObjectiveDifficulty,
				SelectedTimes,
				CorrectTimes,
				Deleted,
				ChapterId,
				CreateDate,
				UpdateDate,
				Mark,
				Duration,
				ParentId,
				ManagementOrder,
				Discrimination,
				Audio
		
FROM
		[dbo].[Questions]
		
WHERE
		[Id] = @Id















GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectPage]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Questions_SelectPage]

-- Author:   			Nguyen Dinh Anh
-- Created: 			2011-3-8
-- Last Modified: 		2011-3-8

@PageNumber 			int,
@PageSize 			int
-- WITH ENCRYPTION
AS

DECLARE @PageLowerBound int
DECLARE @PageUpperBound int


SET @PageLowerBound = (@PageSize * @PageNumber) - @PageSize
SET @PageUpperBound = @PageLowerBound + @PageSize + 1

/*
Note: temp tables use the server default for collation not the database default
so if adding character columns be sure and specify to use the database collation like this
to avoid collation errors:

CREATE TABLE #PageIndexForUsers
(
IndexID int IDENTITY (1, 1) NOT NULL,
UserName nvarchar(50) COLLATE DATABASE_DEFAULT,
LoginName nvarchar(50) COLLATE DATABASE_DEFAULT
) 


*/

CREATE TABLE #PageIndex 
(
	IndexID int IDENTITY (1, 1) NOT NULL,
Id bigint
)

BEGIN

INSERT INTO #PageIndex ( 
Id
)

SELECT
		[Id]
		
FROM
		[dbo].[Questions]
		
-- WHERE

-- ORDER BY

END


SELECT
		t1.*
		
FROM
		[dbo].[Questions] t1

JOIN			#PageIndex t2
ON			
		t1.[Id] = t2.[Id]
		
WHERE
		t2.IndexID > @PageLowerBound 
		AND t2.IndexID < @PageUpperBound
		
ORDER BY t2.IndexID

DROP TABLE #PageIndex












GO
/****** Object:  StoredProcedure [dbo].[Questions_Update]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[Questions_Update]

/*
Author:   			Nguyen Dinh Anh
Created: 			2011-3-8
Last Modified: 		2011-3-8
*/
@Id bigint, 
@Content nvarchar(max),
@Interchange bit,
@SubjectiveDifficulty decimal(18,10),
@SelectedTimes int,
@CorrectTimes int,
@Deleted bit,
@ChapterId int,
@CreateDate datetime,
@UpdateDate datetime,
@Mark decimal(18,10),
@Duration int,
@ParentId bigint,
@Discrimination decimal(18,10),
@Audio bit
-- WITH ENCRYPTION
AS

UPDATE 		[dbo].[Questions] 

SET
			[ChapterId] = @ChapterId,
			[Content] = @Content,
			[Interchange] = @Interchange,
			[Mark] = @Mark,
			[SubjectiveDifficulty] = @SubjectiveDifficulty,
			[ObjectiveDifficulty] = 0.0,
			[ParentId] = @ParentId,
			[Deleted] = @Deleted,
			[SelectedTimes] = @SelectedTimes,
			[CorrectTimes] = @CorrectTimes,
			[CreateDate] = @CreateDate,
			[UpdateDate] = @UpdateDate,
			[Duration] = @Duration,
			[Discrimination] = @Discrimination,
			[Audio] = @Audio
			
WHERE
			[Id] = @Id




GO
/****** Object:  StoredProcedure [dbo].[Questions_UpdateParentId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Questions_UpdateParentId]

/*
Author:   			Hoang Van Hieu	
Created: 			2017-05-28
Last Modified: 		2017-05-30
*/
	
@Id bigint, 
@ParentId bigint
-- WITH ENCRYPTION
AS

UPDATE 		[dbo].[Questions] 

SET
			[ParentId] = @ParentId
WHERE
			[Id] = @Id





GO
/****** Object:  StoredProcedure [dbo].[QuestionsDeleted_SelectBy_ChapterId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[QuestionsDeleted_SelectBy_ChapterId]

/*
Author:   			Hoang Van Hieu
Created: 			2017-05-29
Last Modified: 		2017-05-29
*/

@ChapterId int
-- WITH ENCRYPTION
AS


SELECT
		*
FROM
		[dbo].[Questions]
		
WHERE
		[ChapterId] = @ChapterId
		and Deleted = 'true' and ParentId =0 OR [ChapterId] = @ChapterId
		and Deleted = 'true' and ParentId = Id
ORDER BY [Id]





GO
/****** Object:  StoredProcedure [dbo].[QuestionsDeleted_SelectBy_ParentId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[QuestionsDeleted_SelectBy_ParentId]

/*
Author:   			Haong Van Hieu
Created: 			2017-05-27
Last Modified: 		2017-05-30
*/

@ParentId bigint
-- WITH ENCRYPTION
AS


SELECT
		*
FROM
		[dbo].[Questions]
		
WHERE
		[ParentId] = @ParentId
		and Deleted = 'true' and ParentId != Id
ORDER BY Id




GO
/****** Object:  StoredProcedure [dbo].[QuestionSheetDetailCreate]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- QuestionSheetDetail
CREATE PROC [dbo].[QuestionSheetDetailCreate]
    @QuestionSheetId BIGINT ,
    @QuestionId BIGINT ,
    @Order INT
AS
    BEGIN
        INSERT  INTO dbo.QuestionSheetDetails
                ( QuestionSheetId ,
                  QuestionId ,
                  [Order]
                )
        VALUES  ( @QuestionSheetId , -- QuestionSheetId - bigint
                  @QuestionId , -- QuestionId - bigint
                  @Order
                );
    END;





GO
/****** Object:  StoredProcedure [dbo].[QuestionSheetDetailSelectById]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[QuestionSheetDetailSelectById]
    @QuestionSheetId BIGINT ,
    @QuestionId BIGINT
AS
    BEGIN
        SELECT * FROM dbo.QuestionSheetDetails WHERE QuestionSheetId = @QuestionSheetId AND QuestionId = @QuestionId
    END;





GO
/****** Object:  StoredProcedure [dbo].[QuestionSheetDetailUpdate]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[QuestionSheetDetailUpdate]
    @QuestionSheetId BIGINT ,
    @QuestionId BIGINT ,
    @Order INT ,
    @AnswerId INT ,
    @Correct BIT ,
    @CreateDate DATETIME ,
    @UpdateDate DATETIME ,
    @ListenTimes INT
AS
    BEGIN
        UPDATE dbo.QuestionSheetDetails
		SET [Order] = @Order, AnswerId = @AnswerId, CreateDate = @CreateDate,
			UpdateDate = @UpdateDate, ListenTimes = @ListenTimes
        WHERE QuestionSheetId = @QuestionSheetId AND QuestionId = @QuestionId
    END;





GO
/****** Object:  StoredProcedure [dbo].[QuestionSheetGetAll]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[QuestionSheetGetAll]
as
Select * from QuestionSheets
order by Id Desc




GO
/****** Object:  StoredProcedure [dbo].[QuestionSheetID_SelectMax]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[QuestionSheetID_SelectMax]

/*
Author:   			Hoang Van Hieu
Created: 			2017-05-05
Last Modified: 		2017-05-05
*/

-- WITH ENCRYPTION
AS

DECLARE @Max int

SELECT
		@Max = MAX(Id)
FROM
		[dbo].[PaperQuestionSheets]

IF(@Max IS NULL) SELECT 0
ELSE SELECT @Max




GO
/****** Object:  StoredProcedure [dbo].[QuestionSheetInsert]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[QuestionSheetInsert]
    @Name NVARCHAR(100) ,
    @CreateDate DATETIME ,
    @Approved BIT ,
    @Started BIT ,
    @Completed BIT ,
    @ExtraTime INT ,
    @ExtraTimeReason NVARCHAR(100) ,
    @Mark DECIMAL ,
    @ShiftSubjectStudentId BIGINT ,
    @NumberOfCorrect INT ,
    @Total INT ,
    @Difficulty DECIMAL,
	@UserId INT
AS
    BEGIN
        INSERT  INTO dbo.QuestionSheets
                ( Name ,
                  CreateDate ,
                  Approved ,
                  [Started] ,
                  Completed ,
                  ExtraTime ,
                  ExtraTimeReason ,
                  Mark ,
                  NumberOfCorrect ,
                  Total ,
                  Difficulty ,
                  UserId
	            )
        VALUES  ( @Name , -- Name - nvarchar(100)
                  @CreateDate , -- CreateDate - datetime
                  @Approved , -- Approved - bit
                  @Started , -- Started - bit
                  @Completed , -- Completed - bit
                  @ExtraTime , -- ExtraTime - int
                  @ExtraTimeReason , -- ExtraTimeReason - nvarchar(100)
                  @Mark , -- Mark - decimal
                  @NumberOfCorrect , -- NumberOfCorrect - int
                  @Total , -- Total - int
                  @Difficulty, -- Difficulty - decimal
				  @UserId
	            );
    END;

GO
/****** Object:  StoredProcedure [dbo].[QuestionSheetSelectById]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[QuestionSheetSelectById]
	@Id BIGINT
AS
    BEGIN
        SELECT * FROM dbo.QuestionSheets WHERE Id = @Id
    END;





GO
/****** Object:  StoredProcedure [dbo].[QuestionSheetUpdate]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[QuestionSheetUpdate]
	@Id BIGINT,
    @Name NVARCHAR(100) ,
    @CreateDate DATETIME ,
    @Approved BIT ,
    @Started BIT ,
    @Completed BIT ,
    @ExtraTime INT ,
    @ExtraTimeReason NVARCHAR(100) ,
    @Mark DECIMAL ,
    @ShiftSubjectStudentId BIGINT ,
    @NumberOfCorrect INT ,
    @Total INT ,
    @Difficulty DECIMAL
AS
    BEGIN
        UPDATE dbo.QuestionSheets
		SET [Name] = @Name, CreateDate = @CreateDate, Approved = @Approved,
			[Started] = @Started, Completed = @Completed, ExtraTime = @ExtraTime,
			ExtraTimeReason = @ExtraTimeReason, Mark = @Mark,
			NumberOfCorrect = @NumberOfCorrect, Total = @Total, Difficulty = @Difficulty
        WHERE Id = @Id
    END;

GO
/****** Object:  StoredProcedure [dbo].[RestoreQuestionDeleted]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[RestoreQuestionDeleted]

@Id bigint
-- WITH ENCRYPTION
AS
BEGIN
	update Questions set Deleted = 'false' where [Id] = @Id AND Deleted = 'true';
	Declare  @SubjectId int;
	SET @SubjectId = (SELECT SubjectId from Questions where Id = @Id) ;
	Declare @Faculty int;
	SET @Faculty = (select FacultyId from Subjects where Id = @SubjectId);
	UPDATE Subjects set Deleted = 'false' Where Id = @SubjectId;
	UPDATE Faculties Set Deleted = 'false' WHERE Id = @Faculty;
END




GO
/****** Object:  StoredProcedure [dbo].[ShiftInsert]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Shift
CREATE PROC [dbo].[ShiftInsert]
    @Name NVARCHAR(50) ,
    @StartTime DATETIME ,
    @EndTime DATETIME ,
    @Activated BIT ,
    @ActivateTime DATETIME ,
    @Duration INT ,
    @Ended BIT ,
    @EndDate DATETIME ,
    @ExamId INT ,
    @QuestionSheetCreated BIT ,
    @Deleted BIT
AS
    BEGIN

        INSERT  INTO dbo.Shifts
                ( [Name] ,
                  StartTime ,
                  EndTime ,
                  Activated ,
                  ActivateTime ,
                  Duration ,
                  Ended ,
                  EndDate ,
                  ExamId ,
                  QuestionSheetCreated ,
                  Deleted
	            )
        VALUES  ( @Name , -- Name - nvarchar(50)
                  @StartTime , -- StartTime - datetime
                  @EndTime , -- EndTime - datetime
                  @Activated , -- Activated - bit
                  @ActivateTime , -- ActivateTime - datetime
                  @Duration , -- Duration - int
                  @Ended , -- Ended - bit
                  @EndTime , -- EndDate - datetime
                  @ExamId , -- ExamId - int
                  @QuestionSheetCreated , -- QuestionSheetCreated - bit
                  @Deleted  -- Deleted - bit
	            );
    END;





GO
/****** Object:  StoredProcedure [dbo].[ShiftSelectByExamId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ShiftSelectByExamId]
	@ExamId INT
AS
    BEGIN

        SELECT * FROM dbo.Shifts
		WHERE ExamId = @ExamId
		order by Id DESC
    END;





GO
/****** Object:  StoredProcedure [dbo].[ShiftSelectById]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ShiftSelectById]
	@Id INT
AS
    BEGIN

        SELECT * FROM dbo.Shifts
		WHERE Id = @Id
    END;






GO
/****** Object:  StoredProcedure [dbo].[ShiftSubjectInsert]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ShiftSubjects
CREATE PROC [dbo].[ShiftSubjectInsert]
	@ShiftId  int,
	@SubjectId  int,
	@MatrixId  bigint
AS
    BEGIN

		DECLARE @ROW int;
		SEt @ROW = (SELECT Id FROM dbo.PaperShiftSubjects WHERE ShiftId =@ShiftId AND SubjectId = @SubjectId)
		IF(@ROW is NULL)
			BEGIN
				INSERT INTO dbo.PaperShiftSubjects 
					( ShiftId, SubjectId, MatrixId )
				VALUES  ( @ShiftId, -- ShiftId - int
					  @SubjectId, -- SubjectId - int
					  @MatrixId  -- MatrixId - bigint
					  )
			END
		ELSE
			BEGIN
				UPDATE PaperShiftSubjects SET MatrixId = @MatrixId WHERE ShiftId =@ShiftId AND SubjectId = @SubjectId
				SELECT 1;
			END
    END;


	SELECT * FROM PaperShiftSubjects


	




GO
/****** Object:  StoredProcedure [dbo].[ShiftSubjectSelectById]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ShiftSubjectSelectById] @Id BIGINT
AS
    BEGIN

        SELECT  *
        FROM    dbo.ShiftSubjects
        WHERE   Id = @Id;
    END;





GO
/****** Object:  StoredProcedure [dbo].[ShiftSubjectSelectByShiftId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ShiftSubjectSelectByShiftId] 
@ShiftId BIGINT
AS
    BEGIN

        SELECT  *
        FROM    dbo.ShiftSubjects
        WHERE   ShiftId = @ShiftId;
    END;





GO
/****** Object:  StoredProcedure [dbo].[ShiftSubjectStudentInsert]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ShiftSubjectStudents
CREATE PROC [dbo].[ShiftSubjectStudentInsert]
    @ShiftSubjectId BIGINT ,
    @StudentId INT ,
    @QuestionSheetId BIGINT ,
    @LogIn BIT ,
    @LastLogIn BIT ,
    @LastLogOut BIT
AS
    BEGIN

        INSERT  INTO dbo.ShiftSubjectStudents
                ( ShiftSubjectId ,
                  StudentId ,
                  QuestionSheetId ,
                  LogIn ,
                  LastLogIn ,
                  LastLogOut
                )
        VALUES  ( @ShiftSubjectId , -- ShiftSubjectId - bigint
                  @StudentId , -- StudentId - int
                  @QuestionSheetId , -- QuestionSheetId - bigint
                  @LogIn , -- LogIn - bit
                  @LastLogIn , -- LastLogIn - bit
                  @LastLogOut  -- LastLogOut - bit
                );
    END;





GO
/****** Object:  StoredProcedure [dbo].[ShiftSubjectStudentSelectById]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ShiftSubjectStudentSelectById]
    @ShiftSubjectId BIGINT ,
    @StudentId INT
AS
    BEGIN

        SELECT * FROM dbo.ShiftSubjectStudents
        WHERE ShiftSubjectId = @ShiftSubjectId AND StudentId = @StudentId
    END;	





GO
/****** Object:  StoredProcedure [dbo].[ShiftSubjectStudentUpdate]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ShiftSubjectStudentUpdate]
    @ShiftSubjectId BIGINT ,
    @StudentId INT ,
    @QuestionSheetId BIGINT ,
    @LogIn BIT ,
    @LastLogIn BIT ,
    @LastLogOut BIT
AS
    BEGIN

        UPDATE dbo.ShiftSubjectStudents
		SET [LogIn] = @LogIn, LastLogIn = @LastLogIn, LastLogOut = @LastLogOut, QuestionSheetId = @QuestionSheetId
        WHERE ShiftSubjectId = @ShiftSubjectId AND StudentId = @StudentId
    END;





GO
/****** Object:  StoredProcedure [dbo].[ShiftSubjectUpdate]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ShiftSubjects
CREATE PROC [dbo].[ShiftSubjectUpdate]
	@Id int,
	@ShiftId  int,
	@SubjectId  int,
	@MatrixId  bigint
AS
    BEGIN
	UPDATE ShiftSubjects SET ShiftId = @ShiftId, SubjectId = @SubjectId, MatrixId = @MatrixId
			WHERE Id = @Id
    END;





GO
/****** Object:  StoredProcedure [dbo].[ShiftUpdate]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ShiftUpdate]
	@Id INT,
    @Name NVARCHAR(50) ,
    @StartTime DATETIME ,
    @EndTime DATETIME ,
    @Activated BIT ,
    @ActivateTime DATETIME ,
    @Duration INT ,
    @Ended BIT ,
    @EndDate DATETIME ,
    @ExamId INT ,
    @QuestionSheetCreated BIT ,
    @Deleted BIT
AS
    BEGIN

        UPDATE dbo.Shifts
		SET [Name] = @Name, StartTime = @StartTime, EndTime=@EndTime, Activated = @Activated, ActivateTime = @ActivateTime, Duration = @Duration, Ended = @Ended, EndDate = @EndDate, ExamId = @ExamId, QuestionSheetCreated = @QuestionSheetCreated, Deleted = @Deleted
        WHERE Id =@Id
    END;





GO
/****** Object:  StoredProcedure [dbo].[Subject_Delete]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Subject_Delete]
@Id INT,
@FacultyId INT
AS
BEGIN
	BEGIN
		UPDATE Subjects SET Deleted ='true', validated =0 where Id = @Id;
		UPDATE Chapters SET Deleted = 'true', validated =0 WHERE SubjectId = @Id;
		UPDATE Questions SET Deleted = 'true', validated =0 WHERE SubjectId =@Id;
	END	
	DECLARE @SoLuongCauHoi int;
	SET @SoLuongCauHoi = (SELECT COUNT(Id) FROM Questions
						WHERE validated =1 AND SubjectId IN(SELECT Id FROM Subjects WHERE FacultyId = @FacultyId))
	IF(@SoLuongCauHoi =0)
		UPDATE Faculties SET Deleted = 1, validated =0 WHERE Id =@FacultyId
END



GO
/****** Object:  StoredProcedure [dbo].[Subject_SelectBy_QuestionDelete]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Subject_SelectBy_QuestionDelete]

/*
Author:   			Hoang Van Hieu
Created: 			2017-06-01
Last Modified: 		2017-06-01
*/

@FaculyId bigint
-- WITH ENCRYPTION
AS

SELECT  MH.Id, MH.Name, MH.Code , Count(MH.Id) as 'SoCauHoi'

FROM 
	[dbo].[Faculties] K
	JOIN [dbo].[Subjects] MH ON MH.FacultyId = K.Id
	JOIN [dbo].[Chapters] P ON P.SubjectId = MH.Id
	JOIN [dbo].[Questions] CH ON CH.ChapterId = P.Id

WHERE 
	
	CH.Deleted = 'true' AND CH.validated =1
	AND K.Id = @FaculyId

GROUP BY MH.Id, MH.Name, MH.Code







GO
/****** Object:  StoredProcedure [dbo].[Subjects_Count]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Subjects_Count]
AS
SELECT COUNT([Id]) AS Quantity_Subjects
     
  FROM [dbo].[Subjects]












GO
/****** Object:  StoredProcedure [dbo].[Subjects_FlagAsDeleted]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Subjects_FlagAsDeleted]
	@Code Varchar

AS

DELETE FROM [dbo].[Subjects]
  WHERE Code= @Code













GO
/****** Object:  StoredProcedure [dbo].[Subjects_Insert]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Subjects_Insert]

@FacultyId int,
@Code varchar(10),
@Name nvarchar(100),
@Deleted bit

-- WITH ENCRYPTION
AS

INSERT INTO 	[dbo].[Subjects] 
(
				[Code],
				[Name],
				[Deleted],
				[FacultyId],
				[ManagementOrder]
) 

VALUES 
(
				@Code,
				@Name,
				@Deleted,
				@FacultyId,
				(select  (isnull(count(ManagementOrder),0)+1) from Subjects where FacultyId = @FacultyId)
				
)






GO
/****** Object:  StoredProcedure [dbo].[Subjects_Restore]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Subjects_Restore]

/*
Author:   			Nguyen Bao Quoc
Created: 			2011-3-8
Last Modified: 		2011-3-8
*/
	
@Id bigint,
@FacultyId int

-- WITH ENCRYPTION
AS
BEGIN

	UPDATE Questions SET Deleted = 0
	WHERE SubjectId = @Id

	UPDATE Chapters SET Deleted = 0
	WHERE SubjectId = @Id

	UPDATE Subjects	SET Deleted = 0
	WHERE Id = @Id

	DECLARE @SoLuongCauHoi int;
	Set @SoLuongCauHoi = (SELECT Count(Id) FROM Questions 
						  WHERE Deleted = 1 AND SubjectId IN(SELECT Id from Subjects WHERE FacultyId = @FacultyId))
	IF(@SoLuongCauHoi =0)
		UPDATE Faculties SET Deleted =0 WHERE Id = @FacultyId
END



GO
/****** Object:  StoredProcedure [dbo].[Subjects_SelectAll]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Subjects_SelectAll]

/*
Author:   			Nguyen Bao Quoc
Created: 			2011-3-8
Last Modified: 		2011-3-8
*/
-- WITH ENCRYPTION
AS


SELECT
		[Id],
		[Code],
		[Name],
		[Deleted],
		[FacultyId],
		[ManagementOrder]
		
FROM
		[dbo].[Subjects]




GO
/****** Object:  StoredProcedure [dbo].[Subjects_SelectAll_Deleted]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Subjects_SelectAll_Deleted]

/*
Author:   			Nguyen Bao Quoc
Created: 			2011-3-8
Last Modified: 		2011-3-8
*/
-- WITH ENCRYPTION
AS


SELECT
		*		
FROM
		[dbo].[Subjects]
where
		Deleted = 'True'











GO
/****** Object:  StoredProcedure [dbo].[Subjects_SelectBy_FacultyId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Subjects_SelectBy_FacultyId]

/*
Author:   			Nguyen Bao Quoc
Created: 			2011-3-8
Last Modified: 		2011-3-8
*/

@FacultyId int
-- WITH ENCRYPTION
AS


SELECT
		*
		
FROM
		[dbo].[Subjects]
		
WHERE
		[FacultyId] = @FacultyId
		and Deleted = 'False'










GO
/****** Object:  StoredProcedure [dbo].[Subjects_SelectOne]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Subjects_SelectOne]

/*
Author:   			Nguyen Bao Quoc
Created: 			2011-3-8
Last Modified: 		2011-3-8
*/

@Id bigint
-- WITH ENCRYPTION
AS


SELECT
		[Id],
		[Code],
		[Name],
		[Deleted],
		[FacultyId],
		[ManagementOrder]
		
FROM
		[dbo].[Subjects]
		
WHERE
		[Id] = @Id












GO
/****** Object:  StoredProcedure [dbo].[Subjects_SelectOneByName]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Subjects_SelectOneByName]

/*
Author:   			Nguyen Bao Quoc
Created: 			2011-3-8
Last Modified: 		2011-3-8
*/
@FacultyId int,
@Name nvarchar(100)
-- WITH ENCRYPTION
AS


SELECT
		*		
FROM
		[dbo].[Subjects]
		
WHERE
		lower([Name]) =  lower(@Name)
		and [FacultyId] = @FacultyId











GO
/****** Object:  StoredProcedure [dbo].[Subjects_SelectPage]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Subjects_SelectPage]

-- Author:   			Nguyen Bao Quoc
-- Created: 			2011-3-8
-- Last Modified: 		2011-3-8

@PageNumber 			int,
@PageSize 			int
-- WITH ENCRYPTION
AS

DECLARE @PageLowerBound int
DECLARE @PageUpperBound int


SET @PageLowerBound = (@PageSize * @PageNumber) - @PageSize
SET @PageUpperBound = @PageLowerBound + @PageSize + 1

/*
Note: temp tables use the server default for collation not the database default
so if adding character columns be sure and specify to use the database collation like this
to avoid collation errors:

CREATE TABLE #PageIndexForUsers
(
IndexID int IDENTITY (1, 1) NOT NULL,
UserName nvarchar(50) COLLATE DATABASE_DEFAULT,
LoginName nvarchar(50) COLLATE DATABASE_DEFAULT
) 


*/

CREATE TABLE #PageIndex 
(
	IndexID int IDENTITY (1, 1) NOT NULL,
	Id bigint
)

BEGIN

INSERT INTO #PageIndex ( 
Id
)

SELECT
		[Id]
		
FROM
		[dbo].[Subjects]
		
-- WHERE

-- ORDER BY

END


SELECT
		t1.*
		
FROM
		[dbo].[Subjects] t1

JOIN			#PageIndex t2
ON			
		t1.[Id] = t2.[Id]
		
WHERE
		t2.IndexID > @PageLowerBound 
		AND t2.IndexID < @PageUpperBound
		
ORDER BY t2.IndexID

DROP TABLE #PageIndex












GO
/****** Object:  StoredProcedure [dbo].[Subjects_Update]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Subjects_Update]
	/*
	Author:   			HOANG VAN HIEU
	Created: 			2017-02-06
	Last Modified: 		2017-02-06
	*/
	@Id int,
	@Code varchar(10),
    @Name  nvarchar(100),
    @Deleted bit,
    @FacultyId int
AS
BEGIN
	IF(@Deleted='False')
		UPDATE [dbo].[Subjects]
		   SET [Code] = @Code
			  ,[Name] = @Name
			  ,[Deleted] = @Deleted
			  ,[FacultyId] = @FacultyId
		 WHERE [Id] = @Id
	ELSE
		BEGIN
			UPDATE Subjects SET Deleted ='true' where Id = @Id;
			UPDATE Chapters SET Deleted = 'true' WHERE SubjectId = @Id;
			UPDATE Questions SET Deleted = 'true' WHERE SubjectId =@Id;
		END	
	DECLARE @SoLuongCauHoi int;
	SET @SoLuongCauHoi = (SELECT COUNT(Id) FROM Questions
						WHERE Deleted =0 AND SubjectId IN(SELECT Id FROM Subjects WHERE FacultyId = @FacultyId))
	select @SoLuongCauHoi
	IF(@SoLuongCauHoi =0)
		UPDATE Faculties SET Deleted = 1 WHERE Id =@FacultyId
END




GO
/****** Object:  StoredProcedure [dbo].[UpdateAnswer]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateAnswer]
    @questionSheetId BIGINT ,
    @questionId BIGINT ,
    @answerId BIGINT
AS
    BEGIN
        DECLARE @completed BIT;

        SELECT  @completed = Completed
        FROM    dbo.QuestionSheets
        WHERE   Id = @questionSheetId;

        IF ( @completed = 0 ) --false
            BEGIN
                UPDATE  dbo.QuestionSheetDetails
                SET     AnswerId = @answerId
                WHERE   QuestionSheetId = @questionSheetId
                        AND QuestionId = @questionId;

                SELECT  'true' AS Result; --true
            END;
        ELSE
            SELECT 'false' AS Result; --false
    END;




GO
/****** Object:  StoredProcedure [dbo].[UpdateDiscriminationForQuestion]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[UpdateDiscriminationForQuestion]
@MarkAdv decimal(18,10),
@MarkBle decimal(18,10),
@AnswerId BigInt,
@QuestionId BigInt
as
BEGIN
	DECLARE @Adv int;
	DECLARE @Ble int;
	SET @Adv =(SELECT isnull(count(AnswerId),0) from QuestionSheetDetails QD Join QuestionSheets QS ON QD.QuestionSheetId = QS.Id 
				where QS.Mark >@MarkAdv And QD.AnswerId =@AnswerId And QD.QuestionId =@QuestionId  And Correct =1)
	SET @Ble = (SELECT ISNULL(COUNT(AnswerId),0) from QuestionSheetDetails QD Join QuestionSheets QS ON QD.QuestionSheetId = QS.Id 
				WHERE QS.Mark <@MarkBle And QD.AnswerId =@AnswerId And QD.QuestionId =@QuestionId And Correct=1);
	update Questions SET Discrimination =ABS(Convert(decimal(18,10),(CONVERT(decimal(18,10),(1-0)) / CONVERT(decimal(18,10),(0.27*SELECTedTimes))))) where Id = @QuestionId And SELECTedTimes >0
END




GO
/****** Object:  StoredProcedure [dbo].[UpdateDiscriminationForQuestionByChapterId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UpdateDiscriminationForQuestionByChapterId]
@ChapterId int,
@MarkAdv decimal(18,10),
@MarkBle decimal(18,10),
@Limit decimal(18,10),
@SelectedTimes int
As
BEGIN
	DECLARE @QuestionId BigInt;
	DECLARE MY_CURSOR CURSOR 
	  LOCAL STATIC READ_ONLY FORWARD_ONLY
	FOR 
	SELECT DISTINCT Id 
	FROM QuestionsV WHERE ChapterId =@ChapterId

	OPEN MY_CURSOR
	FETCH NEXT FROM MY_CURSOR INTO @QuestionId
	WHILE @@FETCH_STATUS = 0
	BEGIN 

		DECLARE @AnswerId BigInt;
		DECLARE MY_CURSOR_Ans CURSOR 
		  LOCAL STATIC READ_ONLY FORWARD_ONLY
		FOR 
		SELECT DISTINCT Id 
		FROM AnswersV 

		OPEN MY_CURSOR_Ans
		FETCH NEXT FROM MY_CURSOR INTO @AnswerId
		WHILE @@FETCH_STATUS = 0
		BEGIN 
			Update Answers set SelectedTimes = (select ISNULL(COUNT(AnswerId),0) from QuestionSheetDetails 
			where Answers.Id = AnswerId  Group By AnswerId) WHERE Id = @AnswerId
			DECLARE @Adv int;
			DECLARE @Ble int;
			SET @Adv =(SELECT isnull(count(AnswerId),0) from QuestionSheetDetails QD Join QuestionSheets QS ON QD.QuestionSheetId = QS.Id 
						where QS.Mark >(@MarkAdv-0.1) And QD.AnswerId =@AnswerId And QD.QuestionId =@QuestionId  And Correct =1)
			SET @Ble = (SELECT ISNULL(COUNT(AnswerId),0) from QuestionSheetDetails QD Join QuestionSheets QS ON QD.QuestionSheetId = QS.Id 
						WHERE QS.Mark <(@MarkBle+0.1) And QD.AnswerId =@AnswerId And QD.QuestionId =@QuestionId And Correct=1);
			update Questions SET Discrimination =ABS(Convert(decimal(18,10),(CONVERT(decimal(18,10),(@Adv-@Ble)) / CONVERT(decimal(18,10),(@Limit*SELECTedTimes))))) where Id = @QuestionId And SelectedTimes >@SelectedTimes
			FETCH NEXT FROM MY_CURSOR_Ans INTO @AnswerId
		END
		CLOSE MY_CURSOR_Ans
		DEALLOCATE MY_CURSOR_Ans
		FETCH NEXT FROM MY_CURSOR INTO @QuestionId
	END
	CLOSE MY_CURSOR
	DEALLOCATE MY_CURSOR
END




GO
/****** Object:  StoredProcedure [dbo].[UpdateDiscriminationForQuestionBySubjectId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UpdateDiscriminationForQuestionBySubjectId]
@SubjectId int,
@MarkAdv decimal(18,10),
@MarkBle decimal(18,10),
@Limit decimal(18,10),
@SelectedTimes int
As
BEGIN
	DECLARE @QuestionId BigInt;
	DECLARE MY_CURSOR CURSOR 
	  LOCAL STATIC READ_ONLY FORWARD_ONLY
	FOR 
	SELECT DISTINCT Id 
	FROM QuestionsV WHERE SubjectId =@SubjectId

	OPEN MY_CURSOR
	FETCH NEXT FROM MY_CURSOR INTO @QuestionId
	WHILE @@FETCH_STATUS = 0
	BEGIN 

		DECLARE @AnswerId BigInt;
		DECLARE MY_CURSOR_Ans CURSOR 
		  LOCAL STATIC READ_ONLY FORWARD_ONLY
		FOR 
		SELECT DISTINCT Id 
		FROM AnswersV 

		OPEN MY_CURSOR_Ans
		FETCH NEXT FROM MY_CURSOR INTO @AnswerId
		WHILE @@FETCH_STATUS = 0
		BEGIN 
			Update Answers set SelectedTimes = (select ISNULL(COUNT(AnswerId),0) from QuestionSheetDetails 
			where Answers.Id = AnswerId  Group By AnswerId) WHERE Id = @AnswerId
			DECLARE @Adv int;
			DECLARE @Ble int;
			SET @Adv =(SELECT isnull(count(AnswerId),0) from QuestionSheetDetails QD Join QuestionSheets QS ON QD.QuestionSheetId = QS.Id 
						where QS.Mark >(@MarkAdv-0.1) And QD.AnswerId =@AnswerId And QD.QuestionId =@QuestionId  And Correct =1)
			SET @Ble = (SELECT ISNULL(COUNT(AnswerId),0) from QuestionSheetDetails QD Join QuestionSheets QS ON QD.QuestionSheetId = QS.Id 
						WHERE QS.Mark <(@MarkBle+0.1) And QD.AnswerId =@AnswerId And QD.QuestionId =@QuestionId And Correct=1);
			update Questions SET Discrimination =ABS(Convert(decimal(18,10),(CONVERT(decimal(18,10),(@Adv-@Ble)) / CONVERT(decimal(18,10),(@Limit*SELECTedTimes))))) where Id = @QuestionId And SELECTedTimes >@SelectedTimes
			FETCH NEXT FROM MY_CURSOR_Ans INTO @AnswerId
		END
		CLOSE MY_CURSOR_Ans
		DEALLOCATE MY_CURSOR_Ans
		FETCH NEXT FROM MY_CURSOR INTO @QuestionId
	END
	CLOSE MY_CURSOR
	DEALLOCATE MY_CURSOR
END




GO
/****** Object:  StoredProcedure [dbo].[UpdateListenTimes]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateListenTimes]
    @questionSheetId BIGINT ,
    @questionId BIGINT
AS
    BEGIN
        DECLARE @listenTimes INT;

        SET @listenTimes = ( SELECT   ListenTimes
                           FROM     dbo.QuestionSheetDetails
                           WHERE    QuestionSheetId = @questionSheetId
                                    AND QuestionId = @questionId
                         );
        IF ( @listenTimes <= 5 )
            SET @listenTimes = @listenTimes + 1;
	
        UPDATE  dbo.QuestionSheetDetails
        SET     ListenTimes = @listenTimes
        WHERE   QuestionSheetId = @questionSheetId
                AND QuestionId = @questionId;

        IF ( @listenTimes <= 5 )
            SELECT  'true' AS Result --trả store về true
        ELSE
            SELECT  'false' AS Result; --trả store về false
    END;




GO
/****** Object:  StoredProcedure [dbo].[UpdateObjectiveDifficulty]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[UpdateObjectiveDifficulty]

@ChapterId int

as
	UPDATE Questions SET ObjectiveDifficulty =(CONVERT(decimal(18,10),(CorrectTimes)))/(CONVERT(decimal(18,10),(SelectedTimes)))
	WHERE CorrectTimes>0 and SelectedTimes >0 and ChapterId =@ChapterId




GO
/****** Object:  StoredProcedure [dbo].[UpdateObjectiveDifficultyByChapterId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[UpdateObjectiveDifficultyByChapterId]

@ChapterId int,
@SelectedTimes int
as
	UPDATE Questions SET ObjectiveDifficulty =(CONVERT(decimal(18,10),(CorrectTimes)))/(CONVERT(decimal(18,10),(SelectedTimes)))
	WHERE CorrectTimes>0 and SelectedTimes >(@SelectedTimes-1) and ChapterId =@ChapterId




GO
/****** Object:  StoredProcedure [dbo].[UpdateObjectiveDifficultyBySubjectId]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[UpdateObjectiveDifficultyBySubjectId]

@SubjectId int,
@SelectedTimes int

as
	UPDATE Questions SET ObjectiveDifficulty =(CONVERT(decimal(18,10),(CorrectTimes)))/(CONVERT(decimal(18,10),(SelectedTimes)))
	WHERE CorrectTimes>0 and SelectedTimes >@SelectedTimes and SubjectId =@SubjectId




GO
/****** Object:  StoredProcedure [dbo].[UpdatePaperQuestionSheet]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UpdatePaperQuestionSheet]
@Id Bigint
AS
	UPDATE PaperQuestionSheets SET Exported =1, ExportDate = GETDATE()
	WHERE Id =@Id


GO
/****** Object:  StoredProcedure [dbo].[UpdateSelectedTimeCorrect]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[UpdateSelectedTimeCorrect] 
As
Update Answers set SelectedTimes = (select ISNULL(COUNT(AnswerId),0) from QuestionSheetDetails 
where Answers.Id = AnswerId  Group By AnswerId) WHere Id in (Select AnswerId from QuestionSheetDetails Group by AnswerId)





GO
/****** Object:  StoredProcedure [dbo].[User_SelectAll]    Script Date: 21/07/2017 1:21:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[User_SelectAll]
AS
	SELECT * FROM [Users]





GO
USE [master]
GO
ALTER DATABASE [ObjectiveTest] SET  READ_WRITE 
GO
