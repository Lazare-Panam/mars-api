-- Series 38 (multi-port, quote-only Price NULL). Run from file (SSMS: File > Open > Execute).
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 38')
    INSERT INTO Categories (Name, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures)
    VALUES (N'Series 38',
        N'The Mars Series 38 is a 3-way threaded ball valve rated to 1000 PSI, reduced port, with L-port or T-port ball for diverting and mixing, in sizes 1/4" to 3". CF8M body with PTFE/RTFE seats; NPT, BSP or BSPT ends.',
        N'CF8M', N'PTFE / RTFE', N'3-Way Threaded Ball Valve',
        N'3-way threaded design
Reduced port
Ball configuration: L port, T port
Rated to 1000 PSI
CF8M body
PTFE / RTFE seats
Ends: NPT, BSP, BSPT
Size 1/4" to 3"');

DECLARE @SeriesName nvarchar(100) = N'Series 38';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);

INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'End Connection'),(N'Size'),(N'Ball Configuration')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);

INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'End Connection',0),(N'Size',1),(N'Ball Configuration',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);

INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'V38-NPT-1-4IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, NPT, 1/4", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-NPT-1-4IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, NPT, 1/4", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-NPT-3-8IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, NPT, 3/8", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-NPT-3-8IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, NPT, 3/8", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-NPT-1-2IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, NPT, 1/2", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-NPT-1-2IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, NPT, 1/2", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-NPT-3-4IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, NPT, 3/4", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-NPT-3-4IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, NPT, 3/4", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-NPT-1IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, NPT, 1", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-NPT-1IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, NPT, 1", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-NPT-1-1-4IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, NPT, 1 1/4", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-NPT-1-1-4IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, NPT, 1 1/4", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-NPT-1-1-2IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, NPT, 1 1/2", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-NPT-1-1-2IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, NPT, 1 1/2", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-NPT-2IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, NPT, 2", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-NPT-2IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, NPT, 2", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-NPT-2-1-2IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, NPT, 2 1/2", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-NPT-2-1-2IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, NPT, 2 1/2", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-NPT-3IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, NPT, 3", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-NPT-3IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, NPT, 3", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSP-1-4IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSP, 1/4", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSP-1-4IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSP, 1/4", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSP-3-8IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSP, 3/8", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSP-3-8IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSP, 3/8", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSP-1-2IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSP, 1/2", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSP-1-2IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSP, 1/2", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSP-3-4IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSP, 3/4", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSP-3-4IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSP, 3/4", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSP-1IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSP, 1", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSP-1IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSP, 1", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSP-1-1-4IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSP, 1 1/4", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSP-1-1-4IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSP, 1 1/4", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSP-1-1-2IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSP, 1 1/2", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSP-1-1-2IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSP, 1 1/2", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSP-2IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSP, 2", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSP-2IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSP, 2", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSP-2-1-2IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSP, 2 1/2", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSP-2-1-2IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSP, 2 1/2", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSP-3IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSP, 3", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSP-3IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSP, 3", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSPT-1-4IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSPT, 1/4", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSPT-1-4IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSPT, 1/4", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSPT-3-8IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSPT, 3/8", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSPT-3-8IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSPT, 3/8", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSPT-1-2IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSPT, 1/2", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSPT-1-2IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSPT, 1/2", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSPT-3-4IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSPT, 3/4", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSPT-3-4IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSPT, 3/4", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSPT-1IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSPT, 1", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSPT-1IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSPT, 1", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSPT-1-1-4IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSPT, 1 1/4", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSPT-1-1-4IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSPT, 1 1/4", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSPT-1-1-2IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSPT, 1 1/2", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSPT-1-1-2IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSPT, 1 1/2", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSPT-2IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSPT, 2", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSPT-2IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSPT, 2", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSPT-2-1-2IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSPT, 2 1/2", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSPT-2-1-2IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSPT, 2 1/2", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSPT-3IN-L', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSPT, 3", L port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL),
(N'V38-BSPT-3IN-T', @CategoryId, N'Active', N'Series 38', N'V38 - 3-Way Threaded Ball Valve, Reduced Port, BSPT, 3", T port, Body CF8M, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-way-multi-port-ball-valve/series-38.jpg', NULL);

INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'V38-NPT-1-4IN-L',N'End Connection',N'NPT'),(N'V38-NPT-1-4IN-L',N'Size',N'1/4"'),(N'V38-NPT-1-4IN-L',N'Ball Configuration',N'L port'),
  (N'V38-NPT-1-4IN-T',N'End Connection',N'NPT'),(N'V38-NPT-1-4IN-T',N'Size',N'1/4"'),(N'V38-NPT-1-4IN-T',N'Ball Configuration',N'T port'),
  (N'V38-NPT-3-8IN-L',N'End Connection',N'NPT'),(N'V38-NPT-3-8IN-L',N'Size',N'3/8"'),(N'V38-NPT-3-8IN-L',N'Ball Configuration',N'L port'),
  (N'V38-NPT-3-8IN-T',N'End Connection',N'NPT'),(N'V38-NPT-3-8IN-T',N'Size',N'3/8"'),(N'V38-NPT-3-8IN-T',N'Ball Configuration',N'T port'),
  (N'V38-NPT-1-2IN-L',N'End Connection',N'NPT'),(N'V38-NPT-1-2IN-L',N'Size',N'1/2"'),(N'V38-NPT-1-2IN-L',N'Ball Configuration',N'L port'),
  (N'V38-NPT-1-2IN-T',N'End Connection',N'NPT'),(N'V38-NPT-1-2IN-T',N'Size',N'1/2"'),(N'V38-NPT-1-2IN-T',N'Ball Configuration',N'T port'),
  (N'V38-NPT-3-4IN-L',N'End Connection',N'NPT'),(N'V38-NPT-3-4IN-L',N'Size',N'3/4"'),(N'V38-NPT-3-4IN-L',N'Ball Configuration',N'L port'),
  (N'V38-NPT-3-4IN-T',N'End Connection',N'NPT'),(N'V38-NPT-3-4IN-T',N'Size',N'3/4"'),(N'V38-NPT-3-4IN-T',N'Ball Configuration',N'T port'),
  (N'V38-NPT-1IN-L',N'End Connection',N'NPT'),(N'V38-NPT-1IN-L',N'Size',N'1"'),(N'V38-NPT-1IN-L',N'Ball Configuration',N'L port'),
  (N'V38-NPT-1IN-T',N'End Connection',N'NPT'),(N'V38-NPT-1IN-T',N'Size',N'1"'),(N'V38-NPT-1IN-T',N'Ball Configuration',N'T port'),
  (N'V38-NPT-1-1-4IN-L',N'End Connection',N'NPT'),(N'V38-NPT-1-1-4IN-L',N'Size',N'1 1/4"'),(N'V38-NPT-1-1-4IN-L',N'Ball Configuration',N'L port'),
  (N'V38-NPT-1-1-4IN-T',N'End Connection',N'NPT'),(N'V38-NPT-1-1-4IN-T',N'Size',N'1 1/4"'),(N'V38-NPT-1-1-4IN-T',N'Ball Configuration',N'T port'),
  (N'V38-NPT-1-1-2IN-L',N'End Connection',N'NPT'),(N'V38-NPT-1-1-2IN-L',N'Size',N'1 1/2"'),(N'V38-NPT-1-1-2IN-L',N'Ball Configuration',N'L port'),
  (N'V38-NPT-1-1-2IN-T',N'End Connection',N'NPT'),(N'V38-NPT-1-1-2IN-T',N'Size',N'1 1/2"'),(N'V38-NPT-1-1-2IN-T',N'Ball Configuration',N'T port'),
  (N'V38-NPT-2IN-L',N'End Connection',N'NPT'),(N'V38-NPT-2IN-L',N'Size',N'2"'),(N'V38-NPT-2IN-L',N'Ball Configuration',N'L port'),
  (N'V38-NPT-2IN-T',N'End Connection',N'NPT'),(N'V38-NPT-2IN-T',N'Size',N'2"'),(N'V38-NPT-2IN-T',N'Ball Configuration',N'T port'),
  (N'V38-NPT-2-1-2IN-L',N'End Connection',N'NPT'),(N'V38-NPT-2-1-2IN-L',N'Size',N'2 1/2"'),(N'V38-NPT-2-1-2IN-L',N'Ball Configuration',N'L port'),
  (N'V38-NPT-2-1-2IN-T',N'End Connection',N'NPT'),(N'V38-NPT-2-1-2IN-T',N'Size',N'2 1/2"'),(N'V38-NPT-2-1-2IN-T',N'Ball Configuration',N'T port'),
  (N'V38-NPT-3IN-L',N'End Connection',N'NPT'),(N'V38-NPT-3IN-L',N'Size',N'3"'),(N'V38-NPT-3IN-L',N'Ball Configuration',N'L port'),
  (N'V38-NPT-3IN-T',N'End Connection',N'NPT'),(N'V38-NPT-3IN-T',N'Size',N'3"'),(N'V38-NPT-3IN-T',N'Ball Configuration',N'T port'),
  (N'V38-BSP-1-4IN-L',N'End Connection',N'BSP'),(N'V38-BSP-1-4IN-L',N'Size',N'1/4"'),(N'V38-BSP-1-4IN-L',N'Ball Configuration',N'L port'),
  (N'V38-BSP-1-4IN-T',N'End Connection',N'BSP'),(N'V38-BSP-1-4IN-T',N'Size',N'1/4"'),(N'V38-BSP-1-4IN-T',N'Ball Configuration',N'T port'),
  (N'V38-BSP-3-8IN-L',N'End Connection',N'BSP'),(N'V38-BSP-3-8IN-L',N'Size',N'3/8"'),(N'V38-BSP-3-8IN-L',N'Ball Configuration',N'L port'),
  (N'V38-BSP-3-8IN-T',N'End Connection',N'BSP'),(N'V38-BSP-3-8IN-T',N'Size',N'3/8"'),(N'V38-BSP-3-8IN-T',N'Ball Configuration',N'T port'),
  (N'V38-BSP-1-2IN-L',N'End Connection',N'BSP'),(N'V38-BSP-1-2IN-L',N'Size',N'1/2"'),(N'V38-BSP-1-2IN-L',N'Ball Configuration',N'L port'),
  (N'V38-BSP-1-2IN-T',N'End Connection',N'BSP'),(N'V38-BSP-1-2IN-T',N'Size',N'1/2"'),(N'V38-BSP-1-2IN-T',N'Ball Configuration',N'T port'),
  (N'V38-BSP-3-4IN-L',N'End Connection',N'BSP'),(N'V38-BSP-3-4IN-L',N'Size',N'3/4"'),(N'V38-BSP-3-4IN-L',N'Ball Configuration',N'L port'),
  (N'V38-BSP-3-4IN-T',N'End Connection',N'BSP'),(N'V38-BSP-3-4IN-T',N'Size',N'3/4"'),(N'V38-BSP-3-4IN-T',N'Ball Configuration',N'T port'),
  (N'V38-BSP-1IN-L',N'End Connection',N'BSP'),(N'V38-BSP-1IN-L',N'Size',N'1"'),(N'V38-BSP-1IN-L',N'Ball Configuration',N'L port'),
  (N'V38-BSP-1IN-T',N'End Connection',N'BSP'),(N'V38-BSP-1IN-T',N'Size',N'1"'),(N'V38-BSP-1IN-T',N'Ball Configuration',N'T port'),
  (N'V38-BSP-1-1-4IN-L',N'End Connection',N'BSP'),(N'V38-BSP-1-1-4IN-L',N'Size',N'1 1/4"'),(N'V38-BSP-1-1-4IN-L',N'Ball Configuration',N'L port'),
  (N'V38-BSP-1-1-4IN-T',N'End Connection',N'BSP'),(N'V38-BSP-1-1-4IN-T',N'Size',N'1 1/4"'),(N'V38-BSP-1-1-4IN-T',N'Ball Configuration',N'T port'),
  (N'V38-BSP-1-1-2IN-L',N'End Connection',N'BSP'),(N'V38-BSP-1-1-2IN-L',N'Size',N'1 1/2"'),(N'V38-BSP-1-1-2IN-L',N'Ball Configuration',N'L port'),
  (N'V38-BSP-1-1-2IN-T',N'End Connection',N'BSP'),(N'V38-BSP-1-1-2IN-T',N'Size',N'1 1/2"'),(N'V38-BSP-1-1-2IN-T',N'Ball Configuration',N'T port'),
  (N'V38-BSP-2IN-L',N'End Connection',N'BSP'),(N'V38-BSP-2IN-L',N'Size',N'2"'),(N'V38-BSP-2IN-L',N'Ball Configuration',N'L port'),
  (N'V38-BSP-2IN-T',N'End Connection',N'BSP'),(N'V38-BSP-2IN-T',N'Size',N'2"'),(N'V38-BSP-2IN-T',N'Ball Configuration',N'T port'),
  (N'V38-BSP-2-1-2IN-L',N'End Connection',N'BSP'),(N'V38-BSP-2-1-2IN-L',N'Size',N'2 1/2"'),(N'V38-BSP-2-1-2IN-L',N'Ball Configuration',N'L port'),
  (N'V38-BSP-2-1-2IN-T',N'End Connection',N'BSP'),(N'V38-BSP-2-1-2IN-T',N'Size',N'2 1/2"'),(N'V38-BSP-2-1-2IN-T',N'Ball Configuration',N'T port'),
  (N'V38-BSP-3IN-L',N'End Connection',N'BSP'),(N'V38-BSP-3IN-L',N'Size',N'3"'),(N'V38-BSP-3IN-L',N'Ball Configuration',N'L port'),
  (N'V38-BSP-3IN-T',N'End Connection',N'BSP'),(N'V38-BSP-3IN-T',N'Size',N'3"'),(N'V38-BSP-3IN-T',N'Ball Configuration',N'T port'),
  (N'V38-BSPT-1-4IN-L',N'End Connection',N'BSPT'),(N'V38-BSPT-1-4IN-L',N'Size',N'1/4"'),(N'V38-BSPT-1-4IN-L',N'Ball Configuration',N'L port'),
  (N'V38-BSPT-1-4IN-T',N'End Connection',N'BSPT'),(N'V38-BSPT-1-4IN-T',N'Size',N'1/4"'),(N'V38-BSPT-1-4IN-T',N'Ball Configuration',N'T port'),
  (N'V38-BSPT-3-8IN-L',N'End Connection',N'BSPT'),(N'V38-BSPT-3-8IN-L',N'Size',N'3/8"'),(N'V38-BSPT-3-8IN-L',N'Ball Configuration',N'L port'),
  (N'V38-BSPT-3-8IN-T',N'End Connection',N'BSPT'),(N'V38-BSPT-3-8IN-T',N'Size',N'3/8"'),(N'V38-BSPT-3-8IN-T',N'Ball Configuration',N'T port'),
  (N'V38-BSPT-1-2IN-L',N'End Connection',N'BSPT'),(N'V38-BSPT-1-2IN-L',N'Size',N'1/2"'),(N'V38-BSPT-1-2IN-L',N'Ball Configuration',N'L port'),
  (N'V38-BSPT-1-2IN-T',N'End Connection',N'BSPT'),(N'V38-BSPT-1-2IN-T',N'Size',N'1/2"'),(N'V38-BSPT-1-2IN-T',N'Ball Configuration',N'T port'),
  (N'V38-BSPT-3-4IN-L',N'End Connection',N'BSPT'),(N'V38-BSPT-3-4IN-L',N'Size',N'3/4"'),(N'V38-BSPT-3-4IN-L',N'Ball Configuration',N'L port'),
  (N'V38-BSPT-3-4IN-T',N'End Connection',N'BSPT'),(N'V38-BSPT-3-4IN-T',N'Size',N'3/4"'),(N'V38-BSPT-3-4IN-T',N'Ball Configuration',N'T port'),
  (N'V38-BSPT-1IN-L',N'End Connection',N'BSPT'),(N'V38-BSPT-1IN-L',N'Size',N'1"'),(N'V38-BSPT-1IN-L',N'Ball Configuration',N'L port'),
  (N'V38-BSPT-1IN-T',N'End Connection',N'BSPT'),(N'V38-BSPT-1IN-T',N'Size',N'1"'),(N'V38-BSPT-1IN-T',N'Ball Configuration',N'T port'),
  (N'V38-BSPT-1-1-4IN-L',N'End Connection',N'BSPT'),(N'V38-BSPT-1-1-4IN-L',N'Size',N'1 1/4"'),(N'V38-BSPT-1-1-4IN-L',N'Ball Configuration',N'L port'),
  (N'V38-BSPT-1-1-4IN-T',N'End Connection',N'BSPT'),(N'V38-BSPT-1-1-4IN-T',N'Size',N'1 1/4"'),(N'V38-BSPT-1-1-4IN-T',N'Ball Configuration',N'T port'),
  (N'V38-BSPT-1-1-2IN-L',N'End Connection',N'BSPT'),(N'V38-BSPT-1-1-2IN-L',N'Size',N'1 1/2"'),(N'V38-BSPT-1-1-2IN-L',N'Ball Configuration',N'L port'),
  (N'V38-BSPT-1-1-2IN-T',N'End Connection',N'BSPT'),(N'V38-BSPT-1-1-2IN-T',N'Size',N'1 1/2"'),(N'V38-BSPT-1-1-2IN-T',N'Ball Configuration',N'T port'),
  (N'V38-BSPT-2IN-L',N'End Connection',N'BSPT'),(N'V38-BSPT-2IN-L',N'Size',N'2"'),(N'V38-BSPT-2IN-L',N'Ball Configuration',N'L port'),
  (N'V38-BSPT-2IN-T',N'End Connection',N'BSPT'),(N'V38-BSPT-2IN-T',N'Size',N'2"'),(N'V38-BSPT-2IN-T',N'Ball Configuration',N'T port'),
  (N'V38-BSPT-2-1-2IN-L',N'End Connection',N'BSPT'),(N'V38-BSPT-2-1-2IN-L',N'Size',N'2 1/2"'),(N'V38-BSPT-2-1-2IN-L',N'Ball Configuration',N'L port'),
  (N'V38-BSPT-2-1-2IN-T',N'End Connection',N'BSPT'),(N'V38-BSPT-2-1-2IN-T',N'Size',N'2 1/2"'),(N'V38-BSPT-2-1-2IN-T',N'Ball Configuration',N'T port'),
  (N'V38-BSPT-3IN-L',N'End Connection',N'BSPT'),(N'V38-BSPT-3IN-L',N'Size',N'3"'),(N'V38-BSPT-3IN-L',N'Ball Configuration',N'L port'),
  (N'V38-BSPT-3IN-T',N'End Connection',N'BSPT'),(N'V38-BSPT-3IN-T',N'Size',N'3"'),(N'V38-BSPT-3IN-T',N'Ball Configuration',N'T port')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;

SELECT COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
