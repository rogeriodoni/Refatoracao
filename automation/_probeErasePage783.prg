SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cOut, loc_oForm, loc_oErro
loc_cOut = ""
loc_oForm = CREATEOBJECT("Form")
loc_oForm.AddObject("pgf1", "PageFrame")
loc_cOut = loc_cOut + "PEMSTATUS(pgf,ErasePage,5)=" + TRANSFORM(PEMSTATUS(loc_oForm.pgf1, "ErasePage", 5)) + CHR(13) + CHR(10)
TRY
    loc_oForm.pgf1.ErasePage = .T.
    loc_cOut = loc_cOut + "ATRIB_PGF=OK valor=" + TRANSFORM(loc_oForm.pgf1.ErasePage) + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "ATRIB_PGF=ERRO " + loc_oErro.Message + CHR(13) + CHR(10)
ENDTRY
TRY
    loc_cOut = loc_cOut + "LEITURA_PAGE1=" + TRANSFORM(loc_oForm.pgf1.Page1.ErasePage) + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "LEITURA_PAGE1=ERRO " + loc_oErro.Message + CHR(13) + CHR(10)
ENDTRY
STRTOFILE(loc_cOut, "C:\4c\automation\_probeErasePage783.txt")
QUIT
