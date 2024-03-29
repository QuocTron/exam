USE [ObjectiveTestFinalV1]
GO
/****** Object:  View [dbo].[AnswersV]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[AnswersV]
as
SELECT        Id, QuestionId, [Content], [Order], Correct, Interchange, SelectedTimes
FROM            dbo.Answers
WHERE        (Id IN
                             (SELECT        AnswerId
                               FROM            dbo.QuestionSheetDetails))





GO
/****** Object:  View [dbo].[QuestionsV]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[QuestionsV]
as
SELECT        Id, [Content], Interchange, SubjectiveDifficulty, SelectedTimes, CorrectTimes, Deleted, ChapterId, CreateDate, UpdateDate, Mark, Duration, ParentId, Audio, Discrimination, ManagementOrder, SubjectId, 
                         ListenedTimes, ObjectiveDifficulty
FROM            dbo.Questions
WHERE        (Id IN
                             (SELECT        QuestionId
                               FROM            dbo.QuestionSheetDetails))






GO
/****** Object:  View [dbo].[QuestionV]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[QuestionV]
as
SELECT        Id, [Content], Interchange, SubjectiveDifficulty, SelectedTimes, CorrectTimes, Deleted, ChapterId, CreateDate, UpdateDate, Mark, Duration, ParentId, Audio, Discrimination, ManagementOrder, SubjectId, 
                         ListenedTimes, ObjectiveDifficulty
FROM            dbo.Questions
WHERE        (Id IN
                             (SELECT        QuestionId
                               FROM            dbo.QuestionSheetDetails))






GO
/****** Object:  StoredProcedure [dbo].[Answers_Insert]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Answers_Insert]

/*
Author:   			Nguyen Dinh Anh
Created: 			2011-3-9
Last Modified: 		2011-3-9
*/

@QuestionId bigint,
@Content nvarchar(max),
@Order int,
@Correct bit,
@Interchange bit

-- WITH ENCRYPTION
AS

INSERT INTO 	[dbo].[Answers] 
(

				[QuestionId],
				[Content],
				[Order],
				[Correct],
				[Interchange]
) 

VALUES 
(
				@QuestionId,
				@Content,
				@Order,
				@Correct,
				@Interchange
				
)











GO
/****** Object:  StoredProcedure [dbo].[Answers_SelectBy_QuestionId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[Answers_SelectBy_QuestionId]

/*
Author:   			Pham Phu Thanh Sang
Created: 			2010-11-13
Last Modified: 		2010-11-13
*/

@QuestionId bigint
-- WITH ENCRYPTION
AS


SELECT
		[Id],
		[QuestionId],
		[Content],
		[Order],
		[Correct],
		[Interchange]
		
FROM
		[dbo].[Answers]
		
WHERE
		[QuestionId] = @QuestionId
ORDER BY [Order]











GO
/****** Object:  StoredProcedure [dbo].[Answers_Update]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Answers_Update]

/*
Author:   			Nguyen Dinh Anh
Created: 			2011-3-9
Last Modified: 		2011-3-9
*/
	
@Id bigint, 
@QuestionId bigint, 
@Content nvarchar(max), 
@Order int, 
@Correct bit, 
@Interchange bit 

-- WITH ENCRYPTION
AS

UPDATE 		[dbo].[Answers] 

SET
			[QuestionId] = @QuestionId,
			[Content] = @Content,
			[Order] = @Order,
			[Correct] = @Correct,
			[Interchange] = @Interchange
			
WHERE
			[Id] = @Id 












GO
/****** Object:  StoredProcedure [dbo].[Chapter_SelectBy_ParentId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Chapter_SelectBy_ParentId]

/*
Author:   			Hoang Van Hieu
Created: 			2015-05-25
Last Modified: 		2017-05-25
*/

@ParentId int
-- WITH ENCRYPTION
AS


SELECT
		*
FROM
		[dbo].[Chapters]
		
WHERE
		ParentId = @ParentId
		and Deleted = 'False' And Validated =1
ORDER BY ManagementOrder


GO
/****** Object:  StoredProcedure [dbo].[Chapter_SelectBy_SubjectId_ParentId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Chapter_SelectBy_SubjectId_ParentId]

/*
Author:   			Hoang Van Hieu
Created: 			2016-06-06
Last Modified: 		2017-05-05
*/

@SubjectId int,
@ParentId int
-- WITH ENCRYPTION
AS


SELECT
		*
		
FROM
		[dbo].[Chapters]
		
WHERE
		[SubjectId] = @SubjectId
	AND	[ParentId] = @ParentId
	AND  Deleted = 'False' And Validated =1

ORDER BY [Order], Name





GO
/****** Object:  StoredProcedure [dbo].[Chapter_SelectBy_SubjectId_ParentId_QuestionDelted]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Chapter_SelectBy_SubjectId_ParentId_QuestionDelted]

/*
Author:   			Hoang Van Hieu
Created: 			2017-06-02
Last Modified: 		2017-06-02
*/

@SubjectId int,
@ParentId int
-- WITH ENCRYPTION
AS

SELECT  P.Id, P.Name, P.ManagementOrder,P.ParentId , Count(P.Id) as 'SoCauHoi'

FROM 
	
	[dbo].[Subjects] MH
	JOIN [dbo].[Chapters] P ON P.SubjectId = MH.Id
	JOIN [dbo].[Questions] CH ON CH.ChapterId = P.Id

WHERE 
	
	CH.Deleted = 'true' AND CH.Validated  =1
	AND MH.Id = @SubjectId


GROUP BY P.Id, P.Name, P.ManagementOrder, P.ParentId


GO
/****** Object:  StoredProcedure [dbo].[Chapters_Insert]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author:   			Hoang Van Hieu
Created: 			2017-05-05
Last Modified: 		2017-05-05
*/
CREATE PROCEDURE [dbo].[Chapters_Insert]
@SubjectId int,
@Name nvarchar(100),
@Content nvarchar(1000),
@Order int,
@ParentId int,
@Deleted bit

AS
BEGIN
	DECLARE @STT int
	SET @STT =(select  (isnull(count(ManagementOrder),0)+1) from Chapters where SubjectId = @SubjectId)
	INSERT INTO 	[dbo].[Chapters] 
	(
					[SubjectId],
					[Name],
					[Content],
					[Order],
					[ParentId],
					[Deleted],
					[ManagementOrder]
	) 
	VALUES 
	(
				
					@SubjectId,
					@Name,
					@Content,
					@Order,
					@ParentId,
					@Deleted,
					@STT		
	)
END





GO
/****** Object:  StoredProcedure [dbo].[Chapters_Restore]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- RESTORE PHAN
CREATE PROCEDURE [dbo].[Chapters_Restore]	
@Id int

AS
UPDATE 
	Questions
SET
	Deleted = 'False'

WHERE 
Id IN (SELECT Id 
					FROM Chapters
					WHERE Id = @Id
					and Deleted = 'True'
					)
	and Deleted = 'True';

UPDATE 
	Chapters
SET 
	Deleted = 'False'
WHERE 
	Id = @Id
	and Deleted = 'True';












GO
/****** Object:  StoredProcedure [dbo].[Chapters_SelectAll]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- SELECT ALL PHAN
CREATE PROCEDURE [dbo].[Chapters_SelectAll]

AS
SELECT
		[Id],
		[SubjectId],
		[Name],
		[Content],
		[Order],
		[ParentId],
		[Deleted]	
FROM
		[dbo].[Chapters]
WHERE Validated =1
GO
/****** Object:  StoredProcedure [dbo].[Chapters_SelectOne]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Chapters_SelectOne]

/*
Author:   			Nguyen Bao Quoc
Created: 			2011-3-9
Last Modified: 		2011-3-9
*/

@Id int
-- WITH ENCRYPTION
AS


SELECT
		[Id],
		[SubjectId],
		[Name],
		[Content],
		[Order],
		[ParentId],
		[Deleted],
		[ManagementOrder]
		
FROM
		[dbo].[Chapters]
		
WHERE
		[Id] = @Id AND validated =1
GO
/****** Object:  StoredProcedure [dbo].[Chapters_SelectOneByName]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Chapters_SelectOneByName]

/*
Author:   			Nguyen Bao Quoc
Created: 			2011-3-9
Last Modified: 		2011-3-9
*/

@SubjectId int,
@ParentId int,
@Name nvarchar(100)
-- WITH ENCRYPTION
AS


SELECT	*
FROM	[dbo].[Chapters]
WHERE	[SubjectId] = @SubjectId
	AND [ParentId] = @ParentId
	AND	Lower([Name]) = Lower(@Name)
	AND validated =1

GO
/****** Object:  StoredProcedure [dbo].[Chapters_Update]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- UPDATE PHAN
CREATE PROCEDURE [dbo].[Chapters_Update]
@Id int, 
@SubjectId int, 
@Name nvarchar(250), 
@Content nvarchar(max), 
@Order int, 
@ParentId int, 
@Deleted bit 

AS
UPDATE 		[dbo].[Chapters] 
SET
			[SubjectId] = @SubjectId,
			[Name] = @Name,
			[Content] = @Content,
			[Order] = @Order,
			[ParentId] = @ParentId,
			[Deleted] = @Deleted	
WHERE
			[Id] = @Id












GO
/****** Object:  StoredProcedure [dbo].[ChapterSelectBySubjectId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ChapterSelectBySubjectId]

/*
Author:   			Nguyen Bao Quoc
Created: 			2011-3-9
Last Modified: 		2011-3-9
*/

@SubjectId int
-- WITH ENCRYPTION
AS


SELECT
		*
		
FROM
		[dbo].[Chapters]
		
WHERE
		SubjectId = @SubjectId
		AND Deleted = 'False' And Validated =1

ORDER BY [ManagementOrder]

GO
/****** Object:  StoredProcedure [dbo].[CheckChapter]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[CheckChapter]

/*
Author:   			Nguyen Bao Quoc
Created: 			2011-3-9
Last Modified: 		2011-3-9
*/

@Id int,
@SubjectId int
-- WITH ENCRYPTION
AS


SELECT
		[Id],
		[SubjectId],
		[Name],
		[Content],
		[Order],
		[ParentId],
		[Deleted],
		[ManagementOrder]
		
FROM
		[dbo].[Chapters]
		
WHERE
		[Id] = @Id AND validated =1 AND SubjectId = @SubjectId
GO
/****** Object:  StoredProcedure [dbo].[CheckSubjectBySubjectIdAndName]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[CheckSubjectBySubjectIdAndName]
@Code nvarchar(100),
@Name nvarchar(100)
AS
SELECT * FROM Subjects
WHERE Code = @Code AND Name =@Name
GO
/****** Object:  StoredProcedure [dbo].[DeleteTemporaryQuestion]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DeleteTemporaryQuestion]
@Id Bigint
AS
UPDATE  Questions SET Deleted ='true', validated =0
WHERE Id =@Id
GO
/****** Object:  StoredProcedure [dbo].[Exams_Delete]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Exams_Delete]
	@Id int,
	@Deleted bit
AS
UPDATE [dbo].[Exams]
   SET [Deleted] = @Deleted
 WHERE [Id] = @Id






GO
/****** Object:  StoredProcedure [dbo].[Exams_Insert]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Exams_Insert]

@Name nvarchar(100),
@CreateDate datetime,
@UserId int,
@Deleted bit

-- WITH ENCRYPTION
AS

INSERT INTO 	[dbo].[Exams] 
(
				[Name],
				[CreateDate],
				[UserId],
				[Deleted],
				[Desktop]
) 

VALUES 
(
				@Name,
				@CreateDate,
				@UserId,
				@Deleted,
				1
)






GO
/****** Object:  StoredProcedure [dbo].[Exams_SelectAll]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Exams_SelectAll]

/*
Author:   			Nguyen Bao Quoc
Created: 			2011-3-9
Last Modified: 		2011-3-9
*/
-- WITH ENCRYPTION
AS


SELECT
		Id, Name as TenDotThi, UserId, CreateDate, Deleted, N'Chi tiết đợt thi' as ShiftOfExam
		
FROM
		[dbo].[Exams] where Deleted = 'false' and Desktop =1





GO
/****** Object:  StoredProcedure [dbo].[Exams_SelectByName]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Exams_SelectByName]

@Name nvarchar(100)

AS


SELECT
		Id, Name as TenDotThi, UserId, CreateDate, Deleted
		
FROM
		[dbo].[Exams] Where Name =@Name






GO
/****** Object:  StoredProcedure [dbo].[Exams_Update]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Exams_Update]
	@Id int,
	@Name nvarchar(100),
	@Deleted bit
AS
UPDATE [dbo].[Exams]
   SET [Name] = @Name
      ,[Deleted] = @Deleted
 WHERE [Id] = @Id





GO
/****** Object:  StoredProcedure [dbo].[Faculties_Insert]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Faculties_Insert]

/*
Author:   			Hoang Van Hieu
Created: 			2017-05-05
Last Modified: 		2017-05-05
*/

@Name nvarchar(100),
@Deleted bit

