-- High-pressure 2-piece quote-only batch: F21-90, F21-9K, F22-40, F22-50.
-- Run the whole file in SSMS; GO splits the batches.

-- ===== Series F21-90 (21 products, quote-only Price NULL) =====
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series F21-90')
    INSERT INTO Categories (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures)
    VALUES (N'Series F21-90', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'The Mars Series F21-90 is a 2-piece, full-port high-pressure ball valve with threaded ends, rated to 6000 PSI. CF8M or WCB body with Delrin + 5% carbon seats, in sizes 1/4" to 1 1/2". Fire-safe design on request.', N'CF8M / WCB', N'Delrin + 5% Carbon', N'Two Piece, Full Port, High Pressure', N'2-piece full port high pressure design
Threaded ends (NPT, BSP, BSPT)
Rated to 6000 PSI
CF8M or WCB body
Delrin + 5% carbon seats
Size 1/4" to 1 1/2"
Fire-safe design on request');
GO
DECLARE @SeriesName nvarchar(100) = N'Series F21-90';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);
INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'End Connection'),(N'Operating Pressure')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);
INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'End Connection',0),(N'Size',1),(N'Operating Pressure',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);
INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VF21-90-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F21-90 Two Piece High Pressure Ball Valve', N'VF21-90 - 2-PC Ball Valve, Two Piece, Full Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin + 5% Carbon, 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-90.jpg', NULL),
(N'VF21-90-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F21-90 Two Piece High Pressure Ball Valve', N'VF21-90 - 2-PC Ball Valve, Two Piece, Full Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin + 5% Carbon, 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-90.jpg', NULL),
(N'VF21-90-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-90 Two Piece High Pressure Ball Valve', N'VF21-90 - 2-PC Ball Valve, Two Piece, Full Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin + 5% Carbon, 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-90.jpg', NULL),
(N'VF21-90-3-8IN-NPT', @CategoryId, N'Active', N'Mars Series F21-90 Two Piece High Pressure Ball Valve', N'VF21-90 - 2-PC Ball Valve, Two Piece, Full Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin + 5% Carbon, 3/8", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-90.jpg', NULL),
(N'VF21-90-3-8IN-BSP', @CategoryId, N'Active', N'Mars Series F21-90 Two Piece High Pressure Ball Valve', N'VF21-90 - 2-PC Ball Valve, Two Piece, Full Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin + 5% Carbon, 3/8", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-90.jpg', NULL),
(N'VF21-90-3-8IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-90 Two Piece High Pressure Ball Valve', N'VF21-90 - 2-PC Ball Valve, Two Piece, Full Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin + 5% Carbon, 3/8", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-90.jpg', NULL),
(N'VF21-90-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F21-90 Two Piece High Pressure Ball Valve', N'VF21-90 - 2-PC Ball Valve, Two Piece, Full Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin + 5% Carbon, 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-90.jpg', NULL),
(N'VF21-90-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F21-90 Two Piece High Pressure Ball Valve', N'VF21-90 - 2-PC Ball Valve, Two Piece, Full Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin + 5% Carbon, 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-90.jpg', NULL),
(N'VF21-90-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-90 Two Piece High Pressure Ball Valve', N'VF21-90 - 2-PC Ball Valve, Two Piece, Full Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin + 5% Carbon, 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-90.jpg', NULL),
(N'VF21-90-3-4IN-NPT', @CategoryId, N'Active', N'Mars Series F21-90 Two Piece High Pressure Ball Valve', N'VF21-90 - 2-PC Ball Valve, Two Piece, Full Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin + 5% Carbon, 3/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-90.jpg', NULL),
(N'VF21-90-3-4IN-BSP', @CategoryId, N'Active', N'Mars Series F21-90 Two Piece High Pressure Ball Valve', N'VF21-90 - 2-PC Ball Valve, Two Piece, Full Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin + 5% Carbon, 3/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-90.jpg', NULL),
(N'VF21-90-3-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-90 Two Piece High Pressure Ball Valve', N'VF21-90 - 2-PC Ball Valve, Two Piece, Full Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin + 5% Carbon, 3/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-90.jpg', NULL),
(N'VF21-90-1IN-NPT', @CategoryId, N'Active', N'Mars Series F21-90 Two Piece High Pressure Ball Valve', N'VF21-90 - 2-PC Ball Valve, Two Piece, Full Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin + 5% Carbon, 1", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-90.jpg', NULL),
(N'VF21-90-1IN-BSP', @CategoryId, N'Active', N'Mars Series F21-90 Two Piece High Pressure Ball Valve', N'VF21-90 - 2-PC Ball Valve, Two Piece, Full Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin + 5% Carbon, 1", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-90.jpg', NULL),
(N'VF21-90-1IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-90 Two Piece High Pressure Ball Valve', N'VF21-90 - 2-PC Ball Valve, Two Piece, Full Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin + 5% Carbon, 1", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-90.jpg', NULL),
(N'VF21-90-1-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F21-90 Two Piece High Pressure Ball Valve', N'VF21-90 - 2-PC Ball Valve, Two Piece, Full Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin + 5% Carbon, 1 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-90.jpg', NULL),
(N'VF21-90-1-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F21-90 Two Piece High Pressure Ball Valve', N'VF21-90 - 2-PC Ball Valve, Two Piece, Full Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin + 5% Carbon, 1 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-90.jpg', NULL),
(N'VF21-90-1-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-90 Two Piece High Pressure Ball Valve', N'VF21-90 - 2-PC Ball Valve, Two Piece, Full Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin + 5% Carbon, 1 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-90.jpg', NULL),
(N'VF21-90-1-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F21-90 Two Piece High Pressure Ball Valve', N'VF21-90 - 2-PC Ball Valve, Two Piece, Full Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin + 5% Carbon, 1 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-90.jpg', NULL),
(N'VF21-90-1-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F21-90 Two Piece High Pressure Ball Valve', N'VF21-90 - 2-PC Ball Valve, Two Piece, Full Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin + 5% Carbon, 1 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-90.jpg', NULL),
(N'VF21-90-1-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-90 Two Piece High Pressure Ball Valve', N'VF21-90 - 2-PC Ball Valve, Two Piece, Full Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin + 5% Carbon, 1 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-90.jpg', NULL);
INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VF21-90-1-4IN-NPT',N'Size',N'1/4"'),(N'VF21-90-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF21-90-1-4IN-NPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-90-1-4IN-BSP',N'Size',N'1/4"'),(N'VF21-90-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF21-90-1-4IN-BSP',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-90-1-4IN-BSPT',N'Size',N'1/4"'),(N'VF21-90-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-90-1-4IN-BSPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-90-3-8IN-NPT',N'Size',N'3/8"'),(N'VF21-90-3-8IN-NPT',N'End Connection',N'NPT'),(N'VF21-90-3-8IN-NPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-90-3-8IN-BSP',N'Size',N'3/8"'),(N'VF21-90-3-8IN-BSP',N'End Connection',N'BSP'),(N'VF21-90-3-8IN-BSP',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-90-3-8IN-BSPT',N'Size',N'3/8"'),(N'VF21-90-3-8IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-90-3-8IN-BSPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-90-1-2IN-NPT',N'Size',N'1/2"'),(N'VF21-90-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF21-90-1-2IN-NPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-90-1-2IN-BSP',N'Size',N'1/2"'),(N'VF21-90-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF21-90-1-2IN-BSP',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-90-1-2IN-BSPT',N'Size',N'1/2"'),(N'VF21-90-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-90-1-2IN-BSPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-90-3-4IN-NPT',N'Size',N'3/4"'),(N'VF21-90-3-4IN-NPT',N'End Connection',N'NPT'),(N'VF21-90-3-4IN-NPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-90-3-4IN-BSP',N'Size',N'3/4"'),(N'VF21-90-3-4IN-BSP',N'End Connection',N'BSP'),(N'VF21-90-3-4IN-BSP',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-90-3-4IN-BSPT',N'Size',N'3/4"'),(N'VF21-90-3-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-90-3-4IN-BSPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-90-1IN-NPT',N'Size',N'1"'),(N'VF21-90-1IN-NPT',N'End Connection',N'NPT'),(N'VF21-90-1IN-NPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-90-1IN-BSP',N'Size',N'1"'),(N'VF21-90-1IN-BSP',N'End Connection',N'BSP'),(N'VF21-90-1IN-BSP',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-90-1IN-BSPT',N'Size',N'1"'),(N'VF21-90-1IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-90-1IN-BSPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-90-1-1-4IN-NPT',N'Size',N'1 1/4"'),(N'VF21-90-1-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF21-90-1-1-4IN-NPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-90-1-1-4IN-BSP',N'Size',N'1 1/4"'),(N'VF21-90-1-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF21-90-1-1-4IN-BSP',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-90-1-1-4IN-BSPT',N'Size',N'1 1/4"'),(N'VF21-90-1-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-90-1-1-4IN-BSPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-90-1-1-2IN-NPT',N'Size',N'1 1/2"'),(N'VF21-90-1-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF21-90-1-1-2IN-NPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-90-1-1-2IN-BSP',N'Size',N'1 1/2"'),(N'VF21-90-1-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF21-90-1-1-2IN-BSP',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-90-1-1-2IN-BSPT',N'Size',N'1 1/2"'),(N'VF21-90-1-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-90-1-1-2IN-BSPT',N'Operating Pressure',N'6000 PSI')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;
SELECT N'Series F21-90' AS Series, COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
GO

