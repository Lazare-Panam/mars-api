-- Series F98A (wafer-type flanged, quote-only Price NULL). Run from file (SSMS: File > Open > Execute).
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series F98A')
    INSERT INTO Categories (Name, Description, BodyMaterial, SeatMaterial, Design, Approvals, KeyFeatures)
    VALUES (N'Series F98A',
        N'The Mars Series F98A is a wafer-type full-port ball valve certified to ISO 15848-1 (fugitive emissions), rated PN10/40, in sizes 1/2" to 4". Body 1.4408 / 1.0619 with PTFE/RTFE seats (other options on request).',
        N'1.4408 / 1.0619', N'PTFE / RTFE', N'Wafer Type, Full Port, ISO 15848-1 Certified', N'ISO 15848-1',
        N'Wafer type full port design
ISO 15848-1 certified (fugitive emissions)
Flange rating: PN10/40
Body 1.4408 / 1.0619
PTFE / RTFE seats
Size 1/2" to 4"');

DECLARE @SeriesName nvarchar(100) = N'Series F98A';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);

INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'Flange Rating')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);

INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'Flange Rating',0),(N'Size',1)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);

INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VF98A-1-2IN-PN10-40', @CategoryId, N'Active', N'Mars Series F98A Wafer Type Ball Valve', N'VF98A - Wafer Type Ball Valve, Full Port, ISO 15848-1, PN10/40, Body 1.4408 / 1.0619, Seat PTFE / RTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-98fa.jpg', NULL),
(N'VF98A-3-4IN-PN10-40', @CategoryId, N'Active', N'Mars Series F98A Wafer Type Ball Valve', N'VF98A - Wafer Type Ball Valve, Full Port, ISO 15848-1, PN10/40, Body 1.4408 / 1.0619, Seat PTFE / RTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-98fa.jpg', NULL),
(N'VF98A-1IN-PN10-40', @CategoryId, N'Active', N'Mars Series F98A Wafer Type Ball Valve', N'VF98A - Wafer Type Ball Valve, Full Port, ISO 15848-1, PN10/40, Body 1.4408 / 1.0619, Seat PTFE / RTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-98fa.jpg', NULL),
(N'VF98A-1-1-4IN-PN10-40', @CategoryId, N'Active', N'Mars Series F98A Wafer Type Ball Valve', N'VF98A - Wafer Type Ball Valve, Full Port, ISO 15848-1, PN10/40, Body 1.4408 / 1.0619, Seat PTFE / RTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-98fa.jpg', NULL),
(N'VF98A-1-1-2IN-PN10-40', @CategoryId, N'Active', N'Mars Series F98A Wafer Type Ball Valve', N'VF98A - Wafer Type Ball Valve, Full Port, ISO 15848-1, PN10/40, Body 1.4408 / 1.0619, Seat PTFE / RTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-98fa.jpg', NULL),
(N'VF98A-2IN-PN10-40', @CategoryId, N'Active', N'Mars Series F98A Wafer Type Ball Valve', N'VF98A - Wafer Type Ball Valve, Full Port, ISO 15848-1, PN10/40, Body 1.4408 / 1.0619, Seat PTFE / RTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-98fa.jpg', NULL),
(N'VF98A-2-1-2IN-PN10-40', @CategoryId, N'Active', N'Mars Series F98A Wafer Type Ball Valve', N'VF98A - Wafer Type Ball Valve, Full Port, ISO 15848-1, PN10/40, Body 1.4408 / 1.0619, Seat PTFE / RTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-98fa.jpg', NULL),
(N'VF98A-3IN-PN10-40', @CategoryId, N'Active', N'Mars Series F98A Wafer Type Ball Valve', N'VF98A - Wafer Type Ball Valve, Full Port, ISO 15848-1, PN10/40, Body 1.4408 / 1.0619, Seat PTFE / RTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-98fa.jpg', NULL),
(N'VF98A-4IN-PN10-40', @CategoryId, N'Active', N'Mars Series F98A Wafer Type Ball Valve', N'VF98A - Wafer Type Ball Valve, Full Port, ISO 15848-1, PN10/40, Body 1.4408 / 1.0619, Seat PTFE / RTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-98fa.jpg', NULL);

INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VF98A-1-2IN-PN10-40',N'Size',N'1/2"'),(N'VF98A-1-2IN-PN10-40',N'Flange Rating',N'PN10/40'),
  (N'VF98A-3-4IN-PN10-40',N'Size',N'3/4"'),(N'VF98A-3-4IN-PN10-40',N'Flange Rating',N'PN10/40'),
  (N'VF98A-1IN-PN10-40',N'Size',N'1"'),(N'VF98A-1IN-PN10-40',N'Flange Rating',N'PN10/40'),
  (N'VF98A-1-1-4IN-PN10-40',N'Size',N'1 1/4"'),(N'VF98A-1-1-4IN-PN10-40',N'Flange Rating',N'PN10/40'),
  (N'VF98A-1-1-2IN-PN10-40',N'Size',N'1 1/2"'),(N'VF98A-1-1-2IN-PN10-40',N'Flange Rating',N'PN10/40'),
  (N'VF98A-2IN-PN10-40',N'Size',N'2"'),(N'VF98A-2IN-PN10-40',N'Flange Rating',N'PN10/40'),
  (N'VF98A-2-1-2IN-PN10-40',N'Size',N'2 1/2"'),(N'VF98A-2-1-2IN-PN10-40',N'Flange Rating',N'PN10/40'),
  (N'VF98A-3IN-PN10-40',N'Size',N'3"'),(N'VF98A-3IN-PN10-40',N'Flange Rating',N'PN10/40'),
  (N'VF98A-4IN-PN10-40',N'Size',N'4"'),(N'VF98A-4IN-PN10-40',N'Flange Rating',N'PN10/40')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;

SELECT COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
