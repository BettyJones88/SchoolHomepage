USE [SchoolHomepage]
GO
/****** Object:  StoredProcedure [dbo].[News_Search_By_Title_And_Article]    Script Date: 2014/12/16 21:39:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[News_Search_By_Title_And_Article]
	-- Add the parameters for the stored procedure here
	@Page_Size int,
	@Page_Request int,
	@Search_Content nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @Page_Whole INTEGER,
			@Page_Now INTEGER,
			@Row_Count REAL;
	SET @Page_Whole = @Page_Size * @Page_Request;
	SET @Page_Now = @Page_Whole - @Page_Size;
    
    -- Insert statements for procedure here
    
    SELECT * 
    FROM(
		SELECT ROW_NUMBER() OVER (ORDER BY GETDATE()) row_id, * 
		FROM(
			SELECT TOP (@Page_Whole) * FROM dbo.news WHERE article LIKE '%'+@Search_Content+'%' OR title LIKE '%'+@Search_Content+'%' ORDER BY update_time DESC
		)Temp_Row_01
    )Temp_Row_02
    WHERE row_id > @Page_Now

END
