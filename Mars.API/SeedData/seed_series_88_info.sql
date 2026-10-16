-- Series 88 series row. Run from file (SSMS: File > Open > Execute). Run BEFORE the products file.
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 88')
    INSERT INTO Categories
        (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, Approvals, KeyFeatures)
    VALUES (
        N'Series 88',
        N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/series-88.pdf',
        N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/series-88.pdf',
        N'The Mars Series 88 is a 3-piece, heavy-duty ball valve in standard and fire-safe versions, with fully enclosed body bolting, an ISO 5211 direct mounting pad and a standard anti-static device. CF8M or WCB body with PTFE/RPTFE seats, full or reduced port, flower or round end caps, 1/4" to 4". Rated 1000/2000 PSI.',
        N'CF8M / WCB',
        N'PTFE / RPTFE',
        N'Three Piece, Heavy Duty, Full / Reduced Port',
        N'Fire-Safe (FS version), Anti-static',
        N'3-piece heavy duty design, standard and fire-safe versions
Full port and reduced port options
Flower or round end caps
CF8M or WCB body
PTFE / RPTFE seats
Body bolting fully enclosed
ISO 5211 direct mounting pad for actuation
Anti-static device standard
Size 1/4" to 4"
1000/2000 PSI'
    );

SELECT CategoryId, Name, CatalogUrl, BodyMaterial, SeatMaterial, Design
FROM Categories WHERE Name = N'Series 88';