-- WITH ENCRYPTION
AS

INSERT INTO 	[dbo].[Faculties] 
(
				[Name],
				[Deleted]
) 

VALUES 
(
				@Name,
				@Deleted
				
)












GO
/****** Object:  StoredProcedure [dbo].[Faculties_Retore]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Faculties_Retore]

/*
Author:   			Hoang Van Hieu
Created: 			2016-09-29
Last Modified: 		2016-09-29
*/
	
@Id int

-- WITH ENCRYPTION
AS
BEGIN
	UPDATE Faculties SET Deleted =0 , Validated =1 Where Id =@Id;
	UPDATE Subjects SET Deleted =0 where FacultyId = @Id;
	UPDATE Chapters SET Deleted = 0 WHERE SubjectId in (Select Id from Subjects WHERE FacultyId =@Id)
	UPDATE Questions SET Deleted = 0
	WHERE SubjectId in (Select Id from Subjects WHERE FacultyId =@Id)
END;
GO
/****** Object:  StoredProcedure [dbo].[Faculties_SelectAll]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Faculties_SelectAll]

/*
Author:   			Hoang Van Hieu
Created: 			2011-3-9
Last Modified: 		2011-3-9
*/
-- WITH ENCRYPTION
AS


SELECT
		[Id],
		[Name],
		[Deleted]
		
FROM
		[dbo].[Faculties]
WHERE Deleted = 'false' AND Validated = 1
GO
/****** Object:  StoredProcedure [dbo].[Faculties_SelectOne]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Faculties_SelectOne]

/*
Author:   			Hoang Van Hieu
Created: 			2016-09-29
Last Modified: 		2016-09-29
*/

@Id int
-- WITH ENCRYPTION
AS


SELECT
		*
		
FROM
		[dbo].[Faculties]
		
WHERE
		[Id] = @Id





GO
/****** Object:  StoredProcedure [dbo].[Faculties_SelectOneByName]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Faculties_SelectOneByName]

/*
Author:   			Nguyen Bao Quoc
Created: 			2011-3-8
Last Modified: 		2011-3-8
*/

@Name nvarchar(100)
-- WITH ENCRYPTION
AS


SELECT
		*		
FROM
		[dbo].[Faculties]
		
WHERE
		lower([Name]) =  lower(@Name)
		and Deleted = 'False' and Validated =1
GO
/****** Object:  StoredProcedure [dbo].[Faculties_Update]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Faculties_Update]

/*
Author:   			Hoang Van Hieu
Created: 			2016-09-29
Last Modified: 		2016-09-29
*/
	
@Id int, 
@Name nvarchar(250), 
@Deleted bit,
@Comment nvarchar(100) 

-- WITH ENCRYPTION
AS
BEGIN
	IF(@Deleted ='false')
		BEGIN
		UPDATE 		[dbo].[Faculties] 
		SET
					[Name] = @Name,
					[Comment] = @Comment
		WHERE
					[Id] = @Id
		END
	ELSE
		BEGIN
			UPDATE Faculties SET Deleted ='true' where Id =@Id;
			UPDATE Subjects SET Deleted ='true'where FacultyId = @Id;
			UPDATE Chapters SET Deleted = 'true'WHERE SubjectId in (Select Id from Subjects WHERE FacultyId =@Id)
			UPDATE Questions SET Deleted = 'true'
			WHERE SubjectId in (Select Id from Subjects WHERE FacultyId =@Id)
		END

END;





GO
/****** Object:  StoredProcedure [dbo].[Faculty_Delete]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Faculty_Delete]

/*
Author:   			Hoang Van Hieu
Created: 			2016-09-29
Last Modified: 		2016-09-29
*/

@Id int
As
	BEGIN
			UPDATE Faculties SET Deleted ='true', Validated =0 where Id =@Id;
			UPDATE Subjects SET Deleted ='true', Validated =0 where FacultyId = @Id;
			UPDATE Chapters SET Deleted = 'true', Validated =0 WHERE SubjectId in (Select Id from Subjects WHERE FacultyId =@Id)
			UPDATE Questions SET Deleted = 'true', Validated =0
			WHERE SubjectId in (Select Id from Subjects WHERE FacultyId =@Id)
	END


GO
/****** Object:  StoredProcedure [dbo].[Faculty_Delete_By_Id]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Faculty_Delete_By_Id]
@FacultyId int
AS
BEGIN
	DELETE FROM [dbo].[QuestionSheetDetails]
			WHERE QuestionId IN( SELECT Id FROM Questions WHERE SubjectId IN (SELECT Id From Subjects WHERE FacultyId =@FacultyId))

	DELETE  FROM Answers 
	WHERE QuestionId IN( SELECT Id FROM Questions WHERE SubjectId IN (SELECT Id From Subjects WHERE FacultyId =@FacultyId))

	DELETE FROM Questions
	WHERE SubjectId IN (SELECT Id From Subjects WHERE FacultyId =@FacultyId)

	DELETE FROM MatrixDetails 
	WHERE ChapterId In (SELECT Id FROM Chapters WHERE SubjectId IN (SELECT Id From Subjects WHERE FacultyId =@FacultyId))

	DELETE FROM ShiftSubjectStudents
	WHERE ShiftSubjectId IN (SELECT Id FROM ShiftSubjects WHERE SubjectId IN (SELECT Id From Subjects WHERE FacultyId =@FacultyId))

	DELETE FROM ShiftSubjects
	WHERE SubjectId IN (SELECT Id From Subjects WHERE FacultyId =@FacultyId)

	DELETE FROM Matrices
	WHERE SubjectId IN  (SELECT Id From Subjects WHERE FacultyId =@FacultyId)

	DELETE FROM Chapters
	WHERE SubjectId IN (SELECT Id From Subjects WHERE FacultyId =@FacultyId)

	DELETE FROM Subjects
	WHERE FacultyId =@FacultyId

	DELETE FROM Faculties
	WHERE Id =@FacultyId

END





GO
/****** Object:  StoredProcedure [dbo].[Faculty_SelectBy_QuestionDelete]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Faculty_SelectBy_QuestionDelete]

/*
Author:   			HOANG VAN HIEU
Created: 			2017-02-06
Last Modified: 		2017-02-06
*/

AS

SELECT  K.Id, K.Name , Count(K.Id) as 'SoCauHoi'

FROM 

	[dbo].[Faculties] K
	JOIN [dbo].[Subjects] MH ON MH.FacultyId =  K.Id
	JOIN [dbo].[Chapters] P ON P.SubjectId = MH.Id
	JOIN [dbo].[Questions] CH ON CH.ChapterId = P.Id

WHERE 
	
	(CH.Deleted = 'true'OR K.Deleted ='true' OR MH.Deleted ='true' OR P.Deleted ='true') And K.Validated =1 AND CH.Validated =1

GROUP BY K.Id, K.Name
GO
/****** Object:  StoredProcedure [dbo].[GenerateExam]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GenerateExam] 
	@number int, 
	@subjectId int
AS
BEGIN
	SELECT TOP (@number) Id FROM dbo.Questions WHERE SubjectId = @subjectId ORDER BY NEWID()
END




GO
/****** Object:  StoredProcedure [dbo].[GetAnswerByQuestionId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAnswerByQuestionId] @questionId BIGINT
AS
    BEGIN
        IF ( ( SELECT   Interchange
               FROM     dbo.Questions
               WHERE    Id = @questionId
             ) = 1 )
            BEGIN
                SELECT  QuestionId ,
                        Id ,
                        Content ,
                        [Order]
                FROM    dbo.Answers
                WHERE   QuestionId = @questionId
                ORDER BY NEWID();
            END;
        ELSE
            BEGIN
                SELECT  QuestionId ,
                        Id ,
                        Content ,
                        [Order]
                FROM    dbo.Answers
                WHERE   QuestionId = @questionId
                ORDER BY [Order];
            END;
    END;





GO
/****** Object:  StoredProcedure [dbo].[GetChaperId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetChaperId]
	@SubjectId int,
	@TenPhanCha nvarchar(100),
	@TenPhanCon nvarchar(100)
	AS
	BEGIN
		IF(@TenPhanCha !='')
			BEGIN
				DECLARE @Ma int
				SET @Ma =(Select Id from Chapters
				where SubjectId = @SubjectId and [Name] =@TenPhanCha) 
				Select * from Chapters
				where SubjectId = @SubjectId and [Name] =@TenPhanCon AND ParentId = @Ma
			END
		ELSE
			BEGIN
				Select * from Chapters
				where SubjectId = @SubjectId and [Name] =@TenPhanCon 
			END

	END
GO
/****** Object:  StoredProcedure [dbo].[GetChapterId_SelectBy_ParentId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetChapterId_SelectBy_ParentId]

/*
Author:   			Hoang Van Hieu
Created: 			2015-05-25
Last Modified: 		2017-05-25
*/

@ParentId int
-- WITH ENCRYPTION
AS


SELECT
		Id
FROM
		[dbo].[Chapters]
		
WHERE
		[ParentId] = @ParentId
		and Deleted = 'False' And validated =1
ORDER BY Id

GO
/****** Object:  StoredProcedure [dbo].[GetListQuestionCorretTimeHighest]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetListQuestionCorretTimeHighest]
@SubjectId int
AS
	Select top 100 percent Id, Content,ParentId,ManagementOrder from Questions
	WHERE SubjectId = @SubjectId And Deleted =0
	order by CorrectTimes DESC

GO
/****** Object:  StoredProcedure [dbo].[GetListQuestionCorretTimeLowest]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--thống kê top 100 câu đúng ít nhất theo môn học
CREATE PROC [dbo].[GetListQuestionCorretTimeLowest]
@SubjectId int
AS
	Select top 100 percent Id, Content,ParentId,ManagementOrder from Questions
	WHERE SubjectId = @SubjectId AND Deleted =0
	order by CorrectTimes ASC

GO
/****** Object:  StoredProcedure [dbo].[GetListQuestionRateHighest]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetListQuestionRateHighest]
@SubjectId int
AS
	Select top 100 percent Id, Content,ParentId,ManagementOrder from Questions
	WHERE SubjectId = @SubjectId AND Deleted =0
	order by CONVERT(decimal(18,10),(CorrectTimes))/ CONVERT(decimal(18,10),(SelectedTimes)) desc

GO
/****** Object:  StoredProcedure [dbo].[GetListQuestionRateLowest]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetListQuestionRateLowest]
@SubjectId int
AS
	Select top 100 percent Id, Content,ParentId,ManagementOrder from Questions
	WHERE SubjectId = @SubjectId AND Deleted =0
	order by CONVERT(decimal(18,10),(CorrectTimes))/ CONVERT(decimal(18,10),(SelectedTimes)) ASC

GO
/****** Object:  StoredProcedure [dbo].[GetListQuestionSelectdTimeHighest]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetListQuestionSelectdTimeHighest]
@SubjectId int
AS
	Select top 100 percent Id, Content,ParentId,ManagementOrder from Questions
	WHERE SubjectId = @SubjectId AND Deleted =0
	order by SelectedTimes DESC

GO
/****** Object:  StoredProcedure [dbo].[GetListQuestionSelectdTimeZero]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetListQuestionSelectdTimeZero]
@SubjectId int
AS
	select top 100 percent Id, Content,ParentId,ManagementOrder from Questions Where SelectedTimes =0 AND SubjectId =@SubjectId AND Deleted =0

GO
/****** Object:  StoredProcedure [dbo].[GetMatrixDetailByMatrixId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetMatrixDetailByMatrixId]
@MatrixId int
AS
	SELECT * FROM MatrixDetails WHERE MatrixId = @MatrixId





GO
/****** Object:  StoredProcedure [dbo].[GetNameFacultyBySubjectId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetNameFacultyBySubjectId]
@SubjectId int
AS
BEGIN
	DECLARE @Name nvarchar(50);
	SET @Name =(Select f.Name FROM Faculties f join Subjects s On s.FacultyId = f.Id where s.Id = @SubjectId)
	Select @Name		
END




GO
/****** Object:  StoredProcedure [dbo].[GetPaperQuestionSheetsByPaperShiftSubjectId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[GetPaperQuestionSheetsByPaperShiftSubjectId]
@PaperShiftSubjectId int
AS
 SELECT * FROM PaperQuestionSheets WHERE PaperShiftSubjectId = @PaperShiftSubjectId





GO
/****** Object:  StoredProcedure [dbo].[GetQuantityQuestionDiscriminationBester]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetQuantityQuestionDiscriminationBester]
@SubjectId int,
@Limit decimal(18,10)
AS
BEGIN
	Declare @number int;
	SET @number = (SELECT Id from Questions WHERE SubjectId = @SubjectId AND Discrimination> @Limit);
	
	IF(@number IS NULL) 
		SELECT 0
	ELSE 
		SELECT @number
END

GO
/****** Object:  StoredProcedure [dbo].[GetQuantityQuestionDiscriminationGood]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetQuantityQuestionDiscriminationGood]
@SubjectId int,
@LimitS decimal(18,10),
@LimitE decimal(18,10)
AS
BEGIN
	Declare @number int;
	SET @number = (SELECT COUNT(ID) from Questions WHERE SubjectId = @SubjectId AND Discrimination BETWEEN @LimitS AND @LimitE);
	
	IF(@number IS NULL) 
		SELECT 0
	ELSE 
		SELECT @number
END

GO
/****** Object:  StoredProcedure [dbo].[GetQuantityQuestionSheetAdvByMarkAndAnswerIdAndQuestionId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[GetQuantityQuestionSheetAdvByMarkAndAnswerIdAndQuestionId]

@Mark decimal(18,10),
@Answer BigInt,
@QuestionId BigInt
As
select ISNULL(COUNT(AnswerId),0) from QuestionSheetDetails QD Join QuestionSheets QS ON QD.QuestionSheetId = QS.Id 
where QS.Mark >@Mark And QD.AnswerId =@Answer And QD.QuestionId =@QuestionId 
Group By AnswerId





GO
/****** Object:  StoredProcedure [dbo].[GetQuantityQuestionSheetBelByMarkAndAnswerIdAndQuestionId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROC [dbo].[GetQuantityQuestionSheetBelByMarkAndAnswerIdAndQuestionId]

@Mark decimal(18,10),
@Answer BigInt,
@QuestionId BigInt
As
select ISNULL(COUNT(AnswerId),0) from QuestionSheetDetails QD Join QuestionSheets QS ON QD.QuestionSheetId = QS.Id 
where QS.Mark <@Mark And QD.AnswerId =@Answer And QD.QuestionId =@QuestionId 
Group By AnswerId





GO
/****** Object:  StoredProcedure [dbo].[GetQuestionContent]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetQuestionContent] @questionId BIGINT
AS
    BEGIN
        SELECT  Content ,
                Audio
        FROM    dbo.Questions
        WHERE Id=@questionId
    END;





GO
/****** Object:  StoredProcedure [dbo].[GetQuestionIdByParentId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetQuestionIdByParentId]

/*
Author:   			Haong Van Hieu
Created: 			2017-05-27
Last Modified: 		2017-05-30
*/

