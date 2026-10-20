-- Series F10-30 + F10-50 + F10-60 (quote-only one-piece). Run from file (SSMS: File > Open > Execute).
-- GO separators split the batches; just run the whole file.

-- ===== Series F10-30 (24 products, quote-only Price NULL) =====
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series F10-30')
    INSERT INTO Categories (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures)
    VALUES (N'Series F10-30', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'The Mars Series F10-30 is a one-piece, reduced-port ball valve with threaded ends, rated to 1000 PSI. CF8M or WCB body with PTFE, RTFE or TFM1600 seats, in sizes 1/4" to 2".', N'CF8M / WCB', N'PTFE / RTFE / TFM1600', N'One Piece, Reduced Port', N'One-piece reduced port design
Threaded ends (NPT, BSP, BSPT)
Rated to 1000 PSI
CF8M or WCB body
PTFE / RTFE / TFM1600 seats
Size 1/4" to 2"');
GO
DECLARE @SeriesName nvarchar(100) = N'Series F10-30';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);
INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'End Connection'),(N'Operating Pressure')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);
INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'End Connection',0),(N'Size',1),(N'Operating Pressure',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);
INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VF10-30-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F10-30 One Piece Ball Valve', N'VF10-30 - One Piece Reduced Port Ball Valve, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-30.png', NULL),
(N'VF10-30-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F10-30 One Piece Ball Valve', N'VF10-30 - One Piece Reduced Port Ball Valve, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-30.png', NULL),
(N'VF10-30-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-30 One Piece Ball Valve', N'VF10-30 - One Piece Reduced Port Ball Valve, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-30.png', NULL),
(N'VF10-30-3-8IN-NPT', @CategoryId, N'Active', N'Mars Series F10-30 One Piece Ball Valve', N'VF10-30 - One Piece Reduced Port Ball Valve, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 3/8", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-30.png', NULL),
(N'VF10-30-3-8IN-BSP', @CategoryId, N'Active', N'Mars Series F10-30 One Piece Ball Valve', N'VF10-30 - One Piece Reduced Port Ball Valve, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 3/8", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-30.png', NULL),
(N'VF10-30-3-8IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-30 One Piece Ball Valve', N'VF10-30 - One Piece Reduced Port Ball Valve, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 3/8", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-30.png', NULL),
(N'VF10-30-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F10-30 One Piece Ball Valve', N'VF10-30 - One Piece Reduced Port Ball Valve, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-30.png', NULL),
(N'VF10-30-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F10-30 One Piece Ball Valve', N'VF10-30 - One Piece Reduced Port Ball Valve, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-30.png', NULL),
(N'VF10-30-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-30 One Piece Ball Valve', N'VF10-30 - One Piece Reduced Port Ball Valve, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-30.png', NULL),
(N'VF10-30-3-4IN-NPT', @CategoryId, N'Active', N'Mars Series F10-30 One Piece Ball Valve', N'VF10-30 - One Piece Reduced Port Ball Valve, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 3/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-30.png', NULL),
(N'VF10-30-3-4IN-BSP', @CategoryId, N'Active', N'Mars Series F10-30 One Piece Ball Valve', N'VF10-30 - One Piece Reduced Port Ball Valve, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 3/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-30.png', NULL),
(N'VF10-30-3-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-30 One Piece Ball Valve', N'VF10-30 - One Piece Reduced Port Ball Valve, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 3/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-30.png', NULL),
(N'VF10-30-1IN-NPT', @CategoryId, N'Active', N'Mars Series F10-30 One Piece Ball Valve', N'VF10-30 - One Piece Reduced Port Ball Valve, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-30.png', NULL),
(N'VF10-30-1IN-BSP', @CategoryId, N'Active', N'Mars Series F10-30 One Piece Ball Valve', N'VF10-30 - One Piece Reduced Port Ball Valve, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-30.png', NULL),
(N'VF10-30-1IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-30 One Piece Ball Valve', N'VF10-30 - One Piece Reduced Port Ball Valve, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-30.png', NULL),
(N'VF10-30-1-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F10-30 One Piece Ball Valve', N'VF10-30 - One Piece Reduced Port Ball Valve, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-30.png', NULL),
(N'VF10-30-1-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F10-30 One Piece Ball Valve', N'VF10-30 - One Piece Reduced Port Ball Valve, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-30.png', NULL),
(N'VF10-30-1-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-30 One Piece Ball Valve', N'VF10-30 - One Piece Reduced Port Ball Valve, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-30.png', NULL),
(N'VF10-30-1-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F10-30 One Piece Ball Valve', N'VF10-30 - One Piece Reduced Port Ball Valve, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-30.png', NULL),
(N'VF10-30-1-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F10-30 One Piece Ball Valve', N'VF10-30 - One Piece Reduced Port Ball Valve, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-30.png', NULL),
(N'VF10-30-1-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-30 One Piece Ball Valve', N'VF10-30 - One Piece Reduced Port Ball Valve, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-30.png', NULL),
(N'VF10-30-2IN-NPT', @CategoryId, N'Active', N'Mars Series F10-30 One Piece Ball Valve', N'VF10-30 - One Piece Reduced Port Ball Valve, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-30.png', NULL),
(N'VF10-30-2IN-BSP', @CategoryId, N'Active', N'Mars Series F10-30 One Piece Ball Valve', N'VF10-30 - One Piece Reduced Port Ball Valve, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-30.png', NULL),
(N'VF10-30-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-30 One Piece Ball Valve', N'VF10-30 - One Piece Reduced Port Ball Valve, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-30.png', NULL);
INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VF10-30-1-4IN-NPT',N'Size',N'1/4"'),(N'VF10-30-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF10-30-1-4IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-30-1-4IN-BSP',N'Size',N'1/4"'),(N'VF10-30-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF10-30-1-4IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-30-1-4IN-BSPT',N'Size',N'1/4"'),(N'VF10-30-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-30-1-4IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-30-3-8IN-NPT',N'Size',N'3/8"'),(N'VF10-30-3-8IN-NPT',N'End Connection',N'NPT'),(N'VF10-30-3-8IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-30-3-8IN-BSP',N'Size',N'3/8"'),(N'VF10-30-3-8IN-BSP',N'End Connection',N'BSP'),(N'VF10-30-3-8IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-30-3-8IN-BSPT',N'Size',N'3/8"'),(N'VF10-30-3-8IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-30-3-8IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-30-1-2IN-NPT',N'Size',N'1/2"'),(N'VF10-30-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF10-30-1-2IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-30-1-2IN-BSP',N'Size',N'1/2"'),(N'VF10-30-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF10-30-1-2IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-30-1-2IN-BSPT',N'Size',N'1/2"'),(N'VF10-30-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-30-1-2IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-30-3-4IN-NPT',N'Size',N'3/4"'),(N'VF10-30-3-4IN-NPT',N'End Connection',N'NPT'),(N'VF10-30-3-4IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-30-3-4IN-BSP',N'Size',N'3/4"'),(N'VF10-30-3-4IN-BSP',N'End Connection',N'BSP'),(N'VF10-30-3-4IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-30-3-4IN-BSPT',N'Size',N'3/4"'),(N'VF10-30-3-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-30-3-4IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-30-1IN-NPT',N'Size',N'1"'),(N'VF10-30-1IN-NPT',N'End Connection',N'NPT'),(N'VF10-30-1IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-30-1IN-BSP',N'Size',N'1"'),(N'VF10-30-1IN-BSP',N'End Connection',N'BSP'),(N'VF10-30-1IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-30-1IN-BSPT',N'Size',N'1"'),(N'VF10-30-1IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-30-1IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-30-1-1-4IN-NPT',N'Size',N'1 1/4"'),(N'VF10-30-1-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF10-30-1-1-4IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-30-1-1-4IN-BSP',N'Size',N'1 1/4"'),(N'VF10-30-1-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF10-30-1-1-4IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-30-1-1-4IN-BSPT',N'Size',N'1 1/4"'),(N'VF10-30-1-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-30-1-1-4IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-30-1-1-2IN-NPT',N'Size',N'1 1/2"'),(N'VF10-30-1-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF10-30-1-1-2IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-30-1-1-2IN-BSP',N'Size',N'1 1/2"'),(N'VF10-30-1-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF10-30-1-1-2IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-30-1-1-2IN-BSPT',N'Size',N'1 1/2"'),(N'VF10-30-1-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-30-1-1-2IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-30-2IN-NPT',N'Size',N'2"'),(N'VF10-30-2IN-NPT',N'End Connection',N'NPT'),(N'VF10-30-2IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-30-2IN-BSP',N'Size',N'2"'),(N'VF10-30-2IN-BSP',N'End Connection',N'BSP'),(N'VF10-30-2IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-30-2IN-BSPT',N'Size',N'2"'),(N'VF10-30-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-30-2IN-BSPT',N'Operating Pressure',N'1000 PSI')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;
SELECT N'Series F10-30' AS Series, COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
GO

