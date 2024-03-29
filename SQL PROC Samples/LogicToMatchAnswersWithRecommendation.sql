USE [C74_Lynwood]
GO
/****** Object:  StoredProcedure [dbo].[Resources_Question1Answers]    Script Date: 6/23/2019 10:45:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[Resources_Question1Answers]
						 @SurveyInstanceId INT


AS

/*
DECLARE		
		@SurveyInstanceId INT = 299

EXECUTE [dbo].[Resources_Question1Answers] 
						 @SurveyInstanceId


*/

DECLARE  
		 @AnsweredId INT 
		,@ZIPCODE NVARCHAR(500)
		,@ZIPCODE2 NVARCHAR(500)
		,@SecondQuestionId INT
		,@SecondAnswerId INT
		,@QuestionId INT = 1

IF 
		(SELECT
				SurveyQuestions.[Id] AS QuestionId

		FROM
				dbo. SurveyInstances AS SI
				INNER JOIN dbo.SurveyAnswers AS Answers
				ON  Answers.InstanceId = SI.Id AND SI.Id = @SurveyInstanceId
				INNER JOIN dbo.SurveyQuestions AS SurveyQuestions
				ON SurveyQuestions.Id = Answers.QuestionId
				LEFT JOIN dbo.SurveyQuestionAnswerOptions AS AnwserOptions
				ON AnwserOptions.Id = Answers.AnswerOptionId
				WHERE Answers.QuestionId = @QuestionId) = @QuestionId

BEGIN

 --- GETTING ANSWERS ID
		SET 
			@AnsweredId = (SELECT SA.AnswerOptionId 
		FROM 
			dbo.SurveyAnswers AS SA
		WHERE 
			SA.InstanceId = @SurveyInstanceId  AND SA.QuestionId = @QuestionId) 

--- Getting ZIPCODE---

	SET @ZIPCODE = (SELECT 
	Answer AS ZipCode
	FROM  dbo.SurveyAnswers AS Answers
	WHERE   
	Answers.InstanceId = @SurveyInstanceId AND Answers.QuestionId = 7) -- should be hard coded to 6 or 7 
		SET @ZIPCODE2 = (SELECT 
	Answer AS ZipCode
	FROM  dbo.SurveyAnswers AS Answers
	WHERE   
	Answers.InstanceId = @SurveyInstanceId AND Answers.QuestionId = 6) -- should be hard coded to 6 or 7 		

--- DO CHECK BASED ON ZIPCODES AND ANSWER ID option No.1
		IF (@ZIPCODE) >= 90002 AND (@ZIPCODE) <= 90262 AND (@AnsweredId) = 1 

BEGIN
		SELECT   R.[Id]
				,R.[CompanyName]
				,R.[Description]
				,R.[ContactName]
				,R.[ContactEmail]
				,BT.[Name] AS [BusinessTypeName]
				,IT.[Name] AS [IndustryTypeName]
				,R.[ImageUrl]
				,R.[SiteUrl]
				,R.[Phone]
				,(	SELECT	RC.Id AS [Id]
							,RC.[Name] AS [Name]
					FROM [dbo].[Resources] AS RS
					INNER JOIN [dbo].[ResourcesAndCategories] AS RAC
					ON RS.[Id] = RAC.[ResourceId] AND RS.[Id] = R.[Id]
					INNER JOIN [dbo].[ResourcesCategories] as RC
					ON RAC. [ResourceCategoryId] = RC.[Id]
					FOR JSON AUTO
						) AS Categories

				FROM ResourcesAndCategories AS RC
						JOIN dbo.SurveyAnswers AS Answers
					ON  RC.[ResourceCategoryId] = 1
						OR 
					 RC.[ResourceCategoryId] = 24
						 OR 
					 RC.[ResourceCategoryId] = 30
					 OR 
					 RC.[ResourceCategoryId] = 43
						JOIN dbo.Resources AS R
					ON RC.ResourceId = R.Id
						JOIN [dbo].[BusinessTypes] AS BT
					ON R.BusinessTypeId = BT.[Id]
						JOIN[dbo].[IndustryTypes] AS IT
					ON IT.Id = R.IndustryTypeId

		WHERE   Answers.InstanceId = @SurveyInstanceId AND Answers.AnswerOptionId = @AnsweredId
