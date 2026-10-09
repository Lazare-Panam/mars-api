-- Series 20-40 rich content (from marsselect). Run from file (SSMS: File > Open > Execute).
UPDATE Categories
SET
  Description      = N'Our Mars Series 20-40, Full Bore Female / Female screwed ball valve is a non-maintainable heavy duty two piece, general isolating valve, providing safe operation for both general and industrial chemical applications. A reliable valve with CF8M Stainless Steel body and reinforced PTFE seat. Reinforced seat ensures tight ''shut-off'' and versatility over a wide range of media. Features a blow-out proof stem and insulated grip, lockable lever handle.',
  BodyMaterial     = N'Stainless Steel (CF8M)',
  SeatMaterial     = N'Reinforced PTFE',
  Design           = N'2 Piece, Full Bore, Female x Female',
  TemperatureRange = N'-20°C to +200°C',
  Approvals        = N'ATEX',
  DatasheetUrl     = N'https://pblol2.blob.core.windows.net/mars-valves/datasheets/BV5107.pdf',
  CertificatesJson = NULL,
  KeyFeatures      = N'Body and Ball in Stainless Steel
Screwed 1/4" to 2" BSP or NPT
Heavy duty, full bore, two piece
Available in Screwed BSP or NPT, sizes 1/4" to 2"
Temperature range: -20°C to +200°C
Operating pressure: 2000 PSI (1/4" to 1") and 1500 PSI (1 1/4" to 2")
Movement: 90° turn
Investment cast with low torque'
WHERE Name = N'Series 20-40';

SELECT CategoryId, Name, BodyMaterial, SeatMaterial, Design, TemperatureRange, Approvals, DatasheetUrl
FROM Categories WHERE Name = N'Series 20-40';
