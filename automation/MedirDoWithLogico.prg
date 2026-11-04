*==============================================================================
* MedirDoWithLogico.prg - o helper do ProbeCim701F8 reportou FALHA com
* protected=.T. e esperado=.T. O literal logico em "DO ... WITH" ja foi
* medido e chega certo (1a rodada). Agora mede a EXPRESSAO do helper:
* "DO Chk WITH <texto>, (A AND (B = C))" com continuacao de linha.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET EXACT ON

#DEFINE SAI "C:\4c\automation\medir_dowith_logico.txt"

STRTOFILE("=== DO ... WITH: expressao do helper ===" + CHR(13) + CHR(10), SAI)

LOCAL loc_lExiste, loc_lProt, loc_lEsp
loc_lExiste = .T.
loc_lProt   = .T.
loc_lEsp    = .T.

*-- a) avaliado ANTES, numa variavel (referencia)
LOCAL loc_lCalc
loc_lCalc = (loc_lExiste AND (loc_lProt = loc_lEsp))
DO Rec WITH "a) calculado antes, passado em variavel", loc_lCalc

*-- b) expressao inline, UMA linha
DO Rec WITH "b) expressao inline numa linha", (loc_lExiste AND (loc_lProt = loc_lEsp))

*-- c) expressao inline com CONTINUACAO de linha antes dela (forma do helper)
DO Rec WITH "c) inline com ; antes do 2o argumento", ;
    (loc_lExiste AND (loc_lProt = loc_lEsp))

*-- d) a forma EXATA do helper: 1o argumento tambem quebrado, com IIF dentro
DO Rec WITH "d) forma exata do helper (" + ;
    IIF(loc_lEsp, "protegido", "publico") + ")", ;
    (loc_lExiste AND (loc_lProt = loc_lEsp))

*-- e) sem o = entre logicos
DO Rec WITH "e) sem o = entre logicos (IIF)", ;
    (loc_lExiste AND IIF(loc_lEsp, loc_lProt, NOT loc_lProt))

QUIT

PROCEDURE Rec(pcRotulo, plOk)
    STRTOFILE("   " + PADR(pcRotulo, 44) + " tipo=" + VARTYPE(plOk) + ;
        "  recebido=" + TRANSFORM(plOk) + "  (esperado .T.)" + CHR(13) + CHR(10), SAI, 1)
ENDPROC
