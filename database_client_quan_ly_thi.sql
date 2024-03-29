USE [master]
GO
/****** Object:  Database [QuanLyTracNghiem]    Script Date: 15/05/2021 12:38:33 PM ******/
CREATE DATABASE [QuanLyTracNghiem] ON  PRIMARY 
( NAME = N'QuanLyTracNghiem', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\QuanLyTracNghiem.mdf' , SIZE = 3328KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QuanLyTracNghiem_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\QuanLyTracNghiem_log.LDF' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QuanLyTracNghiem] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyTracNghiem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyTracNghiem] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyTracNghiem] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyTracNghiem] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyTracNghiem] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyTracNghiem] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyTracNghiem] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QuanLyTracNghiem] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyTracNghiem] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyTracNghiem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyTracNghiem] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyTracNghiem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyTracNghiem] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyTracNghiem] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyTracNghiem] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyTracNghiem] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyTracNghiem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyTracNghiem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyTracNghiem] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyTracNghiem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyTracNghiem] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyTracNghiem] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [QuanLyTracNghiem] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyTracNghiem] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QuanLyTracNghiem] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyTracNghiem] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyTracNghiem] SET DB_CHAINING OFF 
GO
USE [QuanLyTracNghiem]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 15/05/2021 12:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Answers]    Script Date: 15/05/2021 12:38:33 PM ******/
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
 CONSTRAINT [PK_Answers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Chapters]    Script Date: 15/05/2021 12:38:33 PM ******/
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
	[FolderName] [nvarchar](max) NULL,
 CONSTRAINT [PK_Chapters] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exams]    Script Date: 15/05/2021 12:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exams](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[CreateDate] [datetime2](7) NULL,
	[Desktop] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[UserId] [int] NULL,
 CONSTRAINT [PK_Exams] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExtraTimeLogs]    Script Date: 15/05/2021 12:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExtraTimeLogs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Reason] [nvarchar](100) NULL,
	[ExtraTime] [smallint] NOT NULL,
	[QuestionSheetId] [bigint] NULL,
 CONSTRAINT [PK_ExtraTimeLogs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Faculties]    Script Date: 15/05/2021 12:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faculties](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Comment] [nvarchar](100) NULL,
	[Deleted] [bit] NOT NULL,
	[Validated] [bit] NOT NULL,
	[FolderName] [nvarchar](max) NULL,
 CONSTRAINT [PK_Faculties] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MarkRoundings]    Script Date: 15/05/2021 12:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MarkRoundings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Using] [bit] NOT NULL,
	[Code] [nvarchar](50) NULL,
 CONSTRAINT [PK_MarkRoundings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Matrices]    Script Date: 15/05/2021 12:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Matrices](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExamId] [int] NULL,
	[CreateDate] [datetime2](7) NULL,
	[Name] [nvarchar](100) NULL,
	[SubjectId] [int] NULL,
 CONSTRAINT [PK_Matrices] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MatrixDetails]    Script Date: 15/05/2021 12:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MatrixDetails](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[MatrixId] [int] NOT NULL,
	[ChapterId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Excluded] [nvarchar](max) NULL,
	[Factor] [int] NULL,
 CONSTRAINT [PK_MatrixDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaperQuestionSheetDetails]    Script Date: 15/05/2021 12:38:33 PM ******/
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
/****** Object:  Table [dbo].[PaperQuestionSheets]    Script Date: 15/05/2021 12:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaperQuestionSheets](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[CreateDate] [datetime2](7) NULL,
	[ExportDate] [datetime2](7) NULL,
	[TestDate] [datetime2](7) NULL,
	[Duration] [int] NULL,
	[Exported] [bit] NULL,
	[PaperShiftSubjectId] [bigint] NULL,
	[ObjectiveDifficulty] [decimal](18, 2) NULL,
	[Total] [int] NULL,
 CONSTRAINT [PK_PaperQuestionSheets] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaperShiftSubjects]    Script Date: 15/05/2021 12:38:33 PM ******/
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
/****** Object:  Table [dbo].[Questions]    Script Date: 15/05/2021 12:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questions](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Content] [nvarchar](max) NULL,
	[Interchange] [bit] NULL,
	[SubjectiveDifficulty] [decimal](18, 2) NULL,
	[ObjectiveDifficulty] [decimal](18, 2) NULL,
	[SelectedTimes] [int] NULL,
	[CorrectTimes] [int] NULL,
	[ChapterId] [int] NULL,
	[CreateDate] [datetime2](7) NULL,
	[UpdateDate] [datetime2](7) NULL,
	[Mark] [decimal](18, 2) NULL,
	[Duration] [int] NULL,
	[ParentId] [bigint] NULL,
	[Audio] [bit] NULL,
	[Discrimination] [decimal](18, 2) NULL,
	[ManagementOrder] [int] NULL,
	[SubjectId] [int] NULL,
	[ListenedTimes] [int] NULL,
	[Validated] [bit] NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_Questions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestionSheetDetails]    Script Date: 15/05/2021 12:38:33 PM ******/
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
	[CreateDate] [datetime2](7) NULL,
	[UpdateDate] [datetime2](7) NULL,
	[ListenTimes] [tinyint] NULL,
	[Desktop] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_QuestionSheetDetails] PRIMARY KEY CLUSTERED 
(
	[QuestionSheetId] ASC,
	[QuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestionSheets]    Script Date: 15/05/2021 12:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionSheets](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[CreateDate] [datetime2](7) NULL,
	[Approved] [bit] NOT NULL,
	[Started] [bit] NOT NULL,
	[Completed] [bit] NOT NULL,
	[ExtraTime] [tinyint] NOT NULL,
	[ExtraTimeReason] [nvarchar](100) NULL,
	[Mark] [decimal](18, 2) NULL,
	[NumberOfCorrect] [smallint] NULL,
	[Total] [smallint] NULL,
	[Difficulty] [decimal](18, 2) NULL,
	[UserId] [int] NULL,
	[StudentId] [int] NOT NULL,
	[ShiftId] [int] NULL,
	[ShiftSubjectId] [bigint] NOT NULL,
 CONSTRAINT [PK_QuestionSheets] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 15/05/2021 12:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleUsers]    Script Date: 15/05/2021 12:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleUsers](
	[Role_Id] [int] NOT NULL,
	[User_Id] [int] NOT NULL,
	[UserId] [int] NULL,
	[RoleId] [int] NULL,
 CONSTRAINT [PK_RoleUsers] PRIMARY KEY CLUSTERED 
(
	[User_Id] ASC,
	[Role_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Semesters]    Script Date: 15/05/2021 12:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Semesters](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Comment] [nvarchar](max) NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_Semesters] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Settings]    Script Date: 15/05/2021 12:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_Settings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shifts]    Script Date: 15/05/2021 12:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shifts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[ExamId] [int] NULL,
	[QuestionSheetCreated] [bit] NOT NULL,
	[Desktop] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_Shifts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShiftSubjects]    Script Date: 15/05/2021 12:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShiftSubjects](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ShiftId] [int] NULL,
	[SubjectId] [int] NULL,
	[MatrixId] [int] NULL,
	[SubjectCode] [nvarchar](max) NULL,
	[SubjectName] [nvarchar](max) NULL,
	[GroupCode] [nvarchar](max) NULL,
	[SubGroupCode] [nvarchar](max) NULL,
	[StartTime] [datetime2](7) NULL,
	[EndTime] [datetime2](7) NULL,
	[Ended] [bit] NULL,
	[EndDate] [datetime2](7) NULL,
	[ActivateTime] [datetime2](7) NULL,
	[Duration] [smallint] NULL,
	[CreatedQuestionSheet] [bit] NOT NULL,
	[StateActivate] [tinyint] NULL,
 CONSTRAINT [PK_ShiftSubjects] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShiftSubjectStudents]    Script Date: 15/05/2021 12:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShiftSubjectStudents](
	[ShiftSubjectId] [bigint] NOT NULL,
	[StudentId] [int] NOT NULL,
	[QuestionSheetId] [bigint] NULL,
	[LogIn] [bit] NOT NULL,
	[LastLogIn] [datetime2](7) NULL,
	[LastLogOut] [datetime2](7) NULL,
	[StateExam] [tinyint] NULL,
	[InsertTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_ShiftSubjectStudents] PRIMARY KEY CLUSTERED 
(
	[ShiftSubjectId] ASC,
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 15/05/2021 12:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](100) NULL,
	[LastName] [nvarchar](50) NULL,
	[FirstName] [nvarchar](50) NULL,
	[ClassName] [nvarchar](max) NULL,
	[Name] [nvarchar](50) NULL,
	[Email] [nvarchar](max) NULL,
	[Password] [nvarchar](max) NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subjects]    Script Date: 15/05/2021 12:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subjects](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](12) NULL,
	[Name] [nvarchar](100) NULL,
	[FacultyId] [int] NULL,
	[ManagementOrder] [smallint] NULL,
	[Validated] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[FolderName] [nvarchar](max) NULL,
 CONSTRAINT [PK_Subjects] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 15/05/2021 12:38:33 PM ******/
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
	[CreateDate] [datetime2](7) NULL,
	[LogOut] [bit] NOT NULL,
	[LastActivity] [datetime2](7) NULL,
	[LastLogIn] [datetime2](7) NULL,
	[LastPasswordChanged] [datetime2](7) NULL,
	[LastLogOut] [datetime2](7) NULL,
	[Comment] [nvarchar](100) NULL,
	[BuildInUser] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[FacultyId] [nvarchar](10) NULL,
	[SubjectId] [nvarchar](10) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200710131227_InitialProject', N'3.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20201020073207_AddColumnFolderName', N'3.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20201022073305_FixPropertyAudio', N'3.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20201022091442_AddColumnSetting', N'3.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20210515021633_UpdateAudio', N'3.0.0')
SET IDENTITY_INSERT [dbo].[Answers] ON 

INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (1, 3, N'Thuộc nhóm Lincosamide', 2, 1, 0, 5)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (2, 5, N'sum int', 2, 0, 0, 5)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (3, 5, N'sum interger', 1, 0, 0, 5)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (4, 4, N'20m', 4, 0, 0, 5)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (5, 4, N'15m', 3, 1, 0, 5)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (6, 4, N'10m', 2, 0, 0, 5)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (7, 4, N'5m', 1, 0, 0, 5)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (8, 1, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, 5)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (9, 1, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, 5)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (10, 1, N'Gồm những hành động một đầu vào và nhiều đầu ra.', 3, 0, 0, 5)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (11, 1, N'Gồm những hành động một đầu vào, có nhiều đầu ra và quyết định được hình thức hóa.', 4, 1, 0, 5)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (12, 2, N'study/will pass', 1, 1, 0, 6)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (13, 2, N'study/pass', 2, 0, 0, 5)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (14, 2, N'study/would passed', 3, 0, 0, 5)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (15, 2, N'study/passed', 4, 0, 0, 5)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (16, 3, N'Thuộc nhóm Aminoglycosides', 1, 0, 0, 5)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (17, 5, N'int sum', 3, 1, 0, 5)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (18, 5, N'sum [interger]', 4, 0, 0, 5)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (19, 13, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, 1)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (20, 13, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, 0)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (169, 139, N'Đáp án 1 - Câu hỏi con 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (170, 139, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (171, 140, N'Đáp án 2 - Câu hỏi con 2', 2, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (172, 140, N'Đáp án 1 - Câu hỏi con 2', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (246, 181, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (247, 181, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (248, 182, N'Đáp án 1 - Câu hỏi con 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (249, 182, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (250, 183, N'Đáp án 2 - Câu hỏi con 2', 2, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (251, 183, N'Đáp án 1 - Câu hỏi con 2', 1, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (279, 139, N'Đáp án 3 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (281, 182, N'Đáp án 3- Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (282, 295, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (283, 295, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (286, 298, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (287, 298, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (288, 299, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (289, 299, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (290, 300, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (291, 300, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (292, 301, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (293, 301, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (294, 302, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (295, 302, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (296, 303, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (297, 303, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (298, 304, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (299, 304, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (300, 305, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (301, 305, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (302, 306, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (303, 306, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (304, 307, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (305, 307, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (306, 308, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (307, 308, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (308, 309, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (309, 309, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (310, 310, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (311, 310, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (312, 311, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (313, 311, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (314, 312, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (315, 312, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (316, 313, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (317, 313, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (318, 314, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (319, 314, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (320, 315, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (321, 315, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (322, 316, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (323, 316, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (324, 317, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (325, 317, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (326, 318, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (327, 318, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (328, 319, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (329, 319, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (330, 320, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (331, 320, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (332, 321, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (333, 321, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (334, 322, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (335, 322, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (336, 323, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (337, 323, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (338, 324, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (339, 324, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (340, 325, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (341, 325, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (342, 326, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (343, 326, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (344, 327, N'Đáp án 1 - Câu hỏi 1', 1, 1, 1, NULL)
INSERT [dbo].[Answers] ([Id], [QuestionId], [Content], [Order], [Correct], [Interchange], [SelectedTimes]) VALUES (345, 327, N'Đáp án 2 - Câu hỏi 1', 2, 0, 1, NULL)
SET IDENTITY_INSERT [dbo].[Answers] OFF
SET IDENTITY_INSERT [dbo].[Chapters] ON 

INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (1, N'Chương 5', N'Demo', 1, NULL, 10, 5, 1, 0, N'CHUONG5')
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (2, N'Chương PARENTANDCHILD', N'Demo', 4, 2, 7, 4, 1, 0, N'STRING')
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (3, N'Chương 3', N'UIO', 3, NULL, 1, 3, 0, 1, N'CHUONG3')
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (4, N'Chương 2', N'RTY', 2, NULL, 3, 2, 0, 1, N'CHUONG2')
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (5, N'Chương 1', N'QWE', 1, NULL, 5, 1, 0, 1, N'CHUONG 1')
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (8, N'CHƯƠNG C1', N'Chuong con 1', NULL, 2, NULL, NULL, 0, 0, N'CHUONGC1')
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (9, N'CHƯƠNG C2', N'Chuong con 2', NULL, 2, NULL, NULL, 0, 0, N'CHUONGC2')
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (11, N'CHƯƠNG C1', N'Chuong con 1', NULL, 2, 7, NULL, 0, 0, N'CHUONGC1')
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (12, N'CHƯƠNG C2', N'Chuong con 2', NULL, 2, 7, NULL, 0, 0, N'CHUONGC2')
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (13, N'CHƯƠNG C1', N'Chuong con 1', NULL, 2, 7, NULL, 0, 0, N'CHUONGC1')
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (14, N'CHƯƠNG C2', N'Chuong con 2', NULL, 2, 7, NULL, 0, 0, N'CHUONGC2')
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (15, N'CHƯƠNG C1', N'Chuong con 1', NULL, 2, 7, NULL, 0, 0, N'CHUONGC1')
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (16, N'CHƯƠNG C2', N'Chuong con 2', NULL, 2, 7, NULL, 0, 0, N'CHUONGC2')
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (17, N'CHƯƠNG C1', N'Chuong con 1', NULL, 2, 7, NULL, 0, 0, N'CHUONGC1')
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (18, N'CHƯƠNG C1', N'Chuong con 1', 1, 2, 7, NULL, 0, 0, N'CHUONGC1')
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (19, N'CHƯƠNG C2', N'Chuong con 2', 1, 2, 7, NULL, 0, 0, N'CHUONGC2')
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (22, N'CHƯƠNG C1', N'Chuong con 1', 1, 2, 7, NULL, 0, 0, N'CHUONGC1')
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (23, N'CHƯƠNG C2', N'Chuong con 2', 1, 2, 7, NULL, 0, 0, N'CHUONGC2')
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (24, N'CHƯƠNG CON 2', N'Chuong con 2', 1, 2, 7, NULL, 0, 0, N'CHUONGCON2')
INSERT [dbo].[Chapters] ([Id], [Name], [Content], [Order], [ParentId], [SubjectId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (25, N'CHƯƠNG CON 1', N'Chuong con 1', 1, 2, 7, NULL, 0, 0, N'CHUONGCON1')
SET IDENTITY_INSERT [dbo].[Chapters] OFF
SET IDENTITY_INSERT [dbo].[Exams] ON 

INSERT [dbo].[Exams] ([Id], [Name], [CreateDate], [Desktop], [Deleted], [UserId]) VALUES (1, N'HK1A 2020-2021 EDIT', CAST(N'2021-04-08T18:56:06.4294150' AS DateTime2), 0, 1, NULL)
INSERT [dbo].[Exams] ([Id], [Name], [CreateDate], [Desktop], [Deleted], [UserId]) VALUES (2, N'HK1B 2020-2021', CAST(N'2021-04-08T19:05:14.7474459' AS DateTime2), 0, 1, NULL)
INSERT [dbo].[Exams] ([Id], [Name], [CreateDate], [Desktop], [Deleted], [UserId]) VALUES (3, N'HK1B - Cuối kỳ - NH 2021_2022', CAST(N'2021-05-14T22:01:48.6906589' AS DateTime2), 0, 0, NULL)
SET IDENTITY_INSERT [dbo].[Exams] OFF
SET IDENTITY_INSERT [dbo].[Faculties] ON 

INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Deleted], [Validated], [FolderName]) VALUES (1, N'CÔNG NGHỆ THÔNG TIN', N' ', 0, 0, N'KHOACNTT')
INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Deleted], [Validated], [FolderName]) VALUES (2, N'XÂY DỰNG', N' ', 0, 0, N'KHOAXAYDUNG')
INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Deleted], [Validated], [FolderName]) VALUES (3, N'DƯỢC', N' ', 0, 0, N'KHOADUOC')
INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Deleted], [Validated], [FolderName]) VALUES (4, N'Tiếng Anh', N' ', 0, 0, N'KHOATIENGANH')
INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Deleted], [Validated], [FolderName]) VALUES (5, N'Hệ Thống Thông Tin Quản Lý', N' ', 0, 0, N'KHOAHTTT')
INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Deleted], [Validated], [FolderName]) VALUES (6, N'Kế toán', NULL, 0, 0, N'KHOAKETOAN')
INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Deleted], [Validated], [FolderName]) VALUES (7, N'Marketing', NULL, 0, 0, N'KHOAMARKETING')
INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Deleted], [Validated], [FolderName]) VALUES (8, N'Du lịch - Nhà hàng - Khách sạn', NULL, 0, 0, N'KHOADLNH')
INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Deleted], [Validated], [FolderName]) VALUES (9, N'Quản trị kinh doanh', NULL, 1, 0, N'KHOAQUANTRIKD')
INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Deleted], [Validated], [FolderName]) VALUES (10, N'Tài chính', NULL, 0, 0, N'KHOATAICHINH')
INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Deleted], [Validated], [FolderName]) VALUES (11, N'Ngân hàng', N' ', 1, 0, N'KHOANGANHANG')
INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Deleted], [Validated], [FolderName]) VALUES (15, N'Công Nghệ Ô Tô', N' ', 0, 0, N'KHOACONGNGHEOTO')
INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Deleted], [Validated], [FolderName]) VALUES (16, N'Thú Y', N' ', 0, 0, N'KHOATHUY')
INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Deleted], [Validated], [FolderName]) VALUES (17, N'Công nghệ thực phẩm', N' ', 0, 0, N'KHOACONGNGHETP')
INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Deleted], [Validated], [FolderName]) VALUES (18, N'TÀI CHÍNH EDIT', N' ', 1, 1, N'KHOANTAICHINH')
INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Deleted], [Validated], [FolderName]) VALUES (19, N'THÚ Ý', N' ', 0, 0, N'KHOA THU Y ')
INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Deleted], [Validated], [FolderName]) VALUES (20, N'VI DU 2', N' ', 0, 1, N'KHOAVIDU2')
INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Deleted], [Validated], [FolderName]) VALUES (21, N'EXAMPLE', N' ', 1, 0, N'KHOAEXAMPLE')
INSERT [dbo].[Faculties] ([Id], [Name], [Comment], [Deleted], [Validated], [FolderName]) VALUES (22, N'EXAMPLE', N' ', 1, 0, N'KHOAEXAMPLE')
SET IDENTITY_INSERT [dbo].[Faculties] OFF
SET IDENTITY_INSERT [dbo].[Matrices] ON 

INSERT [dbo].[Matrices] ([Id], [ExamId], [CreateDate], [Name], [SubjectId]) VALUES (1, 3, CAST(N'2021-05-14T22:02:46.6409669' AS DateTime2), N'MaTranTest', NULL)
SET IDENTITY_INSERT [dbo].[Matrices] OFF
SET IDENTITY_INSERT [dbo].[MatrixDetails] ON 

INSERT [dbo].[MatrixDetails] ([Id], [MatrixId], [ChapterId], [Quantity], [Excluded], [Factor]) VALUES (1, 1, 1, 5, N'0', 1)
INSERT [dbo].[MatrixDetails] ([Id], [MatrixId], [ChapterId], [Quantity], [Excluded], [Factor]) VALUES (2, 1, 2, 5, N'0', 1)
INSERT [dbo].[MatrixDetails] ([Id], [MatrixId], [ChapterId], [Quantity], [Excluded], [Factor]) VALUES (3, 1, 3, 5, N'0', 1)
SET IDENTITY_INSERT [dbo].[MatrixDetails] OFF
SET IDENTITY_INSERT [dbo].[Questions] ON 

INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (1, N'Noi dung cau hoi don EDIT', 1, CAST(0.00 AS Decimal(18, 2)), CAST(0.50 AS Decimal(18, 2)), 10, 5, 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2021-02-24T09:17:01.0230430' AS DateTime2), CAST(0.50 AS Decimal(18, 2)), 10, 0, 0, CAST(0.50 AS Decimal(18, 2)), 5, 10, NULL, 0, 1)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (2, N'If I (to study)______________, I (to pass) ______________the exams.', 1, CAST(0.50 AS Decimal(18, 2)), CAST(0.50 AS Decimal(18, 2)), 11, 5, 2, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2021-02-24T09:17:01.0230430' AS DateTime2), CAST(0.50 AS Decimal(18, 2)), 10, 0, 0, CAST(0.50 AS Decimal(18, 2)), 4, 7, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (3, N'Kháng sinh Gentamycin gây ức chế sự tổng hợp protein của vi khuẩn. Chọn câu đúng về Gentamycin: ', 1, CAST(0.50 AS Decimal(18, 2)), CAST(0.50 AS Decimal(18, 2)), 10, 5, 3, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2021-02-24T09:17:01.0230430' AS DateTime2), CAST(0.50 AS Decimal(18, 2)), 10, 0, 0, CAST(0.50 AS Decimal(18, 2)), 3, 1, NULL, 0, 1)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (4, N'Khoan thăm dò thường khoan tối đa sâu bao nhiêu m? ', 1, CAST(0.50 AS Decimal(18, 2)), CAST(0.50 AS Decimal(18, 2)), 10, 5, 4, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2021-02-24T09:17:01.0230430' AS DateTime2), CAST(0.50 AS Decimal(18, 2)), 10, 0, 0, CAST(0.50 AS Decimal(18, 2)), 2, 3, NULL, 0, 1)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (5, N'Câu lệnh nào đúng khi định nghĩa một biến số nguyên sum: ', 1, CAST(0.50 AS Decimal(18, 2)), CAST(0.50 AS Decimal(18, 2)), 10, 5, 5, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2021-02-24T09:17:01.0230430' AS DateTime2), CAST(0.50 AS Decimal(18, 2)), 10, 0, 0, CAST(0.50 AS Decimal(18, 2)), 1, 5, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (9, N'1 + 1 = ?', 1, CAST(0.50 AS Decimal(18, 2)), CAST(0.50 AS Decimal(18, 2)), 11, 5, 1, CAST(N'2020-10-08T15:31:07.5490415' AS DateTime2), CAST(N'2021-02-24T09:17:01.0230430' AS DateTime2), CAST(0.50 AS Decimal(18, 2)), 10, 0, 0, CAST(0.50 AS Decimal(18, 2)), 5, 10, 0, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (13, N'Noi dung cau hoi don EDIT 2', 1, CAST(0.00 AS Decimal(18, 2)), CAST(0.50 AS Decimal(18, 2)), 11, 5, 1, CAST(N'2020-10-09T15:20:59.6781210' AS DateTime2), CAST(N'2021-04-01T22:15:52.4955264' AS DateTime2), CAST(0.50 AS Decimal(18, 2)), 10, 0, 0, CAST(0.50 AS Decimal(18, 2)), 5, 10, 0, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (139, N'[<egc>] EDIT Noi dung cau hoi cha[</egc>]Noi dung cau hoi con 1', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 1, CAST(N'2020-12-01T14:53:52.6608437' AS DateTime2), CAST(N'2021-02-24T09:59:02.5842458' AS DateTime2), NULL, NULL, 139, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (140, N'Câu hỏi con 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 1, CAST(N'2020-12-01T14:53:53.1967113' AS DateTime2), CAST(N'2021-02-24T09:59:02.5931696' AS DateTime2), NULL, NULL, 139, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (181, N'Noi dung cau hoi EDIT', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 1, CAST(N'2021-01-13T21:47:58.8994191' AS DateTime2), CAST(N'2021-01-13T21:57:24.0835954' AS DateTime2), NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (182, N'[<egc>] EDIT 2 Noi dung cau hoi cha[</egc>]Noi dung cau hoi con 1', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 1, CAST(N'2021-01-13T21:49:09.3058376' AS DateTime2), CAST(N'2021-04-01T22:00:32.0802137' AS DateTime2), NULL, NULL, 182, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (183, N'Câu hỏi con 2 EDIT', 0, CAST(0.50 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 1, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-04-01T22:00:32.0956378' AS DateTime2), NULL, NULL, 182, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (246, N'Câu hỏi', 0, CAST(0.50 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 1, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (247, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.50 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 1, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 1, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (248, N'Câu hỏi', 0, CAST(0.50 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 1, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (249, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.50 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 2, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 1, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (250, N'Câu hỏi', 0, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 2, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (251, N'Câu hỏi', 0, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 2, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (252, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 2, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 1, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (253, N'Câu hỏi', 0, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 2, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (254, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 2, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 1, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (255, N'Câu hỏi', 0, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 2, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (256, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.20 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 3, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 1, NULL, NULL, NULL, NULL, 0, 1)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (257, N'Câu hỏi', 0, CAST(0.20 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 3, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 0, NULL, NULL, NULL, NULL, 0, 1)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (258, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.20 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 3, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 1, NULL, NULL, NULL, NULL, 0, 1)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (259, N'Câu hỏi', 0, CAST(0.20 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 3, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 0, NULL, NULL, NULL, NULL, 0, 1)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (260, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.40 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 3, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 1, NULL, NULL, NULL, NULL, 0, 1)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (261, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.40 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 4, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 1, NULL, NULL, NULL, NULL, 0, 1)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (262, N'Câu hỏi', 0, CAST(0.40 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 4, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 0, NULL, NULL, NULL, NULL, 0, 1)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (263, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.40 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 4, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 1, NULL, NULL, NULL, NULL, 0, 1)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (264, N'Câu hỏi', 0, CAST(0.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 4, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 0, NULL, NULL, NULL, NULL, 0, 1)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (265, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 4, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 1, NULL, NULL, NULL, NULL, 0, 1)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (266, N'Câu hỏi', 0, CAST(0.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 4, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 0, NULL, NULL, NULL, NULL, 0, 1)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (267, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 4, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 1, NULL, NULL, NULL, NULL, 0, 1)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (268, N'Câu hỏi', 0, CAST(0.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 5, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (269, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 5, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 1, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (270, N'Câu hỏi', 0, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 5, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (271, N'Câu hỏi', 0, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 5, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (272, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.20 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 5, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 1, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (273, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.20 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 5, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 1, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (274, N'Câu hỏi', 0, CAST(0.20 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 5, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (275, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.20 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 5, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 1, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (276, N'Câu hỏi', 0, CAST(0.40 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 2, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (277, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.40 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 2, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 1, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (278, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.40 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 3, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 1, NULL, NULL, NULL, NULL, 0, 1)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (279, N'Câu hỏi', 0, CAST(0.40 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 3, CAST(N'2021-01-13T21:49:09.3108116' AS DateTime2), CAST(N'2021-01-13T22:06:24.9254078' AS DateTime2), NULL, NULL, 182, 0, NULL, NULL, NULL, NULL, 0, 1)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (294, N'Câu hỏi', 0, CAST(0.40 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 2, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (295, N'Noi dung cau hoi', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 9, CAST(N'2021-05-08T11:09:45.9737394' AS DateTime2), CAST(N'2021-05-08T11:09:45.9742979' AS DateTime2), NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (298, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 1, CAST(N'2021-05-14T21:18:50.6258874' AS DateTime2), CAST(N'2021-05-14T21:18:50.6258979' AS DateTime2), NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (299, N'Noi dung cau hoi', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 1, CAST(N'2021-05-14T21:18:55.2062962' AS DateTime2), CAST(N'2021-05-14T21:18:55.2063030' AS DateTime2), NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (300, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 1, CAST(N'2021-05-14T21:18:56.3530116' AS DateTime2), CAST(N'2021-05-14T21:18:56.3530179' AS DateTime2), NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (301, N'Noi dung cau hoi', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 1, CAST(N'2021-05-14T21:18:57.3126569' AS DateTime2), CAST(N'2021-05-14T21:18:57.3126682' AS DateTime2), NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (302, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 1, CAST(N'2021-05-14T21:18:58.4456360' AS DateTime2), CAST(N'2021-05-14T21:18:58.4456461' AS DateTime2), NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (303, N'Noi dung cau hoi', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 1, CAST(N'2021-05-14T21:18:59.2939758' AS DateTime2), CAST(N'2021-05-14T21:18:59.2939862' AS DateTime2), NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (304, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 1, CAST(N'2021-05-14T21:19:00.5328249' AS DateTime2), CAST(N'2021-05-14T21:19:00.5328348' AS DateTime2), NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (305, N'Noi dung cau hoi', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 1, CAST(N'2021-05-14T21:19:01.6470260' AS DateTime2), CAST(N'2021-05-14T21:19:01.6470355' AS DateTime2), NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (306, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 1, CAST(N'2021-05-14T21:19:02.5697270' AS DateTime2), CAST(N'2021-05-14T21:19:02.5697380' AS DateTime2), NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (307, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 1, CAST(N'2021-05-14T21:19:03.6520209' AS DateTime2), CAST(N'2021-05-14T21:19:03.6520309' AS DateTime2), NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (308, N'Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 2, CAST(N'2021-05-14T21:19:15.6061248' AS DateTime2), CAST(N'2021-05-14T21:19:15.6061320' AS DateTime2), NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (309, N'Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 2, CAST(N'2021-05-14T21:19:16.5868869' AS DateTime2), CAST(N'2021-05-14T21:19:16.5868957' AS DateTime2), NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (310, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 2, CAST(N'2021-05-14T21:19:17.2502989' AS DateTime2), CAST(N'2021-05-14T21:19:17.2503068' AS DateTime2), NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (311, N'Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 2, CAST(N'2021-05-14T21:19:17.9181551' AS DateTime2), CAST(N'2021-05-14T21:19:17.9181607' AS DateTime2), NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (312, N'Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 2, CAST(N'2021-05-14T21:19:18.5681704' AS DateTime2), CAST(N'2021-05-14T21:19:18.5681789' AS DateTime2), NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (313, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 2, CAST(N'2021-05-14T21:19:19.3022807' AS DateTime2), CAST(N'2021-05-14T21:19:19.3022908' AS DateTime2), NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (314, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 2, CAST(N'2021-05-14T21:19:19.9656486' AS DateTime2), CAST(N'2021-05-14T21:19:19.9656503' AS DateTime2), NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (315, N'Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 2, CAST(N'2021-05-14T21:19:20.6928205' AS DateTime2), CAST(N'2021-05-14T21:19:20.6928213' AS DateTime2), NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (316, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 2, CAST(N'2021-05-14T21:19:21.5302175' AS DateTime2), CAST(N'2021-05-14T21:19:21.5302190' AS DateTime2), NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (317, N'Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 2, CAST(N'2021-05-14T21:19:22.2992946' AS DateTime2), CAST(N'2021-05-14T21:19:22.2993047' AS DateTime2), NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (318, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 3, CAST(N'2021-05-14T21:19:26.3802485' AS DateTime2), CAST(N'2021-05-14T21:19:26.3802496' AS DateTime2), NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (319, N'Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 3, CAST(N'2021-05-14T21:19:27.1536600' AS DateTime2), CAST(N'2021-05-14T21:19:27.1536610' AS DateTime2), NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (320, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 3, CAST(N'2021-05-14T21:19:27.8713740' AS DateTime2), CAST(N'2021-05-14T21:19:27.8713757' AS DateTime2), NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (321, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 3, CAST(N'2021-05-14T21:19:28.5765821' AS DateTime2), CAST(N'2021-05-14T21:19:28.5765831' AS DateTime2), NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (322, N'Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 3, CAST(N'2021-05-14T21:19:29.2913510' AS DateTime2), CAST(N'2021-05-14T21:19:29.2913524' AS DateTime2), NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (323, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 3, CAST(N'2021-05-14T21:19:29.9139711' AS DateTime2), CAST(N'2021-05-14T21:19:29.9139735' AS DateTime2), NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (324, N'Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 3, CAST(N'2021-05-14T21:19:30.6273813' AS DateTime2), CAST(N'2021-05-14T21:19:30.6273825' AS DateTime2), NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (325, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 3, CAST(N'2021-05-14T21:19:31.3653073' AS DateTime2), CAST(N'2021-05-14T21:19:31.3653093' AS DateTime2), NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (326, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 3, CAST(N'2021-05-14T21:19:32.2926736' AS DateTime2), CAST(N'2021-05-14T21:19:32.2926744' AS DateTime2), NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Questions] ([Id], [Content], [Interchange], [SubjectiveDifficulty], [ObjectiveDifficulty], [SelectedTimes], [CorrectTimes], [ChapterId], [CreateDate], [UpdateDate], [Mark], [Duration], [ParentId], [Audio], [Discrimination], [ManagementOrder], [SubjectId], [ListenedTimes], [Validated], [Deleted]) VALUES (327, N'[<audio>]KHOAHTTT:MONPTDL1:CHUONG5:audio:4a801646-7288-4cb3-8adf-83919cb6c56f.mp3[</audio>[<img>]KHOAHTTT:MONPTDL1:CHUONG5:image:0af28a12-d6ac-47f8-9c60-18be6ca13519.jpg[</img>]Noi dung cau hoi 2', 0, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, 3, CAST(N'2021-05-14T21:19:33.0589899' AS DateTime2), CAST(N'2021-05-14T21:19:33.0589908' AS DateTime2), NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, 0, 0)
SET IDENTITY_INSERT [dbo].[Questions] OFF
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (1, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:42.7511573' AS DateTime2), CAST(N'2021-05-15T09:42:42.7511573' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (1, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:42.7511573' AS DateTime2), CAST(N'2021-05-15T09:42:42.7511573' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (1, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:42.7511573' AS DateTime2), CAST(N'2021-05-15T09:42:42.7511573' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (1, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:42.7511573' AS DateTime2), CAST(N'2021-05-15T09:42:42.7511573' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (1, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:42.7511573' AS DateTime2), CAST(N'2021-05-15T09:42:42.7511573' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (2, 139, 1, 169, 0, CAST(N'2021-05-15T09:42:42.7511573' AS DateTime2), CAST(N'2021-05-15T09:42:42.7511573' AS DateTime2), 3, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (2, 140, 2, 171, 0, CAST(N'2021-05-15T09:42:42.7511573' AS DateTime2), CAST(N'2021-05-15T09:42:42.7511573' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (3, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:42.7511573' AS DateTime2), CAST(N'2021-05-15T09:42:42.7511573' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (3, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:42.7511573' AS DateTime2), CAST(N'2021-05-15T09:42:42.7511573' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (3, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:42.7511573' AS DateTime2), CAST(N'2021-05-15T09:42:42.7511573' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (3, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:42.7511573' AS DateTime2), CAST(N'2021-05-15T09:42:42.7511573' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (3, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:42.7511573' AS DateTime2), CAST(N'2021-05-15T09:42:42.7511573' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (4, 139, 1, NULL, 0, CAST(N'2021-05-15T09:42:42.9560416' AS DateTime2), CAST(N'2021-05-15T09:42:42.9560416' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (4, 140, 2, NULL, 0, CAST(N'2021-05-15T09:42:42.9560416' AS DateTime2), CAST(N'2021-05-15T09:42:42.9560416' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (5, 139, 1, NULL, 0, CAST(N'2021-05-15T09:42:42.9580395' AS DateTime2), CAST(N'2021-05-15T09:42:42.9580395' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (5, 140, 2, NULL, 0, CAST(N'2021-05-15T09:42:42.9580395' AS DateTime2), CAST(N'2021-05-15T09:42:42.9580395' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (6, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:42.9600372' AS DateTime2), CAST(N'2021-05-15T09:42:42.9600372' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (6, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:42.9600372' AS DateTime2), CAST(N'2021-05-15T09:42:42.9600372' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (6, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:42.9600372' AS DateTime2), CAST(N'2021-05-15T09:42:42.9600372' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (6, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:42.9600372' AS DateTime2), CAST(N'2021-05-15T09:42:42.9600372' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (6, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:42.9600372' AS DateTime2), CAST(N'2021-05-15T09:42:42.9600372' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (7, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.0709738' AS DateTime2), CAST(N'2021-05-15T09:42:43.0709738' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (7, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.0709738' AS DateTime2), CAST(N'2021-05-15T09:42:43.0709738' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (7, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:43.0709738' AS DateTime2), CAST(N'2021-05-15T09:42:43.0709738' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (7, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:43.0709738' AS DateTime2), CAST(N'2021-05-15T09:42:43.0709738' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (7, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:43.0709738' AS DateTime2), CAST(N'2021-05-15T09:42:43.0709738' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (8, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.0759710' AS DateTime2), CAST(N'2021-05-15T09:42:43.0759710' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (8, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.0759710' AS DateTime2), CAST(N'2021-05-15T09:42:43.0759710' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (8, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:43.0759710' AS DateTime2), CAST(N'2021-05-15T09:42:43.0759710' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (8, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:43.0759710' AS DateTime2), CAST(N'2021-05-15T09:42:43.0759710' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (8, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:43.0759710' AS DateTime2), CAST(N'2021-05-15T09:42:43.0759710' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (9, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.0819693' AS DateTime2), CAST(N'2021-05-15T09:42:43.0819693' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (9, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.0819693' AS DateTime2), CAST(N'2021-05-15T09:42:43.0819693' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (9, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:43.0819693' AS DateTime2), CAST(N'2021-05-15T09:42:43.0819693' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (9, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:43.0819693' AS DateTime2), CAST(N'2021-05-15T09:42:43.0819693' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (9, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:43.0819693' AS DateTime2), CAST(N'2021-05-15T09:42:43.0819693' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (10, 139, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.1799115' AS DateTime2), CAST(N'2021-05-15T09:42:43.1799115' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (10, 140, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.1799115' AS DateTime2), CAST(N'2021-05-15T09:42:43.1799115' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (11, 139, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.2200268' AS DateTime2), CAST(N'2021-05-15T09:42:43.2200268' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (11, 140, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.2200268' AS DateTime2), CAST(N'2021-05-15T09:42:43.2200268' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (12, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.2230198' AS DateTime2), CAST(N'2021-05-15T09:42:43.2230198' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (12, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.2230198' AS DateTime2), CAST(N'2021-05-15T09:42:43.2230198' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (12, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:43.2230198' AS DateTime2), CAST(N'2021-05-15T09:42:43.2230198' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (12, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:43.2230198' AS DateTime2), CAST(N'2021-05-15T09:42:43.2230198' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (12, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:43.2230198' AS DateTime2), CAST(N'2021-05-15T09:42:43.2230198' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (13, 139, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.2974247' AS DateTime2), CAST(N'2021-05-15T09:42:43.2974247' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (13, 140, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.2974247' AS DateTime2), CAST(N'2021-05-15T09:42:43.2974247' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (14, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.3284776' AS DateTime2), CAST(N'2021-05-15T09:42:43.3284776' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (14, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.3284776' AS DateTime2), CAST(N'2021-05-15T09:42:43.3284776' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (14, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:43.3284776' AS DateTime2), CAST(N'2021-05-15T09:42:43.3284776' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (14, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:43.3284776' AS DateTime2), CAST(N'2021-05-15T09:42:43.3284776' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (14, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:43.3284776' AS DateTime2), CAST(N'2021-05-15T09:42:43.3284776' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (15, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.3294775' AS DateTime2), CAST(N'2021-05-15T09:42:43.3294775' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (15, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.3294775' AS DateTime2), CAST(N'2021-05-15T09:42:43.3294775' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (15, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:43.3294775' AS DateTime2), CAST(N'2021-05-15T09:42:43.3294775' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (15, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:43.3294775' AS DateTime2), CAST(N'2021-05-15T09:42:43.3294775' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (15, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:43.3294775' AS DateTime2), CAST(N'2021-05-15T09:42:43.3294775' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (16, 139, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.3959674' AS DateTime2), CAST(N'2021-05-15T09:42:43.3959674' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (16, 140, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.3959674' AS DateTime2), CAST(N'2021-05-15T09:42:43.3959674' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (17, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.4239730' AS DateTime2), CAST(N'2021-05-15T09:42:43.4239730' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (17, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.4239730' AS DateTime2), CAST(N'2021-05-15T09:42:43.4239730' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (17, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:43.4239730' AS DateTime2), CAST(N'2021-05-15T09:42:43.4239730' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (17, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:43.4239730' AS DateTime2), CAST(N'2021-05-15T09:42:43.4239730' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (17, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:43.4239730' AS DateTime2), CAST(N'2021-05-15T09:42:43.4239730' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (18, 139, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.4239730' AS DateTime2), CAST(N'2021-05-15T09:42:43.4239730' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (18, 140, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.4239730' AS DateTime2), CAST(N'2021-05-15T09:42:43.4239730' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (19, 139, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.5270774' AS DateTime2), CAST(N'2021-05-15T09:42:43.5270774' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (19, 140, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.5270774' AS DateTime2), CAST(N'2021-05-15T09:42:43.5270774' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (20, 139, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.5280774' AS DateTime2), CAST(N'2021-05-15T09:42:43.5280774' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (20, 140, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.5280774' AS DateTime2), CAST(N'2021-05-15T09:42:43.5280774' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (21, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.5280774' AS DateTime2), CAST(N'2021-05-15T09:42:43.5280774' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (21, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.5280774' AS DateTime2), CAST(N'2021-05-15T09:42:43.5280774' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (21, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:43.5280774' AS DateTime2), CAST(N'2021-05-15T09:42:43.5280774' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (21, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:43.5280774' AS DateTime2), CAST(N'2021-05-15T09:42:43.5280774' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (21, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:43.5280774' AS DateTime2), CAST(N'2021-05-15T09:42:43.5280774' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (22, 139, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.5763322' AS DateTime2), CAST(N'2021-05-15T09:42:43.5763322' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (22, 140, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.5763322' AS DateTime2), CAST(N'2021-05-15T09:42:43.5763322' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (23, 139, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.5793288' AS DateTime2), CAST(N'2021-05-15T09:42:43.5793288' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (23, 140, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.5793288' AS DateTime2), CAST(N'2021-05-15T09:42:43.5793288' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (24, 139, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.5813292' AS DateTime2), CAST(N'2021-05-15T09:42:43.5813292' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (24, 140, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.5813292' AS DateTime2), CAST(N'2021-05-15T09:42:43.5813292' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (25, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.6802927' AS DateTime2), CAST(N'2021-05-15T09:42:43.6802927' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (25, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.6802927' AS DateTime2), CAST(N'2021-05-15T09:42:43.6802927' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (25, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:43.6802927' AS DateTime2), CAST(N'2021-05-15T09:42:43.6802927' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (25, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:43.6802927' AS DateTime2), CAST(N'2021-05-15T09:42:43.6802927' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (25, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:43.6802927' AS DateTime2), CAST(N'2021-05-15T09:42:43.6802927' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (26, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.6832909' AS DateTime2), CAST(N'2021-05-15T09:42:43.6832909' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (26, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.6832909' AS DateTime2), CAST(N'2021-05-15T09:42:43.6832909' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (26, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:43.6832909' AS DateTime2), CAST(N'2021-05-15T09:42:43.6832909' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (26, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:43.6832909' AS DateTime2), CAST(N'2021-05-15T09:42:43.6832909' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (26, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:43.6832909' AS DateTime2), CAST(N'2021-05-15T09:42:43.6832909' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (27, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.6863000' AS DateTime2), CAST(N'2021-05-15T09:42:43.6863000' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (27, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.6863000' AS DateTime2), CAST(N'2021-05-15T09:42:43.6863000' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (27, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:43.6863000' AS DateTime2), CAST(N'2021-05-15T09:42:43.6863000' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (27, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:43.6863000' AS DateTime2), CAST(N'2021-05-15T09:42:43.6863000' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (27, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:43.6863000' AS DateTime2), CAST(N'2021-05-15T09:42:43.6863000' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (28, 139, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.7742556' AS DateTime2), CAST(N'2021-05-15T09:42:43.7742556' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (28, 140, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.7742556' AS DateTime2), CAST(N'2021-05-15T09:42:43.7742556' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (29, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.7772528' AS DateTime2), CAST(N'2021-05-15T09:42:43.7772528' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (29, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.7772528' AS DateTime2), CAST(N'2021-05-15T09:42:43.7772528' AS DateTime2), NULL, 0, 0)
GO
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (29, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:43.7772528' AS DateTime2), CAST(N'2021-05-15T09:42:43.7772528' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (29, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:43.7772528' AS DateTime2), CAST(N'2021-05-15T09:42:43.7772528' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (29, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:43.7772528' AS DateTime2), CAST(N'2021-05-15T09:42:43.7772528' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (30, 139, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.7802513' AS DateTime2), CAST(N'2021-05-15T09:42:43.7802513' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (30, 140, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.7802513' AS DateTime2), CAST(N'2021-05-15T09:42:43.7802513' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (31, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.8647466' AS DateTime2), CAST(N'2021-05-15T09:42:43.8647466' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (31, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.8647466' AS DateTime2), CAST(N'2021-05-15T09:42:43.8647466' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (31, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:43.8647466' AS DateTime2), CAST(N'2021-05-15T09:42:43.8647466' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (31, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:43.8647466' AS DateTime2), CAST(N'2021-05-15T09:42:43.8647466' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (31, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:43.8647466' AS DateTime2), CAST(N'2021-05-15T09:42:43.8647466' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (32, 139, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.8907300' AS DateTime2), CAST(N'2021-05-15T09:42:43.8907300' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (32, 140, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.8917310' AS DateTime2), CAST(N'2021-05-15T09:42:43.8917310' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (33, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.8917310' AS DateTime2), CAST(N'2021-05-15T09:42:43.8917310' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (33, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.8917310' AS DateTime2), CAST(N'2021-05-15T09:42:43.8917310' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (33, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:43.8917310' AS DateTime2), CAST(N'2021-05-15T09:42:43.8917310' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (33, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:43.8917310' AS DateTime2), CAST(N'2021-05-15T09:42:43.8917310' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (33, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:43.8917310' AS DateTime2), CAST(N'2021-05-15T09:42:43.8917310' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (34, 139, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.9456979' AS DateTime2), CAST(N'2021-05-15T09:42:43.9456979' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (34, 140, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.9456979' AS DateTime2), CAST(N'2021-05-15T09:42:43.9456979' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (35, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.9476989' AS DateTime2), CAST(N'2021-05-15T09:42:43.9476989' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (35, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.9476989' AS DateTime2), CAST(N'2021-05-15T09:42:43.9476989' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (35, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:43.9476989' AS DateTime2), CAST(N'2021-05-15T09:42:43.9476989' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (35, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:43.9476989' AS DateTime2), CAST(N'2021-05-15T09:42:43.9476989' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (35, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:43.9476989' AS DateTime2), CAST(N'2021-05-15T09:42:43.9476989' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (36, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:43.9496954' AS DateTime2), CAST(N'2021-05-15T09:42:43.9496954' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (36, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:43.9496954' AS DateTime2), CAST(N'2021-05-15T09:42:43.9496954' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (36, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:43.9496954' AS DateTime2), CAST(N'2021-05-15T09:42:43.9496954' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (36, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:43.9496954' AS DateTime2), CAST(N'2021-05-15T09:42:43.9496954' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (36, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:43.9496954' AS DateTime2), CAST(N'2021-05-15T09:42:43.9496954' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (37, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:44.0257198' AS DateTime2), CAST(N'2021-05-15T09:42:44.0257198' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (37, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:44.0257198' AS DateTime2), CAST(N'2021-05-15T09:42:44.0257198' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (37, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:44.0257198' AS DateTime2), CAST(N'2021-05-15T09:42:44.0257198' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (37, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:44.0257198' AS DateTime2), CAST(N'2021-05-15T09:42:44.0257198' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (37, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:44.0257198' AS DateTime2), CAST(N'2021-05-15T09:42:44.0257198' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (38, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:44.0287179' AS DateTime2), CAST(N'2021-05-15T09:42:44.0287179' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (38, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:44.0287179' AS DateTime2), CAST(N'2021-05-15T09:42:44.0287179' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (38, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:44.0287179' AS DateTime2), CAST(N'2021-05-15T09:42:44.0287179' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (38, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:44.0287179' AS DateTime2), CAST(N'2021-05-15T09:42:44.0287179' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (38, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:44.0287179' AS DateTime2), CAST(N'2021-05-15T09:42:44.0287179' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (39, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:44.0625025' AS DateTime2), CAST(N'2021-05-15T09:42:44.0625025' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (39, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:44.0625025' AS DateTime2), CAST(N'2021-05-15T09:42:44.0625025' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (39, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:44.0625025' AS DateTime2), CAST(N'2021-05-15T09:42:44.0625025' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (39, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:44.0625025' AS DateTime2), CAST(N'2021-05-15T09:42:44.0625025' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (39, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:44.0625025' AS DateTime2), CAST(N'2021-05-15T09:42:44.0625025' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (40, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:44.1584474' AS DateTime2), CAST(N'2021-05-15T09:42:44.1584474' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (40, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:44.1584474' AS DateTime2), CAST(N'2021-05-15T09:42:44.1584474' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (40, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:44.1584474' AS DateTime2), CAST(N'2021-05-15T09:42:44.1584474' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (40, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:44.1584474' AS DateTime2), CAST(N'2021-05-15T09:42:44.1584474' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (40, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:44.1584474' AS DateTime2), CAST(N'2021-05-15T09:42:44.1584474' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (41, 139, 1, NULL, 0, CAST(N'2021-05-15T09:42:44.1894302' AS DateTime2), CAST(N'2021-05-15T09:42:44.1894302' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (41, 140, 2, NULL, 0, CAST(N'2021-05-15T09:42:44.1894302' AS DateTime2), CAST(N'2021-05-15T09:42:44.1894302' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (42, 139, 1, NULL, 0, CAST(N'2021-05-15T09:42:44.1904287' AS DateTime2), CAST(N'2021-05-15T09:42:44.1904287' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (42, 140, 2, NULL, 0, CAST(N'2021-05-15T09:42:44.1904287' AS DateTime2), CAST(N'2021-05-15T09:42:44.1904287' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (43, 139, 1, NULL, 0, CAST(N'2021-05-15T09:42:44.2734276' AS DateTime2), CAST(N'2021-05-15T09:42:44.2734276' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (43, 140, 2, NULL, 0, CAST(N'2021-05-15T09:42:44.2734276' AS DateTime2), CAST(N'2021-05-15T09:42:44.2734276' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (44, 139, 1, NULL, 0, CAST(N'2021-05-15T09:42:44.2754275' AS DateTime2), CAST(N'2021-05-15T09:42:44.2754275' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (44, 140, 2, NULL, 0, CAST(N'2021-05-15T09:42:44.2754275' AS DateTime2), CAST(N'2021-05-15T09:42:44.2754275' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (45, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:44.2784238' AS DateTime2), CAST(N'2021-05-15T09:42:44.2784238' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (45, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:44.2784238' AS DateTime2), CAST(N'2021-05-15T09:42:44.2784238' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (45, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:44.2784238' AS DateTime2), CAST(N'2021-05-15T09:42:44.2784238' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (45, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:44.2784238' AS DateTime2), CAST(N'2021-05-15T09:42:44.2784238' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (45, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:44.2784238' AS DateTime2), CAST(N'2021-05-15T09:42:44.2784238' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (46, 139, 1, NULL, 0, CAST(N'2021-05-15T09:42:44.3694006' AS DateTime2), CAST(N'2021-05-15T09:42:44.3694006' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (46, 140, 2, NULL, 0, CAST(N'2021-05-15T09:42:44.3694006' AS DateTime2), CAST(N'2021-05-15T09:42:44.3694006' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (47, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:44.3733987' AS DateTime2), CAST(N'2021-05-15T09:42:44.3733987' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (47, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:44.3733987' AS DateTime2), CAST(N'2021-05-15T09:42:44.3733987' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (47, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:44.3733987' AS DateTime2), CAST(N'2021-05-15T09:42:44.3733987' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (47, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:44.3733987' AS DateTime2), CAST(N'2021-05-15T09:42:44.3733987' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (47, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:44.3733987' AS DateTime2), CAST(N'2021-05-15T09:42:44.3733987' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (48, 182, 1, NULL, 0, CAST(N'2021-05-15T09:42:44.3743975' AS DateTime2), CAST(N'2021-05-15T09:42:44.3743975' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (48, 183, 2, NULL, 0, CAST(N'2021-05-15T09:42:44.3743975' AS DateTime2), CAST(N'2021-05-15T09:42:44.3743975' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (48, 246, 3, NULL, 0, CAST(N'2021-05-15T09:42:44.3743975' AS DateTime2), CAST(N'2021-05-15T09:42:44.3743975' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (48, 247, 4, NULL, 0, CAST(N'2021-05-15T09:42:44.3743975' AS DateTime2), CAST(N'2021-05-15T09:42:44.3743975' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (48, 248, 5, NULL, 0, CAST(N'2021-05-15T09:42:44.3743975' AS DateTime2), CAST(N'2021-05-15T09:42:44.3743975' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (49, 2, 9, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (49, 9, 4, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (49, 13, 5, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (49, 139, 2, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (49, 140, 3, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (49, 302, 1, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (49, 310, 6, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (49, 314, 8, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (49, 315, 7, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (49, 316, 10, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (49, 321, 12, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (49, 322, 11, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (49, 323, 13, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (49, 324, 14, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (49, 327, 15, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (50, 2, 9, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (50, 9, 1, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (50, 13, 3, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (50, 181, 4, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (50, 299, 5, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (50, 302, 2, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (50, 309, 6, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (50, 313, 8, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (50, 315, 10, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (50, 316, 7, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), 1, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (50, 320, 11, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
GO
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (50, 321, 15, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (50, 325, 13, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (50, 326, 14, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (50, 327, 12, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), 1, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (51, 2, 7, 12, 1, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (51, 9, 4, NULL, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (51, 13, 2, 19, 1, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (51, 301, 5, 292, 1, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (51, 306, 3, 302, 1, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (51, 307, 1, 304, 1, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (51, 308, 6, 306, 1, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (51, 310, 10, 310, 1, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (51, 312, 9, 315, 0, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (51, 317, 8, 324, 1, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (51, 321, 15, 332, 1, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (51, 322, 14, 334, 1, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (51, 324, 13, 338, 1, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (51, 325, 11, 340, 1, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (51, 326, 12, 342, 1, CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), CAST(N'2021-05-15T11:36:00.5067079' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (52, 2, 10, NULL, 0, CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (52, 9, 5, NULL, 0, CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (52, 13, 1, NULL, 0, CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (52, 139, 2, NULL, 0, CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (52, 140, 3, NULL, 0, CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (52, 301, 4, NULL, 0, CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (52, 308, 9, NULL, 0, CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (52, 311, 6, NULL, 0, CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (52, 313, 8, NULL, 0, CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (52, 316, 7, NULL, 0, CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (52, 321, 14, NULL, 0, CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (52, 322, 15, NULL, 0, CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (52, 323, 11, NULL, 0, CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (52, 326, 12, NULL, 0, CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (52, 327, 13, NULL, 0, CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (53, 2, 7, NULL, 0, CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (53, 9, 3, NULL, 0, CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (53, 13, 1, NULL, 0, CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (53, 303, 4, NULL, 0, CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (53, 304, 2, NULL, 0, CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (53, 306, 5, NULL, 0, CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (53, 310, 8, NULL, 0, CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (53, 311, 6, NULL, 0, CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (53, 315, 10, NULL, 0, CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (53, 316, 9, NULL, 0, CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (53, 318, 11, NULL, 0, CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (53, 321, 15, NULL, 0, CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (53, 324, 12, NULL, 0, CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (53, 326, 13, NULL, 0, CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (53, 327, 14, NULL, 0, CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (54, 2, 8, NULL, 0, CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (54, 9, 5, NULL, 0, CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (54, 13, 2, NULL, 0, CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (54, 300, 3, NULL, 0, CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (54, 301, 1, NULL, 0, CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (54, 303, 4, NULL, 0, CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (54, 308, 9, NULL, 0, CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (54, 310, 7, NULL, 0, CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (54, 311, 10, NULL, 0, CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (54, 313, 6, NULL, 0, CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (54, 319, 15, NULL, 0, CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (54, 321, 11, NULL, 0, CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (54, 325, 13, NULL, 0, CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (54, 326, 14, NULL, 0, CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (54, 327, 12, NULL, 0, CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (55, 2, 8, NULL, 0, CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (55, 9, 5, NULL, 0, CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (55, 13, 2, NULL, 0, CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (55, 294, 6, NULL, 0, CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (55, 300, 1, NULL, 0, CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (55, 304, 3, NULL, 0, CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (55, 305, 4, NULL, 0, CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (55, 310, 9, NULL, 0, CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (55, 313, 10, NULL, 0, CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (55, 314, 7, NULL, 0, CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (55, 319, 12, NULL, 0, CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (55, 320, 13, NULL, 0, CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (55, 322, 11, NULL, 0, CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (55, 324, 15, NULL, 0, CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (55, 326, 14, NULL, 0, CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (56, 2, 8, NULL, 0, CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (56, 9, 5, NULL, 0, CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (56, 13, 3, NULL, 0, CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (56, 139, 1, NULL, 0, CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (56, 140, 2, NULL, 0, CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (56, 302, 4, NULL, 0, CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (56, 310, 6, NULL, 0, CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (56, 312, 10, NULL, 0, CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (56, 316, 9, NULL, 0, CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (56, 317, 7, NULL, 0, CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (56, 318, 11, NULL, 0, CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (56, 319, 13, NULL, 0, CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (56, 320, 15, NULL, 0, CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (56, 322, 12, NULL, 0, CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (56, 323, 14, NULL, 0, CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (57, 2, 10, NULL, 0, CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (57, 9, 1, NULL, 0, CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (57, 13, 4, NULL, 0, CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (57, 183, 2, NULL, 0, CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (57, 246, 3, NULL, 0, CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (57, 248, 5, NULL, 0, CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), NULL, 0, 0)
GO
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (57, 308, 8, NULL, 0, CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (57, 312, 7, NULL, 0, CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (57, 314, 6, NULL, 0, CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (57, 317, 9, NULL, 0, CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (57, 318, 12, NULL, 0, CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (57, 319, 14, NULL, 0, CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (57, 322, 13, NULL, 0, CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (57, 323, 15, NULL, 0, CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), NULL, 0, 0)
INSERT [dbo].[QuestionSheetDetails] ([QuestionSheetId], [QuestionId], [Order], [AnswerId], [Correct], [CreateDate], [UpdateDate], [ListenTimes], [Desktop], [Deleted]) VALUES (57, 325, 11, NULL, 0, CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), NULL, 0, 0)
SET IDENTITY_INSERT [dbo].[QuestionSheets] ON 

INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (1, N'1511200775', CAST(N'2021-05-15T09:42:42.7491584' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 40, 3, 14)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (2, N'1511200779', CAST(N'2021-05-15T09:42:42.7491584' AS DateTime2), 1, 1, 0, 5, NULL, NULL, NULL, 2, NULL, NULL, 41, 3, 14)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (3, N'1511201312', CAST(N'2021-05-15T09:42:42.7491584' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 42, 3, 14)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (4, N'1412500103', CAST(N'2021-05-15T09:42:42.9560416' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 2, NULL, NULL, 43, 3, 15)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (5, N'1412500347', CAST(N'2021-05-15T09:42:42.9580395' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 2, NULL, NULL, 44, 3, 15)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (6, N'1511200877', CAST(N'2021-05-15T09:42:42.9600372' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 45, 3, 15)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (7, N'1511201969', CAST(N'2021-05-15T09:42:43.0709738' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 46, 3, 16)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (8, N'1511200627', CAST(N'2021-05-15T09:42:43.0759710' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 47, 3, 16)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (9, N'1511201188', CAST(N'2021-05-15T09:42:43.0819693' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 48, 3, 16)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (10, N'1511201238', CAST(N'2021-05-15T09:42:43.1799115' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 2, NULL, NULL, 49, 3, 17)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (11, N'1511200444', CAST(N'2021-05-15T09:42:43.2200268' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 2, NULL, NULL, 50, 3, 17)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (12, N'1611202337', CAST(N'2021-05-15T09:42:43.2230198' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 51, 3, 17)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (13, N'1511141862', CAST(N'2021-05-15T09:42:43.2974247' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 2, NULL, NULL, 52, 3, 18)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (14, N'1511202015', CAST(N'2021-05-15T09:42:43.3284776' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 53, 3, 18)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (15, N'1511200914', CAST(N'2021-05-15T09:42:43.3294775' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 54, 3, 18)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (16, N'1511160681', CAST(N'2021-05-15T09:42:43.3959674' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 2, NULL, NULL, 55, 3, 19)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (17, N'1511201164', CAST(N'2021-05-15T09:42:43.4239730' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 56, 3, 19)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (18, N'1511201167', CAST(N'2021-05-15T09:42:43.4239730' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 2, NULL, NULL, 57, 3, 19)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (19, N'1511201385', CAST(N'2021-05-15T09:42:43.5270774' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 2, NULL, NULL, 58, 3, 20)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (20, N'1511201389', CAST(N'2021-05-15T09:42:43.5280774' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 2, NULL, NULL, 59, 3, 20)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (21, N'1511201396', CAST(N'2021-05-15T09:42:43.5280774' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 60, 3, 20)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (22, N'1511201794', CAST(N'2021-05-15T09:42:43.5763322' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 2, NULL, NULL, 61, 3, 21)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (23, N'1511201806', CAST(N'2021-05-15T09:42:43.5793288' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 2, NULL, NULL, 62, 3, 21)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (24, N'1511201821', CAST(N'2021-05-15T09:42:43.5813292' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 2, NULL, NULL, 63, 3, 21)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (25, N'1511201381', CAST(N'2021-05-15T09:42:43.6802927' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 64, 3, 22)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (26, N'1511201390', CAST(N'2021-05-15T09:42:43.6832909' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 65, 3, 22)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (27, N'1511201426', CAST(N'2021-05-15T09:42:43.6863000' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 66, 3, 22)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (28, N'1511201346', CAST(N'2021-05-15T09:42:43.7742556' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 2, NULL, NULL, 67, 3, 23)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (29, N'1511201839', CAST(N'2021-05-15T09:42:43.7772528' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 68, 3, 23)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (30, N'1511202040', CAST(N'2021-05-15T09:42:43.7802513' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 2, NULL, NULL, 69, 3, 23)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (31, N'1511201393', CAST(N'2021-05-15T09:42:43.8647466' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 70, 3, 24)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (32, N'1511201403', CAST(N'2021-05-15T09:42:43.8907300' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 2, NULL, NULL, 71, 3, 24)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (33, N'1511201407', CAST(N'2021-05-15T09:42:43.8917310' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 72, 3, 24)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (34, N'1611200356', CAST(N'2021-05-15T09:42:43.9456979' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 2, NULL, NULL, 73, 3, 25)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (35, N'1611201278', CAST(N'2021-05-15T09:42:43.9476989' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 74, 3, 25)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (36, N'1511201786', CAST(N'2021-05-15T09:42:43.9496954' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 75, 3, 25)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (37, N'1511201631', CAST(N'2021-05-15T09:42:44.0257198' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 76, 3, 26)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (38, N'1511201645', CAST(N'2021-05-15T09:42:44.0287179' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 77, 3, 26)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (39, N'1511201646', CAST(N'2021-05-15T09:42:44.0625025' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 78, 3, 26)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (40, N'1612500088', CAST(N'2021-05-15T09:42:44.1584474' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 79, 3, 27)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (41, N'1512500128', CAST(N'2021-05-15T09:42:44.1894302' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 2, NULL, NULL, 80, 3, 27)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (42, N'1511201168', CAST(N'2021-05-15T09:42:44.1904287' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 2, NULL, NULL, 81, 3, 27)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (43, N'1711130007', CAST(N'2021-05-15T09:42:44.2734276' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 2, NULL, NULL, 82, 3, 28)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (44, N'1711130065', CAST(N'2021-05-15T09:42:44.2754275' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 2, NULL, NULL, 83, 3, 28)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (45, N'1711130051', CAST(N'2021-05-15T09:42:44.2784238' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 84, 3, 28)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (46, N'1611130055', CAST(N'2021-05-15T09:42:44.3694006' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 2, NULL, NULL, 85, 3, 29)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (47, N'1711130048', CAST(N'2021-05-15T09:42:44.3733987' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 86, 3, 29)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (48, N'1711130049', CAST(N'2021-05-15T09:42:44.3743975' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 5, NULL, NULL, 87, 3, 29)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (49, N'1511200619', CAST(N'2021-05-15T11:36:00.5057085' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 15, NULL, NULL, 31, 2, 11)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (50, N'1511200521', CAST(N'2021-05-15T11:36:00.5057085' AS DateTime2), 1, 1, 0, 5, NULL, NULL, NULL, 15, NULL, NULL, 32, 2, 11)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (51, N'1412360298', CAST(N'2021-05-15T11:36:00.5057085' AS DateTime2), 1, 1, 1, 5, NULL, CAST(8.67 AS Decimal(18, 2)), 13, 15, NULL, NULL, 33, 2, 11)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (52, N'1611270294', CAST(N'2021-05-15T11:36:00.7623112' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 15, NULL, NULL, 34, 2, 12)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (53, N'1511200102', CAST(N'2021-05-15T11:36:00.7843015' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 15, NULL, NULL, 35, 2, 12)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (54, N'1412360225', CAST(N'2021-05-15T11:36:00.8423444' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 15, NULL, NULL, 36, 2, 12)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (55, N'1511200853', CAST(N'2021-05-15T11:36:01.0110795' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 15, NULL, NULL, 37, 2, 13)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (56, N'1511200963', CAST(N'2021-05-15T11:36:01.0130784' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 15, NULL, NULL, 38, 2, 13)
INSERT [dbo].[QuestionSheets] ([Id], [Name], [CreateDate], [Approved], [Started], [Completed], [ExtraTime], [ExtraTimeReason], [Mark], [NumberOfCorrect], [Total], [Difficulty], [UserId], [StudentId], [ShiftId], [ShiftSubjectId]) VALUES (57, N'1511200861', CAST(N'2021-05-15T11:36:01.0200776' AS DateTime2), 1, 0, 0, 5, NULL, NULL, NULL, 15, NULL, NULL, 39, 2, 13)
SET IDENTITY_INSERT [dbo].[QuestionSheets] OFF
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([Id], [Name]) VALUES (1, N'Admin')
SET IDENTITY_INSERT [dbo].[Roles] OFF
SET IDENTITY_INSERT [dbo].[Semesters] ON 

INSERT [dbo].[Semesters] ([Id], [Name], [Comment], [Deleted]) VALUES (1, N'1A', N'', 0)
INSERT [dbo].[Semesters] ([Id], [Name], [Comment], [Deleted]) VALUES (2, N'1B', N'', 0)
SET IDENTITY_INSERT [dbo].[Semesters] OFF
SET IDENTITY_INSERT [dbo].[Settings] ON 

INSERT [dbo].[Settings] ([Id], [Name], [Value]) VALUES (1, N'RootFolder', N'C:\Resources')
SET IDENTITY_INSERT [dbo].[Settings] OFF
SET IDENTITY_INSERT [dbo].[Shifts] ON 

INSERT [dbo].[Shifts] ([Id], [Name], [ExamId], [QuestionSheetCreated], [Desktop], [Deleted]) VALUES (1, N'30/10/2017 - 07:30 - 90', 3, 0, 0, 0)
INSERT [dbo].[Shifts] ([Id], [Name], [ExamId], [QuestionSheetCreated], [Desktop], [Deleted]) VALUES (2, N'30/10/2017 - 09:00 - 90', 3, 1, 0, 0)
INSERT [dbo].[Shifts] ([Id], [Name], [ExamId], [QuestionSheetCreated], [Desktop], [Deleted]) VALUES (3, N'30/10/2017 - 16:30 - 90', 3, 1, 0, 0)
INSERT [dbo].[Shifts] ([Id], [Name], [ExamId], [QuestionSheetCreated], [Desktop], [Deleted]) VALUES (4, N'11/08/2017 - 13:30 - 90', 3, 0, 0, 0)
INSERT [dbo].[Shifts] ([Id], [Name], [ExamId], [QuestionSheetCreated], [Desktop], [Deleted]) VALUES (5, N'23/06/2018 - 13:30 - 90', 3, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[Shifts] OFF
SET IDENTITY_INSERT [dbo].[ShiftSubjects] ON 

INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (1, 1, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'01', N'001', CAST(N'2017-10-30T07:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 0, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (2, 1, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'01', N'002', CAST(N'2017-10-30T07:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 0, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (3, 1, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'02', N'002', CAST(N'2017-10-30T07:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 0, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (4, 1, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'02', N'001', CAST(N'2017-10-30T07:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 0, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (5, 1, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'03', N'001', CAST(N'2017-10-30T07:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 0, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (6, 1, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'03', N'002', CAST(N'2017-10-30T07:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 0, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (7, 1, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'03', N'003', CAST(N'2017-10-30T07:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 0, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (8, 1, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'04', N'003', CAST(N'2017-10-30T07:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 0, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (9, 1, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'05', N'001', CAST(N'2017-10-30T07:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 0, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (10, 1, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'06', N'001', CAST(N'2017-10-30T07:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 0, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (11, 2, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'04', N'001', CAST(N'2017-10-30T09:00:00.0000000' AS DateTime2), NULL, 0, NULL, CAST(N'2021-05-15T11:37:11.5121342' AS DateTime2), 90, 1, 2)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (12, 2, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'04', N'002', CAST(N'2017-10-30T09:00:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 1, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (13, 2, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'05', N'002', CAST(N'2017-10-30T09:00:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 1, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (14, 3, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'06', N'002', CAST(N'2017-10-30T16:30:00.0000000' AS DateTime2), NULL, 0, NULL, CAST(N'2021-05-15T09:56:08.0055389' AS DateTime2), 90, 1, 2)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (15, 3, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'07', N'002', CAST(N'2017-10-30T16:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 1, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (16, 3, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'07', N'001', CAST(N'2017-10-30T16:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 1, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (17, 3, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'08', N'002', CAST(N'2017-10-30T16:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 1, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (18, 3, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'08', N'001', CAST(N'2017-10-30T16:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 1, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (19, 3, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'09', N'002', CAST(N'2017-10-30T16:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 1, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (20, 3, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'09', N'001', CAST(N'2017-10-30T16:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 1, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (21, 3, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'10', N'002', CAST(N'2017-10-30T16:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 1, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (22, 3, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'10', N'001', CAST(N'2017-10-30T16:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 1, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (23, 3, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'11', N'002', CAST(N'2017-10-30T16:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 1, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (24, 3, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'11', N'001', CAST(N'2017-10-30T16:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 1, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (25, 3, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'12', N'001', CAST(N'2017-10-30T16:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 1, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (26, 3, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'12', N'002', CAST(N'2017-10-30T16:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 1, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (27, 3, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'18', N'002', CAST(N'2017-10-30T16:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 1, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (28, 3, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'18', N'001', CAST(N'2017-10-30T16:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 1, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (29, 3, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'701', N'001', CAST(N'2017-10-30T16:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 1, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (30, 4, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'701', N'002', CAST(N'2017-08-11T13:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 0, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (31, 5, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'099', N'002', CAST(N'2018-06-23T13:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 0, 1)
INSERT [dbo].[ShiftSubjects] ([Id], [ShiftId], [SubjectId], [MatrixId], [SubjectCode], [SubjectName], [GroupCode], [SubGroupCode], [StartTime], [EndTime], [Ended], [EndDate], [ActivateTime], [Duration], [CreatedQuestionSheet], [StateActivate]) VALUES (32, 5, 2, 1, N'Demo101', N'Vật Liệu Xây Dựng', N'099', N'003', CAST(N'2018-06-23T13:30:00.0000000' AS DateTime2), NULL, 0, NULL, NULL, 90, 0, 1)
SET IDENTITY_INSERT [dbo].[ShiftSubjects] OFF
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (1, 1, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:12.7890012' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (1, 2, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:12.8009951' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (1, 3, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:12.8049899' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (2, 4, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:12.8249791' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (2, 5, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:12.8379722' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (2, 6, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:12.8519635' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (3, 7, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:12.8719520' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (3, 8, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:12.8789491' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (3, 9, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:12.8879434' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (4, 10, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:12.9149287' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (4, 11, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:12.9229226' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (4, 12, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:12.9299202' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (5, 13, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:12.9549041' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (5, 14, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:12.9678971' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (5, 15, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:12.9748936' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (6, 16, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:12.9998788' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (6, 17, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.0068745' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (6, 18, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.0188679' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (7, 19, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.0718380' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (7, 20, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.0868292' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (7, 21, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.0938272' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (8, 22, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.1517922' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (8, 23, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.1587876' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (8, 24, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.1717805' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (9, 25, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.1947673' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (9, 26, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.2047612' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (9, 27, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.2107592' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (10, 28, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.2337447' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (10, 29, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.2397410' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (10, 30, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.2497355' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (11, 31, 49, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.2727220' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (11, 32, 50, 1, NULL, NULL, 2, CAST(N'2021-05-14T22:03:13.2877143' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (11, 33, 51, 0, NULL, NULL, 3, CAST(N'2021-05-14T22:03:13.2937128' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (12, 34, 52, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.3256916' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (12, 35, 53, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.3376849' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (12, 36, 54, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.3566752' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (13, 37, 55, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.4036482' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (13, 38, 56, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.4096433' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (13, 39, 57, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.4196388' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (14, 40, 1, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.4396263' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (14, 41, 2, 1, NULL, NULL, 2, CAST(N'2021-05-14T22:03:13.4496215' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (14, 42, 3, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.4576170' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (15, 43, 4, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.4756057' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (15, 44, 5, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.4865997' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (15, 45, 6, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.4915961' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (16, 46, 7, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.5085864' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (16, 47, 8, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.5195808' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (16, 48, 9, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.5295789' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (17, 49, 10, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.5495635' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (17, 50, 11, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.5545603' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (17, 51, 12, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.5605567' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (18, 52, 13, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.5815459' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (18, 53, 14, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.5895403' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (18, 54, 15, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.5985364' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (19, 55, 16, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.6245213' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (19, 56, 17, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.6365132' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (19, 57, 18, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.6555029' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (20, 58, 19, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.6794951' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (20, 59, 20, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.6874838' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (20, 60, 21, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.6924834' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (21, 61, 22, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.7114726' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (21, 62, 23, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.7204664' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (21, 63, 24, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.7324592' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (22, 64, 25, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.7534467' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (22, 65, 26, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.7594431' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (22, 66, 27, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.7684368' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (23, 67, 28, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.8124472' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (23, 68, 29, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.8204381' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (23, 69, 30, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.8334302' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (24, 70, 31, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.8674117' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (24, 71, 32, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.8734079' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (24, 72, 33, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.8824016' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (25, 73, 34, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.9013900' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (25, 74, 35, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.9083876' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (25, 75, 36, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.9173826' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (26, 76, 37, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.9423675' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (26, 77, 38, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.9523615' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (26, 78, 39, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.9573589' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (27, 79, 40, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.9813461' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (27, 80, 41, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.9883399' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (27, 81, 42, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:13.9983349' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (28, 82, 43, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:14.0183227' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (28, 83, 44, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:14.0253186' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (28, 84, 45, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:14.0353137' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (29, 85, 46, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:14.0662985' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (29, 86, 47, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:14.0912821' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (29, 87, 48, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:14.1092710' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (30, 88, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:14.1572445' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (30, 89, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:14.1722348' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (30, 90, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:14.1892250' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (31, 91, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:14.2212065' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (31, 92, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:14.2332024' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (31, 93, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:14.2401960' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (31, 94, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:14.2521900' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (31, 95, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:14.2651822' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (31, 96, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:14.2731765' AS DateTime2))
INSERT [dbo].[ShiftSubjectStudents] ([ShiftSubjectId], [StudentId], [QuestionSheetId], [LogIn], [LastLogIn], [LastLogOut], [StateExam], [InsertTime]) VALUES (32, 97, NULL, 0, NULL, NULL, 1, CAST(N'2021-05-14T22:03:14.3021625' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Students] ON 

INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (1, N'1511200004', N'Ngô Hoàng Phương', N'Anh', N'15DTA01', N'Ngô Hoàng Phương Anh', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (2, N'1611200128', N'Văn Thoại', N'Anh', N'16DTAA1', N'Văn Thoại Anh', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (3, N'1511201352', N'Vũ Vân', N'Anh', N'15DTA02', N'Vũ Vân Anh', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (4, N'1511200568', N'Nguyễn Kim', N'Ngân', N'15DTA02', N'Nguyễn Kim Ngân', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (5, N'1511180138', N'Phạm Thị Hồng', N'Ngọc', N'15DKT03', N'Phạm Thị Hồng Ngọc', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (6, N'1511190717', N'Nguyễn Thị Thanh', N'Nguyệt', N'15DTC06', N'Nguyễn Thị Thanh Nguyệt', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (7, N'1311100610', N'Lê Thị Thu', N'Quỳnh', N'13DSH06', N'Lê Thị Thu Quỳnh', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (8, N'1511200146', N'Nguyễn Đức', N'Tâm', N'15DTA02', N'Nguyễn Đức Tâm', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (9, N'1411061424', N'Nguyễn Hữu', N'Thiện', N'15DTA01', N'Nguyễn Hữu Thiện', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (10, N'1511200221', N'Nguyễn Phan Vân', N'Anh', N'15DTA04', N'Nguyễn Phan Vân Anh', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (11, N'1511200636', N'Nguyễn Trần Minh', N'Châu', N'15DTA04', N'Nguyễn Trần Minh Châu', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (12, N'1611202397', N'Trần Tú', N'Châu', N'16DTAC1', N'Trần Tú Châu', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (13, N'1511200179', N'Ng. Trần Thanh Thảo', N'Trang', N'15DTA03', N'Ng. Trần Thanh Thảo Trang', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (14, N'1511200180', N'Võ Thị Thùy', N'Trang', N'15DTA03', N'Võ Thị Thùy Trang', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (15, N'1511200185', N'Lê Minh', N'Trí', N'15DTA03', N'Lê Minh Trí', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (16, N'1611202290', N'Nguyễn Thị Kim', N'Cúc', N'16DTAD3', N'Nguyễn Thị Kim Cúc', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (17, N'1611200580', N'Cao Bảo Kỳ', N'Duyên', N'16DTAD3', N'Cao Bảo Kỳ Duyên', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (18, N'1511200653', N'Nguyễn Hoàng Mỹ', N'Duyên', N'15DTA05', N'Nguyễn Hoàng Mỹ Duyên', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (19, N'1511200764', N'Đặng Huệ', N'Nhi', N'15DTA05', N'Đặng Huệ Nhi', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (20, N'1511200768', N'Lê Thụy Yến', N'Nhi', N'15DTA06', N'Lê Thụy Yến Nhi', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (21, N'1511190305', N'Nguyễn Thị Thu', N'Nho', N'15DTC02', N'Nguyễn Thị Thu Nho', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (22, N'1511200610', N'Kiều Thị Thanh', N'Tuyền', N'15DTA05', N'Kiều Thị Thanh Tuyền', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (23, N'1511200388', N'Trần Diệp Minh', N'Tuyền', N'15DTA05', N'Trần Diệp Minh Tuyền', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (24, N'1511200390', N'Nguyễn Thị', N'út', N'15DTA05', N'Nguyễn Thị út', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (25, N'1611110415', N'Nguyễn Thị Thúy', N'ái', N'16DTPB1', N'Nguyễn Thị Thúy ái', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (26, N'1511200913', N'Nguyễn Thị Hoàng', N'Anh', N'15DTA09', N'Nguyễn Thị Hoàng Anh', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (27, N'1511201071', N'Trần Hồng', N'Ân', N'15DTA09', N'Trần Hồng Ân', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (28, N'1511200597', N'Nguyễn Lê Minh', N'Thông', N'15DTA09', N'Nguyễn Lê Minh Thông', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (29, N'1511200167', N'Nguyễn Thị Phúc', N'Thủy', N'15DTA09', N'Nguyễn Thị Phúc Thủy', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (30, N'1511200600', N'Nguyễn Thị Thủy', N'Tiên', N'15DTA09', N'Nguyễn Thị Thủy Tiên', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (31, N'1511200619', N'Hoàng Kỳ', N'Anh', N'15DTA07', N'Hoàng Kỳ Anh', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (32, N'1511200521', N'Huỳnh Vân', N'Anh', N'15DTA08', N'Huỳnh Vân Anh', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (33, N'1412360298', N'Lâm Ngọc', N'Anh', N'14CTH02', N'Lâm Ngọc Anh', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (34, N'1611270294', N'Lê Thị Kim', N'Ngân', N'16DLKA1', N'Lê Thị Kim Ngân', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (35, N'1511200102', N'Mã Bích', N'Ngân', N'15DTA07', N'Mã Bích Ngân', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (36, N'1412360225', N'Trần Hữu', N'Nghĩa', N'14CTH01', N'Trần Hữu Nghĩa', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (37, N'1511200853', N'Bùi Thị Thanh', N'Trà', N'15DTA08', N'Bùi Thị Thanh Trà', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (38, N'1511200963', N'Trần Nguyễn Thiên', N'Trang', N'15DTA07', N'Trần Nguyễn Thiên Trang', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (39, N'1511200861', N'Đặng Thị Bích', N'Trâm', N'15DTA07', N'Đặng Thị Bích Trâm', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (40, N'1511200775', N'Trương Thảo', N'Nhi', N'15DTA10', N'Trương Thảo Nhi', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (41, N'1511200779', N'Huỳnh Thị', N'Nhung', N'15DTA10', N'Huỳnh Thị Nhung', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (42, N'1511201312', N'Phạm Thị Tuyết', N'Nhung', N'15DTA10', N'Phạm Thị Tuyết Nhung', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (43, N'1412500103', N'Trần Nguyễn Bảo', N'Trân', N'14CTA01', N'Trần Nguyễn Bảo Trân', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (44, N'1412500347', N'Hồ Thị Thanh', N'Trúc', N'14CTA01', N'Hồ Thị Thanh Trúc', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (45, N'1511200877', N'Trần Thị Thủy', N'Trúc', N'15DTA10', N'Trần Thị Thủy Trúc', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (46, N'1511201969', N'Mai Thị Hồng', N'Anh', N'15DTA11', N'Mai Thị Hồng Anh', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (47, N'1511200627', N'Nguyễn Ngọc', N'Bảo', N'15DTA12', N'Nguyễn Ngọc Bảo', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (48, N'1511201188', N'Lương An', N'Bình', N'15DTA11', N'Lương An Bình', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (49, N'1511201238', N'Lê Thị Cẩm', N'Tiên', N'15DTA12', N'Lê Thị Cẩm Tiên', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (50, N'1511200444', N'Vũ Nhật Đàm', N'Tiên', N'15DTA11', N'Vũ Nhật Đàm Tiên', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (51, N'1611202337', N'Huỳnh Hữu', N'Tín', N'16DTAB1', N'Huỳnh Hữu Tín', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (52, N'1511141862', N'Vũ Nguyễn Phương', N'An', N'15DTA13', N'Vũ Nguyễn Phương An', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (53, N'1511202015', N'Nguyễn Thị Kim', N'Anh', N'15DTA13', N'Nguyễn Thị Kim Anh', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (54, N'1511200914', N'Trần Trang Phương', N'Anh', N'15DTA14', N'Trần Trang Phương Anh', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (55, N'1511160681', N'Trịnh Ngọc Xuân', N'Trúc', N'15DKS06', N'Trịnh Ngọc Xuân Trúc', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (56, N'1511201164', N'Lê Thị Kim', N'Trưng', N'15DTA14', N'Lê Thị Kim Trưng', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (57, N'1511201167', N'Nguyễn Thị Cẩm', N'Tú', N'15DTA13', N'Nguyễn Thị Cẩm Tú', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (58, N'1511201385', N'Nguyễn Thị Phước', N'An', N'15DTA16', N'Nguyễn Thị Phước An', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (59, N'1511201389', N'Phạm Trường', N'An', N'15DTA15', N'Phạm Trường An', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (60, N'1511201396', N'Đoàn', N'Anh', N'15DTA15', N'Đoàn Anh', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (61, N'1511201794', N'Nguyễn Ngọc Anh', N'Thư', N'15DTA16', N'Nguyễn Ngọc Anh Thư', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (62, N'1511201806', N'Võ Thị Mỹ', N'Thy', N'15DTA15', N'Võ Thị Mỹ Thy', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (63, N'1511201821', N'Nguyễn Đức', N'Toàn', N'15DTA15', N'Nguyễn Đức Toàn', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (64, N'1511201381', N'Thái Thị Tuyết', N'ái', N'15DTA17', N'Thái Thị Tuyết ái', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (65, N'1511201390', N'Thân Nhật', N'An', N'15DTA18', N'Thân Nhật An', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (66, N'1511201426', N'Trần Lê Thanh', N'Bình', N'15DTA17', N'Trần Lê Thanh Bình', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (67, N'1511201346', N'Hồ Nữ Lệ', N'Trâm', N'15DTA17', N'Hồ Nữ Lệ Trâm', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (68, N'1511201839', N'Nguyễn Ngọc Huyền', N'Trâm', N'15DTA18', N'Nguyễn Ngọc Huyền Trâm', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (69, N'1511202040', N'Nguyễn Hoàng Minh', N'Trí', N'15DTA17', N'Nguyễn Hoàng Minh Trí', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (70, N'1511201393', N'Đặng Nam', N'Anh', N'15DTA20', N'Đặng Nam Anh', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (71, N'1511201403', N'Phạm Đức', N'Anh', N'15DTA19', N'Phạm Đức Anh', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (72, N'1511201407', N'Phạm Thị Trâm', N'Anh', N'15DTA19', N'Phạm Thị Trâm Anh', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (73, N'1611200356', N'Dương Trần Minh', N'Thiện', N'16DTAD2', N'Dương Trần Minh Thiện', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (74, N'1611201278', N'Lê Công', N'Thoáng', N'16DTAD2', N'Lê Công Thoáng', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (75, N'1511201786', N'Võ Thị', N'Thùy', N'15DTA20', N'Võ Thị Thùy', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (76, N'1511201631', N'Trần Thanh', N'Ngà', N'15DTA21', N'Trần Thanh Ngà', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (77, N'1511201645', N'Huỳnh Thị Như', N'Ngọc', N'15DTA21', N'Huỳnh Thị Như Ngọc', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (78, N'1511201646', N'Lê Thị Hồng', N'Ngọc', N'15DTA21', N'Lê Thị Hồng Ngọc', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (79, N'1612500088', N'Phan Thị Huyền', N'Trân', N'16CTAA1', N'Phan Thị Huyền Trân', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (80, N'1512500128', N'Trần Trung', N'Trực', N'16CTAA1', N'Trần Trung Trực', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (81, N'1511201168', N'Trần Nguyễn Thị Cẩm', N'Tú', N'15DTA21', N'Trần Nguyễn Thị Cẩm Tú', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (82, N'1711130007', N'Trương Thị Thùy', N'An', N'17DTTA1', N'Trương Thị Thùy An', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (83, N'1711130065', N'Nguyễn Hoàng Gia', N'Bảo', N'17DTTA1', N'Nguyễn Hoàng Gia Bảo', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (84, N'1711130051', N'Ngô Nguyên', N'Cường', N'17DTTA1', N'Ngô Nguyên Cường', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (85, N'1611130055', N'Lê Ngọc Minh', N'Thư', N'17DTTA1', N'Lê Ngọc Minh Thư', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (86, N'1711130048', N'Nguyễn Thị Kim', N'Thư', N'17DTTA1', N'Nguyễn Thị Kim Thư', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (87, N'1711130049', N'Nguyễn Thị Mười', N'Thương', N'17DTTA1', N'Nguyễn Thị Mười Thương', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (88, N'1612500091', N'Đinh Hà', N'My', N'16CTAA1', N'Đinh Hà My', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (89, N'1611290058', N'Trịnh Phạm Đông', N'Mỹ', N'16DDPHA1', N'Trịnh Phạm Đông Mỹ', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (90, N'1611270024', N'Trần Hoàng', N'Nam', N'16DLKA1', N'Trần Hoàng Nam', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (91, N'1611290386', N'Trần Thị', N'Oanh', N'16DDPHA1', N'Trần Thị Oanh', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (92, N'1611290284', N'Nguyễn Thiên', N'Phúc', N'16DDPHA2', N'Nguyễn Thiên Phúc', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (93, N'1611290199', N'Lê Trúc', N'Phương', N'16DDPHA2', N'Lê Trúc Phương', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (94, N'1611290080', N'Trần Thị', N'Test', N'16DDPHA1', N'Trần Thị Test', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (95, N'1611290280', N'Nguyễn Thiên', N'Test', N'16DDPHA2', N'Nguyễn Thiên Test', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (96, N'1611290190', N'Lê Trúc', N'Test', N'16DDPHA2', N'Lê Trúc Test', NULL, NULL)
INSERT [dbo].[Students] ([Id], [Code], [LastName], [FirstName], [ClassName], [Name], [Email], [Password]) VALUES (97, N'1611290255', N'Dương Văn', N'Thành', N'16DDPHA2', N'Dương Văn Thành', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Students] OFF
SET IDENTITY_INSERT [dbo].[Subjects] ON 

INSERT [dbo].[Subjects] ([Id], [Code], [Name], [FacultyId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (1, N'DDH', N'Dược Động Học', 3, 5, 0, 1, N'MONDDH')
INSERT [dbo].[Subjects] ([Id], [Code], [Name], [FacultyId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (2, N'VLXD', N'Vật Liệu Xây Dựng', 2, 4, 0, 0, N'MONVLXD')
INSERT [dbo].[Subjects] ([Id], [Code], [Name], [FacultyId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (3, N'DCCT', N'Địa Chất Công Trình', 2, 3, 0, 1, N'MONDCCT')
INSERT [dbo].[Subjects] ([Id], [Code], [Name], [FacultyId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (4, N'CNPM', N'Công Nghệ Phần Mềm', 1, 2, 0, 0, N'MONCNPM')
INSERT [dbo].[Subjects] ([Id], [Code], [Name], [FacultyId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (5, N'LTC', N'Lập Trình C', 1, 1, 0, 1, N'MONLTC')
INSERT [dbo].[Subjects] ([Id], [Code], [Name], [FacultyId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (6, N'VS', N'Vi Sinh', 3, 6, 0, 0, N'MONVS')
INSERT [dbo].[Subjects] ([Id], [Code], [Name], [FacultyId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (7, N'TA1', N'Tiếng Anh 1', 4, 7, 0, 0, N'MONTA1')
INSERT [dbo].[Subjects] ([Id], [Code], [Name], [FacultyId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (8, N'TA2', N'Tiếng Anh 2', 4, 8, 0, 0, N'MONTA2')
INSERT [dbo].[Subjects] ([Id], [Code], [Name], [FacultyId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (9, N'KTTH', N'Kế Toán Tin Học', 5, 9, 0, 0, N'MONKTTH')
INSERT [dbo].[Subjects] ([Id], [Code], [Name], [FacultyId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (10, N'PTDL1', N'Phân Tích Dữ Liệu 1', 5, 10, 0, 0, N'MONPTDL1')
INSERT [dbo].[Subjects] ([Id], [Code], [Name], [FacultyId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (11, N'LTHDT', N'Lập trình hướng đối tượng', 1, 11, 0, 1, N'MONLTHDT')
INSERT [dbo].[Subjects] ([Id], [Code], [Name], [FacultyId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (12, N'LTDT2', N'Lý thuyết đồ thị 2', 1, 0, 0, 1, N'MONLTDT2')
INSERT [dbo].[Subjects] ([Id], [Code], [Name], [FacultyId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (13, N'LTDD', N'LẬP TRÌNH DI ĐỘNG EDIT', 1, NULL, 1, 1, N'MONLAPTRINHDIDONG')
INSERT [dbo].[Subjects] ([Id], [Code], [Name], [FacultyId], [ManagementOrder], [Validated], [Deleted], [FolderName]) VALUES (14, N'VI DU EDIT', N'Lý thuyết đồ thị 2', 1, 0, 1, 1, N'STRING')
SET IDENTITY_INSERT [dbo].[Subjects] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [Username], [Password], [Salt], [Name], [CreateDate], [LogOut], [LastActivity], [LastLogIn], [LastPasswordChanged], [LastLogOut], [Comment], [BuildInUser], [Deleted], [FacultyId], [SubjectId]) VALUES (1, N'admin', N'21232f297a57a5a743894a0e4a801fc3', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Users] OFF
/****** Object:  Index [IX_Answers_QuestionId]    Script Date: 15/05/2021 12:38:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_Answers_QuestionId] ON [dbo].[Answers]
(
	[QuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Chapters_SubjectId]    Script Date: 15/05/2021 12:38:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_Chapters_SubjectId] ON [dbo].[Chapters]
(
	[SubjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ExtraTimeLogs_QuestionSheetId]    Script Date: 15/05/2021 12:38:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_ExtraTimeLogs_QuestionSheetId] ON [dbo].[ExtraTimeLogs]
(
	[QuestionSheetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_MatrixDetails_MatrixId]    Script Date: 15/05/2021 12:38:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_MatrixDetails_MatrixId] ON [dbo].[MatrixDetails]
(
	[MatrixId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PaperQuestionSheets_PaperShiftSubjectId]    Script Date: 15/05/2021 12:38:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_PaperQuestionSheets_PaperShiftSubjectId] ON [dbo].[PaperQuestionSheets]
(
	[PaperShiftSubjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PaperShiftSubjects_MatrixId]    Script Date: 15/05/2021 12:38:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_PaperShiftSubjects_MatrixId] ON [dbo].[PaperShiftSubjects]
(
	[MatrixId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PaperShiftSubjects_ShiftId]    Script Date: 15/05/2021 12:38:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_PaperShiftSubjects_ShiftId] ON [dbo].[PaperShiftSubjects]
(
	[ShiftId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Questions_ChapterId]    Script Date: 15/05/2021 12:38:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_Questions_ChapterId] ON [dbo].[Questions]
(
	[ChapterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_QuestionSheetDetails_QuestionId]    Script Date: 15/05/2021 12:38:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_QuestionSheetDetails_QuestionId] ON [dbo].[QuestionSheetDetails]
(
	[QuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [AK_RoleUsers_Role_Id_User_Id]    Script Date: 15/05/2021 12:38:34 PM ******/
ALTER TABLE [dbo].[RoleUsers] ADD  CONSTRAINT [AK_RoleUsers_Role_Id_User_Id] UNIQUE NONCLUSTERED 
(
	[Role_Id] ASC,
	[User_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RoleUsers_RoleId]    Script Date: 15/05/2021 12:38:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_RoleUsers_RoleId] ON [dbo].[RoleUsers]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RoleUsers_UserId]    Script Date: 15/05/2021 12:38:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_RoleUsers_UserId] ON [dbo].[RoleUsers]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Shifts_ExamId]    Script Date: 15/05/2021 12:38:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_Shifts_ExamId] ON [dbo].[Shifts]
(
	[ExamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ShiftSubjects_MatrixId]    Script Date: 15/05/2021 12:38:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_ShiftSubjects_MatrixId] ON [dbo].[ShiftSubjects]
(
	[MatrixId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ShiftSubjects_ShiftId]    Script Date: 15/05/2021 12:38:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_ShiftSubjects_ShiftId] ON [dbo].[ShiftSubjects]
(
	[ShiftId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ShiftSubjects_SubjectId]    Script Date: 15/05/2021 12:38:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_ShiftSubjects_SubjectId] ON [dbo].[ShiftSubjects]
(
	[SubjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ShiftSubjectStudents_QuestionSheetId]    Script Date: 15/05/2021 12:38:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_ShiftSubjectStudents_QuestionSheetId] ON [dbo].[ShiftSubjectStudents]
(
	[QuestionSheetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ShiftSubjectStudents_StudentId]    Script Date: 15/05/2021 12:38:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_ShiftSubjectStudents_StudentId] ON [dbo].[ShiftSubjectStudents]
(
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Subjects_FacultyId]    Script Date: 15/05/2021 12:38:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_Subjects_FacultyId] ON [dbo].[Subjects]
(
	[FacultyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Answers]  WITH CHECK ADD  CONSTRAINT [FK_Answers_Questions_QuestionId] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Questions] ([Id])
GO
ALTER TABLE [dbo].[Answers] CHECK CONSTRAINT [FK_Answers_Questions_QuestionId]
GO
ALTER TABLE [dbo].[Chapters]  WITH CHECK ADD  CONSTRAINT [FK_Chapters_Subjects_SubjectId] FOREIGN KEY([SubjectId])
REFERENCES [dbo].[Subjects] ([Id])
GO
ALTER TABLE [dbo].[Chapters] CHECK CONSTRAINT [FK_Chapters_Subjects_SubjectId]
GO
ALTER TABLE [dbo].[ExtraTimeLogs]  WITH CHECK ADD  CONSTRAINT [FK_ExtraTimeLogs_QuestionSheets_QuestionSheetId] FOREIGN KEY([QuestionSheetId])
REFERENCES [dbo].[QuestionSheets] ([Id])
GO
ALTER TABLE [dbo].[ExtraTimeLogs] CHECK CONSTRAINT [FK_ExtraTimeLogs_QuestionSheets_QuestionSheetId]
GO
ALTER TABLE [dbo].[MatrixDetails]  WITH CHECK ADD  CONSTRAINT [FK_MatrixDetails_Matrices_MatrixId] FOREIGN KEY([MatrixId])
REFERENCES [dbo].[Matrices] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MatrixDetails] CHECK CONSTRAINT [FK_MatrixDetails_Matrices_MatrixId]
GO
ALTER TABLE [dbo].[PaperQuestionSheetDetails]  WITH CHECK ADD  CONSTRAINT [FK_PaperQuestionSheetDetails_PaperQuestionSheets_PaperQuestionSheetId] FOREIGN KEY([PaperQuestionSheetId])
REFERENCES [dbo].[PaperQuestionSheets] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PaperQuestionSheetDetails] CHECK CONSTRAINT [FK_PaperQuestionSheetDetails_PaperQuestionSheets_PaperQuestionSheetId]
GO
ALTER TABLE [dbo].[PaperQuestionSheets]  WITH CHECK ADD  CONSTRAINT [FK_PaperQuestionSheets_PaperShiftSubjects_PaperShiftSubjectId] FOREIGN KEY([PaperShiftSubjectId])
REFERENCES [dbo].[PaperShiftSubjects] ([Id])
GO
ALTER TABLE [dbo].[PaperQuestionSheets] CHECK CONSTRAINT [FK_PaperQuestionSheets_PaperShiftSubjects_PaperShiftSubjectId]
GO
ALTER TABLE [dbo].[PaperShiftSubjects]  WITH CHECK ADD  CONSTRAINT [FK_PaperShiftSubjects_Matrices_MatrixId] FOREIGN KEY([MatrixId])
REFERENCES [dbo].[Matrices] ([Id])
GO
ALTER TABLE [dbo].[PaperShiftSubjects] CHECK CONSTRAINT [FK_PaperShiftSubjects_Matrices_MatrixId]
GO
ALTER TABLE [dbo].[PaperShiftSubjects]  WITH CHECK ADD  CONSTRAINT [FK_PaperShiftSubjects_Shifts_ShiftId] FOREIGN KEY([ShiftId])
REFERENCES [dbo].[Shifts] ([Id])
GO
ALTER TABLE [dbo].[PaperShiftSubjects] CHECK CONSTRAINT [FK_PaperShiftSubjects_Shifts_ShiftId]
GO
ALTER TABLE [dbo].[Questions]  WITH CHECK ADD  CONSTRAINT [FK_Questions_Chapters_ChapterId] FOREIGN KEY([ChapterId])
REFERENCES [dbo].[Chapters] ([Id])
GO
ALTER TABLE [dbo].[Questions] CHECK CONSTRAINT [FK_Questions_Chapters_ChapterId]
GO
ALTER TABLE [dbo].[QuestionSheetDetails]  WITH CHECK ADD  CONSTRAINT [FK_QuestionSheetDetails_Questions_QuestionId] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Questions] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[QuestionSheetDetails] CHECK CONSTRAINT [FK_QuestionSheetDetails_Questions_QuestionId]
GO
ALTER TABLE [dbo].[QuestionSheetDetails]  WITH CHECK ADD  CONSTRAINT [FK_QuestionSheetDetails_QuestionSheets_QuestionSheetId] FOREIGN KEY([QuestionSheetId])
REFERENCES [dbo].[QuestionSheets] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[QuestionSheetDetails] CHECK CONSTRAINT [FK_QuestionSheetDetails_QuestionSheets_QuestionSheetId]
GO
ALTER TABLE [dbo].[RoleUsers]  WITH CHECK ADD  CONSTRAINT [FK_RoleUsers_Roles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
GO
ALTER TABLE [dbo].[RoleUsers] CHECK CONSTRAINT [FK_RoleUsers_Roles_RoleId]
GO
ALTER TABLE [dbo].[RoleUsers]  WITH CHECK ADD  CONSTRAINT [FK_RoleUsers_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[RoleUsers] CHECK CONSTRAINT [FK_RoleUsers_Users_UserId]
GO
ALTER TABLE [dbo].[Shifts]  WITH CHECK ADD  CONSTRAINT [FK_Shifts_Exams_ExamId] FOREIGN KEY([ExamId])
REFERENCES [dbo].[Exams] ([Id])
GO
ALTER TABLE [dbo].[Shifts] CHECK CONSTRAINT [FK_Shifts_Exams_ExamId]
GO
ALTER TABLE [dbo].[ShiftSubjects]  WITH CHECK ADD  CONSTRAINT [FK_ShiftSubjects_Matrices_MatrixId] FOREIGN KEY([MatrixId])
REFERENCES [dbo].[Matrices] ([Id])
GO
ALTER TABLE [dbo].[ShiftSubjects] CHECK CONSTRAINT [FK_ShiftSubjects_Matrices_MatrixId]
GO
ALTER TABLE [dbo].[ShiftSubjects]  WITH CHECK ADD  CONSTRAINT [FK_ShiftSubjects_Shifts_ShiftId] FOREIGN KEY([ShiftId])
REFERENCES [dbo].[Shifts] ([Id])
GO
ALTER TABLE [dbo].[ShiftSubjects] CHECK CONSTRAINT [FK_ShiftSubjects_Shifts_ShiftId]
GO
ALTER TABLE [dbo].[ShiftSubjects]  WITH CHECK ADD  CONSTRAINT [FK_ShiftSubjects_Subjects_SubjectId] FOREIGN KEY([SubjectId])
REFERENCES [dbo].[Subjects] ([Id])
GO
ALTER TABLE [dbo].[ShiftSubjects] CHECK CONSTRAINT [FK_ShiftSubjects_Subjects_SubjectId]
GO
ALTER TABLE [dbo].[ShiftSubjectStudents]  WITH CHECK ADD  CONSTRAINT [FK_ShiftSubjectStudents_QuestionSheets_QuestionSheetId] FOREIGN KEY([QuestionSheetId])
REFERENCES [dbo].[QuestionSheets] ([Id])
GO
ALTER TABLE [dbo].[ShiftSubjectStudents] CHECK CONSTRAINT [FK_ShiftSubjectStudents_QuestionSheets_QuestionSheetId]
GO
ALTER TABLE [dbo].[ShiftSubjectStudents]  WITH CHECK ADD  CONSTRAINT [FK_ShiftSubjectStudents_ShiftSubjects_ShiftSubjectId] FOREIGN KEY([ShiftSubjectId])
REFERENCES [dbo].[ShiftSubjects] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShiftSubjectStudents] CHECK CONSTRAINT [FK_ShiftSubjectStudents_ShiftSubjects_ShiftSubjectId]
GO
ALTER TABLE [dbo].[ShiftSubjectStudents]  WITH CHECK ADD  CONSTRAINT [FK_ShiftSubjectStudents_Students_StudentId] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Students] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShiftSubjectStudents] CHECK CONSTRAINT [FK_ShiftSubjectStudents_Students_StudentId]
GO
ALTER TABLE [dbo].[Subjects]  WITH CHECK ADD  CONSTRAINT [FK_Subjects_Faculties_FacultyId] FOREIGN KEY([FacultyId])
REFERENCES [dbo].[Faculties] ([Id])
GO
ALTER TABLE [dbo].[Subjects] CHECK CONSTRAINT [FK_Subjects_Faculties_FacultyId]
GO
/****** Object:  StoredProcedure [dbo].[Answers_Insert]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Answers_SelectBy_QuestionId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Answers_Update]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CaculateMark]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CaculateMark] @questionSheetId BIGINT
AS
    BEGIN

		DECLARE @questionSheetComplated BIT;

		DECLARE @numberOfCorrect INT;

		SET @questionSheetComplated =	(	SELECT Completed 
											FROM dbo.QuestionSheets
											WHERE Id = @questionSheetId
										);

		IF @questionSheetComplated = 0
			BEGIN
				DECLARE @roundingCode nvarchar(50);
				DECLARE @scope DECIMAL(18,10);
				DECLARE @exactMark INT;
				DECLARE @ApprpximateMark DECIMAL(18,10);
					
				UPDATE  dbo.QuestionSheetDetails
				SET     dbo.QuestionSheetDetails.Correct = dbo.Answers.Correct
				FROM    dbo.QuestionSheetDetails
						JOIN dbo.Answers ON dbo.Answers.Id = dbo.QuestionSheetDetails.AnswerId
				WHERE   dbo.QuestionSheetDetails.QuestionSheetId = @questionSheetId;
	
				SET @numberOfCorrect = (	SELECT   COUNT(*)
											FROM     dbo.QuestionSheetDetails AS qsd INNER JOIN dbo.Questions AS q ON qsd.QuestionId = q.Id
											WHERE    QuestionSheetId = @questionSheetId AND Correct = 1 AND q.Deleted = 0
										);
										
				SET @scope = (SELECT ((@numberOfCorrect * 1.0) / ( COUNT(*) * 1.0 / 10 ))
					FROM dbo.QuestionSheetDetails sd
					INNER JOIN dbo.Questions q ON sd.QuestionId = q.Id
					WHERE sd.QuestionSheetId = @questionSheetId and q.Deleted=0);

				SET @roundingCode = (SELECT Code FROM dbo.MarkRoundings WHERE dbo.MarkRoundings.Using = 'true');

				IF @roundingCode = 'INT'
					SET @scope = ROUND(@scope, 0);

				IF @roundingCode = 'DECIMAL'
					SET @scope = ROUND(@scope, 1);
		
				IF @roundingCode = 'HALF'
					BEGIN
				
						SET @exactMark = @scope;
						SET @ApprpximateMark = @scope - @exactMark;
							
						IF @ApprpximateMark < 0.25
							SET @scope = (@exactMark * 1.0) + 0.0;
						ELSE IF @ApprpximateMark < 0.75
							SET @scope = (@exactMark * 1.0) + 0.5;
						ELSE
							SET @scope = (@exactMark * 1.0) + 1;
					END

				IF @roundingCode = 'QUARTER'
					BEGIN

						SET @exactMark = @scope;
						SET @ApprpximateMark = @scope - @exactMark;
							
						IF @ApprpximateMark < 0.125
							SET @scope = (@exactMark * 1.0) + 0.0;
						ELSE IF @ApprpximateMark < 0.375
							SET @scope = (@exactMark * 1.0) + 0.25;
						ELSE IF @ApprpximateMark < 0.625
							SET @scope = (@exactMark * 1.0) + 0.5
						ELSE IF @ApprpximateMark < 0.875
							SET @scope = (@exactMark * 1.0) + 0.75
						ELSE
							SET @scope = (@exactMark * 1.0) + 1;
					END

				UPDATE  dbo.QuestionSheets 
				SET     NumberOfCorrect = @numberOfCorrect ,
						--Mark = ROUND(( @numberOfCorrect / ( Total * 1.0 / 10 ) ) * 2, 0) / 2 ,
						Mark = @scope,
						Completed = 1
				WHERE   dbo.QuestionSheets.Id = @questionSheetId;

				UPDATE	dbo.ShiftSubjectStudents
				SET		StateExam = 3
				WHERE	dbo.ShiftSubjectStudents.QuestionSheetId = @questionSheetId;
			END
			ELSE
				BEGIN
					SET @numberOfCorrect = (	SELECT   COUNT(*)
												FROM     dbo.QuestionSheetDetails AS qsd INNER JOIN dbo.Questions AS q ON qsd.QuestionId = q.Id
												WHERE    QuestionSheetId = @questionSheetId AND Correct = 1 AND q.Deleted = 0
											);
				END;

		SELECT @numberOfCorrect AS NumberOfCorrect, 'updated' AS UpdateCorrectCompleted, Mark AS Mark
		FROM dbo.QuestionSheets WHERE Id = @questionSheetId;
    END;

GO
/****** Object:  StoredProcedure [dbo].[CalculateUserSheet]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Chapter_SelectBy_ParentId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Chapter_SelectBy_SubjectId_ParentId]    Script Date: 15/05/2021 12:38:34 PM ******/
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

ORDER BY [ManagementOrder]







GO
/****** Object:  StoredProcedure [dbo].[Chapter_SelectBy_SubjectId_ParentId_QuestionDelted]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Chapters_Insert]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Chapters_Restore]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Chapters_SelectAll]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Chapters_SelectOne]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Chapters_SelectOneByName]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Chapters_Update]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ChapterSelectBySubjectId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CheckChapter]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CheckLoginByStudentCode]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckLoginByStudentCode]
    @studentCode NVARCHAR(100)
AS
    BEGIN
        SELECT TOP 1 dbo.Exams.[Name] AS ExamName,
			dbo.Shifts.Id AS ShiftId,
			dbo.Shifts.[Name] AS ShiftName,
			dbo.ShiftSubjects.StartTime,
			dbo.ShiftSubjects.EndTime,
			dbo.ShiftSubjects.Duration,
			dbo.Subjects.[Name] AS SubjectName,
			dbo.Students.Code AS StudentCode,
			dbo.Students.[Name] AS StudentName,
			dbo.QuestionSheets.ExtraTime,
			dbo.ShiftSubjectStudents.ShiftSubjectId,
			dbo.ShiftSubjectStudents.QuestionSheetId,
			dbo.ShiftSubjectStudents.StudentId
		FROM dbo.ShiftSubjectStudents
			INNER JOIN dbo.Students ON Students.Id = ShiftSubjectStudents.StudentId
			INNER JOIN dbo.QuestionSheets ON QuestionSheets.Id = ShiftSubjectStudents.QuestionSheetId
			INNER JOIN dbo.ShiftSubjects ON ShiftSubjects.Id = ShiftSubjectStudents.ShiftSubjectId
			INNER JOIN dbo.Shifts ON Shifts.Id = ShiftSubjects.ShiftId
			INNER JOIN dbo.Subjects ON Subjects.Id = ShiftSubjects.SubjectId
			INNER JOIN dbo.Exams ON Exams.Id = Shifts.ExamId
		WHERE
			dbo.Students.Code = @studentCode
			AND dbo.ShiftSubjects.StateActivate = 2
			AND dbo.ShiftSubjects.Ended = 0
			AND dbo.Shifts.Deleted = 0
			AND dbo.Exams.Deleted = 0
			AND dbo.ShiftSubjects.ActivateTime < GETDATE()
		ORDER BY ShiftSubjectId desc
    END;
GO
/****** Object:  StoredProcedure [dbo].[CheckStudentCode]    Script Date: 15/05/2021 12:38:34 PM ******/
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
        WHERE   dbo.Students.Code = @studentCode ORDER BY Id DESC; 
    END;














GO
/****** Object:  StoredProcedure [dbo].[CheckStudentHasLogin]    Script Date: 15/05/2021 12:38:34 PM ******/
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
	INNER JOIN dbo.ShiftSubjects ON ShiftSubjects.Id = ShiftSubjectStudents.ShiftSubjectId
	INNER JOIN dbo.Shifts ON Shifts.Id = ShiftSubjects.ShiftId
	INNER JOIN dbo.Exams ON Exams.Id = Shifts.ExamId
	WHERE dbo.Students.Code = @studentCode AND dbo.ShiftSubjectStudents.[LogIn] =0
	AND dbo.ShiftSubjects.StateActivate = 2 --ca thi đó phải được kích hoạt
	AND dbo.ShiftSubjects.Ended = 0
	AND dbo.Shifts.Deleted = 0
	AND dbo.Exams.Deleted = 0
	AND dbo.ShiftSubjects.ActivateTime < GETDATE()
END

GO
/****** Object:  StoredProcedure [dbo].[CheckSubjectBySubjectIdAndName]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CompletedQuestionSheet]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[DeleteTemporaryQuestion]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Exams_Delete]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Exams_Insert]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Exams_SelectAll]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Exams_SelectAll]

/*
Author:   			Nguyen Bao Quoc
ALTERd: 			2011-3-9
Last Modified: 		2011-3-9
*/
-- WITH ENCRYPTION
AS


SELECT
		Id, Name as TenDotThi, UserId, CreateDate, Deleted, N'Chi tiết đợt thi' as ShiftOfExam
		
FROM
		[dbo].[Exams] where Deleted = 'false' and Desktop =1











GO
/****** Object:  StoredProcedure [dbo].[Exams_SelectByName]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Exams_Update]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Faculties_Insert]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Faculties_Retore]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Faculties_SelectAll]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Faculties_SelectOne]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Faculties_SelectOneByName]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Faculties_Update]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Faculty_Delete]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Faculty_Delete_By_Id]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Faculty_SelectBy_QuestionDelete]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GenerateExam]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetAnswerByQuestionId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetChaperId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetChapterId_SelectBy_ParentId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetExamsApp]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetExamsApp]
--=============================================
--	Creatd: Hoang Van Hieu
--	Date:	27/07/2018
--	Des:	Lấy danh sách các đợt thi
--	GetExamsApp
--=============================================
AS
BEGIN
	SELECT DISTINCT Ex.ID,Ex.Name
	FROM Exams Ex
	WHERE Ex.Deleted =0 AND Ex.Desktop = 0
END




GO
/****** Object:  StoredProcedure [dbo].[GetListQuestionCorretTimeHighest]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetListQuestionCorretTimeLowest]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetListQuestionRateHighest]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetListQuestionRateLowest]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetListQuestionSelectdTimeHighest]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetListQuestionSelectdTimeZero]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetListQuestionSelectdTimeZero]
@SubjectId int
AS
	select top 100 percent Id, Content,ParentId,ManagementOrder from Questions Where SelectedTimes =0 AND SubjectId =@SubjectId AND Deleted =0







GO
/****** Object:  StoredProcedure [dbo].[GetListStudentExamed_App]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetListStudentExamed_App] 
--==================================================================================
--	Create: Hoàng Văn Hiếu
--	Date:	27/07/2018	
--	Des:	Lấy danh sách sinh viên đã thi theo đợt thi
--==================================================================================
(
	@ExamID INT =0
)
AS
BEGIN
	SELECT Ex.Name AS ExamName, Sh.Name AS ShiftName, SS.ActivateTime, SS.EndTime, SJ.Code, SJ.Name AS SubjectName,
		   ST.Code AS StudentCode,ST.Name AS StudentName, QS.Approved, QS.Total, QS.Difficulty,QS.NumberOfCorrect, QS.Mark
	FROM [dbo].[Exams] Ex
		INNER JOIN [dbo].[Shifts] Sh ON Ex.Id = Sh.ExamId
		INNER JOIN [dbo].[ShiftSubjects] SS ON Sh.Id = SS.ShiftId
		INNER JOIN [dbo].[Subjects] SJ ON SS.SubjectId = SJ.ID
		INNER JOIN [dbo].[ShiftSubjectStudents] SSS ON SSS.ShiftSubjectId = SS.Id
		INNER JOIN [dbo].[Students] ST ON SSS.StudentId = ST.Id
		INNER JOIN [dbo].[QuestionSheets] QS ON SSS.QuestionSheetId = QS.Id
	WHERE Ex.Id =@ExamID
END




GO
/****** Object:  StoredProcedure [dbo].[GetListStudentSubject_App]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetListStudentSubject_App] 
--==================================================================================
--	Create: Hoàng Văn Hiếu
--	Date:	27/07/2018	
--	Des:	Lấy danh sách sinh viên đã thi theo đợt thi và môn thi
--==================================================================================
(
	@ExamID INT =0,
	@SubjectID INT =0
)
AS
BEGIN
	SELECT Ex.Name, Sh.Name, SS.ActivateTime, SS.EndTime, SJ.Code, SJ.Name,
		   ST.Name, ST.Code, QS.Approved, QS.Total, QS.Difficulty, QS.Mark, QS.Mark 
	FROM [dbo].[Exams] Ex
		INNER JOIN [dbo].[Shifts] Sh ON Ex.Id = Sh.ExamId
		INNER JOIN [dbo].[ShiftSubjects] SS ON Sh.Id = SS.ShiftId
		INNER JOIN [dbo].[Subjects] SJ ON SS.SubjectId = SJ.ID
		INNER JOIN [dbo].[ShiftSubjectStudents] SSS ON SSS.ShiftSubjectId = SS.Id
		INNER JOIN [dbo].[Students] ST ON SSS.StudentId = ST.Id
		INNER JOIN [dbo].[QuestionSheets] QS ON SSS.QuestionSheetId = QS.Id
	WHERE SJ.Id =@SubjectID AND Ex.Id = @ExamID
END


GO
/****** Object:  StoredProcedure [dbo].[GetMark]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetMark]
	@questionSheetId BIGINT
AS
BEGIN
	DECLARE @numberOfCorrect INT;
	DECLARE @total INT;
	SET @numberOfCorrect = (SELECT COUNT(*)
		FROM     dbo.QuestionSheetDetails AS qsd INNER JOIN dbo.Questions AS q ON qsd.QuestionId = q.Id
		WHERE    QuestionSheetId = @questionSheetId AND Correct = 1 AND q.Deleted = 0
		);
										
	SET @total = (SELECT COUNT(*)
		FROM dbo.QuestionSheetDetails sd
		INNER JOIN dbo.Questions q ON sd.QuestionId = q.Id
		WHERE sd.QuestionSheetId = @questionSheetId and q.Deleted=0
		);
	SELECT Mark,@numberOfCorrect as NumberOfCorrect, @total as Total 
	FROM dbo.QuestionSheets
	WHERE Id = @questionSheetId
END













GO
/****** Object:  StoredProcedure [dbo].[GetMatrixDetailByMatrixId]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetMatrixDetailByMatrixId]
@MatrixId int
AS
	SELECT * FROM MatrixDetails WHERE MatrixId = @MatrixId











GO
/****** Object:  StoredProcedure [dbo].[GetNameFacultyBySubjectId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetPaperQuestionSheetsByPaperShiftSubjectId]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[GetPaperQuestionSheetsByPaperShiftSubjectId]
@PaperShiftSubjectId int
AS
 SELECT * FROM PaperQuestionSheets WHERE PaperShiftSubjectId = @PaperShiftSubjectId











GO
/****** Object:  StoredProcedure [dbo].[GetQuantityQuestionDiscriminationBester]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetQuantityQuestionDiscriminationGood]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetQuantityQuestionSheetAdvByMarkAndAnswerIdAndQuestionId]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetQuantityQuestionSheetAdvByMarkAndAnswerIdAndQuestionId]

@Mark decimal(18,10),
@Answer BigInt,
@QuestionId BigInt
As
select ISNULL(COUNT(AnswerId),0) from QuestionSheetDetails QD Join QuestionSheets QS ON QD.QuestionSheetId = QS.Id 
where QS.Mark >@Mark And QD.AnswerId =@Answer And QD.QuestionId =@QuestionId 
Group By AnswerId











GO
/****** Object:  StoredProcedure [dbo].[GetQuantityQuestionSheetBelByMarkAndAnswerIdAndQuestionId]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[GetQuantityQuestionSheetBelByMarkAndAnswerIdAndQuestionId]

@Mark decimal(18,10),
@Answer BigInt,
@QuestionId BigInt
As
select ISNULL(COUNT(AnswerId),0) from QuestionSheetDetails QD Join QuestionSheets QS ON QD.QuestionSheetId = QS.Id 
where QS.Mark <@Mark And QD.AnswerId =@Answer And QD.QuestionId =@QuestionId 
Group By AnswerId











GO
/****** Object:  StoredProcedure [dbo].[GetQuestionByChapterId]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetQuestionByChapterId]
@ChapterId int
AS
	SELECT * FROM Questions where ChapterId =@ChapterId





GO
/****** Object:  StoredProcedure [dbo].[GetQuestionContent]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetQuestionIdByParentId]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetQuestionIdByParentId]

/*
Author:   			Haong Van Hieu
ALTERd: 			2017-05-27
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
/****** Object:  StoredProcedure [dbo].[GetQuestionSheet]    Script Date: 15/05/2021 12:38:34 PM ******/
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
        WHERE   [QuestionSheetDetails].[QuestionSheetId] = @questionSheetId and [Question].[Deleted] = 0;
    END;











GO
/****** Object:  StoredProcedure [dbo].[GetQuestionSheetByStudentCode]    Script Date: 15/05/2021 12:38:34 PM ******/
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
                AND dbo.ShiftSubjects.StateActivate = 2 --ca thi dc kích hoạt
                AND ( dbo.ShiftSubjects.Ended = 'false'
                      OR dbo.ShiftSubjects.Ended IS NULL
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
/****** Object:  StoredProcedure [dbo].[GetRemainingTimeByQuestionSheetId]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRemainingTimeByQuestionSheetId]
    @questionSheetId BIGINT ,
    @shiftSubjectId BIGINT
AS
    BEGIN
        DECLARE @endTime DATETIME ,
            @extraTime INT;
        SET @extraTime = ( SELECT    ExtraTime + Duration
                                  FROM      dbo.QuestionSheets
											INNER JOIN dbo.ShiftSubjects on dbo.QuestionSheets.ShiftSubjectId = dbo.ShiftSubjects.Id
                                  WHERE     dbo.QuestionSheets.Id = @questionSheetId
                                );
        SET @endTime = DATEADD(MINUTE, @extraTime,
                                       ( SELECT ActivateTime 
                                         FROM   dbo.ShiftSubjects
                                         WHERE  Id =  @shiftSubjectId
                                       ));
        SELECT  DATEDIFF(SECOND, GETDATE(), @endTime) AS [Duration];
    END;

GO
/****** Object:  StoredProcedure [dbo].[GetResult]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetResult] @questionSheetId BIGINT
AS
    BEGIN
        SELECT  [Order],
				Correct,
				IsNull(AnswerId,0) AS Answered
		FROM    dbo.QuestionSheetDetails INNER JOIN Questions ON QuestionSheetDetails.QuestionId = Questions.Id
		WHERE   QuestionSheetId = @questionSheetId AND 
		QuestionId in (
			select MAX(QuestionId)
			from QuestionSheetDetails
			where QuestionSheetId = @questionSheetId
			group by [order]
		)
		AND Questions.Deleted = 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[GetReviewQuestion]    Script Date: 15/05/2021 12:38:34 PM ******/
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
		   dbo.Chapters.Name AS ChapterName,
		   dbo.Questions.ParentId AS ParentId
	FROM dbo.QuestionSheetDetails JOIN dbo.Answers ON Answers.QuestionId = QuestionSheetDetails.QuestionId
	JOIN dbo.Questions ON Questions.Id = Answers.QuestionId
	JOIN dbo.Chapters ON Chapters.Id = Questions.ChapterId
	WHERE QuestionSheetId = @questionSheetId and Questions.Deleted = 0
END 

GO
/****** Object:  StoredProcedure [dbo].[GetSubjectAndQuantityQuestionShiftByShiftId]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSubjectAndQuantityQuestionShiftByShiftId]

/*
Author:   			Hoang Van Hieu
ALTERd: 			2017-06-07
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
/****** Object:  StoredProcedure [dbo].[GetSubjectByCode]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetSubjectByCode]
@code varchar(100)
AS
	Select * from Subjects where Code =@code







GO
/****** Object:  StoredProcedure [dbo].[GetSubjectByExamID_App]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetSubjectByExamID_App]
--==================================================
--	Creatd: Hoang Van Hieu
--	Date:	27/07/2018
--	Des:	Lấy danh sách môn học theo đợt thi
--	GetSubjectByExamID_App 2
--==================================================
(
	@ExamID INT =0
)
AS
BEGIN
	SELECT DISTINCT SJ.ID,SJ.Name
	FROM Subjects SJ
		INNER JOIN ShiftSubjects SS ON SJ.Id = SS.SubjectId
		INNER JOIN Shifts SH ON SS.ShiftId = SH.Id
		INNER JOIN Exams E ON SH.ExamId = E.Id
	WHERE E.ID =@ExamID
END



GO
/****** Object:  StoredProcedure [dbo].[InsertUser]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ListQuestionDeleted_SelectBy_ChapterId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ListQuestionDeleted_SelectBy_ChapterId_ParentId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Login]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[LoginSuccess]    Script Date: 15/05/2021 12:38:34 PM ******/
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
				SET LogIn = 1 , StateExam = 2 --true/ chuyển trạng thái đã đăng nhập
				WHERE ShiftSubjectId = @shiftSubjectId AND StudentId = @studentId 
					AND QuestionSheetId = @questionSheetId AND StateExam = 1
				SELECT 'true' AS Result
		END
	ELSE
		BEGIN 
			SELECT 'false' AS Result
		END
END














GO
/****** Object:  StoredProcedure [dbo].[LogOut]    Script Date: 15/05/2021 12:38:34 PM ******/
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
				SET LogIn = 0, StateExam = 1 --false/ chuyển trạng thái đã đăng xuất
				WHERE ShiftSubjectId = @shiftSubjectId AND StudentId = @studentId 
					AND QuestionSheetId = @questionSheetId AND StateExam != 3
				SELECT 'true' AS Result
		END
	ELSE
		BEGIN 
			SELECT 'false' AS Result
		END
END

GO
/****** Object:  StoredProcedure [dbo].[Matrices_SelectMax]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Matrices_SelectMax]

@Matrices int
/*
Author:   			Hoang Van Hieu
ALTERd: 			2017-05-05
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
/****** Object:  StoredProcedure [dbo].[MatricesInsert]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[MatricesSelectAll]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MatricesSelectAll]
	@Id BIGINT
AS
BEGIN
	SELECT * FROM dbo.Matrices
END











GO
/****** Object:  StoredProcedure [dbo].[MatricesSelectById]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[MatricesUpdate]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[MatrixDetailInsert]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[MatrixDetailSelectById]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[MatrixDetailUpdate]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PaperQuestionSheetDetailsInsert]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PaperQuestionSheetDetailsSelectByQuestionSheetId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PaperQuestionSheetsInsert]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Question_Delete]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Question_Delete_Temporary]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Question_Restore]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Question_SelectBy_ChapterId_ParentId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Question_SelectBy_Date]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Question_SelectBy_SubjectId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Question_SelectSoCauHoiCon]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[QuestionDeletedByParentId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[QuestionIdList_SelectBy_FacultyId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[QuestionIdList_SelectBy_SubjectId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_COUNT]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_Delete_SelectBy_ParentId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_FlagAsDeleted]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_Insert]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Questions_Insert]
@Content nvarchar(max),
@SubjectiveDifficulty decimal(18,10),
@ChapterId int,
@CreateDate datetime,
@Mark decimal(18,10),
@Duration int,
@ParentId bigint,
@Discrimination decimal(18,10),
@SubjectId int,
@Audio bit
AS
BEGIN
	DECLARE @STT int
	SET @STT =(select  (isnull(count(ManagementOrder),0)+1) from Questions where ChapterId = @ChapterId)
	INSERT INTO 	Questions
	(
				Content,
				SubjectiveDifficulty,
				ObjectiveDifficulty,
				Deleted,
				ChapterId,
				CreateDate,
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
				@SubjectiveDifficulty,
				@SubjectiveDifficulty,
				0,
				@ChapterId,
				@CreateDate,
				@Mark,
				@Duration,
				@ParentId,
				@Discrimination,
				@SubjectId,
				@STT,
				@Audio
	)
	DECLARE @Max int

	SELECT
			@Max = MAX([Id])
	FROM
			[dbo].[Questions]
		
	WHERE
			[ChapterId] = @ChapterId

	IF(@Max IS NULL) SELECT 0
	ELSE SELECT @Max
END








GO
/****** Object:  StoredProcedure [dbo].[Questions_Paging]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Questions_Paging]
	@PageNumber int
as
	select TOP(@PageNumber*2) * from Questions

















GO
/****** Object:  StoredProcedure [dbo].[Questions_Restore]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_Select_NumberOfChildQuestions]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_SelectAll]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_SelectAll_Deleted]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_SelectAllId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_ChapterId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_ChapterId_Paging]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_ChapterId_Paging1]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_ChapterId_ParentId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_Date]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_ParentId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_SubjectCode]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_SelectMax_IdQuestions]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_SelectOne]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_SelectPage]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_Update]    Script Date: 15/05/2021 12:38:34 PM ******/
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
@SubjectiveDifficulty decimal(18,10),
@Deleted bit,
@ChapterId int,
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
			[Mark] = @Mark,
			[SubjectiveDifficulty] = @SubjectiveDifficulty,
			[ObjectiveDifficulty] = @SubjectiveDifficulty,
			[ParentId] = @ParentId,
			[Deleted] = @Deleted,
			[UpdateDate] = @UpdateDate,
			[Duration] = @Duration,
			[Discrimination] = @Discrimination,
			[Audio] = @Audio
			
WHERE
			[Id] = @Id







GO
/****** Object:  StoredProcedure [dbo].[Questions_UpdateParentId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_Validation]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Questions_Validation_GetByParentId]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Questions_Validation_GetByParentId]
@StartDate varchar(100),
@EndDate varchar(100),
@ParentId int
-- WITH ENCRYPTION
AS

--nhỏ hơn hoặc bằng 2 câu trả lời
SELECT CH.Id, CH.Content,CH.ParentId,CH.ManagementOrder 
FROM Questions CH JOIN Answers CTL ON CTL.QuestionId = CH.Id
WHERE [ParentId] = @ParentId and Deleted = 'False' and ParentId != CH.Id AND CH.CreateDate BETWEEN @StartDate AND @EndDate AND validated =1
GROUP BY CH.Id, CH.ChapterId, CH.Content, CH.Interchange, CH.Mark,
		CH.SubjectiveDifficulty, CH.ObjectiveDifficulty, CH.ParentId, CH.Deleted,CH.Duration,
			CH.SelectedTimes, CH.CorrectTimes, CH.CreateDate, CH.UpdateDate, CH.Discrimination, CH.ManagementOrder,SubjectId,Audio,ListenedTimes,CH.validated
HAVING COUNT(CTL.Id)<=2

--không có đáp án
UNION

SELECT CH.Id, CH.Content,CH.ParentId,CH.ManagementOrder FROM Questions CH
WHERE CH.ParentId = @ParentId  AND CH.Id NOT IN(
	SELECT CH.Id
	FROM Questions CH JOIN Answers CTL ON CTL.QuestionId = CH.Id
	WHERE CTL.Correct = 'True'
	GROUP BY CH.Id
	HAVING COUNT(CTL.Correct) = 1
)

AND CH.Id != CH.ParentId AND CH.CreateDate BETWEEN @StartDate AND @EndDate






GO
/****** Object:  StoredProcedure [dbo].[QuestionsDeleted_SelectBy_ChapterId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[QuestionsDeleted_SelectBy_ParentId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[QuestionSheetDetailCreate]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[QuestionSheetDetailSelectById]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[QuestionSheetDetailUpdate]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[QuestionSheetGetAll]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[QuestionSheetGetAll]
as
Select * from QuestionSheets
order by Id Desc











GO
/****** Object:  StoredProcedure [dbo].[QuestionSheetID_SelectMax]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[QuestionSheetInsert]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[QuestionSheetSelectById]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[QuestionSheetUpdate]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[QuestionsSeach_SelectBy_ParentId]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[QuestionsSeach_SelectBy_ParentId]

/*
Author:   			Haong Van Hieu
Created: 			2017-05-27
Last Modified: 		2017-05-30
*/

@ParentId bigint
-- WITH ENCRYPTION
AS


SELECT
		Id, Content,ParentId, Discrimination, ObjectiveDifficulty, SubjectiveDifficulty
FROM
		[dbo].[Questions]
		
WHERE
		[ParentId] = @ParentId
		and Deleted = 'False' and ParentId != Id
ORDER BY Id






GO
/****** Object:  StoredProcedure [dbo].[RANDOMDOKHO]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[RANDOMDOKHO]
As
BEGIN
	DECLARE @QuestionId BigInt;
	DECLARE MY_CURSOR CURSOR 
	  LOCAL STATIC READ_ONLY FORWARD_ONLY
	FOR 
	SELECT DISTINCT Id 
	FROM Questions

	OPEN MY_CURSOR
	FETCH NEXT FROM MY_CURSOR INTO @QuestionId
	WHILE @@FETCH_STATUS = 0
	BEGIN
	UPDATE Questions SET ObjectiveDifficulty = (select RAND()* 0.8) WHERE Id =@QuestionId
	FETCH NEXT FROM MY_CURSOR INTO @QuestionId
	END
	CLOSE MY_CURSOR
	DEALLOCATE MY_CURSOR
END


GO
/****** Object:  StoredProcedure [dbo].[RANDOMTEST]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[RANDOMTEST]
As
BEGIN
	DECLARE @QuestionId BigInt;
	DECLARE MY_CURSOR CURSOR 
	  LOCAL STATIC READ_ONLY FORWARD_ONLY
	FOR 
	SELECT DISTINCT Id 
	FROM Questions

	OPEN MY_CURSOR
	FETCH NEXT FROM MY_CURSOR INTO @QuestionId
	WHILE @@FETCH_STATUS = 0
	BEGIN
	UPDATE Questions SET SelectedTimes = (ROUND((Rand()*0.5),2) *10000000) WHERE Id =@QuestionId
	UPDATE Questions SET CorrectTimes = Rand() *SelectedTimes WHERE Id =@QuestionId
		FETCH NEXT FROM MY_CURSOR INTO @QuestionId
	END
	CLOSE MY_CURSOR
	DEALLOCATE MY_CURSOR
END




GO
/****** Object:  StoredProcedure [dbo].[RANDOMTEST1]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[RANDOMTEST1]
As
BEGIN
	DECLARE @questionSheetId BigInt;
	DECLARE MY_CURSOR CURSOR 
	  LOCAL STATIC READ_ONLY FORWARD_ONLY
	FOR 
	SELECT DISTINCT Id
	FROM QuestionSheets

	OPEN MY_CURSOR
	FETCH NEXT FROM MY_CURSOR INTO @questionSheetId
	WHILE @@FETCH_STATUS = 0
	BEGIN 

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
		FETCH NEXT FROM MY_CURSOR INTO @questionSheetId
	END
	CLOSE MY_CURSOR
	DEALLOCATE MY_CURSOR
END



GO
/****** Object:  StoredProcedure [dbo].[RANDOMTEST12]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[RANDOMTEST12]
As
BEGIN
	DECLARE @QuestionId BigInt;
	DECLARE MY_CURSOR CURSOR 
	  LOCAL STATIC READ_ONLY FORWARD_ONLY
	FOR 
	SELECT DISTINCT Id 
	FROM Questions

	OPEN MY_CURSOR
	FETCH NEXT FROM MY_CURSOR INTO @QuestionId
	WHILE @@FETCH_STATUS = 0
	BEGIN
	update Questions SET Discrimination = round(RAND()*RAND()*0.7,2) WHERE Id =@QuestionId
		FETCH NEXT FROM MY_CURSOR INTO @QuestionId
	END
	CLOSE MY_CURSOR
	DEALLOCATE MY_CURSOR
END


GO
/****** Object:  StoredProcedure [dbo].[RANDOMTEST123]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[RANDOMTEST123]
As
BEGIN
	DECLARE @QuestionId BigInt;
	DECLARE MY_CURSOR CURSOR 
	  LOCAL STATIC READ_ONLY FORWARD_ONLY
	FOR 
	SELECT DISTINCT Id 
	FROM Questions

	OPEN MY_CURSOR
	FETCH NEXT FROM MY_CURSOR INTO @QuestionId
	WHILE @@FETCH_STATUS = 0
	BEGIN
	update Questions SET ObjectiveDifficulty = round(RAND()*RAND()*0.7,2) WHERE Id =@QuestionId
		FETCH NEXT FROM MY_CURSOR INTO @QuestionId
	END
	CLOSE MY_CURSOR
	DEALLOCATE MY_CURSOR
END


GO
/****** Object:  StoredProcedure [dbo].[RANDOMTEST12312]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[RANDOMTEST12312]
As
BEGIN
	DECLARE @QuestionId BigInt;
	DECLARE MY_CURSOR CURSOR 
	  LOCAL STATIC READ_ONLY FORWARD_ONLY
	FOR 
	SELECT DISTINCT Id 
	FROM Questions

	OPEN MY_CURSOR
	FETCH NEXT FROM MY_CURSOR INTO @QuestionId
	WHILE @@FETCH_STATUS = 0
	BEGIN
	update Questions SET ObjectiveDifficulty = round(RAND()*RAND()*0.8,2) WHERE Id =@QuestionId
		FETCH NEXT FROM MY_CURSOR INTO @QuestionId
	END
	CLOSE MY_CURSOR
	DEALLOCATE MY_CURSOR
END


GO
/****** Object:  StoredProcedure [dbo].[RestoreQuestionDeleted]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SeachQuestion]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SeachQuestionByDate]    Script Date: 15/05/2021 12:38:34 PM ******/
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
					Select Id, Content,ParentId,ManagementOrder,Discrimination, SubjectiveDifficulty, ObjectiveDifficulty from Questions where CreateDate = @StartTime AND ChapterId = @ChapterId And Deleted = 0
				ELSE
					Select Id, Content,ParentId,ManagementOrder,Discrimination,SubjectiveDifficulty, ObjectiveDifficulty from Questions Where CreateDate = @StartTime And SubjectId = @SubjectId And Deleted =0
			END
		ELSE
			BEGIN
				IF(@ChapterId !=0)
					Select Id, Content,ParentId,ManagementOrder,Discrimination,SubjectiveDifficulty, ObjectiveDifficulty from Questions where (CreateDate BETWEEN @StartTime AND @EndTime) AND ChapterId = @ChapterId  And Deleted = 0
				ELSE
					Select Id, Content,ParentId,ManagementOrder,Discrimination,SubjectiveDifficulty, ObjectiveDifficulty from Questions where (CreateDate BETWEEN @StartTime AND @EndTime) AND SubjectId = @SubjectId And Deleted = 0
			END
	END






GO
/****** Object:  StoredProcedure [dbo].[Shift_SelectByName]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ShiftDelete]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ShiftInsert]    Script Date: 15/05/2021 12:38:34 PM ******/
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
    @QuestionSheetALTERd BIT ,
    @Deleted BIT
AS
    BEGIN

        INSERT  INTO dbo.Shifts
                ( [Name] ,
                  --StartTime ,
                  --EndTime ,
                  --Activated ,
                  --ActivateTime ,
                  --Duration ,
                  --Ended ,
                  --EndDate ,
                  ExamId ,
                  QuestionSheetCreated ,
                  Deleted
	            )
        VALUES  ( @Name , -- Name - nvarchar(50)
                  --@StartTime , -- StartTime - datetime
                  --@EndTime , -- EndTime - datetime
                  --@Activated , -- Activated - bit
                  --@ActivateTime , -- ActivateTime - datetime
                  --@Duration , -- Duration - int
                  --@Ended , -- Ended - bit
                  --@EndTime , -- EndDate - datetime
                  @ExamId , -- ExamId - int
                  @QuestionSheetALTERd , -- QuestionSheetALTERd - bit
                  @Deleted  -- Deleted - bit
	            );
    END;












GO
/****** Object:  StoredProcedure [dbo].[ShiftSelectByExamId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ShiftSelectById]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ShiftSubjectDelete]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ShiftSubjectInsert]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ShiftSubjectSelectById]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ShiftSubjectSelectByShiftId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ShiftSubjectStudentInsert]    Script Date: 15/05/2021 12:38:34 PM ******/
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
    @LastLogIn DATETIME ,
    @LastLogOut DATETIME
AS
    BEGIN

        INSERT  INTO dbo.ShiftSubjectStudents
                ( ShiftSubjectId ,
                  StudentId ,
                  QuestionSheetId ,
                  LogIn ,
                  LastLogIn ,
                  LastLogOut,
				  InsertTime
                )
        VALUES  ( @ShiftSubjectId , -- ShiftSubjectId - bigint
                  @StudentId , -- StudentId - int
                  @QuestionSheetId , -- QuestionSheetId - bigint
                  @LogIn , -- LogIn - bit
                  @LastLogIn , -- LastLogIn - bit
                  @LastLogOut,  -- LastLogOut - bit
				  GETDATE()
                );
    END;












GO
/****** Object:  StoredProcedure [dbo].[ShiftSubjectStudentSelectById]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ShiftSubjectStudentUpdate]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ShiftSubjectStudentUpdate]
    @ShiftSubjectId BIGINT ,
    @StudentId INT ,
    @QuestionSheetId BIGINT ,
    @LogIn BIT ,
    @LastLogIn DATETIME ,
    @LastLogOut DATETIME
AS
    BEGIN

        UPDATE dbo.ShiftSubjectStudents
		SET [LogIn] = @LogIn, LastLogIn = @LastLogIn, LastLogOut = @LastLogOut, QuestionSheetId = @QuestionSheetId
        WHERE ShiftSubjectId = @ShiftSubjectId AND StudentId = @StudentId
    END;












GO
/****** Object:  StoredProcedure [dbo].[ShiftSubjectUpdate]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ShiftUpdate]    Script Date: 15/05/2021 12:38:34 PM ******/
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
    @QuestionSheetALTERd BIT ,
    @Deleted BIT
AS
    BEGIN

        UPDATE dbo.Shifts
		SET [Name] = @Name,
		--StartTime = @StartTime,
		--EndTime=@EndTime,
		--Activated = @Activated,
		--ActivateTime = @ActivateTime,
		--Duration = @Duration,
		--Ended = @Ended,
		--EndDate = @EndDate,
		ExamId = @ExamId,
		--QuestionSheetALTERd = @QuestionSheetALTERd,
		Deleted = @Deleted
        WHERE Id =@Id
    END;












GO
/****** Object:  StoredProcedure [dbo].[SoCauHoiChuaDuocThiTheoMaPhan]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[SoCauHoiChuaDuocThiTheoMaPhan]

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
/****** Object:  StoredProcedure [dbo].[SoCauHoiDuocThiTheoMaPhan]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SoLuongCauHoiDeTheoMaKhoa]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOIDETHEOMAMONHOC]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOIDETHEOMAPHAN]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SoLuongCauHoiKhoTheoMaKhoa]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOIKHOTHEOMAMONHOC]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOIKHOTHEOMAPHAN]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SoLuongCauHoiRatKhoTheoMaKhoa]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOIRATKHOTHEOMAMONHOC]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOIRATKHOTHEOMAPHAN]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SoLuongCauHoiTrungBinhTheoMaKhoa]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOITRUNGBINHTHEOMAMONHOC]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOITRUNGBINHTHEOMAPHAN]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SoLuongCauHoiTuongDoiKhoTheoMaKhoa]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOITUONGDOIKHOTHEOMAMONHOC]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOITUONGDOIKHOTHEOMAPHAN]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Subject_Delete]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Subject_SelectBy_QuestionDelete]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Subjects_Count]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Subjects_Count]
AS
SELECT COUNT([Id]) AS Quantity_Subjects
     
  FROM [dbo].[Subjects]



















GO
/****** Object:  StoredProcedure [dbo].[Subjects_FlagAsDeleted]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Subjects_Insert]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Subjects_Restore]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Subjects_SelectAll]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Subjects_SelectAll_Deleted]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Subjects_SelectBy_FacultyId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Subjects_SelectOne]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Subjects_SelectOneByName]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Subjects_SelectPage]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Subjects_Update]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateAnswer]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateDiscriminationForQuestion]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateDiscriminationForQuestionByChapterId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
	FROM Questions WHERE ChapterId =@ChapterId

	OPEN MY_CURSOR
	FETCH NEXT FROM MY_CURSOR INTO @QuestionId
	WHILE @@FETCH_STATUS = 0
	BEGIN 

		DECLARE @AnswerId BigInt;
		DECLARE MY_CURSOR_Ans CURSOR 
		  LOCAL STATIC READ_ONLY FORWARD_ONLY
		FOR 
		SELECT DISTINCT Id 
		FROM Answers

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
/****** Object:  StoredProcedure [dbo].[UpdateDiscriminationForQuestionBySubjectId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateListenTimes]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateObjectiveDifficulty]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateObjectiveDifficultyByChapterId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateObjectiveDifficultyBySubjectId]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdatePaperQuestionSheet]    Script Date: 15/05/2021 12:38:34 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateSelectedTimeCorrect]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[UpdateSelectedTimeCorrect] 
As
Update Answers set SelectedTimes = (select ISNULL(COUNT(AnswerId),0) from QuestionSheetDetails 
where Answers.Id = AnswerId  Group By AnswerId) WHere Id in (Select AnswerId from QuestionSheetDetails Group by AnswerId)


GO
/****** Object:  StoredProcedure [dbo].[User_SelectAll]    Script Date: 15/05/2021 12:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[User_SelectAll]
AS
	SELECT * FROM [Users]








GO
USE [master]
GO
ALTER DATABASE [QuanLyTracNghiem] SET  READ_WRITE 
GO