END

--**************************************************************************************************************************
-- DO CHECK BASED ON ASWER ID for option NO.1	
 ELSE IF (@AnsweredId) = 1 

BEGIN

		SELECT   R.[Id]
				,R.[CompanyName]
				,R.[Description]
				,R.[ContactName]
				,R.[ContactEmail]
				,BT.[Name] AS [BusinessTypeName]
				,IT.[Name] AS [IndustryTypeName]
				,R.[ImageUrl]
				,R.[SiteUrl]
				,R.[Phone]
				,(	SELECT	RC.Id AS [Id]
				,RC.[Name] AS [Name]
				FROM [dbo].[Resources] AS RS
				INNER JOIN [dbo].[ResourcesAndCategories] AS RAC
				ON RS.[Id] = RAC.[ResourceId] AND RS.[Id] = R.[Id]
				INNER JOIN [dbo].[ResourcesCategories] as RC
				ON RAC. [ResourceCategoryId] = RC.[Id]
				FOR JSON AUTO
					) AS Categories

				FROM ResourcesAndCategories AS RC
						JOIN dbo.SurveyAnswers AS Answers
					ON  RC.[ResourceCategoryId] = 1
						JOIN dbo.Resources AS R
					ON RC.ResourceId = R.Id
						JOIN [dbo].[BusinessTypes] AS BT
					ON R.BusinessTypeId = BT.[Id]
						JOIN[dbo].[IndustryTypes] AS IT
					ON IT.Id = R.IndustryTypeId

		WHERE   Answers.InstanceId = @SurveyInstanceId AND Answers.AnswerOptionId = @AnsweredId

END
--***********************************************************************************************
--- DO CHECK BASED ON ZIPCODES AND ANSWER ID option No.2 AND QuestionID 8 ANSWER NO 

	ELSE IF ((@ZIPCODE) >= 90002 AND (@ZIPCODE) <= 90262) OR ((@ZIPCODE2) >= 90002 AND (@ZIPCODE2) <= 90262)
			AND 
			(@AnsweredId) = 2 
			AND 
			@SecondQuestionId = 8
			AND 
			@SecondAnswerId =74

BEGIN
		SELECT   R.[Id]
				,R.[CompanyName]
				,R.[Description]
				,R.[ContactName]
				,R.[ContactEmail]
				,BT.[Name] AS [BusinessTypeName]
				,IT.[Name] AS [IndustryTypeName]
				,R.[ImageUrl]
				,R.[SiteUrl]
				,R.[Phone]
				,(	SELECT	RC.Id AS [Id]
				,RC.[Name] AS [Name]
				FROM [dbo].[Resources] AS RS
				INNER JOIN [dbo].[ResourcesAndCategories] AS RAC
				ON RS.[Id] = RAC.[ResourceId] AND RS.[Id] = R.[Id]
				INNER JOIN [dbo].[ResourcesCategories] as RC
				ON RAC. [ResourceCategoryId] = RC.[Id]
				FOR JSON AUTO
					) AS Categories

				FROM ResourcesAndCategories AS RC
						JOIN dbo.SurveyAnswers AS Answers
					ON  RC.[ResourceCategoryId] = 1
					 OR 
					 RC.[ResourceCategoryId] = 2
					 OR 
					 RC.[ResourceCategoryId] = 25
					 OR 
					 RC.[ResourceCategoryId] = 24
					 OR 
					 RC.[ResourceCategoryId] = 30
					 OR 
					 RC.[ResourceCategoryId] = 43
						JOIN dbo.Resources AS R
					ON RC.ResourceId = R.Id
						JOIN [dbo].[BusinessTypes] AS BT
					ON R.BusinessTypeId = BT.[Id]
						JOIN[dbo].[IndustryTypes] AS IT
					ON IT.Id = R.IndustryTypeId

		WHERE   Answers.InstanceId = @SurveyInstanceId AND Answers.AnswerOptionId = @AnsweredId
