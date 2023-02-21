CREATE FUNCTION [Repro].[GetPaths]
(
    @Id INT = null
)
RETURNS TABLE
AS
RETURN
(
    WITH CTE AS
    (
        SELECT P.[Id],
            P.[ParentId],
            P.[Name],
            CAST(P.[Name] AS NVARCHAR(MAX)) AS [FullName]
        FROM [Repro].[Path] AS P
        WHERE
            (@Id is null AND P.ParentId is null)
            OR (P.Id = @Id)

        UNION ALL

        SELECT P.[Id],
            P.[ParentId],
            P.[Name],
            CAST(CONCAT(C.[FullName], ' / ', P.[Name]) AS NVARCHAR(MAX)) AS [FullName]
        FROM [Repro].[Path] AS P
        INNER JOIN CTE AS C ON C.Id = P.ParentId
    )

    SELECT * FROM CTE
)