@ParentId bigint
-- WITH ENCRYPTION
AS


SELECT
		Id
FROM
		[dbo].[Questions]
		
WHERE
		[ParentId] = @ParentId
		and Deleted = 'False' and ParentId != Id
ORDER BY Id



GO
/****** Object:  StoredProcedure [dbo].[GetReviewQuestion]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetReviewQuestion] 
	@questionSheetId BIGINT
AS
BEGIN
	SELECT dbo.QuestionSheetDetails.QuestionId ,
		   dbo.QuestionSheetDetails.AnswerId AS AnswerCurrentChoose,
		   dbo.Answers.Id AS AnswerId,
		   dbo.Answers.[Order] AS AnswerOrder,
           dbo.QuestionSheetDetails.[Order] AS QuestionOrder,
		   dbo.Chapters.Name AS ChapterName
	FROM dbo.QuestionSheetDetails JOIN dbo.Answers ON Answers.QuestionId = QuestionSheetDetails.QuestionId
	JOIN dbo.Questions ON Questions.Id = Answers.QuestionId
	JOIN dbo.Chapters ON Chapters.Id = Questions.ChapterId
	WHERE QuestionSheetId = @questionSheetId
END 




GO
/****** Object:  StoredProcedure [dbo].[GetSubjectAndQuantityQuestionShiftByShiftId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSubjectAndQuantityQuestionShiftByShiftId]

/*
Author:   			Hoang Van Hieu
Created: 			2017-06-07
Last Modified: 		2017-06-07
*/
@ShiftId int

AS

BEGIN
	
				SELECT  PSS.Id, S.Name,PSS.MatrixId,PSS.SubjectId, Count(PSS.Id)-1 as 'SoDeThi',N'Thêm đề thi' as 'TaoDeThi', N'Xem đề thi' as 'ListQuestionSheet'
				FROM 

					[dbo].[PaperShiftSubjects] PSS
					left JOIN [dbo].[PaperQuestionSheets] PQS ON PQS.PaperShiftSubjectId =  PSS.Id
					left JOIN [dbo].[Subjects] S ON PSS.SubjectId = S.Id
				WHERE PSS.ShiftId = @ShiftId and PSS.Deleted =0
				GROUP BY PSS.Id,S.Name,PSS.MatrixId,PSS.SubjectId
END



GO
/****** Object:  StoredProcedure [dbo].[GetSubjectByCode]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetSubjectByCode]
@code varchar(100)
AS
	Select * from Subjects where Code =@code

GO
/****** Object:  StoredProcedure [dbo].[InsertUser]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[InsertUser]
           @Username nvarchar(50),
           @Passwoed nvarchar(128),
           @Name nvarchar(50),
           @CreateDate datetime,
		   @Deleted bit,
		   @Comment nvarchar(100),
		   @FacultyId int,
		   @SubjectID int
AS
INSERT INTO [dbo].[Users]
           ([Username]
           ,[Password]
           ,[Name]
           ,[CreateDate]
		   ,[Deleted]
		   ,[Comment]
		   ,[LastPasswordChanged]
		   ,[LastActivity]
		   ,[LastLogIn]
		   ,[LastLogOut]
		   ,[FacultyId]
		   ,[SubjectId]
           )
     VALUES
           (@Username,
           @Passwoed,
           @Name,
           @CreateDate,
		   @Deleted,
		   @Comment,
		   @CreateDate,
		   @CreateDate,
		   @CreateDate,
		   @CreateDate,
		   @FacultyId,
		   @SubjectID
           )







GO
/****** Object:  StoredProcedure [dbo].[ListQuestionDeleted_SelectBy_ChapterId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ListQuestionDeleted_SelectBy_ChapterId]

/*
Author:   			Nguyen Dinh Anh
Created: 			2011-06-07
Last Modified: 		2011-06-07
*/

@ChapterId int
-- WITH ENCRYPTION
AS


SELECT
		*
FROM
		[dbo].[Questions]
		
WHERE
		[ChapterId] = @ChapterId
		and Deleted = 'true' AND validated =1
ORDER BY [Id]
GO
/****** Object:  StoredProcedure [dbo].[ListQuestionDeleted_SelectBy_ChapterId_ParentId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ListQuestionDeleted_SelectBy_ChapterId_ParentId]

/*
Author:   			Nguyen Dinh Anh
Created: 			2011-06-07
Last Modified: 		2011-06-07
*/

@ChapterId int,
@ParentId int
-- WITH ENCRYPTION
AS


SELECT
		*
FROM
		[dbo].[Questions]
		
WHERE
		([ChapterId] = @ChapterId
		or [ParentId] = @ParentId)
		and Deleted = 'true'
ORDER BY [Id]






GO
/****** Object:  StoredProcedure [dbo].[Login]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Login]
	@Username NVARCHAR(50),
	@Password NVARCHAR(128)
AS
	SELECT *  FROM Users
	WHERE @Username = Username
	AND @Password = Password





GO
/****** Object:  StoredProcedure [dbo].[Matrices_SelectMax]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Matrices_SelectMax]

@Matrices int
/*
Author:   			Hoang Van Hieu
Created: 			2017-05-05
Last Modified: 		2017-05-05
*/
AS

DECLARE @Max int

SELECT
		@Max = MAX([Id])
FROM
		[dbo].[Matrices]

IF(@Max IS NULL) SELECT 0
ELSE SELECT @Max





GO
/****** Object:  StoredProcedure [dbo].[MatricesInsert]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Matrices table
CREATE PROC [dbo].[MatricesInsert]
	@SubjectId INT,
	@CreateDate DATETIME,
	@Name NVARCHAR(100)
AS
BEGIN
	INSERT INTO dbo.Matrices
	        ( SubjectId, CreateDate, Name )
	VALUES  ( @SubjectId, -- SubjectId - int
	          @CreateDate, -- CreateDate - datetime
	          @Name  -- Name - nvarchar(100)
	          )
END






GO
/****** Object:  StoredProcedure [dbo].[MatricesSelectAll]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[MatricesSelectAll]
	@Id BIGINT
AS
BEGIN
	SELECT * FROM dbo.Matrices
END





GO
/****** Object:  StoredProcedure [dbo].[MatricesSelectById]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MatricesSelectById]
	@Id BIGINT
AS
BEGIN
	SELECT * FROM dbo.Matrices WHERE Id = @Id
END






GO
/****** Object:  StoredProcedure [dbo].[MatricesUpdate]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MatricesUpdate]
	@Id BIGINT,
	@SubjectId INT,
	@CreateDate DATETIME,
	@Name NVARCHAR(100)
AS
BEGIN
	UPDATE dbo.Matrices
	SET SubjectId = @SubjectId, CreateDate = CreateDate, [Name] = @Name
	WHERE Id = @Id
END






GO
/****** Object:  StoredProcedure [dbo].[MatrixDetailInsert]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- MatrixDetail
CREATE PROC [dbo].[MatrixDetailInsert]
	@MatrixId BIGINT,
	@ChapterId INT,
	@Quantity INT,
	@Excluded NVARCHAR(1000)
AS
BEGIN
	INSERT INTO dbo.MatrixDetails
	        ( MatrixId ,
	          ChapterId ,
	          Quantity ,
	          Excluded
	        )
	VALUES  ( @MatrixId , -- MatrixId - bigint
	          @ChapterId , -- ChapterId - int
	          @Quantity , -- Quantity - int
	          @Excluded  -- Excluded - nvarchar(1000)
	        )
END






GO
/****** Object:  StoredProcedure [dbo].[MatrixDetailSelectById]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MatrixDetailSelectById]
	@Id INT
AS
BEGIN
	SELECT * FROM dbo.MatrixDetails WHERE Id = @Id
END






GO
/****** Object:  StoredProcedure [dbo].[MatrixDetailUpdate]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MatrixDetailUpdate]
	@Id INT,
	@MatrixId BIGINT,
	@ChapterId INT,
	@Quantity INT,
	@Excluded NVARCHAR(1000)
AS
BEGIN
	UPDATE dbo.MatrixDetails
	SET MatrixId = @MatrixId, ChapterId = @ChapterId, Quantity = @Quantity, Excluded = @Excluded
	WHERE Id = @Id
END






GO
/****** Object:  StoredProcedure [dbo].[PaperQuestionSheetDetailsInsert]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PaperQuestionSheetDetailsInsert]
@PaperQuestionSheetId int,
@QuestionId int,
@Order int
AS
	INSERT INTO [dbo].[PaperQuestionSheetDetails]
			   ([PaperQuestionSheetId]
			   ,[QuestionId]
			   ,[Order])
		 VALUES
			   (@PaperQuestionSheetId,
			   @QuestionId,
			   @Order)






GO
/****** Object:  StoredProcedure [dbo].[PaperQuestionSheetDetailsSelectByQuestionSheetId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PaperQuestionSheetDetailsSelectByQuestionSheetId]
@QuestionSheetId int
AS
	select PaperQuestionSheetId, QuestionId from PaperQuestionSheetDetails where PaperQuestionSheetId =@QuestionSheetId
	ORDER BY [Order]






GO
/****** Object:  StoredProcedure [dbo].[PaperQuestionSheetsInsert]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[PaperQuestionSheetsInsert]
@Name		nvarchar(100),
@Total int,
@ObjectiveDifficulty decimal(18,10),
@CreateDate datetime,
@ExportDate dateTime,
@TestDate	datetime,
@Duration	int,
@Exported	bit,
@PaperShiftSubjectId int
AS 

INSERT INTO [dbo].[PaperQuestionSheets]
           ([Name]
           ,[CreateDate]
           ,[ExportDate]
           ,[TestDate]
           ,[Duration]
           ,[Exported]
           ,[PaperShiftSubjectId]
		   ,[ObjectiveDifficulty]
		   ,[Total])
     VALUES
           (@Name,
     		@CreateDate, 
			@ExportDate, 
			@TestDate,	
			@Duration,	
			@Exported,	
			@PaperShiftSubjectId,
			@ObjectiveDifficulty,
			@Total)





GO
/****** Object:  StoredProcedure [dbo].[Question_Delete]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Question_Delete]

@Id bigint
-- WITH ENCRYPTION
AS

update Questions set Deleted = 'true', Validated =0 where Id = @Id Or ParentId = @Id

GO
/****** Object:  StoredProcedure [dbo].[Question_Delete_Temporary]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Question_Delete_Temporary]

@Id bigint
-- WITH ENCRYPTION
AS

update Questions set Deleted = 'true' where Id = @Id Or ParentId = @Id



















GO
/****** Object:  StoredProcedure [dbo].[Question_Restore]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Question_Restore]

/*
Author:   			Pham Phu Thanh Sang
Created: 			2010-11-13
Last Modified: 		2010-11-13
*/
	
@Id bigint

-- WITH ENCRYPTION
AS

UPDATE 		[dbo].[Question] 

SET
		Deleted = 'False'
			
WHERE
		[Id] = @Id
		and Deleted = 'True'




