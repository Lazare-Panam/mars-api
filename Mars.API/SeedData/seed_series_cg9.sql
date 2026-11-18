-- Series CG9-10/30/40 (2-piece cryogenic flanged, quote-only Price NULL). Run from file (SSMS).
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series CG9-10/30/40')
    INSERT INTO Categories (Name, Description, BodyMaterial, SeatMaterial, Design, TemperatureRange, KeyFeatures)
    VALUES (N'Series CG9-10/30/40',
        N'The Mars Series CG9-10/30/40 is a 2-piece, full-port cryogenic flanged ball valve with an ISO 5211 direct-mount pad and a blow-out-proof stem, rated for -196 to +95 degree C. CF8M body with PCTFE seats and a Viton stem o-ring, in ANSI #150, PN10/16 or PN40 flanged ends, sizes 1/2" to 4".',
        N'CF8M', N'PCTFE', N'Two Piece, Cryogenic, Flanged, Full Port, Direct Mount', N'-196 to +95 degree C',
        N'2-piece cryogenic full port design
ISO 5211 direct mount
Blow-out proof stem
Flange ratings: ANSI #150, PN10/16, PN40
CF8M body
PCTFE seats
Viton o-ring on stem
Temperature range -196 to +95 degree C
Size 1/2" to 4"');

DECLARE @SeriesName nvarchar(100) = N'Series CG9-10/30/40';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);

INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'Flange Rating')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);

INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'Flange Rating',0),(N'Size',1)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);

INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VCG9-1-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, ANSI #150, Body CF8M, Seat PCTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-1-2IN-PN10-16', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, PN10/16, Body CF8M, Seat PCTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-1-2IN-PN40', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, PN40, Body CF8M, Seat PCTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-3-4IN-ANSI-150', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, ANSI #150, Body CF8M, Seat PCTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-3-4IN-PN10-16', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, PN10/16, Body CF8M, Seat PCTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-3-4IN-PN40', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, PN40, Body CF8M, Seat PCTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-1IN-ANSI-150', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, ANSI #150, Body CF8M, Seat PCTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-1IN-PN10-16', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, PN10/16, Body CF8M, Seat PCTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-1IN-PN40', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, PN40, Body CF8M, Seat PCTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-1-1-4IN-ANSI-150', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, ANSI #150, Body CF8M, Seat PCTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-1-1-4IN-PN10-16', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, PN10/16, Body CF8M, Seat PCTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-1-1-4IN-PN40', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, PN40, Body CF8M, Seat PCTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-1-1-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, ANSI #150, Body CF8M, Seat PCTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-1-1-2IN-PN10-16', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, PN10/16, Body CF8M, Seat PCTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-1-1-2IN-PN40', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, PN40, Body CF8M, Seat PCTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, ANSI #150, Body CF8M, Seat PCTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-2IN-PN10-16', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, PN10/16, Body CF8M, Seat PCTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-2IN-PN40', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, PN40, Body CF8M, Seat PCTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-2-1-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, ANSI #150, Body CF8M, Seat PCTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-2-1-2IN-PN10-16', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, PN10/16, Body CF8M, Seat PCTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-2-1-2IN-PN40', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, PN40, Body CF8M, Seat PCTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-3IN-ANSI-150', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, ANSI #150, Body CF8M, Seat PCTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-3IN-PN10-16', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, PN10/16, Body CF8M, Seat PCTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-3IN-PN40', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, PN40, Body CF8M, Seat PCTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-4IN-ANSI-150', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, ANSI #150, Body CF8M, Seat PCTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-4IN-PN10-16', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, PN10/16, Body CF8M, Seat PCTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL),
(N'VCG9-4IN-PN40', @CategoryId, N'Active', N'Mars Series CG9-10/30/40 Cryogenic Flanged Ball Valve', N'VCG9 - 2-PC Cryogenic Flanged Ball Valve, Full Port, Direct Mount, PN40, Body CF8M, Seat PCTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/c1.jpg', NULL);

INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VCG9-1-2IN-ANSI-150',N'Size',N'1/2"'),(N'VCG9-1-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'VCG9-1-2IN-PN10-16',N'Size',N'1/2"'),(N'VCG9-1-2IN-PN10-16',N'Flange Rating',N'PN10/16'),
  (N'VCG9-1-2IN-PN40',N'Size',N'1/2"'),(N'VCG9-1-2IN-PN40',N'Flange Rating',N'PN40'),
  (N'VCG9-3-4IN-ANSI-150',N'Size',N'3/4"'),(N'VCG9-3-4IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'VCG9-3-4IN-PN10-16',N'Size',N'3/4"'),(N'VCG9-3-4IN-PN10-16',N'Flange Rating',N'PN10/16'),
  (N'VCG9-3-4IN-PN40',N'Size',N'3/4"'),(N'VCG9-3-4IN-PN40',N'Flange Rating',N'PN40'),
  (N'VCG9-1IN-ANSI-150',N'Size',N'1"'),(N'VCG9-1IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'VCG9-1IN-PN10-16',N'Size',N'1"'),(N'VCG9-1IN-PN10-16',N'Flange Rating',N'PN10/16'),
  (N'VCG9-1IN-PN40',N'Size',N'1"'),(N'VCG9-1IN-PN40',N'Flange Rating',N'PN40'),
  (N'VCG9-1-1-4IN-ANSI-150',N'Size',N'1 1/4"'),(N'VCG9-1-1-4IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'VCG9-1-1-4IN-PN10-16',N'Size',N'1 1/4"'),(N'VCG9-1-1-4IN-PN10-16',N'Flange Rating',N'PN10/16'),
  (N'VCG9-1-1-4IN-PN40',N'Size',N'1 1/4"'),(N'VCG9-1-1-4IN-PN40',N'Flange Rating',N'PN40'),
  (N'VCG9-1-1-2IN-ANSI-150',N'Size',N'1 1/2"'),(N'VCG9-1-1-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'VCG9-1-1-2IN-PN10-16',N'Size',N'1 1/2"'),(N'VCG9-1-1-2IN-PN10-16',N'Flange Rating',N'PN10/16'),
  (N'VCG9-1-1-2IN-PN40',N'Size',N'1 1/2"'),(N'VCG9-1-1-2IN-PN40',N'Flange Rating',N'PN40'),
  (N'VCG9-2IN-ANSI-150',N'Size',N'2"'),(N'VCG9-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'VCG9-2IN-PN10-16',N'Size',N'2"'),(N'VCG9-2IN-PN10-16',N'Flange Rating',N'PN10/16'),
  (N'VCG9-2IN-PN40',N'Size',N'2"'),(N'VCG9-2IN-PN40',N'Flange Rating',N'PN40'),
  (N'VCG9-2-1-2IN-ANSI-150',N'Size',N'2 1/2"'),(N'VCG9-2-1-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'VCG9-2-1-2IN-PN10-16',N'Size',N'2 1/2"'),(N'VCG9-2-1-2IN-PN10-16',N'Flange Rating',N'PN10/16'),
  (N'VCG9-2-1-2IN-PN40',N'Size',N'2 1/2"'),(N'VCG9-2-1-2IN-PN40',N'Flange Rating',N'PN40'),
  (N'VCG9-3IN-ANSI-150',N'Size',N'3"'),(N'VCG9-3IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'VCG9-3IN-PN10-16',N'Size',N'3"'),(N'VCG9-3IN-PN10-16',N'Flange Rating',N'PN10/16'),
  (N'VCG9-3IN-PN40',N'Size',N'3"'),(N'VCG9-3IN-PN40',N'Flange Rating',N'PN40'),
  (N'VCG9-4IN-ANSI-150',N'Size',N'4"'),(N'VCG9-4IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'VCG9-4IN-PN10-16',N'Size',N'4"'),(N'VCG9-4IN-PN10-16',N'Flange Rating',N'PN10/16'),
  (N'VCG9-4IN-PN40',N'Size',N'4"'),(N'VCG9-4IN-PN40',N'Flange Rating',N'PN40')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;

SELECT COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
