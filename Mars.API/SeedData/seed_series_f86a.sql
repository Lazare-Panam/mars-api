-- Series F86A (3-piece high-performance fire-safe, quote-only Price NULL). Run from file (SSMS).
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series F86A')
    INSERT INTO Categories (Name, Description, BodyMaterial, SeatMaterial, Design, Approvals, KeyFeatures)
    VALUES (N'Series F86A',
        N'The Mars Series F86A is a 3-piece, full-port fire-safe high-pressure ball valve rated to 7500 PSI and conforming to ASME B16.34. CF8M or WCB body with Delrin/Peek seats, in threaded, butt-weld or socket-weld ends, sizes 1/4" to 2". Optional NACE MR0175 on request.',
        N'CF8M / WCB', N'Delrin / Peek', N'Three Piece, Fire-Safe, Full Port, High Pressure', N'ASME B16.34',
        N'3-piece full port fire-safe high pressure design
Ends: Threaded, Butt Weld, Socket Weld
Rated to 7500 PSI
CF8M or WCB body
Delrin / Peek seats
Size 1/4" to 2"
Conforms to ASME B16.34
Optional NACE MR0175');

DECLARE @SeriesName nvarchar(100) = N'Series F86A';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);

INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'End Connection'),(N'Operating Pressure')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);

INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'End Connection',0),(N'Size',1),(N'Operating Pressure',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);

INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VF86A-1-4IN-THREADED', @CategoryId, N'Active', N'Mars Series F86A Three Piece Fire-Safe Ball Valve', N'VF86A - 3-PC Fire-Safe Ball Valve, Full Port, 7500 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1/4", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-three-piece-ball-valve/series-f86a.jpg', NULL),
(N'VF86A-1-4IN-BW', @CategoryId, N'Active', N'Mars Series F86A Three Piece Fire-Safe Ball Valve', N'VF86A - 3-PC Fire-Safe Ball Valve, Full Port, 7500 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1/4", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-three-piece-ball-valve/series-f86a.jpg', NULL),
(N'VF86A-1-4IN-SW', @CategoryId, N'Active', N'Mars Series F86A Three Piece Fire-Safe Ball Valve', N'VF86A - 3-PC Fire-Safe Ball Valve, Full Port, 7500 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1/4", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-three-piece-ball-valve/series-f86a.jpg', NULL),
(N'VF86A-3-8IN-THREADED', @CategoryId, N'Active', N'Mars Series F86A Three Piece Fire-Safe Ball Valve', N'VF86A - 3-PC Fire-Safe Ball Valve, Full Port, 7500 PSI, Body CF8M / WCB, Seat Delrin / Peek, 3/8", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-three-piece-ball-valve/series-f86a.jpg', NULL),
(N'VF86A-3-8IN-BW', @CategoryId, N'Active', N'Mars Series F86A Three Piece Fire-Safe Ball Valve', N'VF86A - 3-PC Fire-Safe Ball Valve, Full Port, 7500 PSI, Body CF8M / WCB, Seat Delrin / Peek, 3/8", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-three-piece-ball-valve/series-f86a.jpg', NULL),
(N'VF86A-3-8IN-SW', @CategoryId, N'Active', N'Mars Series F86A Three Piece Fire-Safe Ball Valve', N'VF86A - 3-PC Fire-Safe Ball Valve, Full Port, 7500 PSI, Body CF8M / WCB, Seat Delrin / Peek, 3/8", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-three-piece-ball-valve/series-f86a.jpg', NULL),
(N'VF86A-1-2IN-THREADED', @CategoryId, N'Active', N'Mars Series F86A Three Piece Fire-Safe Ball Valve', N'VF86A - 3-PC Fire-Safe Ball Valve, Full Port, 7500 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1/2", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-three-piece-ball-valve/series-f86a.jpg', NULL),
(N'VF86A-1-2IN-BW', @CategoryId, N'Active', N'Mars Series F86A Three Piece Fire-Safe Ball Valve', N'VF86A - 3-PC Fire-Safe Ball Valve, Full Port, 7500 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1/2", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-three-piece-ball-valve/series-f86a.jpg', NULL),
(N'VF86A-1-2IN-SW', @CategoryId, N'Active', N'Mars Series F86A Three Piece Fire-Safe Ball Valve', N'VF86A - 3-PC Fire-Safe Ball Valve, Full Port, 7500 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1/2", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-three-piece-ball-valve/series-f86a.jpg', NULL),
(N'VF86A-3-4IN-THREADED', @CategoryId, N'Active', N'Mars Series F86A Three Piece Fire-Safe Ball Valve', N'VF86A - 3-PC Fire-Safe Ball Valve, Full Port, 7500 PSI, Body CF8M / WCB, Seat Delrin / Peek, 3/4", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-three-piece-ball-valve/series-f86a.jpg', NULL),
(N'VF86A-3-4IN-BW', @CategoryId, N'Active', N'Mars Series F86A Three Piece Fire-Safe Ball Valve', N'VF86A - 3-PC Fire-Safe Ball Valve, Full Port, 7500 PSI, Body CF8M / WCB, Seat Delrin / Peek, 3/4", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-three-piece-ball-valve/series-f86a.jpg', NULL),
(N'VF86A-3-4IN-SW', @CategoryId, N'Active', N'Mars Series F86A Three Piece Fire-Safe Ball Valve', N'VF86A - 3-PC Fire-Safe Ball Valve, Full Port, 7500 PSI, Body CF8M / WCB, Seat Delrin / Peek, 3/4", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-three-piece-ball-valve/series-f86a.jpg', NULL),
(N'VF86A-1IN-THREADED', @CategoryId, N'Active', N'Mars Series F86A Three Piece Fire-Safe Ball Valve', N'VF86A - 3-PC Fire-Safe Ball Valve, Full Port, 7500 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-three-piece-ball-valve/series-f86a.jpg', NULL),
(N'VF86A-1IN-BW', @CategoryId, N'Active', N'Mars Series F86A Three Piece Fire-Safe Ball Valve', N'VF86A - 3-PC Fire-Safe Ball Valve, Full Port, 7500 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-three-piece-ball-valve/series-f86a.jpg', NULL),
(N'VF86A-1IN-SW', @CategoryId, N'Active', N'Mars Series F86A Three Piece Fire-Safe Ball Valve', N'VF86A - 3-PC Fire-Safe Ball Valve, Full Port, 7500 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-three-piece-ball-valve/series-f86a.jpg', NULL),
(N'VF86A-1-1-4IN-THREADED', @CategoryId, N'Active', N'Mars Series F86A Three Piece Fire-Safe Ball Valve', N'VF86A - 3-PC Fire-Safe Ball Valve, Full Port, 7500 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1 1/4", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-three-piece-ball-valve/series-f86a.jpg', NULL),
(N'VF86A-1-1-4IN-BW', @CategoryId, N'Active', N'Mars Series F86A Three Piece Fire-Safe Ball Valve', N'VF86A - 3-PC Fire-Safe Ball Valve, Full Port, 7500 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1 1/4", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-three-piece-ball-valve/series-f86a.jpg', NULL),
(N'VF86A-1-1-4IN-SW', @CategoryId, N'Active', N'Mars Series F86A Three Piece Fire-Safe Ball Valve', N'VF86A - 3-PC Fire-Safe Ball Valve, Full Port, 7500 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1 1/4", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-three-piece-ball-valve/series-f86a.jpg', NULL),
(N'VF86A-1-1-2IN-THREADED', @CategoryId, N'Active', N'Mars Series F86A Three Piece Fire-Safe Ball Valve', N'VF86A - 3-PC Fire-Safe Ball Valve, Full Port, 7500 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1 1/2", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-three-piece-ball-valve/series-f86a.jpg', NULL),
(N'VF86A-1-1-2IN-BW', @CategoryId, N'Active', N'Mars Series F86A Three Piece Fire-Safe Ball Valve', N'VF86A - 3-PC Fire-Safe Ball Valve, Full Port, 7500 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1 1/2", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-three-piece-ball-valve/series-f86a.jpg', NULL),
(N'VF86A-1-1-2IN-SW', @CategoryId, N'Active', N'Mars Series F86A Three Piece Fire-Safe Ball Valve', N'VF86A - 3-PC Fire-Safe Ball Valve, Full Port, 7500 PSI, Body CF8M / WCB, Seat Delrin / Peek, 1 1/2", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-three-piece-ball-valve/series-f86a.jpg', NULL),
(N'VF86A-2IN-THREADED', @CategoryId, N'Active', N'Mars Series F86A Three Piece Fire-Safe Ball Valve', N'VF86A - 3-PC Fire-Safe Ball Valve, Full Port, 7500 PSI, Body CF8M / WCB, Seat Delrin / Peek, 2", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-three-piece-ball-valve/series-f86a.jpg', NULL),
(N'VF86A-2IN-BW', @CategoryId, N'Active', N'Mars Series F86A Three Piece Fire-Safe Ball Valve', N'VF86A - 3-PC Fire-Safe Ball Valve, Full Port, 7500 PSI, Body CF8M / WCB, Seat Delrin / Peek, 2", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-three-piece-ball-valve/series-f86a.jpg', NULL),
(N'VF86A-2IN-SW', @CategoryId, N'Active', N'Mars Series F86A Three Piece Fire-Safe Ball Valve', N'VF86A - 3-PC Fire-Safe Ball Valve, Full Port, 7500 PSI, Body CF8M / WCB, Seat Delrin / Peek, 2", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/high-performance-three-piece-ball-valve/series-f86a.jpg', NULL);

INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VF86A-1-4IN-THREADED',N'Size',N'1/4"'),(N'VF86A-1-4IN-THREADED',N'End Connection',N'Threaded'),(N'VF86A-1-4IN-THREADED',N'Operating Pressure',N'7500 PSI'),
  (N'VF86A-1-4IN-BW',N'Size',N'1/4"'),(N'VF86A-1-4IN-BW',N'End Connection',N'Butt Weld'),(N'VF86A-1-4IN-BW',N'Operating Pressure',N'7500 PSI'),
  (N'VF86A-1-4IN-SW',N'Size',N'1/4"'),(N'VF86A-1-4IN-SW',N'End Connection',N'Socket Weld'),(N'VF86A-1-4IN-SW',N'Operating Pressure',N'7500 PSI'),
  (N'VF86A-3-8IN-THREADED',N'Size',N'3/8"'),(N'VF86A-3-8IN-THREADED',N'End Connection',N'Threaded'),(N'VF86A-3-8IN-THREADED',N'Operating Pressure',N'7500 PSI'),
  (N'VF86A-3-8IN-BW',N'Size',N'3/8"'),(N'VF86A-3-8IN-BW',N'End Connection',N'Butt Weld'),(N'VF86A-3-8IN-BW',N'Operating Pressure',N'7500 PSI'),
  (N'VF86A-3-8IN-SW',N'Size',N'3/8"'),(N'VF86A-3-8IN-SW',N'End Connection',N'Socket Weld'),(N'VF86A-3-8IN-SW',N'Operating Pressure',N'7500 PSI'),
  (N'VF86A-1-2IN-THREADED',N'Size',N'1/2"'),(N'VF86A-1-2IN-THREADED',N'End Connection',N'Threaded'),(N'VF86A-1-2IN-THREADED',N'Operating Pressure',N'7500 PSI'),
  (N'VF86A-1-2IN-BW',N'Size',N'1/2"'),(N'VF86A-1-2IN-BW',N'End Connection',N'Butt Weld'),(N'VF86A-1-2IN-BW',N'Operating Pressure',N'7500 PSI'),
  (N'VF86A-1-2IN-SW',N'Size',N'1/2"'),(N'VF86A-1-2IN-SW',N'End Connection',N'Socket Weld'),(N'VF86A-1-2IN-SW',N'Operating Pressure',N'7500 PSI'),
  (N'VF86A-3-4IN-THREADED',N'Size',N'3/4"'),(N'VF86A-3-4IN-THREADED',N'End Connection',N'Threaded'),(N'VF86A-3-4IN-THREADED',N'Operating Pressure',N'7500 PSI'),
  (N'VF86A-3-4IN-BW',N'Size',N'3/4"'),(N'VF86A-3-4IN-BW',N'End Connection',N'Butt Weld'),(N'VF86A-3-4IN-BW',N'Operating Pressure',N'7500 PSI'),
  (N'VF86A-3-4IN-SW',N'Size',N'3/4"'),(N'VF86A-3-4IN-SW',N'End Connection',N'Socket Weld'),(N'VF86A-3-4IN-SW',N'Operating Pressure',N'7500 PSI'),
  (N'VF86A-1IN-THREADED',N'Size',N'1"'),(N'VF86A-1IN-THREADED',N'End Connection',N'Threaded'),(N'VF86A-1IN-THREADED',N'Operating Pressure',N'7500 PSI'),
  (N'VF86A-1IN-BW',N'Size',N'1"'),(N'VF86A-1IN-BW',N'End Connection',N'Butt Weld'),(N'VF86A-1IN-BW',N'Operating Pressure',N'7500 PSI'),
  (N'VF86A-1IN-SW',N'Size',N'1"'),(N'VF86A-1IN-SW',N'End Connection',N'Socket Weld'),(N'VF86A-1IN-SW',N'Operating Pressure',N'7500 PSI'),
  (N'VF86A-1-1-4IN-THREADED',N'Size',N'1 1/4"'),(N'VF86A-1-1-4IN-THREADED',N'End Connection',N'Threaded'),(N'VF86A-1-1-4IN-THREADED',N'Operating Pressure',N'7500 PSI'),
  (N'VF86A-1-1-4IN-BW',N'Size',N'1 1/4"'),(N'VF86A-1-1-4IN-BW',N'End Connection',N'Butt Weld'),(N'VF86A-1-1-4IN-BW',N'Operating Pressure',N'7500 PSI'),
  (N'VF86A-1-1-4IN-SW',N'Size',N'1 1/4"'),(N'VF86A-1-1-4IN-SW',N'End Connection',N'Socket Weld'),(N'VF86A-1-1-4IN-SW',N'Operating Pressure',N'7500 PSI'),
  (N'VF86A-1-1-2IN-THREADED',N'Size',N'1 1/2"'),(N'VF86A-1-1-2IN-THREADED',N'End Connection',N'Threaded'),(N'VF86A-1-1-2IN-THREADED',N'Operating Pressure',N'7500 PSI'),
  (N'VF86A-1-1-2IN-BW',N'Size',N'1 1/2"'),(N'VF86A-1-1-2IN-BW',N'End Connection',N'Butt Weld'),(N'VF86A-1-1-2IN-BW',N'Operating Pressure',N'7500 PSI'),
  (N'VF86A-1-1-2IN-SW',N'Size',N'1 1/2"'),(N'VF86A-1-1-2IN-SW',N'End Connection',N'Socket Weld'),(N'VF86A-1-1-2IN-SW',N'Operating Pressure',N'7500 PSI'),
  (N'VF86A-2IN-THREADED',N'Size',N'2"'),(N'VF86A-2IN-THREADED',N'End Connection',N'Threaded'),(N'VF86A-2IN-THREADED',N'Operating Pressure',N'7500 PSI'),
  (N'VF86A-2IN-BW',N'Size',N'2"'),(N'VF86A-2IN-BW',N'End Connection',N'Butt Weld'),(N'VF86A-2IN-BW',N'Operating Pressure',N'7500 PSI'),
  (N'VF86A-2IN-SW',N'Size',N'2"'),(N'VF86A-2IN-SW',N'End Connection',N'Socket Weld'),(N'VF86A-2IN-SW',N'Operating Pressure',N'7500 PSI')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;

SELECT COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