GO
/****** Object:  StoredProcedure [dbo].[Question_SelectBy_ChapterId_ParentId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Question_SelectBy_ChapterId_ParentId]

/*
Author:   			Hoang Van Hieu
Created: 			2017-05-30
Last Modified: 		2017-05-30
*/

@ChapterId int,
@ParentId bigint
-- WITH ENCRYPTION
AS


SELECT
		Id, Content,ParentId,ManagementOrder
FROM
		[dbo].[Questions]
		
WHERE
		[ChapterId] = @ChapterId
		and [ParentId] = @ParentId
		and Deleted = 'False'
ORDER BY [Id]


GO
/****** Object:  StoredProcedure [dbo].[Question_SelectBy_Date]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Question_SelectBy_Date]
@StartDate varchar(100),
@EndDate varchar(100)
-- WITH ENCRYPTION
AS
SELECT *
FROM Questions
WHERE CreateDate BETWEEN @StartDate AND @EndDate AND Deleted =0
GO
/****** Object:  StoredProcedure [dbo].[Question_SelectBy_SubjectId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Question_SelectBy_SubjectId]

/*
Author:   			Hoang Van Hieu
Created: 			2017-05-28
Last Modified: 		2011-05-30
*/

@SubjectId int
-- WITH ENCRYPTION
AS


SELECT
		DISTINCT CH.*
FROM
		[dbo].[Questions] CH
		JOIN [dbo].[Chapters] P ON P.Id = CH.ChapterId		
WHERE
		P.SubjectId = @SubjectId
ORDER BY CH.Id






GO
/****** Object:  StoredProcedure [dbo].[Question_SelectSoCauHoiCon]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[Question_SelectSoCauHoiCon]

/*
Author:   			Le Xuan Manh
Created: 			2010-12-10
Last Modified: 		2010-12-10
*/

@Id bigint
-- WITH ENCRYPTION
AS

SELECT
	
		count(ParentId) as sl
FROM
		[dbo].[Questions]
		
WHERE
		[ParentId] = @Id





GO
/****** Object:  StoredProcedure [dbo].[QuestionDeletedByParentId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[QuestionDeletedByParentId]
@ParentId int
as
select * from Questions 
where ParentId = @ParentId and Id != @ParentId And Deleted ='true' AND validated =1
Order By Id


GO
/****** Object:  StoredProcedure [dbo].[QuestionIdList_SelectBy_FacultyId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[QuestionIdList_SelectBy_FacultyId]
@FacultyId int
AS
SELECT
		DISTINCT CH.*
FROM
		[dbo].[Questions] CH
		JOIN [dbo].[Chapters] P ON P.Id = CH.ChapterId
		JOIN [dbo].[Subjects] S ON S.Id = P.SubjectId	
WHERE
		S.FacultyId = @FacultyId
ORDER BY Id






GO
/****** Object:  StoredProcedure [dbo].[QuestionIdList_SelectBy_SubjectId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[QuestionIdList_SelectBy_SubjectId]

/*
Author:   			Hoang Van Hieu
Created: 			2017-05-28
Last Modified: 		2011-05-30
*/

@SubjectId int
-- WITH ENCRYPTION
AS


SELECT
		DISTINCT CH.Id
FROM
		[dbo].[Questions] CH
		JOIN [dbo].[Chapters] P ON P.Id = CH.ChapterId	
WHERE
		P.SubjectId = @SubjectId
ORDER BY CH.Id






GO
/****** Object:  StoredProcedure [dbo].[Questions_COUNT]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Questions_COUNT]
@ChapterId int
AS
SELECT COUNT(Id) AS QuestionQuantity
  FROM [dbo].[Questions]
  where [ChapterId] = @ChapterId
		and Deleted = 'False'

GO
/****** Object:  StoredProcedure [dbo].[Questions_Delete_SelectBy_ParentId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Questions_Delete_SelectBy_ParentId]

/*
Author:   			Nguyen Dinh Anh
Created: 			2011-06-20
Last Modified: 		2011-06-20
*/

@ParentId bigint
-- WITH ENCRYPTION
AS


SELECT
		*
FROM
		[dbo].[Questions]
		
WHERE
		[ParentId] = @ParentId
		and Deleted = 'True' AND validated =1
ORDER BY Id

GO
/****** Object:  StoredProcedure [dbo].[Questions_FlagAsDeleted]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Questions_FlagAsDeleted]

/*
Author:   			Pham Phu Thanh Sang
Created: 			2010-11-13
Last Modified: 		2010-11-13
*/
	
@Id bigint

-- WITH ENCRYPTION
AS

UPDATE 		[dbo].[Questions] 

SET
		Deleted = 'True'
			
WHERE
		[Id] = @Id
		and Deleted = 'False'













GO
/****** Object:  StoredProcedure [dbo].[Questions_Insert]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Questions_Insert]
@Content nvarchar(max),
@Interchange bit,
@SubjectiveDifficulty decimal(18,10),
@SelectedTimes int,
@CorrectTimes int,
@Deleted bit,
@ChapterId int,
@CreateDate datetime,
@UpdateDate datetime,
@Mark decimal(18,10),
@Duration int,
@ParentId bigint,
@Discrimination decimal(18,10),
@SubjectId int,
@Audio bit
AS
BEGIN
	DECLARE @STT int
	SET @STT =(select  (isnull(count(ManagementOrder),0)+1) from Questions where SubjectId = @SubjectId)
	INSERT INTO 	Questions
	(
				Content,
				Interchange,
				SubjectiveDifficulty,
				ObjectiveDifficulty,
				SelectedTimes,
				CorrectTimes,
				Deleted,
				ChapterId,
				CreateDate,
				UpdateDate,
				Mark,
				Duration,
				ParentId,
				Discrimination,
				SubjectId,
				ManagementOrder,
				Audio
				
	) 
	VALUES 
	(
				@Content,
				@Interchange,
				@SubjectiveDifficulty,
				0.5,
				@SelectedTimes,
				@CorrectTimes,
				@Deleted,
				@ChapterId,
				@CreateDate,
				@UpdateDate,
				@Mark,
				@Duration,
				@ParentId,
				@Discrimination,
				@SubjectId,
				@STT,
				@Audio
	)

END




GO
/****** Object:  StoredProcedure [dbo].[Questions_Paging]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Questions_Paging]
	@PageNumber int
as
	select TOP(@PageNumber*2) * from Questions











GO
/****** Object:  StoredProcedure [dbo].[Questions_Restore]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Questions_Restore]

/*
Author:   			Pham Phu Thanh Sang
Created: 			2010-11-13
Last Modified: 		2010-11-13
*/
	
@Id bigint

-- WITH ENCRYPTION
AS

UPDATE 		[dbo].[Questions] 

SET
		Deleted = 'False'
			
WHERE
		[Id] = @Id
		and Deleted = 'True'













GO
/****** Object:  StoredProcedure [dbo].[Questions_Select_NumberOfChildQuestions]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Questions_Select_NumberOfChildQuestions]

/*
Author:   			Le Xuan Manh
Created: 			2010-12-10
Last Modified: 		2010-12-10
*/

@Id bigint
-- WITH ENCRYPTION
AS

SELECT
	
		count(ParentId) as sl
FROM
		[dbo].[Questions]
		
WHERE
		[ParentId] = (@Id)











GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectAll]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Questions_SelectAll]

/*
Author:   			Nguyen Dinh Anh
Created: 			2011-3-8
Last Modified: 		2011-3-8
*/
-- WITH ENCRYPTION
AS


SELECT          Content,
				Interchange,
				SubjectiveDifficulty,
				ObjectiveDifficulty,
				SelectedTimes,
				CorrectTimes,
				Deleted,
				ChapterId,
				CreateDate,
				UpdateDate,
				Mark,
				Duration,
				ParentId
		
FROM
		[dbo].[CauHoi]
















GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectAll_Deleted]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Questions_SelectAll_Deleted]

/*
Author:   			Nguyen Dinh Anh
Created: 			2011-3-8
Last Modified: 		2011-3-8
*/
-- WITH ENCRYPTION
AS


SELECT
		*
FROM
		[dbo].[Questions]
WHERE
		Deleted = 'True' And validated =1
ORDER BY [Id]

GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectAllId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Questions_SelectAllId]

/*
Author:   			Hoang Van Hieu
Created: 			2017-02-25
Last Modified: 		2017-02-25
*/
-- WITH ENCRYPTION
AS


SELECT          Id
		
FROM
		[dbo].[Questions]


GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_ChapterId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Questions_SelectBy_ChapterId]

/*
Author:   			Hoang Van Hieu
Created: 			2017-05-29
Last Modified: 		2017-05-29
*/

@ChapterId int
-- WITH ENCRYPTION
AS


SELECT
		Id, Content,ParentId,ManagementOrder, ObjectiveDifficulty
FROM
		[dbo].[Questions]
		
WHERE
		[ChapterId] = @ChapterId
		and Deleted = 'False' 
ORDER BY [Id]
GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_ChapterId_Paging]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Questions_SelectBy_ChapterId_Paging]

@ChapterId int,
@PageNumber INT,   
@PageSize INT  
-- WITH ENCRYPTION
AS
 DECLARE @Start INT, @End INT  
 BEGIN TRANSACTION GetDataSet   
 SET @Start = (((@PageNumber - 1) * @PageSize) + 1)   

 SET @End = (@Start + @PageSize - 1)   
 
 CREATE TABLE #TemporaryTable (   
  Row INT IDENTITY(1,1) PRIMARY KEY,   
	[Id] [bigint],
	[Content] [nvarchar](max) NULL,
	[Interchange] [bit] NULL,
	[SubjectiveDifficulty] [decimal](18, 10) NULL,
	[ObjectiveDifficulty] [decimal](18, 10) NULL,
	[SelectedTimes] [int] NULL,
	[CorrectTimes] [int] NULL,
	[Deleted] [bit] NULL,
	[ChapterId] [int] NOT NULL,
	[CreateDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[Mark] [decimal](18, 10) NULL,
	[Duration] [int] NULL,
	[ParentId] [bigint] NULL,
	[Discrimination] [int] NULL,
	[ManagementOrder] [int] NULL
 )   
 INSERT INTO #TemporaryTable   
  SELECT Id,Content,Interchange,SubjectiveDifficulty,SelectedTimes,SelectedTimes,CorrectTimes,Deleted,ChapterId,CreateDate,UpdateDate,
  Mark,Duration,ParentId,Discrimination,ManagementOrder FROM [Questions]  where ChapterId =@ChapterId
   
 SELECT    Id,Content,Interchange,SubjectiveDifficulty,SelectedTimes,SelectedTimes,CorrectTimes,Deleted,ChapterId,CreateDate,UpdateDate,
  Mark,Duration,ParentId,Discrimination,ManagementOrder
  FROM #TemporaryTable   
  WHERE (Row >= @Start) AND (Row <= @End) AND [ChapterId] = @ChapterId
		and Deleted = 'False'
	ORDER BY [Id]  
 DROP TABLE #TemporaryTable   
 COMMIT TRANSACTION GetDataSet   
 RETURN 0   
ErrorHandler:   
ROLLBACK TRANSACTION GetDataSet   
RETURN @@ERROR 












GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_ChapterId_Paging1]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Questions_SelectBy_ChapterId_Paging1]

@ChapterId int,
@PageNumber INT,   
@PageSize INT  
-- WITH ENCRYPTION
AS
 DECLARE @Start INT, @End INT  
 BEGIN TRANSACTION GetDataSet   
 SET @Start = (((@PageNumber - 1) * @PageSize) + 1)   

 SET @End = (@Start + @PageSize - 1)   
 
 CREATE TABLE #TemporaryTable (   
  Row INT IDENTITY(1,1) PRIMARY KEY,   
	[Id] [bigint],
	[Content] [nvarchar](max) NULL,
	[ParentId] [bigint] NULL,
	[ManagementOrder] [int] NULL
 )   
 INSERT INTO #TemporaryTable   
  SELECT Id,Content,ParentId,ManagementOrder FROM [Questions]  where ChapterId =@ChapterId AND Deleted =0
   
 SELECT    Id,Content,ParentId,ManagementOrder
  FROM #TemporaryTable   
  WHERE (Row >= @Start) AND (Row <= @End)
	ORDER BY [Id]  
 DROP TABLE #TemporaryTable   
 COMMIT TRANSACTION GetDataSet   
 RETURN 0   
ErrorHandler:   
ROLLBACK TRANSACTION GetDataSet   
RETURN @@ERROR 
GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_ChapterId_ParentId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Questions_SelectBy_ChapterId_ParentId]

/*
Author:   			Pham Phu Thanh Sang
Created: 			2010-11-13
Last Modified: 		2010-11-13
*/

@ChapterId int,
@ParentId bigint
-- WITH ENCRYPTION
AS


SELECT
		Id, Content,ParentId,ManagementOrder
FROM
		[dbo].[Questions]
		
WHERE
		[ChapterId] = @ChapterId
		and [ParentId] = @ParentId
		and Deleted = 'False'
