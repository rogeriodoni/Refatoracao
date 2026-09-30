SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigprcotf3.txt"

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()
PUBLIC gnConnHandle
gnConnHandle = -1

LOCAL loForm, loErr, lcOut
lcOut = ""
TRY
    loForm = CREATEOBJECT("FormSIGPRCOT", .NULL., "01")
CATCH TO loErr
    lcOut = lcOut + "EXCECAO: " + loErr.Message + " Ln=" + TRANSFORM(loErr.LineNo) + ;
            " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY

IF VARTYPE(loForm) = "O"
    lcOut = lcOut + "INSTANCIA: OK  BaseClass=" + loForm.BaseClass + ;
        "  Caption=[" + loForm.Caption + "]" + CHR(13) + CHR(10)
    lcOut = lcOut + "this_cMoeda=[" + loForm.this_cMoeda + "]" + CHR(13) + CHR(10)
    lcOut = lcOut + "cnt_4c_Cabecalho existe=" + TRANSFORM(PEMSTATUS(loForm, "cnt_4c_Cabecalho", 5)) + CHR(13) + CHR(10)
    lcOut = lcOut + "lbl_4c_Titulo.Caption=[" + loForm.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption + "]" + CHR(13) + CHR(10)
    lcOut = lcOut + "ForeColor=" + TRANSFORM(loForm.ForeColor) + CHR(13) + CHR(10)
ELSE
    lcOut = lcOut + "INSTANCIA: FALHOU  VARTYPE=" + VARTYPE(loForm) + CHR(13) + CHR(10)
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    lcOut = lcOut + "--- ERROS CAPTURADOS ---" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste)
ENDIF

STRTOFILE(lcOut, "C:\4c\automation\instantiate_sigprcotf3_result.txt")
QUIT
