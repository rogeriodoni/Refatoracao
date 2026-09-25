SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_helpers\test_task575_fase6_dialogs.txt"

LOCAL loc_cRes, loc_oForm, loc_oErro
loc_cRes = ""

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()

gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_helpers\test_task575_fase6_dialogs.txt"

TRY
    loc_oForm = CREATEOBJECT("FormSigMvPdt", "OPERACAO TESTE", " ", 0, "")

    IF VARTYPE(loc_oForm) = "O"
        loc_cRes = loc_cRes + "OK - form instanciado" + CHR(13)
        loc_cRes = loc_cRes + "Width=" + TRANSFORM(loc_oForm.Width) + ;
                   " Height=" + TRANSFORM(loc_oForm.Height) + ;
                   " TitleBar=" + TRANSFORM(loc_oForm.TitleBar) + ;
                   " ControlBox=" + TRANSFORM(loc_oForm.ControlBox) + ;
                   " Movable=" + TRANSFORM(loc_oForm.Movable) + CHR(13)
        loc_cRes = loc_cRes + "Picture=[" + TRANSFORM(loc_oForm.Picture) + "] FILE=" + ;
                   TRANSFORM(FILE(loc_oForm.Picture)) + CHR(13)

        IF PEMSTATUS(loc_oForm, "cmd_4c_Processo", 5)
            WITH loc_oForm.cmd_4c_Processo
                loc_cRes = loc_cRes + "OK - cmd_4c_Processo: Top=" + TRANSFORM(.Top) + ;
                    " Left=" + TRANSFORM(.Left) + " Width=" + TRANSFORM(.Width) + ;
                    " Height=" + TRANSFORM(.Height) + " Visible=" + TRANSFORM(.Visible) + ;
                    " Caption=[" + .Caption + "]" + ;
                    " FontName=[" + .FontName + "] FontSize=" + TRANSFORM(.FontSize) + ;
                    " FontBold=" + TRANSFORM(.FontBold) + ;
                    " ForeColor=" + TRANSFORM(.ForeColor) + ;
                    " BackColor=" + TRANSFORM(.BackColor) + CHR(13)
            ENDWITH
        ELSE
            loc_cRes = loc_cRes + "FALHA - cmd_4c_Processo NAO existe" + CHR(13)
        ENDIF

        loc_cRes = loc_cRes + "props: this_cDope=[" + loc_oForm.this_cDope + "]" + ;
            " this_cTipo=[" + loc_oForm.this_cTipo + "]" + ;
            " this_lDespachado=" + TRANSFORM(loc_oForm.this_lDespachado) + CHR(13)
        loc_cRes = loc_cRes + "BO=" + VARTYPE(loc_oForm.this_oBusinessObject) + ;
            " BuscarOperacao=" + TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject, "BuscarOperacao", 5)) + CHR(13)
        loc_cRes = loc_cRes + "ControlCount=" + TRANSFORM(loc_oForm.ControlCount) + CHR(13)

        loc_oForm.Release()
    ELSE
        loc_cRes = loc_cRes + "FALHA - VARTYPE=" + VARTYPE(loc_oForm) + CHR(13)
    ENDIF
CATCH TO loc_oErro
    loc_cRes = loc_cRes + "EXCEPTION: " + loc_oErro.Message + ;
        " Linha=" + TRANSFORM(loc_oErro.LineNo) + " Proc=" + loc_oErro.Procedure + CHR(13)
ENDTRY

STRTOFILE(loc_cRes, "C:\4c\automation\vfp_helpers\test_task575_fase6_result.txt")
QUIT
