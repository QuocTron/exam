SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
ALTER PROC [dbo].[LoginSuccess]
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

