* ProbeF1SigOpPcu777.prg - instancia o BO da Fase 1 e grava o resultado.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cSaida, loc_oBO, loc_cTxt
loc_cSaida = "C:\4c\automation\ProbeF1SigOpPcu777.txt"
loc_cTxt = ""

TRY
    SET PROCEDURE TO ("C:\4c\projeto\app\classes\businessbase.prg") ADDITIVE
    SET PROCEDURE TO ("C:\4c\projeto\app\utils\messages.prg") ADDITIVE
    SET PROCEDURE TO ("C:\4c\projeto\app\classes\SigOpPcuBO.prg") ADDITIVE

    loc_oBO = CREATEOBJECT("SigOpPcuBO")
    loc_cTxt = "VARTYPE=" + VARTYPE(loc_oBO) + CHR(13) + CHR(10)
    IF VARTYPE(loc_oBO) = "O"
        loc_cTxt = loc_cTxt + "Tabela=[" + loc_oBO.this_cTabela + "]" + CHR(13) + CHR(10)
        loc_cTxt = loc_cTxt + "CampoChave=[" + loc_oBO.this_cCampoChave + "]" + CHR(13) + CHR(10)
        loc_cTxt = loc_cTxt + "Tipo=[" + loc_oBO.this_cTipo + "]" + CHR(13) + CHR(10)
        loc_cTxt = loc_cTxt + "CursorGrade=[" + loc_oBO.this_cCursorGrade + "]" + CHR(13) + CHR(10)
        loc_cTxt = loc_cTxt + "Coefs=" + TRANSFORM(loc_oBO.this_nCoefs) + ;
                   " AltCoef=" + TRANSFORM(loc_oBO.this_nAltCoef) + ;
                   " TotalAdic=" + TRANSFORM(loc_oBO.this_nTotalAdicional) + CHR(13) + CHR(10)
        loc_cTxt = loc_cTxt + "AcessoFeitio=" + TRANSFORM(loc_oBO.this_lAcessoFeitio) + CHR(13) + CHR(10)
        loc_cTxt = loc_cTxt + "OK"
    ENDIF
CATCH TO loc_oErro
    loc_cTxt = loc_cTxt + "ERRO=" + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo)
ENDTRY

STRTOFILE(loc_cTxt, loc_cSaida)
QUIT
