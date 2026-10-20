-- Series F88 (3-piece flanged, quote-only Price NULL). Run from file (SSMS: File > Open > Execute).
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series F88')
    INSERT INTO Categories (Name, Description, BodyMaterial, SeatMaterial, Design, Approvals, KeyFeatures)
    VALUES (N'Series F88',
        N'The Mars Series F88 is a 3-piece, full-port, direct-mount flanged ball valve rated ANSI Class 600/900, certified fire-safe and to ISO 15848-1, conforming to ASME B16.34 with face-to-face per B16.10. CF8M, WCB or special alloy body with Delrin/Peek/TFM1600 seats, in sizes 1/2" to 4". Optional NACE MR0175 on request.',
        N'CF8M / WCB / Special Alloy', N'Delrin / Peek / TFM1600', N'Three Piece, Direct Mount, Flanged, Fire-Safe, Full Port', N'Fire-Safe; ISO 15848-1; ASME B16.34',
        N'3-piece full port direct mount flanged design
Flange ratings: ANSI #600, ANSI #900
Fire-safe certified
ISO 15848-1 certified
Conforms to ASME B16.34; face-to-face B16.10
CF8M / WCB / Special Alloy body
Delrin / Peek / TFM1600 seats
Optional NACE MR0175
Size 1/2" to 4"');

DECLARE @SeriesName nvarchar(100) = N'Series F88';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);

INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'Flange Rating')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);

INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'Flange Rating',0),(N'Size',1)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);

INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VF88-1-2IN-ANSI-600', @CategoryId, N'Active', N'Mars Series F88 Three Piece Direct Mount Flanged Ball Valve', N'VF88 - 3-PC Direct Mount Flanged Ball Valve, Full Port, Fire-Safe, ANSI #600, Body CF8M / WCB / Special Alloy, Seat Delrin / Peek / TFM1600, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-f88.jpg', NULL),
(N'VF88-1-2IN-ANSI-900', @CategoryId, N'Active', N'Mars Series F88 Three Piece Direct Mount Flanged Ball Valve', N'VF88 - 3-PC Direct Mount Flanged Ball Valve, Full Port, Fire-Safe, ANSI #900, Body CF8M / WCB / Special Alloy, Seat Delrin / Peek / TFM1600, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-f88.jpg', NULL),
(N'VF88-3-4IN-ANSI-600', @CategoryId, N'Active', N'Mars Series F88 Three Piece Direct Mount Flanged Ball Valve', N'VF88 - 3-PC Direct Mount Flanged Ball Valve, Full Port, Fire-Safe, ANSI #600, Body CF8M / WCB / Special Alloy, Seat Delrin / Peek / TFM1600, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-f88.jpg', NULL),
(N'VF88-3-4IN-ANSI-900', @CategoryId, N'Active', N'Mars Series F88 Three Piece Direct Mount Flanged Ball Valve', N'VF88 - 3-PC Direct Mount Flanged Ball Valve, Full Port, Fire-Safe, ANSI #900, Body CF8M / WCB / Special Alloy, Seat Delrin / Peek / TFM1600, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-f88.jpg', NULL),
(N'VF88-1IN-ANSI-600', @CategoryId, N'Active', N'Mars Series F88 Three Piece Direct Mount Flanged Ball Valve', N'VF88 - 3-PC Direct Mount Flanged Ball Valve, Full Port, Fire-Safe, ANSI #600, Body CF8M / WCB / Special Alloy, Seat Delrin / Peek / TFM1600, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-f88.jpg', NULL),
(N'VF88-1IN-ANSI-900', @CategoryId, N'Active', N'Mars Series F88 Three Piece Direct Mount Flanged Ball Valve', N'VF88 - 3-PC Direct Mount Flanged Ball Valve, Full Port, Fire-Safe, ANSI #900, Body CF8M / WCB / Special Alloy, Seat Delrin / Peek / TFM1600, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-f88.jpg', NULL),
(N'VF88-1-1-4IN-ANSI-600', @CategoryId, N'Active', N'Mars Series F88 Three Piece Direct Mount Flanged Ball Valve', N'VF88 - 3-PC Direct Mount Flanged Ball Valve, Full Port, Fire-Safe, ANSI #600, Body CF8M / WCB / Special Alloy, Seat Delrin / Peek / TFM1600, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-f88.jpg', NULL),
(N'VF88-1-1-4IN-ANSI-900', @CategoryId, N'Active', N'Mars Series F88 Three Piece Direct Mount Flanged Ball Valve', N'VF88 - 3-PC Direct Mount Flanged Ball Valve, Full Port, Fire-Safe, ANSI #900, Body CF8M / WCB / Special Alloy, Seat Delrin / Peek / TFM1600, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-f88.jpg', NULL),
(N'VF88-1-1-2IN-ANSI-600', @CategoryId, N'Active', N'Mars Series F88 Three Piece Direct Mount Flanged Ball Valve', N'VF88 - 3-PC Direct Mount Flanged Ball Valve, Full Port, Fire-Safe, ANSI #600, Body CF8M / WCB / Special Alloy, Seat Delrin / Peek / TFM1600, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-f88.jpg', NULL),
(N'VF88-1-1-2IN-ANSI-900', @CategoryId, N'Active', N'Mars Series F88 Three Piece Direct Mount Flanged Ball Valve', N'VF88 - 3-PC Direct Mount Flanged Ball Valve, Full Port, Fire-Safe, ANSI #900, Body CF8M / WCB / Special Alloy, Seat Delrin / Peek / TFM1600, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-f88.jpg', NULL),
(N'VF88-2IN-ANSI-600', @CategoryId, N'Active', N'Mars Series F88 Three Piece Direct Mount Flanged Ball Valve', N'VF88 - 3-PC Direct Mount Flanged Ball Valve, Full Port, Fire-Safe, ANSI #600, Body CF8M / WCB / Special Alloy, Seat Delrin / Peek / TFM1600, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-f88.jpg', NULL),
(N'VF88-2IN-ANSI-900', @CategoryId, N'Active', N'Mars Series F88 Three Piece Direct Mount Flanged Ball Valve', N'VF88 - 3-PC Direct Mount Flanged Ball Valve, Full Port, Fire-Safe, ANSI #900, Body CF8M / WCB / Special Alloy, Seat Delrin / Peek / TFM1600, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-f88.jpg', NULL),
(N'VF88-2-1-2IN-ANSI-600', @CategoryId, N'Active', N'Mars Series F88 Three Piece Direct Mount Flanged Ball Valve', N'VF88 - 3-PC Direct Mount Flanged Ball Valve, Full Port, Fire-Safe, ANSI #600, Body CF8M / WCB / Special Alloy, Seat Delrin / Peek / TFM1600, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-f88.jpg', NULL),
(N'VF88-2-1-2IN-ANSI-900', @CategoryId, N'Active', N'Mars Series F88 Three Piece Direct Mount Flanged Ball Valve', N'VF88 - 3-PC Direct Mount Flanged Ball Valve, Full Port, Fire-Safe, ANSI #900, Body CF8M / WCB / Special Alloy, Seat Delrin / Peek / TFM1600, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-f88.jpg', NULL),
(N'VF88-3IN-ANSI-600', @CategoryId, N'Active', N'Mars Series F88 Three Piece Direct Mount Flanged Ball Valve', N'VF88 - 3-PC Direct Mount Flanged Ball Valve, Full Port, Fire-Safe, ANSI #600, Body CF8M / WCB / Special Alloy, Seat Delrin / Peek / TFM1600, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-f88.jpg', NULL),
(N'VF88-3IN-ANSI-900', @CategoryId, N'Active', N'Mars Series F88 Three Piece Direct Mount Flanged Ball Valve', N'VF88 - 3-PC Direct Mount Flanged Ball Valve, Full Port, Fire-Safe, ANSI #900, Body CF8M / WCB / Special Alloy, Seat Delrin / Peek / TFM1600, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-f88.jpg', NULL),
(N'VF88-4IN-ANSI-600', @CategoryId, N'Active', N'Mars Series F88 Three Piece Direct Mount Flanged Ball Valve', N'VF88 - 3-PC Direct Mount Flanged Ball Valve, Full Port, Fire-Safe, ANSI #600, Body CF8M / WCB / Special Alloy, Seat Delrin / Peek / TFM1600, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-f88.jpg', NULL),
(N'VF88-4IN-ANSI-900', @CategoryId, N'Active', N'Mars Series F88 Three Piece Direct Mount Flanged Ball Valve', N'VF88 - 3-PC Direct Mount Flanged Ball Valve, Full Port, Fire-Safe, ANSI #900, Body CF8M / WCB / Special Alloy, Seat Delrin / Peek / TFM1600, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-f88.jpg', NULL);

INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VF88-1-2IN-ANSI-600',N'Size',N'1/2"'),(N'VF88-1-2IN-ANSI-600',N'Flange Rating',N'ANSI #600'),
  (N'VF88-1-2IN-ANSI-900',N'Size',N'1/2"'),(N'VF88-1-2IN-ANSI-900',N'Flange Rating',N'ANSI #900'),
  (N'VF88-3-4IN-ANSI-600',N'Size',N'3/4"'),(N'VF88-3-4IN-ANSI-600',N'Flange Rating',N'ANSI #600'),
  (N'VF88-3-4IN-ANSI-900',N'Size',N'3/4"'),(N'VF88-3-4IN-ANSI-900',N'Flange Rating',N'ANSI #900'),
  (N'VF88-1IN-ANSI-600',N'Size',N'1"'),(N'VF88-1IN-ANSI-600',N'Flange Rating',N'ANSI #600'),
  (N'VF88-1IN-ANSI-900',N'Size',N'1"'),(N'VF88-1IN-ANSI-900',N'Flange Rating',N'ANSI #900'),
  (N'VF88-1-1-4IN-ANSI-600',N'Size',N'1 1/4"'),(N'VF88-1-1-4IN-ANSI-600',N'Flange Rating',N'ANSI #600'),
  (N'VF88-1-1-4IN-ANSI-900',N'Size',N'1 1/4"'),(N'VF88-1-1-4IN-ANSI-900',N'Flange Rating',N'ANSI #900'),
  (N'VF88-1-1-2IN-ANSI-600',N'Size',N'1 1/2"'),(N'VF88-1-1-2IN-ANSI-600',N'Flange Rating',N'ANSI #600'),
  (N'VF88-1-1-2IN-ANSI-900',N'Size',N'1 1/2"'),(N'VF88-1-1-2IN-ANSI-900',N'Flange Rating',N'ANSI #900'),
  (N'VF88-2IN-ANSI-600',N'Size',N'2"'),(N'VF88-2IN-ANSI-600',N'Flange Rating',N'ANSI #600'),
  (N'VF88-2IN-ANSI-900',N'Size',N'2"'),(N'VF88-2IN-ANSI-900',N'Flange Rating',N'ANSI #900'),
  (N'VF88-2-1-2IN-ANSI-600',N'Size',N'2 1/2"'),(N'VF88-2-1-2IN-ANSI-600',N'Flange Rating',N'ANSI #600'),
  (N'VF88-2-1-2IN-ANSI-900',N'Size',N'2 1/2"'),(N'VF88-2-1-2IN-ANSI-900',N'Flange Rating',N'ANSI #900'),
  (N'VF88-3IN-ANSI-600',N'Size',N'3"'),(N'VF88-3IN-ANSI-600',N'Flange Rating',N'ANSI #600'),
  (N'VF88-3IN-ANSI-900',N'Size',N'3"'),(N'VF88-3IN-ANSI-900',N'Flange Rating',N'ANSI #900'),
  (N'VF88-4IN-ANSI-600',N'Size',N'4"'),(N'VF88-4IN-ANSI-600',N'Flange Rating',N'ANSI #600'),
  (N'VF88-4IN-ANSI-900',N'Size',N'4"'),(N'VF88-4IN-ANSI-900',N'Flange Rating',N'ANSI #900')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;

SELECT COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
