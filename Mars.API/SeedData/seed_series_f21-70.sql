-- Series F21-70 (high-pressure 2-piece, quote-only Price NULL). Run from file (SSMS: File > Open > Execute).
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series F21-70')
    INSERT INTO Categories (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, Approvals, KeyFeatures)
    VALUES (N'Series F21-70', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf',
        N'The Mars Series F21-70 is a 2-piece, full-port fire-safe high-pressure ball valve with threaded ends, rated to 3000 PSI, certified to API 607 (5th Edition) and conforming to ASME B16.34. CF8M or WCB body with Delrin/Peek seats, in sizes 1/4" to 2".',
        N'CF8M / WCB', N'Delrin / Peek', N'Two Piece, Fire-Safe, Full Port, High Pressure', N'Fire-Safe API 607, 5th Edition; ASME B16.34',
        N'2-piece full port fire-safe high pressure design
Threaded ends (NPT, BSP, BSPT)
Rated to 3000 PSI
CF8M or WCB body
Delrin / Peek seats
Size 1/4" to 2"
Fire-safe API 607, 5th Edition
Conforms to ASME B16.34');

DECLARE @SeriesName nvarchar(100) = N'Series F21-70';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);

INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'End Connection'),(N'Operating Pressure')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);

INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'End Connection',0),(N'Size',1),(N'Operating Pressure',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);

INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VF21-70-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F21-70 Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-70 - 2-PC Ball Valve, Fire-Safe Full Port High Pressure, 3000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-70.jpg', NULL),
(N'VF21-70-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F21-70 Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-70 - 2-PC Ball Valve, Fire-Safe Full Port High Pressure, 3000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-70.jpg', NULL),
(N'VF21-70-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-70 Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-70 - 2-PC Ball Valve, Fire-Safe Full Port High Pressure, 3000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-70.jpg', NULL),
(N'VF21-70-3-8IN-NPT', @CategoryId, N'Active', N'Mars Series F21-70 Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-70 - 2-PC Ball Valve, Fire-Safe Full Port High Pressure, 3000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 3/8", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-70.jpg', NULL),
(N'VF21-70-3-8IN-BSP', @CategoryId, N'Active', N'Mars Series F21-70 Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-70 - 2-PC Ball Valve, Fire-Safe Full Port High Pressure, 3000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 3/8", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-70.jpg', NULL),
(N'VF21-70-3-8IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-70 Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-70 - 2-PC Ball Valve, Fire-Safe Full Port High Pressure, 3000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 3/8", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-70.jpg', NULL),
(N'VF21-70-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F21-70 Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-70 - 2-PC Ball Valve, Fire-Safe Full Port High Pressure, 3000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-70.jpg', NULL),
(N'VF21-70-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F21-70 Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-70 - 2-PC Ball Valve, Fire-Safe Full Port High Pressure, 3000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-70.jpg', NULL),
(N'VF21-70-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-70 Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-70 - 2-PC Ball Valve, Fire-Safe Full Port High Pressure, 3000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-70.jpg', NULL),
(N'VF21-70-3-4IN-NPT', @CategoryId, N'Active', N'Mars Series F21-70 Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-70 - 2-PC Ball Valve, Fire-Safe Full Port High Pressure, 3000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 3/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-70.jpg', NULL),
(N'VF21-70-3-4IN-BSP', @CategoryId, N'Active', N'Mars Series F21-70 Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-70 - 2-PC Ball Valve, Fire-Safe Full Port High Pressure, 3000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 3/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-70.jpg', NULL),
(N'VF21-70-3-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-70 Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-70 - 2-PC Ball Valve, Fire-Safe Full Port High Pressure, 3000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 3/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-70.jpg', NULL),
(N'VF21-70-1IN-NPT', @CategoryId, N'Active', N'Mars Series F21-70 Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-70 - 2-PC Ball Valve, Fire-Safe Full Port High Pressure, 3000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-70.jpg', NULL),
(N'VF21-70-1IN-BSP', @CategoryId, N'Active', N'Mars Series F21-70 Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-70 - 2-PC Ball Valve, Fire-Safe Full Port High Pressure, 3000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-70.jpg', NULL),
(N'VF21-70-1IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-70 Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-70 - 2-PC Ball Valve, Fire-Safe Full Port High Pressure, 3000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-70.jpg', NULL),
(N'VF21-70-1-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F21-70 Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-70 - 2-PC Ball Valve, Fire-Safe Full Port High Pressure, 3000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-70.jpg', NULL),
(N'VF21-70-1-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F21-70 Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-70 - 2-PC Ball Valve, Fire-Safe Full Port High Pressure, 3000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-70.jpg', NULL),
(N'VF21-70-1-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-70 Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-70 - 2-PC Ball Valve, Fire-Safe Full Port High Pressure, 3000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-70.jpg', NULL),
(N'VF21-70-1-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F21-70 Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-70 - 2-PC Ball Valve, Fire-Safe Full Port High Pressure, 3000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-70.jpg', NULL),
(N'VF21-70-1-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F21-70 Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-70 - 2-PC Ball Valve, Fire-Safe Full Port High Pressure, 3000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-70.jpg', NULL),
(N'VF21-70-1-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-70 Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-70 - 2-PC Ball Valve, Fire-Safe Full Port High Pressure, 3000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-70.jpg', NULL),
(N'VF21-70-2IN-NPT', @CategoryId, N'Active', N'Mars Series F21-70 Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-70 - 2-PC Ball Valve, Fire-Safe Full Port High Pressure, 3000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-70.jpg', NULL),
(N'VF21-70-2IN-BSP', @CategoryId, N'Active', N'Mars Series F21-70 Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-70 - 2-PC Ball Valve, Fire-Safe Full Port High Pressure, 3000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-70.jpg', NULL),
(N'VF21-70-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F21-70 Two Piece Fire-Safe High Pressure Ball Valve', N'VF21-70 - 2-PC Ball Valve, Fire-Safe Full Port High Pressure, 3000 PSI, Body CF8M / WCB, Seat Delrin / Peek, 2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-pressure-two-piece-ball-valve/series-f21-70.jpg', NULL);

INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VF21-70-1-4IN-NPT',N'Size',N'1/4"'),(N'VF21-70-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF21-70-1-4IN-NPT',N'Operating Pressure',N'3000 PSI'),
  (N'VF21-70-1-4IN-BSP',N'Size',N'1/4"'),(N'VF21-70-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF21-70-1-4IN-BSP',N'Operating Pressure',N'3000 PSI'),
  (N'VF21-70-1-4IN-BSPT',N'Size',N'1/4"'),(N'VF21-70-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-70-1-4IN-BSPT',N'Operating Pressure',N'3000 PSI'),
  (N'VF21-70-3-8IN-NPT',N'Size',N'3/8"'),(N'VF21-70-3-8IN-NPT',N'End Connection',N'NPT'),(N'VF21-70-3-8IN-NPT',N'Operating Pressure',N'3000 PSI'),
  (N'VF21-70-3-8IN-BSP',N'Size',N'3/8"'),(N'VF21-70-3-8IN-BSP',N'End Connection',N'BSP'),(N'VF21-70-3-8IN-BSP',N'Operating Pressure',N'3000 PSI'),
  (N'VF21-70-3-8IN-BSPT',N'Size',N'3/8"'),(N'VF21-70-3-8IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-70-3-8IN-BSPT',N'Operating Pressure',N'3000 PSI'),
  (N'VF21-70-1-2IN-NPT',N'Size',N'1/2"'),(N'VF21-70-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF21-70-1-2IN-NPT',N'Operating Pressure',N'3000 PSI'),
  (N'VF21-70-1-2IN-BSP',N'Size',N'1/2"'),(N'VF21-70-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF21-70-1-2IN-BSP',N'Operating Pressure',N'3000 PSI'),
  (N'VF21-70-1-2IN-BSPT',N'Size',N'1/2"'),(N'VF21-70-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-70-1-2IN-BSPT',N'Operating Pressure',N'3000 PSI'),
  (N'VF21-70-3-4IN-NPT',N'Size',N'3/4"'),(N'VF21-70-3-4IN-NPT',N'End Connection',N'NPT'),(N'VF21-70-3-4IN-NPT',N'Operating Pressure',N'3000 PSI'),
  (N'VF21-70-3-4IN-BSP',N'Size',N'3/4"'),(N'VF21-70-3-4IN-BSP',N'End Connection',N'BSP'),(N'VF21-70-3-4IN-BSP',N'Operating Pressure',N'3000 PSI'),
  (N'VF21-70-3-4IN-BSPT',N'Size',N'3/4"'),(N'VF21-70-3-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-70-3-4IN-BSPT',N'Operating Pressure',N'3000 PSI'),
  (N'VF21-70-1IN-NPT',N'Size',N'1"'),(N'VF21-70-1IN-NPT',N'End Connection',N'NPT'),(N'VF21-70-1IN-NPT',N'Operating Pressure',N'3000 PSI'),
  (N'VF21-70-1IN-BSP',N'Size',N'1"'),(N'VF21-70-1IN-BSP',N'End Connection',N'BSP'),(N'VF21-70-1IN-BSP',N'Operating Pressure',N'3000 PSI'),
  (N'VF21-70-1IN-BSPT',N'Size',N'1"'),(N'VF21-70-1IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-70-1IN-BSPT',N'Operating Pressure',N'3000 PSI'),
  (N'VF21-70-1-1-4IN-NPT',N'Size',N'1 1/4"'),(N'VF21-70-1-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF21-70-1-1-4IN-NPT',N'Operating Pressure',N'3000 PSI'),
  (N'VF21-70-1-1-4IN-BSP',N'Size',N'1 1/4"'),(N'VF21-70-1-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF21-70-1-1-4IN-BSP',N'Operating Pressure',N'3000 PSI'),
  (N'VF21-70-1-1-4IN-BSPT',N'Size',N'1 1/4"'),(N'VF21-70-1-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-70-1-1-4IN-BSPT',N'Operating Pressure',N'3000 PSI'),
  (N'VF21-70-1-1-2IN-NPT',N'Size',N'1 1/2"'),(N'VF21-70-1-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF21-70-1-1-2IN-NPT',N'Operating Pressure',N'3000 PSI'),
  (N'VF21-70-1-1-2IN-BSP',N'Size',N'1 1/2"'),(N'VF21-70-1-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF21-70-1-1-2IN-BSP',N'Operating Pressure',N'3000 PSI'),
  (N'VF21-70-1-1-2IN-BSPT',N'Size',N'1 1/2"'),(N'VF21-70-1-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-70-1-1-2IN-BSPT',N'Operating Pressure',N'3000 PSI'),
  (N'VF21-70-2IN-NPT',N'Size',N'2"'),(N'VF21-70-2IN-NPT',N'End Connection',N'NPT'),(N'VF21-70-2IN-NPT',N'Operating Pressure',N'3000 PSI'),
  (N'VF21-70-2IN-BSP',N'Size',N'2"'),(N'VF21-70-2IN-BSP',N'End Connection',N'BSP'),(N'VF21-70-2IN-BSP',N'Operating Pressure',N'3000 PSI'),
  (N'VF21-70-2IN-BSPT',N'Size',N'2"'),(N'VF21-70-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF21-70-2IN-BSPT',N'Operating Pressure',N'3000 PSI')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;

SELECT COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