-- ===== Series F21-9K (24 products, quote-only Price NULL) =====
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series F21-9K')
    INSERT INTO Categories (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures, Approvals)
    VALUES (N'Series F21-9K', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'The Mars Series F21-9K is a 2-piece, reduced-port fire-safe high-pressure ball valve with threaded ends, rated to 6000 PSI, certified to API 607 (5th Edition) and conforming to ASME B16.34. CF8M or WCB body with Delrin/Peek seats, in sizes 1/4" to 2".', N'CF8M / WCB', N'Delrin / Peek', N'Two Piece, Fire-Safe, Reduced Port, High Pressure', N'2-piece reduced port fire-safe high pressure design
Threaded ends (NPT, BSP, BSPT)
Rated to 6000 PSI
CF8M or WCB body
Delrin / Peek seats
Size 1/4" to 2"
Fire-safe API 607, 5th Edition
Conforms to ASME B16.34', N'Fire-Safe API 607, 5th Edition; ASME B16.34');
GO
DECLARE @SeriesName nvarchar(100) = N'Series F21-9K';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);
INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'End Connection'),(N'Operating Pressure')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);
INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'End Connection',0),(N'Size',1),(N'Operating Pressure',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);
INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VF21-9K-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F21-9K Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-9K - 2-PC Ball Valve, Two Piece, Fire-Safe, Reduced Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-9k.jpg', NULL),
(N'VF21-9K-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F21-9K Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-9K - 2-PC Ball Valve, Two Piece, Fire-Safe, Reduced Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-9k.jpg', NULL),
(N'VF21-9K-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-9K Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-9K - 2-PC Ball Valve, Two Piece, Fire-Safe, Reduced Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-9k.jpg', NULL),
(N'VF21-9K-3-8IN-NPT', @CategoryId, N'Active', N'Mars Series F21-9K Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-9K - 2-PC Ball Valve, Two Piece, Fire-Safe, Reduced Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 3/8", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-9k.jpg', NULL),
(N'VF21-9K-3-8IN-BSP', @CategoryId, N'Active', N'Mars Series F21-9K Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-9K - 2-PC Ball Valve, Two Piece, Fire-Safe, Reduced Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 3/8", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-9k.jpg', NULL),
(N'VF21-9K-3-8IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-9K Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-9K - 2-PC Ball Valve, Two Piece, Fire-Safe, Reduced Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 3/8", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-9k.jpg', NULL),
(N'VF21-9K-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F21-9K Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-9K - 2-PC Ball Valve, Two Piece, Fire-Safe, Reduced Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-9k.jpg', NULL),
(N'VF21-9K-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F21-9K Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-9K - 2-PC Ball Valve, Two Piece, Fire-Safe, Reduced Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-9k.jpg', NULL),
(N'VF21-9K-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-9K Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-9K - 2-PC Ball Valve, Two Piece, Fire-Safe, Reduced Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-9k.jpg', NULL),
(N'VF21-9K-3-4IN-NPT', @CategoryId, N'Active', N'Mars Series F21-9K Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-9K - 2-PC Ball Valve, Two Piece, Fire-Safe, Reduced Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 3/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-9k.jpg', NULL),
(N'VF21-9K-3-4IN-BSP', @CategoryId, N'Active', N'Mars Series F21-9K Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-9K - 2-PC Ball Valve, Two Piece, Fire-Safe, Reduced Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 3/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-9k.jpg', NULL),
(N'VF21-9K-3-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-9K Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-9K - 2-PC Ball Valve, Two Piece, Fire-Safe, Reduced Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 3/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-9k.jpg', NULL),
(N'VF21-9K-1IN-NPT', @CategoryId, N'Active', N'Mars Series F21-9K Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-9K - 2-PC Ball Valve, Two Piece, Fire-Safe, Reduced Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-9k.jpg', NULL),
(N'VF21-9K-1IN-BSP', @CategoryId, N'Active', N'Mars Series F21-9K Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-9K - 2-PC Ball Valve, Two Piece, Fire-Safe, Reduced Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-9k.jpg', NULL),
(N'VF21-9K-1IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-9K Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-9K - 2-PC Ball Valve, Two Piece, Fire-Safe, Reduced Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-9k.jpg', NULL),
(N'VF21-9K-1-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F21-9K Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-9K - 2-PC Ball Valve, Two Piece, Fire-Safe, Reduced Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-9k.jpg', NULL),
(N'VF21-9K-1-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F21-9K Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-9K - 2-PC Ball Valve, Two Piece, Fire-Safe, Reduced Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-9k.jpg', NULL),
(N'VF21-9K-1-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-9K Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-9K - 2-PC Ball Valve, Two Piece, Fire-Safe, Reduced Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-9k.jpg', NULL),
(N'VF21-9K-1-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F21-9K Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-9K - 2-PC Ball Valve, Two Piece, Fire-Safe, Reduced Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-9k.jpg', NULL),
(N'VF21-9K-1-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F21-9K Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-9K - 2-PC Ball Valve, Two Piece, Fire-Safe, Reduced Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-9k.jpg', NULL),
(N'VF21-9K-1-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-9K Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-9K - 2-PC Ball Valve, Two Piece, Fire-Safe, Reduced Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-9k.jpg', NULL),
(N'VF21-9K-2IN-NPT', @CategoryId, N'Active', N'Mars Series F21-9K Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-9K - 2-PC Ball Valve, Two Piece, Fire-Safe, Reduced Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-9k.jpg', NULL),
(N'VF21-9K-2IN-BSP', @CategoryId, N'Active', N'Mars Series F21-9K Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-9K - 2-PC Ball Valve, Two Piece, Fire-Safe, Reduced Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-9k.jpg', NULL),
(N'VF21-9K-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-9K Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-9K - 2-PC Ball Valve, Two Piece, Fire-Safe, Reduced Port, High Pressure, 6000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-9k.jpg', NULL);
INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VF21-9K-1-4IN-NPT',N'Size',N'1/4"'),(N'VF21-9K-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF21-9K-1-4IN-NPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-9K-1-4IN-BSP',N'Size',N'1/4"'),(N'VF21-9K-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF21-9K-1-4IN-BSP',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-9K-1-4IN-BSPT',N'Size',N'1/4"'),(N'VF21-9K-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-9K-1-4IN-BSPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-9K-3-8IN-NPT',N'Size',N'3/8"'),(N'VF21-9K-3-8IN-NPT',N'End Connection',N'NPT'),(N'VF21-9K-3-8IN-NPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-9K-3-8IN-BSP',N'Size',N'3/8"'),(N'VF21-9K-3-8IN-BSP',N'End Connection',N'BSP'),(N'VF21-9K-3-8IN-BSP',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-9K-3-8IN-BSPT',N'Size',N'3/8"'),(N'VF21-9K-3-8IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-9K-3-8IN-BSPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-9K-1-2IN-NPT',N'Size',N'1/2"'),(N'VF21-9K-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF21-9K-1-2IN-NPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-9K-1-2IN-BSP',N'Size',N'1/2"'),(N'VF21-9K-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF21-9K-1-2IN-BSP',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-9K-1-2IN-BSPT',N'Size',N'1/2"'),(N'VF21-9K-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-9K-1-2IN-BSPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-9K-3-4IN-NPT',N'Size',N'3/4"'),(N'VF21-9K-3-4IN-NPT',N'End Connection',N'NPT'),(N'VF21-9K-3-4IN-NPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-9K-3-4IN-BSP',N'Size',N'3/4"'),(N'VF21-9K-3-4IN-BSP',N'End Connection',N'BSP'),(N'VF21-9K-3-4IN-BSP',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-9K-3-4IN-BSPT',N'Size',N'3/4"'),(N'VF21-9K-3-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-9K-3-4IN-BSPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-9K-1IN-NPT',N'Size',N'1"'),(N'VF21-9K-1IN-NPT',N'End Connection',N'NPT'),(N'VF21-9K-1IN-NPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-9K-1IN-BSP',N'Size',N'1"'),(N'VF21-9K-1IN-BSP',N'End Connection',N'BSP'),(N'VF21-9K-1IN-BSP',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-9K-1IN-BSPT',N'Size',N'1"'),(N'VF21-9K-1IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-9K-1IN-BSPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-9K-1-1-4IN-NPT',N'Size',N'1 1/4"'),(N'VF21-9K-1-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF21-9K-1-1-4IN-NPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-9K-1-1-4IN-BSP',N'Size',N'1 1/4"'),(N'VF21-9K-1-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF21-9K-1-1-4IN-BSP',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-9K-1-1-4IN-BSPT',N'Size',N'1 1/4"'),(N'VF21-9K-1-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-9K-1-1-4IN-BSPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-9K-1-1-2IN-NPT',N'Size',N'1 1/2"'),(N'VF21-9K-1-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF21-9K-1-1-2IN-NPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-9K-1-1-2IN-BSP',N'Size',N'1 1/2"'),(N'VF21-9K-1-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF21-9K-1-1-2IN-BSP',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-9K-1-1-2IN-BSPT',N'Size',N'1 1/2"'),(N'VF21-9K-1-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-9K-1-1-2IN-BSPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-9K-2IN-NPT',N'Size',N'2"'),(N'VF21-9K-2IN-NPT',N'End Connection',N'NPT'),(N'VF21-9K-2IN-NPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-9K-2IN-BSP',N'Size',N'2"'),(N'VF21-9K-2IN-BSP',N'End Connection',N'BSP'),(N'VF21-9K-2IN-BSP',N'Operating Pressure',N'6000 PSI'),
  (N'VF21-9K-2IN-BSPT',N'Size',N'2"'),(N'VF21-9K-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-9K-2IN-BSPT',N'Operating Pressure',N'6000 PSI')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;
