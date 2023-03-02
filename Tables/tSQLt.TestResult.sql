CREATE TABLE [tSQLt].[TestResult]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Class] [nvarchar] (max) COLLATE Danish_Greenlandic_100_CI_AI NOT NULL,
[TestCase] [nvarchar] (max) COLLATE Danish_Greenlandic_100_CI_AI NOT NULL,
[Name] AS ((quotename([Class])+'.')+quotename([TestCase])),
[TranName] [nvarchar] (max) COLLATE Danish_Greenlandic_100_CI_AI NOT NULL,
[Result] [nvarchar] (max) COLLATE Danish_Greenlandic_100_CI_AI NULL,
[Msg] [nvarchar] (max) COLLATE Danish_Greenlandic_100_CI_AI NULL,
[TestStartTime] [datetime] NOT NULL CONSTRAINT [DF:TestResult(TestStartTime)] DEFAULT (getdate()),
[TestEndTime] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [tSQLt].[TestResult] ADD CONSTRAINT [PK__TestResu__3214EC07C4957606] PRIMARY KEY CLUSTERED ([Id]) ON [PRIMARY]
GO
