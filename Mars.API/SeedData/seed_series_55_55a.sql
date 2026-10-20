-- Economical 3-piece quote-only batch: Series 55, 55A.
-- No catalog PDF supplied -> CatalogUrl/DatasheetUrl NULL. GO splits the batches.

-- ===== Series 55 (33 products, quote-only Price NULL) =====
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 55')
    INSERT INTO Categories (Name, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures)
    VALUES (N'Series 55', N'The Mars Series 55 is a 3-piece, full-port economical ball valve with an ISO 5211 mounting pad, rated to 1000 PSI. CF8M or WCB body with PTFE/RTFE seats, in threaded, butt-weld or socket-weld ends, sizes 1/4" to 4". Conforms to B16.34 on request.', N'CF8M / WCB', N'PTFE / RTFE', N'Three Piece, Economical, Full Port, ISO 5211 Mounting Pad', N'3-piece economical full port design
ISO 5211 mounting pad for actuation
Ends: Threaded, Butt Weld, Socket Weld
Rated to 1000 PSI
CF8M or WCB body
PTFE / RTFE seats
Size 1/4" to 4"
Conforms to B16.34 on request');
GO
DECLARE @SeriesName nvarchar(100) = N'Series 55';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);
INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'End Connection'),(N'Operating Pressure')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);
INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'End Connection',0),(N'Size',1),(N'Operating Pressure',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);
INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'V55-1-4IN-THREADED', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-1-4IN-BW', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-1-4IN-SW', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-3-8IN-THREADED', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-3-8IN-BW', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-3-8IN-SW', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-1-2IN-THREADED', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-1-2IN-BW', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-1-2IN-SW', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-3-4IN-THREADED', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-3-4IN-BW', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-3-4IN-SW', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-1IN-THREADED', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-1IN-BW', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-1IN-SW', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-1-1-4IN-THREADED', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-1-1-4IN-BW', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-1-1-4IN-SW', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-1-1-2IN-THREADED', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-1-1-2IN-BW', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-1-1-2IN-SW', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-2IN-THREADED', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-2IN-BW', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-2IN-SW', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-2-1-2IN-THREADED', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-2-1-2IN-BW', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-2-1-2IN-SW', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-3IN-THREADED', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-3IN-BW', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-3IN-SW', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-4IN-THREADED', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 4", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-4IN-BW', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 4", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL),
(N'V55-4IN-SW', @CategoryId, N'Active', N'Mars Series 55 Three Piece Ball Valve', N'V55 - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 4", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55.jpg', NULL);
INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'V55-1-4IN-THREADED',N'Size',N'1/4"'),(N'V55-1-4IN-THREADED',N'End Connection',N'Threaded'),(N'V55-1-4IN-THREADED',N'Operating Pressure',N'1000 PSI'),
  (N'V55-1-4IN-BW',N'Size',N'1/4"'),(N'V55-1-4IN-BW',N'End Connection',N'Butt Weld'),(N'V55-1-4IN-BW',N'Operating Pressure',N'1000 PSI'),
  (N'V55-1-4IN-SW',N'Size',N'1/4"'),(N'V55-1-4IN-SW',N'End Connection',N'Socket Weld'),(N'V55-1-4IN-SW',N'Operating Pressure',N'1000 PSI'),
  (N'V55-3-8IN-THREADED',N'Size',N'3/8"'),(N'V55-3-8IN-THREADED',N'End Connection',N'Threaded'),(N'V55-3-8IN-THREADED',N'Operating Pressure',N'1000 PSI'),
  (N'V55-3-8IN-BW',N'Size',N'3/8"'),(N'V55-3-8IN-BW',N'End Connection',N'Butt Weld'),(N'V55-3-8IN-BW',N'Operating Pressure',N'1000 PSI'),
  (N'V55-3-8IN-SW',N'Size',N'3/8"'),(N'V55-3-8IN-SW',N'End Connection',N'Socket Weld'),(N'V55-3-8IN-SW',N'Operating Pressure',N'1000 PSI'),
  (N'V55-1-2IN-THREADED',N'Size',N'1/2"'),(N'V55-1-2IN-THREADED',N'End Connection',N'Threaded'),(N'V55-1-2IN-THREADED',N'Operating Pressure',N'1000 PSI'),
  (N'V55-1-2IN-BW',N'Size',N'1/2"'),(N'V55-1-2IN-BW',N'End Connection',N'Butt Weld'),(N'V55-1-2IN-BW',N'Operating Pressure',N'1000 PSI'),
  (N'V55-1-2IN-SW',N'Size',N'1/2"'),(N'V55-1-2IN-SW',N'End Connection',N'Socket Weld'),(N'V55-1-2IN-SW',N'Operating Pressure',N'1000 PSI'),
  (N'V55-3-4IN-THREADED',N'Size',N'3/4"'),(N'V55-3-4IN-THREADED',N'End Connection',N'Threaded'),(N'V55-3-4IN-THREADED',N'Operating Pressure',N'1000 PSI'),
  (N'V55-3-4IN-BW',N'Size',N'3/4"'),(N'V55-3-4IN-BW',N'End Connection',N'Butt Weld'),(N'V55-3-4IN-BW',N'Operating Pressure',N'1000 PSI'),
  (N'V55-3-4IN-SW',N'Size',N'3/4"'),(N'V55-3-4IN-SW',N'End Connection',N'Socket Weld'),(N'V55-3-4IN-SW',N'Operating Pressure',N'1000 PSI'),
  (N'V55-1IN-THREADED',N'Size',N'1"'),(N'V55-1IN-THREADED',N'End Connection',N'Threaded'),(N'V55-1IN-THREADED',N'Operating Pressure',N'1000 PSI'),
  (N'V55-1IN-BW',N'Size',N'1"'),(N'V55-1IN-BW',N'End Connection',N'Butt Weld'),(N'V55-1IN-BW',N'Operating Pressure',N'1000 PSI'),
  (N'V55-1IN-SW',N'Size',N'1"'),(N'V55-1IN-SW',N'End Connection',N'Socket Weld'),(N'V55-1IN-SW',N'Operating Pressure',N'1000 PSI'),
  (N'V55-1-1-4IN-THREADED',N'Size',N'1 1/4"'),(N'V55-1-1-4IN-THREADED',N'End Connection',N'Threaded'),(N'V55-1-1-4IN-THREADED',N'Operating Pressure',N'1000 PSI'),
  (N'V55-1-1-4IN-BW',N'Size',N'1 1/4"'),(N'V55-1-1-4IN-BW',N'End Connection',N'Butt Weld'),(N'V55-1-1-4IN-BW',N'Operating Pressure',N'1000 PSI'),
  (N'V55-1-1-4IN-SW',N'Size',N'1 1/4"'),(N'V55-1-1-4IN-SW',N'End Connection',N'Socket Weld'),(N'V55-1-1-4IN-SW',N'Operating Pressure',N'1000 PSI'),
  (N'V55-1-1-2IN-THREADED',N'Size',N'1 1/2"'),(N'V55-1-1-2IN-THREADED',N'End Connection',N'Threaded'),(N'V55-1-1-2IN-THREADED',N'Operating Pressure',N'1000 PSI'),
  (N'V55-1-1-2IN-BW',N'Size',N'1 1/2"'),(N'V55-1-1-2IN-BW',N'End Connection',N'Butt Weld'),(N'V55-1-1-2IN-BW',N'Operating Pressure',N'1000 PSI'),
  (N'V55-1-1-2IN-SW',N'Size',N'1 1/2"'),(N'V55-1-1-2IN-SW',N'End Connection',N'Socket Weld'),(N'V55-1-1-2IN-SW',N'Operating Pressure',N'1000 PSI'),
  (N'V55-2IN-THREADED',N'Size',N'2"'),(N'V55-2IN-THREADED',N'End Connection',N'Threaded'),(N'V55-2IN-THREADED',N'Operating Pressure',N'1000 PSI'),
  (N'V55-2IN-BW',N'Size',N'2"'),(N'V55-2IN-BW',N'End Connection',N'Butt Weld'),(N'V55-2IN-BW',N'Operating Pressure',N'1000 PSI'),
  (N'V55-2IN-SW',N'Size',N'2"'),(N'V55-2IN-SW',N'End Connection',N'Socket Weld'),(N'V55-2IN-SW',N'Operating Pressure',N'1000 PSI'),
  (N'V55-2-1-2IN-THREADED',N'Size',N'2 1/2"'),(N'V55-2-1-2IN-THREADED',N'End Connection',N'Threaded'),(N'V55-2-1-2IN-THREADED',N'Operating Pressure',N'1000 PSI'),
  (N'V55-2-1-2IN-BW',N'Size',N'2 1/2"'),(N'V55-2-1-2IN-BW',N'End Connection',N'Butt Weld'),(N'V55-2-1-2IN-BW',N'Operating Pressure',N'1000 PSI'),
  (N'V55-2-1-2IN-SW',N'Size',N'2 1/2"'),(N'V55-2-1-2IN-SW',N'End Connection',N'Socket Weld'),(N'V55-2-1-2IN-SW',N'Operating Pressure',N'1000 PSI'),
  (N'V55-3IN-THREADED',N'Size',N'3"'),(N'V55-3IN-THREADED',N'End Connection',N'Threaded'),(N'V55-3IN-THREADED',N'Operating Pressure',N'1000 PSI'),
  (N'V55-3IN-BW',N'Size',N'3"'),(N'V55-3IN-BW',N'End Connection',N'Butt Weld'),(N'V55-3IN-BW',N'Operating Pressure',N'1000 PSI'),
  (N'V55-3IN-SW',N'Size',N'3"'),(N'V55-3IN-SW',N'End Connection',N'Socket Weld'),(N'V55-3IN-SW',N'Operating Pressure',N'1000 PSI'),
  (N'V55-4IN-THREADED',N'Size',N'4"'),(N'V55-4IN-THREADED',N'End Connection',N'Threaded'),(N'V55-4IN-THREADED',N'Operating Pressure',N'1000 PSI'),
  (N'V55-4IN-BW',N'Size',N'4"'),(N'V55-4IN-BW',N'End Connection',N'Butt Weld'),(N'V55-4IN-BW',N'Operating Pressure',N'1000 PSI'),
  (N'V55-4IN-SW',N'Size',N'4"'),(N'V55-4IN-SW',N'End Connection',N'Socket Weld'),(N'V55-4IN-SW',N'Operating Pressure',N'1000 PSI')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;
