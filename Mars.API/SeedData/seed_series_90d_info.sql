-- Series 90D series row. Run from file (SSMS: File > Open > Execute). Run BEFORE the products file.
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 90D')
    INSERT INTO Categories
        (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, Approvals, KeyFeatures)
    VALUES (
        N'Series 90D',
        N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/90d-catalog.pdf',
        N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/90d-catalog.pdf',
        N'The Mars Series 90D is a high-performance, direct-mount flanged ball valve with an ISO 5211 mounting pad. Full port, in ANSI #300 (2F), ANSI #150 (90D-10) and PN10/40 & PN16 (90D-40) flange ratings, stainless (CF8M) or carbon (WCB) body, standard or fire-safe, 1/2" to 6".',
        N'CF8M / WCB',
        N'PTFE / RTFE',
        N'Two Piece, Flanged, Full Port, Direct Mount',
        N'Fire-Safe, ISO 5211',
        N'High performance flanged ball valve, direct mount
Flange ratings: ANSI #300, ANSI #150, PN10/40 & PN16
Standard and fire-safe versions
Stainless (CF8M) or carbon (WCB) body
ISO 5211 mounting pad / DIN 3337 square stem
Full port
Size 1/2" to 6"
Available with or without handle'
    );

SELECT CategoryId, Name, CatalogUrl, BodyMaterial, SeatMaterial, Design
FROM Categories WHERE Name = N'Series 90D';
