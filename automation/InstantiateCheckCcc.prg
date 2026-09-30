SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_ccc.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRes, loc_oForm, loc_oErro

loc_cRes = "FAIL"

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()

    loc_oForm = CREATEOBJECT("FormSigPrCcc")

    IF VARTYPE(loc_oForm) = "O"
        loc_cRes = "OK" + ;
            " W=" + TRANSFORM(loc_oForm.Width) + ;
            " H=" + TRANSFORM(loc_oForm.Height) + ;
            " | OpConta.Visible=" + TRANSFORM(loc_oForm.cnt_4c_OpConta.Visible) + ;
            " OpConta.Empresa.MaxLength=" + TRANSFORM(loc_oForm.cnt_4c_OpConta.txt_4c_Empresa.MaxLength) + ;
            " OpConta.Grupos.MaxLength=" + TRANSFORM(loc_oForm.cnt_4c_OpConta.txt_4c_TxtGrupos.MaxLength) + ;
            " OpConta.Contas.MaxLength=" + TRANSFORM(loc_oForm.cnt_4c_OpConta.txt_4c_TxtContas.MaxLength) + ;
            " OpConta.Moedas.MaxLength=" + TRANSFORM(loc_oForm.cnt_4c_OpConta.txt_4c_TxtMoedas.MaxLength) + ;
            " OpConta.Titulo=[" + loc_oForm.cnt_4c_OpConta.lbl_4c_Label2.Caption + "]" + ;
            " | OpEstoque.Visible=" + TRANSFORM(loc_oForm.cnt_4c_OpEstoque.Visible) + ;
            " OpEstoque.Estoque.Caption=[" + loc_oForm.cnt_4c_OpEstoque.lbl_4c_Estoque.Caption + "]" + ;
            " OpEstoque.Produto.Caption=[" + loc_oForm.cnt_4c_OpEstoque.lbl_4c_Produto.Caption + "]" + ;
            " OpEstoque.Produto.MaxLength=" + TRANSFORM(loc_oForm.cnt_4c_OpEstoque.txt_4c_Produto.MaxLength) + ;
            " OpEstoque.Descricao.MaxLength=" + TRANSFORM(loc_oForm.cnt_4c_OpEstoque.txt_4c_Descricao.MaxLength) + ;
            " OpEstoque.Titulo=[" + loc_oForm.cnt_4c_OpEstoque.lbl_4c_Label2.Caption + "]"

        *-- Simula o toggle do checkbox de Conta Corrente (Fase 4) e confere
        *-- que os campos internos da Fase 5 ficam visiveis junto do container
        loc_oForm.chk_4c_Conta.Value = 1
        loc_oForm.ChkContaClick()
        loc_cRes = loc_cRes + " | posToggleConta: Visible=" + TRANSFORM(loc_oForm.cnt_4c_OpConta.Visible) + ;
            " Empresa.Visible=" + TRANSFORM(loc_oForm.cnt_4c_OpConta.txt_4c_Empresa.Visible) + ;
            " Data.Visible=" + TRANSFORM(loc_oForm.cnt_4c_OpConta.txt_4c_TxtData.Visible)

        loc_oForm.Release()
    ELSE
        loc_cRes = "FAIL VARTYPE=" + VARTYPE(loc_oForm)
    ENDIF
CATCH TO loc_oErro
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "EXCEPTION: " + loc_oErro.Message + ;
               " Linha:" + TRANSFORM(loc_oErro.LineNo) + " Proc:" + loc_oErro.Procedure
ENDTRY

IF FILE("C:\4c\automation\vfp_error_ccc.txt")
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "DIALOGOS: " + FILETOSTR("C:\4c\automation\vfp_error_ccc.txt")
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\instantiate_ccc_result.txt")
QUIT
