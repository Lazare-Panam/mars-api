-- Series 77 series row. Run from file (SSMS: File > Open > Execute). Run BEFORE the products file.
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 77')
    INSERT INTO Categories
        (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, TemperatureRange, Approvals, KeyFeatures)
    VALUES (
        N'Series 77',
        N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/SERIES_77.pdf',
        N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/SERIES_77.pdf',
        N'The Mars Series 77 is a 3-piece, full-bore high performance ball valve with an ISO 5211 direct mount pad for actuation. Investment cast CF8M / WCB body with reinforced PTFE seats, a swing-out body for in-line maintenance and live-loaded stem packing. Screwed BSP, NPT, Socket Weld or Butt Weld ends, 1/4" to 4".',
        N'CF8M / WCB Stainless Steel',
        N'Reinforced PTFE / PTFE',
        N'Three Piece, Full Bore, Direct Mount, Female x Female',
        N'-20°C to 200°C',
        N'ATEX',
        N'3-piece full bore direct mount design
Fully maintainable, swing-out body for in-line service
Live loaded stem packing compensates for wear
ISO 5211 direct mount pad for actuation
Investment cast with low torque
Lockable manual lever handle, 90° turn
Ends: BSP, NPT, Socket Weld, Butt Weld
Size 1/4" to 4"
Rated to 1000 PSI, -20°C to 200°C
ATEX approved'
    );

SELECT CategoryId, Name, CatalogUrl, BodyMaterial, SeatMaterial, Design
FROM Categories WHERE Name = N'Series 77';
