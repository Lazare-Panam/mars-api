-- ============================================================================
-- Export products as Meilisearch documents (JSON) for the ONE `products` index.
-- (Like Panam's single index — series is a sidebar facet, not separate docs.)
-- HOW TO RUN (SSMS):
--   1. Results to TEXT (Ctrl+T) so the JSON comes out as one copyable string.
--   2. Run the query, copy the JSON array.
--   3. Meili → `products` index → "Add documents" → paste. One upload, done.
-- Each product carries a dynamic `attributes` array of every filter name->value it has,
-- so the sidebar builds a filter group for ANY filter (Series, End Connection, Lockable,
-- Size, ...) with no fixed column list.
-- ============================================================================

SELECT
    CAST(p.ProductId AS varchar(20))               AS id,          -- primary key
    p.PartNumber                                   AS partNumber,
    p.FamilyDescription                            AS series,
    c.Name                                         AS seriesName,   -- becomes the "Series" facet
    JSON_QUERY((
        SELECT f.Name AS [name], v.Value AS [value]
        FROM ProductFilterValues v
        JOIN Filters f ON f.FilterId = v.FilterId
        WHERE v.ProductId = p.ProductId
        ORDER BY f.Name
        FOR JSON PATH
    ))                                             AS attributes,  -- [{name,value},...] -> sidebar facets
    (SELECT STRING_AGG(v2.Value, ' ')
     FROM ProductFilterValues v2
     WHERE v2.ProductId = p.ProductId)             AS specs,       -- searchable catch-all
    p.ImageUrl                                     AS image,
    -- each product links to its OWN variant page, not the series configurator
    '/series/' + CAST(p.CategoryId AS varchar(20)) + '/variants/' + p.PartNumber AS href
FROM CatalogProducts p
JOIN Categories c ON c.CategoryId = p.CategoryId
WHERE p.ProductId IN (SELECT TOP (50) ProductId FROM CatalogProducts ORDER BY ProductId)
ORDER BY p.ProductId
FOR JSON PATH;
