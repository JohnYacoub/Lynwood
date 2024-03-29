USE [C74_Lynwood]
GO
/****** Object:  StoredProcedure [dbo].[Entrepreneurs_Insert]    Script Date: 6/23/2019 10:41:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROC [dbo].[Entrepreneurs_Insert]
		@UserId INT
		,@IndustryTypeId INT
		,@CompanyStatusId INT
		,@HasSecurityClearance BIT
		,@HasInsurance BIT
		,@HasBonds BIT 
		,@SpecializedEquipment NVARCHAR(4000)
		,@ImageUrl NVARCHAR(255)
		,@Id INT OUTPUT
AS
/* 
	DECLARE 
			@Id INT = 0
			,@UserId INT = 12
			,@IndustryTypeId INT = 3
			,@CompanyStatusId INT = 3
			,@HasSecurityClearance BIT = 1
			,@HasInsurance BIT = 1
			,@HasBonds BIT = 1
			,@SpecializedEquipment NVARCHAR(4000) = 'Stuff'
			,@ImageUrl NVARCHAR(255) = 'null'

	EXEC dbo.Entrepreneurs_Insert 
			@UserId
			,@IndustryTypeId
			,@CompanyStatusId
			,@HasSecurityClearance
			,@HasInsurance
			,@HasBonds
			,@SpecializedEquipment
			,@ImageUrl
			,@Id OUTPUT

	SELECT @Id

	SELECT *
	FROM dbo.Entrepreneurs
	WHERE Id = @Id
*/
BEGIN
	INSERT INTO 
			[dbo].[Entrepreneurs](
			    [UserId]
			   ,[IndustryTypeId]
			   ,[CompanyStatusId]
			   ,[HasSecurityClearance]
			   ,[HasInsurance]
			   ,[HasBonds]
			   ,[SpecializedEquipment]
			   ,[ImageUrl]
		 )VALUES(
			    @UserId
			   ,@IndustryTypeId
			   ,@CompanyStatusId
			   ,@HasSecurityClearance
			   ,@HasInsurance
			   ,@HasBonds
			   ,@SpecializedEquipment
			   ,@ImageUrl
		);

	SET @Id = SCOPE_IDENTITY()
END