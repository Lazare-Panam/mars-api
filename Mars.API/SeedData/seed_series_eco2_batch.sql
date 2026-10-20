-- Economical 2-piece quote-only batch: 20-30, F20B-2C, F20B-3C, F20-60.
-- (Series 20-40 already exists.) Run the whole file in SSMS; GO splits the batches.

-- ===== Series 20-30 (24 products, quote-only Price NULL) =====
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 20-30')
    INSERT INTO Categories (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures)
    VALUES (N'Series 20-30', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'The Mars Series 20-30 is a 2-piece, reduced-port ball valve with threaded ends, rated to 2000 PSI. CF8M or WCB body with PTFE/RTFE seats, in sizes 1/4" to 2". Optional locking and anti-static devices.', N'CF8M / WCB', N'PTFE / RTFE', N'Two Piece, Reduced Port', N'2-piece reduced port design
Threaded ends (NPT, BSP, BSPT)
Rated to 2000 PSI
CF8M or WCB body
PTFE / RTFE seats
Size 1/4" to 2"
Optional locking device
Optional anti-static device');
GO
DECLARE @SeriesName nvarchar(100) = N'Series 20-30';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);
INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'End Connection'),(N'Operating Pressure')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);
INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'End Connection',0),(N'Size',1),(N'Operating Pressure',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);
INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'V20-30-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series 20-30 Two Piece Ball Valve', N'V20-30 - 2-PC Ball Valve, Two Piece, Reduced Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-20-30.jpg', NULL),
(N'V20-30-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series 20-30 Two Piece Ball Valve', N'V20-30 - 2-PC Ball Valve, Two Piece, Reduced Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-20-30.jpg', NULL),
(N'V20-30-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series 20-30 Two Piece Ball Valve', N'V20-30 - 2-PC Ball Valve, Two Piece, Reduced Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-20-30.jpg', NULL),
(N'V20-30-3-8IN-NPT', @CategoryId, N'Active', N'Mars Series 20-30 Two Piece Ball Valve', N'V20-30 - 2-PC Ball Valve, Two Piece, Reduced Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-20-30.jpg', NULL),
(N'V20-30-3-8IN-BSP', @CategoryId, N'Active', N'Mars Series 20-30 Two Piece Ball Valve', N'V20-30 - 2-PC Ball Valve, Two Piece, Reduced Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-20-30.jpg', NULL),
(N'V20-30-3-8IN-BSPT', @CategoryId, N'Active', N'Mars Series 20-30 Two Piece Ball Valve', N'V20-30 - 2-PC Ball Valve, Two Piece, Reduced Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-20-30.jpg', NULL),
(N'V20-30-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series 20-30 Two Piece Ball Valve', N'V20-30 - 2-PC Ball Valve, Two Piece, Reduced Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-20-30.jpg', NULL),
(N'V20-30-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series 20-30 Two Piece Ball Valve', N'V20-30 - 2-PC Ball Valve, Two Piece, Reduced Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-20-30.jpg', NULL),
(N'V20-30-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series 20-30 Two Piece Ball Valve', N'V20-30 - 2-PC Ball Valve, Two Piece, Reduced Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-20-30.jpg', NULL),
(N'V20-30-3-4IN-NPT', @CategoryId, N'Active', N'Mars Series 20-30 Two Piece Ball Valve', N'V20-30 - 2-PC Ball Valve, Two Piece, Reduced Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-20-30.jpg', NULL),
(N'V20-30-3-4IN-BSP', @CategoryId, N'Active', N'Mars Series 20-30 Two Piece Ball Valve', N'V20-30 - 2-PC Ball Valve, Two Piece, Reduced Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-20-30.jpg', NULL),
(N'V20-30-3-4IN-BSPT', @CategoryId, N'Active', N'Mars Series 20-30 Two Piece Ball Valve', N'V20-30 - 2-PC Ball Valve, Two Piece, Reduced Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-20-30.jpg', NULL),
(N'V20-30-1IN-NPT', @CategoryId, N'Active', N'Mars Series 20-30 Two Piece Ball Valve', N'V20-30 - 2-PC Ball Valve, Two Piece, Reduced Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-20-30.jpg', NULL),
(N'V20-30-1IN-BSP', @CategoryId, N'Active', N'Mars Series 20-30 Two Piece Ball Valve', N'V20-30 - 2-PC Ball Valve, Two Piece, Reduced Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-20-30.jpg', NULL),
(N'V20-30-1IN-BSPT', @CategoryId, N'Active', N'Mars Series 20-30 Two Piece Ball Valve', N'V20-30 - 2-PC Ball Valve, Two Piece, Reduced Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-20-30.jpg', NULL),
(N'V20-30-1-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series 20-30 Two Piece Ball Valve', N'V20-30 - 2-PC Ball Valve, Two Piece, Reduced Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-20-30.jpg', NULL),
(N'V20-30-1-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series 20-30 Two Piece Ball Valve', N'V20-30 - 2-PC Ball Valve, Two Piece, Reduced Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-20-30.jpg', NULL),
(N'V20-30-1-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series 20-30 Two Piece Ball Valve', N'V20-30 - 2-PC Ball Valve, Two Piece, Reduced Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-20-30.jpg', NULL),
(N'V20-30-1-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series 20-30 Two Piece Ball Valve', N'V20-30 - 2-PC Ball Valve, Two Piece, Reduced Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-20-30.jpg', NULL),
(N'V20-30-1-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series 20-30 Two Piece Ball Valve', N'V20-30 - 2-PC Ball Valve, Two Piece, Reduced Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-20-30.jpg', NULL),
(N'V20-30-1-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series 20-30 Two Piece Ball Valve', N'V20-30 - 2-PC Ball Valve, Two Piece, Reduced Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-20-30.jpg', NULL),
(N'V20-30-2IN-NPT', @CategoryId, N'Active', N'Mars Series 20-30 Two Piece Ball Valve', N'V20-30 - 2-PC Ball Valve, Two Piece, Reduced Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-20-30.jpg', NULL),
(N'V20-30-2IN-BSP', @CategoryId, N'Active', N'Mars Series 20-30 Two Piece Ball Valve', N'V20-30 - 2-PC Ball Valve, Two Piece, Reduced Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-20-30.jpg', NULL),
(N'V20-30-2IN-BSPT', @CategoryId, N'Active', N'Mars Series 20-30 Two Piece Ball Valve', N'V20-30 - 2-PC Ball Valve, Two Piece, Reduced Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-20-30.jpg', NULL);
INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'V20-30-1-4IN-NPT',N'Size',N'1/4"'),(N'V20-30-1-4IN-NPT',N'End Connection',N'NPT'),(N'V20-30-1-4IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'V20-30-1-4IN-BSP',N'Size',N'1/4"'),(N'V20-30-1-4IN-BSP',N'End Connection',N'BSP'),(N'V20-30-1-4IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'V20-30-1-4IN-BSPT',N'Size',N'1/4"'),(N'V20-30-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'V20-30-1-4IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'V20-30-3-8IN-NPT',N'Size',N'3/8"'),(N'V20-30-3-8IN-NPT',N'End Connection',N'NPT'),(N'V20-30-3-8IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'V20-30-3-8IN-BSP',N'Size',N'3/8"'),(N'V20-30-3-8IN-BSP',N'End Connection',N'BSP'),(N'V20-30-3-8IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'V20-30-3-8IN-BSPT',N'Size',N'3/8"'),(N'V20-30-3-8IN-BSPT',N'End Connection',N'BSPT'),(N'V20-30-3-8IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'V20-30-1-2IN-NPT',N'Size',N'1/2"'),(N'V20-30-1-2IN-NPT',N'End Connection',N'NPT'),(N'V20-30-1-2IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'V20-30-1-2IN-BSP',N'Size',N'1/2"'),(N'V20-30-1-2IN-BSP',N'End Connection',N'BSP'),(N'V20-30-1-2IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'V20-30-1-2IN-BSPT',N'Size',N'1/2"'),(N'V20-30-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'V20-30-1-2IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'V20-30-3-4IN-NPT',N'Size',N'3/4"'),(N'V20-30-3-4IN-NPT',N'End Connection',N'NPT'),(N'V20-30-3-4IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'V20-30-3-4IN-BSP',N'Size',N'3/4"'),(N'V20-30-3-4IN-BSP',N'End Connection',N'BSP'),(N'V20-30-3-4IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'V20-30-3-4IN-BSPT',N'Size',N'3/4"'),(N'V20-30-3-4IN-BSPT',N'End Connection',N'BSPT'),(N'V20-30-3-4IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'V20-30-1IN-NPT',N'Size',N'1"'),(N'V20-30-1IN-NPT',N'End Connection',N'NPT'),(N'V20-30-1IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'V20-30-1IN-BSP',N'Size',N'1"'),(N'V20-30-1IN-BSP',N'End Connection',N'BSP'),(N'V20-30-1IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'V20-30-1IN-BSPT',N'Size',N'1"'),(N'V20-30-1IN-BSPT',N'End Connection',N'BSPT'),(N'V20-30-1IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'V20-30-1-1-4IN-NPT',N'Size',N'1 1/4"'),(N'V20-30-1-1-4IN-NPT',N'End Connection',N'NPT'),(N'V20-30-1-1-4IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'V20-30-1-1-4IN-BSP',N'Size',N'1 1/4"'),(N'V20-30-1-1-4IN-BSP',N'End Connection',N'BSP'),(N'V20-30-1-1-4IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'V20-30-1-1-4IN-BSPT',N'Size',N'1 1/4"'),(N'V20-30-1-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'V20-30-1-1-4IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'V20-30-1-1-2IN-NPT',N'Size',N'1 1/2"'),(N'V20-30-1-1-2IN-NPT',N'End Connection',N'NPT'),(N'V20-30-1-1-2IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'V20-30-1-1-2IN-BSP',N'Size',N'1 1/2"'),(N'V20-30-1-1-2IN-BSP',N'End Connection',N'BSP'),(N'V20-30-1-1-2IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'V20-30-1-1-2IN-BSPT',N'Size',N'1 1/2"'),(N'V20-30-1-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'V20-30-1-1-2IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'V20-30-2IN-NPT',N'Size',N'2"'),(N'V20-30-2IN-NPT',N'End Connection',N'NPT'),(N'V20-30-2IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'V20-30-2IN-BSP',N'Size',N'2"'),(N'V20-30-2IN-BSP',N'End Connection',N'BSP'),(N'V20-30-2IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'V20-30-2IN-BSPT',N'Size',N'2"'),(N'V20-30-2IN-BSPT',N'End Connection',N'BSPT'),(N'V20-30-2IN-BSPT',N'Operating Pressure',N'2000 PSI')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;
SELECT N'Series 20-30' AS Series, COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
GO

-- ===== Series F20B-2C (33 products, quote-only Price NULL) =====
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series F20B-2C')
    INSERT INTO Categories (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures)
    VALUES (N'Series F20B-2C', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'The Mars Series F20B-2C is a 2-piece, full-port B16.34 ball valve with threaded ends, rated to 1000 PSI. CF8M or WCB body with PTFE/RTFE seats, in sizes 1/4" to 4".', N'CF8M / WCB', N'PTFE / RTFE', N'Two Piece, B16.34, Full Port', N'2-piece full port B16.34 design
Threaded ends (NPT, BSP, BSPT)
Rated to 1000 PSI
CF8M or WCB body
PTFE / RTFE seats
Size 1/4" to 4"');
GO
DECLARE @SeriesName nvarchar(100) = N'Series F20B-2C';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);
INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'End Connection'),(N'Operating Pressure')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);
INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'End Connection',0),(N'Size',1),(N'Operating Pressure',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);
INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VF20B-2C-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-3-8IN-NPT', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-3-8IN-BSP', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-3-8IN-BSPT', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-3-4IN-NPT', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-3-4IN-BSP', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-3-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-1IN-NPT', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-1IN-BSP', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-1IN-BSPT', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-1-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-1-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-1-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-1-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-1-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-1-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-2IN-NPT', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-2IN-BSP', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-2-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-2-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-2-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-3IN-NPT', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-3IN-BSP', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-3IN-BSPT', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-4IN-NPT', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-4IN-BSP', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL),
(N'VF20B-2C-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F20B-2C Two Piece Ball Valve', N'VF20B-2C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-2c.jpg', NULL);
INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VF20B-2C-1-4IN-NPT',N'Size',N'1/4"'),(N'VF20B-2C-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF20B-2C-1-4IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-1-4IN-BSP',N'Size',N'1/4"'),(N'VF20B-2C-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF20B-2C-1-4IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-1-4IN-BSPT',N'Size',N'1/4"'),(N'VF20B-2C-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF20B-2C-1-4IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-3-8IN-NPT',N'Size',N'3/8"'),(N'VF20B-2C-3-8IN-NPT',N'End Connection',N'NPT'),(N'VF20B-2C-3-8IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-3-8IN-BSP',N'Size',N'3/8"'),(N'VF20B-2C-3-8IN-BSP',N'End Connection',N'BSP'),(N'VF20B-2C-3-8IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-3-8IN-BSPT',N'Size',N'3/8"'),(N'VF20B-2C-3-8IN-BSPT',N'End Connection',N'BSPT'),(N'VF20B-2C-3-8IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-1-2IN-NPT',N'Size',N'1/2"'),(N'VF20B-2C-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF20B-2C-1-2IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-1-2IN-BSP',N'Size',N'1/2"'),(N'VF20B-2C-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF20B-2C-1-2IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-1-2IN-BSPT',N'Size',N'1/2"'),(N'VF20B-2C-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF20B-2C-1-2IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-3-4IN-NPT',N'Size',N'3/4"'),(N'VF20B-2C-3-4IN-NPT',N'End Connection',N'NPT'),(N'VF20B-2C-3-4IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-3-4IN-BSP',N'Size',N'3/4"'),(N'VF20B-2C-3-4IN-BSP',N'End Connection',N'BSP'),(N'VF20B-2C-3-4IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-3-4IN-BSPT',N'Size',N'3/4"'),(N'VF20B-2C-3-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF20B-2C-3-4IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-1IN-NPT',N'Size',N'1"'),(N'VF20B-2C-1IN-NPT',N'End Connection',N'NPT'),(N'VF20B-2C-1IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-1IN-BSP',N'Size',N'1"'),(N'VF20B-2C-1IN-BSP',N'End Connection',N'BSP'),(N'VF20B-2C-1IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-1IN-BSPT',N'Size',N'1"'),(N'VF20B-2C-1IN-BSPT',N'End Connection',N'BSPT'),(N'VF20B-2C-1IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-1-1-4IN-NPT',N'Size',N'1 1/4"'),(N'VF20B-2C-1-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF20B-2C-1-1-4IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-1-1-4IN-BSP',N'Size',N'1 1/4"'),(N'VF20B-2C-1-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF20B-2C-1-1-4IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-1-1-4IN-BSPT',N'Size',N'1 1/4"'),(N'VF20B-2C-1-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF20B-2C-1-1-4IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-1-1-2IN-NPT',N'Size',N'1 1/2"'),(N'VF20B-2C-1-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF20B-2C-1-1-2IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-1-1-2IN-BSP',N'Size',N'1 1/2"'),(N'VF20B-2C-1-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF20B-2C-1-1-2IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-1-1-2IN-BSPT',N'Size',N'1 1/2"'),(N'VF20B-2C-1-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF20B-2C-1-1-2IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-2IN-NPT',N'Size',N'2"'),(N'VF20B-2C-2IN-NPT',N'End Connection',N'NPT'),(N'VF20B-2C-2IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-2IN-BSP',N'Size',N'2"'),(N'VF20B-2C-2IN-BSP',N'End Connection',N'BSP'),(N'VF20B-2C-2IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-2IN-BSPT',N'Size',N'2"'),(N'VF20B-2C-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF20B-2C-2IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-2-1-2IN-NPT',N'Size',N'2 1/2"'),(N'VF20B-2C-2-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF20B-2C-2-1-2IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-2-1-2IN-BSP',N'Size',N'2 1/2"'),(N'VF20B-2C-2-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF20B-2C-2-1-2IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-2-1-2IN-BSPT',N'Size',N'2 1/2"'),(N'VF20B-2C-2-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF20B-2C-2-1-2IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-3IN-NPT',N'Size',N'3"'),(N'VF20B-2C-3IN-NPT',N'End Connection',N'NPT'),(N'VF20B-2C-3IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-3IN-BSP',N'Size',N'3"'),(N'VF20B-2C-3IN-BSP',N'End Connection',N'BSP'),(N'VF20B-2C-3IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-3IN-BSPT',N'Size',N'3"'),(N'VF20B-2C-3IN-BSPT',N'End Connection',N'BSPT'),(N'VF20B-2C-3IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-4IN-NPT',N'Size',N'4"'),(N'VF20B-2C-4IN-NPT',N'End Connection',N'NPT'),(N'VF20B-2C-4IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-4IN-BSP',N'Size',N'4"'),(N'VF20B-2C-4IN-BSP',N'End Connection',N'BSP'),(N'VF20B-2C-4IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF20B-2C-4IN-BSPT',N'Size',N'4"'),(N'VF20B-2C-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF20B-2C-4IN-BSPT',N'Operating Pressure',N'1000 PSI')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;
SELECT N'Series F20B-2C' AS Series, COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
GO

