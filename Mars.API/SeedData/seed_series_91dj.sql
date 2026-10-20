-- Series 91DJ (steam jacketed flanged, quote-only Price NULL). Run from file (SSMS: File > Open > Execute).
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 91DJ')
    INSERT INTO Categories (Name, Description, BodyMaterial, SeatMaterial, Design, Approvals, KeyFeatures)
    VALUES (N'Series 91DJ',
        N'The Mars Series 91DJ is a uni-body, reduced-port steam-jacketed flanged ball valve rated ANSI Class 150 and Class 300, in sizes 1/2" to 6". Face-to-face per ANSI B16.10. CF8M body with 25% carbon+PTFE seats.',
        N'CF8M', N'25% Carbon + PTFE', N'Uni-Body, Steam Jacketed, Flanged, Reduced Port', N'Face-to-face: ANSI B16.10',
        N'Uni-body reduced port steam jacketed flanged design
Flange ratings: ANSI #150, ANSI #300
Face-to-face: ANSI B16.10
CF8M body
25% carbon + PTFE seats
Size 1/2" to 6"');

DECLARE @SeriesName nvarchar(100) = N'Series 91DJ';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);

INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'Flange Rating')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);

INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'Flange Rating',0),(N'Size',1)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);

INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'V91DJ-1-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 91DJ Uni-Body Steam Jacketed Flanged Ball Valve', N'V91DJ - Uni-Body Steam Jacketed Flanged Ball Valve, Reduced Port, Reduced Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-91dj.jpg', NULL),
(N'V91DJ-1-2IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 91DJ Uni-Body Steam Jacketed Flanged Ball Valve', N'V91DJ - Uni-Body Steam Jacketed Flanged Ball Valve, Reduced Port, Reduced Port, ANSI #300, Body CF8M, Seat 25% Carbon + PTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-91dj.jpg', NULL),
(N'V91DJ-3-4IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 91DJ Uni-Body Steam Jacketed Flanged Ball Valve', N'V91DJ - Uni-Body Steam Jacketed Flanged Ball Valve, Reduced Port, Reduced Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-91dj.jpg', NULL),
(N'V91DJ-3-4IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 91DJ Uni-Body Steam Jacketed Flanged Ball Valve', N'V91DJ - Uni-Body Steam Jacketed Flanged Ball Valve, Reduced Port, Reduced Port, ANSI #300, Body CF8M, Seat 25% Carbon + PTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-91dj.jpg', NULL),
(N'V91DJ-1IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 91DJ Uni-Body Steam Jacketed Flanged Ball Valve', N'V91DJ - Uni-Body Steam Jacketed Flanged Ball Valve, Reduced Port, Reduced Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-91dj.jpg', NULL),
(N'V91DJ-1IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 91DJ Uni-Body Steam Jacketed Flanged Ball Valve', N'V91DJ - Uni-Body Steam Jacketed Flanged Ball Valve, Reduced Port, Reduced Port, ANSI #300, Body CF8M, Seat 25% Carbon + PTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-91dj.jpg', NULL),
(N'V91DJ-1-1-4IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 91DJ Uni-Body Steam Jacketed Flanged Ball Valve', N'V91DJ - Uni-Body Steam Jacketed Flanged Ball Valve, Reduced Port, Reduced Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-91dj.jpg', NULL),
(N'V91DJ-1-1-4IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 91DJ Uni-Body Steam Jacketed Flanged Ball Valve', N'V91DJ - Uni-Body Steam Jacketed Flanged Ball Valve, Reduced Port, Reduced Port, ANSI #300, Body CF8M, Seat 25% Carbon + PTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-91dj.jpg', NULL),
(N'V91DJ-1-1-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 91DJ Uni-Body Steam Jacketed Flanged Ball Valve', N'V91DJ - Uni-Body Steam Jacketed Flanged Ball Valve, Reduced Port, Reduced Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-91dj.jpg', NULL),
(N'V91DJ-1-1-2IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 91DJ Uni-Body Steam Jacketed Flanged Ball Valve', N'V91DJ - Uni-Body Steam Jacketed Flanged Ball Valve, Reduced Port, Reduced Port, ANSI #300, Body CF8M, Seat 25% Carbon + PTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-91dj.jpg', NULL),
(N'V91DJ-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 91DJ Uni-Body Steam Jacketed Flanged Ball Valve', N'V91DJ - Uni-Body Steam Jacketed Flanged Ball Valve, Reduced Port, Reduced Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-91dj.jpg', NULL),
(N'V91DJ-2IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 91DJ Uni-Body Steam Jacketed Flanged Ball Valve', N'V91DJ - Uni-Body Steam Jacketed Flanged Ball Valve, Reduced Port, Reduced Port, ANSI #300, Body CF8M, Seat 25% Carbon + PTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-91dj.jpg', NULL),
(N'V91DJ-2-1-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 91DJ Uni-Body Steam Jacketed Flanged Ball Valve', N'V91DJ - Uni-Body Steam Jacketed Flanged Ball Valve, Reduced Port, Reduced Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-91dj.jpg', NULL),
(N'V91DJ-2-1-2IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 91DJ Uni-Body Steam Jacketed Flanged Ball Valve', N'V91DJ - Uni-Body Steam Jacketed Flanged Ball Valve, Reduced Port, Reduced Port, ANSI #300, Body CF8M, Seat 25% Carbon + PTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-91dj.jpg', NULL),
(N'V91DJ-3IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 91DJ Uni-Body Steam Jacketed Flanged Ball Valve', N'V91DJ - Uni-Body Steam Jacketed Flanged Ball Valve, Reduced Port, Reduced Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-91dj.jpg', NULL),
(N'V91DJ-3IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 91DJ Uni-Body Steam Jacketed Flanged Ball Valve', N'V91DJ - Uni-Body Steam Jacketed Flanged Ball Valve, Reduced Port, Reduced Port, ANSI #300, Body CF8M, Seat 25% Carbon + PTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-91dj.jpg', NULL),
(N'V91DJ-4IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 91DJ Uni-Body Steam Jacketed Flanged Ball Valve', N'V91DJ - Uni-Body Steam Jacketed Flanged Ball Valve, Reduced Port, Reduced Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-91dj.jpg', NULL),
(N'V91DJ-4IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 91DJ Uni-Body Steam Jacketed Flanged Ball Valve', N'V91DJ - Uni-Body Steam Jacketed Flanged Ball Valve, Reduced Port, Reduced Port, ANSI #300, Body CF8M, Seat 25% Carbon + PTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-91dj.jpg', NULL),
(N'V91DJ-6IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 91DJ Uni-Body Steam Jacketed Flanged Ball Valve', N'V91DJ - Uni-Body Steam Jacketed Flanged Ball Valve, Reduced Port, Reduced Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 6"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-91dj.jpg', NULL),
(N'V91DJ-6IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 91DJ Uni-Body Steam Jacketed Flanged Ball Valve', N'V91DJ - Uni-Body Steam Jacketed Flanged Ball Valve, Reduced Port, Reduced Port, ANSI #300, Body CF8M, Seat 25% Carbon + PTFE, 6"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-91dj.jpg', NULL);

INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'V91DJ-1-2IN-ANSI-150',N'Size',N'1/2"'),(N'V91DJ-1-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V91DJ-1-2IN-ANSI-300',N'Size',N'1/2"'),(N'V91DJ-1-2IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V91DJ-3-4IN-ANSI-150',N'Size',N'3/4"'),(N'V91DJ-3-4IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V91DJ-3-4IN-ANSI-300',N'Size',N'3/4"'),(N'V91DJ-3-4IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V91DJ-1IN-ANSI-150',N'Size',N'1"'),(N'V91DJ-1IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V91DJ-1IN-ANSI-300',N'Size',N'1"'),(N'V91DJ-1IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V91DJ-1-1-4IN-ANSI-150',N'Size',N'1 1/4"'),(N'V91DJ-1-1-4IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V91DJ-1-1-4IN-ANSI-300',N'Size',N'1 1/4"'),(N'V91DJ-1-1-4IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V91DJ-1-1-2IN-ANSI-150',N'Size',N'1 1/2"'),(N'V91DJ-1-1-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V91DJ-1-1-2IN-ANSI-300',N'Size',N'1 1/2"'),(N'V91DJ-1-1-2IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V91DJ-2IN-ANSI-150',N'Size',N'2"'),(N'V91DJ-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V91DJ-2IN-ANSI-300',N'Size',N'2"'),(N'V91DJ-2IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V91DJ-2-1-2IN-ANSI-150',N'Size',N'2 1/2"'),(N'V91DJ-2-1-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V91DJ-2-1-2IN-ANSI-300',N'Size',N'2 1/2"'),(N'V91DJ-2-1-2IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V91DJ-3IN-ANSI-150',N'Size',N'3"'),(N'V91DJ-3IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V91DJ-3IN-ANSI-300',N'Size',N'3"'),(N'V91DJ-3IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V91DJ-4IN-ANSI-150',N'Size',N'4"'),(N'V91DJ-4IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V91DJ-4IN-ANSI-300',N'Size',N'4"'),(N'V91DJ-4IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V91DJ-6IN-ANSI-150',N'Size',N'6"'),(N'V91DJ-6IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V91DJ-6IN-ANSI-300',N'Size',N'6"'),(N'V91DJ-6IN-ANSI-300',N'Flange Rating',N'ANSI #300')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;

SELECT COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