ORDER BY [Id]
GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_Date]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Questions_SelectBy_Date]

/*
Author:   			Hoang Van Hieu
Created: 			2017-07-07
Last Modified: 		2017-07-07
*/

@StartTime varchar(100),
@EndTime varchar(100)
-- WITH ENCRYPTION
AS

SELECT CH.Id, CH.Content,CH.ParentId,CH.ManagementOrder
FROM [dbo].Questions CH
WHERE CH.CreateDate BETWEEN @StartTime AND @EndTime And Deleted = 0
GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_ParentId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Questions_SelectBy_ParentId]

/*
Author:   			Haong Van Hieu
Created: 			2017-05-27
Last Modified: 		2017-05-30
*/

@ParentId bigint
-- WITH ENCRYPTION
AS


SELECT
		Id, Content,ParentId,ManagementOrder
FROM
		[dbo].[Questions]
		
WHERE
		[ParentId] = @ParentId
		and Deleted = 'False' and ParentId != Id
ORDER BY Id
GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectBy_SubjectCode]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Questions_SelectBy_SubjectCode]

/*
Author:   			Nguyen Dinh Anh
Created: 			2011-03-25
Last Modified: 		2011-03-25
*/

@SubjectId int,
@SubjectCode int
-- WITH ENCRYPTION
AS


SELECT
		DISTINCT CH.Id, CH.Content,CH.ParentId,CH.ManagementOrder
FROM
		[dbo].[Questions] CH
		JOIN [dbo].[Chapters] P ON P.Id = CH.Id
WHERE
		P.SubjectId = @SubjectCode
ORDER BY Id













GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectMax_IdQuestions]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Questions_SelectMax_IdQuestions]

/*
Author:   			Hoang Van Hieu
Created: 			2017-05-05
Last Modified: 		2017-05-05
*/

@ChapterId int
-- WITH ENCRYPTION
AS

DECLARE @Max int

SELECT
		@Max = MAX([Id])
FROM
		[dbo].[Questions]
		
WHERE
		[ChapterId] = @ChapterId

IF(@Max IS NULL) SELECT 0
ELSE SELECT @Max







GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectOne]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[Questions_SelectOne]

/*
Author:   			Nguyen Dinh Anh
Created: 			2011-3-8
Last Modified: 		2011-3-8
*/

@Id bigint
-- WITH ENCRYPTION
AS


SELECT
				Id,
				Content,
				Interchange,
				SubjectiveDifficulty,
				ObjectiveDifficulty,
				SelectedTimes,
				CorrectTimes,
				Deleted,
				ChapterId,
				CreateDate,
				UpdateDate,
				Mark,
				Duration,
				ParentId,
				ManagementOrder,
				Discrimination,
				Audio
		
FROM
		[dbo].[Questions]
		
WHERE
		[Id] = @Id
















GO
/****** Object:  StoredProcedure [dbo].[Questions_SelectPage]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Questions_SelectPage]

-- Author:   			Nguyen Dinh Anh
-- Created: 			2011-3-8
-- Last Modified: 		2011-3-8

@PageNumber 			int,
@PageSize 			int
-- WITH ENCRYPTION
AS

DECLARE @PageLowerBound int
DECLARE @PageUpperBound int


SET @PageLowerBound = (@PageSize * @PageNumber) - @PageSize
SET @PageUpperBound = @PageLowerBound + @PageSize + 1

/*
Note: temp tables use the server default for collation not the database default
so if adding character columns be sure and specify to use the database collation like this
to avoid collation errors:

CREATE TABLE #PageIndexForUsers
(
IndexID int IDENTITY (1, 1) NOT NULL,
UserName nvarchar(50) COLLATE DATABASE_DEFAULT,
LoginName nvarchar(50) COLLATE DATABASE_DEFAULT
) 


*/

CREATE TABLE #PageIndex 
(
	IndexID int IDENTITY (1, 1) NOT NULL,
Id bigint
)

BEGIN

INSERT INTO #PageIndex ( 
Id
)

SELECT
		[Id]
		
FROM
		[dbo].[Questions]
		
-- WHERE

-- ORDER BY

END


SELECT
		t1.*
		
FROM
		[dbo].[Questions] t1

JOIN			#PageIndex t2
ON			
		t1.[Id] = t2.[Id]
		
WHERE
		t2.IndexID > @PageLowerBound 
		AND t2.IndexID < @PageUpperBound
		
ORDER BY t2.IndexID

DROP TABLE #PageIndex













GO
/****** Object:  StoredProcedure [dbo].[Questions_Update]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[Questions_Update]

/*
Author:   			Nguyen Dinh Anh
Created: 			2011-3-8
Last Modified: 		2011-3-8
*/
@Id bigint, 
@Content nvarchar(max),
@Interchange bit,
@SubjectiveDifficulty decimal(18,10),
@SelectedTimes int,
@CorrectTimes int,
@Deleted bit,
@ChapterId int,
@CreateDate datetime,
@UpdateDate datetime,
@Mark decimal(18,10),
@Duration int,
@ParentId bigint,
@Discrimination decimal(18,10),
@Audio bit
-- WITH ENCRYPTION
AS

UPDATE 		[dbo].[Questions] 

SET
			[ChapterId] = @ChapterId,
			[Content] = @Content,
			[Interchange] = @Interchange,
			[Mark] = @Mark,
			[SubjectiveDifficulty] = @SubjectiveDifficulty,
			[ObjectiveDifficulty] = @SubjectiveDifficulty,
			[ParentId] = @ParentId,
			[Deleted] = @Deleted,
			[SelectedTimes] = @SelectedTimes,
			[CorrectTimes] = @CorrectTimes,
			[CreateDate] = @CreateDate,
			[UpdateDate] = @UpdateDate,
			[Duration] = @Duration,
			[Discrimination] = @Discrimination,
			[Audio] = @Audio
			
WHERE
			[Id] = @Id





GO
/****** Object:  StoredProcedure [dbo].[Questions_UpdateParentId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Questions_UpdateParentId]

/*
Author:   			Hoang Van Hieu	
Created: 			2017-05-28
Last Modified: 		2017-05-30
*/
	
@Id bigint, 
@ParentId bigint
-- WITH ENCRYPTION
AS

UPDATE 		[dbo].[Questions] 

SET
			[ParentId] = @ParentId
WHERE
			[Id] = @Id






GO
/****** Object:  StoredProcedure [dbo].[Questions_Validation]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Questions_Validation]
@StartDate varchar(100),
@EndDate varchar(100)
-- WITH ENCRYPTION
AS

--nhỏ hơn hoặc bằng 2 câu trả lời
SELECT CH.Id, CH.Content,CH.ParentId,CH.ManagementOrder 
FROM Questions CH JOIN Answers CTL ON CTL.QuestionId = CH.Id
WHERE CH.Id !=CH.ParentId AND CH.CreateDate BETWEEN @StartDate AND @EndDate AND validated =1
GROUP BY CH.Id, CH.ChapterId, CH.Content, CH.Interchange, CH.Mark,
		CH.SubjectiveDifficulty, CH.ObjectiveDifficulty, CH.ParentId, CH.Deleted,CH.Duration,
			CH.SelectedTimes, CH.CorrectTimes, CH.CreateDate, CH.UpdateDate, CH.Discrimination, CH.ManagementOrder,SubjectId,Audio,ListenedTimes,CH.validated
HAVING COUNT(CTL.Id)<=2

--không có đáp án
UNION

SELECT CH.Id, CH.Content,CH.ParentId,CH.ManagementOrder FROM Questions CH
WHERE CH.Id NOT IN(
	SELECT CH.Id
	FROM Questions CH JOIN Answers CTL ON CTL.QuestionId = CH.Id
	WHERE CTL.Correct = 'True'
	GROUP BY CH.Id
	HAVING COUNT(CTL.Correct) = 1
)

AND CH.Id != CH.ParentId AND CH.CreateDate BETWEEN @StartDate AND @EndDate

GO
/****** Object:  StoredProcedure [dbo].[QuestionsDeleted_SelectBy_ChapterId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[QuestionsDeleted_SelectBy_ChapterId]

/*
Author:   			Hoang Van Hieu
Created: 			2017-05-29
Last Modified: 		2017-05-29
*/

@ChapterId int
-- WITH ENCRYPTION
AS


SELECT
		*
FROM
		[dbo].[Questions]
		
WHERE
		[ChapterId] = @ChapterId
		and Deleted = 'true' and ParentId =0 OR [ChapterId] = @ChapterId
		and Deleted = 'true' and ParentId = Id
ORDER BY [Id]






GO
/****** Object:  StoredProcedure [dbo].[QuestionsDeleted_SelectBy_ParentId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[QuestionsDeleted_SelectBy_ParentId]

/*
Author:   			Haong Van Hieu
Created: 			2017-05-27
Last Modified: 		2017-05-30
*/

@ParentId bigint
-- WITH ENCRYPTION
AS


SELECT
		*
FROM
		[dbo].[Questions]
		
WHERE
		[ParentId] = @ParentId
		and Deleted = 'true' and ParentId != Id
ORDER BY Id





GO
/****** Object:  StoredProcedure [dbo].[QuestionSheetDetailCreate]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- QuestionSheetDetail
CREATE PROC [dbo].[QuestionSheetDetailCreate]
    @QuestionSheetId BIGINT ,
    @QuestionId BIGINT ,
    @Order INT
AS
    BEGIN
        INSERT  INTO dbo.QuestionSheetDetails
                ( QuestionSheetId ,
                  QuestionId ,
                  [Order]
                )
        VALUES  ( @QuestionSheetId , -- QuestionSheetId - bigint
                  @QuestionId , -- QuestionId - bigint
                  @Order
                );
    END;






GO
/****** Object:  StoredProcedure [dbo].[QuestionSheetDetailSelectById]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[QuestionSheetDetailSelectById]
    @QuestionSheetId BIGINT ,
    @QuestionId BIGINT
AS
    BEGIN
        SELECT * FROM dbo.QuestionSheetDetails WHERE QuestionSheetId = @QuestionSheetId AND QuestionId = @QuestionId
    END;






GO
/****** Object:  StoredProcedure [dbo].[QuestionSheetDetailUpdate]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[QuestionSheetDetailUpdate]
    @QuestionSheetId BIGINT ,
    @QuestionId BIGINT ,
    @Order INT ,
    @AnswerId INT ,
    @Correct BIT ,
    @CreateDate DATETIME ,
    @UpdateDate DATETIME ,
    @ListenTimes INT
AS
    BEGIN
        UPDATE dbo.QuestionSheetDetails
		SET [Order] = @Order, AnswerId = @AnswerId, CreateDate = @CreateDate,
			UpdateDate = @UpdateDate, ListenTimes = @ListenTimes
        WHERE QuestionSheetId = @QuestionSheetId AND QuestionId = @QuestionId
    END;






GO
/****** Object:  StoredProcedure [dbo].[QuestionSheetGetAll]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[QuestionSheetGetAll]
as
Select * from QuestionSheets
order by Id Desc





GO
/****** Object:  StoredProcedure [dbo].[QuestionSheetID_SelectMax]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[QuestionSheetID_SelectMax]

/*
Author:   			Hoang Van Hieu
Created: 			2017-05-05
Last Modified: 		2017-05-05
*/

-- WITH ENCRYPTION
AS

DECLARE @Max int

SELECT
		@Max = MAX(Id)
FROM
		[dbo].[PaperQuestionSheets]

IF(@Max IS NULL) SELECT 0
ELSE SELECT @Max





