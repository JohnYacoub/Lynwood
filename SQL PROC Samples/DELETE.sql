USE [C74_Lynwood]
GO
/****** Object:  StoredProcedure [dbo].[Entrepreneurs_Delete]    Script Date: 6/23/2019 10:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROC [dbo].[Entrepreneurs_Delete]
		@Id INT
AS
/*

	DECLARE @Id INT = 5

	SELECT * 
	FROM dbo.Entrepreneurs
	WHERE Id = @Id;

	EXEC. dbo.Entrepreneurs_Delete @Id

	SELECT * 
	FROM dbo.Entrepreneurs
	WHERE Id = @Id;

*/

BEGIN

	DELETE 
	FROM [dbo].[Entrepreneurs]
	WHERE Id = @Id

END
