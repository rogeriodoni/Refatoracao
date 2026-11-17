*-- Probe Fase 8 - instanciacao headless de FormSigOpPdt (task784)
SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL

LOCAL loc_oForm, loc_oErro, loc_cLog
loc_cLog = "C:\4c\automation\probe_pdt784f8.txt"

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()
    gb_4c_ModoTeste = .T.

    GarantirClasse("FormSigOpPdt")

    loc_oForm = CREATEOBJECT("FormSigOpPdt")

    STRTOFILE("VARTYPE=" + VARTYPE(loc_oForm) + CHR(13), loc_cLog)

    IF VARTYPE(loc_oForm) = "O"
        STRTOFILE("BaseClass=" + loc_oForm.BaseClass + CHR(13), loc_cLog, 1)
        STRTOFILE("Caption=" + loc_oForm.Caption + CHR(13), loc_cLog, 1)
        STRTOFILE("PEMSTATUS cmd_4c_Ok=" + TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_Ok", 5)) + CHR(13), loc_cLog, 1)
        STRTOFILE("PEMSTATUS cmd_4c_SelTudo=" + TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_SelTudo", 5)) + CHR(13), loc_cLog, 1)
        STRTOFILE("PEMSTATUS cmd_4c_Apaga=" + TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_Apaga", 5)) + CHR(13), loc_cLog, 1)
        STRTOFILE("PEMSTATUS grd_4c_Dados=" + TRANSFORM(PEMSTATUS(loc_oForm, "grd_4c_Dados", 5)) + CHR(13), loc_cLog, 1)
        STRTOFILE("ColumnCount=" + TRANSFORM(loc_oForm.grd_4c_Dados.ColumnCount) + CHR(13), loc_cLog, 1)
        STRTOFILE("RecordSource=" + loc_oForm.grd_4c_Dados.RecordSource + CHR(13), loc_cLog, 1)
        STRTOFILE("txt_4c_Procura.Value=" + TRANSFORM(loc_oForm.txt_4c_Procura.Value) + CHR(13), loc_cLog, 1)
        STRTOFILE("this_cOpEscolha=" + loc_oForm.this_cOpEscolha + CHR(13), loc_cLog, 1)
        STRTOFILE("CarregarLista()=" + TRANSFORM(loc_oForm.CarregarLista()) + CHR(13), loc_cLog, 1)
        STRTOFILE("AjustarBotoesPorModo (sem erro)" + CHR(13), loc_cLog, 1)
        loc_oForm.AjustarBotoesPorModo()
        STRTOFILE("cmd_4c_SelTudo.Visible=" + TRANSFORM(loc_oForm.cmd_4c_SelTudo.Visible) + CHR(13), loc_cLog, 1)
        loc_oForm.Release()
        STRTOFILE("RELEASE_OK" + CHR(13), loc_cLog, 1)
    ENDIF
CATCH TO loc_oErro
    STRTOFILE("ERRO=" + loc_oErro.Message + " LINHA=" + TRANSFORM(loc_oErro.LineNo) + ;
        " PROC=" + loc_oErro.Procedure + CHR(13), loc_cLog, 1)
ENDTRY

QUIT
