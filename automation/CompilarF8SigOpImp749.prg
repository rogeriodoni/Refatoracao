* CompilarF8SigOpImp749.prg
* Compila FormSigOpImp.prg + SigOpImpBO.prg (Fase 8) sem executar - so sintaxe.
* Uso: vfp9.exe -t "C:\4c\automation\CompilarF8SigOpImp749.prg"
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_nI, loc_cArq
LOCAL ARRAY loc_aArq[2]
loc_aArq[1] = "C:\4c\projeto\app\forms\operacionais\FormSigOpImp.prg"
loc_aArq[2] = "C:\4c\projeto\app\classes\SigOpImpBO.prg"

FOR loc_nI = 1 TO 2
    loc_cArq = loc_aArq[loc_nI]
    IF FILE(STRTRAN(loc_cArq, ".prg", ".fxp"))
        DELETE FILE (STRTRAN(loc_cArq, ".prg", ".fxp"))
    ENDIF
    IF FILE(STRTRAN(loc_cArq, ".prg", ".err"))
        DELETE FILE (STRTRAN(loc_cArq, ".prg", ".err"))
    ENDIF
    COMPILE (loc_cArq)
ENDFOR

QUIT
