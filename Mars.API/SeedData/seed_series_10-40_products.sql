-- Series 10-40 products (12, quote-only Price NULL) + filter values. Run AFTER seed_series_10-40_info.sql.
DECLARE @SeriesName nvarchar(100) = N'Series 10-40';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);

INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'End Connection'),(N'Operating Pressure')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);

INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder
FROM (VALUES (N'End Connection',0),(N'Size',1),(N'Operating Pressure',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName
WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);

INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'V10-40-1-8IN-NPT', @CategoryId, N'Active', N'Mars Series 10-40 One Piece Ball Valve', N'V10-40 - One Piece Reduced Port Ball Valve, Female x Female Threaded Ends, PN50, Body CF8M, Seat PTFE, 1/8", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-10-40.jpg', NULL),
(N'V10-40-1-8IN-BSP', @CategoryId, N'Active', N'Mars Series 10-40 One Piece Ball Valve', N'V10-40 - One Piece Reduced Port Ball Valve, Female x Female Threaded Ends, PN50, Body CF8M, Seat PTFE, 1/8", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-10-40.jpg', NULL),
(N'V10-40-1-8IN-BSPT', @CategoryId, N'Active', N'Mars Series 10-40 One Piece Ball Valve', N'V10-40 - One Piece Reduced Port Ball Valve, Female x Female Threaded Ends, PN50, Body CF8M, Seat PTFE, 1/8", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-10-40.jpg', NULL),
(N'V10-40-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series 10-40 One Piece Ball Valve', N'V10-40 - One Piece Reduced Port Ball Valve, Female x Female Threaded Ends, PN50, Body CF8M, Seat PTFE, 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-10-40.jpg', NULL),
(N'V10-40-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series 10-40 One Piece Ball Valve', N'V10-40 - One Piece Reduced Port Ball Valve, Female x Female Threaded Ends, PN50, Body CF8M, Seat PTFE, 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-10-40.jpg', NULL),
(N'V10-40-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series 10-40 One Piece Ball Valve', N'V10-40 - One Piece Reduced Port Ball Valve, Female x Female Threaded Ends, PN50, Body CF8M, Seat PTFE, 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-10-40.jpg', NULL),
(N'V10-40-3-8IN-NPT', @CategoryId, N'Active', N'Mars Series 10-40 One Piece Ball Valve', N'V10-40 - One Piece Reduced Port Ball Valve, Female x Female Threaded Ends, PN50, Body CF8M, Seat PTFE, 3/8", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-10-40.jpg', NULL),
(N'V10-40-3-8IN-BSP', @CategoryId, N'Active', N'Mars Series 10-40 One Piece Ball Valve', N'V10-40 - One Piece Reduced Port Ball Valve, Female x Female Threaded Ends, PN50, Body CF8M, Seat PTFE, 3/8", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-10-40.jpg', NULL),
(N'V10-40-3-8IN-BSPT', @CategoryId, N'Active', N'Mars Series 10-40 One Piece Ball Valve', N'V10-40 - One Piece Reduced Port Ball Valve, Female x Female Threaded Ends, PN50, Body CF8M, Seat PTFE, 3/8", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-10-40.jpg', NULL),
(N'V10-40-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series 10-40 One Piece Ball Valve', N'V10-40 - One Piece Reduced Port Ball Valve, Female x Female Threaded Ends, PN50, Body CF8M, Seat PTFE, 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-10-40.jpg', NULL),
(N'V10-40-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series 10-40 One Piece Ball Valve', N'V10-40 - One Piece Reduced Port Ball Valve, Female x Female Threaded Ends, PN50, Body CF8M, Seat PTFE, 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-10-40.jpg', NULL),
(N'V10-40-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series 10-40 One Piece Ball Valve', N'V10-40 - One Piece Reduced Port Ball Valve, Female x Female Threaded Ends, PN50, Body CF8M, Seat PTFE, 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-10-40.jpg', NULL);

INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value
FROM CatalogProducts p
JOIN (VALUES
  (N'V10-40-1-8IN-NPT',N'Size',N'1/8"'),(N'V10-40-1-8IN-NPT',N'End Connection',N'NPT'),(N'V10-40-1-8IN-NPT',N'Operating Pressure',N'PN50'),
  (N'V10-40-1-8IN-BSP',N'Size',N'1/8"'),(N'V10-40-1-8IN-BSP',N'End Connection',N'BSP'),(N'V10-40-1-8IN-BSP',N'Operating Pressure',N'PN50'),
  (N'V10-40-1-8IN-BSPT',N'Size',N'1/8"'),(N'V10-40-1-8IN-BSPT',N'End Connection',N'BSPT'),(N'V10-40-1-8IN-BSPT',N'Operating Pressure',N'PN50'),
  (N'V10-40-1-4IN-NPT',N'Size',N'1/4"'),(N'V10-40-1-4IN-NPT',N'End Connection',N'NPT'),(N'V10-40-1-4IN-NPT',N'Operating Pressure',N'PN50'),
  (N'V10-40-1-4IN-BSP',N'Size',N'1/4"'),(N'V10-40-1-4IN-BSP',N'End Connection',N'BSP'),(N'V10-40-1-4IN-BSP',N'Operating Pressure',N'PN50'),
  (N'V10-40-1-4IN-BSPT',N'Size',N'1/4"'),(N'V10-40-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'V10-40-1-4IN-BSPT',N'Operating Pressure',N'PN50'),
  (N'V10-40-3-8IN-NPT',N'Size',N'3/8"'),(N'V10-40-3-8IN-NPT',N'End Connection',N'NPT'),(N'V10-40-3-8IN-NPT',N'Operating Pressure',N'PN50'),
  (N'V10-40-3-8IN-BSP',N'Size',N'3/8"'),(N'V10-40-3-8IN-BSP',N'End Connection',N'BSP'),(N'V10-40-3-8IN-BSP',N'Operating Pressure',N'PN50'),
  (N'V10-40-3-8IN-BSPT',N'Size',N'3/8"'),(N'V10-40-3-8IN-BSPT',N'End Connection',N'BSPT'),(N'V10-40-3-8IN-BSPT',N'Operating Pressure',N'PN50'),
  (N'V10-40-1-2IN-NPT',N'Size',N'1/2"'),(N'V10-40-1-2IN-NPT',N'End Connection',N'NPT'),(N'V10-40-1-2IN-NPT',N'Operating Pressure',N'PN50'),
  (N'V10-40-1-2IN-BSP',N'Size',N'1/2"'),(N'V10-40-1-2IN-BSP',N'End Connection',N'BSP'),(N'V10-40-1-2IN-BSP',N'Operating Pressure',N'PN50'),
  (N'V10-40-1-2IN-BSPT',N'Size',N'1/2"'),(N'V10-40-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'V10-40-1-2IN-BSPT',N'Operating Pressure',N'PN50')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;

SELECT COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
SELECT COUNT(*) AS FilterValues FROM ProductFilterValues WHERE CategoryId=@CategoryId;