END
--***************************************************************************************************
 --- DO CHECK BASED ON ZIPCODES AND ANSWER ID option No.2 AND QuestionID 8 ANSWER YES
	ELSE IF (@ZIPCODE) >= 90002 AND (@ZIPCODE) <= 90262 
			  AND 
			  (@AnsweredId) = 2 
			  AND 
			  @SecondQuestionId = 8
			  AND 
			  @SecondAnswerId =73
BEGIN
		SELECT   R.[Id]
				,R.[CompanyName]
				,R.[Description]
				,R.[ContactName]
				,R.[ContactEmail]
				,BT.[Name] AS [BusinessTypeName]
				,IT.[Name] AS [IndustryTypeName]
				,R.[ImageUrl]
				,R.[SiteUrl]
				,R.[Phone]
				,(	SELECT	RC.Id AS [Id]
				,RC.[Name] AS [Name]
				FROM [dbo].[Resources] AS RS
				INNER JOIN [dbo].[ResourcesAndCategories] AS RAC
				ON RS.[Id] = RAC.[ResourceId] AND RS.[Id] = R.[Id]
				INNER JOIN [dbo].[ResourcesCategories] as RC
				ON RAC. [ResourceCategoryId] = RC.[Id]
				FOR JSON AUTO
					) AS Categories


				FROM ResourcesAndCategories AS RC
						JOIN dbo.SurveyAnswers AS Answers
					ON  RC.[ResourceCategoryId] = 2
					 OR 
					 RC.[ResourceCategoryId] = 3
					 OR 
					 RC.[ResourceCategoryId] = 25
					 OR 
					 RC.[ResourceCategoryId] = 30
					 OR 
					 RC.[ResourceCategoryId] = 43
						JOIN dbo.Resources AS R
					ON RC.ResourceId = R.Id
						JOIN [dbo].[BusinessTypes] AS BT
					ON R.BusinessTypeId = BT.[Id]
						JOIN[dbo].[IndustryTypes] AS IT
					ON IT.Id = R.IndustryTypeId

		WHERE   Answers.InstanceId = @SurveyInstanceId AND Answers.AnswerOptionId = @AnsweredId
END
--***************************************************************************************************
		-- DO CHECK BASED ON ASWER ID for option NO.2
	ELSE IF (@AnsweredId) = 2

BEGIN

		SELECT   R.[Id]
				,R.[CompanyName]
				,R.[Description]
				,R.[ContactName]
				,R.[ContactEmail]
				,BT.[Name] AS [BusinessTypeName]
				,IT.[Name] AS [IndustryTypeName]
				,R.[ImageUrl]
				,R.[SiteUrl]
				,R.[Phone]
				,(	SELECT	RC.Id AS [Id]
				,RC.[Name] AS [Name]
				FROM [dbo].[Resources] AS RS
				INNER JOIN [dbo].[ResourcesAndCategories] AS RAC
				ON RS.[Id] = RAC.[ResourceId] AND RS.[Id] = R.[Id]
				INNER JOIN [dbo].[ResourcesCategories] as RC
				ON RAC. [ResourceCategoryId] = RC.[Id]
				FOR JSON AUTO
					) AS Categories


				FROM ResourcesAndCategories AS RC
						JOIN dbo.SurveyAnswers AS Answers
					ON  
					   RC.[ResourceCategoryId] = 2
					   OR 
					   RC.[ResourceCategoryId] = 43

						JOIN dbo.Resources AS R
					ON RC.ResourceId = R.Id
						JOIN [dbo].[BusinessTypes] AS BT
					ON R.BusinessTypeId = BT.[Id]
						JOIN[dbo].[IndustryTypes] AS IT
					ON IT.Id = R.IndustryTypeId

		WHERE   Answers.InstanceId = @SurveyInstanceId AND Answers.AnswerOptionId = @AnsweredId

END

--***************************************************************************************************
--- DO CHECK BASED ON ZIPCODES AND ANSWER ID option No.3 AND QuestionID 8 ANSWER NO 

	ELSE IF ((@ZIPCODE) >= 90002 AND (@ZIPCODE) <= 90262) OR ((@ZIPCODE2) >= 90002 AND (@ZIPCODE2) <= 90262)
			AND 
			(@AnsweredId) = 3 
			AND 
			@SecondQuestionId = 8
			AND 
			@SecondAnswerId =74