GO
/****** Object:  StoredProcedure [dbo].[QuestionSheetInsert]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[QuestionSheetInsert]
    @Name NVARCHAR(100) ,
    @CreateDate DATETIME ,
    @Approved BIT ,
    @Started BIT ,
    @Completed BIT ,
    @ExtraTime INT ,
    @ExtraTimeReason NVARCHAR(100) ,
    @Mark DECIMAL ,
    @ShiftSubjectStudentId BIGINT ,
    @NumberOfCorrect INT ,
    @Total INT ,
    @Difficulty DECIMAL,
	@UserId INT
AS
    BEGIN
        INSERT  INTO dbo.QuestionSheets
                ( Name ,
                  CreateDate ,
                  Approved ,
                  [Started] ,
                  Completed ,
                  ExtraTime ,
                  ExtraTimeReason ,
                  Mark ,
                  NumberOfCorrect ,
                  Total ,
                  Difficulty ,
                  UserId
	            )
        VALUES  ( @Name , -- Name - nvarchar(100)
                  @CreateDate , -- CreateDate - datetime
                  @Approved , -- Approved - bit
                  @Started , -- Started - bit
                  @Completed , -- Completed - bit
                  @ExtraTime , -- ExtraTime - int
                  @ExtraTimeReason , -- ExtraTimeReason - nvarchar(100)
                  @Mark , -- Mark - decimal
                  @NumberOfCorrect , -- NumberOfCorrect - int
                  @Total , -- Total - int
                  @Difficulty, -- Difficulty - decimal
				  @UserId
	            );
    END;


GO
/****** Object:  StoredProcedure [dbo].[QuestionSheetSelectById]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[QuestionSheetSelectById]
	@Id BIGINT
AS
    BEGIN
        SELECT * FROM dbo.QuestionSheets WHERE Id = @Id
    END;






GO
/****** Object:  StoredProcedure [dbo].[QuestionSheetUpdate]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[QuestionSheetUpdate]
	@Id BIGINT,
    @Name NVARCHAR(100) ,
    @CreateDate DATETIME ,
    @Approved BIT ,
    @Started BIT ,
    @Completed BIT ,
    @ExtraTime INT ,
    @ExtraTimeReason NVARCHAR(100) ,
    @Mark DECIMAL ,
    @ShiftSubjectStudentId BIGINT ,
    @NumberOfCorrect INT ,
    @Total INT ,
    @Difficulty DECIMAL
AS
    BEGIN
        UPDATE dbo.QuestionSheets
		SET [Name] = @Name, CreateDate = @CreateDate, Approved = @Approved,
			[Started] = @Started, Completed = @Completed, ExtraTime = @ExtraTime,
			ExtraTimeReason = @ExtraTimeReason, Mark = @Mark,
			NumberOfCorrect = @NumberOfCorrect, Total = @Total, Difficulty = @Difficulty
        WHERE Id = @Id
    END;


GO
/****** Object:  StoredProcedure [dbo].[RestoreQuestionDeleted]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[RestoreQuestionDeleted]

@Id bigint
-- WITH ENCRYPTION
AS
BEGIN
	update Questions set Deleted = 'false' where [Id] = @Id AND Validated = 1;
	Declare  @SubjectId int;
	SET @SubjectId = (SELECT SubjectId from Questions where Id = @Id) ;
	Declare @Faculty int;
	SET @Faculty = (select FacultyId from Subjects where Id = @SubjectId);
	UPDATE Subjects set Deleted = 'false' Where Id = @SubjectId;
	UPDATE Faculties Set Deleted = 'false' WHERE Id = @Faculty;
END
GO
/****** Object:  StoredProcedure [dbo].[SeachQuestion]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SeachQuestion]
@SubjectId int,
@ChapterId int
AS
BEGIN
	IF(@ChapterId = 0)
		SELECT Id, Content,ParentId,ManagementOrder FROM Questions where SubjectId =@SubjectId And Deleted = 0
	ELSE	
		Select Id, Content,ParentId,ManagementOrder from Questions where ChapterId = @ChapterId And Deleted = 0
END
GO
/****** Object:  StoredProcedure [dbo].[SeachQuestionByDate]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SeachQuestionByDate]
@StartTime varchar(100),
@EndTime varchar(100),
@SubjectId int,
@ChapterId int
AS
	BEGIN
		IF(@StartTime =@EndTime)
			BEGIN
				IF(@ChapterId is not null)
					Select Id, Content,ParentId,ManagementOrder from Questions where CreateDate = @StartTime AND ChapterId = @ChapterId And Deleted = 0
				ELSE
					Select Id, Content,ParentId,ManagementOrder from Questions Where CreateDate = @StartTime And SubjectId = @SubjectId And Deleted =0
			END
		ELSE
			BEGIN
				IF(@ChapterId !=0)
					Select Id, Content,ParentId,ManagementOrder from Questions where (CreateDate BETWEEN @StartTime AND @EndTime) AND ChapterId = @ChapterId  And Deleted = 0
				ELSE
					Select Id, Content,ParentId,ManagementOrder from Questions where (CreateDate BETWEEN @StartTime AND @EndTime) AND SubjectId = @SubjectId And Deleted = 0
			END
	END
GO
/****** Object:  StoredProcedure [dbo].[Shift_SelectByName]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Shift_SelectByName]

@Name nvarchar(100)

AS


SELECT
		*
		
FROM
		[dbo].[Shifts] Where [Name] =@Name


GO
/****** Object:  StoredProcedure [dbo].[ShiftDelete]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ShiftDelete]
@shiftId int
AS
	UPDATE Shifts SET Deleted = 1
	WHERE Id =@shiftId
GO
/****** Object:  StoredProcedure [dbo].[ShiftInsert]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Shift
CREATE PROC [dbo].[ShiftInsert]
    @Name NVARCHAR(50) ,
    @StartTime DATETIME ,
    @EndTime DATETIME ,
    @Activated BIT ,
    @ActivateTime DATETIME ,
    @Duration INT ,
    @Ended BIT ,
    @EndDate DATETIME ,
    @ExamId INT ,
    @QuestionSheetCreated BIT ,
    @Deleted BIT
AS
    BEGIN

        INSERT  INTO dbo.Shifts
                ( [Name] ,
                  StartTime ,
                  EndTime ,
                  Activated ,
                  ActivateTime ,
                  Duration ,
                  Ended ,
                  EndDate ,
                  ExamId ,
                  QuestionSheetCreated ,
                  Deleted
	            )
        VALUES  ( @Name , -- Name - nvarchar(50)
                  @StartTime , -- StartTime - datetime
                  @EndTime , -- EndTime - datetime
                  @Activated , -- Activated - bit
                  @ActivateTime , -- ActivateTime - datetime
                  @Duration , -- Duration - int
                  @Ended , -- Ended - bit
                  @EndTime , -- EndDate - datetime
                  @ExamId , -- ExamId - int
                  @QuestionSheetCreated , -- QuestionSheetCreated - bit
                  @Deleted  -- Deleted - bit
	            );
    END;






GO
/****** Object:  StoredProcedure [dbo].[ShiftSelectByExamId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ShiftSelectByExamId]
	@ExamId INT
AS
    BEGIN

        SELECT * FROM dbo.Shifts
		WHERE ExamId = @ExamId And Deleted = 0
		order by Id DESC
    END;


GO
/****** Object:  StoredProcedure [dbo].[ShiftSelectById]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ShiftSelectById]
	@Id INT
AS
    BEGIN

        SELECT * FROM dbo.Shifts
		WHERE Id = @Id
    END;







GO
/****** Object:  StoredProcedure [dbo].[ShiftSubjectDelete]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ShiftSubjectDelete]
@shiftSubjectId int
AS
	UPDATE PaperShiftSubjects SET Deleted = 1
	WHERE Id =@shiftSubjectId
GO
/****** Object:  StoredProcedure [dbo].[ShiftSubjectInsert]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ShiftSubjects
CREATE PROC [dbo].[ShiftSubjectInsert]
	@ShiftId  int,
	@SubjectId  int,
	@MatrixId  bigint
AS
    BEGIN

		DECLARE @ROW int;
		SEt @ROW = (SELECT Id FROM dbo.PaperShiftSubjects WHERE ShiftId =@ShiftId AND SubjectId = @SubjectId)
		IF(@ROW is NULL)
			BEGIN
				INSERT INTO dbo.PaperShiftSubjects 
					( ShiftId, SubjectId, MatrixId )
				VALUES  ( @ShiftId, -- ShiftId - int
					  @SubjectId, -- SubjectId - int
					  @MatrixId  -- MatrixId - bigint
					  )
			END
		ELSE
			BEGIN
				UPDATE PaperShiftSubjects SET MatrixId = @MatrixId WHERE ShiftId =@ShiftId AND SubjectId = @SubjectId
				SELECT 1;
			END
    END;


	SELECT * FROM PaperShiftSubjects


	





GO
/****** Object:  StoredProcedure [dbo].[ShiftSubjectSelectById]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ShiftSubjectSelectById] @Id BIGINT
AS
    BEGIN

        SELECT  *
        FROM    dbo.ShiftSubjects
        WHERE   Id = @Id;
    END;






GO
/****** Object:  StoredProcedure [dbo].[ShiftSubjectSelectByShiftId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ShiftSubjectSelectByShiftId] 
@ShiftId BIGINT
AS
    BEGIN

        SELECT  *
        FROM    dbo.ShiftSubjects
        WHERE   ShiftId = @ShiftId;
    END;






GO
/****** Object:  StoredProcedure [dbo].[ShiftSubjectStudentInsert]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ShiftSubjectStudents
CREATE PROC [dbo].[ShiftSubjectStudentInsert]
    @ShiftSubjectId BIGINT ,
    @StudentId INT ,
    @QuestionSheetId BIGINT ,
    @LogIn BIT ,
    @LastLogIn BIT ,
    @LastLogOut BIT
AS
    BEGIN

        INSERT  INTO dbo.ShiftSubjectStudents
                ( ShiftSubjectId ,
                  StudentId ,
                  QuestionSheetId ,
                  LogIn ,
                  LastLogIn ,
                  LastLogOut
                )
        VALUES  ( @ShiftSubjectId , -- ShiftSubjectId - bigint
                  @StudentId , -- StudentId - int
                  @QuestionSheetId , -- QuestionSheetId - bigint
                  @LogIn , -- LogIn - bit
                  @LastLogIn , -- LastLogIn - bit
                  @LastLogOut  -- LastLogOut - bit
                );
    END;






GO
/****** Object:  StoredProcedure [dbo].[ShiftSubjectStudentSelectById]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ShiftSubjectStudentSelectById]
    @ShiftSubjectId BIGINT ,
    @StudentId INT
AS
    BEGIN

        SELECT * FROM dbo.ShiftSubjectStudents
        WHERE ShiftSubjectId = @ShiftSubjectId AND StudentId = @StudentId
    END;	






GO
/****** Object:  StoredProcedure [dbo].[ShiftSubjectStudentUpdate]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ShiftSubjectStudentUpdate]
    @ShiftSubjectId BIGINT ,
    @StudentId INT ,
    @QuestionSheetId BIGINT ,
    @LogIn BIT ,
    @LastLogIn BIT ,
    @LastLogOut BIT
AS
    BEGIN

        UPDATE dbo.ShiftSubjectStudents
		SET [LogIn] = @LogIn, LastLogIn = @LastLogIn, LastLogOut = @LastLogOut, QuestionSheetId = @QuestionSheetId
        WHERE ShiftSubjectId = @ShiftSubjectId AND StudentId = @StudentId
    END;






GO
/****** Object:  StoredProcedure [dbo].[ShiftSubjectUpdate]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ShiftSubjects
CREATE PROC [dbo].[ShiftSubjectUpdate]
	@Id int,
	@ShiftId  int,
	@SubjectId  int,
	@MatrixId  bigint
AS
    BEGIN
	UPDATE ShiftSubjects SET ShiftId = @ShiftId, SubjectId = @SubjectId, MatrixId = @MatrixId
			WHERE Id = @Id
    END;






GO
/****** Object:  StoredProcedure [dbo].[ShiftUpdate]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ShiftUpdate]
	@Id INT,
    @Name NVARCHAR(50) ,
    @StartTime DATETIME ,
    @EndTime DATETIME ,
    @Activated BIT ,
    @ActivateTime DATETIME ,
    @Duration INT ,
    @Ended BIT ,
    @EndDate DATETIME ,
    @ExamId INT ,
    @QuestionSheetCreated BIT ,
    @Deleted BIT
AS
    BEGIN

        UPDATE dbo.Shifts
		SET [Name] = @Name, StartTime = @StartTime, EndTime=@EndTime, Activated = @Activated, ActivateTime = @ActivateTime, Duration = @Duration, Ended = @Ended, EndDate = @EndDate, ExamId = @ExamId, QuestionSheetCreated = @QuestionSheetCreated, Deleted = @Deleted
        WHERE Id =@Id
    END;






GO
/****** Object:  StoredProcedure [dbo].[SoCauHoiChuaDuocThiTheoMaPhan]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[SoCauHoiChuaDuocThiTheoMaPhan]

@ChapterId int
as
SELECT
		*
FROM
		[dbo].[Questions]
		
WHERE
		[ChapterId] = @ChapterId
		and Deleted ='False' and SelectedTimes =0
ORDER BY [Id]




GO
/****** Object:  StoredProcedure [dbo].[SoCauHoiDuocThiTheoMaPhan]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[SoCauHoiDuocThiTheoMaPhan]

@ChapterId int
as
SELECT
		*
FROM
		[dbo].[Questions]
		
WHERE
		[ChapterId] = @ChapterId
		and Deleted ='False' and SelectedTimes >999
ORDER BY [Id]




GO
/****** Object:  StoredProcedure [dbo].[SoLuongCauHoiDeTheoMaKhoa]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SoLuongCauHoiDeTheoMaKhoa]
@FacultyId int,
@ObjectiveDifficulty decimal(18,10)
AS
SELECT
		DISTINCT CH.Id
FROM
		[dbo].[Questions] CH
		JOIN [dbo].[Chapters] P ON P.Id = CH.ChapterId
		JOIN [dbo].[Subjects] S ON S.Id = P.SubjectId
WHERE
		S.FacultyId = @FacultyId AND ObjectiveDifficulty > @ObjectiveDifficulty
ORDER BY Id



GO
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOIDETHEOMAMONHOC]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SOLUONGCAUHOIDETHEOMAMONHOC]
@SubjectId INT
AS
SELECT Id FROM Questions 
WHERE SubjectId = @SubjectId AND ObjectiveDifficulty > 0.799



GO
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOIDETHEOMAPHAN]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SOLUONGCAUHOIDETHEOMAPHAN]
@ChapterId INT
AS
SELECT Id FROM Questions 
WHERE ChapterId = @ChapterId AND ObjectiveDifficulty > 0.799



GO
/****** Object:  StoredProcedure [dbo].[SoLuongCauHoiKhoTheoMaKhoa]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SoLuongCauHoiKhoTheoMaKhoa]
@FacultyId int,
@ObjectiveDifficultyS decimal(18,10),
@ObjectiveDifficultyE decimal(18,10)
AS
SELECT
		DISTINCT CH.Id
FROM
		[dbo].[Questions] CH
		JOIN [dbo].[Chapters] P ON P.Id = CH.ChapterId
		JOIN [dbo].[Subjects] S ON S.Id = P.SubjectId
WHERE
		S.FacultyId = @FacultyId AND ObjectiveDifficulty >@ObjectiveDifficultyS AND ObjectiveDifficulty <@ObjectiveDifficultyE
ORDER BY Id



GO
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOIKHOTHEOMAMONHOC]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SOLUONGCAUHOIKHOTHEOMAMONHOC]
@SubjectId INT
AS
SELECT Id FROM Questions 
WHERE SubjectId = @SubjectId AND ObjectiveDifficulty >0.1999 AND ObjectiveDifficulty <0.4



GO
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOIKHOTHEOMAPHAN]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SOLUONGCAUHOIKHOTHEOMAPHAN]
@ChapterId INT
AS
SELECT Id FROM Questions 
WHERE ChapterId = @ChapterId AND ObjectiveDifficulty >0.1999 AND ObjectiveDifficulty <0.4



GO
/****** Object:  StoredProcedure [dbo].[SoLuongCauHoiRatKhoTheoMaKhoa]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SoLuongCauHoiRatKhoTheoMaKhoa]
@FacultyId int,
@ObjectiveDifficulty decimal(18,10)
AS
SELECT
		DISTINCT CH.Id
FROM
		[dbo].[Questions] CH
		JOIN [dbo].[Chapters] P ON P.Id = CH.ChapterId
		JOIN [dbo].[Subjects] S ON S.Id = P.SubjectId
WHERE
		S.FacultyId = @FacultyId AND ObjectiveDifficulty <@ObjectiveDifficulty
ORDER BY Id

GO
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOIRATKHOTHEOMAMONHOC]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SOLUONGCAUHOIRATKHOTHEOMAMONHOC]
@SubjectId INT
AS
SELECT Id FROM Questions 
WHERE SubjectId = @SubjectId AND ObjectiveDifficulty <0.2



GO
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOIRATKHOTHEOMAPHAN]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SOLUONGCAUHOIRATKHOTHEOMAPHAN]
@ChapterId INT
AS
SELECT Id FROM Questions 
WHERE ChapterId = @ChapterId AND ObjectiveDifficulty <0.2



GO
/****** Object:  StoredProcedure [dbo].[SoLuongCauHoiTrungBinhTheoMaKhoa]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SoLuongCauHoiTrungBinhTheoMaKhoa]
@FacultyId int,
@ObjectiveDifficultyS decimal(18,10),
@ObjectiveDifficultyE decimal(18,10)
AS
SELECT
		DISTINCT CH.Id
FROM
		[dbo].[Questions] CH
		JOIN [dbo].[Chapters] P ON P.Id = CH.ChapterId
		JOIN [dbo].[Subjects] S ON S.Id = P.SubjectId
WHERE
		S.FacultyId = @FacultyId AND ObjectiveDifficulty >@ObjectiveDifficultyS AND ObjectiveDifficulty <@ObjectiveDifficultyE
ORDER BY Id



GO
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOITRUNGBINHTHEOMAMONHOC]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SOLUONGCAUHOITRUNGBINHTHEOMAMONHOC]
@SubjectId INT
AS
SELECT Id FROM Questions 
WHERE SubjectId = @SubjectId AND ObjectiveDifficulty >0.599 AND ObjectiveDifficulty <0.8



GO
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOITRUNGBINHTHEOMAPHAN]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SOLUONGCAUHOITRUNGBINHTHEOMAPHAN]
@ChapterId INT
AS
SELECT Id FROM Questions 
WHERE ChapterId = @ChapterId AND ObjectiveDifficulty >0.599 AND ObjectiveDifficulty <0.8



GO
/****** Object:  StoredProcedure [dbo].[SoLuongCauHoiTuongDoiKhoTheoMaKhoa]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SoLuongCauHoiTuongDoiKhoTheoMaKhoa]
@FacultyId int,
@ObjectiveDifficultyS decimal(18,10),
@ObjectiveDifficultyE decimal(18,10)
AS
SELECT
		DISTINCT CH.Id
FROM
		[dbo].[Questions] CH
		JOIN [dbo].[Chapters] P ON P.Id = CH.ChapterId
		JOIN [dbo].[Subjects] S ON S.Id = P.SubjectId
WHERE
		S.FacultyId = @FacultyId AND ObjectiveDifficulty > @ObjectiveDifficultyS AND ObjectiveDifficulty <@ObjectiveDifficultyE
ORDER BY Id




GO
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOITUONGDOIKHOTHEOMAMONHOC]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SOLUONGCAUHOITUONGDOIKHOTHEOMAMONHOC]
@SubjectId INT
AS
SELECT Id FROM Questions 
WHERE SubjectId = @SubjectId AND ObjectiveDifficulty >0.399 AND ObjectiveDifficulty <0.6



GO
/****** Object:  StoredProcedure [dbo].[SOLUONGCAUHOITUONGDOIKHOTHEOMAPHAN]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SOLUONGCAUHOITUONGDOIKHOTHEOMAPHAN]
@ChapterId INT
AS
SELECT Id FROM Questions 
WHERE ChapterId = @ChapterId AND ObjectiveDifficulty >0.399 AND ObjectiveDifficulty <0.6



GO
/****** Object:  StoredProcedure [dbo].[Subject_Delete]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Subject_Delete]
@Id INT,
@FacultyId INT
AS
BEGIN
	BEGIN
		UPDATE Subjects SET Deleted ='true', Validated =0 where Id = @Id;
		UPDATE Chapters SET Deleted = 'true', Validated =0 WHERE SubjectId = @Id;
		UPDATE Questions SET Deleted = 'true', Validated =0 WHERE SubjectId =@Id;
	END	
	DECLARE @SoLuongCauHoi int;
	SET @SoLuongCauHoi = (SELECT COUNT(Id) FROM Questions
						WHERE Validated =1 AND SubjectId IN(SELECT Id FROM Subjects WHERE FacultyId = @FacultyId))
	IF(@SoLuongCauHoi =0)
		UPDATE Faculties SET Deleted = 1, Validated =0 WHERE Id =@FacultyId
END
GO
/****** Object:  StoredProcedure [dbo].[Subject_SelectBy_QuestionDelete]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Subject_SelectBy_QuestionDelete]

/*
Author:   			Hoang Van Hieu
Created: 			2017-06-01
Last Modified: 		2017-06-01
*/

