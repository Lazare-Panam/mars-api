-- Series 99 series row. Run from file (SSMS: File > Open > Execute). Run BEFORE the products file.
IF NOT EXISTS (SELECT 1 FROM Categories WHERE Name = N'Series 99')
    INSERT INTO Categories
        (Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial, Design, Approvals, KeyFeatures)
    VALUES (
        N'Series 99',
        N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/99-catalog.pdf',
        N'https://pblol2.blob.core.windows.net/mars-valves/ball-valves/99-catalog.pdf',
        N'The Mars Series 99 is a 1-piece compact wafer ball valve (FIG 99-10 & 99-20) with full port and an ISO 5211 mounting pad for direct actuator mounting. CF8M body and ball with PTFE/RPTFE seats, in PN16/40 and PN25/40 flange ratings, 1/2" to 4".',
        N'CF8M',
        N'PTFE / RPTFE',
        N'One Piece, Compact Wafer, Full Port, Direct Mount',
        N'ISO 5211',
        N'1-piece compact wafer design
Full port
PN16/40 and PN25/40 flange ratings
ISO 5211 mounting pad for direct actuator mounting
CF8M body and ball
PTFE / RPTFE seats
Size 1/2" to 4"
Available with or without handle'
    );

SELECT CategoryId, Name, CatalogUrl, BodyMaterial, SeatMaterial, Design
FROM Categories WHERE Name = N'Series 99';
