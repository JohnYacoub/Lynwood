USE [C74_Lynwood]
GO
/****** Object:  StoredProcedure [dbo].[Entrepreneurs_Update]    Script Date: 6/23/2019 10:42:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROC [dbo].[Entrepreneurs_Update]
			@UserId INT
			,@IndustryTypeId INT
			,@CompanyStatusId INT
			,@HasSecurityClearance BIT
			,@HasInsurance BIT
			,@HasBonds BIT 
			,@SpecializedEquipment NVARCHAR(4000)
			,@ImageUrl NVARCHAR(255)
			,@Id INT 

AS
/* 
	DECLARE  
			 @Id INT = 10
			,@UserId INT = 12
			,@IndustryTypeId INT = 3
			,@CompanyStatusId INT = 3
			,@HasSecurityClearance BIT = 1
			,@HasInsurance BIT = 1
			,@HasBonds BIT = 1
			,@SpecializedEquipment NVARCHAR(4000) = 'Stuff'
			,@ImageUrl NVARCHAR(255) = 'null'

	SELECT *
	FROM dbo.Entrepreneurs
	WHERE Id = @Id

	EXEC dbo.Entrepreneurs_Update 
			@UserId
			,@IndustryTypeId
			,@CompanyStatusId
			,@HasSecurityClearance
			,@HasInsurance
			,@HasBonds
			,@SpecializedEquipment
			,@ImageUrl 
			,@Id 


	SELECT *
	FROM dbo.Entrepreneurs
	WHERE Id = @Id
*/
BEGIN

	DECLARE @DateModified DATETIME2(7) = GETUTCDATE();
	
	UPDATE [dbo].[Entrepreneurs]
	   SET [UserId] = @UserId
		  ,[IndustryTypeId] = @IndustryTypeId
		  ,[CompanyStatusId] = @CompanyStatusId
		  ,[HasSecurityClearance] = @HasSecurityClearance
		  ,[HasInsurance] = @HasInsurance
		  ,[HasBonds] = @HasBonds
		  ,[DateModified] = @DateModified
		  ,[SpecializedEquipment] = @SpecializedEquipment
		  ,[ImageUrl] = @ImageUrl
	 WHERE Id = @Id

END