@FaculyId bigint
-- WITH ENCRYPTION
AS

SELECT  MH.Id, MH.Name, MH.Code , Count(MH.Id) as 'SoCauHoi'

FROM 
	[dbo].[Faculties] K
	JOIN [dbo].[Subjects] MH ON MH.FacultyId = K.Id
	JOIN [dbo].[Chapters] P ON P.SubjectId = MH.Id
	JOIN [dbo].[Questions] CH ON CH.ChapterId = P.Id

WHERE 
	
	CH.Deleted = 'true' AND CH.validated =1
	AND K.Id = @FaculyId

GROUP BY MH.Id, MH.Name, MH.Code
GO
/****** Object:  StoredProcedure [dbo].[Subjects_Count]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Subjects_Count]
AS
SELECT COUNT([Id]) AS Quantity_Subjects
     
  FROM [dbo].[Subjects]













GO
/****** Object:  StoredProcedure [dbo].[Subjects_FlagAsDeleted]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Subjects_FlagAsDeleted]
	@Code Varchar

AS

DELETE FROM [dbo].[Subjects]
  WHERE Code= @Code














GO
/****** Object:  StoredProcedure [dbo].[Subjects_Insert]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Subjects_Insert]

@FacultyId int,
@Code varchar(10),
@Name nvarchar(100),
@Deleted bit

-- WITH ENCRYPTION
AS
BEGIN
	DECLARE @STT int
	SET @STT =(select  (isnull(count(ManagementOrder),0)+1) from Subjects where FacultyId = @FacultyId)
	INSERT INTO 	[dbo].[Subjects] 
	(
					[Code],
					[Name],
					[Deleted],
					[FacultyId],
					[ManagementOrder]
	) 

	VALUES 
	(
					@Code,
					@Name,
					@Deleted,
					@FacultyId,
					@STT
				
	)
END






GO
/****** Object:  StoredProcedure [dbo].[Subjects_Restore]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Subjects_Restore]

/*
Author:   			Nguyen Bao Quoc
Created: 			2011-3-8
Last Modified: 		2011-3-8
*/
	
@Id bigint,
@FacultyId int

-- WITH ENCRYPTION
AS
BEGIN

	UPDATE Questions SET Deleted = 0
	WHERE SubjectId = @Id

	UPDATE Chapters SET Deleted = 0
	WHERE SubjectId = @Id

	UPDATE Subjects	SET Deleted = 0
	WHERE Id = @Id

	DECLARE @SoLuongCauHoi int;
	Set @SoLuongCauHoi = (SELECT Count(Id) FROM Questions 
						  WHERE Deleted = 1 AND SubjectId IN(SELECT Id from Subjects WHERE FacultyId = @FacultyId))
	IF(@SoLuongCauHoi =0)
		UPDATE Faculties SET Deleted =0 WHERE Id = @FacultyId
END




GO
/****** Object:  StoredProcedure [dbo].[Subjects_SelectAll]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Subjects_SelectAll]

/*
Author:   			Nguyen Bao Quoc
Created: 			2011-3-8
Last Modified: 		2011-3-8
*/
-- WITH ENCRYPTION
AS


SELECT
		[Id],
		[Code],
		[Name],
		[Deleted],
		[FacultyId],
		[ManagementOrder]
		
FROM
		[dbo].[Subjects]





GO
/****** Object:  StoredProcedure [dbo].[Subjects_SelectAll_Deleted]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Subjects_SelectAll_Deleted]

/*
Author:   			Hoang Van Hieu
Created: 			2017-02-45
Last Modified: 		2017-02-45
*/
-- WITH ENCRYPTION
AS


SELECT
		*		
FROM
		[dbo].[Subjects]
where
		Deleted = 'True' AND validated =1








GO
/****** Object:  StoredProcedure [dbo].[Subjects_SelectBy_FacultyId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Subjects_SelectBy_FacultyId]

/*
Author:   			Nguyen Bao Quoc
Created: 			2011-3-8
Last Modified: 		2011-3-8
*/

@FacultyId int
-- WITH ENCRYPTION
AS


SELECT
		*
		
FROM
		[dbo].[Subjects]
		
WHERE
		[FacultyId] = @FacultyId
		and Deleted = 'False'











GO
/****** Object:  StoredProcedure [dbo].[Subjects_SelectOne]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Subjects_SelectOne]

/*
Author:   			Nguyen Bao Quoc
Created: 			2011-3-8
Last Modified: 		2011-3-8
*/

@Id bigint
-- WITH ENCRYPTION
AS


SELECT
		[Id],
		[Code],
		[Name],
		[Deleted],
		[FacultyId],
		[ManagementOrder]
		
FROM
		[dbo].[Subjects]
		
WHERE
		[Id] = @Id













GO
/****** Object:  StoredProcedure [dbo].[Subjects_SelectOneByName]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Subjects_SelectOneByName]

/*
Author:   			Nguyen Bao Quoc
Created: 			2011-3-8
Last Modified: 		2011-3-8
*/
@FacultyId int,
@Name nvarchar(100)
-- WITH ENCRYPTION
AS


SELECT
		*		
FROM
		[dbo].[Subjects]
		
WHERE
		lower([Name]) =  lower(@Name)
		and [FacultyId] = @FacultyId












GO
/****** Object:  StoredProcedure [dbo].[Subjects_SelectPage]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Subjects_SelectPage]

-- Author:   			Nguyen Bao Quoc
-- Created: 			2011-3-8
-- Last Modified: 		2011-3-8

@PageNumber 			int,
@PageSize 			int
-- WITH ENCRYPTION
AS

DECLARE @PageLowerBound int
DECLARE @PageUpperBound int


SET @PageLowerBound = (@PageSize * @PageNumber) - @PageSize
SET @PageUpperBound = @PageLowerBound + @PageSize + 1

/*
Note: temp tables use the server default for collation not the database default
so if adding character columns be sure and specify to use the database collation like this
to avoid collation errors:

CREATE TABLE #PageIndexForUsers
(
IndexID int IDENTITY (1, 1) NOT NULL,
UserName nvarchar(50) COLLATE DATABASE_DEFAULT,
LoginName nvarchar(50) COLLATE DATABASE_DEFAULT
) 


*/