-- ===== Series F10-50 (24 products, quote-only Price NULL) =====
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series F10-50')
    INSERT INTO Categories (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures)
    VALUES (N'Series F10-50', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'The Mars Series F10-50 is a one-piece, reduced-port ball valve with threaded ends, rated to 2000 PSI. CF8M body with PTFE or RTFE seats, in sizes 1/4" to 2".', N'CF8M', N'PTFE / RTFE', N'One Piece, Reduced Port', N'One-piece reduced port design
Threaded ends (NPT, BSP, BSPT)
Rated to 2000 PSI
CF8M body
PTFE / RTFE seats
Size 1/4" to 2"');
GO
DECLARE @SeriesName nvarchar(100) = N'Series F10-50';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);
INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'End Connection'),(N'Operating Pressure')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);
INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'End Connection',0),(N'Size',1),(N'Operating Pressure',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);
INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VF10-50-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F10-50 One Piece Ball Valve', N'VF10-50 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M, Seat PTFE / RTFE, 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-50.png', NULL),
(N'VF10-50-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F10-50 One Piece Ball Valve', N'VF10-50 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M, Seat PTFE / RTFE, 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-50.png', NULL),
(N'VF10-50-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-50 One Piece Ball Valve', N'VF10-50 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M, Seat PTFE / RTFE, 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-50.png', NULL),
(N'VF10-50-3-8IN-NPT', @CategoryId, N'Active', N'Mars Series F10-50 One Piece Ball Valve', N'VF10-50 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M, Seat PTFE / RTFE, 3/8", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-50.png', NULL),
(N'VF10-50-3-8IN-BSP', @CategoryId, N'Active', N'Mars Series F10-50 One Piece Ball Valve', N'VF10-50 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M, Seat PTFE / RTFE, 3/8", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-50.png', NULL),
(N'VF10-50-3-8IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-50 One Piece Ball Valve', N'VF10-50 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M, Seat PTFE / RTFE, 3/8", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-50.png', NULL),
(N'VF10-50-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F10-50 One Piece Ball Valve', N'VF10-50 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M, Seat PTFE / RTFE, 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-50.png', NULL),
(N'VF10-50-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F10-50 One Piece Ball Valve', N'VF10-50 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M, Seat PTFE / RTFE, 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-50.png', NULL),
(N'VF10-50-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-50 One Piece Ball Valve', N'VF10-50 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M, Seat PTFE / RTFE, 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-50.png', NULL),
(N'VF10-50-3-4IN-NPT', @CategoryId, N'Active', N'Mars Series F10-50 One Piece Ball Valve', N'VF10-50 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M, Seat PTFE / RTFE, 3/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-50.png', NULL),
(N'VF10-50-3-4IN-BSP', @CategoryId, N'Active', N'Mars Series F10-50 One Piece Ball Valve', N'VF10-50 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M, Seat PTFE / RTFE, 3/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-50.png', NULL),
(N'VF10-50-3-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-50 One Piece Ball Valve', N'VF10-50 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M, Seat PTFE / RTFE, 3/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-50.png', NULL),
(N'VF10-50-1IN-NPT', @CategoryId, N'Active', N'Mars Series F10-50 One Piece Ball Valve', N'VF10-50 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M, Seat PTFE / RTFE, 1", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-50.png', NULL),
(N'VF10-50-1IN-BSP', @CategoryId, N'Active', N'Mars Series F10-50 One Piece Ball Valve', N'VF10-50 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M, Seat PTFE / RTFE, 1", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-50.png', NULL),
(N'VF10-50-1IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-50 One Piece Ball Valve', N'VF10-50 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M, Seat PTFE / RTFE, 1", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-50.png', NULL),
(N'VF10-50-1-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F10-50 One Piece Ball Valve', N'VF10-50 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M, Seat PTFE / RTFE, 1 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-50.png', NULL),
(N'VF10-50-1-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F10-50 One Piece Ball Valve', N'VF10-50 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M, Seat PTFE / RTFE, 1 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-50.png', NULL),
(N'VF10-50-1-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-50 One Piece Ball Valve', N'VF10-50 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M, Seat PTFE / RTFE, 1 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-50.png', NULL),
(N'VF10-50-1-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F10-50 One Piece Ball Valve', N'VF10-50 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M, Seat PTFE / RTFE, 1 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-50.png', NULL),
(N'VF10-50-1-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F10-50 One Piece Ball Valve', N'VF10-50 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M, Seat PTFE / RTFE, 1 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-50.png', NULL),
(N'VF10-50-1-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-50 One Piece Ball Valve', N'VF10-50 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M, Seat PTFE / RTFE, 1 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-50.png', NULL),
(N'VF10-50-2IN-NPT', @CategoryId, N'Active', N'Mars Series F10-50 One Piece Ball Valve', N'VF10-50 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M, Seat PTFE / RTFE, 2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-50.png', NULL),
(N'VF10-50-2IN-BSP', @CategoryId, N'Active', N'Mars Series F10-50 One Piece Ball Valve', N'VF10-50 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M, Seat PTFE / RTFE, 2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-50.png', NULL),
(N'VF10-50-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-50 One Piece Ball Valve', N'VF10-50 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M, Seat PTFE / RTFE, 2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-50.png', NULL);
INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VF10-50-1-4IN-NPT',N'Size',N'1/4"'),(N'VF10-50-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF10-50-1-4IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-50-1-4IN-BSP',N'Size',N'1/4"'),(N'VF10-50-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF10-50-1-4IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-50-1-4IN-BSPT',N'Size',N'1/4"'),(N'VF10-50-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-50-1-4IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-50-3-8IN-NPT',N'Size',N'3/8"'),(N'VF10-50-3-8IN-NPT',N'End Connection',N'NPT'),(N'VF10-50-3-8IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-50-3-8IN-BSP',N'Size',N'3/8"'),(N'VF10-50-3-8IN-BSP',N'End Connection',N'BSP'),(N'VF10-50-3-8IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-50-3-8IN-BSPT',N'Size',N'3/8"'),(N'VF10-50-3-8IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-50-3-8IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-50-1-2IN-NPT',N'Size',N'1/2"'),(N'VF10-50-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF10-50-1-2IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-50-1-2IN-BSP',N'Size',N'1/2"'),(N'VF10-50-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF10-50-1-2IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-50-1-2IN-BSPT',N'Size',N'1/2"'),(N'VF10-50-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-50-1-2IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-50-3-4IN-NPT',N'Size',N'3/4"'),(N'VF10-50-3-4IN-NPT',N'End Connection',N'NPT'),(N'VF10-50-3-4IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-50-3-4IN-BSP',N'Size',N'3/4"'),(N'VF10-50-3-4IN-BSP',N'End Connection',N'BSP'),(N'VF10-50-3-4IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-50-3-4IN-BSPT',N'Size',N'3/4"'),(N'VF10-50-3-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-50-3-4IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-50-1IN-NPT',N'Size',N'1"'),(N'VF10-50-1IN-NPT',N'End Connection',N'NPT'),(N'VF10-50-1IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-50-1IN-BSP',N'Size',N'1"'),(N'VF10-50-1IN-BSP',N'End Connection',N'BSP'),(N'VF10-50-1IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-50-1IN-BSPT',N'Size',N'1"'),(N'VF10-50-1IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-50-1IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-50-1-1-4IN-NPT',N'Size',N'1 1/4"'),(N'VF10-50-1-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF10-50-1-1-4IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-50-1-1-4IN-BSP',N'Size',N'1 1/4"'),(N'VF10-50-1-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF10-50-1-1-4IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-50-1-1-4IN-BSPT',N'Size',N'1 1/4"'),(N'VF10-50-1-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-50-1-1-4IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-50-1-1-2IN-NPT',N'Size',N'1 1/2"'),(N'VF10-50-1-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF10-50-1-1-2IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-50-1-1-2IN-BSP',N'Size',N'1 1/2"'),(N'VF10-50-1-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF10-50-1-1-2IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-50-1-1-2IN-BSPT',N'Size',N'1 1/2"'),(N'VF10-50-1-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-50-1-1-2IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-50-2IN-NPT',N'Size',N'2"'),(N'VF10-50-2IN-NPT',N'End Connection',N'NPT'),(N'VF10-50-2IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-50-2IN-BSP',N'Size',N'2"'),(N'VF10-50-2IN-BSP',N'End Connection',N'BSP'),(N'VF10-50-2IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-50-2IN-BSPT',N'Size',N'2"'),(N'VF10-50-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-50-2IN-BSPT',N'Operating Pressure',N'2000 PSI')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;
SELECT N'Series F10-50' AS Series, COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
GO

