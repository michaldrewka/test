CREATE TABLE [tSQLt].[Private_Configurations]
(
[Name] [nvarchar] (100) COLLATE Danish_Greenlandic_100_CI_AI NOT NULL,
[Value] [sql_variant] NULL
) ON [PRIMARY]
GO
ALTER TABLE [tSQLt].[Private_Configurations] ADD CONSTRAINT [PK__Private___737584F782A7B744] PRIMARY KEY CLUSTERED ([Name]) ON [PRIMARY]
GO
