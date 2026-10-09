-- Series 50 series row. Run from file (SSMS: File > Open > Execute). Run BEFORE the products file.
-- No catalog PDF supplied, so CatalogUrl / DatasheetUrl are left NULL.
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 50')
    INSERT INTO Categories
        (Name, Description, BodyMaterial, SeatMaterial, Design, TemperatureRange, Approvals, KeyFeatures)
    VALUES (
        N'Series 50',
        N'The Mars Series 50 is a 3-piece, full-bore, fully maintainable ball valve with a blow-out proof stem and lockable lever handle. SS316 / CF8M body with steam-rated carbon-filled R-PTFE seats, for shut-off and isolation of low-temperature steam duty and medium flows. Screwed BSP, NPT, Socket Weld or Butt Weld ends, 1/4" to 4". Manual operation only.',
        N'SS316 / CF8M Stainless Steel',
        N'Carbon Filled R-PTFE / PTFE',
        N'Three Piece, Full Bore, Female x Female',
        N'-20°C to +200°C',
        N'General / Industrial / Process, High Temperature',
        N'3-piece full bore, fully maintainable in-line
Blow-out proof stem
Steam rated carbon-filled R-PTFE seats
Insulated grip, lockable manual lever handle, 90° turn
Ends: BSP, NPT, Socket Weld, Butt Weld
Size 1/4" to 4"
1000 PSI (1/4" to 2"), 800 PSI (2 1/2" to 4")
Temperature -20°C to +200°C
Manual operation only'
    );

SELECT CategoryId, Name, BodyMaterial, SeatMaterial, Design
FROM Categories WHERE Name = N'Series 50';
