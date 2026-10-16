-- High-performance 2-piece quote-only batch: Series 28, 20-50, F20-80.
-- Run the whole file in SSMS; GO splits the batches.

-- ===== Series 28 (30 products, quote-only Price NULL) =====
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 28')
    INSERT INTO Categories (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures, Approvals)
    VALUES (N'Series 28', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'The Mars Series 28 is a 2-piece, full-port fire-safe ball valve with a seal-welded design and threaded ends, rated to 1000 PSI and certified to API 607 (7th Edition). CF8M or WCB body with PTFE/RTFE seats, in sizes 1/4" to 3". Optional NACE MR0175 and DIN 3202 M3 face-to-face on request.', N'CF8M / WCB', N'PTFE / RTFE', N'Two Piece, Fire-Safe, Full Port, Seal Welded', N'2-piece full port fire-safe design
Seal welded body
Threaded ends (NPT, BSP, BSPT)
Rated to 1000 PSI
CF8M or WCB body
PTFE / RTFE seats
Size 1/4" to 3"
Fire-safe API 607, 7th Edition
Optional NACE MR0175
Optional DIN 3202 M3 face-to-face', N'Fire-Safe API 607, 7th Edition');
GO
DECLARE @SeriesName nvarchar(100) = N'Series 28';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);
INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'End Connection'),(N'Operating Pressure')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);
INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'End Connection',0),(N'Size',1),(N'Operating Pressure',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);
INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'V28-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-3-8IN-NPT', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-3-8IN-BSP', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-3-8IN-BSPT', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-3-4IN-NPT', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-3-4IN-BSP', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-3-4IN-BSPT', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-1IN-NPT', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-1IN-BSP', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-1IN-BSPT', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-1-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-1-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-1-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-1-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-1-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-1-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-2IN-NPT', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-2IN-BSP', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-2IN-BSPT', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-2-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-2-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-2-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-3IN-NPT', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-3IN-BSP', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL),
(N'V28-3IN-BSPT', @CategoryId, N'Active', N'Mars Series 28 Two Piece Fire-Safe Ball Valve', N'V28 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, Seal Welded, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-28.jpg', NULL);
INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'V28-1-4IN-NPT',N'Size',N'1/4"'),(N'V28-1-4IN-NPT',N'End Connection',N'NPT'),(N'V28-1-4IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'V28-1-4IN-BSP',N'Size',N'1/4"'),(N'V28-1-4IN-BSP',N'End Connection',N'BSP'),(N'V28-1-4IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'V28-1-4IN-BSPT',N'Size',N'1/4"'),(N'V28-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'V28-1-4IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'V28-3-8IN-NPT',N'Size',N'3/8"'),(N'V28-3-8IN-NPT',N'End Connection',N'NPT'),(N'V28-3-8IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'V28-3-8IN-BSP',N'Size',N'3/8"'),(N'V28-3-8IN-BSP',N'End Connection',N'BSP'),(N'V28-3-8IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'V28-3-8IN-BSPT',N'Size',N'3/8"'),(N'V28-3-8IN-BSPT',N'End Connection',N'BSPT'),(N'V28-3-8IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'V28-1-2IN-NPT',N'Size',N'1/2"'),(N'V28-1-2IN-NPT',N'End Connection',N'NPT'),(N'V28-1-2IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'V28-1-2IN-BSP',N'Size',N'1/2"'),(N'V28-1-2IN-BSP',N'End Connection',N'BSP'),(N'V28-1-2IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'V28-1-2IN-BSPT',N'Size',N'1/2"'),(N'V28-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'V28-1-2IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'V28-3-4IN-NPT',N'Size',N'3/4"'),(N'V28-3-4IN-NPT',N'End Connection',N'NPT'),(N'V28-3-4IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'V28-3-4IN-BSP',N'Size',N'3/4"'),(N'V28-3-4IN-BSP',N'End Connection',N'BSP'),(N'V28-3-4IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'V28-3-4IN-BSPT',N'Size',N'3/4"'),(N'V28-3-4IN-BSPT',N'End Connection',N'BSPT'),(N'V28-3-4IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'V28-1IN-NPT',N'Size',N'1"'),(N'V28-1IN-NPT',N'End Connection',N'NPT'),(N'V28-1IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'V28-1IN-BSP',N'Size',N'1"'),(N'V28-1IN-BSP',N'End Connection',N'BSP'),(N'V28-1IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'V28-1IN-BSPT',N'Size',N'1"'),(N'V28-1IN-BSPT',N'End Connection',N'BSPT'),(N'V28-1IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'V28-1-1-4IN-NPT',N'Size',N'1 1/4"'),(N'V28-1-1-4IN-NPT',N'End Connection',N'NPT'),(N'V28-1-1-4IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'V28-1-1-4IN-BSP',N'Size',N'1 1/4"'),(N'V28-1-1-4IN-BSP',N'End Connection',N'BSP'),(N'V28-1-1-4IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'V28-1-1-4IN-BSPT',N'Size',N'1 1/4"'),(N'V28-1-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'V28-1-1-4IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'V28-1-1-2IN-NPT',N'Size',N'1 1/2"'),(N'V28-1-1-2IN-NPT',N'End Connection',N'NPT'),(N'V28-1-1-2IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'V28-1-1-2IN-BSP',N'Size',N'1 1/2"'),(N'V28-1-1-2IN-BSP',N'End Connection',N'BSP'),(N'V28-1-1-2IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'V28-1-1-2IN-BSPT',N'Size',N'1 1/2"'),(N'V28-1-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'V28-1-1-2IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'V28-2IN-NPT',N'Size',N'2"'),(N'V28-2IN-NPT',N'End Connection',N'NPT'),(N'V28-2IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'V28-2IN-BSP',N'Size',N'2"'),(N'V28-2IN-BSP',N'End Connection',N'BSP'),(N'V28-2IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'V28-2IN-BSPT',N'Size',N'2"'),(N'V28-2IN-BSPT',N'End Connection',N'BSPT'),(N'V28-2IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'V28-2-1-2IN-NPT',N'Size',N'2 1/2"'),(N'V28-2-1-2IN-NPT',N'End Connection',N'NPT'),(N'V28-2-1-2IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'V28-2-1-2IN-BSP',N'Size',N'2 1/2"'),(N'V28-2-1-2IN-BSP',N'End Connection',N'BSP'),(N'V28-2-1-2IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'V28-2-1-2IN-BSPT',N'Size',N'2 1/2"'),(N'V28-2-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'V28-2-1-2IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'V28-3IN-NPT',N'Size',N'3"'),(N'V28-3IN-NPT',N'End Connection',N'NPT'),(N'V28-3IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'V28-3IN-BSP',N'Size',N'3"'),(N'V28-3IN-BSP',N'End Connection',N'BSP'),(N'V28-3IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'V28-3IN-BSPT',N'Size',N'3"'),(N'V28-3IN-BSPT',N'End Connection',N'BSPT'),(N'V28-3IN-BSPT',N'Operating Pressure',N'1000 PSI')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;
SELECT N'Series 28' AS Series, COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
GO

