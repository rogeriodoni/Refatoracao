*==============================================================================
* MedirIgualLogico.prg - o diagnostico do ProbeCim701F8 mostrou
* loc_lProt=.T. plEsperado=.T. e (loc_lExiste AND (loc_lProt = plEsperado)) = .F.
* Mede o operador "=" entre logicos, inclusive com um dos lados vindo de
* PARAMETRO e do retorno de PEMSTATUS.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET EXACT ON

#DEFINE SAI "C:\4c\automation\medir_igual_logico.txt"
STRTOFILE("=== operador = entre logicos ===" + CHR(13) + CHR(10), SAI)

LOCAL loc_lA, loc_lB, loc_oX
loc_lA = .T.
loc_lB = .T.

DO Lin WITH "literal .T. = .T.",            (.T. = .T.)
DO Lin WITH "local .T. = local .T.",        (loc_lA = loc_lB)
DO Lin WITH "local .T. = literal .T.",      (loc_lA = .T.)
DO Lin WITH "local .T. == local .T.",       (loc_lA == loc_lB)

*-- com um lado vindo de PEMSTATUS (o caso real do probe)
loc_oX = CREATEOBJECT("Custom")
loc_oX.AddProperty("teste", 1)
DO Lin WITH "PEMSTATUS(...,5) = .T.",       (PEMSTATUS(loc_oX, "teste", 5) = .T.)
DO Lin WITH "PEMSTATUS(...,2) = .F.",       (PEMSTATUS(loc_oX, "teste", 2) = .F.)

*-- com um lado vindo de PARAMETRO (forma exata do helper)
DO Par WITH .T., .T.
DO Par WITH .F., .F.
DO Par WITH .T., .F.

QUIT

PROCEDURE Lin(pcRotulo, plRes)
    STRTOFILE("   " + PADR(pcRotulo, 34) + " -> " + TRANSFORM(plRes) + CHR(13) + CHR(10), SAI, 1)
ENDPROC

PROCEDURE Par(plEsq, plDir)
    LOCAL loc_lIgual, loc_lIgualIdent
    loc_lIgual      = (plEsq = plDir)
    loc_lIgualIdent = (plEsq == plDir)
    STRTOFILE("   parametro " + TRANSFORM(plEsq) + " = parametro " + TRANSFORM(plDir) + ;
        "   ->  = devolve " + TRANSFORM(loc_lIgual) + ;
        "   == devolve " + TRANSFORM(loc_lIgualIdent) + CHR(13) + CHR(10), SAI, 1)
ENDPROC
