-- Series 36SN series row. Run from file (SSMS: File > Open > Execute). Run BEFORE the products file.
-- No catalog PDF available for 36SN, so CatalogUrl / DatasheetUrl are left NULL.
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 36SN')
    INSERT INTO Categories
        (Name, Description, BodyMaterial, SeatMaterial, Design, KeyFeatures)
    VALUES (
        N'Series 36SN',
        N'The Mars Series 36SN is an FDA-approved, 3-A certified sanitary 3-way / 4-way full-port ball valve with an ISO 5211 mounting pad for actuation. Investment cast CF8M (SS316) body with PTFE seats (cavity filler on request), in Tri-Clamp or OD tube ends from 1/2" to 4", rated to 1000 PSI max.',
        N'CF8M (SS316) Stainless Steel',
        N'PTFE (cavity filler on request)',
        N'Three-Way / Four-Way, Full Port, Sanitary, ISO 5211 Direct Mount',
        N'Sanitary 3-way / 4-way full port design
FDA approved, 3-A certified
ISO 5211 direct mount pad for actuation
Investment cast CF8M (SS316) body
PTFE seats, cavity filler on request
Tri-Clamp or OD tube ends
Size 1/2" to 4"
Rated to 1000 PSI max
Available bare shaft or with handle'
    );

SELECT CategoryId, Name, BodyMaterial, SeatMaterial, Design
FROM Categories WHERE Name = N'Series 36SN';
