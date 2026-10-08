*==============================================================================
* MedirProcParensLparameters.prg - mede no VFP9 se
*   PROCEDURE Nome(par)   +   LPARAMETERS par
* (parametros declarados DUAS vezes) funciona ou estoura em runtime.
*
* Motivo: o probe da Fase 6 do FormSigPrGlx acusou
*   "10 ALTERNARPAGINA FALHOU: Unrecognized command verb."
* e AlternarPagina usa exatamente esse par. Compila limpo.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_o, loc_oErro, loc_cLog
loc_cLog = "C:\4c\automation\logs\medir_parens_lparameters.txt"
IF FILE(loc_cLog)
    DELETE FILE (loc_cLog)
ENDIF

loc_o = CREATEOBJECT("ClsMedir")

*-- A: PROCEDURE com parenteses E LPARAMETERS (o par suspeito)
TRY
    Grava(loc_cLog, "A ComParensEComLparameters(7): " + TRANSFORM(loc_o.ComParensEComLparameters(7)))
CATCH TO loc_oErro
    Grava(loc_cLog, "A FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
ENDTRY

*-- B: PROCEDURE com parenteses, SEM LPARAMETERS
TRY
    Grava(loc_cLog, "B ComParensSemLparameters(7): " + TRANSFORM(loc_o.ComParensSemLparameters(7)))
CATCH TO loc_oErro
    Grava(loc_cLog, "B FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
ENDTRY

*-- C: PROCEDURE sem parenteses, COM LPARAMETERS (forma canonica)
TRY
    Grava(loc_cLog, "C SemParensComLparameters(7): " + TRANSFORM(loc_o.SemParensComLparameters(7)))
CATCH TO loc_oErro
    Grava(loc_cLog, "C FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
ENDTRY

*-- D: dois parametros, com parenteses E LPARAMETERS (caso dos handlers
*--    de KeyPress gerados pelo template do orquestrador)
TRY
    Grava(loc_cLog, "D DoisComParensEComLparameters(13, 0): " + ;
        TRANSFORM(loc_o.DoisComParensEComLparameters(13, 0)))
CATCH TO loc_oErro
    Grava(loc_cLog, "D FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
ENDTRY

*-- E: chamada SEM argumento em PROCEDURE com parens + LPARAMETERS
TRY
    Grava(loc_cLog, "E ComParensEComLparameters() sem arg: " + ;
        TRANSFORM(loc_o.ComParensEComLparameters()))
CATCH TO loc_oErro
    Grava(loc_cLog, "E FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
ENDTRY

QUIT

PROCEDURE Grava(par_cArq, par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), par_cArq, 1)
ENDPROC

DEFINE CLASS ClsMedir AS Custom

    PROCEDURE ComParensEComLparameters(par_n)
        LPARAMETERS par_n
        RETURN IIF(VARTYPE(par_n) = "N", par_n * 10, -1)
    ENDPROC

    PROCEDURE ComParensSemLparameters(par_n)
        RETURN IIF(VARTYPE(par_n) = "N", par_n * 10, -1)
    ENDPROC

    PROCEDURE SemParensComLparameters
        LPARAMETERS par_n
        RETURN IIF(VARTYPE(par_n) = "N", par_n * 10, -1)
    ENDPROC

    PROCEDURE DoisComParensEComLparameters(par_nA, par_nB)
        LPARAMETERS par_nA, par_nB
        RETURN IIF(VARTYPE(par_nA) = "N", par_nA * 100 + NVL(par_nB, 0), -1)
    ENDPROC

ENDDEFINE
