USE [ObjectiveTestHutech]
GO
/****** Object:  StoredProcedure [dbo].[GetResult]    Script Date: 10/22/2019 9:16:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetResult] @questionSheetId BIGINT
AS
    BEGIN
        SELECT  [Order] ,
				Correct 
		FROM    dbo.QuestionSheetDetails
		WHERE   QuestionSheetId = @questionSheetId AND 
		QuestionId in (
			SELECT MAX(QuestionId)
			FROM QuestionSheetDetails
			WHERE QuestionSheetId = @questionSheetId
			GROUP BY [order]
		);
    END;
