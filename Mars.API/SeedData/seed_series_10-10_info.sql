-- Series 10-10 series row. Run from file (SSMS: File > Open > Execute). Run BEFORE the products file.
-- Catalog = series-10-20.pdf (shared by all series-10 and series-20 valves).
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 10-10')
    INSERT INTO Categories
        (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures)
    VALUES (
        N'Series 10-10',
        N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf',
        N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series-10-20.pdf',
        N'The Mars Series 10-10 is a one-piece unibody, reduced-bore ball valve with threaded ends, rated to 800 PSI. Body, ball and stem are SS316 stainless steel with a PTFE seat.',
        N'SS316 Stainless Steel',
        N'PTFE',
        N'One Piece, Unibody, Reduced Bore, Threaded Ends',
        N'One-piece unibody construction
Reduced bore, threaded ends
Rated to 800 PSI
Body, ball and stem in SS316 stainless steel
PTFE seat
Available with or without a locking handle'
    );

SELECT CategoryId, Name, CatalogUrl, BodyMaterial, SeatMaterial, Design
FROM Categories WHERE Name = N'Series 10-10';