CREATE TABLE #PageIndex 
(
	IndexID int IDENTITY (1, 1) NOT NULL,
	Id bigint
)

BEGIN

INSERT INTO #PageIndex ( 
Id
)

SELECT
		[Id]
		
FROM
		[dbo].[Subjects]
		
-- WHERE

-- ORDER BY

END


SELECT
		t1.*
		
FROM
		[dbo].[Subjects] t1

JOIN			#PageIndex t2
ON			
		t1.[Id] = t2.[Id]
		
WHERE
		t2.IndexID > @PageLowerBound 
		AND t2.IndexID < @PageUpperBound
		
ORDER BY t2.IndexID

DROP TABLE #PageIndex













GO
/****** Object:  StoredProcedure [dbo].[Subjects_Update]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Subjects_Update]
	/*
	Author:   			HOANG VAN HIEU
	Created: 			2017-02-06
	Last Modified: 		2017-02-06
	*/
	@Id int,
	@Code varchar(10),
    @Name  nvarchar(100),
    @Deleted bit,
    @FacultyId int
AS
BEGIN
	IF(@Deleted='False')
		UPDATE [dbo].[Subjects]
		   SET [Code] = @Code
			  ,[Name] = @Name
			  ,[Deleted] = @Deleted
			  ,[FacultyId] = @FacultyId
		 WHERE [Id] = @Id
	ELSE
		BEGIN
			UPDATE Subjects SET Deleted ='true' where Id = @Id;
			UPDATE Chapters SET Deleted = 'true' WHERE SubjectId = @Id;
			UPDATE Questions SET Deleted = 'true' WHERE SubjectId =@Id;
		END	
	DECLARE @SoLuongCauHoi int;
	SET @SoLuongCauHoi = (SELECT COUNT(Id) FROM Questions
						WHERE Deleted =0 AND SubjectId IN(SELECT Id FROM Subjects WHERE FacultyId = @FacultyId))
	select @SoLuongCauHoi
	IF(@SoLuongCauHoi =0)
		UPDATE Faculties SET Deleted = 1 WHERE Id =@FacultyId
END





GO
/****** Object:  StoredProcedure [dbo].[UpdateAnswer]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateAnswer]
    @questionSheetId BIGINT ,
    @questionId BIGINT ,
    @answerId BIGINT
AS
    BEGIN
        DECLARE @completed BIT;

        SELECT  @completed = Completed
        FROM    dbo.QuestionSheets
        WHERE   Id = @questionSheetId;

        IF ( @completed = 0 ) --false
            BEGIN
                UPDATE  dbo.QuestionSheetDetails
                SET     AnswerId = @answerId
                WHERE   QuestionSheetId = @questionSheetId
                        AND QuestionId = @questionId;

                SELECT  'true' AS Result; --true
            END;
        ELSE
            SELECT 'false' AS Result; --false
    END;





GO
/****** Object:  StoredProcedure [dbo].[UpdateDiscriminationForQuestion]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[UpdateDiscriminationForQuestion]
@MarkAdv decimal(18,10),
@MarkBle decimal(18,10),
@AnswerId BigInt,
@QuestionId BigInt
as
BEGIN
	DECLARE @Adv int;
	DECLARE @Ble int;
	SET @Adv =(SELECT isnull(count(AnswerId),0) from QuestionSheetDetails QD Join QuestionSheets QS ON QD.QuestionSheetId = QS.Id 
				where QS.Mark >@MarkAdv And QD.AnswerId =@AnswerId And QD.QuestionId =@QuestionId  And Correct =1)
	SET @Ble = (SELECT ISNULL(COUNT(AnswerId),0) from QuestionSheetDetails QD Join QuestionSheets QS ON QD.QuestionSheetId = QS.Id 
				WHERE QS.Mark <@MarkBle And QD.AnswerId =@AnswerId And QD.QuestionId =@QuestionId And Correct=1);
	update Questions SET Discrimination =ABS(Convert(decimal(18,10),(CONVERT(decimal(18,10),(1-0)) / CONVERT(decimal(18,10),(0.27*SELECTedTimes))))) where Id = @QuestionId And SELECTedTimes >0
END





GO
/****** Object:  StoredProcedure [dbo].[UpdateDiscriminationForQuestionByChapterId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UpdateDiscriminationForQuestionByChapterId]
@ChapterId int,
@MarkAdv decimal(18,10),
@MarkBle decimal(18,10),
@Limit decimal(18,10),
@SelectedTimes int
As
BEGIN
	DECLARE @QuestionId BigInt;
	DECLARE MY_CURSOR CURSOR 
	  LOCAL STATIC READ_ONLY FORWARD_ONLY
	FOR 
	SELECT DISTINCT Id 
	FROM QuestionsV WHERE ChapterId =@ChapterId

	OPEN MY_CURSOR
	FETCH NEXT FROM MY_CURSOR INTO @QuestionId
	WHILE @@FETCH_STATUS = 0
	BEGIN 

		DECLARE @AnswerId BigInt;
		DECLARE MY_CURSOR_Ans CURSOR 
		  LOCAL STATIC READ_ONLY FORWARD_ONLY
		FOR 
		SELECT DISTINCT Id 
		FROM AnswersV 

		OPEN MY_CURSOR_Ans
		FETCH NEXT FROM MY_CURSOR INTO @AnswerId
		WHILE @@FETCH_STATUS = 0
		BEGIN 
			Update Answers set SelectedTimes = (select ISNULL(COUNT(AnswerId),0) from QuestionSheetDetails 
			where Answers.Id = AnswerId  Group By AnswerId) WHERE Id = @AnswerId
			DECLARE @Adv int;
			DECLARE @Ble int;
			SET @Adv =(SELECT isnull(count(AnswerId),0) from QuestionSheetDetails QD Join QuestionSheets QS ON QD.QuestionSheetId = QS.Id 
						where QS.Mark >(@MarkAdv-0.1) And QD.AnswerId =@AnswerId And QD.QuestionId =@QuestionId  And Correct =1)
			SET @Ble = (SELECT ISNULL(COUNT(AnswerId),0) from QuestionSheetDetails QD Join QuestionSheets QS ON QD.QuestionSheetId = QS.Id 
						WHERE QS.Mark <(@MarkBle+0.1) And QD.AnswerId =@AnswerId And QD.QuestionId =@QuestionId And Correct=1);
			update Questions SET Discrimination =ABS(Convert(decimal(18,10),(CONVERT(decimal(18,10),(@Adv-@Ble)) / CONVERT(decimal(18,10),(@Limit*SELECTedTimes))))) where Id = @QuestionId And SelectedTimes >@SelectedTimes
			FETCH NEXT FROM MY_CURSOR_Ans INTO @AnswerId
		END
		CLOSE MY_CURSOR_Ans
		DEALLOCATE MY_CURSOR_Ans
		FETCH NEXT FROM MY_CURSOR INTO @QuestionId
	END
	CLOSE MY_CURSOR
	DEALLOCATE MY_CURSOR
END





GO
/****** Object:  StoredProcedure [dbo].[UpdateDiscriminationForQuestionBySubjectId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UpdateDiscriminationForQuestionBySubjectId]
@SubjectId int,
@MarkAdv decimal(18,10),
@MarkBle decimal(18,10),
@Limit decimal(18,10),
@SelectedTimes int
As
BEGIN
	DECLARE @QuestionId BigInt;
	DECLARE MY_CURSOR CURSOR 
	  LOCAL STATIC READ_ONLY FORWARD_ONLY
	FOR 
	SELECT DISTINCT Id 
	FROM GetQuesTionInQuestionSheet(@SubjectId)

	OPEN MY_CURSOR
	FETCH NEXT FROM MY_CURSOR INTO @QuestionId
	WHILE @@FETCH_STATUS = 0
	BEGIN 

		DECLARE @AnswerId BigInt;
		DECLARE MY_CURSOR_Ans CURSOR 
		  LOCAL STATIC READ_ONLY FORWARD_ONLY
		FOR 
		SELECT DISTINCT Id 
		FROM GetAnswerInQuestionSheet(@SubjectId) 

		OPEN MY_CURSOR_Ans
		FETCH NEXT FROM MY_CURSOR_Ans INTO @AnswerId
		WHILE @@FETCH_STATUS = 0
		BEGIN 
			Update Answers set SelectedTimes = (select ISNULL(COUNT(AnswerId),0) from QuestionSheetDetails 
			where Answers.Id = AnswerId  Group By AnswerId) WHERE Id = @AnswerId
			DECLARE @Adv int;
			DECLARE @Ble int;
			SET @Adv =(SELECT isnull(count(AnswerId),0) from QuestionSheetDetails QD Join QuestionSheets QS ON QD.QuestionSheetId = QS.Id 
						where QS.Mark >(@MarkAdv-0.1) And QD.AnswerId =@AnswerId And QD.QuestionId =@QuestionId  And Correct =1)
			SET @Ble = (SELECT ISNULL(COUNT(AnswerId),0) from QuestionSheetDetails QD Join QuestionSheets QS ON QD.QuestionSheetId = QS.Id 
						WHERE QS.Mark <(@MarkBle+0.1) And QD.AnswerId =@AnswerId And QD.QuestionId =@QuestionId And Correct=1);
			update Questions SET Discrimination =ABS(Convert(decimal(18,10),(CONVERT(decimal(18,10),(@Adv-@Ble)) / CONVERT(decimal(18,10),(@Limit*SelectedTimes))))) where Id = @QuestionId And SELECTedTimes >@SelectedTimes
			FETCH NEXT FROM MY_CURSOR_Ans INTO @AnswerId
		END
		CLOSE MY_CURSOR_Ans
		DEALLOCATE MY_CURSOR_Ans
		FETCH NEXT FROM MY_CURSOR INTO @QuestionId
	END
	CLOSE MY_CURSOR
	DEALLOCATE MY_CURSOR
END



GO
/****** Object:  StoredProcedure [dbo].[UpdateListenTimes]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateListenTimes]
    @questionSheetId BIGINT ,
    @questionId BIGINT
AS
    BEGIN
        DECLARE @listenTimes INT;

        SET @listenTimes = ( SELECT   ListenTimes
                           FROM     dbo.QuestionSheetDetails
                           WHERE    QuestionSheetId = @questionSheetId
                                    AND QuestionId = @questionId
                         );
        IF ( @listenTimes <= 5 )
            SET @listenTimes = @listenTimes + 1;
	
        UPDATE  dbo.QuestionSheetDetails
        SET     ListenTimes = @listenTimes
        WHERE   QuestionSheetId = @questionSheetId
                AND QuestionId = @questionId;

        IF ( @listenTimes <= 5 )
            SELECT  'true' AS Result --trả store về true
        ELSE
            SELECT  'false' AS Result; --trả store về false
    END;





GO
/****** Object:  StoredProcedure [dbo].[UpdateObjectiveDifficulty]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[UpdateObjectiveDifficulty]

@ChapterId int

as
	UPDATE Questions SET ObjectiveDifficulty =(CONVERT(decimal(18,10),(CorrectTimes)))/(CONVERT(decimal(18,10),(SelectedTimes)))
	WHERE CorrectTimes>0 and SelectedTimes >0 and ChapterId =@ChapterId





GO
/****** Object:  StoredProcedure [dbo].[UpdateObjectiveDifficultyByChapterId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[UpdateObjectiveDifficultyByChapterId]

@ChapterId int,
@SelectedTimes int
as
	UPDATE Questions SET ObjectiveDifficulty =(CONVERT(decimal(18,10),(CorrectTimes)))/(CONVERT(decimal(18,10),(SelectedTimes)))
	WHERE CorrectTimes>0 and SelectedTimes >(@SelectedTimes-1) and ChapterId =@ChapterId





GO
/****** Object:  StoredProcedure [dbo].[UpdateObjectiveDifficultyBySubjectId]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[UpdateObjectiveDifficultyBySubjectId]

@SubjectId int,
@SelectedTimes int

as
	UPDATE Questions SET ObjectiveDifficulty =(CONVERT(decimal(18,10),(CorrectTimes)))/(CONVERT(decimal(18,10),(SelectedTimes)))
	WHERE CorrectTimes>0 and SelectedTimes >@SelectedTimes and SubjectId =@SubjectId





GO
/****** Object:  StoredProcedure [dbo].[UpdatePaperQuestionSheet]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UpdatePaperQuestionSheet]
@Id Bigint
AS
	UPDATE PaperQuestionSheets SET Exported =1, ExportDate = GETDATE()
	WHERE Id =@Id



GO
/****** Object:  StoredProcedure [dbo].[User_SelectAll]    Script Date: 7/23/2017 4:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[User_SelectAll]
AS
	SELECT * FROM [Users]






GO
