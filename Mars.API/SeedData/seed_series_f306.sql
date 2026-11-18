-- Series F306 (metal-seated high-pressure 3-piece, quote-only Price NULL). Run from file (SSMS). Self-cleaning on re-run.
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series F306')
    INSERT INTO Categories (Name, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures)
    VALUES (N'Series F306',
        N'The Mars Series F306 is a 3-piece, direct-mount, metal-seated high-pressure ball valve rated ANSI Class 1500, full port, in sizes 1/2" to 1". CF8M or WCB body with SS316+Stellite seats, a CF8M+hard-chrome ball, a 17-4PH stem and flanged ends.',
        N'CF8M / WCB', N'SS316 + Stellite', N'Three Piece, Direct Mount, Metal Seated, Full Port, High Pressure',
        N'3-piece direct mount metal seated design
Full port high pressure
Pressure rating: ANSI #1500
Flanged ends
Body: CF8M, WCB
Seats: SS316 + Stellite
Ball: CF8M + Hard Chrome
Stem: 17-4PH
Size 1/2" to 1"');

DECLARE @SeriesName nvarchar(100) = N'Series F306';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);

-- Idempotent: clear any prior rows for this series so re-running always yields a clean set.
DELETE FROM ProductFilterValues WHERE CategoryId = @CategoryId;
DELETE FROM CatalogProducts WHERE CategoryId = @CategoryId;
DELETE FROM CategoryFilters WHERE CategoryId = @CategoryId;

INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'Body')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);

INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'Size',0),(N'Body',1)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);

INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VF306-1-2IN-CF8M', @CategoryId, N'Active', N'Mars Series F306 Metal Seated High Pressure Ball Valve', N'VF306 - 3-PC Direct Mount Metal Seated Ball Valve, Full Port, High Pressure, ANSI #1500 Flanged, Body CF8M, Seat SS316 + Stellite, Ball CF8M + Hard Chrome, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/metal-seated/high-pressure/series-F306.jpg', NULL),
(N'VF306-1-2IN-WCB', @CategoryId, N'Active', N'Mars Series F306 Metal Seated High Pressure Ball Valve', N'VF306 - 3-PC Direct Mount Metal Seated Ball Valve, Full Port, High Pressure, ANSI #1500 Flanged, Body WCB, Seat SS316 + Stellite, Ball CF8M + Hard Chrome, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/metal-seated/high-pressure/series-F306.jpg', NULL),
(N'VF306-3-4IN-CF8M', @CategoryId, N'Active', N'Mars Series F306 Metal Seated High Pressure Ball Valve', N'VF306 - 3-PC Direct Mount Metal Seated Ball Valve, Full Port, High Pressure, ANSI #1500 Flanged, Body CF8M, Seat SS316 + Stellite, Ball CF8M + Hard Chrome, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/metal-seated/high-pressure/series-F306.jpg', NULL),
(N'VF306-3-4IN-WCB', @CategoryId, N'Active', N'Mars Series F306 Metal Seated High Pressure Ball Valve', N'VF306 - 3-PC Direct Mount Metal Seated Ball Valve, Full Port, High Pressure, ANSI #1500 Flanged, Body WCB, Seat SS316 + Stellite, Ball CF8M + Hard Chrome, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/metal-seated/high-pressure/series-F306.jpg', NULL),
(N'VF306-1IN-CF8M', @CategoryId, N'Active', N'Mars Series F306 Metal Seated High Pressure Ball Valve', N'VF306 - 3-PC Direct Mount Metal Seated Ball Valve, Full Port, High Pressure, ANSI #1500 Flanged, Body CF8M, Seat SS316 + Stellite, Ball CF8M + Hard Chrome, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/metal-seated/high-pressure/series-F306.jpg', NULL),
(N'VF306-1IN-WCB', @CategoryId, N'Active', N'Mars Series F306 Metal Seated High Pressure Ball Valve', N'VF306 - 3-PC Direct Mount Metal Seated Ball Valve, Full Port, High Pressure, ANSI #1500 Flanged, Body WCB, Seat SS316 + Stellite, Ball CF8M + Hard Chrome, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/metal-seated/high-pressure/series-F306.jpg', NULL);

INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VF306-1-2IN-CF8M',N'Size',N'1/2"'),(N'VF306-1-2IN-CF8M',N'Body',N'CF8M'),
  (N'VF306-1-2IN-WCB',N'Size',N'1/2"'),(N'VF306-1-2IN-WCB',N'Body',N'WCB'),
  (N'VF306-3-4IN-CF8M',N'Size',N'3/4"'),(N'VF306-3-4IN-CF8M',N'Body',N'CF8M'),
  (N'VF306-3-4IN-WCB',N'Size',N'3/4"'),(N'VF306-3-4IN-WCB',N'Body',N'WCB'),
  (N'VF306-1IN-CF8M',N'Size',N'1"'),(N'VF306-1IN-CF8M',N'Body',N'CF8M'),
  (N'VF306-1IN-WCB',N'Size',N'1"'),(N'VF306-1IN-WCB',N'Body',N'WCB')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;

SELECT COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
