USE [master]
GO
/****** Object:  Database [ObjectiveTest]    Script Date: 31-Jul-17 1:43:19 PM ******/
CREATE DATABASE [ObjectiveTest]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ObjectiveTest', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\ObjectiveTest.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ObjectiveTest_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\ObjectiveTest_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
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
/****** Object:  Table [dbo].[Answers]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  Table [dbo].[QuestionSheetDetails]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  View [dbo].[AnswersV]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  Table [dbo].[Questions]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  View [dbo].[QuestionsV]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  View [dbo].[QuestionV]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  Table [dbo].[Chapters]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  Table [dbo].[Exams]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  Table [dbo].[Faculties]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  Table [dbo].[Matrices]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  Table [dbo].[MatrixDetails]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  Table [dbo].[PaperQuestionSheetDetails]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  Table [dbo].[PaperQuestionSheets]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  Table [dbo].[PaperShiftSubjects]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaperShiftSubjects](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ShiftId] [int] NULL,
	[SubjectId] [int] NULL,
	[MatrixId] [int] NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_PaperShiftSubjects] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[QuestionSheets]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  Table [dbo].[Shifts]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  Table [dbo].[ShiftSubjects]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  Table [dbo].[ShiftSubjectStudents]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  Table [dbo].[Students]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  Table [dbo].[Subjects]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  Table [dbo].[UserRoles]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
SET IDENTITY_INSERT [dbo].[Answers] ON 

INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (1, 1, N'Dùng 

điều 

chế 

Al 

trong 

công 

nghiệp 

hiện 

nay

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (2, 1, N'Na

, 

K 

dùng 

làm 

chất 

trao 

đổi 

nhiệt 

ở 

một 

vài 

phản 

ứng 

hạt 

nhân

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (3, 1, N'Dùng 

trong 

tổng 

hợp 

hữu 

cơ

.', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (4, 1, N'Tạo 

hợp 

kim 

có 

nhiệt 

độ 

nóng 

chảy 

thấp

, 

dùng 

trong 

thiết 

bị 

báo 

cháy

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (5, 2, N'CH<sub>3</sub>COOH 

và 

CH<sub>3</sub>OH

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (6, 2, N'CH<sub>3</sub>COOH

, 

CH<sub>3</sub>OH 

và 

H<sub>2</sub>SO<sub>4</sub> 

đặc

.', 2, 1, 0, 14)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (7, 2, N'CH<sub>3</sub>COOH 

và 

C<sub>2</sub>H<sub>5</sub>OH

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (8, 2, N'CH<sub>3</sub>COOH

, 

C<sub>2</sub>H<sub>5</sub>OH 

và 

H<sub>2</sub>SO<sub>4</sub> 

đặc

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (9, 3, N'Đều 

tác 

dụng 

với 

dung 

dịch 

AgNO<sub>3</sub>

/

NH<sub>3</sub>

, 

đun 

nóng

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (10, 3, N'Đều 

tác 

dụng 

với 

H<sub>2</sub> 

xúc 

tác 

Ni

, 

t<sup>0</sup>

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (11, 3, N'Đều 

làm 

mất 

màu 

nước 

Br<sub>2</sub>

.', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (12, 3, N'Đều 

có 

công 

thức 

phân 

tử 

C<sub>6</sub>H<sub>12</sub>O<sub>6</sub>

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (13, 4, N'[

Ar

]

3d<sup>8</sup>4s<sup>2</sup>

<sup>               </sup>', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (14, 4, N'[

Ar

]

4s<sup>2</sup>3d<sup>8</sup>

<sup>               </sup>', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (15, 4, N'[

Ar

]

3d<sup>9</sup>4s<sup>1</sup>

<sup>               </sup>', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (16, 4, N'[

Ar

]

3d<sup>10</sup>', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (17, 5, N'194

,

40 

gam', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (18, 5, N'97

,

20 

gam', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (19, 5, N'174

,

96 

gam', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (20, 5, N'87

,

48 

gam', 4, 0, 0, 2)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (21, 6, N'4', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (22, 6, N'3', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (23, 6, N'6', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (24, 6, N'5', 4, 0, 0, 2)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (25, 7, N'SO<sub>2</sub>

, 

CO

, 

NO<sub>2</sub>

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (26, 7, N'SO<sub>2</sub>

, 

CO

, 

NO

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (27, 7, N'NO

, 

NO<sub>2</sub>

, 

SO<sub>2</sub>

.', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (28, 7, N'NO<sub>2</sub>

, 

CO<sub>2</sub>

, 

CO

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (29, 8, N'2

.', 1, 0, 0, 2)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (30, 8, N'3

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (31, 8, N'4

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (32, 8, N'1

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (33, 9, N'PVA

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (34, 9, N'PVC

.', 2, 0, 0, 2)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (35, 9, N'PP

.', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (36, 9, N'PS

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (37, 10, N'Cho 

Ag 

vào 

dung 

dịch 

H<sub>2</sub>SO<sub>4</sub> 

loãng

, 

nóng

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (38, 10, N'Cho 

Al

(

OH

)

<sub>3</sub> 

vào 

dung 

dịch 

HCl

.', 2, 1, 0, 2)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (39, 10, N'Cho 

CrO<sub>3</sub> 

vào 

H<sub>2</sub>O

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (40, 10, N'Cho 

Cu 

vào 

dung 

dịch 

H<sub>2</sub>SO<sub>4</sub> 

đặc

, 

nguội

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (41, 11, N'H<sub>2</sub>SO<sub>4</sub>

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (42, 11, N'HCl

.', 2, 0, 0, 2)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (43, 11, N'CuSO<sub>4</sub>

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (44, 11, N'HNO<sub>3</sub>

.', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (45, 12, N'Tơ 

visco

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (46, 12, N'Tơ 

tằm

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (47, 12, N'Tơ 

nitron

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (48, 12, N'Tơ 

nilon

&mdash;

6

,

6

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (49, 13, N'Fe<sub>2</sub>O<sub>3</sub> 

+ 

6HNO<sub>3</sub> 

→ 

2Fe

(

NO<sub>3</sub>

)

<sub>3</sub> 

+ 

3H<sub>2</sub>O', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (50, 13, N'Al

(

OH

)

<sub>3</sub>  

+ 

3HCl 

→ 

AlCl<sub>3</sub> 


+ 

3H<sub>2</sub>O', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (51, 13, N'Mg 

+ 

2HCl 

→ 

MgCl<sub>2</sub> 


+ 

H<sub>2</sub>', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (52, 13, N'2Cr 

+ 

6HCl 

→ 

2CrCl<sub>3</sub> 

+ 

3H<sub>2</sub>', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (53, 14, N'4

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (54, 14, N'6

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (55, 14, N'5

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (56, 14, N'8

.', 4, 0, 0, 2)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (57, 15, N'trắng

.', 1, 0, 0, 2)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (58, 15, N'nâu 

đỏ

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (59, 15, N'xanh 

lam

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (60, 15, N'vàng 

nhạt

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (61, 16, N'HCl

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (62, 16, N'H<sub>2</sub>SO<sub>4</sub>

.', 2, 1, 0, 2)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (63, 16, N'Na<sub>2</sub>CO<sub>3</sub>

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (64, 16, N'NaCl

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (65, 17, N'HCOOC<sub>2</sub>H<sub>5</sub>

.', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (66, 17, N'CH<sub>3</sub>COOCH<sub>3</sub>

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (67, 17, N'CH<sub>3</sub>COOC<sub>2</sub>H<sub>5</sub>

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (68, 17, N'C<sub>2</sub>H<sub>5</sub>COOC<sub>2</sub>H<sub>5</sub>

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (69, 18, N'7 

gam

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (70, 18, N'6 

gam', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (71, 18, N'6

,

5 

gam

.', 3, 0, 0, 2)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (72, 18, N'5

,

9 

gam

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (73, 19, N'Quặng 

pirit 

sắt 

có 

thành 

phần 

chính 

là 

FeCO<sub>3</sub>

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (74, 19, N'Sắt 

(

II

) 

hiđroxit 

là 

chất 

rắn

, 

màu 

trắng 

xanh

, 

không 

tan 

trong 

nước

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (75, 19, N'Sắt 

là 

kim 

loại 

màu 

trắng 

hơi 

xám

, 

dẫn 

nhiệt 

tốt

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (76, 19, N'Gang 

là 

hợp 

kim 

của 

Fe 

và 

C

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (77, 20, N'Fe<sup>2</sup>

<sup>+</sup>.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (78, 20, N'Ag

<sup>+</sup>.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (79, 20, N'Au<sup>3</sup>

<sup>+</sup>.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (80, 20, N'Cu<sup>2</sup>

<sup>+</sup>.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (81, 21, N'Na

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (82, 21, N'K

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (83, 21, N'Li

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (84, 21, N'Rb

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (85, 22, N'1', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (86, 22, N'3', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (87, 22, N'5', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (88, 22, N'4', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (89, 23, N'HCl

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (90, 23, N'HNO<sub>3</sub>

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (91, 23, N'NaOH

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (92, 23, N'Na<sub>2</sub>SO<sub>4</sub>

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (93, 24, N'36

,

20 

gam

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (94, 24, N'39

,

12 

gam

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (95, 24, N'40

,

58 

gam

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (96, 24, N'43

,

50 

gam

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (97, 25, N'16

,

8

.', 1, 0, 0, 2)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (98, 25, N'8

,

4

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (99, 25, N'5

,

6

.', 3, 0, 0, 0)
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (100, 25, N'2

,

8

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (101, 26, N'8

,

4 

gam

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (102, 26, N'12

,

6 

gam

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (103, 26, N'14

,

0 

gam

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (104, 26, N'9

,

8 

gam

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (105, 27, N'3

,

7', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (106, 27, N'4

,

7', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (107, 27, N'2

,

7', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (108, 27, N'7

,

7', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (109, 28, N'H<sub>2</sub>NC<sub>3</sub>H<sub>5</sub>

(

COOH

)

<sub>2</sub>

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (110, 28, N'H<sub>2</sub>NC<sub>2</sub>H<sub>3</sub>

(

COOH

)

<sub>2</sub>

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (111, 28, N'H<sub>2</sub>NC<sub>4</sub>H<sub>7</sub>

(

COOH

)

<sub>2</sub>

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (112, 28, N'(

H<sub>2</sub>N

)

<sub>2</sub>C<sub>3</sub>H<sub>5</sub>COOH

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (113, 29, N'240 

ml', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (114, 29, N'180 

ml', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (115, 29, N'60 

ml', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (116, 29, N'120 

ml', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (117, 30, N'31

,

25 

kg

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (118, 30, N'125

,

0 

kg

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (119, 30, N'93

,

75 

kg

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (120, 30, N'62

,

50 

kg

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (121, 31, N'amoni 

clorua

, 

lysin

, 

alanin

, 

phenylamoni 

clorua

, 

axit 

glutamic

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (122, 31, N'axit 

glutamic

, 

amoni 

clorua

, 

phenylamoni 

clorua

, 

lysin

, 

alanin

.', 2, 1, 0, 11)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (123, 31, N'amoni 

clorua

, 

phenylamoni 

clorua

, 

alanin

, 

lysin

, 

axit 

glutamic

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (124, 31, N'axit 

glutamic

, 

lysin

, 

alanin

, 

amoni 

clorua

, 

phenylamoni 

clorua

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (125, 32, N'114

,

4g', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (126, 32, N'91

,

2g', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (127, 32, N'69

,

6g', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (128, 32, N'103

,

6g', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (129, 33, N'1 

: 

1', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (130, 33, N'2 

: 

3', 2, 1, 0, 1)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (131, 33, N'2 

: 

1', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (132, 33, N'4 

: 

3', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (133, 34, N'92

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (134, 34, N'107

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (135, 34, N'102

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (136, 34, N'97

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (137, 35, N'5', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (138, 35, N'3', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (139, 35, N'4', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (140, 35, N'2', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (141, 36, N'Fe', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (142, 36, N'Cu', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (143, 36, N'AgNO<sub>3</sub>

<sub>               </sub>', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (144, 36, N'Cl<sub>2</sub>', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (145, 37, N'2

,

394

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (146, 37, N'1

,

960

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (147, 37, N'0

,

840

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (148, 37, N'2

,

240

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (149, 38, N'8', 1, 1, 0, 1)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (150, 38, N'6', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (151, 38, N'7', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (152, 38, N'5', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (153, 39, N'28

.

4

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (154, 39, N'27

.

2

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (155, 39, N'34

.

6

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (156, 39, N'32

.

8

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (157, 40, N'41

.

23

%.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (158, 40, N'38

.

84

%.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (159, 40, N'42

.

19

%.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (160, 40, N'48

.

61

%.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (161, 41, N'<img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Co Ban\2017\7\24\Images\b7706b3a-283b-4f0a-8721-bb7449f2b5d6.png">', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (162, 41, N'<img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Co Ban\2017\7\24\Images\63174619-df34-4b38-a613-1c057a220ced.png">', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (163, 41, N'<img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Co Ban\2017\7\24\Images\b4c511d0-8cce-4f42-b21a-2ada6980d54f.png">', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (164, 41, N'<img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Co Ban\2017\7\24\Images\f77edf48-b15f-4d53-8c33-6b83f2f6207c.png">', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (165, 42, N'<i>3</i>

<i>.</i>', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (166, 42, N'<i>2</i>

<i>.</i>', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (167, 42, N'<i>1</i>

<i>.</i>', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (168, 42, N'<i>0</i>

<i>.</i>', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (169, 43, N'<img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Co Ban\2017\7\24\Images\53380483-009e-476e-a7d5-ca0af7037d67.png">', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (170, 43, N'<img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Co Ban\2017\7\24\Images\f7219f85-ef14-4b0f-beff-6c41a253bf06.png">', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (171, 43, N'<img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Co Ban\2017\7\24\Images\ae7c08c6-7b36-4787-a40f-063c0b214c8f.png">', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (172, 43, N'<img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Co Ban\2017\7\24\Images\2d66b288-4f02-4bbd-96d0-8f6ce3e5bdd7.png">', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (173, 44, N'<i>3</i>

<i>.</i>', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (174, 44, N'<i>2</i>

<i>.</i>', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (175, 44, N'<i>1</i>

<i>.</i>', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (176, 44, N'<i>0</i>

<i>.</i>', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (177, 45, N'<img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Nâng Cao\2017\7\24\Images\851d79da-0ff7-4acc-b965-1b9d847956ca.png">', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (178, 45, N'<img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Nâng Cao\2017\7\24\Images\eeb7e5bb-3f05-4aba-952d-b99635b519ec.png">', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (179, 45, N'<img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Nâng Cao\2017\7\24\Images\16f5f65f-b895-41a4-bcc4-4e74f73ab048.png">', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (180, 45, N'<img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Nâng Cao\2017\7\24\Images\5fa25f21-4c3e-4263-88bc-2d81dd4072f6.png">', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (181, 46, N'Với 

<i>D</i>


là 

hình 

tròn 

<img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Nâng Cao\2017\7\24\Images\b56720c0-81e2-43a7-bf4f-dc9848037227.png"> 

ta 

có 

<img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Nâng Cao\2017\7\24\Images\4fbff0cc-b72e-470d-98e9-6b325110eaff.png">', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (182, 46, N'Với 

<i>D</i>


là 

hình 

tròn 

<img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Nâng Cao\2017\7\24\Images\d293dcde-56e8-44cd-b704-7fea2c84bb56.png"> 

ta 

có 

<img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Nâng Cao\2017\7\24\Images\63f6f2fc-8fc0-4738-8626-52bf2fc1eb8d.png">', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (183, 46, N'Với 

<i>D</i>


là 

hình 

tròn 

<img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Nâng Cao\2017\7\24\Images\15bae9b0-f813-4b76-b4d6-64c7642d2892.png"> 

ta 

có 

<img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Nâng Cao\2017\7\24\Images\681e51b1-7463-4556-94f8-5e5057ad358a.png">', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (184, 46, N'Ba 

khẳng 

định 

còn 

lại 

đều 

đúng

.', 4, 1, 1, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (185, 47, N'Với 

<i>D</i>


là 

hình 

tròn 

<img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Nâng Cao\2017\7\24\Images\6f458161-d570-4e14-a2ac-ab457617f439.png"> 

ta 

có 

<img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Nâng Cao\2017\7\24\Images\203d624c-2553-4228-9792-a0868e37a4a2.png">', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (186, 47, N'Với 

<i>D</i>


là 

hình 

tròn 

<img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Nâng Cao\2017\7\24\Images\6ca781bc-79fb-43ab-99f2-fcd81694bbfe.png"> 

ta 

có 

<img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Nâng Cao\2017\7\24\Images\61ee6ad7-168c-4d70-a919-b340ade67008.png">', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (187, 47, N'Với 

<i>D</i>


là 

hình 

tròn 

<img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Nâng Cao\2017\7\24\Images\8293893f-26d2-4164-8654-1c2b6612da33.png"> 

ta 

có 

<img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Nâng Cao\2017\7\24\Images\50c08bd4-871f-4760-b10e-84dac28c4287.png">', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (188, 47, N'Ba 

khẳng 

định 

còn 

lại 

đều 

đúng

.', 4, 1, 1, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (189, 48, N'Cty


cổ 

phần

, 

Cty


TNHH


1 

hoặc


2 

thành


viên


trở


lên', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (190, 48, N'Cty


cổ 

phần

, 

Cty


TNHH


1 

hoặc


2 

thành


viên


trở


lên

, 

Cty


hợp


danh', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (191, 48, N'Cty


cổ 

phần

, 

Cty


TNHH


1 

hoặc


2 

thành


viên


trở


lên

, 

Cty


hợp


danh

, 

Nhóm


Cty', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (192, 48, N'Cty


cổ 

phần

, 

Cty


TNHH


1 

hoặc


2 

thành


viên


trở


lên

, 

Cty


hợp


danh

, 

Nhóm


Cty


và 

các


DNTN', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (193, 49, N'Cổ 

phần


phổ


thông

, 

các


lọai


cổ 

phần


ưu 

đãi


trừ


cổ 

phần


ưu 

đãi


biểu


quyết', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (194, 49, N'Cổ 

phần


phổ


thông

, 

các


lọai


cổ 

phần


ưu 

đãi


trừ


cổ 

phần


ưu 

đãi


cổ 

tức', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (195, 49, N'Cổ 

phần


phổ


thông

, 

các


lọai


cổ 

phần


ưu 

đãi


trừ


cổ 

phần


ưu 

đãi


hòan


lại', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (196, 49, N'Tất


cả 

đều


sai', 4, 0, 1, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (197, 50, N'7 

ngày', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (198, 50, N'15 

ngày', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (199, 50, N'20 

ngày', 3, 0, 0, 0)
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (200, 50, N'30 

ngày', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (201, 51, N'1', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (202, 51, N'2', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (203, 51, N'3', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (204, 51, N'Tùy


ý', 4, 0, 1, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (205, 52, N'Cty


TNHH', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (206, 52, N'Cty


hợp


danh', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (207, 52, N'Cty


cổ 

phần', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (208, 52, N'DNTN', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (209, 53, N'Đăng


kí 

kinh


doanh', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (210, 53, N'Được


cấp


giấy


chứng


nhận


đăng


kí 

kinh


doanh', 2, 1, 0, 9)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (211, 53, N'Khi


nộp


đơn


xin


thành


lập


Cty', 3, 0, 0, 2)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (212, 53, N'a

,

b

,

c 

đều


sai', 4, 0, 1, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (213, 54, N'TVHD


phải


chịu


trách


nhiệm


bằng


tòan


bộ 

tài


sản


của


mình


về 

các


nghĩa


vụ 

của


Cty


còn


TVGV


chỉ


chịu


trác


nhiệm


bằng


số 

vốn


mình


góp


vào


Cty', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (214, 54, N'TVHD


có 

quyền


điều


hành


quản


lí 

Cty


còn


TVGV


thì


không', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (215, 54, N'TVHD


không


được


làm


chủ


DNTN


khác


hoặc


làm


TVHD


của


Cty


Hợp


danh


khác


còn


TVGV


thì


được', 3, 0, 0, 9)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (216, 54, N'<i>Cả </i>

<i>3 </i>

<i>câu </i>

<i>trên </i>

<i>đều </i>

<i>đúng </i>', 4, 1, 1, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (217, 55, N'Cty


cổ 

phần', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (218, 55, N'Cty


hợp


danh', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (219, 55, N'DNTN', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (220, 55, N'Cả 

3 

câu


đều


sai', 4, 0, 1, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (221, 56, N'Số 

vốn


tối


thiểu


theo


qui


định


pháp


luật


để 

doanh


nghiệp


họat


động


kinh


doanh', 1, 0, 0, 2)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (222, 56, N'Số 

vốn


do 

các


thành


viên


của


doanh


nghiệp


góp


vào', 2, 0, 0, 9)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (223, 56, N'Số 

vốn


do 

các


thành


viên

, 

cổ 

đông


góp


hoặc


cam


kết


góp


trong


1 

thời


hạn


nhất


định


và 

được


ghi


vào


điều


lệ 

công


ty', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (224, 56, N'b 

và 

c 

đúng', 4, 0, 1, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (225, 57, N'Nhà


nước


công


nhận


sự 

tồn


tại


lâu


dài


và 

phát


triển


của


các


loại


hình


doanh


nghiệp


được


qui


định


trong


luật


nảy

,

bảo


đảm


sự 

bình


đẳng


trước


pháp


luật


của


các


doanh


nghiệp', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (226, 57, N'Công


nhận


và 

bảo


hộ 

quyền


sở 

hữu


tài


sản

,

vốn


đầu


tư

,

quyền


lợi


ích


hợp


pháp


khác


của


DN 

và 

chủ


sở 

hữu


DN', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (227, 57, N'Tài


sản


và 

vốn


đầu


tư 

hợp


pháp


của


DN 

và 

chủ


sở 

hữu


DN 

không


bị 

quốc


hữu


hóa', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (228, 57, N'<i>Tất </i>

<i>cả </i>

<i>đều </i>

<i>đúng  </i>', 4, 1, 1, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (229, 58, N'Tự 

chủ


KD

,

chủ


động


lựa


chọn


ngành


nghề

,

địa


bàn

,

hình


thức


kinh


doanh

,

đầu


tư

,

chủ


động


mở 

rộng


qui


mô 

và 

ngành


nghề


kinh


doanh', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (230, 58, N'Lựa


chọn


hình


thức

,

phương


thức


huy


động


phân


bố 

và 

sử 

dụng


vốn', 2, 0, 0, 11)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (231, 58, N'Chủ


động


tìm


kiếm


thị


trường

,

khách


hàng


và 

kí 

kết


hợp


đồng', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (232, 58, N'Trực


tiếp


thong


qua


người


đại


diện


theo


ủy 

quyền


tham


gia


tố 

tụng


theo


qui


định


của


pháp


luật', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (233, 59, N'Tự 

chủ


quyết


định


các


công


việc


kinh


doanh', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (234, 59, N'Chiếm


hữu

,

sử 

dụng

,

định


đoạt


tài


sản


của


DN', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (235, 59, N'Bảo


đảm


quyền


và 

lợi


ích


của


người


lao


động


theo


qui


định


của


pháp


luật


về 

lao


động', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (236, 59, N'Khiếu


nại


tố 

cáo


theo


qui


định

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (237, 60, N'Sản


xuất


và 

cung


ứng


sản


phẩm

,

dịch


vụ 

không


theo


đúng


chất


lượng


và 

số 

lượng', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (238, 60, N'Không


đảm


bảo


các


điều


kiện


tốt


nhất


cho


khách


hàng', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (239, 60, N'Kê 

khai


không


trung


thực

,

không


chính


xác


nội


dung

,

hồ 

sơ 

đăng


kí 

kinh


doanh


hoặc


không


kịp


thời


với


những


thay


đổi


của


hồ 

sơ 

đăng


kí 

kinh


doanh', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (240, 60, N'Từ 

chối


mọi


yêu


cầu


cung


cấp


các


nguồn


lực


không


được


pháp


luật


qui


định', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (241, 61, N'Khi


thay


đổi


tên

,

địa


chỉ


trụ


sở 

chính

,

chi


nhánh


văn


phòng', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (242, 61, N'Thay


đổi


nội


dung


giấy


chứng


nhận


đăng


kí 

kinh


doanh', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (243, 61, N'Giấy


chứng


nhận


đăng


kí 

kinh


doanh


bị 

mất

,

rách

,

cháy


hoặc


tiêu


hủy


dưới


các


hình


thức', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (244, 61, N'b 

và 

c 

đúng', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (245, 62, N'Bảng


cam


kết


về 

việc


thực


hiện


kinh


doanh


theo


đúng


pháp


luật', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (246, 62, N'Bảng


cam


kết


của


tất


cả 

các


thành


viên


về 

việc


thành


lập


tổ 

chức

,

quản


lí 

và 

hoạt


động


của


công


ty', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (247, 62, N'Bảng


cam


kết


giữa


các


thành


viên


của


DN 

trong


việc


chia


tỉ 

lệ 

lợi


nhuận', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (248, 62, N'Bảng


cam


kết


đối


với


khách


hàng', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (249, 63, N'Thành


viên


đã 

chuyển


nhượng


hết


vốn


góp


của


mình


cho


người


khác', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (250, 63, N'Thành


viên


chết', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (251, 63, N'Khi


điều


lệ 

DN 

qui


định', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (252, 63, N'<i>Tất </i>

<i>cả </i>

<i>đều </i>

<i>đúng  </i>', 4, 1, 1, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (253, 64, N'Tối


thiểu


là 

2', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (254, 64, N'Không


giới


hạn', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (255, 64, N'Tối


thiểu


là 

2

,

tối


đa 

là 

50', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (256, 64, N'Tất


cả 

đều


sai', 4, 0, 1, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (257, 65, N'Số 

phiếu


đại


diện


ít 

nhất


65

% 

tổng


số 

vốn


góp


của


các


thành


viên


dự 

họp


chấp


thuận', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (258, 65, N'Số 

phiếu


đại


diện


ít 

nhất


50

% 

tổng


số 

vốn


điều


lệ', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (259, 65, N'Số 

phiếu


đại


diện


ít 

nhất


48

.

75

% 

tổng


số 

vốn


điều


lệ', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (260, 65, N'Cả 

a 

và 

c 

đều


đúng', 4, 0, 1, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (261, 66, N'Tăng


vốn


góp


của


thành


viên

,

tiếp


nhận


vốn


góp


của


thành


viên


mới', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (262, 66, N'Điều


chỉnh


tăng


mức


vốn


điều


lệ 

tương


ứng


với


giá


trị


tài


sản


tăng


lên


của


công


ty', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (263, 66, N'Cả 

a 

và 

b 

đều


đúng', 3, 1, 1, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (264, 66, N'Tất


cả 

đều


sai', 4, 0, 1, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (265, 67, N'Cty


TNHH', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (266, 67, N'DNTN', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (267, 67, N'Nhóm


Cty', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (268, 67, N'Cty


hợp


danh', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (269, 68, N'Cty


TNHH


1 

thành


viên', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (270, 68, N'Cty


TNHH


2 

thành


viên', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (271, 68, N'Cty


hợp


danh', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (272, 68, N'DNTN', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (273, 69, N'2 

thành


viên', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (274, 69, N'3 

thành


viên', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (275, 69, N'4 

thành


viên', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (276, 69, N'5 

thành


viên', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (277, 70, N'2 

thành


viên', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (278, 70, N'3 

thành


viên', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (279, 70, N'4 

thành


viên', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (280, 70, N'5 

thành


viên', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (281, 71, N'10

% 

tổng


số 

cổ 

phần


phổ


thông', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (282, 71, N'20

% 

tổng


số 

cổ 

phần


phổ


thông', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (283, 71, N'30

% 

tổng


số 

cổ 

phần


phổ


thông', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (284, 71, N'50

% 

tổng


số 

cổ 

phần


phổ


thông', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (285, 72, N'Cty


TNHH


1 

thành


viên', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (286, 72, N'Cty


TNHH


2 

thành


viên', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (287, 72, N'Cty


hợp


danh', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (288, 72, N'DN 

tư 

nhân', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (289, 73, N'CTy


TNHH


và 

Cty


cổ 

phần', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (290, 73, N'CTy


TNHH


và 

Cty


hợp


danh', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (291, 73, N'Cty


hợp


danh


và 

CTy


cổ 

phần', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (292, 73, N'Cty


hợp


danh


và 

nhóm


Cty', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (293, 74, N'Chủ


sở 

hửu


Cty


chỉ


định', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (294, 74, N'Hội


đồng


thành


viên


chỉ


định', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (295, 74, N'Ban


kiểm


soát


chỉ


định', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (296, 74, N'Tất


cả 

đều


đúng', 4, 0, 1, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (297, 75, N'1

/

2 

số 

thành


viên


dự 

họp


chấp


nhận', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (298, 75, N'3

/

4 

số 

thành


viên


dự 

họp


chấp


nhận', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (299, 75, N'4

/

5 

số 

thành


viên


dự 

họp


chấp


nhận', 3, 0, 0, 0)
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (300, 75, N'100

% 

số 

thành


viên


dự 

họp


chấp


nhận', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (301, 76, N'1 

à 

3 

thành


viên', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (302, 76, N'2 

à 

4 

thành


viên', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (303, 76, N'3 

à 

6 

thành


viên', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (304, 76, N'5 

à 

10 

thành


viên', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (305, 77, N'2 

à 

30 

thành


viên', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (306, 77, N'2 

à 

40 

thành


viên', 2, 0, 0, 11)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (307, 77, N'2 

à 

45 

thành


viên', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (308, 77, N'2 

à 

50 

thành


viên', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (309, 78, N'Doanh 

nghiệp 

do 

1 

cá 

nhân 

làm 

chủ', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (310, 78, N'Tự 

chịu 

trách 

nhiệm 

bằng 

toàn 

bộ 

tài 

sản 

của 

mình 

và 

mọi 

hoạt 

động 

của 

doanh 

nghiệp', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (311, 78, N'Doanh 

nghiệp 

do 

nhiều 

người 

đồng 

sở 

hữu', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (312, 78, N'A 

và 

B 

đúng', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (313, 79, N'Doanh 

nghiệp 

tư 

nhân 

là 

doanh 

nghiệp 

1 

chủ', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (314, 79, N'Doanh 

nghiệp 

tư 

nhân 

kô 

có 

tư 

cách 

pháp 

nhân', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (315, 79, N'Chủ 

doanh 

nghiệp 

tư 

nhân 

chịu 

trách 

nhiệm 

vô 

hạn 

về 

mọi 

khoản 

nợ 

phát 

sinh 

trong 

hoạt 

động 

của 

doanh 

nghiệp 

tư 

nhân', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (316, 79, N'<i>Tất
</i>

<i>cả </i>

<i>đều
</i>

<i>đúng</i>', 4, 1, 1, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (317, 80, N'Sĩ 

quan

, 

hạ 

sĩ 

quan 

trong 

các 

cơ 

quan

, 

đơn 

vị 

thuộc 

Quân 

đội 

nhân 

dân 

VN', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (318, 80, N'Cá 

nhân 

người 

nước 

ngoài', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (319, 80, N'Cán 

bộ 

lãnh 

đạo

, 

quản 

lý 

nghiệp 

vụ 

trong 

các 

DN 

100

% 

vốn 

sở 

hữu 

nhà 

nước', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (320, 80, N'Người


đang


chấp


hành


hình


phạt


tù', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (321, 81, N'Phải 

có 

logo 

của 

doanh 

nghiệp', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (322, 81, N'Tên 

doanh 

nghiệp 

tư 

nhân 

phải 

viết 

được 

bằng 

tiếng 

Việt', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (323, 81, N'Kô 

được 

đặt 

tên 

gây 

nhầm 

lẫn 

với 

tên 

của 

doanh 

nghiệp 

đã 

đăng 

ký', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (324, 81, N'Tên


tiếng


nước


ngoài


của


doanh


nghiệp


phải


được


in 

hoặc


viết


với


khổ


chữ


nhỏ


hơn


tên


tiếng


Việt


của


doanh


nghiệp


trên


các


giấy


tờ 

giao


dịch', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (325, 82, N'Trong 

1 

số', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (326, 82, N'Trong 

2 

số 

liên 

tiếp', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (327, 82, N'Trong 

3 

số 

liên 

tiếp', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (328, 82, N'Tất


cả 

đều


sai', 4, 0, 1, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (329, 83, N'Do 

một


cá 

nhân


là 

công


dân


VN

, 

1 

nhóm


người

, 

1 

hộ 

gia


đình


làm


chủ', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (330, 83, N'Không


có 

con


dấu', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (331, 83, N'Sử 

dụng


không


quá


mười


lao


động', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (332, 83, N'Tất


cả 

những


đặc


điểm


trên', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (333, 84, N'Chủ


hộ 

kinh


doanh


chịu


trách


nhiệm


hữu


hạn


trong


hoạt


động


kinh


doanh', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (334, 84, N'Hộ 

kinh


doanh


có 

sử 

dụng


thường


xuyên


hơn


mười


lao


động


phải


đăng


ký 

kinh


doanh


dưới


hình


thức


doanh


nghiệp', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (335, 84, N'Hộ 

kinh


doanh


thường


tồn


tại


với


quy


mô 

nhỏ', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (336, 84, N'Tất


cả 

các


phát


biểu


trên', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (337, 85, N'Người


chưa


thành


niên', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (338, 85, N'Người


đang


chấp


hành


hình


phạt


tù', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (339, 85, N'Người


bị 

tước


quyền


hành


nghề', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (340, 85, N'Tất


cả 

những


người


trên', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (341, 86, N'3 

ngày', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (342, 86, N'5 

ngày', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (343, 86, N'7 

ngày', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (344, 86, N'10 

ngày', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (345, 87, N'Tuần


thứ


1 

hằng


tháng', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (346, 87, N'Tuần


thú


2 

hằng


tháng', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (347, 87, N'Tuần


thứ


3 

hằng


tháng', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (348, 87, N'Tuần


thứ


4 

hằng


tháng', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (349, 88, N'nước 

ta 

nằm 

ở 

vị 

trí 

tiếp 

giáp 

giữa 

lục 

địa 

và 

đại 

dương

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (350, 88, N'nước 

ta 

nằm 

kề 

liền 

với 

hai 

vành 

đai 

sinh 

khoáng


Địa 

Trung 

Hải 

và 

Thái 

Bình 

Dương

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (351, 88, N'nước 

ta 

nằm 

gần 

trung 

tâm 

Đông 

Nam 

Á

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (352, 88, N'nước 

ta 

nằm 

phía 

Đông 

bán 

đảo 

Đông 

Dương

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (353, 89, N'nằm 

ở 

trung 

tâm 

Đông 

Nam 

Á

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (354, 89, N'nằm 

trên 

tuyến 

đường 

hàng 

hải 

quốc 

tế

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (355, 89, N'cầu 

nối 

giữa 

châu 

Á 

và 

châu 

Đại 

Dương

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (356, 89, N'cửa 

ngõ 

ra 

vào 

khu 

vực 

Đông 

Dương

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (357, 90, N'hình 

dạng 

lãnh 

thổ

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (358, 90, N'nước 

ta 

nằm 

gần 

trung 

tâm 

Đông 

Nam 

Á

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (359, 90, N'nước 

ta 

nằm 

trong 

khu 

vực 

nhiệt 

đới 

gió 

mùa

.', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (360, 90, N'nước 

ta 

nằm 

phía 

Đông 

bán 

đảo 

Đông 

Dương

.          

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (361, 91, N'có 

mạng 

lưới 

kênh 

rạch 

chằng 

chịt

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (362, 91, N'địa 

hình 

thấp

, 

bằng 

phẳng

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (363, 91, N'<b><i>có </i></b>

<b><i>nhiều </i></b>

<b><i>vùng </i></b>

<b><i>trũng </i></b>

<b><i>rộng </i></b>

<b><i>lớn</i></b>

<b><i>.</i></b>

<b><i>            </i></b>

<b><i>            </i></b>

<b><i>            </i></b>', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (364, 91, N'<b><i>biển </i></b>

<b><i>bao </i></b>

<b><i>bọc </i></b>

<b><i>ba </i></b>

<b><i>mặt </i></b>

<b><i>đồng </i></b>

<b><i>bằng</i></b>

<b><i>.</i></b>', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (365, 92, N'có&nbsp;

nhiệt&nbsp;

độ&nbsp;

cao

,&nbsp;

nhiều&nbsp;

nắng

,&nbsp;

chỉ&nbsp;

có&nbsp;

vài&nbsp;

sông&nbsp;

nhỏ&nbsp;

đổ&nbsp;

ra&nbsp;

biển

.', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (366, 92, N'không&nbsp;

có&nbsp;

bão&nbsp;

lại&nbsp;

ít&nbsp;

chịu&nbsp;

ảnh&nbsp;

hưởng&nbsp;

của&nbsp;

gió&nbsp;

mùa&nbsp;

đông&nbsp;

bắc

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (367, 92, N'có&nbsp;

những&nbsp;

hệ&nbsp;

núi&nbsp;

cao&nbsp;

ăn&nbsp;

lan&nbsp;

ra&nbsp;

tận&nbsp;

biển&nbsp;

nên&nbsp;

bờ&nbsp;

biển&nbsp;

khúc&nbsp;

khuỷu

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (368, 92, N'có&nbsp;

thềm&nbsp;

lục&nbsp;

địa&nbsp;

thoai&nbsp;

thoải&nbsp;

kéo&nbsp;

dài&nbsp;

sang&nbsp;

tận&nbsp;

Ma

-

lai

-

xi

-

a

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (369, 93, N'địa 

hình', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (370, 93, N'khí 

hậu', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (371, 93, N'đất 

đai', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (372, 93, N'sinh 

vật', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (373, 94, N'tính 

chất 

nhiệt 

đới 

tăng 

dần 

theo 

hướng 

nam

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (374, 94, N'gió 

mùa 

Đông 

Bắc 

hoạt 

động 

mạnh 

tạo 

nên 

mùa 

đông 

lạnh

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (375, 94, N'có 

một 

mùa 

khô 

và 

mùa 

mưa 

rõ 

rệt

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (376, 94, N'gió 

phơn 

tây 

nam 

hoạt 

động 

rất 

mạnh

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (377, 95, N'công 

tác 

kế 

hoạch 

hóa 

gia 

đình

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (378, 95, N'việc 

giáo 

dục 

dân 

số

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (379, 95, N'pháp 

lệnh 

dân 

số

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (380, 95, N'chính 

sách 

dân 

số 

và 

kế 

hoạch 

hóa 

gia 

đình

.', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (381, 96, N'Đội 

ngũ 

lao 

động 

có 

chuyên


môn 

kĩ 

thuật 

ngày 

càng 

đông 

đảo

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (382, 96, N'Người 

lao 

động 

còn 

thiếu 

tác 

phong 

công 

nghiệp

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (383, 96, N'Lực 

lượng 

lao 

động 

có 

chuyên


môn 

kĩ 

thuật 

phân 

bố 

tương 

đối 

đồng 

đều

.', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (384, 96, N'Nguồn 

lao 

động 

dồi 

dào

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (385, 97, N'Dân 

cư 

nước 

ta 

phân 

bố 

đồng 

đều 

giữa 

đồng 

bằng 

với 

trung 

du 

và 

miền 

núi

.', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (386, 97, N'Tây 

Nguyên


là 

vùng 

có 

mật 

độ 

dân 

số 

thấp 

nhất 

nước 

ta 

hiện 

nay

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (387, 97, N'Dân 

cư 

chủ 

yếu 

tập 

trung 

ở 

khu 

vực 

nông 

thôn

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (388, 97, N'Tỉ 

lệ 

dân 

cư 

thành 

thị 

nước 

ta 

ngày 

càng 

tăng

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (389, 98, N'Sự 

đa 

dạng 

về 

cơ 

cấu 

mùa 

vụ

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (390, 98, N'Sự 

đa 

dạng 

về 

cơ 

cấu 

cây 

trồng

, 

vật 

nuôi

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (391, 98, N'Tính 

bấp 

bênh

, 

không 

ổn 

định 

của 

một 

số 

sản 

phẩm 

nông 

nghiệp

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (392, 98, N'Năng 

suất 

và 

sản 

lượng 

luôn 

tăng 

trưởng


ổn 

định

.', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (393, 99, N'Ngư 

trường


Cà 

Mau

-

Kiên 

Giang

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (394, 99, N'Ngư 

trường


Ninh 

Thuận

-

Bình 

Thuận

-

Bà 

Rịa

-

Vũng 

Tàu

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (395, 99, N'Ngư 

trường


Quảng 

Ninh

-

Hải 

Phòng

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (396, 99, N'Ngư 

trường


Hoàng 

Sa

-

Trường


Sa

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (397, 100, N'Có 

thế 

mạnh 

lâu 

dài

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (398, 100, N'Gắn 

với 

nguồn 

vốn 

đầu 

tư 

nước 

ngoài

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (399, 100, N'Mang 

lại 

hiệu 

quả 

kinh 

tế 

cao

.', 3, 0, 0, 0)
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (400, 100, N'Tác 

động 

đến 

các 

ngành 

kinh 

tế 

khác

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (401, 101, N'cây 

lương 

thực

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (402, 101, N'cây 

rau 

đậu

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (403, 101, N'cây 

công 

nghiệp

.', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (404, 101, N'cây 

ăn 

quả

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (405, 102, N'Đồng 

bằng 

duyên 

hải 

miền 

Trung

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (406, 102, N'Đồng 

bằng 

sông 

Hồng

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (407, 102, N'Đồng 

bằng 

sông 

Cửu 

Long

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (408, 102, N'các 

đồng 

bằng 

giữa 

núi 

và 

ở 

trung 

du

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (409, 103, N'Đẩy 

mạnh 

hoạt 

động 

vận 

tải

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (410, 103, N'Tăng 

cường 

sản 

xuất 

chuyên


môn 

hóa

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (411, 103, N'Áp 

dụng 

rộng 

rãi 

công 

nghiệp


chế 

biến

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (412, 103, N'Sử 

dụng 

ngày 

càng 

nhiều 

công 

nghệ 

bảo 

quản 

nông 

sản

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (413, 104, N'nhu 

cầu 

của 

thị 

trường


thế 

giới 

ngày 

càng 

lớn

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (414, 104, N'có 

nhiều 

sông 

ngòi

, 

kênh 

rạch

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (415, 104, N'bờ 

biển 

dài

, 

vùng 

đặc 

quyền 

kinh 

tế 

rộng

.', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (416, 104, N'nhân 

dân 

có 

nhiều 

kinh 

nghiệm


đánh 

bắt

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (417, 105, N'dải 

công 

nghiệp


từ 

thành


phố 

Hồ 

Chí 

Minh 

đến 

Bà 

Rịa 

&mdash; 

Vũng 

Tàu

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (418, 105, N'đồng 

bằng 

sông 

Hồng 

và 

vùng 

phụ 

cận

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (419, 105, N'dọc 

theo 

duyên 

hải 

miền 

Trung

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (420, 105, N'khu 

Đông 

Bắc 

Bắc 

Bộ

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (421, 106, N'Bắc 

Trung 

Bộ

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (422, 106, N'Tây 

Nguyên

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (423, 106, N'Đông 

Nam 

Bộ

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (424, 106, N'Trung 

du 

và 

miền 

núi 

Bắc 

Bộ

.', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (425, 107, N'Hình 

thành 

từ 

những 

năm 

60 

của 

thế 

kỉ 

XX

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (426, 107, N'Phát 

triển 

nhanh 

từ 

đầu 

thập 

kỉ 

90 

của 

thế 

kỉ 

XX 

đến 

nay

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (427, 107, N'Số 

lượng 

khách 

nội 

địa 

ít 

hơn 

khách 

quốc 

tế

.', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (428, 107, N'Cơ 

sở 

lưu 

trú

, 

nghỉ 

dưỡng 

ngày 

càng 

phát 

triển

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (429, 108, N'đất 

xám 

bạc 

màu 

trên 

phù 

sa 

cổ 

chiếm 

diện 

tích 

lớn

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (430, 108, N'tài 

nguyên


lâm 

nghiệp


không 

thật 

lớn

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (431, 108, N'tài 

nguyên


khoáng


sản 

chỉ 

có 

dầu 

khí 

ở 

thềm 

lục 

địa

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (432, 108, N'mùa 

khô 

kéo 

dài

, 

có 

khi 

tới 

4 

&mdash; 

5 

tháng

.', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (433, 109, N'đội 

ngũ 

lao 

động 

lành 

nghề

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (434, 109, N'các 

cơ 

sở 

năng 

lượng

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (435, 109, N'hệ 

thống 

giao 

thông 

vận 

tải

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (436, 109, N'vốn 

đầu 

tư 

nước 

ngoài

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (437, 110, N'bảo 

vệ 

môi 

trường

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (438, 110, N'mở 

rộng 

quan 

hệ 

với 

các 

vùng 

trong 

nước

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (439, 110, N'đẩy 

mạnh 

phát 

triển 

các 

ngành 

giao 

thông 

vận 

tải

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (440, 110, N'thu 

hút 

vốn 

đầu 

tư 

nước 

ngoài

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (441, 111, N'Rét 

đậm

, 

rét 

hại

, 

sương 

muối

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (442, 111, N'Khí 

hậu 

có 

mùa 

đông 

lạnh

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (443, 111, N'Tình 

trạng 

thiếu 

nước 

về 

mùa 

đông

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (444, 111, N'Mạng 

lưới 

cơ 

sở 

chế 

biến 

nông 

sản 

còn 

hạn 

chế

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (445, 112, N'người 

dân 

có 

kinh 

nghiệm


trồng 

trọt

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (446, 112, N'vùng 

có 

đất 

phù 

sa 

cổ

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (447, 112, N'nơi 

đây 

có 

mùa 

đông 

lạnh 

nhất 

nước 

ta

.', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (448, 112, N'vùng 

có 

vị 

trí 

ở 

phía 

Bắc 

nước 

ta

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (449, 113, N'rừng 

sản 

xuất

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (450, 113, N'rừng 

phòng 

hộ

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (451, 113, N'rừng 

đặc 

dụng

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (452, 113, N'rừng 

tự 

nhiên

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (453, 114, N'thiếu 

tài 

nguyên


khoáng


sản 

và 

các 

nguồn 

nguyên


liệu 

khác

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (454, 114, N'thiếu 

nguồn 

lao 

động

, 

đặc 

biệt 

là 

lao 

động 

có 

tay 

nghề

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (455, 114, N'những 

hạn 

chế 

về 

điều 

kiện 

kĩ 

thuật

, 

vốn

.', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (456, 114, N'thiếu 

cơ 

sở 

năng 

lượng 

tại 

chỗ

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (457, 115, N'đất 

badan 

màu 

mỡ

, 

tầng 

phong 

hóa 

sâu

, 

phân 

bố 

thành 

mặt 

bằng 

rộng 

lớn

.', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (458, 115, N'có 

đội 

ngũ 

lao 

động 

đông 

đảo

, 

trình 

độ 

chuyên


môn 

cao', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (459, 115, N'giao 

thông 

thuận 

lợi

, 

có 

nhiều 

tuyến 

đường 

đang 

được 

nâng 

cấp

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (460, 115, N'nhu 

cầu 

thị 

trường


trong 

và 

ngoài 

nước 

tăng 

mạnh

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (461, 116, N'Tài 

nguyên


thiên 

nhiên 

rất 

phong 

phú 

đa 

dạng

.', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (462, 116, N'Có 

nhiều 

thiên 

tai 

(

bão

, 

lũ 

lụt

, 

hạn 

hán

...).', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (463, 116, N'Có 

một 

số 

tài 

nguyên


thiên 

nhiên 

(

đất

, 

nước 

trên 

mặt

...) 

bị 

xuống 

cấp

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (464, 116, N'Là 

vùng 

thiếu 

nguyên


liệu 

cho 

việc 

phát 

triển 

công 

nghiệp

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (465, 117, N'Dãy 

Hoàng 

Liên 

Sơn

.', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (466, 117, N'Dãy 

Trường


Sơn 

Nam

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (467, 117, N'Dãy 

Bạch 

Mã

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (468, 117, N'Dãy 

Đông 

Triều

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (469, 118, N'Thành


phố 

Hồ 

Chí 

Minh

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (470, 118, N'Hải 

Phòng

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (471, 118, N'Hà 

Nội

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (472, 118, N'Cần 

Thơ

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (473, 119, N'Phú 

Yên

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (474, 119, N'Đà 

Nẵng

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (475, 119, N'Ninh 

Thuận

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (476, 119, N'Bình 

Thuận

.', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (477, 120, N'Phả 

Lại

.', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (478, 120, N'Na 

Dương

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (479, 120, N'Uông 

Bí

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (480, 120, N'Ninh 

Bình

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (481, 121, N'Năng 

suất 

lúa 

tăng 

khá 

nhanh 

nhưng 

tăng 

không 

liên 

tục

.', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (482, 121, N'Năng 

suất 

lúa 

tăng 

khá 

nhanh 

và 

tăng 

liên 

tục

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (483, 121, N'Diện 

tích 

lúa 

tăng 

liên 

tục

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (484, 121, N'Diện 

tích 

lúa 

và 

năng 

suất 

lúa 

đều 

tăng 

liên 

tục

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (485, 122, N'Tỉ 

trọng 

khu 

vực 

kinh 

tế 

nhà 

nước 

tăng

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (486, 122, N'Tỉ 

trọng 

khu 

vực 

kinh 

tế 

ngoài 

nhà 

nước 

luôn 

nhỏ 

nhất

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (487, 122, N'Tỉ 

trọng 

khu 

vực 

kinh 

tế 

có 

vốn 

đầu 

tư 

nước 

ngoài 

tăng

.', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (488, 122, N'Tỉ 

trọng 

khu 

vực 

kinh 

tế 

có 

vốn 

đầu 

tư 

nước 

ngoài 

luôn 

lớn 

nhất

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (489, 123, N'Tỉ 

lệ 

dân 

thành 

thị 

thấp

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (490, 123, N'Tốc 

độ 

tăng 

tỉ 

lệ 

dân 

thành 

thị 

nhanh

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (491, 123, N'Tốc 

độ 

tăng 

tỉ 

lệ 

dân 

thành 

thị 

chậm

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (492, 123, N'Tỉ 

lệ 

dân 

thành 

thị 

tăng 

liên 

tục

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (493, 124, N'Đồng 

bằng 

sông 

Hồng', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (494, 124, N'Đông 

Nam 

Bộ', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (495, 124, N'Đồng 

bằng 

sông 

Cửu 

Long', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (496, 124, N'Tây 

Nguyên', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (497, 125, N'Biểu 

đồ 

tròn', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (498, 125, N'Biểu 

đồ 

đường', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (499, 125, N'Biểu 

đồ 

miền', 3, 0, 0, 0)
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (500, 125, N'Biểu 

đồ 

cột', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (501, 126, N'Thu 

nhập 

bình 

quân 

đầu 

người 

của 

Đông 

Nam 

Bộ 

và 

Tây 

Nguyên


đều 

có 

xu 

hướng 

tăng

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (502, 126, N'Thu 

nhập 

của 

Đông 

Nam 

Bộ 

luôn 

cao 

hơn 

Tây 

Nguyên

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (503, 126, N'Thu 

nhập 

bình 

quân 

đầu 

người 

của 

Đông 

Nam 

Bộ 

tăng 

liên 

tục

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (504, 126, N'Thu 

nhập 

bình 

quân 

đầu 

người 

của 

Tây 

Nguyên


tăng 

liên 

tục

.', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (505, 127, N'nước 

ta 

nằm 

ở 

vị 

trí 

tiếp 

giáp 

giữa 

lục 

địa 

và 

đại 

dương

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (506, 127, N'nước 

ta 

nằm 

kề 

liền 

với 

hai 

vành 

đai 

sinh 

khoáng


Địa 

Trung 

Hải 

và 

Thái 

Bình 

Dương

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (507, 127, N'nước 

ta 

nằm 

gần 

trung 

tâm 

Đông 

Nam 

Á

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (508, 127, N'nước 

ta 

nằm 

phía 

Đông 

bán 

đảo 

Đông 

Dương

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (509, 128, N'nằm 

ở 

trung 

tâm 

Đông 

Nam 

Á

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (510, 128, N'nằm 

trên 

tuyến 

đường 

hàng 

hải 

quốc 

tế

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (511, 128, N'cầu 

nối 

giữa 

châu 

Á 

và 

châu 

Đại 

Dương

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (512, 128, N'cửa 

ngõ 

ra 

vào 

khu 

vực 

Đông 

Dương

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (513, 129, N'hình 

dạng 

lãnh 

thổ

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (514, 129, N'nước 

ta 

nằm 

gần 

trung 

tâm 

Đông 

Nam 

Á

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (515, 129, N'nước 

ta 

nằm 

trong 

khu 

vực 

nhiệt 

đới 

gió 

mùa

.', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (516, 129, N'nước 

ta 

nằm 

phía 

Đông 

bán 

đảo 

Đông 

Dương

.          

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (517, 130, N'có 

mạng 

lưới 

kênh 

rạch 

chằng 

chịt

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (518, 130, N'địa 

hình 

thấp

, 

bằng 

phẳng

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (519, 130, N'<b><i>có </i></b>

<b><i>nhiều </i></b>

<b><i>vùng </i></b>

<b><i>trũng </i></b>

<b><i>rộng </i></b>

<b><i>lớn</i></b>

<b><i>.</i></b>

<b><i>            </i></b>

<b><i>            </i></b>

<b><i>            </i></b>', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (520, 130, N'<b><i>biển </i></b>

<b><i>bao </i></b>

<b><i>bọc </i></b>

<b><i>ba </i></b>

<b><i>mặt </i></b>

<b><i>đồng </i></b>

<b><i>bằng</i></b>

<b><i>.</i></b>', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (521, 131, N'có&nbsp;

nhiệt&nbsp;

độ&nbsp;

cao

,&nbsp;

nhiều&nbsp;

nắng

,&nbsp;

chỉ&nbsp;

có&nbsp;

vài&nbsp;

sông&nbsp;

nhỏ&nbsp;

đổ&nbsp;

ra&nbsp;

biển

.', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (522, 131, N'không&nbsp;

có&nbsp;

bão&nbsp;

lại&nbsp;

ít&nbsp;

chịu&nbsp;

ảnh&nbsp;

hưởng&nbsp;

của&nbsp;

gió&nbsp;

mùa&nbsp;

đông&nbsp;

bắc

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (523, 131, N'có&nbsp;

những&nbsp;

hệ&nbsp;

núi&nbsp;

cao&nbsp;

ăn&nbsp;

lan&nbsp;

ra&nbsp;

tận&nbsp;

biển&nbsp;

nên&nbsp;

bờ&nbsp;

biển&nbsp;

khúc&nbsp;

khuỷu

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (524, 131, N'có&nbsp;

thềm&nbsp;

lục&nbsp;

địa&nbsp;

thoai&nbsp;

thoải&nbsp;

kéo&nbsp;

dài&nbsp;

sang&nbsp;

tận&nbsp;

Ma

-

lai

-

xi

-

a

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (525, 132, N'địa 

hình', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (526, 132, N'khí 

hậu', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (527, 132, N'đất 

đai', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (528, 132, N'sinh 

vật', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (529, 133, N'tính 

chất 

nhiệt 

đới 

tăng 

dần 

theo 

hướng 

nam

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (530, 133, N'gió 

mùa 

Đông 

Bắc 

hoạt 

động 

mạnh 

tạo 

nên 

mùa 

đông 

lạnh

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (531, 133, N'có 

một 

mùa 

khô 

và 

mùa 

mưa 

rõ 

rệt

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (532, 133, N'gió 

phơn 

tây 

nam 

hoạt 

động 

rất 

mạnh

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (533, 134, N'công 

tác 

kế 

hoạch 

hóa 

gia 

đình

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (534, 134, N'việc 

giáo 

dục 

dân 

số

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (535, 134, N'pháp 

lệnh 

dân 

số

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (536, 134, N'chính 

sách 

dân 

số 

và 

kế 

hoạch 

hóa 

gia 

đình

.', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (537, 135, N'Đội 

ngũ 

lao 

động 

có 

chuyên


môn 

kĩ 

thuật 

ngày 

càng 

đông 

đảo

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (538, 135, N'Người 

lao 

động 

còn 

thiếu 

tác 

phong 

công 

nghiệp

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (539, 135, N'Lực 

lượng 

lao 

động 

có 

chuyên


môn 

kĩ 

thuật 

phân 

bố 

tương 

đối 

đồng 

đều

.', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (540, 135, N'Nguồn 

lao 

động 

dồi 

dào

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (541, 136, N'Dân 

cư 

nước 

ta 

phân 

bố 

đồng 

đều 

giữa 

đồng 

bằng 

với 

trung 

du 

và 

miền 

núi

.', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (542, 136, N'Tây 

Nguyên


là 

vùng 

có 

mật 

độ 

dân 

số 

thấp 

nhất 

nước 

ta 

hiện 

nay

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (543, 136, N'Dân 

cư 

chủ 

yếu 

tập 

trung 

ở 

khu 

vực 

nông 

thôn

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (544, 136, N'Tỉ 

lệ 

dân 

cư 

thành 

thị 

nước 

ta 

ngày 

càng 

tăng

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (545, 137, N'Sự 

đa 

dạng 

về 

cơ 

cấu 

mùa 

vụ

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (546, 137, N'Sự 

đa 

dạng 

về 

cơ 

cấu 

cây 

trồng

, 

vật 

nuôi

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (547, 137, N'Tính 

bấp 

bênh

, 

không 

ổn 

định 

của 

một 

số 

sản 

phẩm 

nông 

nghiệp

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (548, 137, N'Năng 

suất 

và 

sản 

lượng 

luôn 

tăng 

trưởng


ổn 

định

.', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (549, 138, N'Ngư 

trường


Cà 

Mau

-

Kiên 

Giang

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (550, 138, N'Ngư 

trường


Ninh 

Thuận

-

Bình 

Thuận

-

Bà 

Rịa

-

Vũng 

Tàu

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (551, 138, N'Ngư 

trường


Quảng 

Ninh

-

Hải 

Phòng

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (552, 138, N'Ngư 

trường


Hoàng 

Sa

-

Trường


Sa

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (553, 139, N'Có 

thế 

mạnh 

lâu 

dài

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (554, 139, N'Gắn 

với 

nguồn 

vốn 

đầu 

tư 

nước 

ngoài

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (555, 139, N'Mang 

lại 

hiệu 

quả 

kinh 

tế 

cao

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (556, 139, N'Tác 

động 

đến 

các 

ngành 

kinh 

tế 

khác

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (557, 140, N'cây 

lương 

thực

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (558, 140, N'cây 

rau 

đậu

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (559, 140, N'cây 

công 

nghiệp

.', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (560, 140, N'cây 

ăn 

quả

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (561, 141, N'Đồng 

bằng 

duyên 

hải 

miền 

Trung

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (562, 141, N'Đồng 

bằng 

sông 

Hồng

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (563, 141, N'Đồng 

bằng 

sông 

Cửu 

Long

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (564, 141, N'các 

đồng 

bằng 

giữa 

núi 

và 

ở 

trung 

du

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (565, 142, N'Đẩy 

mạnh 

hoạt 

động 

vận 

tải

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (566, 142, N'Tăng 

cường 

sản 

xuất 

chuyên


môn 

hóa

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (567, 142, N'Áp 

dụng 

rộng 

rãi 

công 

nghiệp


chế 

biến

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (568, 142, N'Sử 

dụng 

ngày 

càng 

nhiều 

công 

nghệ 

bảo 

quản 

nông 

sản

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (569, 143, N'nhu 

cầu 

của 

thị 

trường


thế 

giới 

ngày 

càng 

lớn

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (570, 143, N'có 

nhiều 

sông 

ngòi

, 

kênh 

rạch

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (571, 143, N'bờ 

biển 

dài

, 

vùng 

đặc 

quyền 

kinh 

tế 

rộng

.', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (572, 143, N'nhân 

dân 

có 

nhiều 

kinh 

nghiệm


đánh 

bắt

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (573, 144, N'dải 

công 

nghiệp


từ 

thành


phố 

Hồ 

Chí 

Minh 

đến 

Bà 

Rịa 

&mdash; 

Vũng 

Tàu

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (574, 144, N'đồng 

bằng 

sông 

Hồng 

và 

vùng 

phụ 

cận

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (575, 144, N'dọc 

theo 

duyên 

hải 

miền 

Trung

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (576, 144, N'khu 

Đông 

Bắc 

Bắc 

Bộ

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (577, 145, N'Bắc 

Trung 

Bộ

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (578, 145, N'Tây 

Nguyên

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (579, 145, N'Đông 

Nam 

Bộ

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (580, 145, N'Trung 

du 

và 

miền 

núi 

Bắc 

Bộ

.', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (581, 146, N'Hình 

thành 

từ 

những 

năm 

60 

của 

thế 

kỉ 

XX

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (582, 146, N'Phát 

triển 

nhanh 

từ 

đầu 

thập 

kỉ 

90 

của 

thế 

kỉ 

XX 

đến 

nay

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (583, 146, N'Số 

lượng 

khách 

nội 

địa 

ít 

hơn 

khách 

quốc 

tế

.', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (584, 146, N'Cơ 

sở 

lưu 

trú

, 

nghỉ 

dưỡng 

ngày 

càng 

phát 

triển

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (585, 147, N'đất 

xám 

bạc 

màu 

trên 

phù 

sa 

cổ 

chiếm 

diện 

tích 

lớn

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (586, 147, N'tài 

nguyên


lâm 

nghiệp


không 

thật 

lớn

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (587, 147, N'tài 

nguyên


khoáng


sản 

chỉ 

có 

dầu 

khí 

ở 

thềm 

lục 

địa

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (588, 147, N'mùa 

khô 

kéo 

dài

, 

có 

khi 

tới 

4 

&mdash; 

5 

tháng

.', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (589, 148, N'đội 

ngũ 

lao 

động 

lành 

nghề

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (590, 148, N'các 

cơ 

sở 

năng 

lượng

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (591, 148, N'hệ 

thống 

giao 

thông 

vận 

tải

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (592, 148, N'vốn 

đầu 

tư 

nước 

ngoài

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (593, 149, N'bảo 

vệ 

môi 

trường

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (594, 149, N'mở 

rộng 

quan 

hệ 

với 

các 

vùng 

trong 

nước

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (595, 149, N'đẩy 

mạnh 

phát 

triển 

các 

ngành 

giao 

thông 

vận 

tải

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (596, 149, N'thu 

hút 

vốn 

đầu 

tư 

nước 

ngoài

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (597, 150, N'Rét 

đậm

, 

rét 

hại

, 

sương 

muối

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (598, 150, N'Khí 

hậu 

có 

mùa 

đông 

lạnh

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (599, 150, N'Tình 

trạng 

thiếu 

nước 

về 

mùa 

đông

.', 3, 0, 0, 0)
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (600, 150, N'Mạng 

lưới 

cơ 

sở 

chế 

biến 

nông 

sản 

còn 

hạn 

chế

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (601, 151, N'người 

dân 

có 

kinh 

nghiệm


trồng 

trọt

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (602, 151, N'vùng 

có 

đất 

phù 

sa 

cổ

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (603, 151, N'nơi 

đây 

có 

mùa 

đông 

lạnh 

nhất 

nước 

ta

.', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (604, 151, N'vùng 

có 

vị 

trí 

ở 

phía 

Bắc 

nước 

ta

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (605, 152, N'rừng 

sản 

xuất

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (606, 152, N'rừng 

phòng 

hộ

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (607, 152, N'rừng 

đặc 

dụng

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (608, 152, N'rừng 

tự 

nhiên

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (609, 153, N'thiếu 

tài 

nguyên


khoáng


sản 

và 

các 

nguồn 

nguyên


liệu 

khác

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (610, 153, N'thiếu 

nguồn 

lao 

động

, 

đặc 

biệt 

là 

lao 

động 

có 

tay 

nghề

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (611, 153, N'những 

hạn 

chế 

về 

điều 

kiện 

kĩ 

thuật

, 

vốn

.', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (612, 153, N'thiếu 

cơ 

sở 

năng 

lượng 

tại 

chỗ

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (613, 154, N'đất 

badan 

màu 

mỡ

, 

tầng 

phong 

hóa 

sâu

, 

phân 

bố 

thành 

mặt 

bằng 

rộng 

lớn

.', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (614, 154, N'có 

đội 

ngũ 

lao 

động 

đông 

đảo

, 

trình 

độ 

chuyên


môn 

cao', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (615, 154, N'giao 

thông 

thuận 

lợi

, 

có 

nhiều 

tuyến 

đường 

đang 

được 

nâng 

cấp

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (616, 154, N'nhu 

cầu 

thị 

trường


trong 

và 

ngoài 

nước 

tăng 

mạnh

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (617, 155, N'Tài 

nguyên


thiên 

nhiên 

rất 

phong 

phú 

đa 

dạng

.', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (618, 155, N'Có 

nhiều 

thiên 

tai 

(

bão

, 

lũ 

lụt

, 

hạn 

hán

...).', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (619, 155, N'Có 

một 

số 

tài 

nguyên


thiên 

nhiên 

(

đất

, 

nước 

trên 

mặt

...) 

bị 

xuống 

cấp

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (620, 155, N'Là 

vùng 

thiếu 

nguyên


liệu 

cho 

việc 

phát 

triển 

công 

nghiệp

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (621, 156, N'Dãy 

Hoàng 

Liên 

Sơn

.', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (622, 156, N'Dãy 

Trường


Sơn 

Nam

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (623, 156, N'Dãy 

Bạch 

Mã

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (624, 156, N'Dãy 

Đông 

Triều

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (625, 157, N'Thành


phố 

Hồ 

Chí 

Minh

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (626, 157, N'Hải 

Phòng

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (627, 157, N'Hà 

Nội

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (628, 157, N'Cần 

Thơ

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (629, 158, N'Phú 

Yên

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (630, 158, N'Đà 

Nẵng

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (631, 158, N'Ninh 

Thuận

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (632, 158, N'Bình 

Thuận

.', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (633, 159, N'Phả 

Lại

.', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (634, 159, N'Na 

Dương

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (635, 159, N'Uông 

Bí

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (636, 159, N'Ninh 

Bình

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (637, 160, N'Năng 

suất 

lúa 

tăng 

khá 

nhanh 

nhưng 

tăng 

không 

liên 

tục

.', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (638, 160, N'Năng 

suất 

lúa 

tăng 

khá 

nhanh 

và 

tăng 

liên 

tục

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (639, 160, N'Diện 

tích 

lúa 

tăng 

liên 

tục

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (640, 160, N'Diện 

tích 

lúa 

và 

năng 

suất 

lúa 

đều 

tăng 

liên 

tục

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (641, 161, N'Tỉ 

trọng 

khu 

vực 

kinh 

tế 

nhà 

nước 

tăng

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (642, 161, N'Tỉ 

trọng 

khu 

vực 

kinh 

tế 

ngoài 

nhà 

nước 

luôn 

nhỏ 

nhất

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (643, 161, N'Tỉ 

trọng 

khu 

vực 

kinh 

tế 

có 

vốn 

đầu 

tư 

nước 

ngoài 

tăng

.', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (644, 161, N'Tỉ 

trọng 

khu 

vực 

kinh 

tế 

có 

vốn 

đầu 

tư 

nước 

ngoài 

luôn 

lớn 

nhất

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (645, 162, N'Tỉ 

lệ 

dân 

thành 

thị 

thấp

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (646, 162, N'Tốc 

độ 

tăng 

tỉ 

lệ 

dân 

thành 

thị 

nhanh

.', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (647, 162, N'Tốc 

độ 

tăng 

tỉ 

lệ 

dân 

thành 

thị 

chậm

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (648, 162, N'Tỉ 

lệ 

dân 

thành 

thị 

tăng 

liên 

tục

.', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (649, 163, N'Đồng 

bằng 

sông 

Hồng', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (650, 163, N'Đông 

Nam 

Bộ', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (651, 163, N'Đồng 

bằng 

sông 

Cửu 

Long', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (652, 163, N'Tây 

Nguyên', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (653, 164, N'Biểu 

đồ 

tròn', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (654, 164, N'Biểu 

đồ 

đường', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (655, 164, N'Biểu 

đồ 

miền', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (656, 164, N'Biểu 

đồ 

cột', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (657, 165, N'Thu 

nhập 

bình 

quân 

đầu 

người 

của 

Đông 

Nam 

Bộ 

và 

Tây 

Nguyên


đều 

có 

xu 

hướng 

tăng

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (658, 165, N'Thu 

nhập 

của 

Đông 

Nam 

Bộ 

luôn 

cao 

hơn 

Tây 

Nguyên

.', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (659, 165, N'Thu 

nhập 

bình 

quân 

đầu 

người 

của 

Đông 

Nam 

Bộ 

tăng 

liên 

tục

.', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (660, 165, N'Thu 

nhập 

bình 

quân 

đầu 

người 

của 

Tây 

Nguyên


tăng 

liên 

tục

.', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (661, 167, N'eradicate', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (662, 167, N'astronaut', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (663, 167, N'standard', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (664, 167, N'fatal', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (665, 168, N'straight', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (666, 168, N'pleasure', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (667, 168, N'celebrate', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (668, 168, N'break', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (669, 169, N'impressed', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (670, 169, N'proposed', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (671, 169, N'increased', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (672, 169, N'passed', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (673, 170, N'penalize', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (674, 170, N'penetrate', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (675, 170, N'penalty', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (676, 170, N'penny', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (677, 171, N'crossbar', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (678, 171, N'discuss', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (679, 171, N'association', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (680, 171, N'possession', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (681, 172, N'Đáp 

án 

a', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (682, 172, N'Đáp 

án 

b', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (683, 172, N'Đáp 

án 

c', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (684, 172, N'Đáp 

án 

d', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (685, 173, N'AL', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (686, 173, N'DB', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (687, 173, N'DLI', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (688, 173, N'ANPha', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (689, 175, N'3

:

00', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (690, 175, N'4

:

00', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (691, 175, N'5

:

00', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (692, 175, N'10

:

00', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (693, 176, N'At 

the 

bus 

stop

.', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (694, 176, N'At 

a 

conference', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (695, 176, N'In 

the 

man’s 

office', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (696, 176, N'In 

the 

waiting 

room', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (697, 178, N'failing', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (698, 178, N'fail', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (699, 178, N'failed', 3, 0, 0, 0)
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (700, 178, N'failure', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (701, 179, N'with', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (702, 179, N'into', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (703, 179, N'in', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (704, 179, N'for', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (705, 180, N'printer', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (706, 180, N'printed', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (707, 180, N'printing', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (708, 180, N'print', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (709, 182, N'light', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (710, 182, N'slight', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (711, 182, N'lightly', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (712, 182, N'lighted', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (713, 183, N'certainly', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (714, 183, N'possibly', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (715, 183, N'mainly', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (716, 183, N'likely', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (717, 184, N'continued', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (718, 184, N'chased', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (719, 184, N'followed', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (720, 184, N'forwarded', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (721, 185, N'each


one', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (722, 185, N'one


other', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (723, 185, N'the


other


one', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (724, 185, N'one


another', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (725, 186, N'relation', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (726, 186, N'relationship', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (727, 186, N'relations', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (728, 186, N'relatives', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (729, 187, N'younger', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (730, 187, N'most


young', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (731, 187, N'youngest', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (732, 187, N'young', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (733, 188, N'easy', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (734, 188, N'basic', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (735, 188, N'fundamental', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (736, 188, N'elementary', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (737, 189, N'changed', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (738, 189, N'transferred', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (739, 189, N'converted', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (740, 189, N'exchanged', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (741, 190, N'sense', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (742, 190, N'sensation', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (743, 190, N'sensitivity', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (744, 190, N'sensibility', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (745, 191, N'inactive', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (746, 191, N'inaccurate', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (747, 191, N'inappropriate', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (748, 191, N'inexact', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (749, 193, N'0', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (750, 193, N'# 

Value 

!', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (751, 193, N'4', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (752, 193, N'# 

Name 

!', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (753, 194, N'SUMIF', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (754, 194, N'COUNTIF', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (755, 194, N'COUNT', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (756, 194, N'SUM', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (757, 195, N'HT 

CNTT', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (758, 195, N'ht 

cntt', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (759, 195, N'Ht 

Cntt', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (760, 195, N'# 

NAME

?', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (761, 196, N'TH', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (762, 196, N'TT', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (763, 196, N'TTTH', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (764, 196, N'TTTT', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (765, 197, N'Số 

123', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (766, 197, N'Số 

12', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (767, 197, N'Chuỗi 

&ldquo; 

123 

&rdquo;', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (768, 197, N'Số 

23', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (769, 198, N'# 

Value 

!', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (770, 198, N'50', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (771, 198, N'10', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (772, 198, N'2', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (773, 199, N'Dữ 

liệu 

kiểu 

số 

sẽ 

mặc 

định 

căn 

lề 

trái', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (774, 199, N'Dữ 

liệu 

kiểu 

ký 

tự 

sẽ 

mặc 

định 

căn 

lề 

trái', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (775, 199, N'Dữ 

liệu 

kiểu 

thời 

gian 

sẽ 

mặc 

định 

căn 

lề 

trái', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (776, 199, N'Dữ 

liệu 

kiểu 

ngày 

tháng 

sẽ 

mặc 

định 

căn 

lề 

trái', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (777, 200, N'0', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (778, 200, N'# 

Value 

!', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (779, 200, N'0 

#', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (780, 200, N'# 

DIV 

/ 

0 

!', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (781, 201, N'B 

$ 

1

:

D 

$ 

10', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (782, 201, N'$ 

B1 

:$ 

D10', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (783, 201, N'B 

$ 

1 

$: 

D 

$ 

10 

$', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (784, 201, N'$ 

B 

$ 

1 

:$ 

D 

$ 

10', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (785, 202, N'4', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (786, 202, N'2014', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (787, 202, N'1', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (788, 202, N'# 

DIV 

/ 

0 

!', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (789, 203, N'Thẻ 

Home 

- 

Cells 

&mdash; 

Format 

- 

Hide 

&amp; 

Unhide 

&mdash; 

Hide 

Columns', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (790, 203, N'Thẻ 

Data 

- 

Cells 

&mdash; 

Format 

- 

Hide 

&amp; 

Unhide 

&mdash; 

Hide 

Columns', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (791, 203, N'Thẻ 

Fomulas 

- 

Cells 

&mdash; 

Format 

- 

Hide 

&amp; 

Unhide 

&mdash; 

Hide 

Columns', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (792, 203, N'Thẻ 

View 

- 

Cells 

&mdash; 

Format 

- 

Hide 

&amp; 

Unhide 

&mdash; 

Hide 

Columns', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (793, 204, N'Thẻ 

Insert 

- 

Page 

Setup 

- 

Print 

Titles', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (794, 204, N'Thẻ 

Page 

Layout 

- 

Page 

Setup 

- 

Print 

Titles', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (795, 204, N'Thẻ 

File 

- 

Page 

Setup 

- 

Print 

Titles', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (796, 204, N'Thẻ 

Format 

- 

Page 

Setup 

- 

Print 

Titles', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (797, 205, N'Thẻ 

Fumulas 

&mdash; 

Picture', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (798, 205, N'Thẻ 

Data 

&mdash; 

Picture', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (799, 205, N'Thẻ 

Insert 

&mdash; 

Picture', 3, 1, 0, 0)
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (800, 205, N'Thẻ 

Review 

&mdash; 

Picture', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (801, 206, N'Thẻ 

Insert 

&mdash; 

Text 

to 

Columns 

&mdash; 

Delimited', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (802, 206, N'Thẻ 

Home 

&mdash; 

Text 

to 

Columns 

&mdash; 

Delimited', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (803, 206, N'Thẻ 

Fomulas 

- 

Text 

to 

Columns 

&mdash; 

Delimited', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (804, 206, N'Thẻ 

Data 

- 

Text 

to 

Columns 

&mdash; 

Delimited', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (805, 207, N'Thẻ 

Page 

Layout 

&mdash; 

Orientation 

&mdash; 

Portrait 

/ 

Landscape', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (806, 207, N'Thẻ 

File 

&mdash; 

Page 

Setup 

&mdash; 

Portrait 

/ 

Landscape', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (807, 207, N'Thẻ 

Format 

- 

Page 

Setup 

&mdash; 

Portrait 

/ 

Landscape', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (808, 207, N'Thẻ 

Home 

- 

Orientation 

&mdash; 

Portrait 

/ 

Landscape', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (809, 208, N'Thẻ 

Review 

&mdash; 

Freeze 

Panes', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (810, 208, N'Thẻ 

View 

&mdash; 

Freeze 

Panes', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (811, 208, N'Thẻ 

Page 

Layout 

&mdash; 

Freeze 

Panes', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (812, 208, N'Thẻ 

Home 

&mdash; 

Freeze 

Panes', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (813, 209, N'# 

DIV 

/ 

0 

!', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (814, 209, N'# 

VALUE 

!', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (815, 209, N'6', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (816, 209, N'TINHOC', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (817, 210, N'AND', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (818, 210, N'OR', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (819, 210, N'NOT', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (820, 210, N'&amp;', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (821, 211, N'Excel', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (822, 211, N'# 

VALUE 

!', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (823, 211, N'2007', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (824, 211, N'Excel2007', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (825, 212, N'Tiêu 

để', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (826, 212, N'Có 

đường 

lưới 

hay 

không', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (827, 212, N'Chú 

giải 

cho 

các 

trục', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (828, 212, N'Cả 

3 

đều 

đúng', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (829, 213, N'# 

NAME 

!', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (830, 213, N'# 

VALUE 

!', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (831, 213, N'Giá 

trị 

kiểu 

chuỗi 

2008', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (832, 213, N'Giá 

trị 

kiểu 

số 

2008', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (833, 214, N'3', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (834, 214, N'5', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (835, 214, N'- 

25', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (836, 214, N'14', 4, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (837, 215, N'TT 

TTTH', 1, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (838, 215, N'tt 

ttth', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (839, 215, N'TT', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (840, 215, N'TTTH', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (841, 216, N'5', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (842, 216, N'6', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (843, 216, N'4', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (844, 216, N'3', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (845, 217, N'= 

C1 

+ 

$ 

B 

$ 

2 

+ 

E 

$ 

3', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (846, 217, N'= 

C4 

+ 

$ 

B 

$ 

2 

+ 

E 

$ 

3', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (847, 217, N'= 

A4 

+ 

$ 

B 

$ 

2 

+ 

C 

$ 

3', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (848, 217, N'Báo 

lỗi', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (849, 218, N'Không 

được 

tuyển 

dụng', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (850, 218, N'Công 

thức 

sai 

vì 

trong 

Excel 

không 

có 

phép 

toán 

=&gt;', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (851, 218, N'Công 

thức 

sai 

vì 

thiếu 

đối 

số 

trong 

hàm 

IF', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (852, 218, N'TRUE', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (853, 219, N'=&quot; 

TRAN 

VAN 

&quot; 

+ 

&quot; 

AN 

&quot;', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (854, 219, N'=&quot; 

TRAN 

VAN 

&quot; 

&amp; 

&quot; 

AN 

&quot;', 2, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (855, 219, N'=&quot; 

TRAN 

VAN 

&quot; 

AND 

&quot; 

AN 

&quot;', 3, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (856, 219, N'Không 

ghép 

được', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (857, 220, N'Tran 

Thi 

Hoa', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (858, 220, N'tran 

thi 

hoa', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (859, 220, N'TRAN 

THI 

HOA', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (860, 220, N'Báo 

lỗi', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (861, 221, N'Nằm 

trong 

cột 

bên 

phải 

của 

vùng 

dữ 

liệu 

tìm 

kiếm', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (862, 221, N'Nắm 

trong 

hàng 

bất 

kỳ 

của 

vùng 

dữ 

liệu 

tìm 

kiếm', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (863, 221, N'Nằm 

trong 

cột 

bên 

trài 

của 

vùng 

dữ 

liệu 

tìm 

kiếm', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (864, 221, N'Nằm 

trọng 

cột 

bất 

kỳ 

của 

của 

vùng 

dữ 

liệu 

tìm 

kiếm', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (865, 222, N'7500', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (866, 222, N'7480', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (867, 222, N'7475', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (868, 222, N'7475

, 

5', 4, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (869, 223, N'A

. 

15', 1, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (870, 223, N'18', 2, 0, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (871, 223, N'tran 

_ 

thi 

_ 

thu 

_ 

thanh', 3, 1, 0, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (872, 223, N'Báo 

lỗi', 4, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[Answers] OFF
SET IDENTITY_INSERT [dbo].[Chapters] ON 

INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted]) VALUES (1, N'Hoa Huu Co', N'', 0, 0, 1, 1, 1, 0)
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted]) VALUES (2, N'Chuong 1. Tich Phan Kep', N'', 0, 0, 2, 1, 1, 0)
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted]) VALUES (3, N'Co Ban', N'', 0, 2, 2, 2, 1, 0)
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted]) VALUES (4, N'Nâng Cao', N'', 0, 2, 2, 3, 1, 0)
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted]) VALUES (5, N'Luat Kinh Te Can Ban', N'', 0, 0, 3, 1, 1, 0)
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted]) VALUES (6, N'Kinh Te Dia Ly', N'', 0, 0, 4, 1, 1, 0)
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted]) VALUES (7, N'Kinh Te Vung Dong Nam Bo', N'', 0, 0, 4, 2, 1, 0)
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted]) VALUES (8, N'Part I Pronunciation', N'
<p><b>Pronunciation </b></p>

<p><b>Mark the letter A, B, C, or D on your
answer sheet to indicate the word whose underlined part differs from the other
three in pronunciation in each of the following questions.</b></p>

', 0, 0, 5, 1, 1, 0)
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted]) VALUES (9, N'Part Ii Question-response', N'
<p>Question-Response</p>

<p>Choose the answer that most
closely answers the question and fill in the corresponding oval on your answer
sheet. </p>
', 0, 0, 5, 2, 1, 0)
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted]) VALUES (10, N'Part Iii Conversations', N'
<p>Conversations</p>

<p>Choose the best answer to the
question and fill in the corresponding oval on your answer sheet. </p>
', 0, 0, 5, 3, 1, 0)
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted]) VALUES (11, N'Powerpoint', N'', 0, 0, 7, 1, 1, 0)
SET IDENTITY_INSERT [dbo].[Chapters] OFF
SET IDENTITY_INSERT [dbo].[Exams] ON 

INSERT [dbo].[Exams] ([Id], [Name], [CreateDate], [UserId], [Desktop], [Deleted]) VALUES (1, N'HK2 - Cuối kỳ - Đợt 1 - NH 17_18', CAST(N'2017-07-24T01:22:56.293' AS DateTime), NULL, 0, 0)
SET IDENTITY_INSERT [dbo].[Exams] OFF
SET IDENTITY_INSERT [dbo].[Faculties] ON 

INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Validated], [Deleted]) VALUES (1, N'Khoa Cong Nghe Thuc Pham', NULL, 1, 0)
INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Validated], [Deleted]) VALUES (2, N'Khoa Hoc Co Ban', NULL, 1, 0)
INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Validated], [Deleted]) VALUES (3, N'Khoa Luat', NULL, 1, 0)
INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Validated], [Deleted]) VALUES (4, N'Khoa Moi Truong', NULL, 1, 0)
INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Validated], [Deleted]) VALUES (5, N'Khoa Ngoai Ngu', NULL, 1, 0)
INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Validated], [Deleted]) VALUES (6, N'Quan Tri Doanh Nghiep', NULL, 1, 0)
INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Validated], [Deleted]) VALUES (7, N'Trung Tam Tin Hoc', NULL, 1, 0)
SET IDENTITY_INSERT [dbo].[Faculties] OFF
SET IDENTITY_INSERT [dbo].[Matrices] ON 

INSERT [dbo].[Matrices] ([Id], [SubjectId], [CreateDate], [Name]) VALUES (1, 1, CAST(N'2017-07-24T08:23:04.187' AS DateTime), N'YC_HH_90')
INSERT [dbo].[Matrices] ([Id], [SubjectId], [CreateDate], [Name]) VALUES (2, 3, CAST(N'2017-07-24T08:23:04.230' AS DateTime), N'YC_KT_60')
SET IDENTITY_INSERT [dbo].[Matrices] OFF
SET IDENTITY_INSERT [dbo].[MatrixDetails] ON 

INSERT [dbo].[MatrixDetails] ([Id], [MatrixId], [ChapterId], [Quantity], [Excluded]) VALUES (1, 1, 1, 40, N'-1')
INSERT [dbo].[MatrixDetails] ([Id], [MatrixId], [ChapterId], [Quantity], [Excluded]) VALUES (2, 2, 5, 25, N'-1')
SET IDENTITY_INSERT [dbo].[MatrixDetails] OFF
SET IDENTITY_INSERT [dbo].[Questions] ON 

INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (1, N'
<p>Ứng
dụng nào sau đây không phải của
kim loại kiềm?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 1, CAST(N'2017-07-24T00:19:03.700' AS DateTime), CAST(N'2017-07-24T00:19:08.693' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 1, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (2, N'
<p>Để
điều chế etyl axetat trong phòng thí nghiệm, người ta lắp dụng cụ như hình vẽ
sau:</p>

<p>
 
 
  
  
  
  
  
  
  
  
  
  
  
  
 
 
 

 <img src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Cong Nghe Thuc Pham\Hoa Hoc\Hoa Huu Co\2017\7\24\Images\adb4563d-f468-428d-a39e-0f0dd5fbfdf7.png">
</p>

<p>Hóa
chất được cho vào bình 1 trong thí nghiệm trên là</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 14, 13, 1, CAST(N'2017-07-24T00:19:08.770' AS DateTime), CAST(N'2017-07-24T00:19:11.970' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 2, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (3, N'
<p>Điều nào sau đây là sai khi nói về glucozơ và fructozơ ?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 1, CAST(N'2017-07-24T00:19:12.030' AS DateTime), CAST(N'2017-07-24T00:19:16.050' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 3, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (4, N'
<p>Cho
biết Cu có Z=29. Cấu hình electron của Cu<sup>+</sup> là</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 1, CAST(N'2017-07-24T00:19:16.117' AS DateTime), CAST(N'2017-07-24T00:19:17.960' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 4, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (5, N'
<p>Để
tráng bạc một số ruột phích, người ta thủy phân 171 gam saccarozơ trong môi trường
axit. Dung dịch thu được cho phản ứng với dung dịch AgNO<sub>3 </sub>dư trong
NH<sub>3</sub>. Khối lượng Ag tạo ra là: (giả thiết rằng hiệu suất toàn bộ quá
trình đạt 90%)</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 14, 0, 1, CAST(N'2017-07-24T00:19:18.030' AS DateTime), CAST(N'2017-07-24T00:19:19.940' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 5, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (6, N'
<p>Cho
dãy các chất: C<sub>2</sub>H<sub>2</sub>, HCHO, HCOOH, CH<sub>3</sub>CHO, C<sub>6</sub>H<sub>5</sub>NH<sub>3</sub>Cl,
HCOOC<sub>2</sub>H<sub>5</sub>, (CH<sub>3</sub>)<sub>2</sub>CO, C<sub>12</sub>H<sub>22</sub>O<sub>11</sub>
(mantozơ), HOOC-CH<sub>3</sub>. Số chất trong dãy tham gia được phản ứng tráng
gương là:</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 14, 0, 1, CAST(N'2017-07-24T00:19:20.003' AS DateTime), CAST(N'2017-07-24T00:19:20.990' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 6, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (7, N'
<p>Các
khí thải công nghiệp và của các động cơ ô tô, xe máy... là nguyên nhân chủ yếu
gây ra mưa axit. Những thành phần hóa học chủ yếu trong các khí thải trực tiếp gây
ra mưa axit là:</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 14, 0, 1, CAST(N'2017-07-24T00:19:21.067' AS DateTime), CAST(N'2017-07-24T00:19:23.623' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 7, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (8, N'
<p>Số amin bậc 1 có công thức phân tử C<sub>3</sub>H<sub>9</sub>N
là:</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 14, 0, 1, CAST(N'2017-07-24T00:19:23.693' AS DateTime), CAST(N'2017-07-24T00:19:24.930' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 8, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (9, N'
<p>Polime
dùng làm ống dẫn nước, đồ giả da, vải che mưa là:</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 14, 0, 1, CAST(N'2017-07-24T00:19:24.997' AS DateTime), CAST(N'2017-07-24T00:19:26.333' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 9, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (10, N'
<p>Thí nghiệm nào sau đây không có sự hòa tan chất rắn?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 14, 2, 1, CAST(N'2017-07-24T00:19:26.397' AS DateTime), CAST(N'2017-07-24T00:19:30.470' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 10, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (11, N'
<p>Kim loại Fe phản ứng với dung dịch X (loãng, dư) không tạo
muối Fe (II). Chất X là:</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 14, 0, 1, CAST(N'2017-07-24T00:19:30.537' AS DateTime), CAST(N'2017-07-24T00:19:31.897' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 11, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (12, N'
<p>Tơ nào sau đây là tơ thiên nhiên ?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 1, CAST(N'2017-07-24T00:19:31.973' AS DateTime), CAST(N'2017-07-24T00:19:33.980' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 12, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (13, N'
<p>Phương trình hoá học nào sau đây sai ?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 1, CAST(N'2017-07-24T00:19:34.083' AS DateTime), CAST(N'2017-07-24T00:19:37.810' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 13, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (14, N'
<p>Cho dãy các chất: Ag, Fe<sub>3</sub>O<sub>4</sub>, Na<sub>2</sub>CO<sub>3</sub>,
Mg(NO<sub>3</sub>)<sub>2</sub>,
Zn, CuO, NaHSO<sub>3</sub>, K<sub>2</sub>SO<sub>4</sub> và Fe(OH)<sub>3</sub>. Số chất trong dãy tác dụng được với
dung dịch HCl loãng là:</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 14, 0, 1, CAST(N'2017-07-24T00:19:37.880' AS DateTime), CAST(N'2017-07-24T00:19:39.173' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 14, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (15, N'
<p>Nếu cho dung dịch CuSO<sub>4</sub> vào dung dịch NaOH thì
xuất hiện kết tủa màu</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 14, 0, 1, CAST(N'2017-07-24T00:19:39.243' AS DateTime), CAST(N'2017-07-24T00:19:40.730' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 15, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (16, N'
<p>Cho mẫu nước cứng chứa các ion: Ca<sup>2+</sup>, Mg<sup>2+</sup>,
Cl<sup>&mdash;</sup>, SO<sub>4</sub><sup>2&mdash;</sup>, HCO<sub>3</sub><sup>&mdash;</sup>. Hoá
chất được dùng để làm mềm mẫu nước cứng trên là:</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 14, 2, 1, CAST(N'2017-07-24T00:19:40.800' AS DateTime), CAST(N'2017-07-24T00:19:42.047' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 16, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (17, N'
<p>Etyl propionat có công thức hóa học là:</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 1, CAST(N'2017-07-24T00:19:42.123' AS DateTime), CAST(N'2017-07-24T00:19:43.367' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 17, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (18, N'
<p>Cho
1,68 gam hỗn hơp A gồm Fe, Cu, Mg tác duṇg hết với H<sub>2</sub>SO<sub>4</sub>
đăc nóng. Sau phản ứng thấy tạo hỗn hơp muối B và khí SO<sub>2</sub>
có thể tích 1,008 lít (đktc). Khối lươṇg muối thu đươc là</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 14, 0, 1, CAST(N'2017-07-24T00:19:43.437' AS DateTime), CAST(N'2017-07-24T00:19:45.253' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 18, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (19, N'
<p>Phát biểu nào sau đây sai ?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 1, CAST(N'2017-07-24T00:19:45.333' AS DateTime), CAST(N'2017-07-24T00:19:50.297' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 19, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (20, N'
<p>Trong các ion sau: Ag<sup>+</sup>, Cu<sup>2+</sup> Fe<sup>2+</sup>
Au<sup>3+</sup>. Ion có tính oxi yếu nhất là:</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 1, CAST(N'2017-07-24T00:19:50.370' AS DateTime), CAST(N'2017-07-24T00:19:51.657' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 20, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (21, N'
<p>Cho 1,56 gam kim loại kiềm M tác dụng hết với H<sub>2</sub>O,
thu được 0,02 mol khí H<sub>2</sub>. Kim loại M là:</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 14, 0, 1, CAST(N'2017-07-24T00:19:51.733' AS DateTime), CAST(N'2017-07-24T00:19:52.983' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 21, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (22, N'
<p>Cho dãy các chất: metyl acrylat, tristearin, fructozơ, anilin, alanin, glyxylalanin (Gly-Ala). Số chất bị thủy phân khi đun nóng
trong môi trường axit là:</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 1, CAST(N'2017-07-24T00:19:53.050' AS DateTime), CAST(N'2017-07-24T00:19:54.057' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 22, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (23, N'
<p>Để phân biệt các dung dịch riêng biệt: NH<sub>4</sub>Cl,
MgCl<sub>2</sub>, AlCl<sub>3</sub>, NaNO<sub>3</sub> có thể dùng dung dịch</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 1, CAST(N'2017-07-24T00:19:54.127' AS DateTime), CAST(N'2017-07-24T00:19:55.443' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 23, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (24, N'
<p>Cho 21,6 gam hỗn hợp X gồm metyl amin, etylamin và
propyl amin (có tỉ lệ số mol tương ứng là 1:2:1) tác dụng hết với dung
dịch HCl thu được m gam muối. Giá trị của m là</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 1, CAST(N'2017-07-24T00:19:55.523' AS DateTime), CAST(N'2017-07-24T00:19:57.797' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 24, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (25, N'
<p>Khử hoàn
toàn m gam Fe<sub>2</sub>O<sub>3</sub> cần vừa đủ 3,36 lít khí CO (ở đktc). Khối
lượng sắt thu được sau phản ứng là</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 14, 0, 1, CAST(N'2017-07-24T00:19:57.880' AS DateTime), CAST(N'2017-07-24T00:19:59.867' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 25, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (26, N'
<p>Cho m gam bột Fe vào dung dịch hỗn hợp NaNO<sub>3</sub>
và HCl đến khi các phản ứng kết thúc; thu được dung dịch X; 4,48 lít (đktc)
hỗn hợp khí NO, H<sub>2</sub>&nbsp;(có tỉ khối đối với H<sub>2</sub> là 4,5) và
1,4 gam chất rắn không
tan. Giá trị của m là</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 14, 0, 1, CAST(N'2017-07-24T00:19:59.950' AS DateTime), CAST(N'2017-07-24T00:20:02.220' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 26, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (27, N'
<p>Cho 4,56 gam hỗn hợp X gồm C<sub>3</sub>H<sub>12</sub>O<sub>3</sub>N<sub>2</sub>
và C<sub>2</sub>H<sub>8</sub>O<sub>3</sub>N<sub>2</sub> tác dụng vừa đủ với
dung dịch NaOH đun nóng thu được dung dịch Y chỉ chứa các chất vô cơ và 0,055
mol hai chất hữu cơ đơn chức (đều làm xanh quỳ tím ẩm). Cô cạn Y thu được m gam
muối. Giá trị của m gần nhất với giá trị nào sau đây:</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 14, 0, 1, CAST(N'2017-07-24T00:20:02.300' AS DateTime), CAST(N'2017-07-24T00:20:03.933' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 27, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (28, N'
<p>Cho 0,01 mol α - amino axit X tác dụng vừa đủ với 200 ml
dung dịch KOH 0,1M hay 100 ml dung dịch HCl 0,1M. Nếu cho 0,03 mol X tác dụng với
40 gam dung dịch NaOH 7,05% cô cạn dung 
dịch sau phản ứng, thu được 6,15 gam chất rắn. Công thức của X là.</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 1, CAST(N'2017-07-24T00:20:04.007' AS DateTime), CAST(N'2017-07-24T00:20:06.687' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 28, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (29, N'
<p>Đốt cháy 17,16 gam chất
béo X bằng lượng oxi vừa đủ, thu được 48,4 gam CO<sub>2</sub> và 18,36 gam nước.
Mặt khác 0,06 mol X làm mất màu tối đa V ml dung dịch Br<sub>2 </sub> 1M. Giá trị của V là:</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 14, 0, 1, CAST(N'2017-07-24T00:20:06.807' AS DateTime), CAST(N'2017-07-24T00:20:08.053' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 29, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (30, N'
<p>Để
điều chế cao su Buna người ta có thể thực hiện theo các sơ đồ biến hóa sau: <v:shapetype id="_x0000_t75" coordsize="21600,21600"
 o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe" filled="f"
 stroked="f">
 <v:stroke joinstyle="miter"/>
 <v:formulas>
  <v:f eqn="if lineDrawn pixelLineWidth 0"/>
  <v:f eqn="sum @0 1 0"/>
  <v:f eqn="sum 0 0 @1"/>
  <v:f eqn="prod @2 1 2"/>
  <v:f eqn="prod @3 21600 pixelWidth"/>
  <v:f eqn="prod @3 21600 pixelHeight"/>
  <v:f eqn="sum @0 0 1"/>
  <v:f eqn="prod @6 1 2"/>
  <v:f eqn="prod @7 21600 pixelWidth"/>
  <v:f eqn="sum @8 21600 0"/>
  <v:f eqn="prod @7 21600 pixelHeight"/>
  <v:f eqn="sum @10 21600 0"/>
 </v:formulas>
 <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
 
</v:shapetype><v:shape id="Picture_x0020_15" o:spid="_x0000_i1025" type="#_x0000_t75"
 o:bordertopcolor="yellow pure" o:borderleftcolor="yellow pure"
 o:borderbottomcolor="yellow pure" o:borderrightcolor="yellow pure">
 <v:imagedata src="file:///C:/Users/MHN/AppData/Local/Temp/msohtmlclip1/01/clip_image001.png"
  o:title="hinh"/>
 <w:bordertop type="single" width="6"/>
 <w:borderleft type="single" width="6"/>
 <w:borderbottom type="single" width="6"/>
 <w:borderright type="single" width="6"/>
</v:shape>&nbsp;Tính khối lượng etan cần lấy để có thể điều chế được
10,8 kg cao su buna theo sơ đồ trên?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 1, CAST(N'2017-07-24T00:20:08.127' AS DateTime), CAST(N'2017-07-24T00:20:10.297' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 30, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (31, N'
<p>X, Y, Z, T, P là các dung dịch chứa các chất sau:
axit glutamic, alanin, phenylamoni clorua, lysin và amoni clorua. Thực hiện các
thí nghiệm và có kết quả ghi theo bảng sau:</p>

<p>Các chất X, Y, Z, T, P lần lượt là.</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 14, 10, 1, CAST(N'2017-07-24T00:20:10.380' AS DateTime), CAST(N'2017-07-24T00:20:15.377' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 31, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (32, N'
<p>Thực
hiện phản ứng nhiệt nhôm m gam hỗn hợp gồm Al và Fe<sub>3</sub>O<sub>4</sub>. Để
hoà tan hết các chất tan được trong dung dịch KOH thì cần dùng 400g dung dịch
KOH 11,2%, không có khí thoát ra. Sau khi hoà tan bằng dung dịch KOH, phần chất
rắn còn lại có khối lượng 73,6g. Giá trị của m là</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 1, CAST(N'2017-07-24T00:20:15.450' AS DateTime), CAST(N'2017-07-24T00:20:17.103' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 32, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (33, N'
<p>Khi nhỏ từ từ đến
dư dung dịch NaOH vào dung dịch hỗn hợp gồm a mol HCl và b mol AlCl<sub>3</sub>,
kết quả thí nghiệm được biểu diễn trên đồ thị sau:</p>

<p>Tỉ lệ a : b là</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 14, 0, 1, CAST(N'2017-07-24T00:20:17.180' AS DateTime), CAST(N'2017-07-24T00:20:18.933' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 33, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (34, N'
<p>Thủy phân hoàn toàn m gam hỗn hợp gồm peptit X và peptit
Y (đều mạch hở) bằng dung dịch NaOH vừa đủ thu được 151,2 gam hỗn hợp gồm các
muối natri của Gly, Ala và Val. Mặt khác, để đốt cháy hoàn toàn m gam hỗn hợp
X, Y ở trên cần 107,52 lít khí O<sub>2</sub> (đktc) và thu được 64,8 gam H<sub>2</sub>O. Giá trị gần nhất của m là</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 1, CAST(N'2017-07-24T00:20:19.010' AS DateTime), CAST(N'2017-07-24T00:20:20.307' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 34, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (35, N'
<p>Thực
hiện các thí nghiệm sau:</p>

<p>(I)
Cho dung dịch NaCl vào dung dịch KOH.</p>

<p>(II)
Cho dung dịch Na<sub>2</sub>CO<sub>3</sub> vào dung dịch Ca(OH)<sub>2</sub>.</p>

<p>(III)
Điện phân dung dịch NaCl với điện cực trơ, có màng ngăn.</p>

<p>(IV)
Cho Cu(OH)<sub>2 </sub>vào dung dịch NaNO<sub>3</sub>.</p>

<p>(V)
Sục khí NH<sub>3</sub> vào dung dịch Na<sub>2</sub>CO<sub>3</sub>.</p>

<p>(VI)
Cho dung dịch Na<sub>2</sub>SO<sub>4</sub> vào dung dịch Ba(OH)<sub>2</sub>. </p>

<p>Số
thí nghiệm thu được NaOH là</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 1, CAST(N'2017-07-24T00:20:20.383' AS DateTime), CAST(N'2017-07-24T00:20:22.253' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 35, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (36, N'
<p>Cho hỗn hợp Cu và Fe<sub>2</sub>O<sub>3</sub> vào dung dịch
HCl dư. Sau khi phản ứng xảy ra hoàn toàn, thu được dung dịch X và một lượng chất
rắn không tan. Dung dịch X không tác dụng với chất nào sau đây?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 1, CAST(N'2017-07-24T00:20:22.333' AS DateTime), CAST(N'2017-07-24T00:20:23.270' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 36, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (37, N'
<p>Hòa tan
6,84 gam muối MSO<sub>4</sub> vào nước được dung dịch X. Điện phân X (với điện
cực trơ, cường độ dòng điện không đổi) trong thời gian t giây, được m gam kim
loại M duy nhất ở catot và 0,392 lít khí ở anot. Còn nếu thời gian điện phân là
2t giây thì tổng thể tích khí thu được ở cả hai điện cực là 1,3944 lít. Biết thể
tích các khí ở điều kiện tiêu chuẩn. Giá trị của m là:</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 1, CAST(N'2017-07-24T00:20:23.350' AS DateTime), CAST(N'2017-07-24T00:20:25.177' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 37, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (38, N'
<p>Cho các phát biểu sau:</p>

<p>1) Glucozơ bị khử bởi dung dịch AgNO<sub>3</sub> trong NH<sub>3</sub>.</p>

<p>2) Phân tử khối của một amino axit (1 nhóm &mdash; NH<sub>2</sub>,
1 nhóm &mdash; COOH) luôn luôn là một số lẻ.</p>

<p>3) Dung dịch CH<sub>3</sub>NH<sub>2</sub> làm quỳ tím
chuyển sang màu hồng.</p>

<p>4) Các aminoaxit (nhóm NH<sub>2</sub>&nbsp;ở vị số 6,
7...) là nguyên liệu sản xuất tơ nilon.</p>

<p>5) Tơ tằm thuộc loại tơ thiên nhiên.</p>

<p>6) Thuỷ phân hoàn toàn một este no, đơn chức, mạch hở trong
môi trường kiềm luôn thu được muối và ancol.</p>

<p>7) Dung dịch saccarozơ không tác dụng với Cu(OH)<sub>2</sub>
cho dung dịch phức màu xanh lam.</p>

<p>8) Tinh bột và xenlulozơ thủy phân hoàn toàn đều thu được
sản phẩm cuối cùng là glucozơ.</p>

<p>9) Để phân biệt anilin và ancol etylic ta có thể dùng dung
dịch brom.</p>

<p>10) Các peptit đều dễ bị thuỷ phân trong môi trường axit hoặc
kiềm hoặc có mặt của men thích hợp.</p>

<p>Số phát biểu đúng là:</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 14, 0, 1, CAST(N'2017-07-24T00:20:25.250' AS DateTime), CAST(N'2017-07-24T00:20:27.623' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 38, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (39, N'
<p>Hòa tan hoàn toàn m gam hỗn
hợp X gồm Mg, Fe, FeCO<sub>3</sub> và Cu(NO<sub>3</sub>)<sub>2</sub> trong dung dịch chứa H<sub>2</sub>SO<sub>4</sub> loãng và
0,045 mol NaNO<sub>3</sub> thu được dung dịch Y
chỉ chứa 62,605 gam muối trung hòa (không có Fe<sup>3+</sup>) và 3,808 lít (đktc) hỗn hợp khí Z (trong đó H<sub>2</sub>: 0,02 mol) có tỉ khối so với O<sub>2</sub> bằng 19/17.
Cho dung dịch NaOH 1M vào Y đến khi lượng kết
tủa đạt cực đại là 31.72 gam thì vừa hết 865 ml. Giá trị m là:</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 1, CAST(N'2017-07-24T00:20:27.700' AS DateTime), CAST(N'2017-07-24T00:20:29.567' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 39, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (40, N'
<p>Thủy
phân m gam hỗn hợp X gồm este đơn chức M (C<sub>5</sub>H<sub>8</sub>O<sub>2</sub>)
và este hai chức N (C<sub>6</sub>H<sub>10</sub>O<sub>4</sub>) cần vừa đủ 150 ml
dung dịch NaOH 1M rồi cô cạn thu được hỗn hợp Y gồm hai muối và hỗn hợp Z gồm
hai ancol no đơn chức, đồng đẳng kế tiếp, ngoài ra không chứa sản phẩm hữu cơ
nào khác. Cho toàn bộ hỗn hợp Z tác dụng với một lượng CuO (dư) nung nóng thu
được hỗn hợp hơi T (có tỉ khối hơi so với H<sub>2</sub> là 13.75). Cho toàn bộ
hỗn hợp T tác dụng với một lượng dư dung dịch AgNO<sub>3</sub>/NH<sub>3</sub>
thu được 32.4 gam Ag. Các phản ứng xảy ra hoàn toàn. Thành phần phần trăm của
muối có phân tử khối nhỏ hơn trong Y là</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 1, CAST(N'2017-07-24T00:20:29.647' AS DateTime), CAST(N'2017-07-24T00:20:31.493' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 40, 1, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (41, N'
<p>Diện
tích miền <img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Co Ban\2017\7\24\Images\d6fbdb74-2644-458e-970b-2fe397d0abcc.png"> giới hạn bởi đường astroid <img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Co Ban\2017\7\24\Images\ba399e24-6703-448e-aa25-dd035cb0ddfb.png"> <img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Co Ban\2017\7\24\Images\e23e2df1-435e-4d0a-abe8-44097f2a7e99.png"> <img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Co Ban\2017\7\24\Images\41b152e6-43e4-4fa0-9a26-76e395f4c55b.png"> có giá trị bằng</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 3, CAST(N'2017-07-24T00:20:34.447' AS DateTime), CAST(N'2017-07-24T00:20:37.840' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 1, 2, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (42, N'
<p>Tính diện tích của miền <i>D</i> giới hạn bởi <i>y = x + 1,</i>  trục <i>Ox</i>, 
<i>y = 4 &mdash; 2x.</i></p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 3, CAST(N'2017-07-24T00:20:38.007' AS DateTime), CAST(N'2017-07-24T00:20:39.927' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 2, 2, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (43, N'
<p>Diện
tích miền <img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Co Ban\2017\7\24\Images\e3140f82-d978-48b8-88f0-f092e49ed66d.png"> giới hạn bởi đường astroid <img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Co Ban\2017\7\24\Images\c0c37f79-f5d4-491a-a67e-039405a3859a.png"> <img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Co Ban\2017\7\24\Images\43697f5d-0ba6-4c84-b59c-6dc23c1cdee7.png"> <img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Co Ban\2017\7\24\Images\a8bd098b-807c-4a85-8fa7-ba189482f418.png"> có giá trị bằng</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 3, CAST(N'2017-07-24T00:20:39.983' AS DateTime), CAST(N'2017-07-24T00:20:41.957' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 3, 2, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (44, N'
<p>Tính diện tích của miền <i>D</i> giới hạn bởi <i>y = x + 1,</i>  trục <i>Ox</i>, 
<i>y = 4 &mdash; 2x.</i></p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 3, CAST(N'2017-07-24T00:20:42.007' AS DateTime), CAST(N'2017-07-24T00:20:43.830' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 4, 2, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (45, N'
<p>Chuyển tích phân sau sang tọa độ cực <img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Nâng Cao\2017\7\24\Images\fbb10626-4047-498a-9f97-6be5123c5159.png"> trong đó <i>D</i> là hình tròn <img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Nâng Cao\2017\7\24\Images\088a8497-c4a8-443d-a5fb-bc68b93e5993.png">. Đẳng thức nào sau đây đúng?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 4, CAST(N'2017-07-24T00:20:45.110' AS DateTime), CAST(N'2017-07-24T00:20:48.353' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 5, 2, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (46, N'
<p>Cho tích phân <img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Nâng Cao\2017\7\24\Images\36ff7510-ac9a-45b6-9791-e25b5e868213.png"> Đẳng thức nào
sau đây đúng?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 4, CAST(N'2017-07-24T00:20:48.407' AS DateTime), CAST(N'2017-07-24T00:20:52.623' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 6, 2, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (47, N'
<p>Cho tích phân ad <img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Hoc Co Ban\Toan A3\Nâng Cao\2017\7\24\Images\9ab3ce22-af4d-461b-bc32-676a3d93fe6f.png"> Đẳng thức nào
sau đây đúng?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 4, CAST(N'2017-07-24T00:20:52.723' AS DateTime), CAST(N'2017-07-24T00:20:56.833' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 7, 2, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (48, N'
<p>Có bao nhiêu lọai hình công ty?</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:20:59.150' AS DateTime), CAST(N'2017-07-24T00:21:05.263' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 1, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (49, N'
<p>Lọai cổ phần nào được chuyển nhượng tự do?</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:21:05.343' AS DateTime), CAST(N'2017-07-24T00:21:10.570' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 2, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (50, N'
<p>Trong thời hạn bao nhiêu ngày kể từ ngày cấp giấy
chứng nhận đăng kí kinh doanh,cơ quan đăng kí kinh doanh phải thông báo nội
dung giấy chứng nhận đăng kí kinh doanh đó cho cơ quan thuế,thống kê:</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:21:10.680' AS DateTime), CAST(N'2017-07-24T00:21:12.350' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 3, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (51, N'
<p>Mỗi cá nhân được quyền thành lập bao nhiêu doanh
nghiệp tư nhân?</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:21:12.437' AS DateTime), CAST(N'2017-07-24T00:21:13.890' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 4, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (52, N'
<p>Lọai hình DN nào có quyền phát hành các lọai cổ phiếu:</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:21:13.983' AS DateTime), CAST(N'2017-07-24T00:21:15.720' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 5, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (53, N'
<p>Cty cổ phần có tư cách pháp nhân khi :</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 11, 8, 5, CAST(N'2017-07-24T00:21:15.807' AS DateTime), CAST(N'2017-07-24T00:21:18.827' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 6, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (54, N'
<p>Điểm khác biệt giữa thành viên hợp danh(TVHD) và thành
viên góp vốn(TVGV) :</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 11, 0, 5, CAST(N'2017-07-24T00:21:18.920' AS DateTime), CAST(N'2017-07-24T00:21:25.140' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 7, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (55, N'
<p>Tổ chức kinh doanh nào sau đây không có tư cách pháp
nhân:</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:21:25.233' AS DateTime), CAST(N'2017-07-24T00:21:27.173' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 8, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (56, N'
<p>Vốn điều lệ là gì?</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 11, 0, 5, CAST(N'2017-07-24T00:21:27.267' AS DateTime), CAST(N'2017-07-24T00:21:32.780' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 9, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (57, N'
<p>Việc bảo đảm của nhà nước đối với doanh nghiệp và chủ
sở hữu doanh nghiệp thể hiện ở :</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:21:32.873' AS DateTime), CAST(N'2017-07-24T00:21:40.543' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 10, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (58, N'
<p>Các quyền cơ bản,quan trọng nhất của DN:</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 11, 0, 5, CAST(N'2017-07-24T00:21:40.630' AS DateTime), CAST(N'2017-07-24T00:21:48.090' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 11, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (59, N'
<p>Nghĩa vụ của doanh nghiệp:</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 11, 0, 5, CAST(N'2017-07-24T00:21:48.180' AS DateTime), CAST(N'2017-07-24T00:21:52.703' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 12, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (60, N'
<p>Các hành vi nào là bị cấm đối với DN:</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 11, 0, 5, CAST(N'2017-07-24T00:21:52.790' AS DateTime), CAST(N'2017-07-24T00:21:59.243' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 13, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (61, N'
<p>Trường hợp nào thì được cấp lại giấy chứng nhận đăng
kí kinh doanh:</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 11, 0, 5, CAST(N'2017-07-24T00:21:59.337' AS DateTime), CAST(N'2017-07-24T00:22:03.837' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 14, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (62, N'
<p>Điều lệ công ty là:</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:22:03.927' AS DateTime), CAST(N'2017-07-24T00:22:09.150' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 15, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (63, N'
<p>Tư cách chấm dứt 
thành viên của DN trong các trường hợp nào?</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:22:09.243' AS DateTime), CAST(N'2017-07-24T00:22:12.053' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 16, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (64, N'
<p>Số lượng thành viên của công ty TNHH 2 thành viên trở
lên:</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 11, 0, 5, CAST(N'2017-07-24T00:22:12.150' AS DateTime), CAST(N'2017-07-24T00:22:14.547' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 17, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (65, N'
<p>Quyết định của HĐQT được thông qua tại cuộc họp khi :
(trong Cty TNHH 2 thành viên)</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:22:14.653' AS DateTime), CAST(N'2017-07-24T00:22:19.737' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 18, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (66, N'
<p>Theo quyết định
của Hội Đồng thành viên trong Cty TNHH 2 thành viên trở lên thì công ty có thể
tăng vốn điều lệ bằng các hình thức nào sau đây:</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:22:19.830' AS DateTime), CAST(N'2017-07-24T00:22:23.907' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 19, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (67, N'
<p>Lọai hình doanh
nghiệp nào chịu trách nhiệm vô hạn về số vốn:</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:22:23.997' AS DateTime), CAST(N'2017-07-24T00:22:25.523' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 20, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (68, N'
<p>Loại hình doanh nghiệp nào không được thay đổi vốn
điều lệ(nếu thay đổi phải thay đổi loại hình công ty):</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:22:25.620' AS DateTime), CAST(N'2017-07-24T00:22:27.603' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 21, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (69, N'
<p>Cty hợp danh có ít nhất bao nhiêu thành viên là chủ sở
hữu công ty :</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:22:27.700' AS DateTime), CAST(N'2017-07-24T00:22:29.530' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 22, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (70, N'
<p>Cty cổ phần có ít nhất bao nhiêu thành viên</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:22:29.627' AS DateTime), CAST(N'2017-07-24T00:22:31.547' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 23, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (71, N'
<p>Trong Cty cổ phần,các cổ đông sáng lập phải đăng kí ít
nhất:</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:22:31.720' AS DateTime), CAST(N'2017-07-24T00:22:34.960' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 24, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (72, N'
<p>Trong các DN sau đây,loại hình DN nào không được thuê
giám đốc:</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:22:35.057' AS DateTime), CAST(N'2017-07-24T00:22:37.250' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 25, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (73, N'
<p>Những loại hình DN nào sau đây có thể chuyển đổi lẫn
nhau</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:22:37.357' AS DateTime), CAST(N'2017-07-24T00:22:40.207' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 26, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (74, N'
<p>Đối với CTy TNHH 1 thành viên,chủ tịch hội đồng thành
viên do</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:22:40.313' AS DateTime), CAST(N'2017-07-24T00:22:42.840' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 27, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (75, N'
<p>Cty TNHH 1 thành viên sửa đổi điều lệ Cty,chuyển
nhượng 1 phần hoặc toàn bộ vốn điều lệ thì phải thông qua:</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:22:42.947' AS DateTime), CAST(N'2017-07-24T00:22:46.833' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 28, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (76, N'
<p>Kiểm soát viên của Cty TNHH 1 thành viên có số lượng
tử:</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:22:46.947' AS DateTime), CAST(N'2017-07-24T00:22:49.573' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 29, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (77, N'
<p>CTy TNHH 2 thành viên có thể có bao nhiêu thành viên :</p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 11, 0, 5, CAST(N'2017-07-24T00:22:49.680' AS DateTime), CAST(N'2017-07-24T00:22:52.207' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 30, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (78, N'
<p>Doanh nghiệp tư nhân là </p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:22:52.307' AS DateTime), CAST(N'2017-07-24T00:22:56.223' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 31, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (79, N'
<p>Đặc điểm pháp lý của doanh nghiệp tư
nhân </p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:22:56.327' AS DateTime), CAST(N'2017-07-24T00:23:00.770' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 32, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (80, N'
<p>Trường hợp nào sau đây được phép mở
doanh nghiệp tư nhân </p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 11, 0, 5, CAST(N'2017-07-24T00:23:00.873' AS DateTime), CAST(N'2017-07-24T00:23:05.477' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 33, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (81, N'
<p>Điều kiện nào không có trong điều kiện
đăng ký kinh doanh </p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:23:05.587' AS DateTime), CAST(N'2017-07-24T00:23:10.787' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 34, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (82, N'
<p>Khi
một doanh nghiệp muốn giải thể, trong thời hạn 7 ngày làm việc thông qua quyết
định giải thể, nếu pháp luật yêu cầu đăng báo điện tử hoặc 1 tờ báo thì phải
đăng </p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 11, 0, 5, CAST(N'2017-07-24T00:23:10.890' AS DateTime), CAST(N'2017-07-24T00:23:13.087' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 35, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (83, N'
<p>Đặc điểm hộ kinh doanh </p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 11, 0, 5, CAST(N'2017-07-24T00:23:13.187' AS DateTime), CAST(N'2017-07-24T00:23:16.737' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 36, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (84, N'
<p>Phát biểu nào sau đây là sai </p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:23:16.843' AS DateTime), CAST(N'2017-07-24T00:23:21.590' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 37, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (85, N'
<p>Những người nào không được đăng ký hộ kinh doanh </p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:23:21.697' AS DateTime), CAST(N'2017-07-24T00:23:24.393' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 38, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (86, N'
<p>Trong thời gian bao lâu, kể từ ngày nhận hồ sơ xin
đăng ký kinh doanh, nếu kô hợp lệ, cơ quan kinh doanh phải gửi văn bản yêu cầu
bổ sung sửa đổi cho người thành lập </p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 11, 0, 5, CAST(N'2017-07-24T00:23:24.503' AS DateTime), CAST(N'2017-07-24T00:23:26.217' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 39, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (87, N'
<p>Vào thời điểm nào, cơ quan đăng ký kinh doanh cấp
huyện gửi danh sách hộ kinh doanh đã đăng ký cho phòng đăng ký kinh doanh cấp
tỉnh, cơ quan thuế cùng cấp và sở chuyên ngành </p>
', 0, CAST(0.6000000000 AS Decimal(18, 10)), CAST(0.6000000000 AS Decimal(18, 10)), 0, 0, 5, CAST(N'2017-07-24T00:23:26.327' AS DateTime), CAST(N'2017-07-24T00:23:28.697' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.4000000000 AS Decimal(18, 10)), 40, 3, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (88, N'
<p>Tài nguyên khoáng
sản nước ta phong phú về loại hình, đa dạng về chủng loại là do</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:23:31.133' AS DateTime), CAST(N'2017-07-24T00:23:36.183' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 1, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (89, N'
<p>Ưu thế lớn nhất của
vị trí địa lí trong việc giao lưu buôn bán với nước ngoài của nước ta là</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:23:36.257' AS DateTime), CAST(N'2017-07-24T00:23:39.860' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 2, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (90, N'
<p>Nhân tố quan trọng
nhất làm cho thiên nhiên nước ta khác hẳn với các nước có cùng vĩ độ ở Tây Á,
Đông Phi, Tây Phi là</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:23:39.950' AS DateTime), CAST(N'2017-07-24T00:23:45.283' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 3, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (91, N'
<p>Ở Đồng bằng sông Cửu Long, về mùa cạn, nước
triều lấn mạnh làm gần 2/3 diện tích đồng bằng bị nhiễm mặn, là do </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:23:45.357' AS DateTime), CAST(N'2017-07-24T00:23:48.427' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 4, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (92, N'
<p>Vùng&nbsp;cực&nbsp;Nam&nbsp;Trung&nbsp;Bộ&nbsp;là&nbsp;nơi&nbsp;có&nbsp;nghề&nbsp;làm&nbsp;muối&nbsp;rất&nbsp;lí&nbsp;tưởng&nbsp;vì&nbsp;
</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:23:48.507' AS DateTime), CAST(N'2017-07-24T00:23:53.950' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 5, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (93, N'
<p>Nguyên nhân chính làm
phân hóa thiên nhiên nước ta theo vĩ độ (Bắc&mdash;Nam) là do sự tác động của</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:23:54.030' AS DateTime), CAST(N'2017-07-24T00:23:55.517' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 6, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (94, N'
<p>Đặc trưng của khí hậu miền Bắc và Đông bắc Bắc Bộ là</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:23:55.593' AS DateTime), CAST(N'2017-07-24T00:23:59.910' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 7, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (95, N'
<p>Nguyên nhân lớn nhất làm
cho tỉ lệ gia tăng tự nhiên của dân số nước ta giảm là do thực hiện </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:23:59.990' AS DateTime), CAST(N'2017-07-24T00:24:03.450' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 8, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (96, N'
<p>Đặc điểm nào sau đây không phải là đặc điểm của lao động
nước ta?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:24:03.530' AS DateTime), CAST(N'2017-07-24T00:24:08.203' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 9, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (97, N'
<p>Nhận định nào sau đây không đúng với đặc điểm phân bố dân
cư nước ta?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:24:08.307' AS DateTime), CAST(N'2017-07-24T00:24:13.893' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 10, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (98, N'
<p>Đặc điểm nào dưới đây không phải là đặc
điểm của nền nông nghiệp nhiệt đới ở nước ta?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:24:13.970' AS DateTime), CAST(N'2017-07-24T00:24:18.227' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 11, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (99, N'
<p>Ngư trường nào sau đây nằm gần các tỉnh cực
Nam Trung Bộ?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:24:18.323' AS DateTime), CAST(N'2017-07-24T00:24:22.560' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 12, 4, NULL, 1, 0)
GO
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (100, N'
<p>Nhận định nào sau đây không đúng với ngành
công nghiệp trọng điểm của nước ta?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:24:22.653' AS DateTime), CAST(N'2017-07-24T00:24:26.373' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 13, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (101, N'
<p>Trong cơ cấu giá trị sản xuất của ngành trồng
trọt hiện nay, nhóm cây có xu hướng tăng nhanh nhất về tỉ trọng là </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:24:26.467' AS DateTime), CAST(N'2017-07-24T00:24:28.587' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 14, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (102, N'
<p>Vùng có năng xuất lúa lớn nhất nước ta là</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:24:28.710' AS DateTime), CAST(N'2017-07-24T00:24:31.877' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 15, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (103, N'
<p>Tính mùa vụ trong sản xuất nông nghiệp ở nước
ta được khai thác tốt hơn không phải nhờ vào yếu tố nào sau đây?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:24:31.973' AS DateTime), CAST(N'2017-07-24T00:24:35.817' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 16, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (104, N'
<p>Điều kiện thiên nhiên thuận lợi cho hoạt động đánh bắt
hải sản của nước ta là </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:24:35.903' AS DateTime), CAST(N'2017-07-24T00:24:39.943' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 17, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (105, N'
<p>Khu vực có mức độ tập trung công nghiệp vào loại cao nhất
trong cả nước là </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:24:40.043' AS DateTime), CAST(N'2017-07-24T00:24:44.050' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 18, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (106, N'
<p>Vùng có tiềm năng thủy điện lớn nhất nước ta
là</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:24:44.150' AS DateTime), CAST(N'2017-07-24T00:24:46.867' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 19, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (107, N'
<p>Đặc điểm nào sau đây không đúng với đặc
điểm của ngành du lịch của nước ta?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:24:46.957' AS DateTime), CAST(N'2017-07-24T00:24:51.753' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 20, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (108, N'
<p>Khó khăn lớn nhất về tự nhiên của vùng Đông Nam Bộ là</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:24:51.843' AS DateTime), CAST(N'2017-07-24T00:24:56.400' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 21, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (109, N'
<p>Để khai thác lãnh thổ theo chiều sâu trong
công nghiệp ở Đông Nam Bộ, biện pháp quan trọng hàng đầu là tăng cường</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:24:56.513' AS DateTime), CAST(N'2017-07-24T00:24:59.833' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 22, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (110, N'
<p>Quá trình phát triển công nghiệp ở vùng Đông
Nam Bộ luôn cần quan tâm đến vấn đề</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:24:59.927' AS DateTime), CAST(N'2017-07-24T00:25:03.727' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 23, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (111, N'
<p>Khó khăn nào sau đây không phải là khó khăn
trong sản xuất nông nghiệp ở Trung du và miền núi Bắc Bộ?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:25:03.820' AS DateTime), CAST(N'2017-07-24T00:25:07.750' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 24, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (112, N'
<p>Trung du và miền núi Bắc
Bộ trồng được nhiều cây có nguồn gốc cận nhiệt và ôn đới chủ yếu do </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:25:07.857' AS DateTime), CAST(N'2017-07-24T00:25:11.500' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 25, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (113, N'
<p>50% diện tích rừng của Bắc Trung Bộ là </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:25:11.597' AS DateTime), CAST(N'2017-07-24T00:25:13.593' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 26, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (114, N'
<p>Nguyên nhân cơ bản làm cho cơ cấu công nghiệp
của Bắc Trung Bộ chưa thật định hình và sẽ còn nhiều biến đổi là </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:25:13.690' AS DateTime), CAST(N'2017-07-24T00:25:18.370' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 27, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (115, N'
<p>Điều kiện thuận lợi để
Tây Nguyên trở thành vùng chuyên canh cây công nghiệp lớn nhất nước ta là </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:25:18.470' AS DateTime), CAST(N'2017-07-24T00:25:23.947' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 28, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (116, N'
<p>Đặc điểm nào sau đây không đúng  với đặc điểm của Đồng bằng sông Hồng?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:25:24.043' AS DateTime), CAST(N'2017-07-24T00:25:29.117' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 29, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (117, N'
<p>Căn cứ vào Atlat Địa lí Việt Nam trang 6 -
7,  hãy cho biết hướng Tây Bắc &mdash; Đông Nam
là hướng của dãy núi nào dưới đây?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:25:29.217' AS DateTime), CAST(N'2017-07-24T00:25:31.067' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 30, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (118, N'
<p>Căn cứ vào Atlat Địa lí Việt Nam trang 15,
hãy cho biết đô thị nào sau đây là đô thị loại 1 ở nước ta? </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:25:31.160' AS DateTime), CAST(N'2017-07-24T00:25:33.080' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 31, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (119, N'
<p>Căn
cứ vào Atlat Địa lí Việt Nam trang 20, hãy cho biết tỉnh nào ở Duyên hải Nam
Trung Bộ có sản lượng thủy sản khai thác lớn hơn 50.000 tấn?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:25:33.183' AS DateTime), CAST(N'2017-07-24T00:25:35.137' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 32, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (120, N'
<p>Căn cứ vào Atlat Địa lí Việt Nam trang 22,
cho biết nhà máy nhiệt điện nào có công suất trên 1000MW ?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:25:35.230' AS DateTime), CAST(N'2017-07-24T00:25:37.130' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 33, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (121, N'
<p>Cho bảng số liệu: Diện tích, năng suất lúa
của Đồng bằng sông Cửu Long qua các năm. Căn cứ bảng số liệu trên, hay cho
biết nhận xét nào dưới đây không đúng với nội dung thể hiện ở bảng
số liệu trên?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:25:37.277' AS DateTime), CAST(N'2017-07-24T00:25:41.567' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 34, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (122, N'
<p>Cho biểu đồ: Cơ cấu giá trị sản xuất công
nghiệp theo thành phần kinh tế của nước ta</p>

<p align=center><img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Moi Truong\Dia Ly Viet Nam\Kinh Te Dia Ly\2017\7\24\Images\278b43c0-5b9d-4176-a608-28a45bf820bf.png"></p>

<p>Năm 1996                                                         Năm
2005</p>

<p>Căn
cứ vào biểu đồ, hãy cho biết nhận xét nào sau đây đúng về sự thay đổi cơ cấu
giá trị sản xuất công nghiệp của nước ta năm 1996 và năm 2005?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:25:41.663' AS DateTime), CAST(N'2017-07-24T00:25:47.140' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 35, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (123, N'
<p>Cho bảng số liệu: Tỉ lệ dân thành thị của
Việt Nam qua các năm (đơn vị %). Nhận xét nào sau đây không đúng với  nội dung thể hiện ở bảng số liệu trên?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:25:47.240' AS DateTime), CAST(N'2017-07-24T00:25:51.107' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 36, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (124, N'
<p>Căn cứ vào Atlat Địa lí Việt Nam trang 23, hãy
cho biết quốc lộ 1A không đi qua vùng kinh tế nào sau đây của nước ta?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:25:51.210' AS DateTime), CAST(N'2017-07-24T00:25:53.523' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 37, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (125, N'
<p>Cho bảng số liệu: Sản lượng điện, than và dầu thô của
nước ta giai đoạn 1995 &mdash; 2012. Để thể hiện tốc độ tăng trưởng sản lượng điện,
than và dầu thô của nước ta giai đoạn 1995 &mdash; 2012, biểu đồ nào sau đây thích
hợp nhất?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:25:53.627' AS DateTime), CAST(N'2017-07-24T00:25:55.287' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 38, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (126, N'
<p>Cho bảng số liệu: Thu nhập bình quân đầu người theo tháng ở Đông Nam Bộ và Tây Nguyên (theo
giá so sánh năm 1994). Nhận xét nào sau đây không đúng với nội dung
thể hiện ở bảng số liệu trên?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 6, CAST(N'2017-07-24T00:25:55.387' AS DateTime), CAST(N'2017-07-24T00:26:00.967' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 39, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (127, N'
<p>Tài nguyên khoáng
sản nước ta phong phú về loại hình, đa dạng về chủng loại là do</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:26:02.373' AS DateTime), CAST(N'2017-07-24T00:26:07.873' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 40, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (128, N'
<p>Ưu thế lớn nhất của
vị trí địa lí trong việc giao lưu buôn bán với nước ngoài của nước ta là</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:26:07.950' AS DateTime), CAST(N'2017-07-24T00:26:12.033' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 41, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (129, N'
<p>Nhân tố quan trọng
nhất làm cho thiên nhiên nước ta khác hẳn với các nước có cùng vĩ độ ở Tây Á,
Đông Phi, Tây Phi là</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:26:12.167' AS DateTime), CAST(N'2017-07-24T00:26:17.820' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 42, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (130, N'
<p>Ở Đồng bằng sông Cửu Long, về mùa cạn, nước
triều lấn mạnh làm gần 2/3 diện tích đồng bằng bị nhiễm mặn, là do </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:26:17.897' AS DateTime), CAST(N'2017-07-24T00:26:21.233' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 43, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (131, N'
<p>Vùng&nbsp;cực&nbsp;Nam&nbsp;Trung&nbsp;Bộ&nbsp;là&nbsp;nơi&nbsp;có&nbsp;nghề&nbsp;làm&nbsp;muối&nbsp;rất&nbsp;lí&nbsp;tưởng&nbsp;vì&nbsp;
</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:26:21.313' AS DateTime), CAST(N'2017-07-24T00:26:26.987' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 44, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (132, N'
<p>Nguyên nhân chính làm
phân hóa thiên nhiên nước ta theo vĩ độ (Bắc&mdash;Nam) là do sự tác động của</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:26:27.067' AS DateTime), CAST(N'2017-07-24T00:26:28.590' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 45, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (133, N'
<p>Đặc trưng của khí hậu miền Bắc và Đông bắc Bắc Bộ là</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:26:28.667' AS DateTime), CAST(N'2017-07-24T00:26:32.917' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 46, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (134, N'
<p>Nguyên nhân lớn nhất làm
cho tỉ lệ gia tăng tự nhiên của dân số nước ta giảm là do thực hiện </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:26:33.003' AS DateTime), CAST(N'2017-07-24T00:26:36.540' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 47, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (135, N'
<p>Đặc điểm nào sau đây không phải là đặc điểm của lao động
nước ta?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:26:36.623' AS DateTime), CAST(N'2017-07-24T00:26:41.213' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 48, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (136, N'
<p>Nhận định nào sau đây không đúng với đặc điểm phân bố dân
cư nước ta?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:26:41.363' AS DateTime), CAST(N'2017-07-24T00:26:47.063' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 49, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (137, N'
<p>Đặc điểm nào dưới đây không phải là đặc
điểm của nền nông nghiệp nhiệt đới ở nước ta?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:26:47.143' AS DateTime), CAST(N'2017-07-24T00:26:51.740' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 50, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (138, N'
<p>Ngư trường nào sau đây nằm gần các tỉnh cực
Nam Trung Bộ?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:26:51.823' AS DateTime), CAST(N'2017-07-24T00:26:55.760' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 51, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (139, N'
<p>Nhận định nào sau đây không đúng với ngành
công nghiệp trọng điểm của nước ta?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:26:55.857' AS DateTime), CAST(N'2017-07-24T00:26:59.610' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 52, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (140, N'
<p>Trong cơ cấu giá trị sản xuất của ngành trồng
trọt hiện nay, nhóm cây có xu hướng tăng nhanh nhất về tỉ trọng là </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:26:59.703' AS DateTime), CAST(N'2017-07-24T00:27:01.747' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 53, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (141, N'
<p>Vùng có năng xuất lúa lớn nhất nước ta là</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:27:01.833' AS DateTime), CAST(N'2017-07-24T00:27:04.947' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 54, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (142, N'
<p>Tính mùa vụ trong sản xuất nông nghiệp ở nước
ta được khai thác tốt hơn không phải nhờ vào yếu tố nào sau đây?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:27:05.047' AS DateTime), CAST(N'2017-07-24T00:27:08.783' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 55, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (143, N'
<p>Điều kiện thiên nhiên thuận lợi cho hoạt động đánh bắt
hải sản của nước ta là </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:27:08.873' AS DateTime), CAST(N'2017-07-24T00:27:12.917' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 56, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (144, N'
<p>Khu vực có mức độ tập trung công nghiệp vào loại cao nhất
trong cả nước là </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:27:13.010' AS DateTime), CAST(N'2017-07-24T00:27:17.213' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 57, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (145, N'
<p>Vùng có tiềm năng thủy điện lớn nhất nước ta
là</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:27:17.303' AS DateTime), CAST(N'2017-07-24T00:27:20.147' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 58, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (146, N'
<p>Đặc điểm nào sau đây không đúng với đặc
điểm của ngành du lịch của nước ta?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:27:20.240' AS DateTime), CAST(N'2017-07-24T00:27:25.007' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 59, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (147, N'
<p>Khó khăn lớn nhất về tự nhiên của vùng Đông Nam Bộ là</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:27:25.093' AS DateTime), CAST(N'2017-07-24T00:27:29.737' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 60, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (148, N'
<p>Để khai thác lãnh thổ theo chiều sâu trong
công nghiệp ở Đông Nam Bộ, biện pháp quan trọng hàng đầu là tăng cường</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:27:29.827' AS DateTime), CAST(N'2017-07-24T00:27:33.147' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 61, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (149, N'
<p>Quá trình phát triển công nghiệp ở vùng Đông
Nam Bộ luôn cần quan tâm đến vấn đề</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:27:33.240' AS DateTime), CAST(N'2017-07-24T00:27:36.893' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 62, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (150, N'
<p>Khó khăn nào sau đây không phải là khó khăn
trong sản xuất nông nghiệp ở Trung du và miền núi Bắc Bộ?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:27:36.983' AS DateTime), CAST(N'2017-07-24T00:27:40.840' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 63, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (151, N'
<p>Trung du và miền núi Bắc
Bộ trồng được nhiều cây có nguồn gốc cận nhiệt và ôn đới chủ yếu do </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:27:40.943' AS DateTime), CAST(N'2017-07-24T00:27:44.437' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 64, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (152, N'
<p>50% diện tích rừng của Bắc Trung Bộ là </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:27:44.530' AS DateTime), CAST(N'2017-07-24T00:27:46.480' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 65, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (153, N'
<p>Nguyên nhân cơ bản làm cho cơ cấu công nghiệp
của Bắc Trung Bộ chưa thật định hình và sẽ còn nhiều biến đổi là </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:27:46.610' AS DateTime), CAST(N'2017-07-24T00:27:51.370' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 66, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (154, N'
<p>Điều kiện thuận lợi để
Tây Nguyên trở thành vùng chuyên canh cây công nghiệp lớn nhất nước ta là </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:27:51.463' AS DateTime), CAST(N'2017-07-24T00:27:56.793' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 67, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (155, N'
<p>Đặc điểm nào sau đây không đúng  với đặc điểm của Đồng bằng sông Hồng?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:27:56.887' AS DateTime), CAST(N'2017-07-24T00:28:01.937' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 68, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (156, N'
<p>Căn cứ vào Atlat Địa lí Việt Nam trang 6 -
7,  hãy cho biết hướng Tây Bắc &mdash; Đông Nam
là hướng của dãy núi nào dưới đây?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:28:02.030' AS DateTime), CAST(N'2017-07-24T00:28:03.890' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 69, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (157, N'
<p>Căn cứ vào Atlat Địa lí Việt Nam trang 15,
hãy cho biết đô thị nào sau đây là đô thị loại 1 ở nước ta? </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:28:04.000' AS DateTime), CAST(N'2017-07-24T00:28:05.917' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 70, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (158, N'
<p>Căn
cứ vào Atlat Địa lí Việt Nam trang 20, hãy cho biết tỉnh nào ở Duyên hải Nam
Trung Bộ có sản lượng thủy sản khai thác lớn hơn 50.000 tấn?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:28:06.020' AS DateTime), CAST(N'2017-07-24T00:28:07.930' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 71, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (159, N'
<p>Căn cứ vào Atlat Địa lí Việt Nam trang 22,
cho biết nhà máy nhiệt điện nào có công suất trên 1000MW ?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:28:08.030' AS DateTime), CAST(N'2017-07-24T00:28:09.847' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 72, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (160, N'
<p>Cho bảng số liệu: Diện tích, năng suất lúa
của Đồng bằng sông Cửu Long qua các năm. Căn cứ bảng số liệu trên, hay cho
biết nhận xét nào dưới đây không đúng với nội dung thể hiện ở bảng
số liệu trên?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:28:09.953' AS DateTime), CAST(N'2017-07-24T00:28:14.270' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 73, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (161, N'
<p>Cho biểu đồ: Cơ cấu giá trị sản xuất công
nghiệp theo thành phần kinh tế của nước ta</p>

<p align=center><img 
src="D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Moi Truong\Dia Ly Viet Nam\Kinh Te Vung Dong Nam Bo\2017\7\24\Images\77a2a5c1-8e5d-4785-9716-6a218667cba8.png"></p>

<p>Năm 1996                                                         Năm
2005</p>

<p>Căn
cứ vào biểu đồ, hãy cho biết nhận xét nào sau đây đúng về sự thay đổi cơ cấu
giá trị sản xuất công nghiệp của nước ta năm 1996 và năm 2005?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:28:14.377' AS DateTime), CAST(N'2017-07-24T00:28:20.483' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 74, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (162, N'
<p>Cho bảng số liệu: Tỉ lệ dân thành thị của
Việt Nam qua các năm (đơn vị %). Nhận xét nào sau đây không đúng với  nội dung thể hiện ở bảng số liệu trên?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:28:20.587' AS DateTime), CAST(N'2017-07-24T00:28:24.750' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 75, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (163, N'
<p>Căn cứ vào Atlat Địa lí Việt Nam trang 23, hãy
cho biết quốc lộ 1A không đi qua vùng kinh tế nào sau đây của nước ta?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:28:24.887' AS DateTime), CAST(N'2017-07-24T00:28:27.253' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 76, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (164, N'
<p>Cho bảng số liệu: Sản lượng điện, than và dầu thô của
nước ta giai đoạn 1995 &mdash; 2012. Để thể hiện tốc độ tăng trưởng sản lượng điện,
than và dầu thô của nước ta giai đoạn 1995 &mdash; 2012, biểu đồ nào sau đây thích
hợp nhất?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:28:27.353' AS DateTime), CAST(N'2017-07-24T00:28:28.980' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 77, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (165, N'
<p>Cho bảng số liệu: Thu nhập bình quân đầu người theo tháng ở Đông Nam Bộ và Tây Nguyên (theo
giá so sánh năm 1994). Nhận xét nào sau đây không đúng với nội dung
thể hiện ở bảng số liệu trên?</p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 7, CAST(N'2017-07-24T00:28:29.073' AS DateTime), CAST(N'2017-07-24T00:28:34.330' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 78, 4, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (166, N'
<p><i>Choose the word whose
underlined part is pronounced differently from the rest</i></p>

<p><i>in the same line.</i></p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 8, CAST(N'2017-07-24T00:28:37.843' AS DateTime), CAST(N'2017-07-24T00:28:43.843' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, 166, 0, CAST(0.5000000000 AS Decimal(18, 10)), 1, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (167, N'<p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.</p>', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 8, CAST(N'2017-07-24T00:28:38.333' AS DateTime), CAST(N'2017-07-24T00:28:38.390' AS DateTime), CAST(0.0000000000 AS Decimal(18, 10)), 0, 166, 0, CAST(0.0000000000 AS Decimal(18, 10)), 2, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (168, N'<p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.</p>', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 8, CAST(N'2017-07-24T00:28:39.483' AS DateTime), CAST(N'2017-07-24T00:28:39.547' AS DateTime), CAST(0.0000000000 AS Decimal(18, 10)), 0, 166, 0, CAST(0.0000000000 AS Decimal(18, 10)), 3, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (169, N'<p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.</p>', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 8, CAST(N'2017-07-24T00:28:40.620' AS DateTime), CAST(N'2017-07-24T00:28:40.680' AS DateTime), CAST(0.0000000000 AS Decimal(18, 10)), 0, 166, 0, CAST(0.0000000000 AS Decimal(18, 10)), 4, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (170, N'<p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.</p>', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 8, CAST(N'2017-07-24T00:28:41.750' AS DateTime), CAST(N'2017-07-24T00:28:41.813' AS DateTime), CAST(0.0000000000 AS Decimal(18, 10)), 0, 166, 0, CAST(0.0000000000 AS Decimal(18, 10)), 5, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (171, N'<p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.</p>', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 8, CAST(N'2017-07-24T00:28:42.870' AS DateTime), CAST(N'2017-07-24T00:28:42.930' AS DateTime), CAST(0.0000000000 AS Decimal(18, 10)), 0, 166, 0, CAST(0.0000000000 AS Decimal(18, 10)), 6, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (172, N'
<p> <audio>D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Ngoai Ngu\Tieng Anh 1\Part Ii Question-response\2017\7\24\Audio\d740280d-4b9f-4480-a94e-76e28d8a52a8.mp3</audio></p>
', 0, CAST(0.0000000000 AS Decimal(18, 10)), CAST(0.0000000000 AS Decimal(18, 10)), 0, 0, 9, CAST(N'2017-07-24T00:28:46.077' AS DateTime), CAST(N'2017-07-24T00:28:47.960' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 1, CAST(0.6000000000 AS Decimal(18, 10)), 7, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (173, N'
<p> <audio>D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Ngoai Ngu\Tieng Anh 1\Part Ii Question-response\2017\7\24\Audio\b8bf104b-335d-4b63-839a-7cb67d160ca1.mp3</audio></p>
', 0, CAST(0.1000000000 AS Decimal(18, 10)), CAST(0.1000000000 AS Decimal(18, 10)), 0, 0, 9, CAST(N'2017-07-24T00:28:48.010' AS DateTime), CAST(N'2017-07-24T00:28:49.090' AS DateTime), CAST(0.4000000000 AS Decimal(18, 10)), 0, -1, 1, CAST(0.0000000000 AS Decimal(18, 10)), 8, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (174, N'
<p>using for Number  &lt;bd&gt; &mdash; &lt;kt&gt;</p>

<p><audio>D:\GoogleDrive\Projects\ExaminationSystem\client\resources\ObjectiveTest\Files\Khoa Ngoai Ngu\Tieng Anh 1\Part Iii Conversations\2017\7\24\Audio\db966cd8-778a-43db-aa2d-3cc57bc82d74.mp3</audio></p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 10, CAST(N'2017-07-24T00:28:51.450' AS DateTime), CAST(N'2017-07-24T00:28:55.817' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, 174, 1, CAST(0.5000000000 AS Decimal(18, 10)), 9, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (175, N'
<p>When will the speakers meet?</p>
', 0, CAST(0.2000000000 AS Decimal(18, 10)), CAST(0.2000000000 AS Decimal(18, 10)), 0, 0, 10, CAST(N'2017-07-24T00:28:51.940' AS DateTime), CAST(N'2017-07-24T00:28:52.003' AS DateTime), CAST(0.0000000000 AS Decimal(18, 10)), 0, 174, 0, CAST(0.0000000000 AS Decimal(18, 10)), 10, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (176, N'
<p> Where
will they meet?</p>
', 0, CAST(0.4000000000 AS Decimal(18, 10)), CAST(0.4000000000 AS Decimal(18, 10)), 0, 0, 10, CAST(N'2017-07-24T00:28:53.877' AS DateTime), CAST(N'2017-07-24T00:28:53.950' AS DateTime), CAST(0.0000000000 AS Decimal(18, 10)), 0, 174, 0, CAST(0.0000000000 AS Decimal(18, 10)), 11, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (177, N'
<p>Questions
50 &mdash; 75 are incomplete sentences. Four words or phrases, marked A., B., C., D.,
are given beneath each sentence. You are to choose the one word or phrase that
best completes the sentence. Then, on your answer sheet, find the number of the
question and mark your answer &lt;bt&gt; -
&lt;kt&gt;</p>
', 0, CAST(0.0000000000 AS Decimal(18, 10)), CAST(0.0000000000 AS Decimal(18, 10)), 0, 0, 10, CAST(N'2017-07-24T00:28:55.850' AS DateTime), CAST(N'2017-07-24T00:28:58.963' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, 177, 0, CAST(0.5000000000 AS Decimal(18, 10)), 12, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (178, N'
<p>Our goal is to turn ……………..   into success.</p>
', 0, CAST(0.2700000000 AS Decimal(18, 10)), CAST(0.2700000000 AS Decimal(18, 10)), 0, 0, 10, CAST(N'2017-07-24T00:28:56.077' AS DateTime), CAST(N'2017-07-24T00:28:56.140' AS DateTime), CAST(0.0000000000 AS Decimal(18, 10)), 0, 177, 0, CAST(0.0000000000 AS Decimal(18, 10)), 13, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (179, N'
<p>The plane will be landing
…………... Chicago in twenty minutes.</p>
', 0, CAST(0.3000000000 AS Decimal(18, 10)), CAST(0.3000000000 AS Decimal(18, 10)), 0, 0, 10, CAST(N'2017-07-24T00:28:57.073' AS DateTime), CAST(N'2017-07-24T00:28:57.140' AS DateTime), CAST(0.0000000000 AS Decimal(18, 10)), 0, 177, 0, CAST(0.0000000000 AS Decimal(18, 10)), 14, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (180, N'
<p>The seminar was canceled because
the invitations were not …………... in time.</p>
', 0, CAST(0.2500000000 AS Decimal(18, 10)), CAST(0.2500000000 AS Decimal(18, 10)), 0, 0, 10, CAST(N'2017-07-24T00:28:58.070' AS DateTime), CAST(N'2017-07-24T00:28:58.137' AS DateTime), CAST(0.0000000000 AS Decimal(18, 10)), 0, 177, 0, CAST(0.0000000000 AS Decimal(18, 10)), 15, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (181, N'
<p>Vietnamese generally shake hands when
getting and parting. Using both hands shows respect as does a !1!……. bow of the
head. In rural areas, elderly people who do not extend their hand are greeted
with a bow. Women are more !2!……. to bow the head than to shake hands.
Vietnamese names begin with the family name and are !3! ……… by a given name.
People address !4! ………. by their given names, but add a title that indicates
their received !5! …….. to the other person. These titles are family related
rather than professional. Among colleagues, for example, the !6! ……… of the two
might combine the given name with the title of &ldquo;Anh&rdquo; ( Older Brother ). A/n !7!
………. greeting combined with the given name and title &ldquo;Xin chao&rdquo; ( Hello ).
Classifiers for gender and familiarity are also combined with the greeting. In
formal meetings, business cards are</p>

<p>sometimes !8! ………. on greeting.</p>

<p>Vietnamese people have a strong !9! ………
of hospitality and feel embarrassed if they cannot show their guests full
respect by preparing for their arrival. Therefore, it is !10! ..... to visit
someone without having been invited. Gifts are not required, but are
appreciated. Flowers, incense, or tea may be proper gifts for the hosts. Hosts
also appreciate a small gift for their children or elderly parents.</p>
', 0, CAST(0.0000000000 AS Decimal(18, 10)), CAST(0.0000000000 AS Decimal(18, 10)), 0, 0, 10, CAST(N'2017-07-24T00:28:58.997' AS DateTime), CAST(N'2017-07-24T00:29:10.630' AS DateTime), CAST(0.0000000000 AS Decimal(18, 10)), 0, 181, 0, CAST(0.5000000000 AS Decimal(18, 10)), 16, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (182, N'<p>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.</p>', 0, CAST(0.2500000000 AS Decimal(18, 10)), CAST(0.2500000000 AS Decimal(18, 10)), 0, 0, 10, CAST(N'2017-07-24T00:28:59.373' AS DateTime), CAST(N'2017-07-24T00:28:59.433' AS DateTime), CAST(0.0000000000 AS Decimal(18, 10)), 0, 181, 0, CAST(0.0000000000 AS Decimal(18, 10)), 17, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (183, N'<p>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.</p>', 0, CAST(0.2500000000 AS Decimal(18, 10)), CAST(0.2500000000 AS Decimal(18, 10)), 0, 0, 10, CAST(N'2017-07-24T00:29:00.523' AS DateTime), CAST(N'2017-07-24T00:29:00.583' AS DateTime), CAST(0.0000000000 AS Decimal(18, 10)), 0, 181, 0, CAST(0.0000000000 AS Decimal(18, 10)), 18, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (184, N'<p>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.</p>', 0, CAST(0.2500000000 AS Decimal(18, 10)), CAST(0.2500000000 AS Decimal(18, 10)), 0, 0, 10, CAST(N'2017-07-24T00:29:01.657' AS DateTime), CAST(N'2017-07-24T00:29:01.717' AS DateTime), CAST(0.0000000000 AS Decimal(18, 10)), 0, 181, 0, CAST(0.0000000000 AS Decimal(18, 10)), 19, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (185, N'<p>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.</p>', 0, CAST(0.2500000000 AS Decimal(18, 10)), CAST(0.2500000000 AS Decimal(18, 10)), 0, 0, 10, CAST(N'2017-07-24T00:29:02.810' AS DateTime), CAST(N'2017-07-24T00:29:02.870' AS DateTime), CAST(0.0000000000 AS Decimal(18, 10)), 0, 181, 0, CAST(0.0000000000 AS Decimal(18, 10)), 20, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (186, N'<p>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.</p>', 0, CAST(0.2500000000 AS Decimal(18, 10)), CAST(0.2500000000 AS Decimal(18, 10)), 0, 0, 10, CAST(N'2017-07-24T00:29:04.227' AS DateTime), CAST(N'2017-07-24T00:29:04.290' AS DateTime), CAST(0.0000000000 AS Decimal(18, 10)), 0, 181, 0, CAST(0.0000000000 AS Decimal(18, 10)), 21, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (187, N'<p>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.</p>', 0, CAST(0.2500000000 AS Decimal(18, 10)), CAST(0.2500000000 AS Decimal(18, 10)), 0, 0, 10, CAST(N'2017-07-24T00:29:05.303' AS DateTime), CAST(N'2017-07-24T00:29:05.363' AS DateTime), CAST(0.0000000000 AS Decimal(18, 10)), 0, 181, 0, CAST(0.0000000000 AS Decimal(18, 10)), 22, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (188, N'<p>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.</p>', 0, CAST(0.2500000000 AS Decimal(18, 10)), CAST(0.2500000000 AS Decimal(18, 10)), 0, 0, 10, CAST(N'2017-07-24T00:29:06.450' AS DateTime), CAST(N'2017-07-24T00:29:06.510' AS DateTime), CAST(0.0000000000 AS Decimal(18, 10)), 0, 181, 0, CAST(0.0000000000 AS Decimal(18, 10)), 23, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (189, N'<p>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.</p>', 0, CAST(0.2500000000 AS Decimal(18, 10)), CAST(0.2500000000 AS Decimal(18, 10)), 0, 0, 10, CAST(N'2017-07-24T00:29:07.480' AS DateTime), CAST(N'2017-07-24T00:29:07.540' AS DateTime), CAST(0.0000000000 AS Decimal(18, 10)), 0, 181, 0, CAST(0.0000000000 AS Decimal(18, 10)), 24, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (190, N'<p>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.</p>', 0, CAST(0.2500000000 AS Decimal(18, 10)), CAST(0.2500000000 AS Decimal(18, 10)), 0, 0, 10, CAST(N'2017-07-24T00:29:08.583' AS DateTime), CAST(N'2017-07-24T00:29:08.647' AS DateTime), CAST(0.0000000000 AS Decimal(18, 10)), 0, 181, 0, CAST(0.0000000000 AS Decimal(18, 10)), 25, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (191, N'<p>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.</p>', 0, CAST(0.2500000000 AS Decimal(18, 10)), CAST(0.2500000000 AS Decimal(18, 10)), 0, 0, 10, CAST(N'2017-07-24T00:29:09.663' AS DateTime), CAST(N'2017-07-24T00:29:09.727' AS DateTime), CAST(0.0000000000 AS Decimal(18, 10)), 0, 181, 0, CAST(0.0000000000 AS Decimal(18, 10)), 26, 5, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (192, N'', 0, CAST(0.0000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:29:13.920' AS DateTime), CAST(N'1753-01-01T12:00:00.000' AS DateTime), CAST(0.0000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.0000000000 AS Decimal(18, 10)), 1, 7, NULL, 0, 1)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (193, N'
<p>Câu 1:  Trong bảng tính MS Excel 2007, tại ô A1 có
giá trị số 16, tại ô B1 gõ vào công thức =SQRT(A1) thì nhận được kết quả là: </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:29:13.967' AS DateTime), CAST(N'2017-07-24T00:29:15.663' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 2, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (194, N'
<p>Câu 2:  Trong bảng tính MS Excel 2007, hàm nào sau
đây cho phép đếm các giá trị thỏa mãn một điều kiện cho trước: </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:29:15.737' AS DateTime), CAST(N'2017-07-24T00:29:16.960' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 3, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (195, N'
<p>Câu 3:  Trong bảng tính MS Excel 2007, công thức =
Lower(&ldquo;ht CNTT&rdquo;) cho kết quả: </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:29:17.033' AS DateTime), CAST(N'2017-07-24T00:29:18.643' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 4, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (196, N'
<p>Câu 4:  Trong bảng tính MS Excel 2007, công thức =Right(&ldquo;TTTTTH&rdquo;,2)
cho kết quả: </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:29:18.737' AS DateTime), CAST(N'2017-07-24T00:29:20.007' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 5, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (197, N'
<p>Câu 5:  Trong bảng tính MS Excel 2007, công thức
=Mid(&ldquo;m1234&rdquo;,2,3) cho kết quả: </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:29:20.087' AS DateTime), CAST(N'2017-07-24T00:29:21.813' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 6, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (198, N'
<p>Câu 6:  Trong bảng tính MS Excel 2007, tại ô A2 có
giá trị số 10, tại ô B2 gõ công thức =PRODUCT(A2,5) cho kết quả: </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:29:21.883' AS DateTime), CAST(N'2017-07-24T00:29:23.263' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 7, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (199, N'
<p>Câu 7:  Đáp án nào sau đây đúng? Khi nhập dữ liệu vào
bảng tính Excel thì: </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:29:23.340' AS DateTime), CAST(N'2017-07-24T00:29:27.443' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 8, 7, NULL, 1, 0)
GO
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (200, N'
<p>Câu 8:  Trong bảng tính MS Excel 2007, tại ô A2 có
giá trị chuỗi &ldquo;a&rdquo;, tại ô B2 gõ công thức =5/A2 cho kết quả: </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:29:27.530' AS DateTime), CAST(N'2017-07-24T00:29:29.360' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 9, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (201, N'
<p>Câu 9:  Trong các dạng địa chỉ sau đây, địa chỉ nào
là địa chỉ tuyệt đối tại cột, tương đối tại hàng? </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:29:29.443' AS DateTime), CAST(N'2017-07-24T00:29:32.457' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 10, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (202, N'
<p>Câu 10:  Trong bảng tính MS Excel 2007, tại ô A1 có
giá trị chuỗi 2014, tại ô B1 gõ công thức =Len(A1) cho kết quả: </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:29:32.533' AS DateTime), CAST(N'2017-07-24T00:29:33.963' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 11, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (203, N'
<p>Câu 11:  Trong bảng tính MS Excel 2007, để ẩn cột, ta
thực hiện: </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:29:34.043' AS DateTime), CAST(N'2017-07-24T00:29:38.680' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 12, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (204, N'
<p>Câu 12:  Trong bảng tính MS Excel 2007, để thiết lập
nhãn in, ta thực hiện: </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:29:38.760' AS DateTime), CAST(N'2017-07-24T00:29:42.037' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 13, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (205, N'
<p>Câu 13:  Trong bảng tính MS Excel 2007, để chèn hình ảnh,
ta thực hiện: </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:29:42.117' AS DateTime), CAST(N'2017-07-24T00:29:44.173' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 14, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (206, N'
<p>Câu 14:  Trong bảng tính MS Excel 2007, để tách dữ liệu
trong một ô thành hai hoặc nhiều ô, ta thực hiện: </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:29:44.257' AS DateTime), CAST(N'2017-07-24T00:29:47.457' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 15, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (207, N'
<p>Câu 15:  Trong bảng tính MS Excel 2007, để thay đổi kiểu
trang in ngang hoặc dọc, ta thực hiện: </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:29:47.540' AS DateTime), CAST(N'2017-07-24T00:29:51.013' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 16, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (208, N'
<p>Câu 16:  Trong bảng tính MS Excel 2007, để giữ cố định
hàng hoặc cột trong cửa sổ soạn thảo, ta đánh dấu hàng hoặc cột, chọn: </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:29:51.103' AS DateTime), CAST(N'2017-07-24T00:29:53.610' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 17, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (209, N'
<p>Câu 17:  Trong bảng tính MS Excel 2007, tại ô A2 có
giá trị TINHOC, tại ô B2 gõ công thức =6/VALUE(A2) cho kết quả: </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:29:53.693' AS DateTime), CAST(N'2017-07-24T00:29:55.377' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 18, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (210, N'
<p>Câu 18:  Trong bảng tính MS Excel 2007, điều kiện
trong hàm IF được phát biểu dưới dạng một phép so sánh. Khi cần so sánh đồng thời
nhiều điều kiện thì sử dụng công thức nào? </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:29:55.463' AS DateTime), CAST(N'2017-07-24T00:29:56.660' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 19, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (211, N'
<p>Câu 19:  Trong bảng tính MS Excel 2007, tại ô A1 có
giá trị chuỗi &ldquo;Excel&rdquo;, ô B1 có giá trị số 2007, tại ô C1 gõ công thức =A1+B1
cho kết quả: </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:29:56.747' AS DateTime), CAST(N'2017-07-24T00:29:58.127' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 20, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (212, N'
<p>Câu 20:  Trong bảng tính MS Excel 2007, hộp thoại
Chart Wizard cho phép xác định các thông tin nào sau đây cho biểu đồ: </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:29:58.217' AS DateTime), CAST(N'2017-07-24T00:30:00.487' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 21, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (213, N'
<p>Câu 21:  Trong bảng tính MS Excel 2007, tại ô A2 có
giá trị chuỗi 2008, tại ô B2 gõ vào công thức =VALUE(A2) cho kết quả: </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:30:00.570' AS DateTime), CAST(N'2017-07-24T00:30:02.787' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 22, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (214, N'
<p>Câu 22:  Trong bảng tính MS Excel 2007, tại ô A2 gõ
vào công thức =MAX(3,14,-25,5) cho kết quả: </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:30:02.880' AS DateTime), CAST(N'2017-07-24T00:30:04.217' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 23, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (215, N'
<p>Câu 23:  Trong bảng tính MS Excel 2007, công thức
=Upper(&ldquo;TT TTTH&rdquo;) cho kết quả: </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:30:04.307' AS DateTime), CAST(N'2017-07-24T00:30:05.670' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 24, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (216, N'
<p>Câu 24:  Trong bảng tính MS Excel 2007, công thức
=Mod(26,7) cho kết quả: </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:30:05.760' AS DateTime), CAST(N'2017-07-24T00:30:07.000' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 25, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (217, N'
<p>Câu 25:  Trong MS Excel 2007, giả sử tại ô B5 có công thức
= A1+$B$2+C$3. Sau khi sao chép công thức đó từ ô B5 đến ô D8 sẽ có công thức </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:30:07.093' AS DateTime), CAST(N'2017-07-24T00:30:10.700' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 26, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (218, N'
<p>Câu 26:  Trong MS Excel 2007, công thức sau trả về giá
trị nào: = IF(5 &gt;= 5, &quot;Không được tuyển dụng&quot;) </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:30:10.790' AS DateTime), CAST(N'2017-07-24T00:30:13.703' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 27, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (219, N'
<p>Câu 27:  Trong MS Excel 2007, để ghép 2 xâu ký tự
&quot;TRAN VAN&quot; và &quot;AN&quot; thành xâu ký tự mới là &quot;TRAN VAN
AN&quot;, tư sử dụng công thức: </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:30:13.797' AS DateTime), CAST(N'2017-07-24T00:30:16.710' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 28, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (220, N'
<p>Câu 28:  Trong MS Excel 2007, công thức sau sẽ trả về
kết quả nào: = UPPER(&quot;tran thi Hoa&quot;) </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:30:16.803' AS DateTime), CAST(N'2017-07-24T00:30:18.560' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 29, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (221, N'
<p>Câu 29:  Trong MS Excel 2007, hàm VLOOKUP() dùng để
tìm kiếm giá trị: </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:30:18.657' AS DateTime), CAST(N'2017-07-24T00:30:22.853' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 30, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (222, N'
<p>Câu 30:  Trong MS Excel 2007, công thức sau sẽ tả về kết
quả nào: = ROUND(7475.47, -2) </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:30:22.943' AS DateTime), CAST(N'2017-07-24T00:30:24.343' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 31, 7, NULL, 1, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (223, N'
<p>Câu 31:  Trong MS Excel 2007, công thức sau trả về giá
trị nào: = LEN(@TRAN_THI_THU_THANH@) </p>
', 0, CAST(0.5000000000 AS Decimal(18, 10)), CAST(0.5000000000 AS Decimal(18, 10)), 0, 0, 11, CAST(N'2017-07-24T00:30:24.443' AS DateTime), CAST(N'2017-07-24T00:30:26.417' AS DateTime), CAST(0.5000000000 AS Decimal(18, 10)), 0, -1, 0, CAST(0.5000000000 AS Decimal(18, 10)), 32, 7, NULL, 1, 0)
SET IDENTITY_INSERT [dbo].[Questions] OFF
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (1, 2, 18, 6, 1, CAST(N'2017-07-24T08:23:15.960' AS DateTime), CAST(N'2017-07-24T08:23:15.960' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (1, 5, 38, 20, 0, CAST(N'2017-07-24T08:23:15.963' AS DateTime), CAST(N'2017-07-24T08:23:15.963' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (1, 6, 0, 24, 0, CAST(N'2017-07-24T08:23:15.947' AS DateTime), CAST(N'2017-07-24T08:23:15.947' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (1, 7, 20, NULL, 0, CAST(N'2017-07-24T08:23:15.960' AS DateTime), CAST(N'2017-07-24T08:23:15.960' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (1, 8, 6, 29, 0, CAST(N'2017-07-24T08:23:15.953' AS DateTime), CAST(N'2017-07-24T08:23:15.953' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (1, 9, 30, 34, 0, CAST(N'2017-07-24T08:23:15.963' AS DateTime), CAST(N'2017-07-24T08:23:15.963' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (1, 10, 24, 38, 1, CAST(N'2017-07-24T08:23:15.963' AS DateTime), CAST(N'2017-07-24T08:23:15.963' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (1, 11, 4, 42, 0, CAST(N'2017-07-24T08:23:15.953' AS DateTime), CAST(N'2017-07-24T08:23:15.953' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (1, 14, 36, 56, 0, CAST(N'2017-07-24T08:23:15.963' AS DateTime), CAST(N'2017-07-24T08:23:15.963' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (1, 15, 12, 57, 0, CAST(N'2017-07-24T08:23:15.960' AS DateTime), CAST(N'2017-07-24T08:23:15.960' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (1, 16, 22, 62, 1, CAST(N'2017-07-24T08:23:15.960' AS DateTime), CAST(N'2017-07-24T08:23:15.960' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (1, 18, 34, 71, 0, CAST(N'2017-07-24T08:23:15.963' AS DateTime), CAST(N'2017-07-24T08:23:15.963' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (1, 21, 10, NULL, 0, CAST(N'2017-07-24T08:23:15.960' AS DateTime), CAST(N'2017-07-24T08:23:15.960' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (1, 25, 14, 97, 0, CAST(N'2017-07-24T08:23:15.960' AS DateTime), CAST(N'2017-07-24T08:23:15.960' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (1, 26, 26, NULL, 0, CAST(N'2017-07-24T08:23:15.963' AS DateTime), CAST(N'2017-07-24T08:23:15.963' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (1, 27, 28, NULL, 0, CAST(N'2017-07-24T08:23:15.963' AS DateTime), CAST(N'2017-07-24T08:23:15.963' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (1, 29, 32, NULL, 0, CAST(N'2017-07-24T08:23:15.963' AS DateTime), CAST(N'2017-07-24T08:23:15.963' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (1, 31, 8, 122, 1, CAST(N'2017-07-24T08:23:15.960' AS DateTime), CAST(N'2017-07-24T08:23:15.960' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (1, 33, 2, 130, 1, CAST(N'2017-07-24T08:23:15.953' AS DateTime), CAST(N'2017-07-24T08:23:15.953' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (1, 38, 16, 149, 1, CAST(N'2017-07-24T08:23:15.960' AS DateTime), CAST(N'2017-07-24T08:23:15.960' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (2, 53, 14, 210, 1, CAST(N'2017-07-24T09:47:29.737' AS DateTime), CAST(N'2017-07-24T09:47:29.737' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (2, 54, 16, 215, 0, CAST(N'2017-07-24T09:47:29.737' AS DateTime), CAST(N'2017-07-24T09:47:29.737' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (2, 56, 2, 222, 0, CAST(N'2017-07-24T09:47:29.733' AS DateTime), CAST(N'2017-07-24T09:47:29.733' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (2, 58, 0, 230, 0, CAST(N'2017-07-24T09:47:29.710' AS DateTime), CAST(N'2017-07-24T09:47:29.710' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (2, 59, 22, 233, 0, CAST(N'2017-07-24T09:47:29.740' AS DateTime), CAST(N'2017-07-24T09:47:29.740' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (2, 60, 18, 238, 0, CAST(N'2017-07-24T09:47:29.737' AS DateTime), CAST(N'2017-07-24T09:47:29.737' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (2, 61, 6, 242, 0, CAST(N'2017-07-24T09:47:29.733' AS DateTime), CAST(N'2017-07-24T09:47:29.733' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (2, 64, 8, NULL, 0, CAST(N'2017-07-24T09:47:29.733' AS DateTime), CAST(N'2017-07-24T09:47:29.733' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (2, 77, 12, 306, 0, CAST(N'2017-07-24T09:47:29.737' AS DateTime), CAST(N'2017-07-24T09:47:29.737' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (2, 80, 24, 317, 0, CAST(N'2017-07-24T09:47:29.740' AS DateTime), CAST(N'2017-07-24T09:47:29.740' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (2, 82, 20, 325, 0, CAST(N'2017-07-24T09:47:29.737' AS DateTime), CAST(N'2017-07-24T09:47:29.737' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (2, 83, 4, NULL, 0, CAST(N'2017-07-24T09:47:29.733' AS DateTime), CAST(N'2017-07-24T09:47:29.733' AS DateTime), NULL, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop]) VALUES (2, 86, 10, NULL, 0, CAST(N'2017-07-24T09:47:29.733' AS DateTime), CAST(N'2017-07-24T09:47:29.733' AS DateTime), NULL, 0)
SET IDENTITY_INSERT [dbo].[QuestionSheets] ON 

INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId]) VALUES (1, N'123123123', CAST(N'2017-07-24T08:23:15.930' AS DateTime), 1, 0, 0, 0, NULL, CAST(1.50 AS Decimal(18, 2)), 6, 40, NULL, 0)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId]) VALUES (2, N'22112211', CAST(N'2017-07-24T09:47:29.677' AS DateTime), 1, 1, 0, 0, NULL, CAST(0.50 AS Decimal(18, 2)), 1, 25, NULL, 0)
SET IDENTITY_INSERT [dbo].[QuestionSheets] OFF
SET IDENTITY_INSERT [dbo].[Shifts] ON 

INSERT [dbo].[Shifts] ([Id], [Name], [StartTime], [EndTime], [Activated], [ActivateTime], [Duration], [Ended], [EndDate], [ExamId], [QuestionSheetCreated], [Desktop], [Deleted]) VALUES (1, N'24-Jul-17 - 9:30 - 90', CAST(N'2017-07-28T09:30:00.000' AS DateTime), CAST(N'2017-08-30T00:40:00.000' AS DateTime), 1, NULL, 90, 0, NULL, 1, 1, 0, 0)
INSERT [dbo].[Shifts] ([Id], [Name], [StartTime], [EndTime], [Activated], [ActivateTime], [Duration], [Ended], [EndDate], [ExamId], [QuestionSheetCreated], [Desktop], [Deleted]) VALUES (2, N'24-Jul-17 - 10:30 - 60', CAST(N'2017-07-28T10:30:00.000' AS DateTime), CAST(N'2017-08-30T00:40:00.000' AS DateTime), 1, NULL, 60, 0, NULL, 1, 1, 0, 0)
SET IDENTITY_INSERT [dbo].[Shifts] OFF
SET IDENTITY_INSERT [dbo].[ShiftSubjects] ON 

INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId]) VALUES (1, 1, 1, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId]) VALUES (2, 2, 3, 2)
SET IDENTITY_INSERT [dbo].[ShiftSubjects] OFF
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut]) VALUES (1, 1, 1, 1, NULL, NULL)
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut]) VALUES (2, 2, 2, 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Students] ON 

INSERT [dbo].[Students] ([Id], [Code], [Name]) VALUES (1, N'123123123', N'Trần Văn B')
INSERT [dbo].[Students] ([Id], [Code], [Name]) VALUES (2, N'22112211', N'Nguyễn Văn A')
SET IDENTITY_INSERT [dbo].[Students] OFF
SET IDENTITY_INSERT [dbo].[Subjects] ON 

INSERT [dbo].[Subjects] ([Id], [Code], [Name], [FacultyId], [ManagementOrder], [Validated], [Deleted]) VALUES (1, N'1', N'Hoa Hoc', 1, 1, 1, 0)
INSERT [dbo].[Subjects] ([Id], [Code], [Name], [FacultyId], [ManagementOrder], [Validated], [Deleted]) VALUES (2, N'452665400', N'Toan A3', 2, 1, 1, 0)
INSERT [dbo].[Subjects] ([Id], [Code], [Name], [FacultyId], [ManagementOrder], [Validated], [Deleted]) VALUES (3, N'2', N'Luat Kinh Te', 3, 1, 1, 0)
INSERT [dbo].[Subjects] ([Id], [Code], [Name], [FacultyId], [ManagementOrder], [Validated], [Deleted]) VALUES (4, N'3', N'Dia Ly Viet Nam', 4, 1, 1, 0)
INSERT [dbo].[Subjects] ([Id], [Code], [Name], [FacultyId], [ManagementOrder], [Validated], [Deleted]) VALUES (5, N'4', N'Tieng Anh 1', 5, 1, 1, 0)
INSERT [dbo].[Subjects] ([Id], [Code], [Name], [FacultyId], [ManagementOrder], [Validated], [Deleted]) VALUES (6, N'5', N'Quan Ly Muc Tieu Chung', 6, 1, 1, 0)
INSERT [dbo].[Subjects] ([Id], [Code], [Name], [FacultyId], [ManagementOrder], [Validated], [Deleted]) VALUES (7, N'6', N'Tin Hoc Dai Cuong', 7, 1, 1, 0)
SET IDENTITY_INSERT [dbo].[Subjects] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [Username], [Password], [Salt], [Name], [CreateDate], [LogOut], [LastActivity], [LastLogIn], [LastLogOut], [LastPasswordChanged], [Comment], [BuildInUser], [FacultyId], [SubjectId], [Deleted]) VALUES (1, N'admin', N'21232F297A57A5A743894A0E4A801FC3', N'2017-01-01 00:00:00.000', N'HUTECH', CAST(N'2017-01-01T00:00:00.000' AS DateTime), 0, CAST(N'2017-01-01T00:00:00.000' AS DateTime), CAST(N'2017-01-01T00:00:00.000' AS DateTime), CAST(N'2017-01-01T00:00:00.000' AS DateTime), CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'2017-01-01 00:00:00.000', 0, N'1         ', N'1         ', 0)
INSERT [dbo].[Users] ([Id], [Username], [Password], [Salt], [Name], [CreateDate], [LogOut], [LastActivity], [LastLogIn], [LastLogOut], [LastPasswordChanged], [Comment], [BuildInUser], [FacultyId], [SubjectId], [Deleted]) VALUES (2, N'hieu', N'hieu', N'asdasd', N'Nguyen Mai Hieu', CAST(N'2017-07-24T00:17:50.420' AS DateTime), 0, CAST(N'2017-07-24T00:17:50.420' AS DateTime), CAST(N'2017-07-24T00:17:50.420' AS DateTime), CAST(N'2017-07-24T00:17:50.420' AS DateTime), CAST(N'2017-07-24T00:17:50.420' AS DateTime), N'', 1, N'          ', N'          ', 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
ALTER TABLE [dbo].[Answers] ADD  CONSTRAINT [DF_Answers_SelectedTimes]  DEFAULT ((0)) FOR [SelectedTimes]
GO
ALTER TABLE [dbo].[Chapters] ADD  CONSTRAINT [DF_Chapters_Valided]  DEFAULT ((1)) FOR [Validated]
GO
ALTER TABLE [dbo].[Chapters] ADD  CONSTRAINT [DF_Phan_XoaTam]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Exams] ADD  CONSTRAINT [DF_DotThi_NgayTao]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Exams] ADD  CONSTRAINT [DF_Exams_Desktop]  DEFAULT ((0)) FOR [Desktop]
GO
ALTER TABLE [dbo].[Faculties] ADD  CONSTRAINT [DF_Faculties_Valided]  DEFAULT ((1)) FOR [Validated]
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
ALTER TABLE [dbo].[Questions] ADD  CONSTRAINT [DF_Questions_Valided]  DEFAULT ((1)) FOR [Validated]
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
ALTER TABLE [dbo].[Subjects] ADD  CONSTRAINT [DF_Subjects_Valided]  DEFAULT ((1)) FOR [Validated]
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
/****** Object:  StoredProcedure [dbo].[Answers_Insert]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Answers_SelectBy_QuestionId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Answers_Update]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CaculateMark]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Chapter_SelectBy_ParentId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
		and Deleted = 'False' And Validated =1
ORDER BY ManagementOrder





GO
/****** Object:  StoredProcedure [dbo].[Chapter_SelectBy_SubjectId_ParentId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
	AND  Deleted = 'False' And Validated =1

ORDER BY [Order], Name








GO
/****** Object:  StoredProcedure [dbo].[Chapter_SelectBy_SubjectId_ParentId_QuestionDelted]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
	
	CH.Deleted = 'true' AND CH.Validated  =1
	AND MH.Id = @SubjectId


GROUP BY P.Id, P.Name, P.ManagementOrder, P.ParentId





GO
/****** Object:  StoredProcedure [dbo].[Chapters_Insert]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
BEGIN
	DECLARE @STT int
	SET @STT =(select  (isnull(count(ManagementOrder),0)+1) from Chapters where SubjectId = @SubjectId)
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
					@STT		
	)
END








GO
/****** Object:  StoredProcedure [dbo].[Chapters_Restore]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Chapters_SelectAll]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
WHERE Validated =1



GO
/****** Object:  StoredProcedure [dbo].[Chapters_SelectOne]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
		[Id] = @Id AND validated =1



GO
/****** Object:  StoredProcedure [dbo].[Chapters_SelectOneByName]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Chapters_Update]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ChapterSelectBySubjectId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
		AND Deleted = 'False' And Validated =1

ORDER BY [ManagementOrder]




GO
/****** Object:  StoredProcedure [dbo].[CheckChapter]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[CheckChapter]

/*
Author:   			Nguyen Bao Quoc
Created: 			2011-3-9
Last Modified: 		2011-3-9
*/

