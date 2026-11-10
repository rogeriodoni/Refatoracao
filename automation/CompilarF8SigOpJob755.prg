* CompilarF8SigOpJob755.prg
* Compila FormSigOpJob.prg + SigOpJobBO.prg (Fase 8) sem executar -
* so para provar sintaxe. Apaga .fxp/.err ANTES (COMPILE pode nao
* reescrever um .fxp existente - regra #29).
* Uso: vfp9.exe -t "C:\4c\automation\CompilarF8SigOpJob755.prg"
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_nI, loc_cArq
LOCAL ARRAY loc_aArq[2]
loc_aArq[1] = "C:\4c\projeto\app\forms\operacionais\FormSigOpJob.prg"
loc_aArq[2] = "C:\4c\projeto\app\classes\SigOpJobBO.prg"

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