BEGIN
		SELECT   R.[Id]
				,R.[CompanyName]
				,R.[Description]
				,R.[ContactName]
				,R.[ContactEmail]
				,BT.[Name] AS [BusinessTypeName]
				,IT.[Name] AS [IndustryTypeName]
				,R.[ImageUrl]
				,R.[SiteUrl]
				,R.[Phone]
				,(	SELECT	RC.Id AS [Id]
					,RC.[Name] AS [Name]
					FROM [dbo].[Resources] AS RS
					INNER JOIN [dbo].[ResourcesAndCategories] AS RAC
					ON RS.[Id] = RAC.[ResourceId] AND RS.[Id] = R.[Id]
					INNER JOIN [dbo].[ResourcesCategories] as RC
					ON RAC. [ResourceCategoryId] = RC.[Id]
					FOR JSON AUTO
						) AS Categories


				FROM ResourcesAndCategories AS RC
						JOIN dbo.SurveyAnswers AS Answers
					ON  RC.[ResourceCategoryId] = 4
					 OR 
					 RC.[ResourceCategoryId] = 25
					 OR 
					 RC.[ResourceCategoryId] = 30
					 OR 
					 RC.[ResourceCategoryId] = 43
						JOIN dbo.Resources AS R
					ON RC.ResourceId = R.Id
						JOIN [dbo].[BusinessTypes] AS BT
					ON R.BusinessTypeId = BT.[Id]
						JOIN[dbo].[IndustryTypes] AS IT
					ON IT.Id = R.IndustryTypeId

		WHERE   Answers.InstanceId = @SurveyInstanceId AND Answers.AnswerOptionId = @AnsweredId
END
--****************************************************************************************************
 --- DO CHECK BASED ON ZIPCODES AND ANSWER ID option No.3 AND QuestionID 8 ANSWER YES
	ELSE IF (@ZIPCODE) >= 90002 AND (@ZIPCODE) <= 90262 
			  AND 
			  (@AnsweredId) = 3
			  AND 
			  @SecondQuestionId = 8
			  AND 
			  @SecondAnswerId =73
BEGIN
		SELECT   R.[Id]
				,R.[CompanyName]
				,R.[Description]
				,R.[ContactName]
				,R.[ContactEmail]
				,BT.[Name] AS [BusinessTypeName]
				,IT.[Name] AS [IndustryTypeName]
				,R.[ImageUrl]
				,R.[SiteUrl]
				,R.[Phone]
				,(	SELECT	RC.Id AS [Id]
				,RC.[Name] AS [Name]
					FROM [dbo].[Resources] AS RS
					INNER JOIN [dbo].[ResourcesAndCategories] AS RAC
					ON RS.[Id] = RAC.[ResourceId] AND RS.[Id] = R.[Id]
					INNER JOIN [dbo].[ResourcesCategories] as RC
					ON RAC. [ResourceCategoryId] = RC.[Id]
					FOR JSON AUTO
						) AS Categories

				FROM ResourcesAndCategories AS RC
						JOIN dbo.SurveyAnswers AS Answers
					ON  RC.[ResourceCategoryId] = 4
					 OR 
					 RC.[ResourceCategoryId] = 3
					 OR 
					 RC.[ResourceCategoryId] = 25
					 OR 
					 RC.[ResourceCategoryId] = 24
					 OR 
					 RC.[ResourceCategoryId] = 30
					 OR 
					 RC.[ResourceCategoryId] = 43
						JOIN dbo.Resources AS R
					ON RC.ResourceId = R.Id
						JOIN [dbo].[BusinessTypes] AS BT
					ON R.BusinessTypeId = BT.[Id]
						JOIN[dbo].[IndustryTypes] AS IT
					ON IT.Id = R.IndustryTypeId

		WHERE   Answers.InstanceId = @SurveyInstanceId AND Answers.AnswerOptionId = @AnsweredId
END
--*******************************************************************************************************
-- DO CHECK BASED ON ASWER ID for option NO.3
		ELSE IF (@AnsweredId) = 3