@Id int,
@SubjectId int
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
		[Id] = @Id AND validated =1 AND SubjectId = @SubjectId



GO
/****** Object:  StoredProcedure [dbo].[CheckLoginByStudentCode]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CheckStudentCode]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CheckStudentHasLogin]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
	JOIN dbo.ShiftSubjects ON ShiftSubjects.Id = ShiftSubjectStudents.ShiftSubjectId
	JOIN dbo.Shifts ON Shifts.Id = ShiftSubjects.ShiftId
	WHERE dbo.Students.Code = @studentCode AND dbo.ShiftSubjectStudents.[LogIn] = 0 
	AND dbo.Shifts.Activated = 1 --ca thi đó phải được kích hoạt
END












GO
/****** Object:  StoredProcedure [dbo].[CheckSubjectBySubjectIdAndName]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[CheckSubjectBySubjectIdAndName]
@Code nvarchar(100),
@Name nvarchar(100)
AS
SELECT * FROM Subjects
WHERE Code = @Code AND Name =@Name



GO
/****** Object:  StoredProcedure [dbo].[DeleteTemporaryQuestion]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Exams_Delete]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Exams_Insert]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Exams_SelectAll]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Exams_SelectByName]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Exams_Update]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Faculties_Insert]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Faculties_Retore]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
	UPDATE Faculties SET Deleted =0 , Validated =1 Where Id =@Id;
	UPDATE Subjects SET Deleted =0 where FacultyId = @Id;
	UPDATE Chapters SET Deleted = 0 WHERE SubjectId in (Select Id from Subjects WHERE FacultyId =@Id)
	UPDATE Questions SET Deleted = 0
	WHERE SubjectId in (Select Id from Subjects WHERE FacultyId =@Id)
END;



GO
/****** Object:  StoredProcedure [dbo].[Faculties_SelectAll]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Faculties_SelectAll]

/*
Author:   			Hoang Van Hieu
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
WHERE Deleted = 'false' AND Validated = 1



GO
/****** Object:  StoredProcedure [dbo].[Faculties_SelectOne]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Faculties_SelectOneByName]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
		and Deleted = 'False' and Validated =1



GO
/****** Object:  StoredProcedure [dbo].[Faculties_Update]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Faculty_Delete]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
			UPDATE Faculties SET Deleted ='true', Validated =0 where Id =@Id;
			UPDATE Subjects SET Deleted ='true', Validated =0 where FacultyId = @Id;
			UPDATE Chapters SET Deleted = 'true', Validated =0 WHERE SubjectId in (Select Id from Subjects WHERE FacultyId =@Id)
			UPDATE Questions SET Deleted = 'true', Validated =0
			WHERE SubjectId in (Select Id from Subjects WHERE FacultyId =@Id)
	END





GO
/****** Object:  StoredProcedure [dbo].[Faculty_Delete_By_Id]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Faculty_SelectBy_QuestionDelete]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
	
	(CH.Deleted = 'true'OR K.Deleted ='true' OR MH.Deleted ='true' OR P.Deleted ='true') And K.Validated =1 AND CH.Validated =1

GROUP BY K.Id, K.Name



GO
/****** Object:  StoredProcedure [dbo].[GenerateExam]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetAnswerByQuestionId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetChaperId]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetChaperId]
	@SubjectId int,
	@TenPhanCha nvarchar(100),
	@TenPhanCon nvarchar(100)
	AS
	BEGIN
		IF(@TenPhanCha !='')
			BEGIN
				DECLARE @Ma int
				SET @Ma =(Select Id from Chapters
				where SubjectId = @SubjectId and [Name] =@TenPhanCha) 
				Select * from Chapters
				where SubjectId = @SubjectId and [Name] =@TenPhanCon AND ParentId = @Ma
			END
		ELSE
			BEGIN
				Select * from Chapters
				where SubjectId = @SubjectId and [Name] =@TenPhanCon 
			END

	END



GO
/****** Object:  StoredProcedure [dbo].[GetChapterId_SelectBy_ParentId]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetChapterId_SelectBy_ParentId]

/*
Author:   			Hoang Van Hieu
Created: 			2015-05-25
Last Modified: 		2017-05-25
*/

