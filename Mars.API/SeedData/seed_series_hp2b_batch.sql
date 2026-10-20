-- High-performance 2-piece quote-only batch 2: F202D, F21-10, F21-20.
-- Run the whole file in SSMS; GO splits the batches.

-- ===== Series F202D (33 products, quote-only Price NULL) =====
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series F202D')
    INSERT INTO Categories (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures)
    VALUES (N'Series F202D', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'The Mars Series F202D is a 2-piece, seal-welded direct-mount, full-port ball valve with threaded ends, rated to 2000 PSI. CF8M or WCB body with TFM1600 seats, in sizes 1/4" to 4". Available with deadman handle, oval handle, TSM unit / extended bonnet.', N'CF8M / WCB', N'TFM1600', N'Two Piece, Seal Welded, Direct Mount, Full Port', N'2-piece seal welded direct mount design
Full port
Threaded ends (NPT, BSP, BSPT)
Rated to 2000 PSI
CF8M or WCB body
TFM1600 seats
Size 1/4" to 4"
Deadman handle / oval handle
TSM unit / extended bonnet');
GO
DECLARE @SeriesName nvarchar(100) = N'Series F202D';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);
INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'End Connection'),(N'Operating Pressure')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);
INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'End Connection',0),(N'Size',1),(N'Operating Pressure',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);
INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VF202D-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-3-8IN-NPT', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 3/8", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-3-8IN-BSP', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 3/8", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-3-8IN-BSPT', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 3/8", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-3-4IN-NPT', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 3/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-3-4IN-BSP', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 3/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-3-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 3/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-1IN-NPT', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 1", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-1IN-BSP', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 1", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-1IN-BSPT', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 1", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-1-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 1 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-1-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 1 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-1-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 1 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-1-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 1 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-1-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 1 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-1-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 1 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-2IN-NPT', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-2IN-BSP', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-2-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 2 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-2-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 2 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-2-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 2 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-3IN-NPT', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 3", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-3IN-BSP', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 3", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-3IN-BSPT', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 3", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-4IN-NPT', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-4IN-BSP', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL),
(N'VF202D-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F202D Two Piece Seal Welded Ball Valve', N'VF202D - 2-PC Ball Valve, Two Piece, Seal Welded, Direct Mount, Full Port, 2000 PSI, Body CF8M / WCB, Seat TFM1600, 4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f202d.jpg', NULL);
INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VF202D-1-4IN-NPT',N'Size',N'1/4"'),(N'VF202D-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF202D-1-4IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-1-4IN-BSP',N'Size',N'1/4"'),(N'VF202D-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF202D-1-4IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-1-4IN-BSPT',N'Size',N'1/4"'),(N'VF202D-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF202D-1-4IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-3-8IN-NPT',N'Size',N'3/8"'),(N'VF202D-3-8IN-NPT',N'End Connection',N'NPT'),(N'VF202D-3-8IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-3-8IN-BSP',N'Size',N'3/8"'),(N'VF202D-3-8IN-BSP',N'End Connection',N'BSP'),(N'VF202D-3-8IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-3-8IN-BSPT',N'Size',N'3/8"'),(N'VF202D-3-8IN-BSPT',N'End Connection',N'BSPT'),(N'VF202D-3-8IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-1-2IN-NPT',N'Size',N'1/2"'),(N'VF202D-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF202D-1-2IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-1-2IN-BSP',N'Size',N'1/2"'),(N'VF202D-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF202D-1-2IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-1-2IN-BSPT',N'Size',N'1/2"'),(N'VF202D-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF202D-1-2IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-3-4IN-NPT',N'Size',N'3/4"'),(N'VF202D-3-4IN-NPT',N'End Connection',N'NPT'),(N'VF202D-3-4IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-3-4IN-BSP',N'Size',N'3/4"'),(N'VF202D-3-4IN-BSP',N'End Connection',N'BSP'),(N'VF202D-3-4IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-3-4IN-BSPT',N'Size',N'3/4"'),(N'VF202D-3-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF202D-3-4IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-1IN-NPT',N'Size',N'1"'),(N'VF202D-1IN-NPT',N'End Connection',N'NPT'),(N'VF202D-1IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-1IN-BSP',N'Size',N'1"'),(N'VF202D-1IN-BSP',N'End Connection',N'BSP'),(N'VF202D-1IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-1IN-BSPT',N'Size',N'1"'),(N'VF202D-1IN-BSPT',N'End Connection',N'BSPT'),(N'VF202D-1IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-1-1-4IN-NPT',N'Size',N'1 1/4"'),(N'VF202D-1-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF202D-1-1-4IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-1-1-4IN-BSP',N'Size',N'1 1/4"'),(N'VF202D-1-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF202D-1-1-4IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-1-1-4IN-BSPT',N'Size',N'1 1/4"'),(N'VF202D-1-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF202D-1-1-4IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-1-1-2IN-NPT',N'Size',N'1 1/2"'),(N'VF202D-1-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF202D-1-1-2IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-1-1-2IN-BSP',N'Size',N'1 1/2"'),(N'VF202D-1-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF202D-1-1-2IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-1-1-2IN-BSPT',N'Size',N'1 1/2"'),(N'VF202D-1-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF202D-1-1-2IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-2IN-NPT',N'Size',N'2"'),(N'VF202D-2IN-NPT',N'End Connection',N'NPT'),(N'VF202D-2IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-2IN-BSP',N'Size',N'2"'),(N'VF202D-2IN-BSP',N'End Connection',N'BSP'),(N'VF202D-2IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-2IN-BSPT',N'Size',N'2"'),(N'VF202D-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF202D-2IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-2-1-2IN-NPT',N'Size',N'2 1/2"'),(N'VF202D-2-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF202D-2-1-2IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-2-1-2IN-BSP',N'Size',N'2 1/2"'),(N'VF202D-2-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF202D-2-1-2IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-2-1-2IN-BSPT',N'Size',N'2 1/2"'),(N'VF202D-2-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF202D-2-1-2IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-3IN-NPT',N'Size',N'3"'),(N'VF202D-3IN-NPT',N'End Connection',N'NPT'),(N'VF202D-3IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-3IN-BSP',N'Size',N'3"'),(N'VF202D-3IN-BSP',N'End Connection',N'BSP'),(N'VF202D-3IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-3IN-BSPT',N'Size',N'3"'),(N'VF202D-3IN-BSPT',N'End Connection',N'BSPT'),(N'VF202D-3IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-4IN-NPT',N'Size',N'4"'),(N'VF202D-4IN-NPT',N'End Connection',N'NPT'),(N'VF202D-4IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-4IN-BSP',N'Size',N'4"'),(N'VF202D-4IN-BSP',N'End Connection',N'BSP'),(N'VF202D-4IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF202D-4IN-BSPT',N'Size',N'4"'),(N'VF202D-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF202D-4IN-BSPT',N'Operating Pressure',N'2000 PSI')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;
SELECT N'Series F202D' AS Series, COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
GO

