USE [ObjectiveTest]
GO
/****** Object:  Table [dbo].[Answers]    Script Date: 23-Jul-17 12:51:26 AM ******/
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
/****** Object:  Table [dbo].[Chapters]    Script Date: 23-Jul-17 12:51:26 AM ******/
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
/****** Object:  Table [dbo].[Exams]    Script Date: 23-Jul-17 12:51:26 AM ******/
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
/****** Object:  Table [dbo].[Faculties]    Script Date: 23-Jul-17 12:51:26 AM ******/
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
/****** Object:  Table [dbo].[Matrices]    Script Date: 23-Jul-17 12:51:26 AM ******/
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
/****** Object:  Table [dbo].[MatrixDetails]    Script Date: 23-Jul-17 12:51:26 AM ******/
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
/****** Object:  Table [dbo].[PaperQuestionSheetDetails]    Script Date: 23-Jul-17 12:51:26 AM ******/
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
/****** Object:  Table [dbo].[PaperQuestionSheets]    Script Date: 23-Jul-17 12:51:26 AM ******/
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
/****** Object:  Table [dbo].[PaperShiftSubjects]    Script Date: 23-Jul-17 12:51:26 AM ******/
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
/****** Object:  Table [dbo].[Questions]    Script Date: 23-Jul-17 12:51:26 AM ******/
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
/****** Object:  Table [dbo].[QuestionSheetDetails]    Script Date: 23-Jul-17 12:51:26 AM ******/
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
/****** Object:  Table [dbo].[QuestionSheets]    Script Date: 23-Jul-17 12:51:26 AM ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 23-Jul-17 12:51:26 AM ******/
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
/****** Object:  Table [dbo].[Shifts]    Script Date: 23-Jul-17 12:51:26 AM ******/
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
/****** Object:  Table [dbo].[ShiftSubjects]    Script Date: 23-Jul-17 12:51:26 AM ******/
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
/****** Object:  Table [dbo].[ShiftSubjectStudents]    Script Date: 23-Jul-17 12:51:26 AM ******/
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
/****** Object:  Table [dbo].[Students]    Script Date: 23-Jul-17 12:51:26 AM ******/
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
/****** Object:  Table [dbo].[Subjects]    Script Date: 23-Jul-17 12:51:26 AM ******/
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
/****** Object:  Table [dbo].[UserRoles]    Script Date: 23-Jul-17 12:51:26 AM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 23-Jul-17 12:51:26 AM ******/
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