SELECT N'Series F21-9K' AS Series, COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
GO

-- ===== Series F22-40 (24 products, quote-only Price NULL) =====
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series F22-40')
    INSERT INTO Categories (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures, Approvals)
    VALUES (N'Series F22-40', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'The Mars Series F22-40 is a 2-piece, full-port direct-mount high-pressure ball valve with threaded ends and a 17-4ph stem, rated to 3600 PSI with a fire-safe design. CF8M body with Delrin/Peek seats, in sizes 1/4" to 2".', N'CF8M', N'Delrin / Peek', N'Two Piece, Direct Mount, Full Port, High Pressure', N'2-piece full port direct mount high pressure design
Threaded ends (NPT, BSP, BSPT)
Rated to 3600 PSI
CF8M body, 17-4ph stem
Delrin / Peek seats
Size 1/4" to 2"
Fire-safe design', N'Fire-Safe');
GO
DECLARE @SeriesName nvarchar(100) = N'Series F22-40';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);
INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'End Connection'),(N'Operating Pressure')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);
INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'End Connection',0),(N'Size',1),(N'Operating Pressure',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);
INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VF22-40-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F22-40 Two Piece High Pressure Ball Valve', N'VF22-40 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 3600 PSI, Body CF8M, Seat Delrin / Peek, 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-40.jpg', NULL),
(N'VF22-40-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F22-40 Two Piece High Pressure Ball Valve', N'VF22-40 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 3600 PSI, Body CF8M, Seat Delrin / Peek, 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-40.jpg', NULL),
(N'VF22-40-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F22-40 Two Piece High Pressure Ball Valve', N'VF22-40 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 3600 PSI, Body CF8M, Seat Delrin / Peek, 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-40.jpg', NULL),
(N'VF22-40-3-8IN-NPT', @CategoryId, N'Active', N'Mars Series F22-40 Two Piece High Pressure Ball Valve', N'VF22-40 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 3600 PSI, Body CF8M, Seat Delrin / Peek, 3/8", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-40.jpg', NULL),
(N'VF22-40-3-8IN-BSP', @CategoryId, N'Active', N'Mars Series F22-40 Two Piece High Pressure Ball Valve', N'VF22-40 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 3600 PSI, Body CF8M, Seat Delrin / Peek, 3/8", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-40.jpg', NULL),
(N'VF22-40-3-8IN-BSPT', @CategoryId, N'Active', N'Mars Series F22-40 Two Piece High Pressure Ball Valve', N'VF22-40 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 3600 PSI, Body CF8M, Seat Delrin / Peek, 3/8", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-40.jpg', NULL),
(N'VF22-40-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F22-40 Two Piece High Pressure Ball Valve', N'VF22-40 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 3600 PSI, Body CF8M, Seat Delrin / Peek, 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-40.jpg', NULL),
(N'VF22-40-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F22-40 Two Piece High Pressure Ball Valve', N'VF22-40 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 3600 PSI, Body CF8M, Seat Delrin / Peek, 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-40.jpg', NULL),
(N'VF22-40-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F22-40 Two Piece High Pressure Ball Valve', N'VF22-40 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 3600 PSI, Body CF8M, Seat Delrin / Peek, 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-40.jpg', NULL),
(N'VF22-40-3-4IN-NPT', @CategoryId, N'Active', N'Mars Series F22-40 Two Piece High Pressure Ball Valve', N'VF22-40 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 3600 PSI, Body CF8M, Seat Delrin / Peek, 3/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-40.jpg', NULL),
(N'VF22-40-3-4IN-BSP', @CategoryId, N'Active', N'Mars Series F22-40 Two Piece High Pressure Ball Valve', N'VF22-40 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 3600 PSI, Body CF8M, Seat Delrin / Peek, 3/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-40.jpg', NULL),
(N'VF22-40-3-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F22-40 Two Piece High Pressure Ball Valve', N'VF22-40 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 3600 PSI, Body CF8M, Seat Delrin / Peek, 3/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-40.jpg', NULL),
(N'VF22-40-1IN-NPT', @CategoryId, N'Active', N'Mars Series F22-40 Two Piece High Pressure Ball Valve', N'VF22-40 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 3600 PSI, Body CF8M, Seat Delrin / Peek, 1", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-40.jpg', NULL),
(N'VF22-40-1IN-BSP', @CategoryId, N'Active', N'Mars Series F22-40 Two Piece High Pressure Ball Valve', N'VF22-40 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 3600 PSI, Body CF8M, Seat Delrin / Peek, 1", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-40.jpg', NULL),
(N'VF22-40-1IN-BSPT', @CategoryId, N'Active', N'Mars Series F22-40 Two Piece High Pressure Ball Valve', N'VF22-40 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 3600 PSI, Body CF8M, Seat Delrin / Peek, 1", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-40.jpg', NULL),
(N'VF22-40-1-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F22-40 Two Piece High Pressure Ball Valve', N'VF22-40 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 3600 PSI, Body CF8M, Seat Delrin / Peek, 1 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-40.jpg', NULL),
(N'VF22-40-1-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F22-40 Two Piece High Pressure Ball Valve', N'VF22-40 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 3600 PSI, Body CF8M, Seat Delrin / Peek, 1 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-40.jpg', NULL),
(N'VF22-40-1-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F22-40 Two Piece High Pressure Ball Valve', N'VF22-40 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 3600 PSI, Body CF8M, Seat Delrin / Peek, 1 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-40.jpg', NULL),
(N'VF22-40-1-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F22-40 Two Piece High Pressure Ball Valve', N'VF22-40 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 3600 PSI, Body CF8M, Seat Delrin / Peek, 1 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-40.jpg', NULL),
(N'VF22-40-1-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F22-40 Two Piece High Pressure Ball Valve', N'VF22-40 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 3600 PSI, Body CF8M, Seat Delrin / Peek, 1 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-40.jpg', NULL),
(N'VF22-40-1-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F22-40 Two Piece High Pressure Ball Valve', N'VF22-40 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 3600 PSI, Body CF8M, Seat Delrin / Peek, 1 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-40.jpg', NULL),
(N'VF22-40-2IN-NPT', @CategoryId, N'Active', N'Mars Series F22-40 Two Piece High Pressure Ball Valve', N'VF22-40 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 3600 PSI, Body CF8M, Seat Delrin / Peek, 2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-40.jpg', NULL),
(N'VF22-40-2IN-BSP', @CategoryId, N'Active', N'Mars Series F22-40 Two Piece High Pressure Ball Valve', N'VF22-40 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 3600 PSI, Body CF8M, Seat Delrin / Peek, 2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-40.jpg', NULL),
(N'VF22-40-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F22-40 Two Piece High Pressure Ball Valve', N'VF22-40 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 3600 PSI, Body CF8M, Seat Delrin / Peek, 2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-40.jpg', NULL);
INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VF22-40-1-4IN-NPT',N'Size',N'1/4"'),(N'VF22-40-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF22-40-1-4IN-NPT',N'Operating Pressure',N'3600 PSI'),
  (N'VF22-40-1-4IN-BSP',N'Size',N'1/4"'),(N'VF22-40-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF22-40-1-4IN-BSP',N'Operating Pressure',N'3600 PSI'),
  (N'VF22-40-1-4IN-BSPT',N'Size',N'1/4"'),(N'VF22-40-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF22-40-1-4IN-BSPT',N'Operating Pressure',N'3600 PSI'),
  (N'VF22-40-3-8IN-NPT',N'Size',N'3/8"'),(N'VF22-40-3-8IN-NPT',N'End Connection',N'NPT'),(N'VF22-40-3-8IN-NPT',N'Operating Pressure',N'3600 PSI'),
  (N'VF22-40-3-8IN-BSP',N'Size',N'3/8"'),(N'VF22-40-3-8IN-BSP',N'End Connection',N'BSP'),(N'VF22-40-3-8IN-BSP',N'Operating Pressure',N'3600 PSI'),
  (N'VF22-40-3-8IN-BSPT',N'Size',N'3/8"'),(N'VF22-40-3-8IN-BSPT',N'End Connection',N'BSPT'),(N'VF22-40-3-8IN-BSPT',N'Operating Pressure',N'3600 PSI'),
  (N'VF22-40-1-2IN-NPT',N'Size',N'1/2"'),(N'VF22-40-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF22-40-1-2IN-NPT',N'Operating Pressure',N'3600 PSI'),
  (N'VF22-40-1-2IN-BSP',N'Size',N'1/2"'),(N'VF22-40-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF22-40-1-2IN-BSP',N'Operating Pressure',N'3600 PSI'),
  (N'VF22-40-1-2IN-BSPT',N'Size',N'1/2"'),(N'VF22-40-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF22-40-1-2IN-BSPT',N'Operating Pressure',N'3600 PSI'),
  (N'VF22-40-3-4IN-NPT',N'Size',N'3/4"'),(N'VF22-40-3-4IN-NPT',N'End Connection',N'NPT'),(N'VF22-40-3-4IN-NPT',N'Operating Pressure',N'3600 PSI'),
  (N'VF22-40-3-4IN-BSP',N'Size',N'3/4"'),(N'VF22-40-3-4IN-BSP',N'End Connection',N'BSP'),(N'VF22-40-3-4IN-BSP',N'Operating Pressure',N'3600 PSI'),
  (N'VF22-40-3-4IN-BSPT',N'Size',N'3/4"'),(N'VF22-40-3-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF22-40-3-4IN-BSPT',N'Operating Pressure',N'3600 PSI'),
  (N'VF22-40-1IN-NPT',N'Size',N'1"'),(N'VF22-40-1IN-NPT',N'End Connection',N'NPT'),(N'VF22-40-1IN-NPT',N'Operating Pressure',N'3600 PSI'),
  (N'VF22-40-1IN-BSP',N'Size',N'1"'),(N'VF22-40-1IN-BSP',N'End Connection',N'BSP'),(N'VF22-40-1IN-BSP',N'Operating Pressure',N'3600 PSI'),
  (N'VF22-40-1IN-BSPT',N'Size',N'1"'),(N'VF22-40-1IN-BSPT',N'End Connection',N'BSPT'),(N'VF22-40-1IN-BSPT',N'Operating Pressure',N'3600 PSI'),
  (N'VF22-40-1-1-4IN-NPT',N'Size',N'1 1/4"'),(N'VF22-40-1-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF22-40-1-1-4IN-NPT',N'Operating Pressure',N'3600 PSI'),
  (N'VF22-40-1-1-4IN-BSP',N'Size',N'1 1/4"'),(N'VF22-40-1-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF22-40-1-1-4IN-BSP',N'Operating Pressure',N'3600 PSI'),
  (N'VF22-40-1-1-4IN-BSPT',N'Size',N'1 1/4"'),(N'VF22-40-1-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF22-40-1-1-4IN-BSPT',N'Operating Pressure',N'3600 PSI'),
  (N'VF22-40-1-1-2IN-NPT',N'Size',N'1 1/2"'),(N'VF22-40-1-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF22-40-1-1-2IN-NPT',N'Operating Pressure',N'3600 PSI'),
  (N'VF22-40-1-1-2IN-BSP',N'Size',N'1 1/2"'),(N'VF22-40-1-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF22-40-1-1-2IN-BSP',N'Operating Pressure',N'3600 PSI'),
  (N'VF22-40-1-1-2IN-BSPT',N'Size',N'1 1/2"'),(N'VF22-40-1-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF22-40-1-1-2IN-BSPT',N'Operating Pressure',N'3600 PSI'),
  (N'VF22-40-2IN-NPT',N'Size',N'2"'),(N'VF22-40-2IN-NPT',N'End Connection',N'NPT'),(N'VF22-40-2IN-NPT',N'Operating Pressure',N'3600 PSI'),
  (N'VF22-40-2IN-BSP',N'Size',N'2"'),(N'VF22-40-2IN-BSP',N'End Connection',N'BSP'),(N'VF22-40-2IN-BSP',N'Operating Pressure',N'3600 PSI'),
  (N'VF22-40-2IN-BSPT',N'Size',N'2"'),(N'VF22-40-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF22-40-2IN-BSPT',N'Operating Pressure',N'3600 PSI')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;
