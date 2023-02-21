CREATE TABLE [Repro].[Path]
(
    [Id]            INT                 IDENTITY(1,1),
    [ParentId]      INT                 NULL,
    [Name]          NVARCHAR(32)        NULL,

    CONSTRAINT PK_Repro_Path PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT FK_Repro_Path FOREIGN KEY ([ParentId]) REFERENCES [Repro].[Path]([Id])
)