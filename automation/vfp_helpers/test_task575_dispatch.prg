SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_helpers\test_task575_dispatch_dialogs.txt"

LOCAL loc_cRes, loc_oForm, loc_oErro
loc_cRes = ""

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_helpers\test_task575_dispatch_dialogs.txt"

STRTOFILE("ANTES-CREATE" + CHR(13), "C:\4c\automation\vfp_helpers\test_task575_dispatch_trace.txt")

TRY
    loc_oForm = CREATEOBJECT("FormSigMvPdt", "OPERACAO TESTE", " ", 0, "")
    IF VARTYPE(loc_oForm) = "O"
        STRTOFILE("FORM-OK / ANTES-DISPATCH" + CHR(13), "C:\4c\automation\vfp_helpers\test_task575_dispatch_trace.txt", 1)
        loc_oForm.CmdProcessoClick()
        STRTOFILE("DEPOIS-DISPATCH vartype=" + VARTYPE(loc_oForm) + CHR(13), "C:\4c\automation\vfp_helpers\test_task575_dispatch_trace.txt", 1)
        loc_cRes = loc_cRes + "OK - CmdProcessoClick retornou; VARTYPE apos=" + VARTYPE(loc_oForm) + CHR(13)
    ELSE
        loc_cRes = loc_cRes + "FALHA - form VARTYPE=" + VARTYPE(loc_oForm) + CHR(13)
    ENDIF
CATCH TO loc_oErro
    loc_cRes = loc_cRes + "EXCEPTION: " + loc_oErro.Message + ;
        " Linha=" + TRANSFORM(loc_oErro.LineNo) + " Proc=" + loc_oErro.Procedure + CHR(13)
ENDTRY

STRTOFILE(loc_cRes, "C:\4c\automation\vfp_helpers\test_task575_dispatch_result.txt")
QUIT
