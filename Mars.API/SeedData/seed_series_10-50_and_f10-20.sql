-- Series 10-50 + F10-20 (quote-only). Run from file (SSMS: File > Open > Execute).
-- GO separators split the batches; just run the whole file.

-- ===== Series 10-50 (12 products, quote-only Price NULL) =====
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 10-50')
    INSERT INTO Categories (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures)
    VALUES (N'Series 10-50', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'The Mars Series 10-50 is a one-piece, reduced-port ball valve with female-male threaded ends, rated to PN50. CF8M stainless steel body with a PTFE seat, in sizes 1/8" to 1/2".', N'CF8M Stainless Steel', N'PTFE', N'One Piece, Reduced Port, Female x Male Threaded Ends', N'One-piece reduced port design
Female x male threaded ends (NPT, BSP, BSPT)
Rated to PN50
CF8M stainless steel body
PTFE seat
Size 1/8" to 1/2"');
GO
DECLARE @SeriesName nvarchar(100) = N'Series 10-50';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);
INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'End Connection'),(N'Operating Pressure')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);
INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'End Connection',0),(N'Size',1),(N'Operating Pressure',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);
INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'V10-50-1-8IN-NPT', @CategoryId, N'Active', N'Mars Series 10-50 One Piece Ball Valve', N'V10-50 - One Piece Reduced Port Ball Valve, Female x Male Threaded Ends, PN50, Body CF8M, Seat PTFE, 1/8", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-10-50.jpg', NULL),
(N'V10-50-1-8IN-BSP', @CategoryId, N'Active', N'Mars Series 10-50 One Piece Ball Valve', N'V10-50 - One Piece Reduced Port Ball Valve, Female x Male Threaded Ends, PN50, Body CF8M, Seat PTFE, 1/8", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-10-50.jpg', NULL),
(N'V10-50-1-8IN-BSPT', @CategoryId, N'Active', N'Mars Series 10-50 One Piece Ball Valve', N'V10-50 - One Piece Reduced Port Ball Valve, Female x Male Threaded Ends, PN50, Body CF8M, Seat PTFE, 1/8", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-10-50.jpg', NULL),
(N'V10-50-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series 10-50 One Piece Ball Valve', N'V10-50 - One Piece Reduced Port Ball Valve, Female x Male Threaded Ends, PN50, Body CF8M, Seat PTFE, 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-10-50.jpg', NULL),
(N'V10-50-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series 10-50 One Piece Ball Valve', N'V10-50 - One Piece Reduced Port Ball Valve, Female x Male Threaded Ends, PN50, Body CF8M, Seat PTFE, 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-10-50.jpg', NULL),
(N'V10-50-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series 10-50 One Piece Ball Valve', N'V10-50 - One Piece Reduced Port Ball Valve, Female x Male Threaded Ends, PN50, Body CF8M, Seat PTFE, 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-10-50.jpg', NULL),
(N'V10-50-3-8IN-NPT', @CategoryId, N'Active', N'Mars Series 10-50 One Piece Ball Valve', N'V10-50 - One Piece Reduced Port Ball Valve, Female x Male Threaded Ends, PN50, Body CF8M, Seat PTFE, 3/8", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-10-50.jpg', NULL),
(N'V10-50-3-8IN-BSP', @CategoryId, N'Active', N'Mars Series 10-50 One Piece Ball Valve', N'V10-50 - One Piece Reduced Port Ball Valve, Female x Male Threaded Ends, PN50, Body CF8M, Seat PTFE, 3/8", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-10-50.jpg', NULL),
(N'V10-50-3-8IN-BSPT', @CategoryId, N'Active', N'Mars Series 10-50 One Piece Ball Valve', N'V10-50 - One Piece Reduced Port Ball Valve, Female x Male Threaded Ends, PN50, Body CF8M, Seat PTFE, 3/8", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-10-50.jpg', NULL),
(N'V10-50-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series 10-50 One Piece Ball Valve', N'V10-50 - One Piece Reduced Port Ball Valve, Female x Male Threaded Ends, PN50, Body CF8M, Seat PTFE, 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-10-50.jpg', NULL),
(N'V10-50-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series 10-50 One Piece Ball Valve', N'V10-50 - One Piece Reduced Port Ball Valve, Female x Male Threaded Ends, PN50, Body CF8M, Seat PTFE, 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-10-50.jpg', NULL),
(N'V10-50-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series 10-50 One Piece Ball Valve', N'V10-50 - One Piece Reduced Port Ball Valve, Female x Male Threaded Ends, PN50, Body CF8M, Seat PTFE, 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-10-50.jpg', NULL);
INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'V10-50-1-8IN-NPT',N'Size',N'1/8"'),(N'V10-50-1-8IN-NPT',N'End Connection',N'NPT'),(N'V10-50-1-8IN-NPT',N'Operating Pressure',N'PN50'),
  (N'V10-50-1-8IN-BSP',N'Size',N'1/8"'),(N'V10-50-1-8IN-BSP',N'End Connection',N'BSP'),(N'V10-50-1-8IN-BSP',N'Operating Pressure',N'PN50'),
  (N'V10-50-1-8IN-BSPT',N'Size',N'1/8"'),(N'V10-50-1-8IN-BSPT',N'End Connection',N'BSPT'),(N'V10-50-1-8IN-BSPT',N'Operating Pressure',N'PN50'),
  (N'V10-50-1-4IN-NPT',N'Size',N'1/4"'),(N'V10-50-1-4IN-NPT',N'End Connection',N'NPT'),(N'V10-50-1-4IN-NPT',N'Operating Pressure',N'PN50'),
  (N'V10-50-1-4IN-BSP',N'Size',N'1/4"'),(N'V10-50-1-4IN-BSP',N'End Connection',N'BSP'),(N'V10-50-1-4IN-BSP',N'Operating Pressure',N'PN50'),
  (N'V10-50-1-4IN-BSPT',N'Size',N'1/4"'),(N'V10-50-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'V10-50-1-4IN-BSPT',N'Operating Pressure',N'PN50'),
  (N'V10-50-3-8IN-NPT',N'Size',N'3/8"'),(N'V10-50-3-8IN-NPT',N'End Connection',N'NPT'),(N'V10-50-3-8IN-NPT',N'Operating Pressure',N'PN50'),
  (N'V10-50-3-8IN-BSP',N'Size',N'3/8"'),(N'V10-50-3-8IN-BSP',N'End Connection',N'BSP'),(N'V10-50-3-8IN-BSP',N'Operating Pressure',N'PN50'),
  (N'V10-50-3-8IN-BSPT',N'Size',N'3/8"'),(N'V10-50-3-8IN-BSPT',N'End Connection',N'BSPT'),(N'V10-50-3-8IN-BSPT',N'Operating Pressure',N'PN50'),
  (N'V10-50-1-2IN-NPT',N'Size',N'1/2"'),(N'V10-50-1-2IN-NPT',N'End Connection',N'NPT'),(N'V10-50-1-2IN-NPT',N'Operating Pressure',N'PN50'),
  (N'V10-50-1-2IN-BSP',N'Size',N'1/2"'),(N'V10-50-1-2IN-BSP',N'End Connection',N'BSP'),(N'V10-50-1-2IN-BSP',N'Operating Pressure',N'PN50'),
  (N'V10-50-1-2IN-BSPT',N'Size',N'1/2"'),(N'V10-50-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'V10-50-1-2IN-BSPT',N'Operating Pressure',N'PN50')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;
SELECT N'Series 10-50' AS Series, COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
GO

-- ===== Series F10-20 (24 products, quote-only Price NULL) =====
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series F10-20')
    INSERT INTO Categories (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures)
    VALUES (N'Series F10-20', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf', N'The Mars Series F10-20 is a one-piece, reduced-port direct-mount ball valve with threaded ends, rated to 1000 PSI. CF8M stainless steel body with a PTFE seat, in sizes 1/4" to 2".', N'CF8M Stainless Steel', N'PTFE', N'One Piece, Reduced Port, Direct Mount', N'One-piece reduced port direct mount design
Threaded ends (NPT, BSP, BSPT)
Rated to 1000 PSI
CF8M stainless steel body
PTFE seat
Size 1/4" to 2"');
GO
DECLARE @SeriesName nvarchar(100) = N'Series F10-20';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);
INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'End Connection'),(N'Operating Pressure')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);
INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'End Connection',0),(N'Size',1),(N'Operating Pressure',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);
INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VF10-20-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F10-20 One Piece Ball Valve', N'VF10-20 - One Piece Reduced Port Ball Valve, Threaded Ends, Direct Mount, 1000 PSI, Body CF8M, Seat PTFE, 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-20.jpg', NULL),
(N'VF10-20-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F10-20 One Piece Ball Valve', N'VF10-20 - One Piece Reduced Port Ball Valve, Threaded Ends, Direct Mount, 1000 PSI, Body CF8M, Seat PTFE, 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-20.jpg', NULL),
(N'VF10-20-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-20 One Piece Ball Valve', N'VF10-20 - One Piece Reduced Port Ball Valve, Threaded Ends, Direct Mount, 1000 PSI, Body CF8M, Seat PTFE, 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-20.jpg', NULL),
(N'VF10-20-3-8IN-NPT', @CategoryId, N'Active', N'Mars Series F10-20 One Piece Ball Valve', N'VF10-20 - One Piece Reduced Port Ball Valve, Threaded Ends, Direct Mount, 1000 PSI, Body CF8M, Seat PTFE, 3/8", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-20.jpg', NULL),
(N'VF10-20-3-8IN-BSP', @CategoryId, N'Active', N'Mars Series F10-20 One Piece Ball Valve', N'VF10-20 - One Piece Reduced Port Ball Valve, Threaded Ends, Direct Mount, 1000 PSI, Body CF8M, Seat PTFE, 3/8", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-20.jpg', NULL),
(N'VF10-20-3-8IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-20 One Piece Ball Valve', N'VF10-20 - One Piece Reduced Port Ball Valve, Threaded Ends, Direct Mount, 1000 PSI, Body CF8M, Seat PTFE, 3/8", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-20.jpg', NULL),
(N'VF10-20-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F10-20 One Piece Ball Valve', N'VF10-20 - One Piece Reduced Port Ball Valve, Threaded Ends, Direct Mount, 1000 PSI, Body CF8M, Seat PTFE, 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-20.jpg', NULL),
(N'VF10-20-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F10-20 One Piece Ball Valve', N'VF10-20 - One Piece Reduced Port Ball Valve, Threaded Ends, Direct Mount, 1000 PSI, Body CF8M, Seat PTFE, 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-20.jpg', NULL),
(N'VF10-20-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-20 One Piece Ball Valve', N'VF10-20 - One Piece Reduced Port Ball Valve, Threaded Ends, Direct Mount, 1000 PSI, Body CF8M, Seat PTFE, 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-20.jpg', NULL),
(N'VF10-20-3-4IN-NPT', @CategoryId, N'Active', N'Mars Series F10-20 One Piece Ball Valve', N'VF10-20 - One Piece Reduced Port Ball Valve, Threaded Ends, Direct Mount, 1000 PSI, Body CF8M, Seat PTFE, 3/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-20.jpg', NULL),
(N'VF10-20-3-4IN-BSP', @CategoryId, N'Active', N'Mars Series F10-20 One Piece Ball Valve', N'VF10-20 - One Piece Reduced Port Ball Valve, Threaded Ends, Direct Mount, 1000 PSI, Body CF8M, Seat PTFE, 3/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-20.jpg', NULL),
(N'VF10-20-3-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-20 One Piece Ball Valve', N'VF10-20 - One Piece Reduced Port Ball Valve, Threaded Ends, Direct Mount, 1000 PSI, Body CF8M, Seat PTFE, 3/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-20.jpg', NULL),
(N'VF10-20-1IN-NPT', @CategoryId, N'Active', N'Mars Series F10-20 One Piece Ball Valve', N'VF10-20 - One Piece Reduced Port Ball Valve, Threaded Ends, Direct Mount, 1000 PSI, Body CF8M, Seat PTFE, 1", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-20.jpg', NULL),
(N'VF10-20-1IN-BSP', @CategoryId, N'Active', N'Mars Series F10-20 One Piece Ball Valve', N'VF10-20 - One Piece Reduced Port Ball Valve, Threaded Ends, Direct Mount, 1000 PSI, Body CF8M, Seat PTFE, 1", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-20.jpg', NULL),
(N'VF10-20-1IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-20 One Piece Ball Valve', N'VF10-20 - One Piece Reduced Port Ball Valve, Threaded Ends, Direct Mount, 1000 PSI, Body CF8M, Seat PTFE, 1", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-20.jpg', NULL),
(N'VF10-20-1-1-4IN-NPT', @CategoryId, N'Active', N'Mars Series F10-20 One Piece Ball Valve', N'VF10-20 - One Piece Reduced Port Ball Valve, Threaded Ends, Direct Mount, 1000 PSI, Body CF8M, Seat PTFE, 1 1/4", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-20.jpg', NULL),
(N'VF10-20-1-1-4IN-BSP', @CategoryId, N'Active', N'Mars Series F10-20 One Piece Ball Valve', N'VF10-20 - One Piece Reduced Port Ball Valve, Threaded Ends, Direct Mount, 1000 PSI, Body CF8M, Seat PTFE, 1 1/4", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-20.jpg', NULL),
(N'VF10-20-1-1-4IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-20 One Piece Ball Valve', N'VF10-20 - One Piece Reduced Port Ball Valve, Threaded Ends, Direct Mount, 1000 PSI, Body CF8M, Seat PTFE, 1 1/4", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-20.jpg', NULL),
(N'VF10-20-1-1-2IN-NPT', @CategoryId, N'Active', N'Mars Series F10-20 One Piece Ball Valve', N'VF10-20 - One Piece Reduced Port Ball Valve, Threaded Ends, Direct Mount, 1000 PSI, Body CF8M, Seat PTFE, 1 1/2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-20.jpg', NULL),
(N'VF10-20-1-1-2IN-BSP', @CategoryId, N'Active', N'Mars Series F10-20 One Piece Ball Valve', N'VF10-20 - One Piece Reduced Port Ball Valve, Threaded Ends, Direct Mount, 1000 PSI, Body CF8M, Seat PTFE, 1 1/2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-20.jpg', NULL),
(N'VF10-20-1-1-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-20 One Piece Ball Valve', N'VF10-20 - One Piece Reduced Port Ball Valve, Threaded Ends, Direct Mount, 1000 PSI, Body CF8M, Seat PTFE, 1 1/2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-20.jpg', NULL),
(N'VF10-20-2IN-NPT', @CategoryId, N'Active', N'Mars Series F10-20 One Piece Ball Valve', N'VF10-20 - One Piece Reduced Port Ball Valve, Threaded Ends, Direct Mount, 1000 PSI, Body CF8M, Seat PTFE, 2", NPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-20.jpg', NULL),
(N'VF10-20-2IN-BSP', @CategoryId, N'Active', N'Mars Series F10-20 One Piece Ball Valve', N'VF10-20 - One Piece Reduced Port Ball Valve, Threaded Ends, Direct Mount, 1000 PSI, Body CF8M, Seat PTFE, 2", BSP', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-20.jpg', NULL),
(N'VF10-20-2IN-BSPT', @CategoryId, N'Active', N'Mars Series F10-20 One Piece Ball Valve', N'VF10-20 - One Piece Reduced Port Ball Valve, Threaded Ends, Direct Mount, 1000 PSI, Body CF8M, Seat PTFE, 2", BSPT', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/one-piece-ball-valves/series-f10-20.jpg', NULL);
INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VF10-20-1-4IN-NPT',N'Size',N'1/4"'),(N'VF10-20-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF10-20-1-4IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-20-1-4IN-BSP',N'Size',N'1/4"'),(N'VF10-20-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF10-20-1-4IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-20-1-4IN-BSPT',N'Size',N'1/4"'),(N'VF10-20-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-20-1-4IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-20-3-8IN-NPT',N'Size',N'3/8"'),(N'VF10-20-3-8IN-NPT',N'End Connection',N'NPT'),(N'VF10-20-3-8IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-20-3-8IN-BSP',N'Size',N'3/8"'),(N'VF10-20-3-8IN-BSP',N'End Connection',N'BSP'),(N'VF10-20-3-8IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-20-3-8IN-BSPT',N'Size',N'3/8"'),(N'VF10-20-3-8IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-20-3-8IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-20-1-2IN-NPT',N'Size',N'1/2"'),(N'VF10-20-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF10-20-1-2IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-20-1-2IN-BSP',N'Size',N'1/2"'),(N'VF10-20-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF10-20-1-2IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-20-1-2IN-BSPT',N'Size',N'1/2"'),(N'VF10-20-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-20-1-2IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-20-3-4IN-NPT',N'Size',N'3/4"'),(N'VF10-20-3-4IN-NPT',N'End Connection',N'NPT'),(N'VF10-20-3-4IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-20-3-4IN-BSP',N'Size',N'3/4"'),(N'VF10-20-3-4IN-BSP',N'End Connection',N'BSP'),(N'VF10-20-3-4IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-20-3-4IN-BSPT',N'Size',N'3/4"'),(N'VF10-20-3-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-20-3-4IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-20-1IN-NPT',N'Size',N'1"'),(N'VF10-20-1IN-NPT',N'End Connection',N'NPT'),(N'VF10-20-1IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-20-1IN-BSP',N'Size',N'1"'),(N'VF10-20-1IN-BSP',N'End Connection',N'BSP'),(N'VF10-20-1IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-20-1IN-BSPT',N'Size',N'1"'),(N'VF10-20-1IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-20-1IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-20-1-1-4IN-NPT',N'Size',N'1 1/4"'),(N'VF10-20-1-1-4IN-NPT',N'End Connection',N'NPT'),(N'VF10-20-1-1-4IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-20-1-1-4IN-BSP',N'Size',N'1 1/4"'),(N'VF10-20-1-1-4IN-BSP',N'End Connection',N'BSP'),(N'VF10-20-1-1-4IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-20-1-1-4IN-BSPT',N'Size',N'1 1/4"'),(N'VF10-20-1-1-4IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-20-1-1-4IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-20-1-1-2IN-NPT',N'Size',N'1 1/2"'),(N'VF10-20-1-1-2IN-NPT',N'End Connection',N'NPT'),(N'VF10-20-1-1-2IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-20-1-1-2IN-BSP',N'Size',N'1 1/2"'),(N'VF10-20-1-1-2IN-BSP',N'End Connection',N'BSP'),(N'VF10-20-1-1-2IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-20-1-1-2IN-BSPT',N'Size',N'1 1/2"'),(N'VF10-20-1-1-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-20-1-1-2IN-BSPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-20-2IN-NPT',N'Size',N'2"'),(N'VF10-20-2IN-NPT',N'End Connection',N'NPT'),(N'VF10-20-2IN-NPT',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-20-2IN-BSP',N'Size',N'2"'),(N'VF10-20-2IN-BSP',N'End Connection',N'BSP'),(N'VF10-20-2IN-BSP',N'Operating Pressure',N'1000 PSI'),
  (N'VF10-20-2IN-BSPT',N'Size',N'2"'),(N'VF10-20-2IN-BSPT',N'End Connection',N'BSPT'),(N'VF10-20-2IN-BSPT',N'Operating Pressure',N'1000 PSI')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;
SELECT N'Series F10-20' AS Series, COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
GO
