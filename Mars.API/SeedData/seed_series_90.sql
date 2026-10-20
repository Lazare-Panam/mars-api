-- Series 90 (2-piece fire-safe flanged, quote-only Price NULL). Run from file (SSMS: File > Open > Execute).
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 90')
    INSERT INTO Categories (Name, Description, BodyMaterial, SeatMaterial, Design, Approvals, KeyFeatures)
    VALUES (N'Series 90',
        N'The Mars Series 90 is a 2-piece, full-port fire-safe flanged ball valve rated ANSI Class 150/300, PN16/40 and JIS 5K, certified to API 607 (7th Edition). Face-to-face per ANSI B16.10 / EN 558-1 (GR.1/GR.27, DIN 3202 F1/F4/F5), in sizes 1/2" to 4". CF8M, WCB or special alloy body with PTFE/RTFE seats. Available with 30/60/90 degree V-port ball for flow control. Optional NACE MR0175 on request.',
        N'CF8M / WCB / Special Alloy', N'PTFE / RTFE', N'Two Piece, Fire-Safe, Flanged, Full Port', N'Fire-Safe API 607, 7th Edition',
        N'2-piece full port fire-safe flanged design
Flange ratings: ANSI #150/#300, PN16/40, JIS 5K
Face-to-face: ANSI B16.10, EN 558-1 (GR.1/GR.27, DIN 3202 F1/F4/F5)
Rated to API 607, 7th Edition
CF8M / WCB / Special Alloy body
PTFE / RTFE seats
Size 1/2" to 4"
Optional 30/60/90 degree V-port ball
Optional NACE MR0175');

DECLARE @SeriesName nvarchar(100) = N'Series 90';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);

INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'Flange Rating')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);

INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'Flange Rating',0),(N'Size',1)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);

INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'V90-1-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-1-2IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, ANSI #300, Body CF8M / WCB, Seat PTFE / RTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-1-2IN-PN16-40', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, PN16/40, Body CF8M / WCB, Seat PTFE / RTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-1-2IN-JIS-5K', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, JIS 5K, Body CF8M / WCB, Seat PTFE / RTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-3-4IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-3-4IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, ANSI #300, Body CF8M / WCB, Seat PTFE / RTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-3-4IN-PN16-40', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, PN16/40, Body CF8M / WCB, Seat PTFE / RTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-3-4IN-JIS-5K', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, JIS 5K, Body CF8M / WCB, Seat PTFE / RTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-1IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-1IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, ANSI #300, Body CF8M / WCB, Seat PTFE / RTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-1IN-PN16-40', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, PN16/40, Body CF8M / WCB, Seat PTFE / RTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-1IN-JIS-5K', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, JIS 5K, Body CF8M / WCB, Seat PTFE / RTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-1-1-4IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-1-1-4IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, ANSI #300, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-1-1-4IN-PN16-40', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, PN16/40, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-1-1-4IN-JIS-5K', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, JIS 5K, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-1-1-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-1-1-2IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, ANSI #300, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-1-1-2IN-PN16-40', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, PN16/40, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-1-1-2IN-JIS-5K', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, JIS 5K, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-2IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, ANSI #300, Body CF8M / WCB, Seat PTFE / RTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-2IN-PN16-40', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, PN16/40, Body CF8M / WCB, Seat PTFE / RTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-2IN-JIS-5K', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, JIS 5K, Body CF8M / WCB, Seat PTFE / RTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-2-1-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-2-1-2IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, ANSI #300, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-2-1-2IN-PN16-40', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, PN16/40, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-2-1-2IN-JIS-5K', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, JIS 5K, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-3IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-3IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, ANSI #300, Body CF8M / WCB, Seat PTFE / RTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-3IN-PN16-40', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, PN16/40, Body CF8M / WCB, Seat PTFE / RTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-3IN-JIS-5K', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, JIS 5K, Body CF8M / WCB, Seat PTFE / RTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-4IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-4IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, ANSI #300, Body CF8M / WCB, Seat PTFE / RTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-4IN-PN16-40', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, PN16/40, Body CF8M / WCB, Seat PTFE / RTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL),
(N'V90-4IN-JIS-5K', @CategoryId, N'Active', N'Mars Series 90 Two Piece Fire-Safe Flanged Ball Valve', N'V90 - 2-PC Fire-Safe Flanged Ball Valve, Full Port, JIS 5K, Body CF8M / WCB, Seat PTFE / RTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-90.png', NULL);

INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'V90-1-2IN-ANSI-150',N'Size',N'1/2"'),(N'V90-1-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V90-1-2IN-ANSI-300',N'Size',N'1/2"'),(N'V90-1-2IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V90-1-2IN-PN16-40',N'Size',N'1/2"'),(N'V90-1-2IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V90-1-2IN-JIS-5K',N'Size',N'1/2"'),(N'V90-1-2IN-JIS-5K',N'Flange Rating',N'JIS 5K'),
  (N'V90-3-4IN-ANSI-150',N'Size',N'3/4"'),(N'V90-3-4IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V90-3-4IN-ANSI-300',N'Size',N'3/4"'),(N'V90-3-4IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V90-3-4IN-PN16-40',N'Size',N'3/4"'),(N'V90-3-4IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V90-3-4IN-JIS-5K',N'Size',N'3/4"'),(N'V90-3-4IN-JIS-5K',N'Flange Rating',N'JIS 5K'),
  (N'V90-1IN-ANSI-150',N'Size',N'1"'),(N'V90-1IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V90-1IN-ANSI-300',N'Size',N'1"'),(N'V90-1IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V90-1IN-PN16-40',N'Size',N'1"'),(N'V90-1IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V90-1IN-JIS-5K',N'Size',N'1"'),(N'V90-1IN-JIS-5K',N'Flange Rating',N'JIS 5K'),
  (N'V90-1-1-4IN-ANSI-150',N'Size',N'1 1/4"'),(N'V90-1-1-4IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V90-1-1-4IN-ANSI-300',N'Size',N'1 1/4"'),(N'V90-1-1-4IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V90-1-1-4IN-PN16-40',N'Size',N'1 1/4"'),(N'V90-1-1-4IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V90-1-1-4IN-JIS-5K',N'Size',N'1 1/4"'),(N'V90-1-1-4IN-JIS-5K',N'Flange Rating',N'JIS 5K'),
  (N'V90-1-1-2IN-ANSI-150',N'Size',N'1 1/2"'),(N'V90-1-1-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V90-1-1-2IN-ANSI-300',N'Size',N'1 1/2"'),(N'V90-1-1-2IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V90-1-1-2IN-PN16-40',N'Size',N'1 1/2"'),(N'V90-1-1-2IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V90-1-1-2IN-JIS-5K',N'Size',N'1 1/2"'),(N'V90-1-1-2IN-JIS-5K',N'Flange Rating',N'JIS 5K'),
  (N'V90-2IN-ANSI-150',N'Size',N'2"'),(N'V90-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V90-2IN-ANSI-300',N'Size',N'2"'),(N'V90-2IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V90-2IN-PN16-40',N'Size',N'2"'),(N'V90-2IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V90-2IN-JIS-5K',N'Size',N'2"'),(N'V90-2IN-JIS-5K',N'Flange Rating',N'JIS 5K'),
  (N'V90-2-1-2IN-ANSI-150',N'Size',N'2 1/2"'),(N'V90-2-1-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V90-2-1-2IN-ANSI-300',N'Size',N'2 1/2"'),(N'V90-2-1-2IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V90-2-1-2IN-PN16-40',N'Size',N'2 1/2"'),(N'V90-2-1-2IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V90-2-1-2IN-JIS-5K',N'Size',N'2 1/2"'),(N'V90-2-1-2IN-JIS-5K',N'Flange Rating',N'JIS 5K'),
  (N'V90-3IN-ANSI-150',N'Size',N'3"'),(N'V90-3IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V90-3IN-ANSI-300',N'Size',N'3"'),(N'V90-3IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V90-3IN-PN16-40',N'Size',N'3"'),(N'V90-3IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V90-3IN-JIS-5K',N'Size',N'3"'),(N'V90-3IN-JIS-5K',N'Flange Rating',N'JIS 5K'),
  (N'V90-4IN-ANSI-150',N'Size',N'4"'),(N'V90-4IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V90-4IN-ANSI-300',N'Size',N'4"'),(N'V90-4IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V90-4IN-PN16-40',N'Size',N'4"'),(N'V90-4IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V90-4IN-JIS-5K',N'Size',N'4"'),(N'V90-4IN-JIS-5K',N'Flange Rating',N'JIS 5K')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;

SELECT COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
