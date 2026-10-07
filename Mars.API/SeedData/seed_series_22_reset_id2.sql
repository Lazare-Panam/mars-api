-- Renumber Series 22 to CategoryId = 2. Run from file (SSMS: File > Open > Execute).
-- ASSUMES CategoryId 2 is free. If another category already uses id 2, this will
-- fail at the INSERT -- tell me and we pick a different approach.

-- 1. Remove existing Series 22 data, FK-safe order (values -> products -> filters -> category).
DELETE pfv FROM ProductFilterValues pfv
  JOIN Categories c ON pfv.CategoryId = c.CategoryId WHERE c.Name = N'Series 22';
DELETE p FROM CatalogProducts p
  JOIN Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = N'Series 22';
DELETE cf FROM CategoryFilters cf
  JOIN Categories c ON cf.CategoryId = c.CategoryId WHERE c.Name = N'Series 22';
DELETE FROM Categories WHERE Name = N'Series 22';

-- 2. Re-insert the Series 22 category forced to CategoryId 2.
SET IDENTITY_INSERT Categories ON;
INSERT INTO Categories
    (CategoryId, Name, CatalogUrl, DatasheetUrl, Description, BodyMaterial, SeatMaterial,
     Design, TemperatureRange, Approvals, KeyFeatures)
VALUES (
    2,
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
SET IDENTITY_INSERT Categories OFF;

SELECT CategoryId, Name FROM Categories WHERE Name = N'Series 22';
