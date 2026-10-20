-- Series 83 series row. Run from file (SSMS: File > Open > Execute). Run BEFORE the products file.
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 83')
    INSERT INTO Categories
        (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, Approvals, KeyFeatures)
    VALUES (
        N'Series 83',
        N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/SERIES_83.pdf',
        N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/SERIES_83.pdf',
        N'The Mars Series 83 is a 3-piece, heavy-duty fire-safe ball valve with fully enclosed body bolting (1/4" to 1 1/2"), an ISO 5211 mounting pad and a standard anti-static device. CF8M or WCB body with PTFE/RTFE seats, full or reduced port, 1/4" to 2 1/2". Rated 2000 PSI (1/4"-1" full bore) and 1500 PSI (1 1/4"-2" full bore).',
        N'CF8M / WCB',
        N'PTFE / RTFE',
        N'Three Piece, Fire-Safe, Full / Reduced Port',
        N'Fire-Safe API 607, Anti-static',
        N'3-piece heavy duty fire-safe design
Full port and reduced port options
CF8M or WCB body
PTFE / RTFE seats
Body bolting fully enclosed (1/4" to 1 1/2")
ISO 5211 mounting pad for actuation
Anti-static device standard
Size 1/4" to 2 1/2"
2000 PSI (1/4"-1" FB), 1500 PSI (1 1/4"-2" FB)
Fire-safe certified'
    );

SELECT CategoryId, Name, CatalogUrl, BodyMaterial, SeatMaterial, Design
FROM Categories WHERE Name = N'Series 83';
