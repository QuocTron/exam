SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
ALTER PROC [dbo].[GetQuestionSheet]
    @questionSheetId BIGINT
AS
    BEGIN
        SELECT  [QuestionSheetDetails].[QuestionSheetId] ,
                [QuestionSheetDetails].[QuestionId] ,
                [QuestionSheetDetails].[Order] AS [QuestionOrder] ,
                [QuestionSheetDetails].[AnswerId] AS [AnswerCurrentChoose] ,
                [QuestionSheetDetails].[Correct] ,
                [QuestionSheetDetails].[ListenTimes] ,
                [Question].[Content] AS [QuestionContent] ,
                [Question].[ParentId] AS [QuestionParentId] ,
                [Question].[Audio] AS [QuestionAudio] ,
                [Question.Subject].[Id] AS [SubjectId] ,
                [Question.Subject].[Code] AS [SubjectCode] ,
                [Question.Subject].[Name] AS [SubjectName] ,
                [Question.Chapter].[Id] AS [ChapterId] ,
                [Question.Chapter].[Name] AS [ChapterName] ,
                [Question.Chapter].[Content] AS [ChapterContent] ,
                [Question.Chapter].[SubjectId] AS [ChapterSubjectId] ,
                [Question.Chapter].[ParentId] AS [ChapterParentId] ,
                [Question.Answers].[Id] AS [AnswersId] ,
                [Question.Answers].[Content] AS [AnswersContent] ,
                [Question.Answers].[Order] AS [AnswersOrder]
        FROM    [QuestionSheetDetails] AS [QuestionSheetDetails]
                LEFT OUTER JOIN [Questions] AS [Question] ON [QuestionSheetDetails].[QuestionId] = [Question].[Id]
                LEFT OUTER JOIN [Subjects] AS [Question.Subject] ON [Question].[SubjectId] = [Question.Subject].[Id]
                LEFT OUTER JOIN [Chapters] AS [Question.Chapter] ON [Question].[ChapterId] = [Question.Chapter].[Id]
                LEFT OUTER JOIN [Answers] AS [Question.Answers] ON [Question].[Id] = [Question.Answers].[QuestionId]
        WHERE   [QuestionSheetDetails].[QuestionSheetId] = @questionSheetId;
    END;








GO

