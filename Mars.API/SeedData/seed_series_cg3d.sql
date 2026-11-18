-- Series CG3D-10/20/30 (3-piece cryogenic, quote-only Price NULL). Run from file (SSMS). Self-cleaning on re-run.
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series CG3D-10/20/30')
    INSERT INTO Categories (Name, Description, BodyMaterial, SeatMaterial, Design, TemperatureRange, KeyFeatures)
    VALUES (N'Series CG3D-10/20/30',
        N'The Mars Series CG3D-10/20/30 is a 3-piece, full-port cryogenic ball valve with an ISO 5211 direct-mount pad and a blow-out-proof stem, rated to 2000 PSI and -196 to +95 degree C. Face-to-face per DIN 3202-M3/S13. CF8M body with PCTFE seats and a Viton stem o-ring, in threaded, socket-weld or butt-weld ends, sizes 1/4" to 4".',
        N'CF8M', N'PCTFE', N'Three Piece, Cryogenic, Full Port, Direct Mount', N'-196 to +95 degree C',
        N'3-piece cryogenic full port design
ISO 5211 direct mount
Blow-out proof stem
Face-to-face: DIN 3202-M3/S13
Rated to 2000 PSI
Ends: Threaded, Socket Weld, Butt Weld
CF8M body
PCTFE seats
Viton o-ring on stem
Temperature range -196 to +95 degree C
Size 1/4" to 4"');

DECLARE @SeriesName nvarchar(100) = N'Series CG3D-10/20/30';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);

-- Idempotent: clear any prior rows for this series so re-running always yields a clean set.
DELETE FROM ProductFilterValues WHERE CategoryId = @CategoryId;
DELETE FROM CatalogProducts WHERE CategoryId = @CategoryId;
DELETE FROM CategoryFilters WHERE CategoryId = @CategoryId;

INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Ends'),(N'Size')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);

INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'Ends',0),(N'Size',1)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);

INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VCG3D-1-4IN-THREADED', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Threaded, Body CF8M, Seat PCTFE, 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-1-4IN-SW', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Socket Weld, Body CF8M, Seat PCTFE, 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-1-4IN-BW', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Butt Weld, Body CF8M, Seat PCTFE, 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-3-8IN-THREADED', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Threaded, Body CF8M, Seat PCTFE, 3/8"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-3-8IN-SW', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Socket Weld, Body CF8M, Seat PCTFE, 3/8"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-3-8IN-BW', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Butt Weld, Body CF8M, Seat PCTFE, 3/8"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-1-2IN-THREADED', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Threaded, Body CF8M, Seat PCTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-1-2IN-SW', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Socket Weld, Body CF8M, Seat PCTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-1-2IN-BW', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Butt Weld, Body CF8M, Seat PCTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-3-4IN-THREADED', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Threaded, Body CF8M, Seat PCTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-3-4IN-SW', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Socket Weld, Body CF8M, Seat PCTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-3-4IN-BW', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Butt Weld, Body CF8M, Seat PCTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-1IN-THREADED', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Threaded, Body CF8M, Seat PCTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-1IN-SW', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Socket Weld, Body CF8M, Seat PCTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-1IN-BW', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Butt Weld, Body CF8M, Seat PCTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-1-1-4IN-THREADED', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Threaded, Body CF8M, Seat PCTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-1-1-4IN-SW', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Socket Weld, Body CF8M, Seat PCTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-1-1-4IN-BW', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Butt Weld, Body CF8M, Seat PCTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-1-1-2IN-THREADED', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Threaded, Body CF8M, Seat PCTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-1-1-2IN-SW', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Socket Weld, Body CF8M, Seat PCTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-1-1-2IN-BW', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Butt Weld, Body CF8M, Seat PCTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-2IN-THREADED', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Threaded, Body CF8M, Seat PCTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-2IN-SW', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Socket Weld, Body CF8M, Seat PCTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-2IN-BW', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Butt Weld, Body CF8M, Seat PCTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-2-1-2IN-THREADED', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Threaded, Body CF8M, Seat PCTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-2-1-2IN-SW', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Socket Weld, Body CF8M, Seat PCTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-2-1-2IN-BW', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Butt Weld, Body CF8M, Seat PCTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-3IN-THREADED', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Threaded, Body CF8M, Seat PCTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-3IN-SW', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Socket Weld, Body CF8M, Seat PCTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-3IN-BW', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Butt Weld, Body CF8M, Seat PCTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-4IN-THREADED', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Threaded, Body CF8M, Seat PCTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-4IN-SW', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Socket Weld, Body CF8M, Seat PCTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL),
(N'VCG3D-4IN-BW', @CategoryId, N'Active', N'Mars Series CG3D-10/20/30 Cryogenic 3-Piece Ball Valve', N'VCG3D - 3-PC Cryogenic Ball Valve, Full Port, ISO 5211 Direct Mount, 2000 PSI, Butt Weld, Body CF8M, Seat PCTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/CG3D-10.jpg', NULL);

INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VCG3D-1-4IN-THREADED',N'Size',N'1/4"'),(N'VCG3D-1-4IN-THREADED',N'Ends',N'Threaded'),
  (N'VCG3D-1-4IN-SW',N'Size',N'1/4"'),(N'VCG3D-1-4IN-SW',N'Ends',N'Socket Weld'),
  (N'VCG3D-1-4IN-BW',N'Size',N'1/4"'),(N'VCG3D-1-4IN-BW',N'Ends',N'Butt Weld'),
  (N'VCG3D-3-8IN-THREADED',N'Size',N'3/8"'),(N'VCG3D-3-8IN-THREADED',N'Ends',N'Threaded'),
  (N'VCG3D-3-8IN-SW',N'Size',N'3/8"'),(N'VCG3D-3-8IN-SW',N'Ends',N'Socket Weld'),
  (N'VCG3D-3-8IN-BW',N'Size',N'3/8"'),(N'VCG3D-3-8IN-BW',N'Ends',N'Butt Weld'),
  (N'VCG3D-1-2IN-THREADED',N'Size',N'1/2"'),(N'VCG3D-1-2IN-THREADED',N'Ends',N'Threaded'),
  (N'VCG3D-1-2IN-SW',N'Size',N'1/2"'),(N'VCG3D-1-2IN-SW',N'Ends',N'Socket Weld'),
  (N'VCG3D-1-2IN-BW',N'Size',N'1/2"'),(N'VCG3D-1-2IN-BW',N'Ends',N'Butt Weld'),
  (N'VCG3D-3-4IN-THREADED',N'Size',N'3/4"'),(N'VCG3D-3-4IN-THREADED',N'Ends',N'Threaded'),
  (N'VCG3D-3-4IN-SW',N'Size',N'3/4"'),(N'VCG3D-3-4IN-SW',N'Ends',N'Socket Weld'),
  (N'VCG3D-3-4IN-BW',N'Size',N'3/4"'),(N'VCG3D-3-4IN-BW',N'Ends',N'Butt Weld'),
  (N'VCG3D-1IN-THREADED',N'Size',N'1"'),(N'VCG3D-1IN-THREADED',N'Ends',N'Threaded'),
  (N'VCG3D-1IN-SW',N'Size',N'1"'),(N'VCG3D-1IN-SW',N'Ends',N'Socket Weld'),
  (N'VCG3D-1IN-BW',N'Size',N'1"'),(N'VCG3D-1IN-BW',N'Ends',N'Butt Weld'),
  (N'VCG3D-1-1-4IN-THREADED',N'Size',N'1 1/4"'),(N'VCG3D-1-1-4IN-THREADED',N'Ends',N'Threaded'),
  (N'VCG3D-1-1-4IN-SW',N'Size',N'1 1/4"'),(N'VCG3D-1-1-4IN-SW',N'Ends',N'Socket Weld'),
  (N'VCG3D-1-1-4IN-BW',N'Size',N'1 1/4"'),(N'VCG3D-1-1-4IN-BW',N'Ends',N'Butt Weld'),
  (N'VCG3D-1-1-2IN-THREADED',N'Size',N'1 1/2"'),(N'VCG3D-1-1-2IN-THREADED',N'Ends',N'Threaded'),
  (N'VCG3D-1-1-2IN-SW',N'Size',N'1 1/2"'),(N'VCG3D-1-1-2IN-SW',N'Ends',N'Socket Weld'),
  (N'VCG3D-1-1-2IN-BW',N'Size',N'1 1/2"'),(N'VCG3D-1-1-2IN-BW',N'Ends',N'Butt Weld'),
  (N'VCG3D-2IN-THREADED',N'Size',N'2"'),(N'VCG3D-2IN-THREADED',N'Ends',N'Threaded'),
  (N'VCG3D-2IN-SW',N'Size',N'2"'),(N'VCG3D-2IN-SW',N'Ends',N'Socket Weld'),
  (N'VCG3D-2IN-BW',N'Size',N'2"'),(N'VCG3D-2IN-BW',N'Ends',N'Butt Weld'),
  (N'VCG3D-2-1-2IN-THREADED',N'Size',N'2 1/2"'),(N'VCG3D-2-1-2IN-THREADED',N'Ends',N'Threaded'),
  (N'VCG3D-2-1-2IN-SW',N'Size',N'2 1/2"'),(N'VCG3D-2-1-2IN-SW',N'Ends',N'Socket Weld'),
  (N'VCG3D-2-1-2IN-BW',N'Size',N'2 1/2"'),(N'VCG3D-2-1-2IN-BW',N'Ends',N'Butt Weld'),
  (N'VCG3D-3IN-THREADED',N'Size',N'3"'),(N'VCG3D-3IN-THREADED',N'Ends',N'Threaded'),
  (N'VCG3D-3IN-SW',N'Size',N'3"'),(N'VCG3D-3IN-SW',N'Ends',N'Socket Weld'),
  (N'VCG3D-3IN-BW',N'Size',N'3"'),(N'VCG3D-3IN-BW',N'Ends',N'Butt Weld'),
  (N'VCG3D-4IN-THREADED',N'Size',N'4"'),(N'VCG3D-4IN-THREADED',N'Ends',N'Threaded'),
  (N'VCG3D-4IN-SW',N'Size',N'4"'),(N'VCG3D-4IN-SW',N'Ends',N'Socket Weld'),
  (N'VCG3D-4IN-BW',N'Size',N'4"'),(N'VCG3D-4IN-BW',N'Ends',N'Butt Weld')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;

SELECT COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