-- ===== Series F10-60 (24 products, quote-only Price NULL) =====
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series F10-60')
    INSERT INTO Categories (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures, Approvals)
    VALUES (N'Series F10-60', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'The Mars Series F10-60 is a one-piece, reduced-port fire-safe ball valve with threaded ends, rated to 2000 PSI and certified to API 607 (4th Edition). CF8M or WCB body with PTFE or RTFE seats, in sizes 1/4" to 2".', N'CF8M / WCB', N'PTFE / RTFE', N'One Piece, Reduced Port, Fire-Safe', N'One-piece reduced port fire-safe design
Fire-safe certified API 607, 4th Edition
Threaded ends (NPT, BSP, BSPT)
Rated to 2000 PSI
CF8M or WCB body
PTFE / RTFE seats
Size 1/4" to 2"', N'Fire-Safe API 607, 4th Edition');
GO
DECLARE @SeriesName nvarchar(100) = N'Series F10-60';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);
INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'End Connection'),(N'Operating Pressure')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);
INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'End Connection',0),(N'Size',1),(N'Operating Pressure',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);
INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VF10-60-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F10-60 One Piece Ball Valve', N'VF10-60 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-60.jpg', NULL),
(N'VF10-60-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F10-60 One Piece Ball Valve', N'VF10-60 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-60.jpg', NULL),
(N'VF10-60-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-60 One Piece Ball Valve', N'VF10-60 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-60.jpg', NULL),
(N'VF10-60-3-8IN-NPT', @CategoryId, N'Active', N'Mars Series F10-60 One Piece Ball Valve', N'VF10-60 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-60.jpg', NULL),
(N'VF10-60-3-8IN-BSP', @CategoryId, N'Active', N'Mars Series F10-60 One Piece Ball Valve', N'VF10-60 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-60.jpg', NULL),
(N'VF10-60-3-8IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-60 One Piece Ball Valve', N'VF10-60 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-60.jpg', NULL),
(N'VF10-60-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F10-60 One Piece Ball Valve', N'VF10-60 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-60.jpg', NULL),
(N'VF10-60-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F10-60 One Piece Ball Valve', N'VF10-60 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-60.jpg', NULL),
(N'VF10-60-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-60 One Piece Ball Valve', N'VF10-60 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-60.jpg', NULL),
(N'VF10-60-3-4IN-NPT', @CategoryId, N'Active', N'Mars Series F10-60 One Piece Ball Valve', N'VF10-60 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-60.jpg', NULL),
(N'VF10-60-3-4IN-BSP', @CategoryId, N'Active', N'Mars Series F10-60 One Piece Ball Valve', N'VF10-60 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-60.jpg', NULL),
(N'VF10-60-3-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-60 One Piece Ball Valve', N'VF10-60 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-60.jpg', NULL),
(N'VF10-60-1IN-NPT', @CategoryId, N'Active', N'Mars Series F10-60 One Piece Ball Valve', N'VF10-60 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-60.jpg', NULL),
(N'VF10-60-1IN-BSP', @CategoryId, N'Active', N'Mars Series F10-60 One Piece Ball Valve', N'VF10-60 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-60.jpg', NULL),
(N'VF10-60-1IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-60 One Piece Ball Valve', N'VF10-60 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-60.jpg', NULL),
(N'VF10-60-1-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F10-60 One Piece Ball Valve', N'VF10-60 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-60.jpg', NULL),
(N'VF10-60-1-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F10-60 One Piece Ball Valve', N'VF10-60 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-60.jpg', NULL),
(N'VF10-60-1-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-60 One Piece Ball Valve', N'VF10-60 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-60.jpg', NULL),
(N'VF10-60-1-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F10-60 One Piece Ball Valve', N'VF10-60 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-60.jpg', NULL),
(N'VF10-60-1-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F10-60 One Piece Ball Valve', N'VF10-60 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-60.jpg', NULL),
(N'VF10-60-1-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-60 One Piece Ball Valve', N'VF10-60 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-60.jpg', NULL),
(N'VF10-60-2IN-NPT', @CategoryId, N'Active', N'Mars Series F10-60 One Piece Ball Valve', N'VF10-60 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-60.jpg', NULL),
(N'VF10-60-2IN-BSP', @CategoryId, N'Active', N'Mars Series F10-60 One Piece Ball Valve', N'VF10-60 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-60.jpg', NULL),
(N'VF10-60-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-60 One Piece Ball Valve', N'VF10-60 - One Piece Reduced Port Ball Valve, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-60.jpg', NULL);
INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VF10-60-1-4IN-NPT',N'Size',N'1/4"'),(N'VF10-60-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF10-60-1-4IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-60-1-4IN-BSP',N'Size',N'1/4"'),(N'VF10-60-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF10-60-1-4IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-60-1-4IN-BSPT',N'Size',N'1/4"'),(N'VF10-60-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-60-1-4IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-60-3-8IN-NPT',N'Size',N'3/8"'),(N'VF10-60-3-8IN-NPT',N'End Connection',N'NPT'),(N'VF10-60-3-8IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-60-3-8IN-BSP',N'Size',N'3/8"'),(N'VF10-60-3-8IN-BSP',N'End Connection',N'BSP'),(N'VF10-60-3-8IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-60-3-8IN-BSPT',N'Size',N'3/8"'),(N'VF10-60-3-8IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-60-3-8IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-60-1-2IN-NPT',N'Size',N'1/2"'),(N'VF10-60-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF10-60-1-2IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-60-1-2IN-BSP',N'Size',N'1/2"'),(N'VF10-60-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF10-60-1-2IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-60-1-2IN-BSPT',N'Size',N'1/2"'),(N'VF10-60-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-60-1-2IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-60-3-4IN-NPT',N'Size',N'3/4"'),(N'VF10-60-3-4IN-NPT',N'End Connection',N'NPT'),(N'VF10-60-3-4IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-60-3-4IN-BSP',N'Size',N'3/4"'),(N'VF10-60-3-4IN-BSP',N'End Connection',N'BSP'),(N'VF10-60-3-4IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-60-3-4IN-BSPT',N'Size',N'3/4"'),(N'VF10-60-3-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-60-3-4IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-60-1IN-NPT',N'Size',N'1"'),(N'VF10-60-1IN-NPT',N'End Connection',N'NPT'),(N'VF10-60-1IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-60-1IN-BSP',N'Size',N'1"'),(N'VF10-60-1IN-BSP',N'End Connection',N'BSP'),(N'VF10-60-1IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-60-1IN-BSPT',N'Size',N'1"'),(N'VF10-60-1IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-60-1IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-60-1-1-4IN-NPT',N'Size',N'1 1/4"'),(N'VF10-60-1-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF10-60-1-1-4IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-60-1-1-4IN-BSP',N'Size',N'1 1/4"'),(N'VF10-60-1-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF10-60-1-1-4IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-60-1-1-4IN-BSPT',N'Size',N'1 1/4"'),(N'VF10-60-1-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-60-1-1-4IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-60-1-1-2IN-NPT',N'Size',N'1 1/2"'),(N'VF10-60-1-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF10-60-1-1-2IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-60-1-1-2IN-BSP',N'Size',N'1 1/2"'),(N'VF10-60-1-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF10-60-1-1-2IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-60-1-1-2IN-BSPT',N'Size',N'1 1/2"'),(N'VF10-60-1-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-60-1-1-2IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-60-2IN-NPT',N'Size',N'2"'),(N'VF10-60-2IN-NPT',N'End Connection',N'NPT'),(N'VF10-60-2IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-60-2IN-BSP',N'Size',N'2"'),(N'VF10-60-2IN-BSP',N'End Connection',N'BSP'),(N'VF10-60-2IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF10-60-2IN-BSPT',N'Size',N'2"'),(N'VF10-60-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-60-2IN-BSPT',N'Operating Pressure',N'2000 PSI')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;
SELECT N'Series F10-60' AS Series, COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
GO
