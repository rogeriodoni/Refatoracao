* CompilarF8SigOpLop764.prg
* Compila FormSigOpLop.prg (Fase 8) e grava o veredito num arquivo, porque
* .FXP presente e exit=0 nao provam execucao por si (ver smoke test da sessao).
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cForm, loc_cFxp, loc_cErr, loc_cSaida, loc_cTxt

loc_cForm  = "C:\4c\projeto\app\forms\operacionais\FormSigOpLop.prg"
loc_cFxp   = STRTRAN(loc_cForm, ".prg", ".fxp")
loc_cErr   = STRTRAN(loc_cForm, ".prg", ".err")
loc_cSaida = "C:\4c\automation\_f8_764_compile.txt"

IF FILE(loc_cFxp)
    DELETE FILE (loc_cFxp)
ENDIF
IF FILE(loc_cErr)
    DELETE FILE (loc_cErr)
ENDIF
IF FILE(loc_cSaida)
    DELETE FILE (loc_cSaida)
ENDIF

COMPILE (loc_cForm)

loc_cTxt = "FORM FXP=" + IIF(FILE(loc_cFxp), "SIM", "NAO") + ;
           " | ERR=" + IIF(FILE(loc_cErr), "SIM", "NAO") + CHR(13) + CHR(10)

IF FILE(loc_cErr)
    loc_cTxt = loc_cTxt + FILETOSTR(loc_cErr) + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cTxt, loc_cSaida)

QUIT
