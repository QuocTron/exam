SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [dbo].[CheckStudentHasLogin]
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