-- ===== Series 20-50 (30 products, quote-only Price NULL) =====
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 20-50')
    INSERT INTO Categories (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures)
    VALUES (N'Series 20-50', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'The Mars Series 20-50 is a 2-piece, full-port ball valve with an ISO 5211 mounting pad and threaded ends, rated to 1000 PSI. CF8M or WCB body with PTFE/RTFE seats, in sizes 1/4" to 3". Optional NACE MR0175 on request.', N'CF8M / WCB', N'PTFE / RTFE', N'Two Piece, Full Port, ISO 5211 Mounting Pad', N'2-piece full port design
ISO 5211 mounting pad for actuation
Threaded ends (NPT, BSP, BSPT)
Rated to 1000 PSI
CF8M or WCB body
PTFE / RTFE seats
Size 1/4" to 3"
Optional NACE MR0175');
GO
DECLARE @SeriesName nvarchar(100) = N'Series 20-50';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);
INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'End Connection'),(N'Operating Pressure')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);
INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'End Connection',0),(N'Size',1),(N'Operating Pressure',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);
INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'V20-50-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-3-8IN-NPT', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-3-8IN-BSP', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-3-8IN-BSPT', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-3-4IN-NPT', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-3-4IN-BSP', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-3-4IN-BSPT', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-1IN-NPT', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-1IN-BSP', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-1IN-BSPT', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-1-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-1-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-1-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-1-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-1-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-1-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-2IN-NPT', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-2IN-BSP', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-2IN-BSPT', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-2-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-2-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-2-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-3IN-NPT', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-3IN-BSP', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL),
(N'V20-50-3IN-BSPT', @CategoryId, N'Active', N'Mars Series 20-50 Two Piece Ball Valve', N'V20-50 - 2-PC Ball Valve, Two Piece, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-20-50.jpg', NULL);
INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'V20-50-1-4IN-NPT',N'Size',N'1/4"'),(N'V20-50-1-4IN-NPT',N'End Connection',N'NPT'),(N'V20-50-1-4IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-1-4IN-BSP',N'Size',N'1/4"'),(N'V20-50-1-4IN-BSP',N'End Connection',N'BSP'),(N'V20-50-1-4IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-1-4IN-BSPT',N'Size',N'1/4"'),(N'V20-50-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'V20-50-1-4IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-3-8IN-NPT',N'Size',N'3/8"'),(N'V20-50-3-8IN-NPT',N'End Connection',N'NPT'),(N'V20-50-3-8IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-3-8IN-BSP',N'Size',N'3/8"'),(N'V20-50-3-8IN-BSP',N'End Connection',N'BSP'),(N'V20-50-3-8IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-3-8IN-BSPT',N'Size',N'3/8"'),(N'V20-50-3-8IN-BSPT',N'End Connection',N'BSPT'),(N'V20-50-3-8IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-1-2IN-NPT',N'Size',N'1/2"'),(N'V20-50-1-2IN-NPT',N'End Connection',N'NPT'),(N'V20-50-1-2IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-1-2IN-BSP',N'Size',N'1/2"'),(N'V20-50-1-2IN-BSP',N'End Connection',N'BSP'),(N'V20-50-1-2IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-1-2IN-BSPT',N'Size',N'1/2"'),(N'V20-50-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'V20-50-1-2IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-3-4IN-NPT',N'Size',N'3/4"'),(N'V20-50-3-4IN-NPT',N'End Connection',N'NPT'),(N'V20-50-3-4IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-3-4IN-BSP',N'Size',N'3/4"'),(N'V20-50-3-4IN-BSP',N'End Connection',N'BSP'),(N'V20-50-3-4IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-3-4IN-BSPT',N'Size',N'3/4"'),(N'V20-50-3-4IN-BSPT',N'End Connection',N'BSPT'),(N'V20-50-3-4IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-1IN-NPT',N'Size',N'1"'),(N'V20-50-1IN-NPT',N'End Connection',N'NPT'),(N'V20-50-1IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-1IN-BSP',N'Size',N'1"'),(N'V20-50-1IN-BSP',N'End Connection',N'BSP'),(N'V20-50-1IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-1IN-BSPT',N'Size',N'1"'),(N'V20-50-1IN-BSPT',N'End Connection',N'BSPT'),(N'V20-50-1IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-1-1-4IN-NPT',N'Size',N'1 1/4"'),(N'V20-50-1-1-4IN-NPT',N'End Connection',N'NPT'),(N'V20-50-1-1-4IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-1-1-4IN-BSP',N'Size',N'1 1/4"'),(N'V20-50-1-1-4IN-BSP',N'End Connection',N'BSP'),(N'V20-50-1-1-4IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-1-1-4IN-BSPT',N'Size',N'1 1/4"'),(N'V20-50-1-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'V20-50-1-1-4IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-1-1-2IN-NPT',N'Size',N'1 1/2"'),(N'V20-50-1-1-2IN-NPT',N'End Connection',N'NPT'),(N'V20-50-1-1-2IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-1-1-2IN-BSP',N'Size',N'1 1/2"'),(N'V20-50-1-1-2IN-BSP',N'End Connection',N'BSP'),(N'V20-50-1-1-2IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-1-1-2IN-BSPT',N'Size',N'1 1/2"'),(N'V20-50-1-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'V20-50-1-1-2IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-2IN-NPT',N'Size',N'2"'),(N'V20-50-2IN-NPT',N'End Connection',N'NPT'),(N'V20-50-2IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-2IN-BSP',N'Size',N'2"'),(N'V20-50-2IN-BSP',N'End Connection',N'BSP'),(N'V20-50-2IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-2IN-BSPT',N'Size',N'2"'),(N'V20-50-2IN-BSPT',N'End Connection',N'BSPT'),(N'V20-50-2IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-2-1-2IN-NPT',N'Size',N'2 1/2"'),(N'V20-50-2-1-2IN-NPT',N'End Connection',N'NPT'),(N'V20-50-2-1-2IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-2-1-2IN-BSP',N'Size',N'2 1/2"'),(N'V20-50-2-1-2IN-BSP',N'End Connection',N'BSP'),(N'V20-50-2-1-2IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-2-1-2IN-BSPT',N'Size',N'2 1/2"'),(N'V20-50-2-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'V20-50-2-1-2IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-3IN-NPT',N'Size',N'3"'),(N'V20-50-3IN-NPT',N'End Connection',N'NPT'),(N'V20-50-3IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-3IN-BSP',N'Size',N'3"'),(N'V20-50-3IN-BSP',N'End Connection',N'BSP'),(N'V20-50-3IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'V20-50-3IN-BSPT',N'Size',N'3"'),(N'V20-50-3IN-BSPT',N'End Connection',N'BSPT'),(N'V20-50-3IN-BSPT',N'Operating Pressure',N'1000 PSI')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;
SELECT N'Series 20-50' AS Series, COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
GO

-- ===== Series F20-80 (24 products, quote-only Price NULL) =====
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series F20-80')
    INSERT INTO Categories (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures)
    VALUES (N'Series F20-80', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'The Mars Series F20-80 is a 2-piece, full-port direct-mount ball valve with threaded ends, rated to 1500 PSI. CF8M or WCB body with PTFE/RTFE/TFM1600 seats, in sizes 1/4" to 2".', N'CF8M / WCB', N'PTFE / RTFE / TFM1600', N'Two Piece, Direct Mount, Full Port', N'2-piece full port direct mount design
Threaded ends (NPT, BSP, BSPT)
Rated to 1500 PSI
CF8M or WCB body
PTFE / RTFE / TFM1600 seats
Size 1/4" to 2"');
GO
DECLARE @SeriesName nvarchar(100) = N'Series F20-80';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);
INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'End Connection'),(N'Operating Pressure')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);
INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'End Connection',0),(N'Size',1),(N'Operating Pressure',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);
INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VF20-80-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F20-80 Two Piece Ball Valve', N'VF20-80 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, 1500 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f20-80.jpg', NULL),
(N'VF20-80-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F20-80 Two Piece Ball Valve', N'VF20-80 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, 1500 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f20-80.jpg', NULL),
(N'VF20-80-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F20-80 Two Piece Ball Valve', N'VF20-80 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, 1500 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f20-80.jpg', NULL),
(N'VF20-80-3-8IN-NPT', @CategoryId, N'Active', N'Mars Series F20-80 Two Piece Ball Valve', N'VF20-80 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, 1500 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 3/8", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f20-80.jpg', NULL),
(N'VF20-80-3-8IN-BSP', @CategoryId, N'Active', N'Mars Series F20-80 Two Piece Ball Valve', N'VF20-80 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, 1500 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 3/8", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f20-80.jpg', NULL),
(N'VF20-80-3-8IN-BSPT', @CategoryId, N'Active', N'Mars Series F20-80 Two Piece Ball Valve', N'VF20-80 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, 1500 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 3/8", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f20-80.jpg', NULL),
(N'VF20-80-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F20-80 Two Piece Ball Valve', N'VF20-80 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, 1500 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f20-80.jpg', NULL),
(N'VF20-80-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F20-80 Two Piece Ball Valve', N'VF20-80 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, 1500 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f20-80.jpg', NULL),
(N'VF20-80-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F20-80 Two Piece Ball Valve', N'VF20-80 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, 1500 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f20-80.jpg', NULL),
(N'VF20-80-3-4IN-NPT', @CategoryId, N'Active', N'Mars Series F20-80 Two Piece Ball Valve', N'VF20-80 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, 1500 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 3/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f20-80.jpg', NULL),
(N'VF20-80-3-4IN-BSP', @CategoryId, N'Active', N'Mars Series F20-80 Two Piece Ball Valve', N'VF20-80 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, 1500 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 3/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f20-80.jpg', NULL),
(N'VF20-80-3-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F20-80 Two Piece Ball Valve', N'VF20-80 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, 1500 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 3/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f20-80.jpg', NULL),
(N'VF20-80-1IN-NPT', @CategoryId, N'Active', N'Mars Series F20-80 Two Piece Ball Valve', N'VF20-80 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, 1500 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f20-80.jpg', NULL),
(N'VF20-80-1IN-BSP', @CategoryId, N'Active', N'Mars Series F20-80 Two Piece Ball Valve', N'VF20-80 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, 1500 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f20-80.jpg', NULL),
(N'VF20-80-1IN-BSPT', @CategoryId, N'Active', N'Mars Series F20-80 Two Piece Ball Valve', N'VF20-80 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, 1500 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f20-80.jpg', NULL),
(N'VF20-80-1-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F20-80 Two Piece Ball Valve', N'VF20-80 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, 1500 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f20-80.jpg', NULL),
(N'VF20-80-1-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F20-80 Two Piece Ball Valve', N'VF20-80 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, 1500 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f20-80.jpg', NULL),
(N'VF20-80-1-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F20-80 Two Piece Ball Valve', N'VF20-80 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, 1500 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f20-80.jpg', NULL),
(N'VF20-80-1-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F20-80 Two Piece Ball Valve', N'VF20-80 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, 1500 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f20-80.jpg', NULL),
(N'VF20-80-1-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F20-80 Two Piece Ball Valve', N'VF20-80 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, 1500 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f20-80.jpg', NULL),
(N'VF20-80-1-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F20-80 Two Piece Ball Valve', N'VF20-80 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, 1500 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 1 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f20-80.jpg', NULL),
(N'VF20-80-2IN-NPT', @CategoryId, N'Active', N'Mars Series F20-80 Two Piece Ball Valve', N'VF20-80 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, 1500 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f20-80.jpg', NULL),
(N'VF20-80-2IN-BSP', @CategoryId, N'Active', N'Mars Series F20-80 Two Piece Ball Valve', N'VF20-80 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, 1500 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f20-80.jpg', NULL),
(N'VF20-80-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F20-80 Two Piece Ball Valve', N'VF20-80 - 2-PC Ball Valve, Two Piece, Direct Mount, Full Port, 1500 PSI, Body CF8M / WCB, Seat PTFE / RTFE / TFM1600, 2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f20-80.jpg', NULL);
INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VF20-80-1-4IN-NPT',N'Size',N'1/4"'),(N'VF20-80-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF20-80-1-4IN-NPT',N'Operating Pressure',N'1500 PSI'),
  (N'VF20-80-1-4IN-BSP',N'Size',N'1/4"'),(N'VF20-80-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF20-80-1-4IN-BSP',N'Operating Pressure',N'1500 PSI'),
  (N'VF20-80-1-4IN-BSPT',N'Size',N'1/4"'),(N'VF20-80-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF20-80-1-4IN-BSPT',N'Operating Pressure',N'1500 PSI'),
  (N'VF20-80-3-8IN-NPT',N'Size',N'3/8"'),(N'VF20-80-3-8IN-NPT',N'End Connection',N'NPT'),(N'VF20-80-3-8IN-NPT',N'Operating Pressure',N'1500 PSI'),
  (N'VF20-80-3-8IN-BSP',N'Size',N'3/8"'),(N'VF20-80-3-8IN-BSP',N'End Connection',N'BSP'),(N'VF20-80-3-8IN-BSP',N'Operating Pressure',N'1500 PSI'),
  (N'VF20-80-3-8IN-BSPT',N'Size',N'3/8"'),(N'VF20-80-3-8IN-BSPT',N'End Connection',N'BSPT'),(N'VF20-80-3-8IN-BSPT',N'Operating Pressure',N'1500 PSI'),
  (N'VF20-80-1-2IN-NPT',N'Size',N'1/2"'),(N'VF20-80-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF20-80-1-2IN-NPT',N'Operating Pressure',N'1500 PSI'),
  (N'VF20-80-1-2IN-BSP',N'Size',N'1/2"'),(N'VF20-80-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF20-80-1-2IN-BSP',N'Operating Pressure',N'1500 PSI'),
  (N'VF20-80-1-2IN-BSPT',N'Size',N'1/2"'),(N'VF20-80-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF20-80-1-2IN-BSPT',N'Operating Pressure',N'1500 PSI'),
  (N'VF20-80-3-4IN-NPT',N'Size',N'3/4"'),(N'VF20-80-3-4IN-NPT',N'End Connection',N'NPT'),(N'VF20-80-3-4IN-NPT',N'Operating Pressure',N'1500 PSI'),
  (N'VF20-80-3-4IN-BSP',N'Size',N'3/4"'),(N'VF20-80-3-4IN-BSP',N'End Connection',N'BSP'),(N'VF20-80-3-4IN-BSP',N'Operating Pressure',N'1500 PSI'),
  (N'VF20-80-3-4IN-BSPT',N'Size',N'3/4"'),(N'VF20-80-3-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF20-80-3-4IN-BSPT',N'Operating Pressure',N'1500 PSI'),
  (N'VF20-80-1IN-NPT',N'Size',N'1"'),(N'VF20-80-1IN-NPT',N'End Connection',N'NPT'),(N'VF20-80-1IN-NPT',N'Operating Pressure',N'1500 PSI'),
  (N'VF20-80-1IN-BSP',N'Size',N'1"'),(N'VF20-80-1IN-BSP',N'End Connection',N'BSP'),(N'VF20-80-1IN-BSP',N'Operating Pressure',N'1500 PSI'),
  (N'VF20-80-1IN-BSPT',N'Size',N'1"'),(N'VF20-80-1IN-BSPT',N'End Connection',N'BSPT'),(N'VF20-80-1IN-BSPT',N'Operating Pressure',N'1500 PSI'),
  (N'VF20-80-1-1-4IN-NPT',N'Size',N'1 1/4"'),(N'VF20-80-1-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF20-80-1-1-4IN-NPT',N'Operating Pressure',N'1500 PSI'),
  (N'VF20-80-1-1-4IN-BSP',N'Size',N'1 1/4"'),(N'VF20-80-1-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF20-80-1-1-4IN-BSP',N'Operating Pressure',N'1500 PSI'),
  (N'VF20-80-1-1-4IN-BSPT',N'Size',N'1 1/4"'),(N'VF20-80-1-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF20-80-1-1-4IN-BSPT',N'Operating Pressure',N'1500 PSI'),
  (N'VF20-80-1-1-2IN-NPT',N'Size',N'1 1/2"'),(N'VF20-80-1-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF20-80-1-1-2IN-NPT',N'Operating Pressure',N'1500 PSI'),
  (N'VF20-80-1-1-2IN-BSP',N'Size',N'1 1/2"'),(N'VF20-80-1-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF20-80-1-1-2IN-BSP',N'Operating Pressure',N'1500 PSI'),
  (N'VF20-80-1-1-2IN-BSPT',N'Size',N'1 1/2"'),(N'VF20-80-1-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF20-80-1-1-2IN-BSPT',N'Operating Pressure',N'1500 PSI'),
  (N'VF20-80-2IN-NPT',N'Size',N'2"'),(N'VF20-80-2IN-NPT',N'End Connection',N'NPT'),(N'VF20-80-2IN-NPT',N'Operating Pressure',N'1500 PSI'),
  (N'VF20-80-2IN-BSP',N'Size',N'2"'),(N'VF20-80-2IN-BSP',N'End Connection',N'BSP'),(N'VF20-80-2IN-BSP',N'Operating Pressure',N'1500 PSI'),
  (N'VF20-80-2IN-BSPT',N'Size',N'2"'),(N'VF20-80-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF20-80-2IN-BSPT',N'Operating Pressure',N'1500 PSI')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;
SELECT N'Series F20-80' AS Series, COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
GO