BEGIN

		SELECT   R.[Id]
				,R.[CompanyName]
				,R.[Description]
				,R.[ContactName]
				,R.[ContactEmail]
				,BT.[Name] AS [BusinessTypeName]
				,IT.[Name] AS [IndustryTypeName]
				,R.[ImageUrl]
				,R.[SiteUrl]
				,(	SELECT	RC.Id AS [Id]
				,RC.[Name] AS [Name]
					FROM [dbo].[Resources] AS RS
					INNER JOIN [dbo].[ResourcesAndCategories] AS RAC
					ON RS.[Id] = RAC.[ResourceId] AND RS.[Id] = R.[Id]
					INNER JOIN [dbo].[ResourcesCategories] as RC
					ON RAC. [ResourceCategoryId] = RC.[Id]
					FOR JSON AUTO
						) AS Categories


				FROM ResourcesAndCategories AS RC
						JOIN dbo.SurveyAnswers AS Answers
					ON  RC.[ResourceCategoryId] = 4
					OR 
					RC.[ResourceCategoryId] = 43
						JOIN dbo.Resources AS R
					ON RC.ResourceId = R.Id
						JOIN [dbo].[BusinessTypes] AS BT
					ON R.BusinessTypeId = BT.[Id]
						JOIN[dbo].[IndustryTypes] AS IT
					ON IT.Id = R.IndustryTypeId

		WHERE   Answers.InstanceId = @SurveyInstanceId AND Answers.AnswerOptionId = @AnsweredId

END
--******************************************************************************************************
--- DO CHECK BASED ON ZIPCODES AND ANSWER ID option No.4 AND QuestionID 8 ANSWER NO 

	ELSE IF ((@ZIPCODE) >= 90002 AND (@ZIPCODE) <= 90262) OR ((@ZIPCODE2) >= 90002 AND (@ZIPCODE2) <= 90262)
			AND 
			(@AnsweredId) = 60 
			AND 
			@SecondQuestionId = 8
			AND 
			@SecondAnswerId =74

BEGIN
		SELECT   R.[Id]
				,R.[CompanyName]
				,R.[Description]
				,R.[ContactName]
				,R.[ContactEmail]
				,BT.[Name] AS [BusinessTypeName]
				,IT.[Name] AS [IndustryTypeName]
				,R.[ImageUrl]
				,R.[SiteUrl]
				,R.[Phone]
				,(	SELECT	RC.Id AS [Id]
				,RC.[Name] AS [Name]
					FROM [dbo].[Resources] AS RS
					INNER JOIN [dbo].[ResourcesAndCategories] AS RAC
					ON RS.[Id] = RAC.[ResourceId] AND RS.[Id] = R.[Id]
					INNER JOIN [dbo].[ResourcesCategories] as RC
					ON RAC. [ResourceCategoryId] = RC.[Id]
					FOR JSON AUTO
						) AS Categories

				FROM ResourcesAndCategories AS RC
						JOIN dbo.SurveyAnswers AS Answers
					ON  RC.[ResourceCategoryId] = 26
					 OR 
					 RC.[ResourceCategoryId] = 31
					 OR 
					 RC.[ResourceCategoryId] = 43
						JOIN dbo.Resources AS R
					ON RC.ResourceId = R.Id
						JOIN [dbo].[BusinessTypes] AS BT
					ON R.BusinessTypeId = BT.[Id]
						JOIN[dbo].[IndustryTypes] AS IT
					ON IT.Id = R.IndustryTypeId

		WHERE   Answers.InstanceId = @SurveyInstanceId AND Answers.AnswerOptionId = @AnsweredId
END
--*****************************************************************************************************
	 --- DO CHECK BASED ON ZIPCODES AND ANSWER ID option No.4 AND QuestionID 8 ANSWER YES
	ELSE IF (@ZIPCODE) >= 90002 AND (@ZIPCODE) <= 90262 
			  AND 
			  (@AnsweredId) = 60
			  AND 
			  @SecondQuestionId = 8
			  AND 
			  @SecondAnswerId =73
