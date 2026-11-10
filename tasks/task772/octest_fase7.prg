SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcS, loO, loE
lcS = "INICIO" + CHR(13) + CHR(10)
STRTOFILE(lcS, "C:\4c\tasks\task772\octest_fase7.txt")
TRY
    loO = CREATEOBJECT("cttree.cttreeview")
    lcS = lcS + "CREATEOBJECT=" + VARTYPE(loO) + CHR(13) + CHR(10)
CATCH TO loE
    lcS = lcS + "EXCECAO=" + loE.Message + CHR(13) + CHR(10)
ENDTRY
STRTOFILE(lcS, "C:\4c\tasks\task772\octest_fase7.txt")
QUIT
