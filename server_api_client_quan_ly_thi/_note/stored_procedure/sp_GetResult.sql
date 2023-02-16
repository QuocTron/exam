SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [dbo].[GetResult] @questionSheetId BIGINT
AS
    BEGIN
        SELECT  [Order] ,
                Correct
        FROM    dbo.QuestionSheetDetails
        WHERE   QuestionSheetId = @questionSheetId;
    END;











GO

