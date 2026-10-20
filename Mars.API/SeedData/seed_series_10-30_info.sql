-- Series 10-30 series row. Run from file (SSMS: File > Open > Execute). Run BEFORE the products file.
-- Quote-only series (no prices). Catalog = series-10-20.pdf (shared series 10/20).
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 10-30')
    INSERT INTO Categories
        (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures)
    VALUES (
        N'Series 10-30',
        N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf',
        N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf',
        N'The Mars Series 10-30 is a one-piece, reduced-port ball valve with threaded ends, rated to 800 PSI. CF8M stainless steel body with a PTFE seat, in sizes 1/4" to 1".',
        N'CF8M Stainless Steel',
        N'PTFE',
        N'One Piece, Reduced Port, Threaded Ends',
        N'One-piece reduced port design
Threaded ends (NPT, BSP, BSPT)
Rated to 800 PSI
CF8M stainless steel body
PTFE seat
Size 1/4" to 1"'
    );

SELECT CategoryId, Name, CatalogUrl, BodyMaterial, SeatMaterial, Design
FROM Categories WHERE Name = N'Series 10-30';
