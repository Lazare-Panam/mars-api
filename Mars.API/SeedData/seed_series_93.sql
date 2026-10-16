-- Series 93 (2-piece economical flanged, quote-only Price NULL). Run from file (SSMS: File > Open > Execute).
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 93')
    INSERT INTO Categories (Name, Description, BodyMaterial, SeatMaterial, Design, Approvals, KeyFeatures)
    VALUES (N'Series 93',
        N'The Mars Series 93 is a 2-piece, full-port economical flanged ball valve for large bores (5" to 12"), rated ANSI Class 150/300, PN16/40 and JIS 10K/20K. Face-to-face per ANSI B16.10 / EN 558-1 (GR.1/GR.27, DIN 3202 F1/F4/F5). CF8M, WCB or special alloy body with PTFE/RTFE seats (metal seat optional).',
        N'CF8M / WCB / Special Alloy', N'PTFE / RTFE (Metal seat optional)', N'Two Piece, Economical, Flanged, Full Port', N'Face-to-face: ANSI B16.10, EN 558-1',
        N'2-piece full port economical flanged design
Flange ratings: ANSI #150/#300, PN16/40, JIS 10K/20K
Face-to-face: ANSI B16.10, EN 558-1 (GR.1/GR.27, DIN 3202 F1/F4/F5)
CF8M / WCB / Special Alloy body
PTFE / RTFE seats (metal seat optional)
Size 5" to 12"');

DECLARE @SeriesName nvarchar(100) = N'Series 93';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);

INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'Flange Rating')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);

INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'Flange Rating',0),(N'Size',1)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);

INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'V93-5IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 93 Two Piece Economical Flanged Ball Valve', N'V93 - 2-PC Economical Flanged Ball Valve, Full Port, Standard, ANSI #150, Body CF8M / WCB / Special Alloy, Seat PTFE / RTFE, 5"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/eco.gif', NULL),
(N'V93-5IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 93 Two Piece Economical Flanged Ball Valve', N'V93 - 2-PC Economical Flanged Ball Valve, Full Port, Standard, ANSI #300, Body CF8M / WCB / Special Alloy, Seat PTFE / RTFE, 5"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/eco.gif', NULL),
(N'V93-5IN-PN16-40', @CategoryId, N'Active', N'Mars Series 93 Two Piece Economical Flanged Ball Valve', N'V93 - 2-PC Economical Flanged Ball Valve, Full Port, Standard, PN16/40, Body CF8M / WCB / Special Alloy, Seat PTFE / RTFE, 5"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/eco.gif', NULL),
(N'V93-5IN-JIS-10K', @CategoryId, N'Active', N'Mars Series 93 Two Piece Economical Flanged Ball Valve', N'V93 - 2-PC Economical Flanged Ball Valve, Full Port, Standard, JIS 10K, Body CF8M / WCB / Special Alloy, Seat PTFE / RTFE, 5"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/eco.gif', NULL),
(N'V93-5IN-JIS-20K', @CategoryId, N'Active', N'Mars Series 93 Two Piece Economical Flanged Ball Valve', N'V93 - 2-PC Economical Flanged Ball Valve, Full Port, Standard, JIS 20K, Body CF8M / WCB / Special Alloy, Seat PTFE / RTFE, 5"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/eco.gif', NULL),
(N'V93-6IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 93 Two Piece Economical Flanged Ball Valve', N'V93 - 2-PC Economical Flanged Ball Valve, Full Port, Standard, ANSI #150, Body CF8M / WCB / Special Alloy, Seat PTFE / RTFE, 6"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/eco.gif', NULL),
(N'V93-6IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 93 Two Piece Economical Flanged Ball Valve', N'V93 - 2-PC Economical Flanged Ball Valve, Full Port, Standard, ANSI #300, Body CF8M / WCB / Special Alloy, Seat PTFE / RTFE, 6"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/eco.gif', NULL),
(N'V93-6IN-PN16-40', @CategoryId, N'Active', N'Mars Series 93 Two Piece Economical Flanged Ball Valve', N'V93 - 2-PC Economical Flanged Ball Valve, Full Port, Standard, PN16/40, Body CF8M / WCB / Special Alloy, Seat PTFE / RTFE, 6"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/eco.gif', NULL),
(N'V93-6IN-JIS-10K', @CategoryId, N'Active', N'Mars Series 93 Two Piece Economical Flanged Ball Valve', N'V93 - 2-PC Economical Flanged Ball Valve, Full Port, Standard, JIS 10K, Body CF8M / WCB / Special Alloy, Seat PTFE / RTFE, 6"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/eco.gif', NULL),
(N'V93-6IN-JIS-20K', @CategoryId, N'Active', N'Mars Series 93 Two Piece Economical Flanged Ball Valve', N'V93 - 2-PC Economical Flanged Ball Valve, Full Port, Standard, JIS 20K, Body CF8M / WCB / Special Alloy, Seat PTFE / RTFE, 6"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/eco.gif', NULL),
(N'V93-8IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 93 Two Piece Economical Flanged Ball Valve', N'V93 - 2-PC Economical Flanged Ball Valve, Full Port, Standard, ANSI #150, Body CF8M / WCB / Special Alloy, Seat PTFE / RTFE, 8"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/eco.gif', NULL),
(N'V93-8IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 93 Two Piece Economical Flanged Ball Valve', N'V93 - 2-PC Economical Flanged Ball Valve, Full Port, Standard, ANSI #300, Body CF8M / WCB / Special Alloy, Seat PTFE / RTFE, 8"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/eco.gif', NULL),
(N'V93-8IN-PN16-40', @CategoryId, N'Active', N'Mars Series 93 Two Piece Economical Flanged Ball Valve', N'V93 - 2-PC Economical Flanged Ball Valve, Full Port, Standard, PN16/40, Body CF8M / WCB / Special Alloy, Seat PTFE / RTFE, 8"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/eco.gif', NULL),
(N'V93-8IN-JIS-10K', @CategoryId, N'Active', N'Mars Series 93 Two Piece Economical Flanged Ball Valve', N'V93 - 2-PC Economical Flanged Ball Valve, Full Port, Standard, JIS 10K, Body CF8M / WCB / Special Alloy, Seat PTFE / RTFE, 8"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/eco.gif', NULL),
(N'V93-8IN-JIS-20K', @CategoryId, N'Active', N'Mars Series 93 Two Piece Economical Flanged Ball Valve', N'V93 - 2-PC Economical Flanged Ball Valve, Full Port, Standard, JIS 20K, Body CF8M / WCB / Special Alloy, Seat PTFE / RTFE, 8"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/eco.gif', NULL),
(N'V93-10IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 93 Two Piece Economical Flanged Ball Valve', N'V93 - 2-PC Economical Flanged Ball Valve, Full Port, Standard, ANSI #150, Body CF8M / WCB / Special Alloy, Seat PTFE / RTFE, 10"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/eco.gif', NULL),
(N'V93-10IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 93 Two Piece Economical Flanged Ball Valve', N'V93 - 2-PC Economical Flanged Ball Valve, Full Port, Standard, ANSI #300, Body CF8M / WCB / Special Alloy, Seat PTFE / RTFE, 10"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/eco.gif', NULL),
(N'V93-10IN-PN16-40', @CategoryId, N'Active', N'Mars Series 93 Two Piece Economical Flanged Ball Valve', N'V93 - 2-PC Economical Flanged Ball Valve, Full Port, Standard, PN16/40, Body CF8M / WCB / Special Alloy, Seat PTFE / RTFE, 10"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/eco.gif', NULL),
(N'V93-10IN-JIS-10K', @CategoryId, N'Active', N'Mars Series 93 Two Piece Economical Flanged Ball Valve', N'V93 - 2-PC Economical Flanged Ball Valve, Full Port, Standard, JIS 10K, Body CF8M / WCB / Special Alloy, Seat PTFE / RTFE, 10"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/eco.gif', NULL),
(N'V93-10IN-JIS-20K', @CategoryId, N'Active', N'Mars Series 93 Two Piece Economical Flanged Ball Valve', N'V93 - 2-PC Economical Flanged Ball Valve, Full Port, Standard, JIS 20K, Body CF8M / WCB / Special Alloy, Seat PTFE / RTFE, 10"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/eco.gif', NULL),
(N'V93-12IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 93 Two Piece Economical Flanged Ball Valve', N'V93 - 2-PC Economical Flanged Ball Valve, Full Port, Standard, ANSI #150, Body CF8M / WCB / Special Alloy, Seat PTFE / RTFE, 12"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/eco.gif', NULL),
(N'V93-12IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 93 Two Piece Economical Flanged Ball Valve', N'V93 - 2-PC Economical Flanged Ball Valve, Full Port, Standard, ANSI #300, Body CF8M / WCB / Special Alloy, Seat PTFE / RTFE, 12"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/eco.gif', NULL),
(N'V93-12IN-PN16-40', @CategoryId, N'Active', N'Mars Series 93 Two Piece Economical Flanged Ball Valve', N'V93 - 2-PC Economical Flanged Ball Valve, Full Port, Standard, PN16/40, Body CF8M / WCB / Special Alloy, Seat PTFE / RTFE, 12"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/eco.gif', NULL),
(N'V93-12IN-JIS-10K', @CategoryId, N'Active', N'Mars Series 93 Two Piece Economical Flanged Ball Valve', N'V93 - 2-PC Economical Flanged Ball Valve, Full Port, Standard, JIS 10K, Body CF8M / WCB / Special Alloy, Seat PTFE / RTFE, 12"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/eco.gif', NULL),
(N'V93-12IN-JIS-20K', @CategoryId, N'Active', N'Mars Series 93 Two Piece Economical Flanged Ball Valve', N'V93 - 2-PC Economical Flanged Ball Valve, Full Port, Standard, JIS 20K, Body CF8M / WCB / Special Alloy, Seat PTFE / RTFE, 12"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/eco.gif', NULL);

INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'V93-5IN-ANSI-150',N'Size',N'5"'),(N'V93-5IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V93-5IN-ANSI-300',N'Size',N'5"'),(N'V93-5IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V93-5IN-PN16-40',N'Size',N'5"'),(N'V93-5IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V93-5IN-JIS-10K',N'Size',N'5"'),(N'V93-5IN-JIS-10K',N'Flange Rating',N'JIS 10K'),
  (N'V93-5IN-JIS-20K',N'Size',N'5"'),(N'V93-5IN-JIS-20K',N'Flange Rating',N'JIS 20K'),
  (N'V93-6IN-ANSI-150',N'Size',N'6"'),(N'V93-6IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V93-6IN-ANSI-300',N'Size',N'6"'),(N'V93-6IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V93-6IN-PN16-40',N'Size',N'6"'),(N'V93-6IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V93-6IN-JIS-10K',N'Size',N'6"'),(N'V93-6IN-JIS-10K',N'Flange Rating',N'JIS 10K'),
  (N'V93-6IN-JIS-20K',N'Size',N'6"'),(N'V93-6IN-JIS-20K',N'Flange Rating',N'JIS 20K'),
  (N'V93-8IN-ANSI-150',N'Size',N'8"'),(N'V93-8IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V93-8IN-ANSI-300',N'Size',N'8"'),(N'V93-8IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V93-8IN-PN16-40',N'Size',N'8"'),(N'V93-8IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V93-8IN-JIS-10K',N'Size',N'8"'),(N'V93-8IN-JIS-10K',N'Flange Rating',N'JIS 10K'),
  (N'V93-8IN-JIS-20K',N'Size',N'8"'),(N'V93-8IN-JIS-20K',N'Flange Rating',N'JIS 20K'),
  (N'V93-10IN-ANSI-150',N'Size',N'10"'),(N'V93-10IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V93-10IN-ANSI-300',N'Size',N'10"'),(N'V93-10IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V93-10IN-PN16-40',N'Size',N'10"'),(N'V93-10IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V93-10IN-JIS-10K',N'Size',N'10"'),(N'V93-10IN-JIS-10K',N'Flange Rating',N'JIS 10K'),
  (N'V93-10IN-JIS-20K',N'Size',N'10"'),(N'V93-10IN-JIS-20K',N'Flange Rating',N'JIS 20K'),
  (N'V93-12IN-ANSI-150',N'Size',N'12"'),(N'V93-12IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V93-12IN-ANSI-300',N'Size',N'12"'),(N'V93-12IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V93-12IN-PN16-40',N'Size',N'12"'),(N'V93-12IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V93-12IN-JIS-10K',N'Size',N'12"'),(N'V93-12IN-JIS-10K',N'Flange Rating',N'JIS 10K'),
  (N'V93-12IN-JIS-20K',N'Size',N'12"'),(N'V93-12IN-JIS-20K',N'Flange Rating',N'JIS 20K')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;

SELECT COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
