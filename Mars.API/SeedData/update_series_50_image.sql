-- Series 50 was seeded with ImageUrl NULL (no image at the time). Set it now.
-- Run from file (SSMS: File > Open > Execute).
UPDATE CatalogProducts
SET ImageUrl = N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-50.jpg'
WHERE CategoryId = (SELECT CategoryId FROM Categories WHERE Name = N'Series 50');

SELECT COUNT(*) AS Updated
FROM CatalogProducts
WHERE CategoryId = (SELECT CategoryId FROM Categories WHERE Name = N'Series 50')
  AND ImageUrl IS NOT NULL;
