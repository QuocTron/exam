USE [ObjectiveTest]
GO
/****** Object:  StoredProcedure [dbo].[CaculateMark]    Script Date: 23-Jul-17 4:16:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CheckLoginByStudentCode]    Script Date: 23-Jul-17 4:16:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CheckStudentCode]    Script Date: 23-Jul-17 4:16:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CheckStudentHasLogin]    Script Date: 23-Jul-17 4:16:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GenerateExam]    Script Date: 23-Jul-17 4:16:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetMark]    Script Date: 23-Jul-17 4:16:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetQuestionContent]    Script Date: 23-Jul-17 4:16:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetQuestionSheet]    Script Date: 23-Jul-17 4:16:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetQuestionSheetByStudentCode]    Script Date: 23-Jul-17 4:16:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetRemainingTimeByQuestionSheetId]    Script Date: 23-Jul-17 4:16:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetResult]    Script Date: 23-Jul-17 4:16:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetReviewQuestion]    Script Date: 23-Jul-17 4:16:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[LoginSuccess]    Script Date: 23-Jul-17 4:16:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[LogOut]    Script Date: 23-Jul-17 4:16:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateAnswer]    Script Date: 23-Jul-17 4:16:30 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateListenTimes]    Script Date: 23-Jul-17 4:16:30 PM ******/
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