-- ===== Series F21-10 (24 products, quote-only Price NULL) =====
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series F21-10')
    INSERT INTO Categories (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures, Approvals)
    VALUES (N'Series F21-10', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'The Mars Series F21-10 is a 2-piece, full-port ball valve with an SRS handle and threaded ends, rated to 2000 PSI and conforming to ASME B16.34. CF8M body with RTFE seats, in sizes 1/4" to 2".', N'CF8M', N'RTFE', N'Two Piece, Full Port, SRS Handle, ASME B16.34', N'2-piece full port design with SRS handle
Threaded ends (NPT, BSP, BSPT)
Rated to 2000 PSI
CF8M body
RTFE seats
Size 1/4" to 2"
Conforms to ASME B16.34', N'ASME B16.34');
GO
DECLARE @SeriesName nvarchar(100) = N'Series F21-10';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);
INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'End Connection'),(N'Operating Pressure')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);
INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'End Connection',0),(N'Size',1),(N'Operating Pressure',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);
INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VF21-10-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F21-10 Two Piece Ball Valve', N'VF21-10 - 2-PC Ball Valve, Two Piece, Full Port, SRS Handle, ASME B16.34, 2000 PSI, Body CF8M, Seat RTFE, 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-10.jpg', NULL),
(N'VF21-10-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F21-10 Two Piece Ball Valve', N'VF21-10 - 2-PC Ball Valve, Two Piece, Full Port, SRS Handle, ASME B16.34, 2000 PSI, Body CF8M, Seat RTFE, 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-10.jpg', NULL),
(N'VF21-10-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-10 Two Piece Ball Valve', N'VF21-10 - 2-PC Ball Valve, Two Piece, Full Port, SRS Handle, ASME B16.34, 2000 PSI, Body CF8M, Seat RTFE, 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-10.jpg', NULL),
(N'VF21-10-3-8IN-NPT', @CategoryId, N'Active', N'Mars Series F21-10 Two Piece Ball Valve', N'VF21-10 - 2-PC Ball Valve, Two Piece, Full Port, SRS Handle, ASME B16.34, 2000 PSI, Body CF8M, Seat RTFE, 3/8", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-10.jpg', NULL),
(N'VF21-10-3-8IN-BSP', @CategoryId, N'Active', N'Mars Series F21-10 Two Piece Ball Valve', N'VF21-10 - 2-PC Ball Valve, Two Piece, Full Port, SRS Handle, ASME B16.34, 2000 PSI, Body CF8M, Seat RTFE, 3/8", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-10.jpg', NULL),
(N'VF21-10-3-8IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-10 Two Piece Ball Valve', N'VF21-10 - 2-PC Ball Valve, Two Piece, Full Port, SRS Handle, ASME B16.34, 2000 PSI, Body CF8M, Seat RTFE, 3/8", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-10.jpg', NULL),
(N'VF21-10-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F21-10 Two Piece Ball Valve', N'VF21-10 - 2-PC Ball Valve, Two Piece, Full Port, SRS Handle, ASME B16.34, 2000 PSI, Body CF8M, Seat RTFE, 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-10.jpg', NULL),
(N'VF21-10-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F21-10 Two Piece Ball Valve', N'VF21-10 - 2-PC Ball Valve, Two Piece, Full Port, SRS Handle, ASME B16.34, 2000 PSI, Body CF8M, Seat RTFE, 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-10.jpg', NULL),
(N'VF21-10-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-10 Two Piece Ball Valve', N'VF21-10 - 2-PC Ball Valve, Two Piece, Full Port, SRS Handle, ASME B16.34, 2000 PSI, Body CF8M, Seat RTFE, 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-10.jpg', NULL),
(N'VF21-10-3-4IN-NPT', @CategoryId, N'Active', N'Mars Series F21-10 Two Piece Ball Valve', N'VF21-10 - 2-PC Ball Valve, Two Piece, Full Port, SRS Handle, ASME B16.34, 2000 PSI, Body CF8M, Seat RTFE, 3/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-10.jpg', NULL),
(N'VF21-10-3-4IN-BSP', @CategoryId, N'Active', N'Mars Series F21-10 Two Piece Ball Valve', N'VF21-10 - 2-PC Ball Valve, Two Piece, Full Port, SRS Handle, ASME B16.34, 2000 PSI, Body CF8M, Seat RTFE, 3/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-10.jpg', NULL),
(N'VF21-10-3-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-10 Two Piece Ball Valve', N'VF21-10 - 2-PC Ball Valve, Two Piece, Full Port, SRS Handle, ASME B16.34, 2000 PSI, Body CF8M, Seat RTFE, 3/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-10.jpg', NULL),
(N'VF21-10-1IN-NPT', @CategoryId, N'Active', N'Mars Series F21-10 Two Piece Ball Valve', N'VF21-10 - 2-PC Ball Valve, Two Piece, Full Port, SRS Handle, ASME B16.34, 2000 PSI, Body CF8M, Seat RTFE, 1", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-10.jpg', NULL),
(N'VF21-10-1IN-BSP', @CategoryId, N'Active', N'Mars Series F21-10 Two Piece Ball Valve', N'VF21-10 - 2-PC Ball Valve, Two Piece, Full Port, SRS Handle, ASME B16.34, 2000 PSI, Body CF8M, Seat RTFE, 1", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-10.jpg', NULL),
(N'VF21-10-1IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-10 Two Piece Ball Valve', N'VF21-10 - 2-PC Ball Valve, Two Piece, Full Port, SRS Handle, ASME B16.34, 2000 PSI, Body CF8M, Seat RTFE, 1", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-10.jpg', NULL),
(N'VF21-10-1-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F21-10 Two Piece Ball Valve', N'VF21-10 - 2-PC Ball Valve, Two Piece, Full Port, SRS Handle, ASME B16.34, 2000 PSI, Body CF8M, Seat RTFE, 1 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-10.jpg', NULL),
(N'VF21-10-1-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F21-10 Two Piece Ball Valve', N'VF21-10 - 2-PC Ball Valve, Two Piece, Full Port, SRS Handle, ASME B16.34, 2000 PSI, Body CF8M, Seat RTFE, 1 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-10.jpg', NULL),
(N'VF21-10-1-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-10 Two Piece Ball Valve', N'VF21-10 - 2-PC Ball Valve, Two Piece, Full Port, SRS Handle, ASME B16.34, 2000 PSI, Body CF8M, Seat RTFE, 1 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-10.jpg', NULL),
(N'VF21-10-1-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F21-10 Two Piece Ball Valve', N'VF21-10 - 2-PC Ball Valve, Two Piece, Full Port, SRS Handle, ASME B16.34, 2000 PSI, Body CF8M, Seat RTFE, 1 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-10.jpg', NULL),
(N'VF21-10-1-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F21-10 Two Piece Ball Valve', N'VF21-10 - 2-PC Ball Valve, Two Piece, Full Port, SRS Handle, ASME B16.34, 2000 PSI, Body CF8M, Seat RTFE, 1 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-10.jpg', NULL),
(N'VF21-10-1-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-10 Two Piece Ball Valve', N'VF21-10 - 2-PC Ball Valve, Two Piece, Full Port, SRS Handle, ASME B16.34, 2000 PSI, Body CF8M, Seat RTFE, 1 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-10.jpg', NULL),
(N'VF21-10-2IN-NPT', @CategoryId, N'Active', N'Mars Series F21-10 Two Piece Ball Valve', N'VF21-10 - 2-PC Ball Valve, Two Piece, Full Port, SRS Handle, ASME B16.34, 2000 PSI, Body CF8M, Seat RTFE, 2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-10.jpg', NULL),
(N'VF21-10-2IN-BSP', @CategoryId, N'Active', N'Mars Series F21-10 Two Piece Ball Valve', N'VF21-10 - 2-PC Ball Valve, Two Piece, Full Port, SRS Handle, ASME B16.34, 2000 PSI, Body CF8M, Seat RTFE, 2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-10.jpg', NULL),
(N'VF21-10-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-10 Two Piece Ball Valve', N'VF21-10 - 2-PC Ball Valve, Two Piece, Full Port, SRS Handle, ASME B16.34, 2000 PSI, Body CF8M, Seat RTFE, 2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-10.jpg', NULL);
INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VF21-10-1-4IN-NPT',N'Size',N'1/4"'),(N'VF21-10-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF21-10-1-4IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-10-1-4IN-BSP',N'Size',N'1/4"'),(N'VF21-10-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF21-10-1-4IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-10-1-4IN-BSPT',N'Size',N'1/4"'),(N'VF21-10-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-10-1-4IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-10-3-8IN-NPT',N'Size',N'3/8"'),(N'VF21-10-3-8IN-NPT',N'End Connection',N'NPT'),(N'VF21-10-3-8IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-10-3-8IN-BSP',N'Size',N'3/8"'),(N'VF21-10-3-8IN-BSP',N'End Connection',N'BSP'),(N'VF21-10-3-8IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-10-3-8IN-BSPT',N'Size',N'3/8"'),(N'VF21-10-3-8IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-10-3-8IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-10-1-2IN-NPT',N'Size',N'1/2"'),(N'VF21-10-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF21-10-1-2IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-10-1-2IN-BSP',N'Size',N'1/2"'),(N'VF21-10-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF21-10-1-2IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-10-1-2IN-BSPT',N'Size',N'1/2"'),(N'VF21-10-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-10-1-2IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-10-3-4IN-NPT',N'Size',N'3/4"'),(N'VF21-10-3-4IN-NPT',N'End Connection',N'NPT'),(N'VF21-10-3-4IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-10-3-4IN-BSP',N'Size',N'3/4"'),(N'VF21-10-3-4IN-BSP',N'End Connection',N'BSP'),(N'VF21-10-3-4IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-10-3-4IN-BSPT',N'Size',N'3/4"'),(N'VF21-10-3-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-10-3-4IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-10-1IN-NPT',N'Size',N'1"'),(N'VF21-10-1IN-NPT',N'End Connection',N'NPT'),(N'VF21-10-1IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-10-1IN-BSP',N'Size',N'1"'),(N'VF21-10-1IN-BSP',N'End Connection',N'BSP'),(N'VF21-10-1IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-10-1IN-BSPT',N'Size',N'1"'),(N'VF21-10-1IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-10-1IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-10-1-1-4IN-NPT',N'Size',N'1 1/4"'),(N'VF21-10-1-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF21-10-1-1-4IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-10-1-1-4IN-BSP',N'Size',N'1 1/4"'),(N'VF21-10-1-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF21-10-1-1-4IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-10-1-1-4IN-BSPT',N'Size',N'1 1/4"'),(N'VF21-10-1-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-10-1-1-4IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-10-1-1-2IN-NPT',N'Size',N'1 1/2"'),(N'VF21-10-1-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF21-10-1-1-2IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-10-1-1-2IN-BSP',N'Size',N'1 1/2"'),(N'VF21-10-1-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF21-10-1-1-2IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-10-1-1-2IN-BSPT',N'Size',N'1 1/2"'),(N'VF21-10-1-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-10-1-1-2IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-10-2IN-NPT',N'Size',N'2"'),(N'VF21-10-2IN-NPT',N'End Connection',N'NPT'),(N'VF21-10-2IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-10-2IN-BSP',N'Size',N'2"'),(N'VF21-10-2IN-BSP',N'End Connection',N'BSP'),(N'VF21-10-2IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-10-2IN-BSPT',N'Size',N'2"'),(N'VF21-10-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-10-2IN-BSPT',N'Operating Pressure',N'2000 PSI')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;
SELECT N'Series F21-10' AS Series, COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
GO

