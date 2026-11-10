SET SAFETY OFF
SET RESOURCE OFF
SET EXACT ON
LOCAL loc_cOut, loc_nItem, loc_cLocal, loc_cCol
loc_cOut = ""

CREATE CURSOR cDest (cItens N(10,0), Locals C(10), Localos C(10))
INSERT INTO cDest VALUES (1, "", "")
INSERT INTO cDest VALUES (2, "", "")
INSERT INTO cDest VALUES (3, "", "")

loc_nItem  = 2
loc_cLocal = "0102030004"
loc_cCol   = "Locals"

UPDATE cDest SET &loc_cCol. = m.loc_cLocal WHERE cItens = m.loc_nItem
loc_cOut = loc_cOut + "UPDATE (macro col + memvar) _TALLY = " + TRANSFORM(_TALLY) + CHR(13) + CHR(10)
SELECT cDest
LOCATE FOR cItens = 2
loc_cOut = loc_cOut + "  linha 2 Locals = [" + cDest.Locals + "]" + CHR(13) + CHR(10)

*-- item que nao existe
loc_nItem = 99
UPDATE cDest SET &loc_cCol. = m.loc_cLocal WHERE cItens = m.loc_nItem
loc_cOut = loc_cOut + "UPDATE sem match          _TALLY = " + TRANSFORM(_TALLY) + CHR(13) + CHR(10)

*-- coluna Localos (ramo ORIGEM)
loc_cCol  = "Localos"
loc_nItem = 3
UPDATE cDest SET &loc_cCol. = m.loc_cLocal WHERE cItens = m.loc_nItem
loc_cOut = loc_cOut + "UPDATE Localos            _TALLY = " + TRANSFORM(_TALLY) + CHR(13) + CHR(10)
LOCATE FOR cItens = 3
loc_cOut = loc_cOut + "  linha 3 Localos = [" + cDest.Localos + "]" + CHR(13) + CHR(10)

*-- DELETE FROM com SET DELETED ON + COUNT
SET DELETED ON
CREATE CURSOR cIt (Marcas N(1), Cpros C(14))
INSERT INTO cIt VALUES (1, "AAA")
INSERT INTO cIt VALUES (0, "BBB")
INSERT INTO cIt VALUES (1, "CCC")
DELETE FROM cIt WHERE Marcas <> 0
loc_cOut = loc_cOut + "DELETE FROM _TALLY = " + TRANSFORM(_TALLY) + ;
    "  RECCOUNT=" + TRANSFORM(RECCOUNT("cIt"))
SELECT cIt
COUNT TO loc_nVis
loc_cOut = loc_cOut + "  COUNT visiveis=" + TRANSFORM(loc_nVis) + CHR(13) + CHR(10)

STRTOFILE(loc_cOut, "C:\4c\automation\medir_tally_update.txt")
QUIT
