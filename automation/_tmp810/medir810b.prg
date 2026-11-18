SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cOut, loc_nUnit
loc_nUnit = FONTMETRIC(6, "Tahoma", 8, "")
loc_cOut = "unitTahoma8=" + TRANSFORM(loc_nUnit) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "STR(99999,5)=[" + STR(99999,5) + "] px=" + TRANSFORM(TXTWIDTH(STR(99999,5), "Tahoma", 8, "") * loc_nUnit) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "PERC=[" + TRANSFORM(9999.99, "@Z 9999.99%") + "] px=" + TRANSFORM(TXTWIDTH(TRANSFORM(9999.99, "@Z 9999.99%"), "Tahoma", 8, "") * loc_nUnit) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "PERCZERO=[" + TRANSFORM(0, "@Z 9999.99%") + "]" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "Lido px=" + TRANSFORM(TXTWIDTH("Lido :", "Tahoma", 8, "") * loc_nUnit) + " SCXdiz=28" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "Estoque px=" + TRANSFORM(TXTWIDTH("Estoque :", "Tahoma", 8, "") * loc_nUnit) + " SCXdiz=48" + CHR(13) + CHR(10)
= STRTOFILE(loc_cOut, "C:\4c\automation\_tmp810\medir810b.txt")
QUIT
