SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigpremaf4.txt"

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()
PUBLIC gnConnHandle
gnConnHandle = -1

LOCAL loForm, loErr, lcOut
lcOut = ""
TRY
    loForm = CREATEOBJECT("Formsigprema")
CATCH TO loErr
    lcOut = lcOut + "EXCECAO: " + loErr.Message + " Ln=" + TRANSFORM(loErr.LineNo) + ;
            " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY

IF VARTYPE(loForm) = "O"
    lcOut = lcOut + "INSTANCIA: OK  BaseClass=" + loForm.BaseClass + ;
        "  Caption=[" + loForm.Caption + "]" + CHR(13) + CHR(10)
    lcOut = lcOut + "grd_4c_Dados existe=" + TRANSFORM(PEMSTATUS(loForm, "grd_4c_Dados", 5)) + CHR(13) + CHR(10)
    lcOut = lcOut + "grd_4c_Dados.ColumnCount=" + TRANSFORM(loForm.grd_4c_Dados.ColumnCount) + CHR(13) + CHR(10)
    lcOut = lcOut + "grd_4c_Dados.RecordSource=[" + loForm.grd_4c_Dados.RecordSource + "]" + CHR(13) + CHR(10)
    lcOut = lcOut + "Column1.CurrentControl=[" + loForm.grd_4c_Dados.Column1.CurrentControl + "]" + CHR(13) + CHR(10)
    lcOut = lcOut + "cmd_4c_SelTudo existe=" + TRANSFORM(PEMSTATUS(loForm, "cmd_4c_SelTudo", 5)) + CHR(13) + CHR(10)
    lcOut = lcOut + "cmd_4c_Apaga existe=" + TRANSFORM(PEMSTATUS(loForm, "cmd_4c_Apaga", 5)) + CHR(13) + CHR(10)
    lcOut = lcOut + "cmg_4c_Encerrar existe=" + TRANSFORM(PEMSTATUS(loForm, "cmg_4c_Encerrar", 5)) + CHR(13) + CHR(10)
    lcOut = lcOut + "cmd_4c_EnviarEmail existe=" + TRANSFORM(PEMSTATUS(loForm, "cmd_4c_EnviarEmail", 5)) + CHR(13) + CHR(10)
    lcOut = lcOut + "shp_4c_Decoracao existe=" + TRANSFORM(PEMSTATUS(loForm, "shp_4c_Decoracao", 5)) + CHR(13) + CHR(10)
    lcOut = lcOut + "cursor_4c_Dados USED=" + TRANSFORM(USED("cursor_4c_Dados")) + CHR(13) + CHR(10)

    *-- Simula clique nos handlers ja ligados (sem SQL, cursor placeholder vazio)
    TRY
        loForm.BtnSelTudoClick()
        lcOut = lcOut + "BtnSelTudoClick: OK" + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "BtnSelTudoClick EXCECAO: " + loErr.Message + " Ln=" + TRANSFORM(loErr.LineNo) + CHR(13) + CHR(10)
    ENDTRY

    TRY
        loForm.BtnApagaClick()
        lcOut = lcOut + "BtnApagaClick: OK" + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "BtnApagaClick EXCECAO: " + loErr.Message + " Ln=" + TRANSFORM(loErr.LineNo) + CHR(13) + CHR(10)
    ENDTRY

    TRY
        loForm.HeaderContasClick()
        loForm.HeaderRclisClick()
        loForm.HeaderEmailsClick()
        lcOut = lcOut + "HeaderClicks: OK" + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "HeaderClicks EXCECAO: " + loErr.Message + " Ln=" + TRANSFORM(loErr.LineNo) + CHR(13) + CHR(10)
    ENDTRY

    loForm.Release()
ELSE
    lcOut = lcOut + "INSTANCIA: FALHOU  VARTYPE=" + VARTYPE(loForm) + CHR(13) + CHR(10)
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    lcOut = lcOut + "--- ERROS CAPTURADOS ---" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste)
ENDIF

STRTOFILE(lcOut, "C:\4c\automation\instantiate_sigpremaf4_result.txt")
QUIT
