-- Series CG3D-50 (3-piece cryogenic flanged, quote-only Price NULL). Run from file (SSMS). Self-cleaning on re-run.
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series CG3D-50')
    INSERT INTO Categories (Name, Description, BodyMaterial, SeatMaterial, Design, TemperatureRange, KeyFeatures)
    VALUES (N'Series CG3D-50',
        N'The Mars Series CG3D-50 is a 3-piece, full-port cryogenic flanged ball valve with an ISO 5211 direct-mount pad and a blow-out-proof stem, rated -196 to +95 degree C. CF8M body with PCTFE seats and a Viton stem o-ring, in ANSI #300 flanged ends, sizes 1/2" to 4".',
        N'CF8M', N'PCTFE', N'Three Piece, Cryogenic, Flanged, Full Port, Direct Mount', N'-196 to +95 degree C',
        N'3-piece cryogenic full port design
ISO 5211 direct mount
Blow-out proof stem
Ends: ANSI #300 Flanged
CF8M body
PCTFE seats
Viton o-ring on stem
Temperature range -196 to +95 degree C
Size 1/2" to 4"');

DECLARE @SeriesName nvarchar(100) = N'Series CG3D-50';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);

-- Idempotent: clear any prior rows for this series so re-running always yields a clean set.
DELETE FROM ProductFilterValues WHERE CategoryId = @CategoryId;
DELETE FROM CatalogProducts WHERE CategoryId = @CategoryId;
DELETE FROM CategoryFilters WHERE CategoryId = @CategoryId;

INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);

INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'Size',0)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);

INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VCG3D-50-1-2IN', @CategoryId, N'Active', N'Mars Series CG3D-50 Cryogenic 3-Piece Flanged Ball Valve', N'VCG3D-50 - 3-PC Cryogenic Flanged Ball Valve, Full Port, ISO 5211 Direct Mount, ANSI #300 Flanged, Body CF8M, Seat PCTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/cd3d-50.jpg', NULL),
(N'VCG3D-50-3-4IN', @CategoryId, N'Active', N'Mars Series CG3D-50 Cryogenic 3-Piece Flanged Ball Valve', N'VCG3D-50 - 3-PC Cryogenic Flanged Ball Valve, Full Port, ISO 5211 Direct Mount, ANSI #300 Flanged, Body CF8M, Seat PCTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/cd3d-50.jpg', NULL),
(N'VCG3D-50-1IN', @CategoryId, N'Active', N'Mars Series CG3D-50 Cryogenic 3-Piece Flanged Ball Valve', N'VCG3D-50 - 3-PC Cryogenic Flanged Ball Valve, Full Port, ISO 5211 Direct Mount, ANSI #300 Flanged, Body CF8M, Seat PCTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/cd3d-50.jpg', NULL),
(N'VCG3D-50-1-1-4IN', @CategoryId, N'Active', N'Mars Series CG3D-50 Cryogenic 3-Piece Flanged Ball Valve', N'VCG3D-50 - 3-PC Cryogenic Flanged Ball Valve, Full Port, ISO 5211 Direct Mount, ANSI #300 Flanged, Body CF8M, Seat PCTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/cd3d-50.jpg', NULL),
(N'VCG3D-50-1-1-2IN', @CategoryId, N'Active', N'Mars Series CG3D-50 Cryogenic 3-Piece Flanged Ball Valve', N'VCG3D-50 - 3-PC Cryogenic Flanged Ball Valve, Full Port, ISO 5211 Direct Mount, ANSI #300 Flanged, Body CF8M, Seat PCTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/cd3d-50.jpg', NULL),
(N'VCG3D-50-2IN', @CategoryId, N'Active', N'Mars Series CG3D-50 Cryogenic 3-Piece Flanged Ball Valve', N'VCG3D-50 - 3-PC Cryogenic Flanged Ball Valve, Full Port, ISO 5211 Direct Mount, ANSI #300 Flanged, Body CF8M, Seat PCTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/cd3d-50.jpg', NULL),
(N'VCG3D-50-2-1-2IN', @CategoryId, N'Active', N'Mars Series CG3D-50 Cryogenic 3-Piece Flanged Ball Valve', N'VCG3D-50 - 3-PC Cryogenic Flanged Ball Valve, Full Port, ISO 5211 Direct Mount, ANSI #300 Flanged, Body CF8M, Seat PCTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/cd3d-50.jpg', NULL),
(N'VCG3D-50-3IN', @CategoryId, N'Active', N'Mars Series CG3D-50 Cryogenic 3-Piece Flanged Ball Valve', N'VCG3D-50 - 3-PC Cryogenic Flanged Ball Valve, Full Port, ISO 5211 Direct Mount, ANSI #300 Flanged, Body CF8M, Seat PCTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/cd3d-50.jpg', NULL),
(N'VCG3D-50-4IN', @CategoryId, N'Active', N'Mars Series CG3D-50 Cryogenic 3-Piece Flanged Ball Valve', N'VCG3D-50 - 3-PC Cryogenic Flanged Ball Valve, Full Port, ISO 5211 Direct Mount, ANSI #300 Flanged, Body CF8M, Seat PCTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/cyrogenic/cd3d-50.jpg', NULL);

INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VCG3D-50-1-2IN',N'Size',N'1/2"'),
  (N'VCG3D-50-3-4IN',N'Size',N'3/4"'),
  (N'VCG3D-50-1IN',N'Size',N'1"'),
  (N'VCG3D-50-1-1-4IN',N'Size',N'1 1/4"'),
  (N'VCG3D-50-1-1-2IN',N'Size',N'1 1/2"'),
  (N'VCG3D-50-2IN',N'Size',N'2"'),
  (N'VCG3D-50-2-1-2IN',N'Size',N'2 1/2"'),
  (N'VCG3D-50-3IN',N'Size',N'3"'),
  (N'VCG3D-50-4IN',N'Size',N'4"')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;

SELECT COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
