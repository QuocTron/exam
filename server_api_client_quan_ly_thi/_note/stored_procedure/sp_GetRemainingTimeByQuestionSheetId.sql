SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [dbo].[GetRemainingTimeByQuestionSheetId]
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