@ParentId int
-- WITH ENCRYPTION
AS


SELECT
		Id
FROM
		[dbo].[Chapters]
		
WHERE
		[ParentId] = @ParentId
		and Deleted = 'False' And validated =1
ORDER BY Id




GO
/****** Object:  StoredProcedure [dbo].[GetListQuestionCorretTimeHighest]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetListQuestionCorretTimeHighest]
@SubjectId int
AS
	Select top 100 percent Id, Content,ParentId,ManagementOrder from Questions
	WHERE SubjectId = @SubjectId And Deleted =0
	order by CorrectTimes DESC




GO
/****** Object:  StoredProcedure [dbo].[GetListQuestionCorretTimeLowest]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--thống kê top 100 câu đúng ít nhất theo môn học
CREATE PROC [dbo].[GetListQuestionCorretTimeLowest]
@SubjectId int
AS
	Select top 100 percent Id, Content,ParentId,ManagementOrder from Questions
	WHERE SubjectId = @SubjectId AND Deleted =0
	order by CorrectTimes ASC




GO
/****** Object:  StoredProcedure [dbo].[GetListQuestionRateHighest]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetListQuestionRateHighest]
@SubjectId int
AS
	Select top 100 percent Id, Content,ParentId,ManagementOrder from Questions
	WHERE SubjectId = @SubjectId AND Deleted =0
	order by CONVERT(decimal(18,10),(CorrectTimes))/ CONVERT(decimal(18,10),(SelectedTimes)) desc




GO
/****** Object:  StoredProcedure [dbo].[GetListQuestionRateLowest]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetListQuestionRateLowest]
@SubjectId int
AS
	Select top 100 percent Id, Content,ParentId,ManagementOrder from Questions
	WHERE SubjectId = @SubjectId AND Deleted =0
	order by CONVERT(decimal(18,10),(CorrectTimes))/ CONVERT(decimal(18,10),(SelectedTimes)) ASC




GO
/****** Object:  StoredProcedure [dbo].[GetListQuestionSelectdTimeHighest]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetListQuestionSelectdTimeHighest]
@SubjectId int
AS
	Select top 100 percent Id, Content,ParentId,ManagementOrder from Questions
	WHERE SubjectId = @SubjectId AND Deleted =0
	order by SelectedTimes DESC




GO
/****** Object:  StoredProcedure [dbo].[GetListQuestionSelectdTimeZero]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetListQuestionSelectdTimeZero]
@SubjectId int
AS
	select top 100 percent Id, Content,ParentId,ManagementOrder from Questions Where SelectedTimes =0 AND SubjectId =@SubjectId AND Deleted =0




GO
/****** Object:  StoredProcedure [dbo].[GetMark]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetMatrixDetailByMatrixId]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetMatrixDetailByMatrixId]
@MatrixId int
AS
	SELECT * FROM MatrixDetails WHERE MatrixId = @MatrixId








GO
/****** Object:  StoredProcedure [dbo].[GetNameFacultyBySubjectId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetPaperQuestionSheetsByPaperShiftSubjectId]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[GetPaperQuestionSheetsByPaperShiftSubjectId]
@PaperShiftSubjectId int
AS
 SELECT * FROM PaperQuestionSheets WHERE PaperShiftSubjectId = @PaperShiftSubjectId








GO
/****** Object:  StoredProcedure [dbo].[GetQuantityQuestionDiscriminationBester]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetQuantityQuestionDiscriminationBester]
@SubjectId int,
@Limit decimal(18,10)
AS
BEGIN
	Declare @number int;
	SET @number = (SELECT Id from Questions WHERE SubjectId = @SubjectId AND Discrimination> @Limit);
	
	IF(@number IS NULL) 
		SELECT 0
	ELSE 
		SELECT @number
END




GO
/****** Object:  StoredProcedure [dbo].[GetQuantityQuestionDiscriminationGood]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetQuantityQuestionDiscriminationGood]
@SubjectId int,
@LimitS decimal(18,10),
@LimitE decimal(18,10)
AS
BEGIN
	Declare @number int;
	SET @number = (SELECT COUNT(ID) from Questions WHERE SubjectId = @SubjectId AND Discrimination BETWEEN @LimitS AND @LimitE);
	
	IF(@number IS NULL) 
		SELECT 0
	ELSE 
		SELECT @number
END




GO
/****** Object:  StoredProcedure [dbo].[GetQuantityQuestionSheetAdvByMarkAndAnswerIdAndQuestionId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetQuantityQuestionSheetBelByMarkAndAnswerIdAndQuestionId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetQuestionContent]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetQuestionIdByParentId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetQuestionSheet]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetQuestionSheet]
    @questionSheetId BIGINT
AS
    BEGIN
        SELECT  [QuestionSheetDetails].[QuestionSheetId] ,
                [QuestionSheetDetails].[QuestionId] ,
                [QuestionSheetDetails].[Order] AS [QuestionOrder] ,
                [QuestionSheetDetails].[AnswerId] AS [AnswerCurrentChoose] ,
                [QuestionSheetDetails].[Correct] ,
                [QuestionSheetDetails].[ListenTimes] ,
                [Question].[Content] AS [QuestionContent] ,
                [Question].[ParentId] AS [QuestionParentId] ,
                [Question].[Audio] AS [QuestionAudio] ,
                [Question.Subject].[Id] AS [SubjectId] ,
                [Question.Subject].[Code] AS [SubjectCode] ,
                [Question.Subject].[Name] AS [SubjectName] ,
                [Question.Chapter].[Id] AS [ChapterId] ,
                [Question.Chapter].[Name] AS [ChapterName] ,
                [Question.Chapter].[Content] AS [ChapterContent] ,
                [Question.Chapter].[SubjectId] AS [ChapterSubjectId] ,
                [Question.Chapter].[ParentId] AS [ChapterParentId] ,
                [Question.Answers].[Id] AS [AnswersId] ,
                [Question.Answers].[Content] AS [AnswersContent] ,
                [Question.Answers].[Order] AS [AnswersOrder]
        FROM    [QuestionSheetDetails] AS [QuestionSheetDetails]
                LEFT OUTER JOIN [Questions] AS [Question] ON [QuestionSheetDetails].[QuestionId] = [Question].[Id]
                LEFT OUTER JOIN [Subjects] AS [Question.Subject] ON [Question].[SubjectId] = [Question.Subject].[Id]
                LEFT OUTER JOIN [Chapters] AS [Question.Chapter] ON [Question].[ChapterId] = [Question.Chapter].[Id]
                LEFT OUTER JOIN [Answers] AS [Question.Answers] ON [Question].[Id] = [Question.Answers].[QuestionId]
        WHERE   [QuestionSheetDetails].[QuestionSheetId] = @questionSheetId;
    END;








GO
/****** Object:  StoredProcedure [dbo].[GetQuestionSheetByStudentCode]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetRemainingTimeByQuestionSheetId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetResult]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetReviewQuestion]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetSubjectAndQuantityQuestionShiftByShiftId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
				WHERE PSS.ShiftId = @ShiftId and PSS.Deleted =0
				GROUP BY PSS.Id,S.Name,PSS.MatrixId,PSS.SubjectId
END






GO
/****** Object:  StoredProcedure [dbo].[GetSubjectByCode]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetSubjectByCode]
@code varchar(100)
AS
	Select * from Subjects where Code =@code




GO
/****** Object:  StoredProcedure [dbo].[InsertUser]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ListQuestionDeleted_SelectBy_ChapterId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ListQuestionDeleted_SelectBy_ChapterId_ParentId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Login]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[LoginSuccess]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[LogOut]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Matrices_SelectMax]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[MatricesInsert]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[MatricesSelectAll]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[MatricesSelectById]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[MatricesUpdate]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[MatrixDetailInsert]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[MatrixDetailSelectById]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[MatrixDetailUpdate]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PaperQuestionSheetDetailsInsert]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PaperQuestionSheetDetailsSelectByQuestionSheetId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PaperQuestionSheetsInsert]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Question_Delete]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Question_Delete]

@Id bigint
-- WITH ENCRYPTION
AS

update Questions set Deleted = 'true', Validated =0 where Id = @Id Or ParentId = @Id




GO
/****** Object:  StoredProcedure [dbo].[Question_Delete_Temporary]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Question_Restore]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Question_Restore]

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
/****** Object:  StoredProcedure [dbo].[Question_SelectBy_ChapterId_ParentId]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Question_SelectBy_ChapterId_ParentId]

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
		Id, Content,ParentId,ManagementOrder
FROM
		[dbo].[Questions]
		
WHERE
		[ChapterId] = @ChapterId
		and [ParentId] = @ParentId
		and Deleted = 'False'
ORDER BY [Id]





GO
/****** Object:  StoredProcedure [dbo].[Question_SelectBy_Date]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Question_SelectBy_Date]
@StartDate varchar(100),
@EndDate varchar(100)
-- WITH ENCRYPTION
AS
SELECT *
FROM Questions
WHERE CreateDate BETWEEN @StartDate AND @EndDate AND Deleted =0



GO
/****** Object:  StoredProcedure [dbo].[Question_SelectBy_SubjectId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Question_SelectSoCauHoiCon]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[QuestionDeletedByParentId]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[QuestionDeletedByParentId]
@ParentId int
as
select * from Questions 
where ParentId = @ParentId and Id != @ParentId And Deleted ='true' AND validated =1
Order By Id





GO
/****** Object:  StoredProcedure [dbo].[QuestionIdList_SelectBy_FacultyId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[QuestionIdList_SelectBy_SubjectId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_COUNT]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
		and Deleted = 'False'




GO
/****** Object:  StoredProcedure [dbo].[Questions_Delete_SelectBy_ParentId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
		and Deleted = 'True' AND validated =1
ORDER BY Id




GO
/****** Object:  StoredProcedure [dbo].[Questions_FlagAsDeleted]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_Insert]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
BEGIN
	DECLARE @STT int
	SET @STT =(select  (isnull(count(ManagementOrder),0)+1) from Questions where SubjectId = @SubjectId)
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
				@STT,
				@Audio
	)

END







GO
/****** Object:  StoredProcedure [dbo].[Questions_Paging]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Questions_Paging]
	@PageNumber int
as
	select TOP(@PageNumber*2) * from Questions














GO
/****** Object:  StoredProcedure [dbo].[Questions_Restore]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_Select_NumberOfChildQuestions]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_SelectAll]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_SelectAll_Deleted]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
		Deleted = 'True' And validated =1
ORDER BY [Id]




GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectAllId]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Questions_SelectAllId]

/*
Author:   			Hoang Van Hieu
Created: 			2017-02-25
Last Modified: 		2017-02-25
*/
-- WITH ENCRYPTION
AS