-- ===== Series F20B-3C (24 products, quote-only Price NULL) =====
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series F20B-3C')
    INSERT INTO Categories (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures)
    VALUES (N'Series F20B-3C', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'The Mars Series F20B-3C is a 2-piece, full-port B16.34 ball valve with threaded ends, rated to 2000 PSI. CF8M or WCB body with PTFE/RTFE seats, in sizes 1/4" to 2".', N'CF8M / WCB', N'PTFE / RTFE', N'Two Piece, B16.34, Full Port', N'2-piece full port B16.34 design
Threaded ends (NPT, BSP, BSPT)
Rated to 2000 PSI
CF8M or WCB body
PTFE / RTFE seats
Size 1/4" to 2"');
GO
DECLARE @SeriesName nvarchar(100) = N'Series F20B-3C';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);
INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'End Connection'),(N'Operating Pressure')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);
INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'End Connection',0),(N'Size',1),(N'Operating Pressure',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);
INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VF20B-3C-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F20B-3C Two Piece Ball Valve', N'VF20B-3C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-3c.jpg', NULL),
(N'VF20B-3C-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F20B-3C Two Piece Ball Valve', N'VF20B-3C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-3c.jpg', NULL),
(N'VF20B-3C-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F20B-3C Two Piece Ball Valve', N'VF20B-3C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-3c.jpg', NULL),
(N'VF20B-3C-3-8IN-NPT', @CategoryId, N'Active', N'Mars Series F20B-3C Two Piece Ball Valve', N'VF20B-3C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-3c.jpg', NULL),
(N'VF20B-3C-3-8IN-BSP', @CategoryId, N'Active', N'Mars Series F20B-3C Two Piece Ball Valve', N'VF20B-3C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-3c.jpg', NULL),
(N'VF20B-3C-3-8IN-BSPT', @CategoryId, N'Active', N'Mars Series F20B-3C Two Piece Ball Valve', N'VF20B-3C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-3c.jpg', NULL),
(N'VF20B-3C-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F20B-3C Two Piece Ball Valve', N'VF20B-3C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-3c.jpg', NULL),
(N'VF20B-3C-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F20B-3C Two Piece Ball Valve', N'VF20B-3C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-3c.jpg', NULL),
(N'VF20B-3C-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F20B-3C Two Piece Ball Valve', N'VF20B-3C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-3c.jpg', NULL),
(N'VF20B-3C-3-4IN-NPT', @CategoryId, N'Active', N'Mars Series F20B-3C Two Piece Ball Valve', N'VF20B-3C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-3c.jpg', NULL),
(N'VF20B-3C-3-4IN-BSP', @CategoryId, N'Active', N'Mars Series F20B-3C Two Piece Ball Valve', N'VF20B-3C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-3c.jpg', NULL),
(N'VF20B-3C-3-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F20B-3C Two Piece Ball Valve', N'VF20B-3C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-3c.jpg', NULL),
(N'VF20B-3C-1IN-NPT', @CategoryId, N'Active', N'Mars Series F20B-3C Two Piece Ball Valve', N'VF20B-3C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-3c.jpg', NULL),
(N'VF20B-3C-1IN-BSP', @CategoryId, N'Active', N'Mars Series F20B-3C Two Piece Ball Valve', N'VF20B-3C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-3c.jpg', NULL),
(N'VF20B-3C-1IN-BSPT', @CategoryId, N'Active', N'Mars Series F20B-3C Two Piece Ball Valve', N'VF20B-3C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-3c.jpg', NULL),
(N'VF20B-3C-1-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F20B-3C Two Piece Ball Valve', N'VF20B-3C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-3c.jpg', NULL),
(N'VF20B-3C-1-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F20B-3C Two Piece Ball Valve', N'VF20B-3C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-3c.jpg', NULL),
(N'VF20B-3C-1-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F20B-3C Two Piece Ball Valve', N'VF20B-3C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-3c.jpg', NULL),
(N'VF20B-3C-1-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F20B-3C Two Piece Ball Valve', N'VF20B-3C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-3c.jpg', NULL),
(N'VF20B-3C-1-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F20B-3C Two Piece Ball Valve', N'VF20B-3C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-3c.jpg', NULL),
(N'VF20B-3C-1-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F20B-3C Two Piece Ball Valve', N'VF20B-3C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-3c.jpg', NULL),
(N'VF20B-3C-2IN-NPT', @CategoryId, N'Active', N'Mars Series F20B-3C Two Piece Ball Valve', N'VF20B-3C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-3c.jpg', NULL),
(N'VF20B-3C-2IN-BSP', @CategoryId, N'Active', N'Mars Series F20B-3C Two Piece Ball Valve', N'VF20B-3C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-3c.jpg', NULL),
(N'VF20B-3C-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F20B-3C Two Piece Ball Valve', N'VF20B-3C - 2-PC Ball Valve, Two Piece, B16.34, Full Port, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20b-3c.jpg', NULL);
INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VF20B-3C-1-4IN-NPT',N'Size',N'1/4"'),(N'VF20B-3C-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF20B-3C-1-4IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF20B-3C-1-4IN-BSP',N'Size',N'1/4"'),(N'VF20B-3C-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF20B-3C-1-4IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF20B-3C-1-4IN-BSPT',N'Size',N'1/4"'),(N'VF20B-3C-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF20B-3C-1-4IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF20B-3C-3-8IN-NPT',N'Size',N'3/8"'),(N'VF20B-3C-3-8IN-NPT',N'End Connection',N'NPT'),(N'VF20B-3C-3-8IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF20B-3C-3-8IN-BSP',N'Size',N'3/8"'),(N'VF20B-3C-3-8IN-BSP',N'End Connection',N'BSP'),(N'VF20B-3C-3-8IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF20B-3C-3-8IN-BSPT',N'Size',N'3/8"'),(N'VF20B-3C-3-8IN-BSPT',N'End Connection',N'BSPT'),(N'VF20B-3C-3-8IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF20B-3C-1-2IN-NPT',N'Size',N'1/2"'),(N'VF20B-3C-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF20B-3C-1-2IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF20B-3C-1-2IN-BSP',N'Size',N'1/2"'),(N'VF20B-3C-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF20B-3C-1-2IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF20B-3C-1-2IN-BSPT',N'Size',N'1/2"'),(N'VF20B-3C-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF20B-3C-1-2IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF20B-3C-3-4IN-NPT',N'Size',N'3/4"'),(N'VF20B-3C-3-4IN-NPT',N'End Connection',N'NPT'),(N'VF20B-3C-3-4IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF20B-3C-3-4IN-BSP',N'Size',N'3/4"'),(N'VF20B-3C-3-4IN-BSP',N'End Connection',N'BSP'),(N'VF20B-3C-3-4IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF20B-3C-3-4IN-BSPT',N'Size',N'3/4"'),(N'VF20B-3C-3-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF20B-3C-3-4IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF20B-3C-1IN-NPT',N'Size',N'1"'),(N'VF20B-3C-1IN-NPT',N'End Connection',N'NPT'),(N'VF20B-3C-1IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF20B-3C-1IN-BSP',N'Size',N'1"'),(N'VF20B-3C-1IN-BSP',N'End Connection',N'BSP'),(N'VF20B-3C-1IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF20B-3C-1IN-BSPT',N'Size',N'1"'),(N'VF20B-3C-1IN-BSPT',N'End Connection',N'BSPT'),(N'VF20B-3C-1IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF20B-3C-1-1-4IN-NPT',N'Size',N'1 1/4"'),(N'VF20B-3C-1-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF20B-3C-1-1-4IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF20B-3C-1-1-4IN-BSP',N'Size',N'1 1/4"'),(N'VF20B-3C-1-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF20B-3C-1-1-4IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF20B-3C-1-1-4IN-BSPT',N'Size',N'1 1/4"'),(N'VF20B-3C-1-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF20B-3C-1-1-4IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF20B-3C-1-1-2IN-NPT',N'Size',N'1 1/2"'),(N'VF20B-3C-1-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF20B-3C-1-1-2IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF20B-3C-1-1-2IN-BSP',N'Size',N'1 1/2"'),(N'VF20B-3C-1-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF20B-3C-1-1-2IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF20B-3C-1-1-2IN-BSPT',N'Size',N'1 1/2"'),(N'VF20B-3C-1-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF20B-3C-1-1-2IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF20B-3C-2IN-NPT',N'Size',N'2"'),(N'VF20B-3C-2IN-NPT',N'End Connection',N'NPT'),(N'VF20B-3C-2IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF20B-3C-2IN-BSP',N'Size',N'2"'),(N'VF20B-3C-2IN-BSP',N'End Connection',N'BSP'),(N'VF20B-3C-2IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF20B-3C-2IN-BSPT',N'Size',N'2"'),(N'VF20B-3C-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF20B-3C-2IN-BSPT',N'Operating Pressure',N'2000 PSI')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;
SELECT N'Series F20B-3C' AS Series, COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
GO

