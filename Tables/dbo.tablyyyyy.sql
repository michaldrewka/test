CREATE TABLE [dbo].[tablyyyyy]
(
[id] [int] NULL,
[text] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'Nvarchar extended property', N'TextVariable''s value', 'SCHEMA', N'dbo', 'TABLE', N'tablyyyyy', NULL, NULL
GO
