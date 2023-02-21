IF (SELECT COUNT(*) FROM [Repro].[Path]) = 0
BEGIN
    DECLARE @ParentId INT = NULL

    INSERT INTO [Repro].[Path] ([Name]) VALUES ('Foo')
    SET @ParentId = SCOPE_IDENTITY()

    INSERT INTO [Repro].[Item] ([Name], [PathId]) VALUES ('Item1', @ParentId)
    INSERT INTO [Repro].[Path] ([Name], [ParentId]) VALUES ('Bar', @ParentId)
    SET @ParentId = SCOPE_IDENTITY()

    INSERT INTO [Repro].[Item] ([Name], [PathId]) VALUES ('Item2', @ParentId)
    INSERT INTO [Repro].[Item] ([Name], [PathId]) VALUES ('Item3', @ParentId)
    INSERT INTO [Repro].[Path] ([Name], [ParentId]) VALUES ('Baz', @ParentId)
    SET @ParentId = SCOPE_IDENTITY()
    INSERT INTO [Repro].[Item] ([Name], [PathId]) VALUES ('Item4', @ParentId)
    INSERT INTO [Repro].[Item] ([Name], [PathId]) VALUES ('Item5', @ParentId)

    INSERT INTO [Repro].[Path] ([Name]) VALUES ('Tri')
    SET @ParentId = SCOPE_IDENTITY()

    INSERT INTO [Repro].[Item] ([Name], [PathId]) VALUES ('Item6', @ParentId)
    INSERT INTO [Repro].[Path] ([Name], [ParentId]) VALUES ('Tra', @ParentId)
    INSERT INTO [Repro].[Path] ([Name], [ParentId]) VALUES ('Tre', @ParentId)
    SET @ParentId = SCOPE_IDENTITY()

    INSERT INTO [Repro].[Item] ([Name], [PathId]) VALUES ('Item7', @ParentId)
    INSERT INTO [Repro].[Item] ([Name], [PathId]) VALUES ('Item8', @ParentId)

    INSERT INTO [Repro].[Path] ([Name], [ParentId]) VALUES ('Tro', @ParentId)
    SET @ParentId = SCOPE_IDENTITY()

    INSERT INTO [Repro].[Item] ([Name], [PathId]) VALUES ('Item9', @ParentId)
    INSERT INTO [Repro].[Item] ([Name], [PathId]) VALUES ('Item10', @ParentId)

END