BEGIN
		SELECT   R.[Id]
				,R.[CompanyName]
				,R.[Description]
				,R.[ContactName]
				,R.[ContactEmail]
				,BT.[Name] AS [BusinessTypeName]
				,IT.[Name] AS [IndustryTypeName]
				,R.[ImageUrl]
				,R.[SiteUrl]
				,R.[Phone]
				,(	SELECT	RC.Id AS [Id]
				,RC.[Name] AS [Name]
					FROM [dbo].[Resources] AS RS
					INNER JOIN [dbo].[ResourcesAndCategories] AS RAC
					ON RS.[Id] = RAC.[ResourceId] AND RS.[Id] = R.[Id]
					INNER JOIN [dbo].[ResourcesCategories] as RC
					ON RAC. [ResourceCategoryId] = RC.[Id]
					FOR JSON AUTO
						) AS Categories

				FROM ResourcesAndCategories AS RC
						JOIN dbo.SurveyAnswers AS Answers
					ON  RC.[ResourceCategoryId] = 5
					 OR 
					 RC.[ResourceCategoryId] = 25
					 OR 
					 RC.[ResourceCategoryId] = 30
					 OR 
					 RC.[ResourceCategoryId] = 43
						JOIN dbo.Resources AS R
					ON RC.ResourceId = R.Id
						JOIN [dbo].[BusinessTypes] AS BT
					ON R.BusinessTypeId = BT.[Id]
						JOIN[dbo].[IndustryTypes] AS IT
					ON IT.Id = R.IndustryTypeId

		WHERE   Answers.InstanceId = @SurveyInstanceId AND Answers.AnswerOptionId = @AnsweredId
END

--***************************************************************************************************
-- DO CHECK BASED ON ASWER ID for option NO.4
		ELSE IF (@AnsweredId) = 60

BEGIN

		SELECT   R.[Id]
				,R.[CompanyName]
				,R.[Description]
				,R.[ContactName]
				,R.[ContactEmail]
				,BT.[Name] AS [BusinessTypeName]
				,IT.[Name] AS [IndustryTypeName]
				,R.[ImageUrl]
				,R.[SiteUrl]
				,R.[Phone]
				,(	SELECT	RC.Id AS [Id]
				,RC.[Name] AS [Name]
					FROM [dbo].[Resources] AS RS
					INNER JOIN [dbo].[ResourcesAndCategories] AS RAC
					ON RS.[Id] = RAC.[ResourceId] AND RS.[Id] = R.[Id]
					INNER JOIN [dbo].[ResourcesCategories] as RC
					ON RAC. [ResourceCategoryId] = RC.[Id]
					FOR JSON AUTO
						) AS Categories

				FROM ResourcesAndCategories AS RC
						JOIN dbo.SurveyAnswers AS Answers
					ON  RC.[ResourceCategoryId] = 5
						JOIN dbo.Resources AS R
					ON RC.ResourceId = R.Id
						JOIN [dbo].[BusinessTypes] AS BT
					ON R.BusinessTypeId = BT.[Id]
						JOIN[dbo].[IndustryTypes] AS IT
					ON IT.Id = R.IndustryTypeId

		WHERE   Answers.InstanceId = @SurveyInstanceId AND Answers.AnswerOptionId = @AnsweredId

END
--****************************************************************************************************
--- DO CHECK BASED ON ZIPCODES AND ANSWER ID option No.5 AND QuestionID 8 ANSWER NO 

	ELSE IF ((@ZIPCODE) >= 90002 AND (@ZIPCODE) <= 90262) OR ((@ZIPCODE2) >= 90002 AND (@ZIPCODE2) <= 90262)
			AND 
			(@AnsweredId) = 61
			AND 
			@SecondQuestionId = 8
			AND 
			@SecondAnswerId =74

