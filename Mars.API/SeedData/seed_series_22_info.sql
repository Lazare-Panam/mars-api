-- Series 22 — insert the series row. Run from file (SSMS: File > Open > Execute).
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 22')
    INSERT INTO Categories
        (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial,
         Design, TemperatureRange, Approvals, KeyFeatures)
    VALUES (
        N'Series 22',
        N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series_22.pdf',
        N'https://pblol2.blob.core.windows.net/mars-valves/catalogs/series_22.pdf',
        N'Our Mars Ball Valve Series 22 Full Bore Direct Mount is a non-maintainable two piece, full bore ball valve with an ISO 5211 mounting top; providing safe operation for both general and industrial chemical applications. A reliable valve with Stainless Steel body and PTFE seat. The ISO mounting top allows an actuator to be directly mounted to the valve, simplifying the assembly process when compared to conventional mounting brackets. Features a blow-out proof stem and insulated grip, lockable lever handle.',
        N'Stainless Steel',
        N'PTFE',
        N'2 Piece, Full Bore, Female x Female',
        N'-20°C to +180°C',
        N'ATEX',
        N'Available in Screwed BSP or NPT, sizes 1/4" to 3"
Temperature range: -20°C to +180°C
Operating pressure: 1000 PSI
Movement: 90° turn
ATEX approved
Investment cast with low torque
ISO 5211 direct mount top for actuation'
    );

SELECT CategoryId, Name, BodyMaterial, SeatMaterial, Design, TemperatureRange, Approvals, DatasheetUrl
FROM Categories WHERE Name = N'Series 22';
