SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
LOCAL loc_cSaida, loc_cArq
loc_cSaida = ""

loc_cArq = "C:\4c\projeto\app\classes\SigOpEmbBO.prg"
IF FILE(STRTRAN(loc_cArq, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(loc_cArq, ".prg", ".fxp"))
ENDIF
COMPILE (loc_cArq)
loc_cSaida = loc_cSaida + "BO fxp=" + IIF(FILE(STRTRAN(loc_cArq,".prg",".fxp")),"SIM","NAO") + CHR(13)+CHR(10)
IF FILE("C:\4c\projeto\app\classes\SigOpEmbBO.err")
    loc_cSaida = loc_cSaida + "BO ERR:" + CHR(13)+CHR(10) + FILETOSTR("C:\4c\projeto\app\classes\SigOpEmbBO.err") + CHR(13)+CHR(10)
ELSE
    loc_cSaida = loc_cSaida + "BO ERR: nenhum" + CHR(13)+CHR(10)
ENDIF

loc_cArq = "C:\4c\projeto\app\forms\operacionais\FormSigOpEmb.prg"
IF FILE(STRTRAN(loc_cArq, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(loc_cArq, ".prg", ".fxp"))
ENDIF
COMPILE (loc_cArq)
loc_cSaida = loc_cSaida + "FORM fxp=" + IIF(FILE(STRTRAN(loc_cArq,".prg",".fxp")),"SIM","NAO") + CHR(13)+CHR(10)
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpEmb.err")
    loc_cSaida = loc_cSaida + "FORM ERR:" + CHR(13)+CHR(10) + FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigOpEmb.err") + CHR(13)+CHR(10)
ELSE
    loc_cSaida = loc_cSaida + "FORM ERR: nenhum" + CHR(13)+CHR(10)
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\CompileCheckEmb728F8.out")
QUIT
