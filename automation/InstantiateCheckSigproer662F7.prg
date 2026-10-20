SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigproer662f7.txt"

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()
PUBLIC gnConnHandle
gnConnHandle = -1

LOCAL loForm, loErr, lcOut
lcOut = ""
TRY
    loForm = CREATEOBJECT("Formsigproer", "200.1.1.1", "01", "123456", "20261018", 150.75, "103000", "")
CATCH TO loErr
    lcOut = lcOut + "EXCECAO: " + loErr.Message + " Ln=" + TRANSFORM(loErr.LineNo) + ;
            " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY

IF VARTYPE(loForm) = "O"
    lcOut = lcOut + "INSTANCIA: OK  BaseClass=" + loForm.BaseClass + ;
        "  Caption=[" + loForm.Caption + "]" + CHR(13) + CHR(10)

    lcOut = lcOut + "txt_4c_SenhaSupervisor existe=" + ;
        TRANSFORM(PEMSTATUS(loForm, "txt_4c_SenhaSupervisor", 5)) + CHR(13) + CHR(10)
    lcOut = lcOut + "obj_4c_SAIDA.Buttons(1).Caption=[" + loForm.obj_4c_SAIDA.Buttons(1).Caption + "]" + CHR(13) + CHR(10)

    *-- BtnCancelarClick deve gravar RetornoFalha (pulado sem C:\client\Resp)
    *-- e liberar o form, sem excecao.
    TRY
        loForm.BtnCancelarClick()
        lcOut = lcOut + "BtnCancelarClick: OK (Release)" + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "ERRO BtnCancelarClick: " + loErr.Message + " Ln=" + ;
            TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY
ELSE
    lcOut = lcOut + "INSTANCIA: FALHOU  VARTYPE=" + VARTYPE(loForm) + CHR(13) + CHR(10)
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    lcOut = lcOut + "--- ERROS CAPTURADOS ---" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste)
ENDIF

STRTOFILE(lcOut, "C:\4c\automation\instantiate_sigproer662_f7_result.txt")
QUIT
