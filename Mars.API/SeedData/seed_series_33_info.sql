-- Series 33 series row. Run from file (SSMS: File > Open > Execute). Run BEFORE the products file.
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 33')
    INSERT INTO Categories
        (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures)
    VALUES (
        N'Series 33',
        N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/Series_33.pdf',
        N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/Series_33.pdf',
        N'The Mars Series 33 (V33-123) is a 3-way, full-port ball valve with an ISO 5211 mounting pad for actuation, available in L-port and T-port from 1/4" to 4". Body and end caps are CF8M stainless steel with a reinforced PTFE seat.',
        N'CF8M Stainless Steel',
        N'Reinforced PTFE',
        N'Three-Way, Full Port, ISO 5211 Direct Mount, L/T Port',
        N'3-way full port design
L-port and T-port configurations
ISO 5211 direct mount pad for actuation
Size 1/4" to 4"
Body and end caps in CF8M stainless steel
Reinforced PTFE seat
Ends: Flanged, Threaded, Socket Weld, Butt Weld
Flange ratings ANSI Class 150 / Class 300 / PN16/40
Available bare shaft or with handle'
    );

SELECT CategoryId, Name, CatalogUrl, BodyMaterial, SeatMaterial, Design
FROM Categories WHERE Name = N'Series 33';
