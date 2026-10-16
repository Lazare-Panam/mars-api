-- Series 91D (uni-body fire-safe flanged, reduced port, quote-only Price NULL). Run from file (SSMS: File > Open > Execute).
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 91D')
    INSERT INTO Categories (Name, Description, BodyMaterial, SeatMaterial, Design, Approvals, KeyFeatures)
    VALUES (N'Series 91D',
        N'The Mars Series 91D is a uni-body, reduced-port fire-safe flanged ball valve rated ANSI Class 150 and Class 300, certified to API 607 (7th Edition). Face-to-face per ANSI B16.10, in sizes 1/2" to 6". CF8M, WCB or special alloy body with PTFE/RTFE seats. Available with 30/60/90 degree V-port ball for flow control. Optional NACE MR0175 on request.',
        N'CF8M / WCB / Special Alloy', N'PTFE / RTFE', N'Uni-Body, Fire-Safe, Flanged, Reduced Port', N'Fire-Safe API 607, 7th Edition',
        N'Uni-body reduced port fire-safe flanged design
Flange ratings: ANSI #150, ANSI #300
Face-to-face: ANSI B16.10
Rated to API 607, 7th Edition
CF8M / WCB / Special Alloy body
PTFE / RTFE seats
Size 1/2" to 6"
Optional 30/60/90 degree V-port ball
Optional NACE MR0175');

DECLARE @SeriesName nvarchar(100) = N'Series 91D';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);

INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'Flange Rating')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);

INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'Flange Rating',0),(N'Size',1)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);

INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'V91D-1-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 91D Uni-Body Fire-Safe Flanged Ball Valve', N'V91D - Uni-Body Fire-Safe Flanged Ball Valve, Reduced Port, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-91d.png', NULL),
(N'V91D-1-2IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 91D Uni-Body Fire-Safe Flanged Ball Valve', N'V91D - Uni-Body Fire-Safe Flanged Ball Valve, Reduced Port, ANSI #300, Body CF8M / WCB, Seat PTFE / RTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-91d.png', NULL),
(N'V91D-3-4IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 91D Uni-Body Fire-Safe Flanged Ball Valve', N'V91D - Uni-Body Fire-Safe Flanged Ball Valve, Reduced Port, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-91d.png', NULL),
(N'V91D-3-4IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 91D Uni-Body Fire-Safe Flanged Ball Valve', N'V91D - Uni-Body Fire-Safe Flanged Ball Valve, Reduced Port, ANSI #300, Body CF8M / WCB, Seat PTFE / RTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-91d.png', NULL),
(N'V91D-1IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 91D Uni-Body Fire-Safe Flanged Ball Valve', N'V91D - Uni-Body Fire-Safe Flanged Ball Valve, Reduced Port, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-91d.png', NULL),
(N'V91D-1IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 91D Uni-Body Fire-Safe Flanged Ball Valve', N'V91D - Uni-Body Fire-Safe Flanged Ball Valve, Reduced Port, ANSI #300, Body CF8M / WCB, Seat PTFE / RTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-91d.png', NULL),
(N'V91D-1-1-4IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 91D Uni-Body Fire-Safe Flanged Ball Valve', N'V91D - Uni-Body Fire-Safe Flanged Ball Valve, Reduced Port, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-91d.png', NULL),
(N'V91D-1-1-4IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 91D Uni-Body Fire-Safe Flanged Ball Valve', N'V91D - Uni-Body Fire-Safe Flanged Ball Valve, Reduced Port, ANSI #300, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-91d.png', NULL),
(N'V91D-1-1-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 91D Uni-Body Fire-Safe Flanged Ball Valve', N'V91D - Uni-Body Fire-Safe Flanged Ball Valve, Reduced Port, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-91d.png', NULL),
(N'V91D-1-1-2IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 91D Uni-Body Fire-Safe Flanged Ball Valve', N'V91D - Uni-Body Fire-Safe Flanged Ball Valve, Reduced Port, ANSI #300, Body CF8M / WCB, Seat PTFE / RTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-91d.png', NULL),
(N'V91D-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 91D Uni-Body Fire-Safe Flanged Ball Valve', N'V91D - Uni-Body Fire-Safe Flanged Ball Valve, Reduced Port, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-91d.png', NULL),
(N'V91D-2IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 91D Uni-Body Fire-Safe Flanged Ball Valve', N'V91D - Uni-Body Fire-Safe Flanged Ball Valve, Reduced Port, ANSI #300, Body CF8M / WCB, Seat PTFE / RTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-91d.png', NULL),
(N'V91D-2-1-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 91D Uni-Body Fire-Safe Flanged Ball Valve', N'V91D - Uni-Body Fire-Safe Flanged Ball Valve, Reduced Port, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-91d.png', NULL),
(N'V91D-2-1-2IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 91D Uni-Body Fire-Safe Flanged Ball Valve', N'V91D - Uni-Body Fire-Safe Flanged Ball Valve, Reduced Port, ANSI #300, Body CF8M / WCB, Seat PTFE / RTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-91d.png', NULL),
(N'V91D-3IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 91D Uni-Body Fire-Safe Flanged Ball Valve', N'V91D - Uni-Body Fire-Safe Flanged Ball Valve, Reduced Port, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-91d.png', NULL),
(N'V91D-3IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 91D Uni-Body Fire-Safe Flanged Ball Valve', N'V91D - Uni-Body Fire-Safe Flanged Ball Valve, Reduced Port, ANSI #300, Body CF8M / WCB, Seat PTFE / RTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-91d.png', NULL),
(N'V91D-4IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 91D Uni-Body Fire-Safe Flanged Ball Valve', N'V91D - Uni-Body Fire-Safe Flanged Ball Valve, Reduced Port, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-91d.png', NULL),
(N'V91D-4IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 91D Uni-Body Fire-Safe Flanged Ball Valve', N'V91D - Uni-Body Fire-Safe Flanged Ball Valve, Reduced Port, ANSI #300, Body CF8M / WCB, Seat PTFE / RTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-91d.png', NULL),
(N'V91D-6IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 91D Uni-Body Fire-Safe Flanged Ball Valve', N'V91D - Uni-Body Fire-Safe Flanged Ball Valve, Reduced Port, ANSI #150, Body CF8M / WCB, Seat PTFE / RTFE, 6"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-91d.png', NULL),
(N'V91D-6IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 91D Uni-Body Fire-Safe Flanged Ball Valve', N'V91D - Uni-Body Fire-Safe Flanged Ball Valve, Reduced Port, ANSI #300, Body CF8M / WCB, Seat PTFE / RTFE, 6"', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/fire-safe-ball-valves/series-91d.png', NULL);

INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'V91D-1-2IN-ANSI-150',N'Size',N'1/2"'),(N'V91D-1-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V91D-1-2IN-ANSI-300',N'Size',N'1/2"'),(N'V91D-1-2IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V91D-3-4IN-ANSI-150',N'Size',N'3/4"'),(N'V91D-3-4IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V91D-3-4IN-ANSI-300',N'Size',N'3/4"'),(N'V91D-3-4IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V91D-1IN-ANSI-150',N'Size',N'1"'),(N'V91D-1IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V91D-1IN-ANSI-300',N'Size',N'1"'),(N'V91D-1IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V91D-1-1-4IN-ANSI-150',N'Size',N'1 1/4"'),(N'V91D-1-1-4IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V91D-1-1-4IN-ANSI-300',N'Size',N'1 1/4"'),(N'V91D-1-1-4IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V91D-1-1-2IN-ANSI-150',N'Size',N'1 1/2"'),(N'V91D-1-1-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V91D-1-1-2IN-ANSI-300',N'Size',N'1 1/2"'),(N'V91D-1-1-2IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V91D-2IN-ANSI-150',N'Size',N'2"'),(N'V91D-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V91D-2IN-ANSI-300',N'Size',N'2"'),(N'V91D-2IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V91D-2-1-2IN-ANSI-150',N'Size',N'2 1/2"'),(N'V91D-2-1-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V91D-2-1-2IN-ANSI-300',N'Size',N'2 1/2"'),(N'V91D-2-1-2IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V91D-3IN-ANSI-150',N'Size',N'3"'),(N'V91D-3IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V91D-3IN-ANSI-300',N'Size',N'3"'),(N'V91D-3IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V91D-4IN-ANSI-150',N'Size',N'4"'),(N'V91D-4IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V91D-4IN-ANSI-300',N'Size',N'4"'),(N'V91D-4IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V91D-6IN-ANSI-150',N'Size',N'6"'),(N'V91D-6IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V91D-6IN-ANSI-300',N'Size',N'6"'),(N'V91D-6IN-ANSI-300',N'Flange Rating',N'ANSI #300')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;

SELECT COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
