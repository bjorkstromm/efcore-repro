CREATE TABLE [Repro].[Item]
(
    [Id]          INT                 IDENTITY(1,1),
    [PathId]      INT                 NULL,
    [Name]        NVARCHAR(32)        NULL,

    CONSTRAINT PK_Repro_Item PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT FK_Repro_Item_Path FOREIGN KEY ([PathId]) REFERENCES [Repro].[Path]([Id])
)