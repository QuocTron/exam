SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [dbo].[CheckStudentCode]
    @studentCode NVARCHAR(100)
AS
    BEGIN
        SELECT  dbo.Students.Id
        FROM    dbo.Students
        WHERE   dbo.Students.Code = @studentCode;
    END;











GO

