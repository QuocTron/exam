SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO

ALTER PROCEDURE [dbo].[CaculateMark] @questionSheetId BIGINT
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

