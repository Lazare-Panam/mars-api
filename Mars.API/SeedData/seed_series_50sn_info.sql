-- Series 50SN series row. Run from file (SSMS: File > Open > Execute). Run BEFORE the products file.
-- No catalog PDF for 50SN, so CatalogUrl / DatasheetUrl are left NULL.
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 50SN')
    INSERT INTO Categories
        (Name, Description, BodyMaterial, SeatMaterial, Design, TemperatureRange, Approvals, KeyFeatures)
    VALUES (
        N'Series 50SN',
        N'The Mars Series 50SN is a 3-piece, full-bore hygienic manual ball valve with cavity-filled PTFE seats and a swing-out body for in-line maintenance. CF8M body and ball with CF3M end cap, live-loaded stem packing, Tri-Clamp or short-welding ends, 1/2" to 4". FDA compliant and suitable for CIP / SIP cleaning. Manual operation only.',
        N'CF8M Stainless Steel (CF3M end cap)',
        N'PTFE (cavity filler on request)',
        N'Three Piece, Full Bore, Sanitary',
        N'-20°C to 180°C',
        N'ATEX, Hygienic, FDA',
        N'3-piece full bore hygienic design, manual only
FDA compliant, suitable for CIP / SIP cleaning
Fully maintainable, swing-out body for in-line service
Live loaded stem packing compensates for wear
Insulated grip, lockable manual lever, 90° turn
Tri-Clamp or short-welding ends
Size 1/2" to 4"
1000 PSI (1/2" to 2"), 800 PSI (2 1/2" to 4")
Temperature -20°C to 180°C
ATEX / Hygienic approved'
    );

SELECT CategoryId, Name, BodyMaterial, SeatMaterial, Design
FROM Categories WHERE Name = N'Series 50SN';
