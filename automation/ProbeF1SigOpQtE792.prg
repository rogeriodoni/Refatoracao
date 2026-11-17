* ProbeF1SigOpQtE792.prg
* Instancia SigOpQtEBO (Fase 1) e grava as propriedades num TXT.
* Nao abre conexao: o Init do BO nao cria DataAccess (this_cTabela vazio).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cSaida, loc_oBO, loc_oErro
loc_cSaida = ""

TRY
    SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\SigOpQtEBO.prg" ADDITIVE

    loc_oBO = CREATEOBJECT("SigOpQtEBO")

    IF VARTYPE(loc_oBO) = "O"
        loc_cSaida = "OK: SigOpQtEBO instanciado" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "this_cTabela=[" + loc_oBO.this_cTabela + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "this_cCampoChave=[" + loc_oBO.this_cCampoChave + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "this_cPrefixoTitulo=[" + loc_oBO.this_cPrefixoTitulo + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "this_cTitulo=[" + loc_oBO.this_cTitulo + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "this_cCpros=[" + loc_oBO.this_cCpros + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "this_nQtEtiq=[" + TRANSFORM(loc_oBO.this_nQtEtiq) + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "this_cVariavelLegado=[" + loc_oBO.this_cVariavelLegado + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "this_cMascaraQtEtiq=[" + loc_oBO.this_cMascaraQtEtiq + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "this_nMaxQtEtiq=[" + TRANSFORM(loc_oBO.this_nMaxQtEtiq) + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "this_lEmEdicao=[" + TRANSFORM(loc_oBO.this_lEmEdicao) + "]" + CHR(13) + CHR(10)
    ELSE
        loc_cSaida = "FALHA: CREATEOBJECT devolveu " + VARTYPE(loc_oBO) + CHR(13) + CHR(10)
    ENDIF
CATCH TO loc_oErro
    loc_cSaida = "ERRO: " + loc_oErro.Message + " | LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                 " | PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cSaida, "C:\4c\automation\probe_f1_sigopqte792.txt")

QUIT
