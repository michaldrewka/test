CREATE TABLE [dbo].[Persons]
(
[ID] [int] NOT NULL,
[LastName] [varchar] (255) COLLATE Latin1_General_CI_AS NOT NULL,
[FirstName] [varchar] (255) COLLATE Latin1_General_CI_AS NULL,
[Age] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Persons] ADD CONSTRAINT [PK__Persons__3214EC27981054E8] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
