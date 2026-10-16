-- Series 90DJ (2-piece steam jacketed flanged, quote-only Price NULL). Run from file (SSMS: File > Open > Execute).
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 90DJ')
    INSERT INTO Categories (Name, Description, BodyMaterial, SeatMaterial, Design, Approvals, KeyFeatures)
    VALUES (N'Series 90DJ',
        N'The Mars Series 90DJ is a 2-piece, full-port steam-jacketed flanged ball valve rated ANSI Class 150/300, PN16/40 and JIS 10K/20K, in sizes 1/2" to 8". Face-to-face per ANSI B16.10 / EN 558-1 (GR.1/GR.27, DIN 3202 F1/F4/F5). CF8M body with 25% carbon+PTFE seats.',
        N'CF8M', N'25% Carbon + PTFE', N'Two Piece, Steam Jacketed, Flanged, Full Port', N'Face-to-face: ANSI B16.10, EN 558-1',
        N'2-piece full port steam jacketed flanged design
Flange ratings: ANSI #150/#300, PN16/40, JIS 10K/20K
Face-to-face: ANSI B16.10, EN 558-1 (GR.1/GR.27, DIN 3202 F1/F4/F5)
CF8M body
25% carbon + PTFE seats
Size 1/2" to 8"');

DECLARE @SeriesName nvarchar(100) = N'Series 90DJ';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);

INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'Flange Rating')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);

INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'Flange Rating',0),(N'Size',1)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);

INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'V90DJ-1-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-1-2IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, ANSI #300, Body CF8M, Seat 25% Carbon + PTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-1-2IN-PN16-40', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, PN16/40, Body CF8M, Seat 25% Carbon + PTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-1-2IN-JIS-10K', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, JIS 10K, Body CF8M, Seat 25% Carbon + PTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-1-2IN-JIS-20K', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, JIS 20K, Body CF8M, Seat 25% Carbon + PTFE, 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-3-4IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-3-4IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, ANSI #300, Body CF8M, Seat 25% Carbon + PTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-3-4IN-PN16-40', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, PN16/40, Body CF8M, Seat 25% Carbon + PTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-3-4IN-JIS-10K', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, JIS 10K, Body CF8M, Seat 25% Carbon + PTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-3-4IN-JIS-20K', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, JIS 20K, Body CF8M, Seat 25% Carbon + PTFE, 3/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-1IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-1IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, ANSI #300, Body CF8M, Seat 25% Carbon + PTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-1IN-PN16-40', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, PN16/40, Body CF8M, Seat 25% Carbon + PTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-1IN-JIS-10K', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, JIS 10K, Body CF8M, Seat 25% Carbon + PTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-1IN-JIS-20K', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, JIS 20K, Body CF8M, Seat 25% Carbon + PTFE, 1"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-1-1-4IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-1-1-4IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, ANSI #300, Body CF8M, Seat 25% Carbon + PTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-1-1-4IN-PN16-40', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, PN16/40, Body CF8M, Seat 25% Carbon + PTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-1-1-4IN-JIS-10K', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, JIS 10K, Body CF8M, Seat 25% Carbon + PTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-1-1-4IN-JIS-20K', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, JIS 20K, Body CF8M, Seat 25% Carbon + PTFE, 1 1/4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-1-1-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-1-1-2IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, ANSI #300, Body CF8M, Seat 25% Carbon + PTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-1-1-2IN-PN16-40', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, PN16/40, Body CF8M, Seat 25% Carbon + PTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-1-1-2IN-JIS-10K', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, JIS 10K, Body CF8M, Seat 25% Carbon + PTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-1-1-2IN-JIS-20K', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, JIS 20K, Body CF8M, Seat 25% Carbon + PTFE, 1 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-2IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, ANSI #300, Body CF8M, Seat 25% Carbon + PTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-2IN-PN16-40', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, PN16/40, Body CF8M, Seat 25% Carbon + PTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-2IN-JIS-10K', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, JIS 10K, Body CF8M, Seat 25% Carbon + PTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-2IN-JIS-20K', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, JIS 20K, Body CF8M, Seat 25% Carbon + PTFE, 2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-2-1-2IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-2-1-2IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, ANSI #300, Body CF8M, Seat 25% Carbon + PTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-2-1-2IN-PN16-40', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, PN16/40, Body CF8M, Seat 25% Carbon + PTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-2-1-2IN-JIS-10K', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, JIS 10K, Body CF8M, Seat 25% Carbon + PTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-2-1-2IN-JIS-20K', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, JIS 20K, Body CF8M, Seat 25% Carbon + PTFE, 2 1/2"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-3IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-3IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, ANSI #300, Body CF8M, Seat 25% Carbon + PTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-3IN-PN16-40', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, PN16/40, Body CF8M, Seat 25% Carbon + PTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-3IN-JIS-10K', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, JIS 10K, Body CF8M, Seat 25% Carbon + PTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-3IN-JIS-20K', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, JIS 20K, Body CF8M, Seat 25% Carbon + PTFE, 3"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-4IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-4IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, ANSI #300, Body CF8M, Seat 25% Carbon + PTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-4IN-PN16-40', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, PN16/40, Body CF8M, Seat 25% Carbon + PTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-4IN-JIS-10K', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, JIS 10K, Body CF8M, Seat 25% Carbon + PTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-4IN-JIS-20K', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, JIS 20K, Body CF8M, Seat 25% Carbon + PTFE, 4"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-6IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 6"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-6IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, ANSI #300, Body CF8M, Seat 25% Carbon + PTFE, 6"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-6IN-PN16-40', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, PN16/40, Body CF8M, Seat 25% Carbon + PTFE, 6"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-6IN-JIS-10K', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, JIS 10K, Body CF8M, Seat 25% Carbon + PTFE, 6"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-6IN-JIS-20K', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, JIS 20K, Body CF8M, Seat 25% Carbon + PTFE, 6"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-8IN-ANSI-150', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, ANSI #150, Body CF8M, Seat 25% Carbon + PTFE, 8"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-8IN-ANSI-300', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, ANSI #300, Body CF8M, Seat 25% Carbon + PTFE, 8"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-8IN-PN16-40', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, PN16/40, Body CF8M, Seat 25% Carbon + PTFE, 8"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-8IN-JIS-10K', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, JIS 10K, Body CF8M, Seat 25% Carbon + PTFE, 8"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL),
(N'V90DJ-8IN-JIS-20K', @CategoryId, N'Active', N'Mars Series 90DJ Two Piece Steam Jacketed Flanged Ball Valve', N'V90DJ - 2-PC Steam Jacketed Flanged Ball Valve, Full Port, JIS 20K, Body CF8M, Seat 25% Carbon + PTFE, 8"', N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/flanged/series-90dj.jpg', NULL);

INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'V90DJ-1-2IN-ANSI-150',N'Size',N'1/2"'),(N'V90DJ-1-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V90DJ-1-2IN-ANSI-300',N'Size',N'1/2"'),(N'V90DJ-1-2IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V90DJ-1-2IN-PN16-40',N'Size',N'1/2"'),(N'V90DJ-1-2IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V90DJ-1-2IN-JIS-10K',N'Size',N'1/2"'),(N'V90DJ-1-2IN-JIS-10K',N'Flange Rating',N'JIS 10K'),
  (N'V90DJ-1-2IN-JIS-20K',N'Size',N'1/2"'),(N'V90DJ-1-2IN-JIS-20K',N'Flange Rating',N'JIS 20K'),
  (N'V90DJ-3-4IN-ANSI-150',N'Size',N'3/4"'),(N'V90DJ-3-4IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V90DJ-3-4IN-ANSI-300',N'Size',N'3/4"'),(N'V90DJ-3-4IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V90DJ-3-4IN-PN16-40',N'Size',N'3/4"'),(N'V90DJ-3-4IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V90DJ-3-4IN-JIS-10K',N'Size',N'3/4"'),(N'V90DJ-3-4IN-JIS-10K',N'Flange Rating',N'JIS 10K'),
  (N'V90DJ-3-4IN-JIS-20K',N'Size',N'3/4"'),(N'V90DJ-3-4IN-JIS-20K',N'Flange Rating',N'JIS 20K'),
  (N'V90DJ-1IN-ANSI-150',N'Size',N'1"'),(N'V90DJ-1IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V90DJ-1IN-ANSI-300',N'Size',N'1"'),(N'V90DJ-1IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V90DJ-1IN-PN16-40',N'Size',N'1"'),(N'V90DJ-1IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V90DJ-1IN-JIS-10K',N'Size',N'1"'),(N'V90DJ-1IN-JIS-10K',N'Flange Rating',N'JIS 10K'),
  (N'V90DJ-1IN-JIS-20K',N'Size',N'1"'),(N'V90DJ-1IN-JIS-20K',N'Flange Rating',N'JIS 20K'),
  (N'V90DJ-1-1-4IN-ANSI-150',N'Size',N'1 1/4"'),(N'V90DJ-1-1-4IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V90DJ-1-1-4IN-ANSI-300',N'Size',N'1 1/4"'),(N'V90DJ-1-1-4IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V90DJ-1-1-4IN-PN16-40',N'Size',N'1 1/4"'),(N'V90DJ-1-1-4IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V90DJ-1-1-4IN-JIS-10K',N'Size',N'1 1/4"'),(N'V90DJ-1-1-4IN-JIS-10K',N'Flange Rating',N'JIS 10K'),
  (N'V90DJ-1-1-4IN-JIS-20K',N'Size',N'1 1/4"'),(N'V90DJ-1-1-4IN-JIS-20K',N'Flange Rating',N'JIS 20K'),
  (N'V90DJ-1-1-2IN-ANSI-150',N'Size',N'1 1/2"'),(N'V90DJ-1-1-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V90DJ-1-1-2IN-ANSI-300',N'Size',N'1 1/2"'),(N'V90DJ-1-1-2IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V90DJ-1-1-2IN-PN16-40',N'Size',N'1 1/2"'),(N'V90DJ-1-1-2IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V90DJ-1-1-2IN-JIS-10K',N'Size',N'1 1/2"'),(N'V90DJ-1-1-2IN-JIS-10K',N'Flange Rating',N'JIS 10K'),
  (N'V90DJ-1-1-2IN-JIS-20K',N'Size',N'1 1/2"'),(N'V90DJ-1-1-2IN-JIS-20K',N'Flange Rating',N'JIS 20K'),
  (N'V90DJ-2IN-ANSI-150',N'Size',N'2"'),(N'V90DJ-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V90DJ-2IN-ANSI-300',N'Size',N'2"'),(N'V90DJ-2IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V90DJ-2IN-PN16-40',N'Size',N'2"'),(N'V90DJ-2IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V90DJ-2IN-JIS-10K',N'Size',N'2"'),(N'V90DJ-2IN-JIS-10K',N'Flange Rating',N'JIS 10K'),
  (N'V90DJ-2IN-JIS-20K',N'Size',N'2"'),(N'V90DJ-2IN-JIS-20K',N'Flange Rating',N'JIS 20K'),
  (N'V90DJ-2-1-2IN-ANSI-150',N'Size',N'2 1/2"'),(N'V90DJ-2-1-2IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V90DJ-2-1-2IN-ANSI-300',N'Size',N'2 1/2"'),(N'V90DJ-2-1-2IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V90DJ-2-1-2IN-PN16-40',N'Size',N'2 1/2"'),(N'V90DJ-2-1-2IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V90DJ-2-1-2IN-JIS-10K',N'Size',N'2 1/2"'),(N'V90DJ-2-1-2IN-JIS-10K',N'Flange Rating',N'JIS 10K'),
  (N'V90DJ-2-1-2IN-JIS-20K',N'Size',N'2 1/2"'),(N'V90DJ-2-1-2IN-JIS-20K',N'Flange Rating',N'JIS 20K'),
  (N'V90DJ-3IN-ANSI-150',N'Size',N'3"'),(N'V90DJ-3IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V90DJ-3IN-ANSI-300',N'Size',N'3"'),(N'V90DJ-3IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V90DJ-3IN-PN16-40',N'Size',N'3"'),(N'V90DJ-3IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V90DJ-3IN-JIS-10K',N'Size',N'3"'),(N'V90DJ-3IN-JIS-10K',N'Flange Rating',N'JIS 10K'),
  (N'V90DJ-3IN-JIS-20K',N'Size',N'3"'),(N'V90DJ-3IN-JIS-20K',N'Flange Rating',N'JIS 20K'),
  (N'V90DJ-4IN-ANSI-150',N'Size',N'4"'),(N'V90DJ-4IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V90DJ-4IN-ANSI-300',N'Size',N'4"'),(N'V90DJ-4IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V90DJ-4IN-PN16-40',N'Size',N'4"'),(N'V90DJ-4IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V90DJ-4IN-JIS-10K',N'Size',N'4"'),(N'V90DJ-4IN-JIS-10K',N'Flange Rating',N'JIS 10K'),
  (N'V90DJ-4IN-JIS-20K',N'Size',N'4"'),(N'V90DJ-4IN-JIS-20K',N'Flange Rating',N'JIS 20K'),
  (N'V90DJ-6IN-ANSI-150',N'Size',N'6"'),(N'V90DJ-6IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V90DJ-6IN-ANSI-300',N'Size',N'6"'),(N'V90DJ-6IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V90DJ-6IN-PN16-40',N'Size',N'6"'),(N'V90DJ-6IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V90DJ-6IN-JIS-10K',N'Size',N'6"'),(N'V90DJ-6IN-JIS-10K',N'Flange Rating',N'JIS 10K'),
  (N'V90DJ-6IN-JIS-20K',N'Size',N'6"'),(N'V90DJ-6IN-JIS-20K',N'Flange Rating',N'JIS 20K'),
  (N'V90DJ-8IN-ANSI-150',N'Size',N'8"'),(N'V90DJ-8IN-ANSI-150',N'Flange Rating',N'ANSI #150'),
  (N'V90DJ-8IN-ANSI-300',N'Size',N'8"'),(N'V90DJ-8IN-ANSI-300',N'Flange Rating',N'ANSI #300'),
  (N'V90DJ-8IN-PN16-40',N'Size',N'8"'),(N'V90DJ-8IN-PN16-40',N'Flange Rating',N'PN16/40'),
  (N'V90DJ-8IN-JIS-10K',N'Size',N'8"'),(N'V90DJ-8IN-JIS-10K',N'Flange Rating',N'JIS 10K'),
  (N'V90DJ-8IN-JIS-20K',N'Size',N'8"'),(N'V90DJ-8IN-JIS-20K',N'Flange Rating',N'JIS 20K')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;

SELECT COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