-- ===== Series F21-20 (33 products, quote-only Price NULL) =====
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series F21-20')
    INSERT INTO Categories (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures, Approvals)
    VALUES (N'Series F21-20', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'The Mars Series F21-20 is a 2-piece, full-port fire-safe ball valve with threaded ends, rated to 2000 PSI, certified to API 607 (6th Edition) and conforming to ASME B16.34. CF8M or WCB body with PTFE/RTFE seats, in sizes 1/4" to 4".', N'CF8M / WCB', N'PTFE / RTFE', N'Two Piece, Fire-Safe, Full Port, ASME B16.34', N'2-piece full port fire-safe design
Threaded ends (NPT, BSP, BSPT)
Rated to 2000 PSI
CF8M or WCB body
PTFE / RTFE seats
Size 1/4" to 4"
Fire-safe API 607, 6th Edition
Conforms to ASME B16.34', N'Fire-Safe API 607, 6th Edition; ASME B16.34');
GO
DECLARE @SeriesName nvarchar(100) = N'Series F21-20';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);
INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'End Connection'),(N'Operating Pressure')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);
INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'End Connection',0),(N'Size',1),(N'Operating Pressure',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);
INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VF21-20-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-3-8IN-NPT', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-3-8IN-BSP', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-3-8IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-3-4IN-NPT', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-3-4IN-BSP', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-3-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-1IN-NPT', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-1IN-BSP', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-1IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-1-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-1-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-1-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-1-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-1-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-1-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-2IN-NPT', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-2IN-BSP', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-2-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-2-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-2-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-3IN-NPT', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-3IN-BSP', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-3IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-4IN-NPT', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-4IN-BSP', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL),
(N'VF21-20-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-20 Two Piece Fire-Safe Ball Valve', N'VF21-20 - 2-PC Ball Valve, Two Piece, Fire-Safe, Full Port, ASME B16.34, 2000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-two-piece-ball-valve/series-f21-20.jpg', NULL);
INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VF21-20-1-4IN-NPT',N'Size',N'1/4"'),(N'VF21-20-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF21-20-1-4IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-1-4IN-BSP',N'Size',N'1/4"'),(N'VF21-20-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF21-20-1-4IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-1-4IN-BSPT',N'Size',N'1/4"'),(N'VF21-20-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-20-1-4IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-3-8IN-NPT',N'Size',N'3/8"'),(N'VF21-20-3-8IN-NPT',N'End Connection',N'NPT'),(N'VF21-20-3-8IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-3-8IN-BSP',N'Size',N'3/8"'),(N'VF21-20-3-8IN-BSP',N'End Connection',N'BSP'),(N'VF21-20-3-8IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-3-8IN-BSPT',N'Size',N'3/8"'),(N'VF21-20-3-8IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-20-3-8IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-1-2IN-NPT',N'Size',N'1/2"'),(N'VF21-20-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF21-20-1-2IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-1-2IN-BSP',N'Size',N'1/2"'),(N'VF21-20-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF21-20-1-2IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-1-2IN-BSPT',N'Size',N'1/2"'),(N'VF21-20-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-20-1-2IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-3-4IN-NPT',N'Size',N'3/4"'),(N'VF21-20-3-4IN-NPT',N'End Connection',N'NPT'),(N'VF21-20-3-4IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-3-4IN-BSP',N'Size',N'3/4"'),(N'VF21-20-3-4IN-BSP',N'End Connection',N'BSP'),(N'VF21-20-3-4IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-3-4IN-BSPT',N'Size',N'3/4"'),(N'VF21-20-3-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-20-3-4IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-1IN-NPT',N'Size',N'1"'),(N'VF21-20-1IN-NPT',N'End Connection',N'NPT'),(N'VF21-20-1IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-1IN-BSP',N'Size',N'1"'),(N'VF21-20-1IN-BSP',N'End Connection',N'BSP'),(N'VF21-20-1IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-1IN-BSPT',N'Size',N'1"'),(N'VF21-20-1IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-20-1IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-1-1-4IN-NPT',N'Size',N'1 1/4"'),(N'VF21-20-1-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF21-20-1-1-4IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-1-1-4IN-BSP',N'Size',N'1 1/4"'),(N'VF21-20-1-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF21-20-1-1-4IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-1-1-4IN-BSPT',N'Size',N'1 1/4"'),(N'VF21-20-1-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-20-1-1-4IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-1-1-2IN-NPT',N'Size',N'1 1/2"'),(N'VF21-20-1-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF21-20-1-1-2IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-1-1-2IN-BSP',N'Size',N'1 1/2"'),(N'VF21-20-1-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF21-20-1-1-2IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-1-1-2IN-BSPT',N'Size',N'1 1/2"'),(N'VF21-20-1-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-20-1-1-2IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-2IN-NPT',N'Size',N'2"'),(N'VF21-20-2IN-NPT',N'End Connection',N'NPT'),(N'VF21-20-2IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-2IN-BSP',N'Size',N'2"'),(N'VF21-20-2IN-BSP',N'End Connection',N'BSP'),(N'VF21-20-2IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-2IN-BSPT',N'Size',N'2"'),(N'VF21-20-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-20-2IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-2-1-2IN-NPT',N'Size',N'2 1/2"'),(N'VF21-20-2-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF21-20-2-1-2IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-2-1-2IN-BSP',N'Size',N'2 1/2"'),(N'VF21-20-2-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF21-20-2-1-2IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-2-1-2IN-BSPT',N'Size',N'2 1/2"'),(N'VF21-20-2-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-20-2-1-2IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-3IN-NPT',N'Size',N'3"'),(N'VF21-20-3IN-NPT',N'End Connection',N'NPT'),(N'VF21-20-3IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-3IN-BSP',N'Size',N'3"'),(N'VF21-20-3IN-BSP',N'End Connection',N'BSP'),(N'VF21-20-3IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-3IN-BSPT',N'Size',N'3"'),(N'VF21-20-3IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-20-3IN-BSPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-4IN-NPT',N'Size',N'4"'),(N'VF21-20-4IN-NPT',N'End Connection',N'NPT'),(N'VF21-20-4IN-NPT',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-4IN-BSP',N'Size',N'4"'),(N'VF21-20-4IN-BSP',N'End Connection',N'BSP'),(N'VF21-20-4IN-BSP',N'Operating Pressure',N'2000 PSI'),
  (N'VF21-20-4IN-BSPT',N'Size',N'4"'),(N'VF21-20-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-20-4IN-BSPT',N'Operating Pressure',N'2000 PSI')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;
SELECT N'Series F21-20' AS Series, COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
GO