BEGIN
		SELECT   R.[Id]
				,R.[CompanyName]
				,R.[Description]
				,R.[ContactName]
				,R.[ContactEmail]
				,BT.[Name] AS [BusinessTypeName]
				,IT.[Name] AS [IndustryTypeName]
				,R.[ImageUrl]
				,R.[SiteUrl]
				,R.[Phone]
				,(	SELECT	RC.Id AS [Id]
				,RC.[Name] AS [Name]
					FROM [dbo].[Resources] AS RS
					INNER JOIN [dbo].[ResourcesAndCategories] AS RAC
					ON RS.[Id] = RAC.[ResourceId] AND RS.[Id] = R.[Id]
					INNER JOIN [dbo].[ResourcesCategories] as RC
					ON RAC. [ResourceCategoryId] = RC.[Id]
					FOR JSON AUTO
						) AS Categories

				FROM ResourcesAndCategories AS RC
						JOIN dbo.SurveyAnswers AS Answers
					ON  RC.[ResourceCategoryId] = 6
					 OR 
					 RC.[ResourceCategoryId] = 27
						JOIN dbo.Resources AS R
					ON RC.ResourceId = R.Id
						JOIN [dbo].[BusinessTypes] AS BT
					ON R.BusinessTypeId = BT.[Id]
						JOIN[dbo].[IndustryTypes] AS IT
					ON IT.Id = R.IndustryTypeId

		WHERE   Answers.InstanceId = @SurveyInstanceId AND Answers.AnswerOptionId = @AnsweredId
END
--*******************************************************************************************************
--- DO CHECK BASED ON ZIPCODES AND ANSWER ID option No.5 
--AND QuestionID 8 ANSWER NO AND QuestionID 2 ANSWER is 95

	ELSE IF (@ZIPCODE) >= 90002 AND (@ZIPCODE) <= 90262 
			AND 
			(@AnsweredId) = 61
			AND 
			@SecondQuestionId = 8
			AND 
			@SecondAnswerId =74
			OR 
			@SecondQuestionId = 2
			AND
			@SecondAnswerId =95

BEGIN
		SELECT   R.[Id]
				,R.[CompanyName]
				,R.[Description]
				,R.[ContactName]
				,R.[ContactEmail]
				,BT.[Name] AS [BusinessTypeName]
				,IT.[Name] AS [IndustryTypeName]
				,R.[ImageUrl]
				,R.[SiteUrl]
				,R.[Phone]
				,(	SELECT	RC.Id AS [Id]
				,RC.[Name] AS [Name]
					FROM [dbo].[Resources] AS RS
					INNER JOIN [dbo].[ResourcesAndCategories] AS RAC
					ON RS.[Id] = RAC.[ResourceId] AND RS.[Id] = R.[Id]
					INNER JOIN [dbo].[ResourcesCategories] as RC
					ON RAC. [ResourceCategoryId] = RC.[Id]
					FOR JSON AUTO
						) AS Categories


				FROM ResourcesAndCategories AS RC
					JOIN dbo.SurveyAnswers AS Answers
				ON  RC.[ResourceCategoryId] = 6
					OR 
					RC.[ResourceCategoryId] = 27
					OR 
					RC.[ResourceCategoryId] = 31
					JOIN dbo.Resources AS R
				ON RC.ResourceId = R.Id
					JOIN [dbo].[BusinessTypes] AS BT
				ON R.BusinessTypeId = BT.[Id]
					JOIN[dbo].[IndustryTypes] AS IT
					ON IT.Id = R.IndustryTypeId

		WHERE   Answers.InstanceId = @SurveyInstanceId AND Answers.AnswerOptionId = @AnsweredId
END



--****************************************************************************************************
	 --- DO CHECK BASED ON ZIPCODES AND ANSWER ID option No.5 AND QuestionID 8 ANSWER YES
	ELSE IF (@ZIPCODE) >= 90002 AND (@ZIPCODE) <= 90262 
			  AND 
			  (@AnsweredId) = 61
			  AND 
			  @SecondQuestionId = 8
			  AND 
			  @SecondAnswerId =73
