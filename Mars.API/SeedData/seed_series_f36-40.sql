-- Series F36-40 (multi-port, quote-only Price NULL). Run from file (SSMS: File > Open > Execute).
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series F36-40')
    INSERT INTO Categories (Name, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures)
    VALUES (N'Series F36-40',
        N'The Mars Series F36-40 is a 4-way direct-mount threaded ball valve rated to 1000 PSI, in full or reduced port with L-port, LL-port or T-port ball, sizes 1/4" to 2". CF8M body with PTFE/RTFE seats (cavity filler seat on request).',
        N'CF8M', N'PTFE / RTFE', N'4-Way Direct Mount Ball Valve',
        N'4-way direct mount design
Threaded ends
Full port & reduced port
Ball configuration: L port, LL port, T port
Rated to 1000 PSI
CF8M body
PTFE / RTFE seats (cavity filler seat on request)
Size 1/4" to 2"');

DECLARE @SeriesName nvarchar(100) = N'Series F36-40';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);

INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Size'),(N'Ball Configuration'),(N'Port')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);

INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'Size',1),(N'Ball Configuration',2),(N'Port',3)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);

INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'VF36-40-1-4IN-L-FP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1/4", L port, Full Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1-4IN-L-RP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1/4", L port, Reduced Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1-4IN-LL-FP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1/4", LL port, Full Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1-4IN-LL-RP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1/4", LL port, Reduced Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1-4IN-T-FP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1/4", T port, Full Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1-4IN-T-RP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1/4", T port, Reduced Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-3-8IN-L-FP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 3/8", L port, Full Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-3-8IN-L-RP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 3/8", L port, Reduced Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-3-8IN-LL-FP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 3/8", LL port, Full Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-3-8IN-LL-RP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 3/8", LL port, Reduced Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-3-8IN-T-FP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 3/8", T port, Full Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-3-8IN-T-RP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 3/8", T port, Reduced Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1-2IN-L-FP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1/2", L port, Full Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1-2IN-L-RP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1/2", L port, Reduced Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1-2IN-LL-FP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1/2", LL port, Full Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1-2IN-LL-RP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1/2", LL port, Reduced Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1-2IN-T-FP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1/2", T port, Full Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1-2IN-T-RP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1/2", T port, Reduced Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-3-4IN-L-FP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 3/4", L port, Full Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-3-4IN-L-RP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 3/4", L port, Reduced Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-3-4IN-LL-FP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 3/4", LL port, Full Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-3-4IN-LL-RP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 3/4", LL port, Reduced Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-3-4IN-T-FP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 3/4", T port, Full Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-3-4IN-T-RP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 3/4", T port, Reduced Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1IN-L-FP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1", L port, Full Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1IN-L-RP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1", L port, Reduced Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1IN-LL-FP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1", LL port, Full Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1IN-LL-RP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1", LL port, Reduced Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1IN-T-FP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1", T port, Full Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1IN-T-RP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1", T port, Reduced Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1-1-4IN-L-FP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1 1/4", L port, Full Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1-1-4IN-L-RP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1 1/4", L port, Reduced Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1-1-4IN-LL-FP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1 1/4", LL port, Full Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1-1-4IN-LL-RP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1 1/4", LL port, Reduced Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1-1-4IN-T-FP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1 1/4", T port, Full Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1-1-4IN-T-RP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1 1/4", T port, Reduced Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1-1-2IN-L-FP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1 1/2", L port, Full Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1-1-2IN-L-RP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1 1/2", L port, Reduced Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1-1-2IN-LL-FP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1 1/2", LL port, Full Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1-1-2IN-LL-RP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1 1/2", LL port, Reduced Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1-1-2IN-T-FP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1 1/2", T port, Full Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-1-1-2IN-T-RP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 1 1/2", T port, Reduced Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-2IN-L-FP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 2", L port, Full Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-2IN-L-RP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 2", L port, Reduced Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-2IN-LL-FP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 2", LL port, Full Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-2IN-LL-RP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 2", LL port, Reduced Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-2IN-T-FP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 2", T port, Full Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL),
(N'VF36-40-2IN-T-RP', @CategoryId, N'Active', N'Series F36-40', N'VF36-40 - 4-Way Direct Mount Ball Valve, Direct Mount, Threaded ends, 4-way, 2", T port, Reduced Port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-f36-40.jpg', NULL);

INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'VF36-40-1-4IN-L-FP',N'Size',N'1/4"'),(N'VF36-40-1-4IN-L-FP',N'Ball Configuration',N'L port'),(N'VF36-40-1-4IN-L-FP',N'Port',N'Full Port'),
  (N'VF36-40-1-4IN-L-RP',N'Size',N'1/4"'),(N'VF36-40-1-4IN-L-RP',N'Ball Configuration',N'L port'),(N'VF36-40-1-4IN-L-RP',N'Port',N'Reduced Port'),
  (N'VF36-40-1-4IN-LL-FP',N'Size',N'1/4"'),(N'VF36-40-1-4IN-LL-FP',N'Ball Configuration',N'LL port'),(N'VF36-40-1-4IN-LL-FP',N'Port',N'Full Port'),
  (N'VF36-40-1-4IN-LL-RP',N'Size',N'1/4"'),(N'VF36-40-1-4IN-LL-RP',N'Ball Configuration',N'LL port'),(N'VF36-40-1-4IN-LL-RP',N'Port',N'Reduced Port'),
  (N'VF36-40-1-4IN-T-FP',N'Size',N'1/4"'),(N'VF36-40-1-4IN-T-FP',N'Ball Configuration',N'T port'),(N'VF36-40-1-4IN-T-FP',N'Port',N'Full Port'),
  (N'VF36-40-1-4IN-T-RP',N'Size',N'1/4"'),(N'VF36-40-1-4IN-T-RP',N'Ball Configuration',N'T port'),(N'VF36-40-1-4IN-T-RP',N'Port',N'Reduced Port'),
  (N'VF36-40-3-8IN-L-FP',N'Size',N'3/8"'),(N'VF36-40-3-8IN-L-FP',N'Ball Configuration',N'L port'),(N'VF36-40-3-8IN-L-FP',N'Port',N'Full Port'),
  (N'VF36-40-3-8IN-L-RP',N'Size',N'3/8"'),(N'VF36-40-3-8IN-L-RP',N'Ball Configuration',N'L port'),(N'VF36-40-3-8IN-L-RP',N'Port',N'Reduced Port'),
  (N'VF36-40-3-8IN-LL-FP',N'Size',N'3/8"'),(N'VF36-40-3-8IN-LL-FP',N'Ball Configuration',N'LL port'),(N'VF36-40-3-8IN-LL-FP',N'Port',N'Full Port'),
  (N'VF36-40-3-8IN-LL-RP',N'Size',N'3/8"'),(N'VF36-40-3-8IN-LL-RP',N'Ball Configuration',N'LL port'),(N'VF36-40-3-8IN-LL-RP',N'Port',N'Reduced Port'),
  (N'VF36-40-3-8IN-T-FP',N'Size',N'3/8"'),(N'VF36-40-3-8IN-T-FP',N'Ball Configuration',N'T port'),(N'VF36-40-3-8IN-T-FP',N'Port',N'Full Port'),
  (N'VF36-40-3-8IN-T-RP',N'Size',N'3/8"'),(N'VF36-40-3-8IN-T-RP',N'Ball Configuration',N'T port'),(N'VF36-40-3-8IN-T-RP',N'Port',N'Reduced Port'),
  (N'VF36-40-1-2IN-L-FP',N'Size',N'1/2"'),(N'VF36-40-1-2IN-L-FP',N'Ball Configuration',N'L port'),(N'VF36-40-1-2IN-L-FP',N'Port',N'Full Port'),
  (N'VF36-40-1-2IN-L-RP',N'Size',N'1/2"'),(N'VF36-40-1-2IN-L-RP',N'Ball Configuration',N'L port'),(N'VF36-40-1-2IN-L-RP',N'Port',N'Reduced Port'),
  (N'VF36-40-1-2IN-LL-FP',N'Size',N'1/2"'),(N'VF36-40-1-2IN-LL-FP',N'Ball Configuration',N'LL port'),(N'VF36-40-1-2IN-LL-FP',N'Port',N'Full Port'),
  (N'VF36-40-1-2IN-LL-RP',N'Size',N'1/2"'),(N'VF36-40-1-2IN-LL-RP',N'Ball Configuration',N'LL port'),(N'VF36-40-1-2IN-LL-RP',N'Port',N'Reduced Port'),
  (N'VF36-40-1-2IN-T-FP',N'Size',N'1/2"'),(N'VF36-40-1-2IN-T-FP',N'Ball Configuration',N'T port'),(N'VF36-40-1-2IN-T-FP',N'Port',N'Full Port'),
  (N'VF36-40-1-2IN-T-RP',N'Size',N'1/2"'),(N'VF36-40-1-2IN-T-RP',N'Ball Configuration',N'T port'),(N'VF36-40-1-2IN-T-RP',N'Port',N'Reduced Port'),
  (N'VF36-40-3-4IN-L-FP',N'Size',N'3/4"'),(N'VF36-40-3-4IN-L-FP',N'Ball Configuration',N'L port'),(N'VF36-40-3-4IN-L-FP',N'Port',N'Full Port'),
  (N'VF36-40-3-4IN-L-RP',N'Size',N'3/4"'),(N'VF36-40-3-4IN-L-RP',N'Ball Configuration',N'L port'),(N'VF36-40-3-4IN-L-RP',N'Port',N'Reduced Port'),
  (N'VF36-40-3-4IN-LL-FP',N'Size',N'3/4"'),(N'VF36-40-3-4IN-LL-FP',N'Ball Configuration',N'LL port'),(N'VF36-40-3-4IN-LL-FP',N'Port',N'Full Port'),
  (N'VF36-40-3-4IN-LL-RP',N'Size',N'3/4"'),(N'VF36-40-3-4IN-LL-RP',N'Ball Configuration',N'LL port'),(N'VF36-40-3-4IN-LL-RP',N'Port',N'Reduced Port'),
  (N'VF36-40-3-4IN-T-FP',N'Size',N'3/4"'),(N'VF36-40-3-4IN-T-FP',N'Ball Configuration',N'T port'),(N'VF36-40-3-4IN-T-FP',N'Port',N'Full Port'),
  (N'VF36-40-3-4IN-T-RP',N'Size',N'3/4"'),(N'VF36-40-3-4IN-T-RP',N'Ball Configuration',N'T port'),(N'VF36-40-3-4IN-T-RP',N'Port',N'Reduced Port'),
  (N'VF36-40-1IN-L-FP',N'Size',N'1"'),(N'VF36-40-1IN-L-FP',N'Ball Configuration',N'L port'),(N'VF36-40-1IN-L-FP',N'Port',N'Full Port'),
  (N'VF36-40-1IN-L-RP',N'Size',N'1"'),(N'VF36-40-1IN-L-RP',N'Ball Configuration',N'L port'),(N'VF36-40-1IN-L-RP',N'Port',N'Reduced Port'),
  (N'VF36-40-1IN-LL-FP',N'Size',N'1"'),(N'VF36-40-1IN-LL-FP',N'Ball Configuration',N'LL port'),(N'VF36-40-1IN-LL-FP',N'Port',N'Full Port'),
  (N'VF36-40-1IN-LL-RP',N'Size',N'1"'),(N'VF36-40-1IN-LL-RP',N'Ball Configuration',N'LL port'),(N'VF36-40-1IN-LL-RP',N'Port',N'Reduced Port'),
  (N'VF36-40-1IN-T-FP',N'Size',N'1"'),(N'VF36-40-1IN-T-FP',N'Ball Configuration',N'T port'),(N'VF36-40-1IN-T-FP',N'Port',N'Full Port'),
  (N'VF36-40-1IN-T-RP',N'Size',N'1"'),(N'VF36-40-1IN-T-RP',N'Ball Configuration',N'T port'),(N'VF36-40-1IN-T-RP',N'Port',N'Reduced Port'),
  (N'VF36-40-1-1-4IN-L-FP',N'Size',N'1 1/4"'),(N'VF36-40-1-1-4IN-L-FP',N'Ball Configuration',N'L port'),(N'VF36-40-1-1-4IN-L-FP',N'Port',N'Full Port'),
  (N'VF36-40-1-1-4IN-L-RP',N'Size',N'1 1/4"'),(N'VF36-40-1-1-4IN-L-RP',N'Ball Configuration',N'L port'),(N'VF36-40-1-1-4IN-L-RP',N'Port',N'Reduced Port'),
  (N'VF36-40-1-1-4IN-LL-FP',N'Size',N'1 1/4"'),(N'VF36-40-1-1-4IN-LL-FP',N'Ball Configuration',N'LL port'),(N'VF36-40-1-1-4IN-LL-FP',N'Port',N'Full Port'),
  (N'VF36-40-1-1-4IN-LL-RP',N'Size',N'1 1/4"'),(N'VF36-40-1-1-4IN-LL-RP',N'Ball Configuration',N'LL port'),(N'VF36-40-1-1-4IN-LL-RP',N'Port',N'Reduced Port'),
  (N'VF36-40-1-1-4IN-T-FP',N'Size',N'1 1/4"'),(N'VF36-40-1-1-4IN-T-FP',N'Ball Configuration',N'T port'),(N'VF36-40-1-1-4IN-T-FP',N'Port',N'Full Port'),
  (N'VF36-40-1-1-4IN-T-RP',N'Size',N'1 1/4"'),(N'VF36-40-1-1-4IN-T-RP',N'Ball Configuration',N'T port'),(N'VF36-40-1-1-4IN-T-RP',N'Port',N'Reduced Port'),
  (N'VF36-40-1-1-2IN-L-FP',N'Size',N'1 1/2"'),(N'VF36-40-1-1-2IN-L-FP',N'Ball Configuration',N'L port'),(N'VF36-40-1-1-2IN-L-FP',N'Port',N'Full Port'),
  (N'VF36-40-1-1-2IN-L-RP',N'Size',N'1 1/2"'),(N'VF36-40-1-1-2IN-L-RP',N'Ball Configuration',N'L port'),(N'VF36-40-1-1-2IN-L-RP',N'Port',N'Reduced Port'),
  (N'VF36-40-1-1-2IN-LL-FP',N'Size',N'1 1/2"'),(N'VF36-40-1-1-2IN-LL-FP',N'Ball Configuration',N'LL port'),(N'VF36-40-1-1-2IN-LL-FP',N'Port',N'Full Port'),
  (N'VF36-40-1-1-2IN-LL-RP',N'Size',N'1 1/2"'),(N'VF36-40-1-1-2IN-LL-RP',N'Ball Configuration',N'LL port'),(N'VF36-40-1-1-2IN-LL-RP',N'Port',N'Reduced Port'),
  (N'VF36-40-1-1-2IN-T-FP',N'Size',N'1 1/2"'),(N'VF36-40-1-1-2IN-T-FP',N'Ball Configuration',N'T port'),(N'VF36-40-1-1-2IN-T-FP',N'Port',N'Full Port'),
  (N'VF36-40-1-1-2IN-T-RP',N'Size',N'1 1/2"'),(N'VF36-40-1-1-2IN-T-RP',N'Ball Configuration',N'T port'),(N'VF36-40-1-1-2IN-T-RP',N'Port',N'Reduced Port'),
  (N'VF36-40-2IN-L-FP',N'Size',N'2"'),(N'VF36-40-2IN-L-FP',N'Ball Configuration',N'L port'),(N'VF36-40-2IN-L-FP',N'Port',N'Full Port'),
  (N'VF36-40-2IN-L-RP',N'Size',N'2"'),(N'VF36-40-2IN-L-RP',N'Ball Configuration',N'L port'),(N'VF36-40-2IN-L-RP',N'Port',N'Reduced Port'),
  (N'VF36-40-2IN-LL-FP',N'Size',N'2"'),(N'VF36-40-2IN-LL-FP',N'Ball Configuration',N'LL port'),(N'VF36-40-2IN-LL-FP',N'Port',N'Full Port'),
  (N'VF36-40-2IN-LL-RP',N'Size',N'2"'),(N'VF36-40-2IN-LL-RP',N'Ball Configuration',N'LL port'),(N'VF36-40-2IN-LL-RP',N'Port',N'Reduced Port'),
  (N'VF36-40-2IN-T-FP',N'Size',N'2"'),(N'VF36-40-2IN-T-FP',N'Ball Configuration',N'T port'),(N'VF36-40-2IN-T-FP',N'Port',N'Full Port'),
  (N'VF36-40-2IN-T-RP',N'Size',N'2"'),(N'VF36-40-2IN-T-RP',N'Ball Configuration',N'T port'),(N'VF36-40-2IN-T-RP',N'Port',N'Reduced Port')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;

SELECT COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
