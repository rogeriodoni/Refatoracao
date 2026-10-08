*==============================================================================
* MedirParensVaziosLparameters.prg - complemento de
* MedirProcParensLparameters.prg: PROCEDURE Nome() com parenteses VAZIOS
* mais LPARAMETERS eh seguro, ou estoura igual ao caso com parametro
* declarado nas duas formas?
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_o, loc_oErro, loc_cLog
loc_cLog = "C:\4c\automation\logs\medir_parens_vazios.txt"
IF FILE(loc_cLog)
    DELETE FILE (loc_cLog)
ENDIF

loc_o = CREATEOBJECT("ClsMedir2")

TRY
    Grava2(loc_cLog, "F ParensVaziosComLparameters(7): " + ;
        TRANSFORM(loc_o.ParensVaziosComLparameters(7)))
CATCH TO loc_oErro
    Grava2(loc_cLog, "F FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
ENDTRY

TRY
    Grava2(loc_cLog, "G ParensVaziosComLparameters() sem arg: " + ;
        TRANSFORM(loc_o.ParensVaziosComLparameters()))
CATCH TO loc_oErro
    Grava2(loc_cLog, "G FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
ENDTRY

TRY
    Grava2(loc_cLog, "H ParensVaziosDoisLparameters(13, 0): " + ;
        TRANSFORM(loc_o.ParensVaziosDoisLparameters(13, 0)))
CATCH TO loc_oErro
    Grava2(loc_cLog, "H FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
ENDTRY

QUIT

PROCEDURE Grava2(par_cArq, par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), par_cArq, 1)
ENDPROC

DEFINE CLASS ClsMedir2 AS Custom

    PROCEDURE ParensVaziosComLparameters()
        LPARAMETERS par_n
        RETURN IIF(VARTYPE(par_n) = "N", par_n * 10, -1)
    ENDPROC

    PROCEDURE ParensVaziosDoisLparameters()
        LPARAMETERS par_nA, par_nB
        RETURN IIF(VARTYPE(par_nA) = "N", par_nA * 100 + NVL(par_nB, 0), -1)
    ENDPROC

ENDDEFINE
