-- Series 30M (3-way flanged trunnion SIL3, quote-only Price NULL). Run from file (SSMS). Self-cleaning + category upsert on re-run.
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 30M')
    INSERT INTO Categories (Name, Description, BodyMaterial, SeatMaterial, Design, Approvals, KeyFeatures)
    VALUES (N'Series 30M', N'The Mars Series 30M is a 3-way flanged trunnion-mounted SIL3-capable ball valve rated ANSI Class 150/300, PN10/16 and PN25/40, full port, with L/T-port ball, sizes 1 1/2" to 6". CF8M or WCB body with PTFE/RTFE seats standard (other seat options on request).', N'CF8M / WCB', N'PTFE / RTFE', N'Three-Way, Flanged, Trunnion, Full Port, SIL3', NULL, N'3-way flanged trunnion design
SIL3 capable
Full port
Flange ratings: ANSI #150/#300, PN10/16, PN25/40
Ball configuration: L port, T port
CF8M / WCB body
PTFE / RTFE seats standard; other seat options on request
Size 1 1/2" to 6"');

-- Refresh text fields unconditionally so edits land even when the row already exists.
UPDATE Categories SET
    Description = N'The Mars Series 30M is a 3-way flanged trunnion-mounted SIL3-capable ball valve rated ANSI Class 150/300, PN10/16 and PN25/40, full port, with L/T-port ball, sizes 1 1/2" to 6". CF8M or WCB body with PTFE/RTFE seats standard (other seat options on request).',
    BodyMaterial = N'CF8M / WCB',
    SeatMaterial = N'PTFE / RTFE',
    Design = N'Three-Way, Flanged, Trunnion, Full Port, SIL3',
    KeyFeatures = N'3-way flanged trunnion design
SIL3 capable
Full port
Flange ratings: ANSI #150/#300, PN10/16, PN25/40
Ball configuration: L port, T port
CF8M / WCB body
PTFE / RTFE seats standard; other seat options on request
Size 1 1/2" to 6"'
WHERE Name = N'Series 30M';

DECLARE @SeriesName nvarchar(100) = N'Series 30M';
DECLARE @CategoryId int = (SELECT CategoryId FROM Categories WHERE Name = @SeriesName);

-- Idempotent: clear any prior rows for this series so re-running always yields a clean set.
DELETE FROM ProductFilterValues WHERE CategoryId = @CategoryId;
DELETE FROM CatalogProducts WHERE CategoryId = @CategoryId;
DELETE FROM CategoryFilters WHERE CategoryId = @CategoryId;

INSERT INTO Filters (Name) SELECT v.Name FROM (VALUES (N'Flange Rating'),(N'Size'),(N'Ball Configuration')) AS v(Name)
WHERE NOT EXISTS (SELECT 1 FROM Filters f WHERE f.Name = v.Name);

INSERT INTO CategoryFilters (CategoryId, FilterId, SortOrder)
SELECT @CategoryId, f.FilterId, v.SortOrder FROM (VALUES (N'Flange Rating',0),(N'Size',1),(N'Ball Configuration',2)) AS v(FilterName, SortOrder)
JOIN Filters f ON f.Name = v.FilterName WHERE NOT EXISTS (SELECT 1 FROM CategoryFilters cf WHERE cf.CategoryId=@CategoryId AND cf.FilterId=f.FilterId);

INSERT INTO CatalogProducts (PartNumber, CategoryId, ProductStatus, FamilyDescription, DetailDescription, ImageUrl, Price) VALUES
(N'V30M-ANSI-150-1-1-2IN-L', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, ANSI #150, 1 1/2", L port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-ANSI-150-1-1-2IN-T', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, ANSI #150, 1 1/2", T port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-ANSI-150-2IN-L', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, ANSI #150, 2", L port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-ANSI-150-2IN-T', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, ANSI #150, 2", T port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-ANSI-150-2-1-2IN-L', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, ANSI #150, 2 1/2", L port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-ANSI-150-2-1-2IN-T', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, ANSI #150, 2 1/2", T port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-ANSI-150-3IN-L', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, ANSI #150, 3", L port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-ANSI-150-3IN-T', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, ANSI #150, 3", T port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-ANSI-150-4IN-L', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, ANSI #150, 4", L port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-ANSI-150-4IN-T', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, ANSI #150, 4", T port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-ANSI-150-6IN-L', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, ANSI #150, 6", L port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-ANSI-150-6IN-T', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, ANSI #150, 6", T port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-ANSI-300-1-1-2IN-L', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, ANSI #300, 1 1/2", L port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-ANSI-300-1-1-2IN-T', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, ANSI #300, 1 1/2", T port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-ANSI-300-2IN-L', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, ANSI #300, 2", L port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-ANSI-300-2IN-T', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, ANSI #300, 2", T port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-ANSI-300-2-1-2IN-L', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, ANSI #300, 2 1/2", L port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-ANSI-300-2-1-2IN-T', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, ANSI #300, 2 1/2", T port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-ANSI-300-3IN-L', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, ANSI #300, 3", L port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-ANSI-300-3IN-T', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, ANSI #300, 3", T port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-ANSI-300-4IN-L', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, ANSI #300, 4", L port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-ANSI-300-4IN-T', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, ANSI #300, 4", T port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-ANSI-300-6IN-L', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, ANSI #300, 6", L port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-ANSI-300-6IN-T', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, ANSI #300, 6", T port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-PN10-16-1-1-2IN-L', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, PN10/16, 1 1/2", L port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-PN10-16-1-1-2IN-T', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, PN10/16, 1 1/2", T port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-PN10-16-2IN-L', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, PN10/16, 2", L port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-PN10-16-2IN-T', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, PN10/16, 2", T port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-PN10-16-2-1-2IN-L', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, PN10/16, 2 1/2", L port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-PN10-16-2-1-2IN-T', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, PN10/16, 2 1/2", T port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-PN10-16-3IN-L', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, PN10/16, 3", L port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-PN10-16-3IN-T', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, PN10/16, 3", T port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-PN10-16-4IN-L', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, PN10/16, 4", L port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-PN10-16-4IN-T', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, PN10/16, 4", T port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-PN10-16-6IN-L', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, PN10/16, 6", L port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-PN10-16-6IN-T', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, PN10/16, 6", T port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-PN25-40-1-1-2IN-L', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, PN25/40, 1 1/2", L port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-PN25-40-1-1-2IN-T', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, PN25/40, 1 1/2", T port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-PN25-40-2IN-L', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, PN25/40, 2", L port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-PN25-40-2IN-T', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, PN25/40, 2", T port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-PN25-40-2-1-2IN-L', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, PN25/40, 2 1/2", L port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-PN25-40-2-1-2IN-T', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, PN25/40, 2 1/2", T port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-PN25-40-3IN-L', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, PN25/40, 3", L port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-PN25-40-3IN-T', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, PN25/40, 3", T port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-PN25-40-4IN-L', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, PN25/40, 4", L port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-PN25-40-4IN-T', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, PN25/40, 4", T port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-PN25-40-6IN-L', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, PN25/40, 6", L port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL),
(N'V30M-PN25-40-6IN-T', @CategoryId, N'Active', N'Series 30M', N'V30M - Three-Way, Flanged, Trunnion, Full Port, SIL3, PN25/40, 6", T port, Body CF8M / WCB, Seat PTFE / RTFE', N'https://pblol2.blob.core.windows.net/mars-valves/mars%20series%20images/three-four-five-way-ball-valve/series-30m.jpg', NULL);

INSERT INTO ProductFilterValues (ProductId, CategoryId, FilterId, Value)
SELECT p.ProductId, p.CategoryId, f.FilterId, v.Value FROM CatalogProducts p
JOIN (VALUES
  (N'V30M-ANSI-150-1-1-2IN-L',N'Flange Rating',N'ANSI #150'),(N'V30M-ANSI-150-1-1-2IN-L',N'Size',N'1 1/2"'),(N'V30M-ANSI-150-1-1-2IN-L',N'Ball Configuration',N'L port'),
  (N'V30M-ANSI-150-1-1-2IN-T',N'Flange Rating',N'ANSI #150'),(N'V30M-ANSI-150-1-1-2IN-T',N'Size',N'1 1/2"'),(N'V30M-ANSI-150-1-1-2IN-T',N'Ball Configuration',N'T port'),
  (N'V30M-ANSI-150-2IN-L',N'Flange Rating',N'ANSI #150'),(N'V30M-ANSI-150-2IN-L',N'Size',N'2"'),(N'V30M-ANSI-150-2IN-L',N'Ball Configuration',N'L port'),
  (N'V30M-ANSI-150-2IN-T',N'Flange Rating',N'ANSI #150'),(N'V30M-ANSI-150-2IN-T',N'Size',N'2"'),(N'V30M-ANSI-150-2IN-T',N'Ball Configuration',N'T port'),
  (N'V30M-ANSI-150-2-1-2IN-L',N'Flange Rating',N'ANSI #150'),(N'V30M-ANSI-150-2-1-2IN-L',N'Size',N'2 1/2"'),(N'V30M-ANSI-150-2-1-2IN-L',N'Ball Configuration',N'L port'),
  (N'V30M-ANSI-150-2-1-2IN-T',N'Flange Rating',N'ANSI #150'),(N'V30M-ANSI-150-2-1-2IN-T',N'Size',N'2 1/2"'),(N'V30M-ANSI-150-2-1-2IN-T',N'Ball Configuration',N'T port'),
  (N'V30M-ANSI-150-3IN-L',N'Flange Rating',N'ANSI #150'),(N'V30M-ANSI-150-3IN-L',N'Size',N'3"'),(N'V30M-ANSI-150-3IN-L',N'Ball Configuration',N'L port'),
  (N'V30M-ANSI-150-3IN-T',N'Flange Rating',N'ANSI #150'),(N'V30M-ANSI-150-3IN-T',N'Size',N'3"'),(N'V30M-ANSI-150-3IN-T',N'Ball Configuration',N'T port'),
  (N'V30M-ANSI-150-4IN-L',N'Flange Rating',N'ANSI #150'),(N'V30M-ANSI-150-4IN-L',N'Size',N'4"'),(N'V30M-ANSI-150-4IN-L',N'Ball Configuration',N'L port'),
  (N'V30M-ANSI-150-4IN-T',N'Flange Rating',N'ANSI #150'),(N'V30M-ANSI-150-4IN-T',N'Size',N'4"'),(N'V30M-ANSI-150-4IN-T',N'Ball Configuration',N'T port'),
  (N'V30M-ANSI-150-6IN-L',N'Flange Rating',N'ANSI #150'),(N'V30M-ANSI-150-6IN-L',N'Size',N'6"'),(N'V30M-ANSI-150-6IN-L',N'Ball Configuration',N'L port'),
  (N'V30M-ANSI-150-6IN-T',N'Flange Rating',N'ANSI #150'),(N'V30M-ANSI-150-6IN-T',N'Size',N'6"'),(N'V30M-ANSI-150-6IN-T',N'Ball Configuration',N'T port'),
  (N'V30M-ANSI-300-1-1-2IN-L',N'Flange Rating',N'ANSI #300'),(N'V30M-ANSI-300-1-1-2IN-L',N'Size',N'1 1/2"'),(N'V30M-ANSI-300-1-1-2IN-L',N'Ball Configuration',N'L port'),
  (N'V30M-ANSI-300-1-1-2IN-T',N'Flange Rating',N'ANSI #300'),(N'V30M-ANSI-300-1-1-2IN-T',N'Size',N'1 1/2"'),(N'V30M-ANSI-300-1-1-2IN-T',N'Ball Configuration',N'T port'),
  (N'V30M-ANSI-300-2IN-L',N'Flange Rating',N'ANSI #300'),(N'V30M-ANSI-300-2IN-L',N'Size',N'2"'),(N'V30M-ANSI-300-2IN-L',N'Ball Configuration',N'L port'),
  (N'V30M-ANSI-300-2IN-T',N'Flange Rating',N'ANSI #300'),(N'V30M-ANSI-300-2IN-T',N'Size',N'2"'),(N'V30M-ANSI-300-2IN-T',N'Ball Configuration',N'T port'),
  (N'V30M-ANSI-300-2-1-2IN-L',N'Flange Rating',N'ANSI #300'),(N'V30M-ANSI-300-2-1-2IN-L',N'Size',N'2 1/2"'),(N'V30M-ANSI-300-2-1-2IN-L',N'Ball Configuration',N'L port'),
  (N'V30M-ANSI-300-2-1-2IN-T',N'Flange Rating',N'ANSI #300'),(N'V30M-ANSI-300-2-1-2IN-T',N'Size',N'2 1/2"'),(N'V30M-ANSI-300-2-1-2IN-T',N'Ball Configuration',N'T port'),
  (N'V30M-ANSI-300-3IN-L',N'Flange Rating',N'ANSI #300'),(N'V30M-ANSI-300-3IN-L',N'Size',N'3"'),(N'V30M-ANSI-300-3IN-L',N'Ball Configuration',N'L port'),
  (N'V30M-ANSI-300-3IN-T',N'Flange Rating',N'ANSI #300'),(N'V30M-ANSI-300-3IN-T',N'Size',N'3"'),(N'V30M-ANSI-300-3IN-T',N'Ball Configuration',N'T port'),
  (N'V30M-ANSI-300-4IN-L',N'Flange Rating',N'ANSI #300'),(N'V30M-ANSI-300-4IN-L',N'Size',N'4"'),(N'V30M-ANSI-300-4IN-L',N'Ball Configuration',N'L port'),
  (N'V30M-ANSI-300-4IN-T',N'Flange Rating',N'ANSI #300'),(N'V30M-ANSI-300-4IN-T',N'Size',N'4"'),(N'V30M-ANSI-300-4IN-T',N'Ball Configuration',N'T port'),
  (N'V30M-ANSI-300-6IN-L',N'Flange Rating',N'ANSI #300'),(N'V30M-ANSI-300-6IN-L',N'Size',N'6"'),(N'V30M-ANSI-300-6IN-L',N'Ball Configuration',N'L port'),
  (N'V30M-ANSI-300-6IN-T',N'Flange Rating',N'ANSI #300'),(N'V30M-ANSI-300-6IN-T',N'Size',N'6"'),(N'V30M-ANSI-300-6IN-T',N'Ball Configuration',N'T port'),
  (N'V30M-PN10-16-1-1-2IN-L',N'Flange Rating',N'PN10/16'),(N'V30M-PN10-16-1-1-2IN-L',N'Size',N'1 1/2"'),(N'V30M-PN10-16-1-1-2IN-L',N'Ball Configuration',N'L port'),
  (N'V30M-PN10-16-1-1-2IN-T',N'Flange Rating',N'PN10/16'),(N'V30M-PN10-16-1-1-2IN-T',N'Size',N'1 1/2"'),(N'V30M-PN10-16-1-1-2IN-T',N'Ball Configuration',N'T port'),
  (N'V30M-PN10-16-2IN-L',N'Flange Rating',N'PN10/16'),(N'V30M-PN10-16-2IN-L',N'Size',N'2"'),(N'V30M-PN10-16-2IN-L',N'Ball Configuration',N'L port'),
  (N'V30M-PN10-16-2IN-T',N'Flange Rating',N'PN10/16'),(N'V30M-PN10-16-2IN-T',N'Size',N'2"'),(N'V30M-PN10-16-2IN-T',N'Ball Configuration',N'T port'),
  (N'V30M-PN10-16-2-1-2IN-L',N'Flange Rating',N'PN10/16'),(N'V30M-PN10-16-2-1-2IN-L',N'Size',N'2 1/2"'),(N'V30M-PN10-16-2-1-2IN-L',N'Ball Configuration',N'L port'),
  (N'V30M-PN10-16-2-1-2IN-T',N'Flange Rating',N'PN10/16'),(N'V30M-PN10-16-2-1-2IN-T',N'Size',N'2 1/2"'),(N'V30M-PN10-16-2-1-2IN-T',N'Ball Configuration',N'T port'),
  (N'V30M-PN10-16-3IN-L',N'Flange Rating',N'PN10/16'),(N'V30M-PN10-16-3IN-L',N'Size',N'3"'),(N'V30M-PN10-16-3IN-L',N'Ball Configuration',N'L port'),
  (N'V30M-PN10-16-3IN-T',N'Flange Rating',N'PN10/16'),(N'V30M-PN10-16-3IN-T',N'Size',N'3"'),(N'V30M-PN10-16-3IN-T',N'Ball Configuration',N'T port'),
  (N'V30M-PN10-16-4IN-L',N'Flange Rating',N'PN10/16'),(N'V30M-PN10-16-4IN-L',N'Size',N'4"'),(N'V30M-PN10-16-4IN-L',N'Ball Configuration',N'L port'),
  (N'V30M-PN10-16-4IN-T',N'Flange Rating',N'PN10/16'),(N'V30M-PN10-16-4IN-T',N'Size',N'4"'),(N'V30M-PN10-16-4IN-T',N'Ball Configuration',N'T port'),
  (N'V30M-PN10-16-6IN-L',N'Flange Rating',N'PN10/16'),(N'V30M-PN10-16-6IN-L',N'Size',N'6"'),(N'V30M-PN10-16-6IN-L',N'Ball Configuration',N'L port'),
  (N'V30M-PN10-16-6IN-T',N'Flange Rating',N'PN10/16'),(N'V30M-PN10-16-6IN-T',N'Size',N'6"'),(N'V30M-PN10-16-6IN-T',N'Ball Configuration',N'T port'),
  (N'V30M-PN25-40-1-1-2IN-L',N'Flange Rating',N'PN25/40'),(N'V30M-PN25-40-1-1-2IN-L',N'Size',N'1 1/2"'),(N'V30M-PN25-40-1-1-2IN-L',N'Ball Configuration',N'L port'),
  (N'V30M-PN25-40-1-1-2IN-T',N'Flange Rating',N'PN25/40'),(N'V30M-PN25-40-1-1-2IN-T',N'Size',N'1 1/2"'),(N'V30M-PN25-40-1-1-2IN-T',N'Ball Configuration',N'T port'),
  (N'V30M-PN25-40-2IN-L',N'Flange Rating',N'PN25/40'),(N'V30M-PN25-40-2IN-L',N'Size',N'2"'),(N'V30M-PN25-40-2IN-L',N'Ball Configuration',N'L port'),
  (N'V30M-PN25-40-2IN-T',N'Flange Rating',N'PN25/40'),(N'V30M-PN25-40-2IN-T',N'Size',N'2"'),(N'V30M-PN25-40-2IN-T',N'Ball Configuration',N'T port'),
  (N'V30M-PN25-40-2-1-2IN-L',N'Flange Rating',N'PN25/40'),(N'V30M-PN25-40-2-1-2IN-L',N'Size',N'2 1/2"'),(N'V30M-PN25-40-2-1-2IN-L',N'Ball Configuration',N'L port'),
  (N'V30M-PN25-40-2-1-2IN-T',N'Flange Rating',N'PN25/40'),(N'V30M-PN25-40-2-1-2IN-T',N'Size',N'2 1/2"'),(N'V30M-PN25-40-2-1-2IN-T',N'Ball Configuration',N'T port'),
  (N'V30M-PN25-40-3IN-L',N'Flange Rating',N'PN25/40'),(N'V30M-PN25-40-3IN-L',N'Size',N'3"'),(N'V30M-PN25-40-3IN-L',N'Ball Configuration',N'L port'),
  (N'V30M-PN25-40-3IN-T',N'Flange Rating',N'PN25/40'),(N'V30M-PN25-40-3IN-T',N'Size',N'3"'),(N'V30M-PN25-40-3IN-T',N'Ball Configuration',N'T port'),
  (N'V30M-PN25-40-4IN-L',N'Flange Rating',N'PN25/40'),(N'V30M-PN25-40-4IN-L',N'Size',N'4"'),(N'V30M-PN25-40-4IN-L',N'Ball Configuration',N'L port'),
  (N'V30M-PN25-40-4IN-T',N'Flange Rating',N'PN25/40'),(N'V30M-PN25-40-4IN-T',N'Size',N'4"'),(N'V30M-PN25-40-4IN-T',N'Ball Configuration',N'T port'),
  (N'V30M-PN25-40-6IN-L',N'Flange Rating',N'PN25/40'),(N'V30M-PN25-40-6IN-L',N'Size',N'6"'),(N'V30M-PN25-40-6IN-L',N'Ball Configuration',N'L port'),
  (N'V30M-PN25-40-6IN-T',N'Flange Rating',N'PN25/40'),(N'V30M-PN25-40-6IN-T',N'Size',N'6"'),(N'V30M-PN25-40-6IN-T',N'Ball Configuration',N'T port')
) AS v(PartNumber, FilterName, Value) ON v.PartNumber = p.PartNumber
JOIN Filters f ON f.Name = v.FilterName WHERE p.CategoryId=@CategoryId;

SELECT COUNT(*) AS Products FROM CatalogProducts WHERE CategoryId=@CategoryId;