SELECT          Id
		
FROM
		[dbo].[Questions]





GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_ChapterId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
		Id, Content,ParentId,ManagementOrder, ObjectiveDifficulty
FROM
		[dbo].[Questions]
		
WHERE
		[ChapterId] = @ChapterId
		and Deleted = 'False' 
ORDER BY [Id]



GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_ChapterId_Paging]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_ChapterId_Paging1]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Questions_SelectBy_ChapterId_Paging1]

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
	[ParentId] [bigint] NULL,
	[ManagementOrder] [int] NULL
 )   
 INSERT INTO #TemporaryTable   
  SELECT Id,Content,ParentId,ManagementOrder FROM [Questions]  where ChapterId =@ChapterId AND Deleted =0
   
 SELECT    Id,Content,ParentId,ManagementOrder
  FROM #TemporaryTable   
  WHERE (Row >= @Start) AND (Row <= @End)
	ORDER BY [Id]  
 DROP TABLE #TemporaryTable   
 COMMIT TRANSACTION GetDataSet   
 RETURN 0   
ErrorHandler:   
ROLLBACK TRANSACTION GetDataSet   
RETURN @@ERROR 



GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_ChapterId_ParentId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
		Id, Content,ParentId,ManagementOrder
FROM
		[dbo].[Questions]
		
