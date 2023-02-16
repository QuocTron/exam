SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- ca thi đã dc kích hoạt và ca thi đó chưa kết thúc và xóa tạm bằng false hoặc null
-- sinh viên đó phải tồn tại trong database
--đề thi đó đã dc bắt đầu làm và chưa hoàn thành và dc chấp thuận

ALTER PROCEDURE [dbo].[GetQuestionSheetByStudentCode]
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