BEGIN
		SELECT   R.[Id]
				,R.[CompanyName]
				,R.[Description]
				,R.[ContactName]
				,R.[ContactEmail]
				,BT.[Name] AS [BusinessTypeName]
				,IT.[Name] AS [IndustryTypeName]
				,R.[ImageUrl]
				,R.[SiteUrl]
				,R.[Phone]
				,(	SELECT	RC.Id AS [Id]
				,RC.[Name] AS [Name]
					FROM [dbo].[Resources] AS RS
					INNER JOIN [dbo].[ResourcesAndCategories] AS RAC
					ON RS.[Id] = RAC.[ResourceId] AND RS.[Id] = R.[Id]
					INNER JOIN [dbo].[ResourcesCategories] as RC
					ON RAC. [ResourceCategoryId] = RC.[Id]
					FOR JSON AUTO
						) AS Categories


				FROM ResourcesAndCategories AS RC
						JOIN dbo.SurveyAnswers AS Answers
					ON  RC.[ResourceCategoryId] = 6
					 OR 
					 RC.[ResourceCategoryId] = 28
					 OR 
					 RC.[ResourceCategoryId] = 30
					 OR 
					 RC.[ResourceCategoryId] = 37
					 OR
					  RC.[ResourceCategoryId] = 43
						JOIN dbo.Resources AS R
					ON RC.ResourceId = R.Id
						JOIN [dbo].[BusinessTypes] AS BT
					ON R.BusinessTypeId = BT.[Id]
						JOIN[dbo].[IndustryTypes] AS IT
					ON IT.Id = R.IndustryTypeId

		WHERE   Answers.InstanceId = @SurveyInstanceId AND Answers.AnswerOptionId = @AnsweredId
END
--******************************************************************************************************
-- DO CHECK BASED ON ASWER ID for option NO.5
	ELSE IF (@AnsweredId) = 61

BEGIN

		SELECT   R.[Id]
				,R.[CompanyName]
				,R.[Description]
				,R.[ContactName]
				,R.[ContactEmail]
				,BT.[Name] AS [BusinessTypeName]
				,IT.[Name] AS [IndustryTypeName]
				,R.[ImageUrl]
				,R.[SiteUrl]
				,R.[Phone]
				,(	SELECT	RC.Id AS [Id]
				,RC.[Name] AS [Name]
					FROM [dbo].[Resources] AS RS
					INNER JOIN [dbo].[ResourcesAndCategories] AS RAC
					ON RS.[Id] = RAC.[ResourceId] AND RS.[Id] = R.[Id]
					INNER JOIN [dbo].[ResourcesCategories] as RC
					ON RAC. [ResourceCategoryId] = RC.[Id]
					FOR JSON AUTO
						) AS Categories



				FROM ResourcesAndCategories AS RC
						JOIN dbo.SurveyAnswers AS Answers
					ON  RC.[ResourceCategoryId] = 6
						JOIN dbo.Resources AS R
					ON RC.ResourceId = R.Id
						JOIN [dbo].[BusinessTypes] AS BT
					ON R.BusinessTypeId = BT.[Id]
						JOIN[dbo].[IndustryTypes] AS IT
					ON IT.Id = R.IndustryTypeId

		WHERE   Answers.InstanceId = @SurveyInstanceId AND Answers.AnswerOptionId = @AnsweredId

END
--*******************************************************************************************************
-- DO CHECK BASED ON ASWER ID for option NO.6
	ELSE IF (@AnsweredId) = 62

BEGIN

		SELECT   R.[Id]
				,R.[CompanyName]
				,R.[Description]
				,R.[ContactName]
				,R.[ContactEmail]
				,BT.[Name] AS [BusinessTypeName]
				,IT.[Name] AS [IndustryTypeName]
				,R.[ImageUrl]
				,R.[SiteUrl]
				,R.[Phone]
				,(	SELECT	RC.Id AS [Id]
				,RC.[Name] AS [Name]
					FROM [dbo].[Resources] AS RS
					INNER JOIN [dbo].[ResourcesAndCategories] AS RAC
					ON RS.[Id] = RAC.[ResourceId] AND RS.[Id] = R.[Id]
					INNER JOIN [dbo].[ResourcesCategories] as RC
					ON RAC. [ResourceCategoryId] = RC.[Id]
					FOR JSON AUTO
						) AS Categories

				FROM ResourcesAndCategories AS RC
						JOIN dbo.SurveyAnswers AS Answers
					ON  RC.[ResourceCategoryId] = 7

						JOIN dbo.Resources AS R
					ON RC.ResourceId = R.Id
						JOIN [dbo].[BusinessTypes] AS BT
					ON R.BusinessTypeId = BT.[Id]
						JOIN[dbo].[IndustryTypes] AS IT
					ON IT.Id = R.IndustryTypeId

		WHERE   Answers.InstanceId = @SurveyInstanceId AND Answers.AnswerOptionId = @AnsweredId

END

END





