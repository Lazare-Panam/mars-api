-- Series 94D (2-piece economical flanged, quote-only Price NULL). Run from file (SSMS: File > Open > Execute).
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 94D')
    INSERT INTO Categories (Name, Description, BodyMaterial, SeatMaterial, Design, Approvals, KeyFeatures)
    VALUES (N'Series 94D',
        N'The Mars Series 94D is a 2-piece, full-port economical flanged ball valve with a Direct Mount design for small bores (1/2" to 4"), rated ANSI Class 150 / PN16. Face-to-face per ANSI B16.10 / EN 558-1 (GR.1/GR.27, DIN 3202 F1/F4/F5). CF8M or WCB body with PTFE/RTFE seats.',
        N'CF8M / WCB', N'PTFE / RTFE', N'Two Piece, Economical, Flanged, Full Port', N'Face-to-face: ANSI B16.10, EN 558-1',
        N'2-piece full port economical flanged design
Direct Mount design
Flange ratings: ANSI #150, PN16
Face-to-face: ANSI B16.10, EN 558-1 (GR.1/GR.27, DIN 3202 F1/F4/F5)
CF8M / WCB body
PTFE / RTFE seats
Size 1/2" to 4"');

DECLARE @SeriesName nvarchar(100) = N'Series 94D';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);

INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'Flange Rating')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);

INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'Flange Rating',0),(N'Size',1)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);

INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'V94D-1-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 94D Two Piece Direct Mount Economical Flanged Ball Valve', N'V94D - 2-PC Economical Flanged Ball Valve, Full Port, Direct Mount, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series94d.jpg', NULL),
(N'V94D-1-2IN-PN16', @CategoryId, N'Active', N'Mars Series 94D Two Piece Direct Mount Economical Flanged Ball Valve', N'V94D - 2-PC Economical Flanged Ball Valve, Full Port, Direct Mount, PN16, Body CF8M / WCB, Seat PTFE / RTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series94d.jpg', NULL),
(N'V94D-3-4IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 94D Two Piece Direct Mount Economical Flanged Ball Valve', N'V94D - 2-PC Economical Flanged Ball Valve, Full Port, Direct Mount, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series94d.jpg', NULL),
(N'V94D-3-4IN-PN16', @CategoryId, N'Active', N'Mars Series 94D Two Piece Direct Mount Economical Flanged Ball Valve', N'V94D - 2-PC Economical Flanged Ball Valve, Full Port, Direct Mount, PN16, Body CF8M / WCB, Seat PTFE / RTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series94d.jpg', NULL),
(N'V94D-1IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 94D Two Piece Direct Mount Economical Flanged Ball Valve', N'V94D - 2-PC Economical Flanged Ball Valve, Full Port, Direct Mount, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series94d.jpg', NULL),
(N'V94D-1IN-PN16', @CategoryId, N'Active', N'Mars Series 94D Two Piece Direct Mount Economical Flanged Ball Valve', N'V94D - 2-PC Economical Flanged Ball Valve, Full Port, Direct Mount, PN16, Body CF8M / WCB, Seat PTFE / RTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series94d.jpg', NULL),
(N'V94D-1-1-4IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 94D Two Piece Direct Mount Economical Flanged Ball Valve', N'V94D - 2-PC Economical Flanged Ball Valve, Full Port, Direct Mount, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series94d.jpg', NULL),
(N'V94D-1-1-4IN-PN16', @CategoryId, N'Active', N'Mars Series 94D Two Piece Direct Mount Economical Flanged Ball Valve', N'V94D - 2-PC Economical Flanged Ball Valve, Full Port, Direct Mount, PN16, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series94d.jpg', NULL),
(N'V94D-1-1-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 94D Two Piece Direct Mount Economical Flanged Ball Valve', N'V94D - 2-PC Economical Flanged Ball Valve, Full Port, Direct Mount, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series94d.jpg', NULL),
(N'V94D-1-1-2IN-PN16', @CategoryId, N'Active', N'Mars Series 94D Two Piece Direct Mount Economical Flanged Ball Valve', N'V94D - 2-PC Economical Flanged Ball Valve, Full Port, Direct Mount, PN16, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series94d.jpg', NULL),
(N'V94D-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 94D Two Piece Direct Mount Economical Flanged Ball Valve', N'V94D - 2-PC Economical Flanged Ball Valve, Full Port, Direct Mount, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series94d.jpg', NULL),
(N'V94D-2IN-PN16', @CategoryId, N'Active', N'Mars Series 94D Two Piece Direct Mount Economical Flanged Ball Valve', N'V94D - 2-PC Economical Flanged Ball Valve, Full Port, Direct Mount, PN16, Body CF8M / WCB, Seat PTFE / RTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series94d.jpg', NULL),
(N'V94D-2-1-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 94D Two Piece Direct Mount Economical Flanged Ball Valve', N'V94D - 2-PC Economical Flanged Ball Valve, Full Port, Direct Mount, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series94d.jpg', NULL),
(N'V94D-2-1-2IN-PN16', @CategoryId, N'Active', N'Mars Series 94D Two Piece Direct Mount Economical Flanged Ball Valve', N'V94D - 2-PC Economical Flanged Ball Valve, Full Port, Direct Mount, PN16, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series94d.jpg', NULL),
(N'V94D-3IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 94D Two Piece Direct Mount Economical Flanged Ball Valve', N'V94D - 2-PC Economical Flanged Ball Valve, Full Port, Direct Mount, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series94d.jpg', NULL),
(N'V94D-3IN-PN16', @CategoryId, N'Active', N'Mars Series 94D Two Piece Direct Mount Economical Flanged Ball Valve', N'V94D - 2-PC Economical Flanged Ball Valve, Full Port, Direct Mount, PN16, Body CF8M / WCB, Seat PTFE / RTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series94d.jpg', NULL),
(N'V94D-4IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 94D Two Piece Direct Mount Economical Flanged Ball Valve', N'V94D - 2-PC Economical Flanged Ball Valve, Full Port, Direct Mount, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series94d.jpg', NULL),
(N'V94D-4IN-PN16', @CategoryId, N'Active', N'Mars Series 94D Two Piece Direct Mount Economical Flanged Ball Valve', N'V94D - 2-PC Economical Flanged Ball Valve, Full Port, Direct Mount, PN16, Body CF8M / WCB, Seat PTFE / RTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series94d.jpg', NULL);

INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'V94D-1-2IN-ANSI-150',N'Size',N'1/2"'),(N'V94D-1-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V94D-1-2IN-PN16',N'Size',N'1/2"'),(N'V94D-1-2IN-PN16',N'Flange Rating',N'PN16'),
  (N'V94D-3-4IN-ANSI-150',N'Size',N'3/4"'),(N'V94D-3-4IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V94D-3-4IN-PN16',N'Size',N'3/4"'),(N'V94D-3-4IN-PN16',N'Flange Rating',N'PN16'),
  (N'V94D-1IN-ANSI-150',N'Size',N'1"'),(N'V94D-1IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V94D-1IN-PN16',N'Size',N'1"'),(N'V94D-1IN-PN16',N'Flange Rating',N'PN16'),
  (N'V94D-1-1-4IN-ANSI-150',N'Size',N'1 1/4"'),(N'V94D-1-1-4IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V94D-1-1-4IN-PN16',N'Size',N'1 1/4"'),(N'V94D-1-1-4IN-PN16',N'Flange Rating',N'PN16'),
  (N'V94D-1-1-2IN-ANSI-150',N'Size',N'1 1/2"'),(N'V94D-1-1-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V94D-1-1-2IN-PN16',N'Size',N'1 1/2"'),(N'V94D-1-1-2IN-PN16',N'Flange Rating',N'PN16'),
  (N'V94D-2IN-ANSI-150',N'Size',N'2"'),(N'V94D-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V94D-2IN-PN16',N'Size',N'2"'),(N'V94D-2IN-PN16',N'Flange Rating',N'PN16'),
  (N'V94D-2-1-2IN-ANSI-150',N'Size',N'2 1/2"'),(N'V94D-2-1-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V94D-2-1-2IN-PN16',N'Size',N'2 1/2"'),(N'V94D-2-1-2IN-PN16',N'Flange Rating',N'PN16'),
  (N'V94D-3IN-ANSI-150',N'Size',N'3"'),(N'V94D-3IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V94D-3IN-PN16',N'Size',N'3"'),(N'V94D-3IN-PN16',N'Flange Rating',N'PN16'),
  (N'V94D-4IN-ANSI-150',N'Size',N'4"'),(N'V94D-4IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V94D-4IN-PN16',N'Size',N'4"'),(N'V94D-4IN-PN16',N'Flange Rating',N'PN16')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;

SELECT COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