WHERE
		[ChapterId] = @ChapterId
		and [ParentId] = @ParentId
		and Deleted = 'False'
ORDER BY [Id]



GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_Date]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Questions_SelectBy_Date]

/*
Author:   			Hoang Van Hieu
Created: 			2017-07-07
Last Modified: 		2017-07-07
*/

@StartTime varchar(100),
@EndTime varchar(100)
-- WITH ENCRYPTION
AS

SELECT CH.Id, CH.Content,CH.ParentId,CH.ManagementOrder
FROM [dbo].Questions CH
WHERE CH.CreateDate BETWEEN @StartTime AND @EndTime And Deleted = 0



GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_ParentId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
		Id, Content,ParentId,ManagementOrder
FROM
		[dbo].[Questions]
		
WHERE
		[ParentId] = @ParentId
		and Deleted = 'False' and ParentId != Id
ORDER BY Id



GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_SubjectCode]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
		DISTINCT CH.Id, CH.Content,CH.ParentId,CH.ManagementOrder
FROM
		[dbo].[Questions] CH
		JOIN [dbo].[Chapters] P ON P.Id = CH.Id
WHERE
		P.SubjectId = @SubjectCode
ORDER BY Id
















GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectMax_IdQuestions]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_SelectOne]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_SelectPage]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_Update]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
			[ObjectiveDifficulty] = @SubjectiveDifficulty,
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
/****** Object:  StoredProcedure [dbo].[Questions_UpdateParentId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_Validation]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Questions_Validation]
@StartDate varchar(100),
@EndDate varchar(100)
-- WITH ENCRYPTION
AS

--nhỏ hơn hoặc bằng 2 câu trả lời
SELECT CH.Id, CH.Content,CH.ParentId,CH.ManagementOrder 
FROM Questions CH JOIN Answers CTL ON CTL.QuestionId = CH.Id
WHERE CH.Id !=CH.ParentId AND CH.CreateDate BETWEEN @StartDate AND @EndDate AND validated =1
GROUP BY CH.Id, CH.ChapterId, CH.Content, CH.Interchange, CH.Mark,
		CH.SubjectiveDifficulty, CH.ObjectiveDifficulty, CH.ParentId, CH.Deleted,CH.Duration,
			CH.SelectedTimes, CH.CorrectTimes, CH.CreateDate, CH.UpdateDate, CH.Discrimination, CH.ManagementOrder,SubjectId,Audio,ListenedTimes,CH.validated
HAVING COUNT(CTL.Id)<=2

--không có đáp án
UNION

SELECT CH.Id, CH.Content,CH.ParentId,CH.ManagementOrder FROM Questions CH
WHERE CH.Id NOT IN(
	SELECT CH.Id
	FROM Questions CH JOIN Answers CTL ON CTL.QuestionId = CH.Id
	WHERE CTL.Correct = 'True'
	GROUP BY CH.Id
	HAVING COUNT(CTL.Correct) = 1
)

AND CH.Id != CH.ParentId AND CH.CreateDate BETWEEN @StartDate AND @EndDate




GO
/****** Object:  StoredProcedure [dbo].[QuestionsDeleted_SelectBy_ChapterId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[QuestionsDeleted_SelectBy_ParentId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[QuestionSheetDetailCreate]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[QuestionSheetDetailSelectById]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[QuestionSheetDetailUpdate]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[QuestionSheetGetAll]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[QuestionSheetGetAll]
as
Select * from QuestionSheets
order by Id Desc








GO
/****** Object:  StoredProcedure [dbo].[QuestionSheetID_SelectMax]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[QuestionSheetInsert]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[QuestionSheetSelectById]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[QuestionSheetUpdate]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[RestoreQuestionDeleted]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[RestoreQuestionDeleted]

@Id bigint
-- WITH ENCRYPTION
AS
BEGIN
	update Questions set Deleted = 'false' where [Id] = @Id AND Validated = 1;
	Declare  @SubjectId int;
	SET @SubjectId = (SELECT SubjectId from Questions where Id = @Id) ;
	Declare @Faculty int;
	SET @Faculty = (select FacultyId from Subjects where Id = @SubjectId);
	UPDATE Subjects set Deleted = 'false' Where Id = @SubjectId;
	UPDATE Faculties Set Deleted = 'false' WHERE Id = @Faculty;
END



GO
/****** Object:  StoredProcedure [dbo].[SeachQuestion]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SeachQuestion]
@SubjectId int,
@ChapterId int
AS
BEGIN
	IF(@ChapterId = 0)
		SELECT Id, Content,ParentId,ManagementOrder FROM Questions where SubjectId =@SubjectId And Deleted = 0
	ELSE	
		Select Id, Content,ParentId,ManagementOrder from Questions where ChapterId = @ChapterId And Deleted = 0
END



GO
/****** Object:  StoredProcedure [dbo].[SeachQuestionByDate]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SeachQuestionByDate]
@StartTime varchar(100),
@EndTime varchar(100),
@SubjectId int,
@ChapterId int
AS
	BEGIN
		IF(@StartTime =@EndTime)
			BEGIN
				IF(@ChapterId is not null)
					Select Id, Content,ParentId,ManagementOrder from Questions where CreateDate = @StartTime AND ChapterId = @ChapterId And Deleted = 0
				ELSE
					Select Id, Content,ParentId,ManagementOrder from Questions Where CreateDate = @StartTime And SubjectId = @SubjectId And Deleted =0
			END
		ELSE
			BEGIN
				IF(@ChapterId !=0)
					Select Id, Content,ParentId,ManagementOrder from Questions where (CreateDate BETWEEN @StartTime AND @EndTime) AND ChapterId = @ChapterId  And Deleted = 0
				ELSE
					Select Id, Content,ParentId,ManagementOrder from Questions where (CreateDate BETWEEN @StartTime AND @EndTime) AND SubjectId = @SubjectId And Deleted = 0
			END
	END



GO
/****** Object:  StoredProcedure [dbo].[Shift_SelectByName]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Shift_SelectByName]

@Name nvarchar(100)

AS


SELECT
		*
		
FROM
		[dbo].[Shifts] Where [Name] =@Name





GO
/****** Object:  StoredProcedure [dbo].[ShiftDelete]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ShiftDelete]
@shiftId int
AS
	UPDATE Shifts SET Deleted = 1
	WHERE Id =@shiftId



GO
/****** Object:  StoredProcedure [dbo].[ShiftInsert]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ShiftSelectByExamId]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ShiftSelectByExamId]
	@ExamId INT
AS
    BEGIN

        SELECT * FROM dbo.Shifts
		WHERE ExamId = @ExamId And Deleted = 0
		order by Id DESC
    END;





GO
/****** Object:  StoredProcedure [dbo].[ShiftSelectById]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ShiftSubjectDelete]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ShiftSubjectDelete]
@shiftSubjectId int
AS
	UPDATE PaperShiftSubjects SET Deleted = 1
	WHERE Id =@shiftSubjectId



GO
/****** Object:  StoredProcedure [dbo].[ShiftSubjectInsert]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ShiftSubjectSelectById]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ShiftSubjectSelectByShiftId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ShiftSubjectStudentInsert]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ShiftSubjectStudentSelectById]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ShiftSubjectStudentUpdate]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ShiftSubjectUpdate]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ShiftUpdate]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SoCauHoiChuaDuocThiTheoMaPhan]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[SoCauHoiChuaDuocThiTheoMaPhan]

@ChapterId int
as
SELECT
		*
FROM
		[dbo].[Questions]
		
WHERE
		[ChapterId] = @ChapterId
		and Deleted ='False' and SelectedTimes =0
ORDER BY [Id]







GO
/****** Object:  StoredProcedure [dbo].[SoCauHoiDuocThiTheoMaPhan]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[SoCauHoiDuocThiTheoMaPhan]

@ChapterId int
as
SELECT
		*
FROM
		[dbo].[Questions]
		
WHERE
		[ChapterId] = @ChapterId
		and Deleted ='False' and SelectedTimes >999
ORDER BY [Id]







GO
/****** Object:  StoredProcedure [dbo].[SoLuongCauHoiDeTheoMaKhoa]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SoLuongCauHoiDeTheoMaKhoa]
@FacultyId int,
@ObjectiveDifficulty decimal(18,10)
AS
SELECT
		DISTINCT CH.Id
FROM
		[dbo].[Questions] CH
		JOIN [dbo].[Chapters] P ON P.Id = CH.ChapterId
		JOIN [dbo].[Subjects] S ON S.Id = P.SubjectId
WHERE
		S.FacultyId = @FacultyId AND ObjectiveDifficulty > @ObjectiveDifficulty
ORDER BY Id






GO
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOIDETHEOMAMONHOC]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SOLUONGCAUHOIDETHEOMAMONHOC]
@SubjectId INT
AS
SELECT Id FROM Questions 
WHERE SubjectId = @SubjectId AND ObjectiveDifficulty > 0.799






GO
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOIDETHEOMAPHAN]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SOLUONGCAUHOIDETHEOMAPHAN]
@ChapterId INT
AS
SELECT Id FROM Questions 
WHERE ChapterId = @ChapterId AND ObjectiveDifficulty > 0.799






GO
/****** Object:  StoredProcedure [dbo].[SoLuongCauHoiKhoTheoMaKhoa]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SoLuongCauHoiKhoTheoMaKhoa]
@FacultyId int,
@ObjectiveDifficultyS decimal(18,10),
@ObjectiveDifficultyE decimal(18,10)
AS
SELECT
		DISTINCT CH.Id
FROM
		[dbo].[Questions] CH
		JOIN [dbo].[Chapters] P ON P.Id = CH.ChapterId
		JOIN [dbo].[Subjects] S ON S.Id = P.SubjectId
WHERE
		S.FacultyId = @FacultyId AND ObjectiveDifficulty >@ObjectiveDifficultyS AND ObjectiveDifficulty <@ObjectiveDifficultyE
ORDER BY Id






GO
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOIKHOTHEOMAMONHOC]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SOLUONGCAUHOIKHOTHEOMAMONHOC]
@SubjectId INT
AS
SELECT Id FROM Questions 
WHERE SubjectId = @SubjectId AND ObjectiveDifficulty >0.1999 AND ObjectiveDifficulty <0.4






GO
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOIKHOTHEOMAPHAN]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SOLUONGCAUHOIKHOTHEOMAPHAN]
@ChapterId INT
AS
SELECT Id FROM Questions 
WHERE ChapterId = @ChapterId AND ObjectiveDifficulty >0.1999 AND ObjectiveDifficulty <0.4






GO
/****** Object:  StoredProcedure [dbo].[SoLuongCauHoiRatKhoTheoMaKhoa]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SoLuongCauHoiRatKhoTheoMaKhoa]
@FacultyId int,
@ObjectiveDifficulty decimal(18,10)
AS
SELECT
		DISTINCT CH.Id
FROM
		[dbo].[Questions] CH
		JOIN [dbo].[Chapters] P ON P.Id = CH.ChapterId
		JOIN [dbo].[Subjects] S ON S.Id = P.SubjectId
WHERE
		S.FacultyId = @FacultyId AND ObjectiveDifficulty <@ObjectiveDifficulty
ORDER BY Id




GO
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOIRATKHOTHEOMAMONHOC]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SOLUONGCAUHOIRATKHOTHEOMAMONHOC]
@SubjectId INT
AS
SELECT Id FROM Questions 
WHERE SubjectId = @SubjectId AND ObjectiveDifficulty <0.2






GO
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOIRATKHOTHEOMAPHAN]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SOLUONGCAUHOIRATKHOTHEOMAPHAN]
@ChapterId INT
AS
SELECT Id FROM Questions 
WHERE ChapterId = @ChapterId AND ObjectiveDifficulty <0.2






GO
/****** Object:  StoredProcedure [dbo].[SoLuongCauHoiTrungBinhTheoMaKhoa]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SoLuongCauHoiTrungBinhTheoMaKhoa]
@FacultyId int,
@ObjectiveDifficultyS decimal(18,10),
@ObjectiveDifficultyE decimal(18,10)
AS
SELECT
		DISTINCT CH.Id
FROM
		[dbo].[Questions] CH
		JOIN [dbo].[Chapters] P ON P.Id = CH.ChapterId
		JOIN [dbo].[Subjects] S ON S.Id = P.SubjectId
WHERE
		S.FacultyId = @FacultyId AND ObjectiveDifficulty >@ObjectiveDifficultyS AND ObjectiveDifficulty <@ObjectiveDifficultyE
ORDER BY Id






GO
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOITRUNGBINHTHEOMAMONHOC]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SOLUONGCAUHOITRUNGBINHTHEOMAMONHOC]
@SubjectId INT
AS
SELECT Id FROM Questions 
WHERE SubjectId = @SubjectId AND ObjectiveDifficulty >0.599 AND ObjectiveDifficulty <0.8






GO
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOITRUNGBINHTHEOMAPHAN]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SOLUONGCAUHOITRUNGBINHTHEOMAPHAN]
@ChapterId INT
AS
SELECT Id FROM Questions 
WHERE ChapterId = @ChapterId AND ObjectiveDifficulty >0.599 AND ObjectiveDifficulty <0.8






GO
/****** Object:  StoredProcedure [dbo].[SoLuongCauHoiTuongDoiKhoTheoMaKhoa]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SoLuongCauHoiTuongDoiKhoTheoMaKhoa]
@FacultyId int,
@ObjectiveDifficultyS decimal(18,10),
@ObjectiveDifficultyE decimal(18,10)
AS
SELECT
		DISTINCT CH.Id
FROM
		[dbo].[Questions] CH
		JOIN [dbo].[Chapters] P ON P.Id = CH.ChapterId
		JOIN [dbo].[Subjects] S ON S.Id = P.SubjectId
WHERE
		S.FacultyId = @FacultyId AND ObjectiveDifficulty > @ObjectiveDifficultyS AND ObjectiveDifficulty <@ObjectiveDifficultyE
ORDER BY Id







GO
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOITUONGDOIKHOTHEOMAMONHOC]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SOLUONGCAUHOITUONGDOIKHOTHEOMAMONHOC]
@SubjectId INT
AS
SELECT Id FROM Questions 
WHERE SubjectId = @SubjectId AND ObjectiveDifficulty >0.399 AND ObjectiveDifficulty <0.6






GO
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOITUONGDOIKHOTHEOMAPHAN]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SOLUONGCAUHOITUONGDOIKHOTHEOMAPHAN]
@ChapterId INT
AS
SELECT Id FROM Questions 
WHERE ChapterId = @ChapterId AND ObjectiveDifficulty >0.399 AND ObjectiveDifficulty <0.6






GO
/****** Object:  StoredProcedure [dbo].[Subject_Delete]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
		UPDATE Subjects SET Deleted ='true', Validated =0 where Id = @Id;
		UPDATE Chapters SET Deleted = 'true', Validated =0 WHERE SubjectId = @Id;
		UPDATE Questions SET Deleted = 'true', Validated =0 WHERE SubjectId =@Id;
	END	
	DECLARE @SoLuongCauHoi int;
	SET @SoLuongCauHoi = (SELECT COUNT(Id) FROM Questions
						WHERE Validated =1 AND SubjectId IN(SELECT Id FROM Subjects WHERE FacultyId = @FacultyId))
	IF(@SoLuongCauHoi =0)
		UPDATE Faculties SET Deleted = 1, Validated =0 WHERE Id =@FacultyId
END



GO
/****** Object:  StoredProcedure [dbo].[Subject_SelectBy_QuestionDelete]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Subjects_Count]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Subjects_Count]
AS
SELECT COUNT([Id]) AS Quantity_Subjects
     
  FROM [dbo].[Subjects]
















GO
/****** Object:  StoredProcedure [dbo].[Subjects_FlagAsDeleted]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Subjects_Insert]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
BEGIN
	DECLARE @STT int
	SET @STT =(select  (isnull(count(ManagementOrder),0)+1) from Subjects where FacultyId = @FacultyId)
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
					@STT
				
	)
END









GO
/****** Object:  StoredProcedure [dbo].[Subjects_Restore]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Subjects_SelectAll]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Subjects_SelectAll_Deleted]    Script Date: 31-Jul-17 1:43:19 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Subjects_SelectAll_Deleted]

/*
Author:   			Hoang Van Hieu
Created: 			2017-02-45
Last Modified: 		2017-02-45
*/
-- WITH ENCRYPTION
AS


