* CompilarF6SigOpLcl757.prg
* Compila FormSigOpLcl.prg + SigOpLclBO.prg (Fase 6) sem executar.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_i, loc_cArq, loc_nArqs
LOCAL ARRAY loc_aArqs[2]

loc_aArqs[1] = "C:\4c\projeto\app\forms\operacionais\FormSigOpLcl.prg"
loc_aArqs[2] = "C:\4c\projeto\app\classes\SigOpLclBO.prg"
loc_nArqs    = 2

FOR loc_i = 1 TO loc_nArqs
    loc_cArq = loc_aArqs[loc_i]
    IF FILE(STRTRAN(loc_cArq, ".prg", ".fxp"))
        DELETE FILE (STRTRAN(loc_cArq, ".prg", ".fxp"))
    ENDIF
    IF FILE(STRTRAN(loc_cArq, ".prg", ".err"))
        DELETE FILE (STRTRAN(loc_cArq, ".prg", ".err"))
    ENDIF
    COMPILE (loc_cArq)
ENDFOR

QUIT
