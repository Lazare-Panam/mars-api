-- Series F85 (3-piece flanged, quote-only Price NULL). Run from file (SSMS: File > Open > Execute).
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series F85')
    INSERT INTO Categories (Name, Description, BodyMaterial, SeatMaterial, Design, Approvals, KeyFeatures)
    VALUES (N'Series F85',
        N'The Mars Series F85 is a 3-piece, full-port high-pressure flanged ball valve rated ANSI Class 2500, in sizes 1/2" to 2". CF8M body with Delrin/Peek seats and ANSI 2500 flanged ends.',
        N'CF8M', N'Delrin / Peek', N'Three Piece, Flanged, Full Port, High Pressure', NULL,
        N'3-piece full port high pressure flanged design
Flange rating: ANSI #2500
CF8M body
Delrin / Peek seats
ANSI 2500 flanged ends
Size 1/2" to 2"');

DECLARE @SeriesName nvarchar(100) = N'Series F85';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);

INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'Flange Rating')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);

INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'Flange Rating',0),(N'Size',1)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);

INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VF85-1-2IN-ANSI-2500', @CategoryId, N'Active', N'Mars Series F85 Three Piece Flanged Ball Valve', N'VF85 - 3-PC Flanged Ball Valve, Full Port, High Pressure, ANSI #2500, Body CF8M, Seat Delrin / Peek, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/3-piece.jpg', NULL),
(N'VF85-3-4IN-ANSI-2500', @CategoryId, N'Active', N'Mars Series F85 Three Piece Flanged Ball Valve', N'VF85 - 3-PC Flanged Ball Valve, Full Port, High Pressure, ANSI #2500, Body CF8M, Seat Delrin / Peek, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/3-piece.jpg', NULL),
(N'VF85-1IN-ANSI-2500', @CategoryId, N'Active', N'Mars Series F85 Three Piece Flanged Ball Valve', N'VF85 - 3-PC Flanged Ball Valve, Full Port, High Pressure, ANSI #2500, Body CF8M, Seat Delrin / Peek, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/3-piece.jpg', NULL),
(N'VF85-1-1-4IN-ANSI-2500', @CategoryId, N'Active', N'Mars Series F85 Three Piece Flanged Ball Valve', N'VF85 - 3-PC Flanged Ball Valve, Full Port, High Pressure, ANSI #2500, Body CF8M, Seat Delrin / Peek, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/3-piece.jpg', NULL),
(N'VF85-1-1-2IN-ANSI-2500', @CategoryId, N'Active', N'Mars Series F85 Three Piece Flanged Ball Valve', N'VF85 - 3-PC Flanged Ball Valve, Full Port, High Pressure, ANSI #2500, Body CF8M, Seat Delrin / Peek, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/3-piece.jpg', NULL),
(N'VF85-2IN-ANSI-2500', @CategoryId, N'Active', N'Mars Series F85 Three Piece Flanged Ball Valve', N'VF85 - 3-PC Flanged Ball Valve, Full Port, High Pressure, ANSI #2500, Body CF8M, Seat Delrin / Peek, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/3-piece.jpg', NULL);

INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VF85-1-2IN-ANSI-2500',N'Size',N'1/2"'),(N'VF85-1-2IN-ANSI-2500',N'Flange Rating',N'ANSI #2500'),
  (N'VF85-3-4IN-ANSI-2500',N'Size',N'3/4"'),(N'VF85-3-4IN-ANSI-2500',N'Flange Rating',N'ANSI #2500'),
  (N'VF85-1IN-ANSI-2500',N'Size',N'1"'),(N'VF85-1IN-ANSI-2500',N'Flange Rating',N'ANSI #2500'),
  (N'VF85-1-1-4IN-ANSI-2500',N'Size',N'1 1/4"'),(N'VF85-1-1-4IN-ANSI-2500',N'Flange Rating',N'ANSI #2500'),
  (N'VF85-1-1-2IN-ANSI-2500',N'Size',N'1 1/2"'),(N'VF85-1-1-2IN-ANSI-2500',N'Flange Rating',N'ANSI #2500'),
  (N'VF85-2IN-ANSI-2500',N'Size',N'2"'),(N'VF85-2IN-ANSI-2500',N'Flange Rating',N'ANSI #2500')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;

SELECT COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
