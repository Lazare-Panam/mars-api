-- Series 77SN series row. Run from file (SSMS: File > Open > Execute). Run BEFORE the products file.
-- No catalog PDF for 77SN, so CatalogUrl / DatasheetUrl are left NULL.
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 77SN')
    INSERT INTO Categories
        (Name, Description, BodyMaterial, SeatMaterial, Design, TemperatureRange, Approvals, KeyFeatures)
    VALUES (
        N'Series 77SN',
        N'The Mars Series 77SN is a 3-piece, full-bore high performance sanitary ball valve with an ISO 5211 direct mount pad for actuation. CF3M stainless steel body with cavity-filled PTFE seats, a swing-out body for in-line maintenance and live-loaded stem packing. Tri-Clamp or short-welding ends, 1/2" to 4". FDA compliant and suitable for CIP / SIP cleaning.',
        N'CF3M Stainless Steel',
        N'PTFE / RTFE (cavity filler on request)',
        N'Three Piece, Full Bore, Sanitary, Direct Mount',
        N'-20°C to 180°C',
        N'ATEX, Hygienic, FDA',
        N'3-piece full bore sanitary design
FDA compliant, suitable for CIP / SIP cleaning
Fully maintainable, swing-out body for in-line service
Live loaded stem packing compensates for wear
ISO 5211 direct mount pad for actuation
Tri-Clamp or short-welding ends
Size 1/2" to 4"
1000 PSI (1/2" to 2"), 800 PSI (2 1/2" to 4")
Temperature -20°C to 180°C
ATEX / Hygienic approved'
    );

SELECT CategoryId, Name, BodyMaterial, SeatMaterial, Design
FROM Categories WHERE Name = N'Series 77SN';
