*-- Mede se PADL(TRANSFORM(<coluna numerica>), 8, "0") produz o MESMO que
*-- PADL(<coluna numerica>, 8, "0") - o legado usa a 2a forma.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cOut
CREATE CURSOR probe (nDopes N(4,0), nBig N(8,0))
INSERT INTO probe (nDopes, nBig) VALUES (12, 12)

loc_cOut = ""
loc_cOut = loc_cOut + "TRANSFORM(nDopes)              = [" + TRANSFORM(probe.nDopes) + "]" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "PADL(TRANSFORM(nDopes),8,'0')  = [" + PADL(TRANSFORM(probe.nDopes), 8, "0") + "]" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "PADL(nDopes,8,'0')  (legado)   = [" + PADL(probe.nDopes, 8, "0") + "]" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "ALLTRIM(STR(nDopes))           = [" + ALLTRIM(STR(probe.nDopes)) + "]" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "PADL(ALLTRIM(STR(nDopes)),8,'0')=[" + PADL(ALLTRIM(STR(probe.nDopes)), 8, "0") + "]" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "IGUAIS? " + IIF(PADL(TRANSFORM(probe.nDopes), 8, "0") == PADL(probe.nDopes, 8, "0"), "SIM", "NAO") + CHR(13) + CHR(10)

STRTOFILE(loc_cOut, "C:\4c\tasks\task577\probe_transform.txt")
QUIT
