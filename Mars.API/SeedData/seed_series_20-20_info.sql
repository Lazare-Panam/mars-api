-- Series 20-20 series row. Run from file (SSMS: File > Open > Execute). Run BEFORE the products file.
-- Catalog = series-10-20.pdf (shared by all series-10 and series-20 valves).
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 20-20')
    INSERT INTO Categories
        (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures)
    VALUES (
        N'Series 20-20',
        N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf',
        N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf',
        N'The Mars Series 20-20 is a two-piece, full-bore ball valve with threaded ends, rated to 1000 PSI. Body and caps are CF8M stainless steel (WCB option) with PTFE/RTFE seats.',
        N'CF8M Stainless Steel',
        N'PTFE',
        N'Two Piece, Full Port, Threaded Ends',
        N'Two-piece full port construction
Threaded ends, size 1/4" to 3"
Rated to 1000 PSI
Body and caps in CF8M stainless steel (WCB option)
PTFE / RTFE seats
Ends available in NPT, BSP and BSPP
Available with or without a locking handle'
    );

SELECT CategoryId, Name, CatalogUrl, BodyMaterial, SeatMaterial, Design
FROM Categories WHERE Name = N'Series 20-20';
