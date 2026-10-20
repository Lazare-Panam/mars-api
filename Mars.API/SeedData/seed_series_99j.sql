-- Series 99J (steam jacketed flanged, quote-only Price NULL). Run from file (SSMS: File > Open > Execute).
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 99J')
    INSERT INTO Categories (Name, Description, BodyMaterial, SeatMaterial, Design, Approvals, KeyFeatures)
    VALUES (N'Series 99J',
        N'The Mars Series 99J is a wafer-type, compact steam-jacketed ball valve rated ANSI Class 150 and PN16/40, full port, in sizes 1/2" to 4". CF8M body with 25% carbon+PTFE seats.',
        N'CF8M', N'25% Carbon + PTFE', N'Wafer Type, Steam Jacketed, Compact, Full Port', N'Face-to-face: ANSI B16.10',
        N'Wafer type compact steam jacketed design
Full port
Flange ratings: ANSI #150, PN16/40
CF8M body
25% carbon + PTFE seats
Size 1/2" to 4"');

DECLARE @SeriesName nvarchar(100) = N'Series 99J';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);

INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'Flange Rating')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);

INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'Flange Rating',0),(N'Size',1)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);

INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'V99J-1-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 99J Wafer Type Steam Jacketed Ball Valve', N'V99J - Wafer Type Steam Jacketed Compact Ball Valve, Full Port, Full Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-99j.jpg', NULL),
(N'V99J-1-2IN-PN16-40', @CategoryId, N'Active', N'Mars Series 99J Wafer Type Steam Jacketed Ball Valve', N'V99J - Wafer Type Steam Jacketed Compact Ball Valve, Full Port, Full Port, PN16/40, Body CF8M, Seat 25% Carbon + PTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-99j.jpg', NULL),
(N'V99J-3-4IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 99J Wafer Type Steam Jacketed Ball Valve', N'V99J - Wafer Type Steam Jacketed Compact Ball Valve, Full Port, Full Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-99j.jpg', NULL),
(N'V99J-3-4IN-PN16-40', @CategoryId, N'Active', N'Mars Series 99J Wafer Type Steam Jacketed Ball Valve', N'V99J - Wafer Type Steam Jacketed Compact Ball Valve, Full Port, Full Port, PN16/40, Body CF8M, Seat 25% Carbon + PTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-99j.jpg', NULL),
(N'V99J-1IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 99J Wafer Type Steam Jacketed Ball Valve', N'V99J - Wafer Type Steam Jacketed Compact Ball Valve, Full Port, Full Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-99j.jpg', NULL),
(N'V99J-1IN-PN16-40', @CategoryId, N'Active', N'Mars Series 99J Wafer Type Steam Jacketed Ball Valve', N'V99J - Wafer Type Steam Jacketed Compact Ball Valve, Full Port, Full Port, PN16/40, Body CF8M, Seat 25% Carbon + PTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-99j.jpg', NULL),
(N'V99J-1-1-4IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 99J Wafer Type Steam Jacketed Ball Valve', N'V99J - Wafer Type Steam Jacketed Compact Ball Valve, Full Port, Full Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-99j.jpg', NULL),
(N'V99J-1-1-4IN-PN16-40', @CategoryId, N'Active', N'Mars Series 99J Wafer Type Steam Jacketed Ball Valve', N'V99J - Wafer Type Steam Jacketed Compact Ball Valve, Full Port, Full Port, PN16/40, Body CF8M, Seat 25% Carbon + PTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-99j.jpg', NULL),
(N'V99J-1-1-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 99J Wafer Type Steam Jacketed Ball Valve', N'V99J - Wafer Type Steam Jacketed Compact Ball Valve, Full Port, Full Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-99j.jpg', NULL),
(N'V99J-1-1-2IN-PN16-40', @CategoryId, N'Active', N'Mars Series 99J Wafer Type Steam Jacketed Ball Valve', N'V99J - Wafer Type Steam Jacketed Compact Ball Valve, Full Port, Full Port, PN16/40, Body CF8M, Seat 25% Carbon + PTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-99j.jpg', NULL),
(N'V99J-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 99J Wafer Type Steam Jacketed Ball Valve', N'V99J - Wafer Type Steam Jacketed Compact Ball Valve, Full Port, Full Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-99j.jpg', NULL),
(N'V99J-2IN-PN16-40', @CategoryId, N'Active', N'Mars Series 99J Wafer Type Steam Jacketed Ball Valve', N'V99J - Wafer Type Steam Jacketed Compact Ball Valve, Full Port, Full Port, PN16/40, Body CF8M, Seat 25% Carbon + PTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-99j.jpg', NULL),
(N'V99J-2-1-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 99J Wafer Type Steam Jacketed Ball Valve', N'V99J - Wafer Type Steam Jacketed Compact Ball Valve, Full Port, Full Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-99j.jpg', NULL),
(N'V99J-2-1-2IN-PN16-40', @CategoryId, N'Active', N'Mars Series 99J Wafer Type Steam Jacketed Ball Valve', N'V99J - Wafer Type Steam Jacketed Compact Ball Valve, Full Port, Full Port, PN16/40, Body CF8M, Seat 25% Carbon + PTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-99j.jpg', NULL),
(N'V99J-3IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 99J Wafer Type Steam Jacketed Ball Valve', N'V99J - Wafer Type Steam Jacketed Compact Ball Valve, Full Port, Full Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-99j.jpg', NULL),
(N'V99J-3IN-PN16-40', @CategoryId, N'Active', N'Mars Series 99J Wafer Type Steam Jacketed Ball Valve', N'V99J - Wafer Type Steam Jacketed Compact Ball Valve, Full Port, Full Port, PN16/40, Body CF8M, Seat 25% Carbon + PTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-99j.jpg', NULL),
(N'V99J-4IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 99J Wafer Type Steam Jacketed Ball Valve', N'V99J - Wafer Type Steam Jacketed Compact Ball Valve, Full Port, Full Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-99j.jpg', NULL),
(N'V99J-4IN-PN16-40', @CategoryId, N'Active', N'Mars Series 99J Wafer Type Steam Jacketed Ball Valve', N'V99J - Wafer Type Steam Jacketed Compact Ball Valve, Full Port, Full Port, PN16/40, Body CF8M, Seat 25% Carbon + PTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-99j.jpg', NULL);

INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'V99J-1-2IN-ANSI-150',N'Size',N'1/2"'),(N'V99J-1-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V99J-1-2IN-PN16-40',N'Size',N'1/2"'),(N'V99J-1-2IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V99J-3-4IN-ANSI-150',N'Size',N'3/4"'),(N'V99J-3-4IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V99J-3-4IN-PN16-40',N'Size',N'3/4"'),(N'V99J-3-4IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V99J-1IN-ANSI-150',N'Size',N'1"'),(N'V99J-1IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V99J-1IN-PN16-40',N'Size',N'1"'),(N'V99J-1IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V99J-1-1-4IN-ANSI-150',N'Size',N'1 1/4"'),(N'V99J-1-1-4IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V99J-1-1-4IN-PN16-40',N'Size',N'1 1/4"'),(N'V99J-1-1-4IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V99J-1-1-2IN-ANSI-150',N'Size',N'1 1/2"'),(N'V99J-1-1-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V99J-1-1-2IN-PN16-40',N'Size',N'1 1/2"'),(N'V99J-1-1-2IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V99J-2IN-ANSI-150',N'Size',N'2"'),(N'V99J-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V99J-2IN-PN16-40',N'Size',N'2"'),(N'V99J-2IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V99J-2-1-2IN-ANSI-150',N'Size',N'2 1/2"'),(N'V99J-2-1-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V99J-2-1-2IN-PN16-40',N'Size',N'2 1/2"'),(N'V99J-2-1-2IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V99J-3IN-ANSI-150',N'Size',N'3"'),(N'V99J-3IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V99J-3IN-PN16-40',N'Size',N'3"'),(N'V99J-3IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V99J-4IN-ANSI-150',N'Size',N'4"'),(N'V99J-4IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V99J-4IN-PN16-40',N'Size',N'4"'),(N'V99J-4IN-PN16-40',N'Flange Rating',N'PN16/40')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;

SELECT COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