SELECT
		*		
FROM
		[dbo].[Subjects]
where
		Deleted = 'True' AND validated =1











GO
/****** Object:  StoredProcedure [dbo].[Subjects_SelectBy_FacultyId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Subjects_SelectOne]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Subjects_SelectOneByName]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Subjects_SelectPage]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Subjects_Update]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateAnswer]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateDiscriminationForQuestion]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateDiscriminationForQuestionByChapterId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateDiscriminationForQuestionBySubjectId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
	FROM GetQuesTionInQuestionSheet(@SubjectId)

	OPEN MY_CURSOR
	FETCH NEXT FROM MY_CURSOR INTO @QuestionId
	WHILE @@FETCH_STATUS = 0
	BEGIN 

		DECLARE @AnswerId BigInt;
		DECLARE MY_CURSOR_Ans CURSOR 
		  LOCAL STATIC READ_ONLY FORWARD_ONLY
		FOR 
		SELECT DISTINCT Id 
		FROM GetAnswerInQuestionSheet(@SubjectId) 

		OPEN MY_CURSOR_Ans
		FETCH NEXT FROM MY_CURSOR_Ans INTO @AnswerId
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
			update Questions SET Discrimination =ABS(Convert(decimal(18,10),(CONVERT(decimal(18,10),(@Adv-@Ble)) / CONVERT(decimal(18,10),(@Limit*SelectedTimes))))) where Id = @QuestionId And SELECTedTimes >@SelectedTimes
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
/****** Object:  StoredProcedure [dbo].[UpdateListenTimes]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateObjectiveDifficulty]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateObjectiveDifficultyByChapterId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateObjectiveDifficultyBySubjectId]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdatePaperQuestionSheet]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[User_SelectAll]    Script Date: 31-Jul-17 1:43:19 PM ******/
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
