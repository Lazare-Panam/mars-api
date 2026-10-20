-- Series F98 (wafer-type flanged, quote-only Price NULL). Run from file (SSMS: File > Open > Execute).
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series F98')
    INSERT INTO Categories (Name, Description, BodyMaterial, SeatMaterial, Design, Approvals, KeyFeatures)
    VALUES (N'Series F98',
        N'The Mars Series F98 is a wafer-type, direct-mount, fire-safe full-port ball valve rated PN16 and conforming to ASME B16.34, in sizes 1/2" to 4". Body 1.4408 / 1.0619 with PTFE/RTFE seats (other options on request).',
        N'1.4408 / 1.0619', N'PTFE / RTFE', N'Wafer Type, Direct Mount, Fire-Safe, Full Port', N'Fire-Safe; ASME B16.34',
        N'Wafer type full port design
Direct Mount design
Fire-safe
Flange rating: PN16
Body 1.4408 / 1.0619
PTFE / RTFE seats
Conforms to ASME B16.34
Size 1/2" to 4"');

DECLARE @SeriesName nvarchar(100) = N'Series F98';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);

INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'Flange Rating')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);

INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'Flange Rating',0),(N'Size',1)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);

INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VF98-1-2IN-PN16', @CategoryId, N'Active', N'Mars Series F98 Wafer Type Fire-Safe Ball Valve', N'VF98 - Wafer Type Direct Mount Fire-Safe Ball Valve, Full Port, Fire-Safe, PN16, Body 1.4408 / 1.0619, Seat PTFE / RTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-98.jpg', NULL),
(N'VF98-3-4IN-PN16', @CategoryId, N'Active', N'Mars Series F98 Wafer Type Fire-Safe Ball Valve', N'VF98 - Wafer Type Direct Mount Fire-Safe Ball Valve, Full Port, Fire-Safe, PN16, Body 1.4408 / 1.0619, Seat PTFE / RTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-98.jpg', NULL),
(N'VF98-1IN-PN16', @CategoryId, N'Active', N'Mars Series F98 Wafer Type Fire-Safe Ball Valve', N'VF98 - Wafer Type Direct Mount Fire-Safe Ball Valve, Full Port, Fire-Safe, PN16, Body 1.4408 / 1.0619, Seat PTFE / RTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-98.jpg', NULL),
(N'VF98-1-1-4IN-PN16', @CategoryId, N'Active', N'Mars Series F98 Wafer Type Fire-Safe Ball Valve', N'VF98 - Wafer Type Direct Mount Fire-Safe Ball Valve, Full Port, Fire-Safe, PN16, Body 1.4408 / 1.0619, Seat PTFE / RTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-98.jpg', NULL),
(N'VF98-1-1-2IN-PN16', @CategoryId, N'Active', N'Mars Series F98 Wafer Type Fire-Safe Ball Valve', N'VF98 - Wafer Type Direct Mount Fire-Safe Ball Valve, Full Port, Fire-Safe, PN16, Body 1.4408 / 1.0619, Seat PTFE / RTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-98.jpg', NULL),
(N'VF98-2IN-PN16', @CategoryId, N'Active', N'Mars Series F98 Wafer Type Fire-Safe Ball Valve', N'VF98 - Wafer Type Direct Mount Fire-Safe Ball Valve, Full Port, Fire-Safe, PN16, Body 1.4408 / 1.0619, Seat PTFE / RTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-98.jpg', NULL),
(N'VF98-2-1-2IN-PN16', @CategoryId, N'Active', N'Mars Series F98 Wafer Type Fire-Safe Ball Valve', N'VF98 - Wafer Type Direct Mount Fire-Safe Ball Valve, Full Port, Fire-Safe, PN16, Body 1.4408 / 1.0619, Seat PTFE / RTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-98.jpg', NULL),
(N'VF98-3IN-PN16', @CategoryId, N'Active', N'Mars Series F98 Wafer Type Fire-Safe Ball Valve', N'VF98 - Wafer Type Direct Mount Fire-Safe Ball Valve, Full Port, Fire-Safe, PN16, Body 1.4408 / 1.0619, Seat PTFE / RTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-98.jpg', NULL),
(N'VF98-4IN-PN16', @CategoryId, N'Active', N'Mars Series F98 Wafer Type Fire-Safe Ball Valve', N'VF98 - Wafer Type Direct Mount Fire-Safe Ball Valve, Full Port, Fire-Safe, PN16, Body 1.4408 / 1.0619, Seat PTFE / RTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-98.jpg', NULL);

INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VF98-1-2IN-PN16',N'Size',N'1/2"'),(N'VF98-1-2IN-PN16',N'Flange Rating',N'PN16'),
  (N'VF98-3-4IN-PN16',N'Size',N'3/4"'),(N'VF98-3-4IN-PN16',N'Flange Rating',N'PN16'),
  (N'VF98-1IN-PN16',N'Size',N'1"'),(N'VF98-1IN-PN16',N'Flange Rating',N'PN16'),
  (N'VF98-1-1-4IN-PN16',N'Size',N'1 1/4"'),(N'VF98-1-1-4IN-PN16',N'Flange Rating',N'PN16'),
  (N'VF98-1-1-2IN-PN16',N'Size',N'1 1/2"'),(N'VF98-1-1-2IN-PN16',N'Flange Rating',N'PN16'),
  (N'VF98-2IN-PN16',N'Size',N'2"'),(N'VF98-2IN-PN16',N'Flange Rating',N'PN16'),
  (N'VF98-2-1-2IN-PN16',N'Size',N'2 1/2"'),(N'VF98-2-1-2IN-PN16',N'Flange Rating',N'PN16'),
  (N'VF98-3IN-PN16',N'Size',N'3"'),(N'VF98-3IN-PN16',N'Flange Rating',N'PN16'),
  (N'VF98-4IN-PN16',N'Size',N'4"'),(N'VF98-4IN-PN16',N'Flange Rating',N'PN16')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;

SELECT COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
