SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE   VIEW [dbo].[v_tablyyyyy_text]
AS
SELECT *
FROM tablyyyyy
WHERE text = N'TextVariable''s value'
GO
