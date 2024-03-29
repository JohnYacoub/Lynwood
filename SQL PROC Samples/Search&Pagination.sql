USE [C74_Lynwood]
GO
/****** Object:  StoredProcedure [dbo].[Files_Search_Paginated]    Script Date: 6/23/2019 10:43:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[Files_Search_Paginated]
			@Query NVARCHAR(100)
			,@pageIndex INT
			,@pageSize INT

AS
/*
			DECLARE
					@Query NVARCHAR(100) = 'linda'
					,@pageIndex INT = 0
					,@pageSize INT = 12

			EXEC.	dbo.Files_Search_Paginated
					@Query
					,@pageIndex
					,@pageSize
*/
BEGIN
	DECLARE @offset INT = @pageIndex * @pageSize
	SELECT	
			[Id]
			,[Name]
			,[Url]
			,[FileType]
			,[DateCreated]
			,[DateModified]
			,[CreatedBy]
			,[TotalCount] = COUNT(1) OVER()
	FROM	
			[dbo].[Files]
			WHERE ([Name] LIKE '%' + @Query + '%')
	ORDER BY Id DESC
	OFFSET @offset Rows
	Fetch Next @pageSize Rows ONLY
	
END