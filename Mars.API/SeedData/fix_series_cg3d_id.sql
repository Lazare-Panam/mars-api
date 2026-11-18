-- Fix: CG3D was seeded twice -- old name 'Series CG3D-10/20' (took id 71), then the
-- renamed 'Series CG3D-10/20/30' took the next id (72). This collapses them back to
-- ONE category at the ORIGINAL id (71): it removes the duplicate and renames the original.
--
-- Run this, THEN re-run seed_series_cg3d.sql (its self-cleaning will refresh the 33
-- products cleanly under the renamed category). Finally verify the id is what the
-- frontend expects.

-- 1. Remove the duplicate new-named category + all its rows.
DECLARE @dup int = (SELECT CategoryId FROM Categories WHERE Name = N'Series CG3D-10/20/30');
IF @dup IS NOT NULL
BEGIN
    DELETE FROM ProductFilterValues WHERE CategoryId = @dup;
    DELETE FROM CatalogProducts     WHERE CategoryId = @dup;
    DELETE FROM CategoryFilters      WHERE CategoryId = @dup;
    DELETE FROM Categories           WHERE CategoryId = @dup;
END

-- 2. Rename the ORIGINAL category to the correct designation (keeps its id).
UPDATE Categories SET Name = N'Series CG3D-10/20/30' WHERE Name = N'Series CG3D-10/20';

-- 3. Show where it landed (should be the original id, e.g. 71).
SELECT CategoryId, Name FROM Categories WHERE Name LIKE N'Series CG3D%';
