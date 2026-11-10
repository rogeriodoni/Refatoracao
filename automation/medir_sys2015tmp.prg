SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cOut, loc_o
loc_cOut = ""
loc_o = CREATEOBJECT("Empty")
ADDPROPERTY(loc_o, "cCodEmpresa", "01")
TRY
    loc_cOut = loc_cOut + "leitura Sys2015Tmp = [" + TRANSFORM(loc_o.Sys2015Tmp) + "]" + CHR(13) + CHR(10)
CATCH TO loE
    loc_cOut = loc_cOut + "leitura Sys2015Tmp -> ERRO: " + loE.Message + CHR(13) + CHR(10)
ENDTRY
loc_cOut = loc_cOut + "PEMSTATUS(Sys2015Tmp,5) = " + TRANSFORM(PEMSTATUS(loc_o, "Sys2015Tmp", 5)) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "TYPE(o.Sys2015Tmp) = [" + TYPE("loc_o.Sys2015Tmp") + "]" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, "C:\4c\automation\medir_sys2015tmp.txt")
QUIT