SELECT N'Series 55' AS Series, COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
GO

-- ===== Series 55A (33 products, quote-only Price NULL) =====
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 55A')
    INSERT INTO Categories (Name, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures)
    VALUES (N'Series 55A', N'The Mars Series 55A is a 3-piece, full-port economical ball valve with an ISO 5211 mounting pad, rated to 1000 PSI. CF8M or WCB body with PTFE/RTFE seats, in threaded, butt-weld or socket-weld ends, sizes 1/4" to 4".', N'CF8M / WCB', N'PTFE / RTFE', N'Three Piece, Economical, Full Port, ISO 5211 Mounting Pad', N'3-piece economical full port design
ISO 5211 mounting pad for actuation
Ends: Threaded, Butt Weld, Socket Weld
Rated to 1000 PSI
CF8M or WCB body
PTFE / RTFE seats
Size 1/4" to 4"');
GO
DECLARE @SeriesName nvarchar(100) = N'Series 55A';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);
INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'End Connection'),(N'Operating Pressure')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);
INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'End Connection',0),(N'Size',1),(N'Operating Pressure',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);
INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'V55A-1-4IN-THREADED', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-1-4IN-BW', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-1-4IN-SW', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/4", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-3-8IN-THREADED', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-3-8IN-BW', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-3-8IN-SW', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/8", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-1-2IN-THREADED', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-1-2IN-BW', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-1-2IN-SW', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1/2", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-3-4IN-THREADED', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-3-4IN-BW', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-3-4IN-SW', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3/4", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-1IN-THREADED', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-1IN-BW', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-1IN-SW', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-1-1-4IN-THREADED', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-1-1-4IN-BW', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-1-1-4IN-SW', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-1-1-2IN-THREADED', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-1-1-2IN-BW', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-1-1-2IN-SW', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-2IN-THREADED', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-2IN-BW', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-2IN-SW', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-2-1-2IN-THREADED', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-2-1-2IN-BW', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-2-1-2IN-SW', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-3IN-THREADED', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-3IN-BW', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-3IN-SW', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 3", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-4IN-THREADED', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 4", Threaded', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-4IN-BW', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 4", Butt Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL),
(N'V55A-4IN-SW', @CategoryId, N'Active', N'Mars Series 55A Three Piece Ball Valve', N'V55A - 3-PC Economical Ball Valve, Full Port, ISO 5211 Mounting Pad, 1000 PSI, Body CF8M / WCB, Seat PTFE / RTFE, 4", Socket Weld', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/economical-three-piece-ball-valve/series-55a.jpg', NULL);
INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'V55A-1-4IN-THREADED',N'Size',N'1/4"'),(N'V55A-1-4IN-THREADED',N'End Connection',N'Threaded'),(N'V55A-1-4IN-THREADED',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-1-4IN-BW',N'Size',N'1/4"'),(N'V55A-1-4IN-BW',N'End Connection',N'Butt Weld'),(N'V55A-1-4IN-BW',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-1-4IN-SW',N'Size',N'1/4"'),(N'V55A-1-4IN-SW',N'End Connection',N'Socket Weld'),(N'V55A-1-4IN-SW',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-3-8IN-THREADED',N'Size',N'3/8"'),(N'V55A-3-8IN-THREADED',N'End Connection',N'Threaded'),(N'V55A-3-8IN-THREADED',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-3-8IN-BW',N'Size',N'3/8"'),(N'V55A-3-8IN-BW',N'End Connection',N'Butt Weld'),(N'V55A-3-8IN-BW',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-3-8IN-SW',N'Size',N'3/8"'),(N'V55A-3-8IN-SW',N'End Connection',N'Socket Weld'),(N'V55A-3-8IN-SW',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-1-2IN-THREADED',N'Size',N'1/2"'),(N'V55A-1-2IN-THREADED',N'End Connection',N'Threaded'),(N'V55A-1-2IN-THREADED',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-1-2IN-BW',N'Size',N'1/2"'),(N'V55A-1-2IN-BW',N'End Connection',N'Butt Weld'),(N'V55A-1-2IN-BW',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-1-2IN-SW',N'Size',N'1/2"'),(N'V55A-1-2IN-SW',N'End Connection',N'Socket Weld'),(N'V55A-1-2IN-SW',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-3-4IN-THREADED',N'Size',N'3/4"'),(N'V55A-3-4IN-THREADED',N'End Connection',N'Threaded'),(N'V55A-3-4IN-THREADED',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-3-4IN-BW',N'Size',N'3/4"'),(N'V55A-3-4IN-BW',N'End Connection',N'Butt Weld'),(N'V55A-3-4IN-BW',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-3-4IN-SW',N'Size',N'3/4"'),(N'V55A-3-4IN-SW',N'End Connection',N'Socket Weld'),(N'V55A-3-4IN-SW',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-1IN-THREADED',N'Size',N'1"'),(N'V55A-1IN-THREADED',N'End Connection',N'Threaded'),(N'V55A-1IN-THREADED',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-1IN-BW',N'Size',N'1"'),(N'V55A-1IN-BW',N'End Connection',N'Butt Weld'),(N'V55A-1IN-BW',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-1IN-SW',N'Size',N'1"'),(N'V55A-1IN-SW',N'End Connection',N'Socket Weld'),(N'V55A-1IN-SW',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-1-1-4IN-THREADED',N'Size',N'1 1/4"'),(N'V55A-1-1-4IN-THREADED',N'End Connection',N'Threaded'),(N'V55A-1-1-4IN-THREADED',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-1-1-4IN-BW',N'Size',N'1 1/4"'),(N'V55A-1-1-4IN-BW',N'End Connection',N'Butt Weld'),(N'V55A-1-1-4IN-BW',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-1-1-4IN-SW',N'Size',N'1 1/4"'),(N'V55A-1-1-4IN-SW',N'End Connection',N'Socket Weld'),(N'V55A-1-1-4IN-SW',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-1-1-2IN-THREADED',N'Size',N'1 1/2"'),(N'V55A-1-1-2IN-THREADED',N'End Connection',N'Threaded'),(N'V55A-1-1-2IN-THREADED',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-1-1-2IN-BW',N'Size',N'1 1/2"'),(N'V55A-1-1-2IN-BW',N'End Connection',N'Butt Weld'),(N'V55A-1-1-2IN-BW',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-1-1-2IN-SW',N'Size',N'1 1/2"'),(N'V55A-1-1-2IN-SW',N'End Connection',N'Socket Weld'),(N'V55A-1-1-2IN-SW',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-2IN-THREADED',N'Size',N'2"'),(N'V55A-2IN-THREADED',N'End Connection',N'Threaded'),(N'V55A-2IN-THREADED',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-2IN-BW',N'Size',N'2"'),(N'V55A-2IN-BW',N'End Connection',N'Butt Weld'),(N'V55A-2IN-BW',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-2IN-SW',N'Size',N'2"'),(N'V55A-2IN-SW',N'End Connection',N'Socket Weld'),(N'V55A-2IN-SW',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-2-1-2IN-THREADED',N'Size',N'2 1/2"'),(N'V55A-2-1-2IN-THREADED',N'End Connection',N'Threaded'),(N'V55A-2-1-2IN-THREADED',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-2-1-2IN-BW',N'Size',N'2 1/2"'),(N'V55A-2-1-2IN-BW',N'End Connection',N'Butt Weld'),(N'V55A-2-1-2IN-BW',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-2-1-2IN-SW',N'Size',N'2 1/2"'),(N'V55A-2-1-2IN-SW',N'End Connection',N'Socket Weld'),(N'V55A-2-1-2IN-SW',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-3IN-THREADED',N'Size',N'3"'),(N'V55A-3IN-THREADED',N'End Connection',N'Threaded'),(N'V55A-3IN-THREADED',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-3IN-BW',N'Size',N'3"'),(N'V55A-3IN-BW',N'End Connection',N'Butt Weld'),(N'V55A-3IN-BW',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-3IN-SW',N'Size',N'3"'),(N'V55A-3IN-SW',N'End Connection',N'Socket Weld'),(N'V55A-3IN-SW',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-4IN-THREADED',N'Size',N'4"'),(N'V55A-4IN-THREADED',N'End Connection',N'Threaded'),(N'V55A-4IN-THREADED',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-4IN-BW',N'Size',N'4"'),(N'V55A-4IN-BW',N'End Connection',N'Butt Weld'),(N'V55A-4IN-BW',N'Operating Pressure',N'1000 PSI'),
  (N'V55A-4IN-SW',N'Size',N'4"'),(N'V55A-4IN-SW',N'End Connection',N'Socket Weld'),(N'V55A-4IN-SW',N'Operating Pressure',N'1000 PSI')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;
SELECT N'Series 55A' AS Series, COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
GO
