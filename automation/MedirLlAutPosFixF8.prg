*==============================================================================
* MedirLlAutPosFixF8.prg - confere o llAut DEPOIS do fix no fRecalculaS:
*   - a chamada do SIGPRRSS (pAut = .T.) passa a dar llAut = .T. (igual legado)
*   - as chamadas de 2/3 argumentos continuam com llAut = .F. (sem regressao)
*   - a chamada legada com OBJETO em pCta continua funcionando
* Compila tambem o functions.prg (arquivo compartilhado).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cOut, loc_cFn
loc_cOut = "C:\4c\automation\medir_llaut_posfix.txt"
loc_cFn  = "C:\4c\projeto\app\utils\functions.prg"
STRTOFILE("INICIO", loc_cOut)

IF FILE(STRTRAN(loc_cFn, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(loc_cFn, ".prg", ".fxp"))
ENDIF
IF FILE(STRTRAN(loc_cFn, ".prg", ".err"))
    DELETE FILE (STRTRAN(loc_cFn, ".prg", ".err"))
ENDIF
COMPILE (loc_cFn)
STRTOFILE(CHR(13)+CHR(10)+"functions.prg FXP=" + ;
    IIF(FILE(STRTRAN(loc_cFn,".prg",".fxp")),"SIM","NAO") + ;
    " ERR=" + IIF(FILE(STRTRAN(loc_cFn,".prg",".err")),"SIM","NAO"), loc_cOut, 1)
IF FILE(STRTRAN(loc_cFn, ".prg", ".err"))
    STRTOFILE(CHR(13)+CHR(10)+FILETOSTR(STRTRAN(loc_cFn,".prg",".err")), loc_cOut, 1)
ENDIF

LOCAL loc_oConn
loc_oConn = CREATEOBJECT("Empty")
STRTOFILE(CHR(13)+CHR(10)+"SIGPRRSS (pAut=.T.)  -> " + ;
    SondaAut2(.T., 1, .T., .F., .F., .T.), loc_cOut, 1)
STRTOFILE(CHR(13)+CHR(10)+"3 args    (pAut aus) -> " + ;
    SondaAut2(.T., 1, .T.), loc_cOut, 1)
STRTOFILE(CHR(13)+CHR(10)+"2 args    (pAut aus) -> " + ;
    SondaAut2(.T., 1), loc_cOut, 1)
STRTOFILE(CHR(13)+CHR(10)+"LEGADO    (objeto)   -> " + ;
    SondaAut2(.T., loc_oConn, .T., .F., .F., .T.), loc_cOut, 1)
STRTOFILE(CHR(13)+CHR(10)+"REGISTRO  (pGru=C)   -> " + ;
    SondaAut2("GRP", 1, DATE(), "BRL", 1), loc_cOut, 1)

STRTOFILE(CHR(13)+CHR(10)+"FIM", loc_cOut, 1)
QUIT

*-- replica EXATA do bloco de resolucao JA COM o ELSE novo
FUNCTION SondaAut2(pGru, pCta, pDat, pMoe, pCnx, pAut)
    LOCAL llAut
    llAut = .F.
    IF (TYPE([pCta]) = [O])
        IF (TYPE([pDat]) <> [O])
            llAut = pDat
        ENDIF
    ELSE
        IF (TYPE([pAut]) = [L])
            llAut = pAut
        ENDIF
    ENDIF
    RETURN "TYPE(pCta)=[" + TYPE([pCta]) + "] pAut=" + TRANSFORM(pAut) + ;
           " => llAut=" + TRANSFORM(llAut)
ENDFUNC
