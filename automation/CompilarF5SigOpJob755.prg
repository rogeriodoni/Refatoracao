* CompilarF5SigOpJob755.prg
* Compila FormSigOpJob.prg e SigOpJobBO.prg (Fase 5) sem executar.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cForm, loc_cBO, loc_nI, loc_cArq
DIMENSION laArq(2)
laArq(1) = "C:\4c\projeto\app\forms\operacionais\FormSigOpJob.prg"
laArq(2) = "C:\4c\projeto\app\classes\SigOpJobBO.prg"

FOR loc_nI = 1 TO 2
    loc_cArq = laArq(loc_nI)
    IF FILE(STRTRAN(loc_cArq, ".prg", ".fxp"))
        DELETE FILE (STRTRAN(loc_cArq, ".prg", ".fxp"))
    ENDIF
    IF FILE(STRTRAN(loc_cArq, ".prg", ".err"))
        DELETE FILE (STRTRAN(loc_cArq, ".prg", ".err"))
    ENDIF
    COMPILE (loc_cArq)
ENDFOR

QUIT
