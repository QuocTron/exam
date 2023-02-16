SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [dbo].[CheckLoginByStudentCode]
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
	AND dbo.Shifts.Ended = 0
    END;












GO

