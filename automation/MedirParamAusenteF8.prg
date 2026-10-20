*==============================================================================
* MedirParamAusenteF8.prg - mede, no VFP9 real:
*  (1) TYPE() e valor de parametro NAO passado
*  (2) o llAut de fRecalculaS com a chamada LEGADA (objeto em pCta) vs a
*      chamada MIGRADA (handle numerico em pCta)
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cOut
loc_cOut = "C:\4c\automation\medir_param_f8.txt"
STRTOFILE("INICIO", loc_cOut)

*-- (1) parametro ausente
STRTOFILE(CHR(13)+CHR(10)+"--- (1) parametro ausente ---", loc_cOut, 1)
STRTOFILE(CHR(13)+CHR(10)+SondaParam(.T., .T.), loc_cOut, 1)
STRTOFILE(CHR(13)+CHR(10)+SondaParam(.T.), loc_cOut, 1)

*-- (2) replica EXATA do trecho de resolucao de llAut do fRecalculaS
STRTOFILE(CHR(13)+CHR(10)+"--- (2) llAut: legado (objeto) x migrado (handle) ---", loc_cOut, 1)
LOCAL loc_oConn
loc_oConn = CREATEOBJECT("Empty")
STRTOFILE(CHR(13)+CHR(10)+"LEGADO  pCta=objeto  -> " + ;
    SondaAut(.T., loc_oConn, .T., .F., .F., .T.), loc_cOut, 1)
STRTOFILE(CHR(13)+CHR(10)+"MIGRADO pCta=numero  -> " + ;
    SondaAut(.T., 1, .T., .F., .F., .T.), loc_cOut, 1)
STRTOFILE(CHR(13)+CHR(10)+"OUTROS  3 args       -> " + ;
    SondaAut(.T., 1, .T.), loc_cOut, 1)

STRTOFILE(CHR(13)+CHR(10)+"FIM", loc_cOut, 1)
QUIT

FUNCTION SondaParam(pA, pB)
    RETURN "PCOUNT=" + TRANSFORM(PCOUNT()) + ;
           " TYPE(pB)=[" + TYPE([pB]) + "]" + ;
           " valor=[" + TRANSFORM(pB) + "]"
ENDFUNC

FUNCTION SondaAut(pGru, pCta, pDat, pMoe, pCnx, pAut)
    LOCAL llAut
    llAut = .F.
    IF (TYPE([pCta]) = [O])
        IF (TYPE([pDat]) <> [O])
            llAut = pDat
        ENDIF
    ENDIF
    RETURN "TYPE(pCta)=[" + TYPE([pCta]) + "]" + ;
           " llAut=" + TRANSFORM(llAut) + ;
           " TYPE(pAut)=[" + TYPE([pAut]) + "]" + ;
           " pAut=" + TRANSFORM(pAut)
ENDFUNC