SELECT N'Series F22-40' AS Series, COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
GO

-- ===== Series F22-50 (24 products, quote-only Price NULL) =====
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series F22-50')
    INSERT INTO Categories (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures, Approvals)
    VALUES (N'Series F22-50', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'The Mars Series F22-50 is a 2-piece, full-port direct-mount high-pressure ball valve with threaded ends and a 17-4ph stem, rated to 6000 PSI with a fire-safe design. CF8M body with Delrin/Peek seats, in sizes 1/4" to 2".', N'CF8M', N'Delrin / Peek', N'Two Piece, Direct Mount, Full Port, High Pressure', N'2-piece full port direct mount high pressure design
Threaded ends (NPT, BSP, BSPT)
Rated to 6000 PSI
CF8M body, 17-4ph stem
Delrin / Peek seats
Size 1/4" to 2"
Fire-safe design', N'Fire-Safe');
GO
DECLARE @SeriesName nvarchar(100) = N'Series F22-50';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);
INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'End Connection'),(N'Operating Pressure')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);
INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'End Connection',0),(N'Size',1),(N'Operating Pressure',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);
INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VF22-50-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F22-50 Two Piece High Pressure Ball Valve', N'VF22-50 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 6000 PSI, Body CF8M, Seat Delrin / Peek, 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-50.jpg', NULL),
(N'VF22-50-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F22-50 Two Piece High Pressure Ball Valve', N'VF22-50 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 6000 PSI, Body CF8M, Seat Delrin / Peek, 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-50.jpg', NULL),
(N'VF22-50-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F22-50 Two Piece High Pressure Ball Valve', N'VF22-50 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 6000 PSI, Body CF8M, Seat Delrin / Peek, 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-50.jpg', NULL),
(N'VF22-50-3-8IN-NPT', @CategoryId, N'Active', N'Mars Series F22-50 Two Piece High Pressure Ball Valve', N'VF22-50 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 6000 PSI, Body CF8M, Seat Delrin / Peek, 3/8", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-50.jpg', NULL),
(N'VF22-50-3-8IN-BSP', @CategoryId, N'Active', N'Mars Series F22-50 Two Piece High Pressure Ball Valve', N'VF22-50 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 6000 PSI, Body CF8M, Seat Delrin / Peek, 3/8", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-50.jpg', NULL),
(N'VF22-50-3-8IN-BSPT', @CategoryId, N'Active', N'Mars Series F22-50 Two Piece High Pressure Ball Valve', N'VF22-50 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 6000 PSI, Body CF8M, Seat Delrin / Peek, 3/8", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-50.jpg', NULL),
(N'VF22-50-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F22-50 Two Piece High Pressure Ball Valve', N'VF22-50 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 6000 PSI, Body CF8M, Seat Delrin / Peek, 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-50.jpg', NULL),
(N'VF22-50-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F22-50 Two Piece High Pressure Ball Valve', N'VF22-50 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 6000 PSI, Body CF8M, Seat Delrin / Peek, 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-50.jpg', NULL),
(N'VF22-50-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F22-50 Two Piece High Pressure Ball Valve', N'VF22-50 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 6000 PSI, Body CF8M, Seat Delrin / Peek, 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-50.jpg', NULL),
(N'VF22-50-3-4IN-NPT', @CategoryId, N'Active', N'Mars Series F22-50 Two Piece High Pressure Ball Valve', N'VF22-50 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 6000 PSI, Body CF8M, Seat Delrin / Peek, 3/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-50.jpg', NULL),
(N'VF22-50-3-4IN-BSP', @CategoryId, N'Active', N'Mars Series F22-50 Two Piece High Pressure Ball Valve', N'VF22-50 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 6000 PSI, Body CF8M, Seat Delrin / Peek, 3/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-50.jpg', NULL),
(N'VF22-50-3-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F22-50 Two Piece High Pressure Ball Valve', N'VF22-50 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 6000 PSI, Body CF8M, Seat Delrin / Peek, 3/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-50.jpg', NULL),
(N'VF22-50-1IN-NPT', @CategoryId, N'Active', N'Mars Series F22-50 Two Piece High Pressure Ball Valve', N'VF22-50 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 6000 PSI, Body CF8M, Seat Delrin / Peek, 1", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-50.jpg', NULL),
(N'VF22-50-1IN-BSP', @CategoryId, N'Active', N'Mars Series F22-50 Two Piece High Pressure Ball Valve', N'VF22-50 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 6000 PSI, Body CF8M, Seat Delrin / Peek, 1", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-50.jpg', NULL),
(N'VF22-50-1IN-BSPT', @CategoryId, N'Active', N'Mars Series F22-50 Two Piece High Pressure Ball Valve', N'VF22-50 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 6000 PSI, Body CF8M, Seat Delrin / Peek, 1", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-50.jpg', NULL),
(N'VF22-50-1-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F22-50 Two Piece High Pressure Ball Valve', N'VF22-50 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 6000 PSI, Body CF8M, Seat Delrin / Peek, 1 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-50.jpg', NULL),
(N'VF22-50-1-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F22-50 Two Piece High Pressure Ball Valve', N'VF22-50 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 6000 PSI, Body CF8M, Seat Delrin / Peek, 1 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-50.jpg', NULL),
(N'VF22-50-1-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F22-50 Two Piece High Pressure Ball Valve', N'VF22-50 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 6000 PSI, Body CF8M, Seat Delrin / Peek, 1 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-50.jpg', NULL),
(N'VF22-50-1-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F22-50 Two Piece High Pressure Ball Valve', N'VF22-50 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 6000 PSI, Body CF8M, Seat Delrin / Peek, 1 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-50.jpg', NULL),
(N'VF22-50-1-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F22-50 Two Piece High Pressure Ball Valve', N'VF22-50 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 6000 PSI, Body CF8M, Seat Delrin / Peek, 1 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-50.jpg', NULL),
(N'VF22-50-1-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F22-50 Two Piece High Pressure Ball Valve', N'VF22-50 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 6000 PSI, Body CF8M, Seat Delrin / Peek, 1 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-50.jpg', NULL),
(N'VF22-50-2IN-NPT', @CategoryId, N'Active', N'Mars Series F22-50 Two Piece High Pressure Ball Valve', N'VF22-50 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 6000 PSI, Body CF8M, Seat Delrin / Peek, 2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-50.jpg', NULL),
(N'VF22-50-2IN-BSP', @CategoryId, N'Active', N'Mars Series F22-50 Two Piece High Pressure Ball Valve', N'VF22-50 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 6000 PSI, Body CF8M, Seat Delrin / Peek, 2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-50.jpg', NULL),
(N'VF22-50-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F22-50 Two Piece High Pressure Ball Valve', N'VF22-50 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, High Pressure, 6000 PSI, Body CF8M, Seat Delrin / Peek, 2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f22-50.jpg', NULL);
INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VF22-50-1-4IN-NPT',N'Size',N'1/4"'),(N'VF22-50-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF22-50-1-4IN-NPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF22-50-1-4IN-BSP',N'Size',N'1/4"'),(N'VF22-50-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF22-50-1-4IN-BSP',N'Operating Pressure',N'6000 PSI'),
  (N'VF22-50-1-4IN-BSPT',N'Size',N'1/4"'),(N'VF22-50-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF22-50-1-4IN-BSPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF22-50-3-8IN-NPT',N'Size',N'3/8"'),(N'VF22-50-3-8IN-NPT',N'End Connection',N'NPT'),(N'VF22-50-3-8IN-NPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF22-50-3-8IN-BSP',N'Size',N'3/8"'),(N'VF22-50-3-8IN-BSP',N'End Connection',N'BSP'),(N'VF22-50-3-8IN-BSP',N'Operating Pressure',N'6000 PSI'),
  (N'VF22-50-3-8IN-BSPT',N'Size',N'3/8"'),(N'VF22-50-3-8IN-BSPT',N'End Connection',N'BSPT'),(N'VF22-50-3-8IN-BSPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF22-50-1-2IN-NPT',N'Size',N'1/2"'),(N'VF22-50-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF22-50-1-2IN-NPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF22-50-1-2IN-BSP',N'Size',N'1/2"'),(N'VF22-50-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF22-50-1-2IN-BSP',N'Operating Pressure',N'6000 PSI'),
  (N'VF22-50-1-2IN-BSPT',N'Size',N'1/2"'),(N'VF22-50-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF22-50-1-2IN-BSPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF22-50-3-4IN-NPT',N'Size',N'3/4"'),(N'VF22-50-3-4IN-NPT',N'End Connection',N'NPT'),(N'VF22-50-3-4IN-NPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF22-50-3-4IN-BSP',N'Size',N'3/4"'),(N'VF22-50-3-4IN-BSP',N'End Connection',N'BSP'),(N'VF22-50-3-4IN-BSP',N'Operating Pressure',N'6000 PSI'),
  (N'VF22-50-3-4IN-BSPT',N'Size',N'3/4"'),(N'VF22-50-3-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF22-50-3-4IN-BSPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF22-50-1IN-NPT',N'Size',N'1"'),(N'VF22-50-1IN-NPT',N'End Connection',N'NPT'),(N'VF22-50-1IN-NPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF22-50-1IN-BSP',N'Size',N'1"'),(N'VF22-50-1IN-BSP',N'End Connection',N'BSP'),(N'VF22-50-1IN-BSP',N'Operating Pressure',N'6000 PSI'),
  (N'VF22-50-1IN-BSPT',N'Size',N'1"'),(N'VF22-50-1IN-BSPT',N'End Connection',N'BSPT'),(N'VF22-50-1IN-BSPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF22-50-1-1-4IN-NPT',N'Size',N'1 1/4"'),(N'VF22-50-1-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF22-50-1-1-4IN-NPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF22-50-1-1-4IN-BSP',N'Size',N'1 1/4"'),(N'VF22-50-1-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF22-50-1-1-4IN-BSP',N'Operating Pressure',N'6000 PSI'),
  (N'VF22-50-1-1-4IN-BSPT',N'Size',N'1 1/4"'),(N'VF22-50-1-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF22-50-1-1-4IN-BSPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF22-50-1-1-2IN-NPT',N'Size',N'1 1/2"'),(N'VF22-50-1-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF22-50-1-1-2IN-NPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF22-50-1-1-2IN-BSP',N'Size',N'1 1/2"'),(N'VF22-50-1-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF22-50-1-1-2IN-BSP',N'Operating Pressure',N'6000 PSI'),
  (N'VF22-50-1-1-2IN-BSPT',N'Size',N'1 1/2"'),(N'VF22-50-1-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF22-50-1-1-2IN-BSPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF22-50-2IN-NPT',N'Size',N'2"'),(N'VF22-50-2IN-NPT',N'End Connection',N'NPT'),(N'VF22-50-2IN-NPT',N'Operating Pressure',N'6000 PSI'),
  (N'VF22-50-2IN-BSP',N'Size',N'2"'),(N'VF22-50-2IN-BSP',N'End Connection',N'BSP'),(N'VF22-50-2IN-BSP',N'Operating Pressure',N'6000 PSI'),
  (N'VF22-50-2IN-BSPT',N'Size',N'2"'),(N'VF22-50-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF22-50-2IN-BSPT',N'Operating Pressure',N'6000 PSI')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;
SELECT N'Series F22-50' AS Series, COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
GO
