SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigprchr_f7.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRes, loc_oForm, loc_oErro
loc_cRes = "FAIL"

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()

    loc_oForm = CREATEOBJECT("FormSigPrChr")

    IF VARTYPE(loc_oForm) = "O"
        loc_cRes = "OK" + ;
            " W=" + TRANSFORM(loc_oForm.Width) + ;
            " H=" + TRANSFORM(loc_oForm.Height) + ;
            " | Justif.Visible=" + TRANSFORM(loc_oForm.cnt_4c_justificativa.Visible) + ;
            " GetJust.Width=" + TRANSFORM(loc_oForm.cnt_4c_justificativa.obj_4c_Get_justificativa.Width) + ;
            " CmdGconf.BtnCount=" + TRANSFORM(loc_oForm.cnt_4c_justificativa.obj_4c_CmdGconf.ButtonCount) + ;
            " | Procurar.Visible=" + TRANSFORM(loc_oForm.cnt_4c_Procurar.Visible) + ;
            " Procurar.Enabled=" + TRANSFORM(loc_oForm.cnt_4c_Procurar.Enabled) + ;
            " TxtBanco.MaxLen=" + TRANSFORM(loc_oForm.cnt_4c_Procurar.txt_4c_Banco.MaxLength) + ;
            " Cmdgprocurar.BtnCount=" + TRANSFORM(loc_oForm.cnt_4c_Procurar.obj_4c_Cmdgprocurar.ButtonCount) + ;
            " | Impchmat.Visible=" + TRANSFORM(loc_oForm.cnt_4c_Impchmat.Visible) + ;
            " CmdGprocurar.BtnCount=" + TRANSFORM(loc_oForm.cnt_4c_Impchmat.obj_4c_CmdGprocurar.ButtonCount) + ;
            " | Grid.Col3.Header1=" + loc_oForm.grd_4c_Dados.Column3.Header1.Caption + ;
            " CmdGok.BtnCount=" + TRANSFORM(loc_oForm.obj_4c_CmdGok.ButtonCount)

        *-- Exercita o dispatcher da justificativa (Cancelar) sem gravar nada
        loc_oForm.cnt_4c_justificativa.Visible = .T.
        loc_oForm.cnt_4c_justificativa.obj_4c_CmdGconf.Enabled = .T.
        loc_oForm.cnt_4c_justificativa.obj_4c_CmdGconf.Value = 2
        loc_oForm.CmdGconfClick()
        loc_cRes = loc_cRes + " | PosCancelarJustif: Visible=" + TRANSFORM(loc_oForm.cnt_4c_justificativa.Visible) + ;
            " CmdGconfEna=" + TRANSFORM(loc_oForm.cnt_4c_justificativa.obj_4c_CmdGconf.Enabled)

        *-- Exercita o ramo "sem cheque marcado" de BtnChMatClick (chama
        *-- AbrirImpressaoManualCheque() PROTECTED por dentro da classe) -
        *-- cursor_4c_Cheques vazio (nenhum SQLEXEC rodou) conta = 0.
        loc_oForm.BtnChMatClick()
        loc_cRes = loc_cRes + " | PosBtnChMatClick(semMarca): ImpVisible=" + TRANSFORM(loc_oForm.cnt_4c_Impchmat.Visible) + ;
            " CmdGokEna=" + TRANSFORM(loc_oForm.obj_4c_CmdGok.Enabled)

        *-- Fecha via o botao Cancelar do painel (dispatcher publico)
        loc_oForm.cnt_4c_Impchmat.obj_4c_CmdGprocurar.Value = 2
        loc_oForm.CmdGprocurarImpChmatClick()
        loc_cRes = loc_cRes + " | PosCancelarImpManual: ImpVisible=" + TRANSFORM(loc_oForm.cnt_4c_Impchmat.Visible) + ;
            " CmdGokEna=" + TRANSFORM(loc_oForm.obj_4c_CmdGok.Enabled)

        *-- Exercita BtnProcurarClick (abre o painel Procurar) + Cancelar
        loc_oForm.BtnProcurarClick()
        loc_cRes = loc_cRes + " | PosBtnProcurarClick: Visible=" + TRANSFORM(loc_oForm.cnt_4c_Procurar.Visible) + ;
            " CmdGokEna=" + TRANSFORM(loc_oForm.obj_4c_CmdGok.Enabled) + ;
            " GrdEna=" + TRANSFORM(loc_oForm.grd_4c_Dados.Enabled)

        loc_oForm.cnt_4c_Procurar.obj_4c_Cmdgprocurar.Value = 2
        loc_oForm.CmdgprocurarClick()
        loc_cRes = loc_cRes + " | PosCancelarProcurar: Visible=" + TRANSFORM(loc_oForm.cnt_4c_Procurar.Visible) + ;
            " CmdGokEna=" + TRANSFORM(loc_oForm.obj_4c_CmdGok.Enabled) + ;
            " GrdEna=" + TRANSFORM(loc_oForm.grd_4c_Dados.Enabled)

        loc_oForm.Release()
    ELSE
        loc_cRes = "FAIL VARTYPE=" + VARTYPE(loc_oForm)
    ENDIF
CATCH TO loc_oErro
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "EXCEPTION: " + loc_oErro.Message + ;
               " Linha:" + TRANSFORM(loc_oErro.LineNo) + " Proc:" + loc_oErro.Procedure
ENDTRY

IF FILE("C:\4c\automation\vfp_error_sigprchr_f7.txt")
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "DIALOGOS: " + FILETOSTR("C:\4c\automation\vfp_error_sigprchr_f7.txt")
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\instantiate_sigprchr_f7_result.txt")
QUIT