-- ===== Series F20-60 (24 products, quote-only Price NULL) =====
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series F20-60')
    INSERT INTO Categories (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures)
    VALUES (N'Series F20-60', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'The Mars Series F20-60 is a 2-piece, full/reduced-port ball valve with male x male threaded ends and a mounting pad, rated to 1000 PSI. CF8M body with PTFE/RTFE seats, in sizes 1/4" to 2".', N'CF8M', N'PTFE / RTFE', N'Two Piece, Full / Reduced Port, Mounting Pad', N'2-piece full / reduced port design
Male x male threaded ends (NPT, BSP, BSPT)
Mounting pad
Rated to 1000 PSI
CF8M body
PTFE / RTFE seats
Size 1/4" to 2"');
GO
DECLARE @SeriesName nvarchar(100) = N'Series F20-60';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);
INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'End Connection'),(N'Operating Pressure')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);
INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'End Connection',0),(N'Size',1),(N'Operating Pressure',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);
INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VF20-60-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F20-60 Two Piece Ball Valve', N'VF20-60 - 2-PC Ball Valve, Two Piece, Full / Reduced Port, Mounting Pad, 1000 PSI, Body CF8M, Seat PTFE / RTFE, 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20-60.jpg', NULL),
(N'VF20-60-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F20-60 Two Piece Ball Valve', N'VF20-60 - 2-PC Ball Valve, Two Piece, Full / Reduced Port, Mounting Pad, 1000 PSI, Body CF8M, Seat PTFE / RTFE, 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20-60.jpg', NULL),
(N'VF20-60-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F20-60 Two Piece Ball Valve', N'VF20-60 - 2-PC Ball Valve, Two Piece, Full / Reduced Port, Mounting Pad, 1000 PSI, Body CF8M, Seat PTFE / RTFE, 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20-60.jpg', NULL),
(N'VF20-60-3-8IN-NPT', @CategoryId, N'Active', N'Mars Series F20-60 Two Piece Ball Valve', N'VF20-60 - 2-PC Ball Valve, Two Piece, Full / Reduced Port, Mounting Pad, 1000 PSI, Body CF8M, Seat PTFE / RTFE, 3/8", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20-60.jpg', NULL),
(N'VF20-60-3-8IN-BSP', @CategoryId, N'Active', N'Mars Series F20-60 Two Piece Ball Valve', N'VF20-60 - 2-PC Ball Valve, Two Piece, Full / Reduced Port, Mounting Pad, 1000 PSI, Body CF8M, Seat PTFE / RTFE, 3/8", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20-60.jpg', NULL),
(N'VF20-60-3-8IN-BSPT', @CategoryId, N'Active', N'Mars Series F20-60 Two Piece Ball Valve', N'VF20-60 - 2-PC Ball Valve, Two Piece, Full / Reduced Port, Mounting Pad, 1000 PSI, Body CF8M, Seat PTFE / RTFE, 3/8", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20-60.jpg', NULL),
(N'VF20-60-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F20-60 Two Piece Ball Valve', N'VF20-60 - 2-PC Ball Valve, Two Piece, Full / Reduced Port, Mounting Pad, 1000 PSI, Body CF8M, Seat PTFE / RTFE, 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20-60.jpg', NULL),
(N'VF20-60-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F20-60 Two Piece Ball Valve', N'VF20-60 - 2-PC Ball Valve, Two Piece, Full / Reduced Port, Mounting Pad, 1000 PSI, Body CF8M, Seat PTFE / RTFE, 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20-60.jpg', NULL),
(N'VF20-60-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F20-60 Two Piece Ball Valve', N'VF20-60 - 2-PC Ball Valve, Two Piece, Full / Reduced Port, Mounting Pad, 1000 PSI, Body CF8M, Seat PTFE / RTFE, 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20-60.jpg', NULL),
(N'VF20-60-3-4IN-NPT', @CategoryId, N'Active', N'Mars Series F20-60 Two Piece Ball Valve', N'VF20-60 - 2-PC Ball Valve, Two Piece, Full / Reduced Port, Mounting Pad, 1000 PSI, Body CF8M, Seat PTFE / RTFE, 3/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20-60.jpg', NULL),
(N'VF20-60-3-4IN-BSP', @CategoryId, N'Active', N'Mars Series F20-60 Two Piece Ball Valve', N'VF20-60 - 2-PC Ball Valve, Two Piece, Full / Reduced Port, Mounting Pad, 1000 PSI, Body CF8M, Seat PTFE / RTFE, 3/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20-60.jpg', NULL),
(N'VF20-60-3-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F20-60 Two Piece Ball Valve', N'VF20-60 - 2-PC Ball Valve, Two Piece, Full / Reduced Port, Mounting Pad, 1000 PSI, Body CF8M, Seat PTFE / RTFE, 3/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20-60.jpg', NULL),
(N'VF20-60-1IN-NPT', @CategoryId, N'Active', N'Mars Series F20-60 Two Piece Ball Valve', N'VF20-60 - 2-PC Ball Valve, Two Piece, Full / Reduced Port, Mounting Pad, 1000 PSI, Body CF8M, Seat PTFE / RTFE, 1", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20-60.jpg', NULL),
(N'VF20-60-1IN-BSP', @CategoryId, N'Active', N'Mars Series F20-60 Two Piece Ball Valve', N'VF20-60 - 2-PC Ball Valve, Two Piece, Full / Reduced Port, Mounting Pad, 1000 PSI, Body CF8M, Seat PTFE / RTFE, 1", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20-60.jpg', NULL),
(N'VF20-60-1IN-BSPT', @CategoryId, N'Active', N'Mars Series F20-60 Two Piece Ball Valve', N'VF20-60 - 2-PC Ball Valve, Two Piece, Full / Reduced Port, Mounting Pad, 1000 PSI, Body CF8M, Seat PTFE / RTFE, 1", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20-60.jpg', NULL),
(N'VF20-60-1-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F20-60 Two Piece Ball Valve', N'VF20-60 - 2-PC Ball Valve, Two Piece, Full / Reduced Port, Mounting Pad, 1000 PSI, Body CF8M, Seat PTFE / RTFE, 1 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20-60.jpg', NULL),
(N'VF20-60-1-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F20-60 Two Piece Ball Valve', N'VF20-60 - 2-PC Ball Valve, Two Piece, Full / Reduced Port, Mounting Pad, 1000 PSI, Body CF8M, Seat PTFE / RTFE, 1 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20-60.jpg', NULL),
(N'VF20-60-1-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F20-60 Two Piece Ball Valve', N'VF20-60 - 2-PC Ball Valve, Two Piece, Full / Reduced Port, Mounting Pad, 1000 PSI, Body CF8M, Seat PTFE / RTFE, 1 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20-60.jpg', NULL),
(N'VF20-60-1-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F20-60 Two Piece Ball Valve', N'VF20-60 - 2-PC Ball Valve, Two Piece, Full / Reduced Port, Mounting Pad, 1000 PSI, Body CF8M, Seat PTFE / RTFE, 1 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20-60.jpg', NULL),
(N'VF20-60-1-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F20-60 Two Piece Ball Valve', N'VF20-60 - 2-PC Ball Valve, Two Piece, Full / Reduced Port, Mounting Pad, 1000 PSI, Body CF8M, Seat PTFE / RTFE, 1 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20-60.jpg', NULL),
(N'VF20-60-1-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F20-60 Two Piece Ball Valve', N'VF20-60 - 2-PC Ball Valve, Two Piece, Full / Reduced Port, Mounting Pad, 1000 PSI, Body CF8M, Seat PTFE / RTFE, 1 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20-60.jpg', NULL),
(N'VF20-60-2IN-NPT', @CategoryId, N'Active', N'Mars Series F20-60 Two Piece Ball Valve', N'VF20-60 - 2-PC Ball Valve, Two Piece, Full / Reduced Port, Mounting Pad, 1000 PSI, Body CF8M, Seat PTFE / RTFE, 2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20-60.jpg', NULL),
(N'VF20-60-2IN-BSP', @CategoryId, N'Active', N'Mars Series F20-60 Two Piece Ball Valve', N'VF20-60 - 2-PC Ball Valve, Two Piece, Full / Reduced Port, Mounting Pad, 1000 PSI, Body CF8M, Seat PTFE / RTFE, 2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20-60.jpg', NULL),
(N'VF20-60-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F20-60 Two Piece Ball Valve', N'VF20-60 - 2-PC Ball Valve, Two Piece, Full / Reduced Port, Mounting Pad, 1000 PSI, Body CF8M, Seat PTFE / RTFE, 2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-two-piece-ball-valve/series-f20-60.jpg', NULL);
INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VF20-60-1-4IN-NPT',N'Size',N'1/4"'),(N'VF20-60-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF20-60-1-4IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20-60-1-4IN-BSP',N'Size',N'1/4"'),(N'VF20-60-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF20-60-1-4IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF20-60-1-4IN-BSPT',N'Size',N'1/4"'),(N'VF20-60-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF20-60-1-4IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20-60-3-8IN-NPT',N'Size',N'3/8"'),(N'VF20-60-3-8IN-NPT',N'End Connection',N'NPT'),(N'VF20-60-3-8IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20-60-3-8IN-BSP',N'Size',N'3/8"'),(N'VF20-60-3-8IN-BSP',N'End Connection',N'BSP'),(N'VF20-60-3-8IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF20-60-3-8IN-BSPT',N'Size',N'3/8"'),(N'VF20-60-3-8IN-BSPT',N'End Connection',N'BSPT'),(N'VF20-60-3-8IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20-60-1-2IN-NPT',N'Size',N'1/2"'),(N'VF20-60-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF20-60-1-2IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20-60-1-2IN-BSP',N'Size',N'1/2"'),(N'VF20-60-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF20-60-1-2IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF20-60-1-2IN-BSPT',N'Size',N'1/2"'),(N'VF20-60-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF20-60-1-2IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20-60-3-4IN-NPT',N'Size',N'3/4"'),(N'VF20-60-3-4IN-NPT',N'End Connection',N'NPT'),(N'VF20-60-3-4IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20-60-3-4IN-BSP',N'Size',N'3/4"'),(N'VF20-60-3-4IN-BSP',N'End Connection',N'BSP'),(N'VF20-60-3-4IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF20-60-3-4IN-BSPT',N'Size',N'3/4"'),(N'VF20-60-3-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF20-60-3-4IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20-60-1IN-NPT',N'Size',N'1"'),(N'VF20-60-1IN-NPT',N'End Connection',N'NPT'),(N'VF20-60-1IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20-60-1IN-BSP',N'Size',N'1"'),(N'VF20-60-1IN-BSP',N'End Connection',N'BSP'),(N'VF20-60-1IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF20-60-1IN-BSPT',N'Size',N'1"'),(N'VF20-60-1IN-BSPT',N'End Connection',N'BSPT'),(N'VF20-60-1IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20-60-1-1-4IN-NPT',N'Size',N'1 1/4"'),(N'VF20-60-1-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF20-60-1-1-4IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20-60-1-1-4IN-BSP',N'Size',N'1 1/4"'),(N'VF20-60-1-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF20-60-1-1-4IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF20-60-1-1-4IN-BSPT',N'Size',N'1 1/4"'),(N'VF20-60-1-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF20-60-1-1-4IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20-60-1-1-2IN-NPT',N'Size',N'1 1/2"'),(N'VF20-60-1-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF20-60-1-1-2IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20-60-1-1-2IN-BSP',N'Size',N'1 1/2"'),(N'VF20-60-1-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF20-60-1-1-2IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF20-60-1-1-2IN-BSPT',N'Size',N'1 1/2"'),(N'VF20-60-1-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF20-60-1-1-2IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20-60-2IN-NPT',N'Size',N'2"'),(N'VF20-60-2IN-NPT',N'End Connection',N'NPT'),(N'VF20-60-2IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF20-60-2IN-BSP',N'Size',N'2"'),(N'VF20-60-2IN-BSP',N'End Connection',N'BSP'),(N'VF20-60-2IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF20-60-2IN-BSPT',N'Size',N'2"'),(N'VF20-60-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF20-60-2IN-BSPT',N'Operating Pressure',N'1000 PSI')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;
SELECT N'Series F20-60' AS Series, COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
GO
