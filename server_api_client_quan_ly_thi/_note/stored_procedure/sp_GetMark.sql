SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [dbo].[GetMark]
	@questionSheetId BIGINT
AS
BEGIN
	SELECT Mark, NumberOfCorrect, Total 
	FROM dbo.QuestionSheets
	WHERE Id = @questionSheetId
END










GO

