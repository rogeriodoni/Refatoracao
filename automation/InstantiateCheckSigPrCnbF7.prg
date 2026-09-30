SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigprcnb_f7.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRes, loc_oForm, loc_oErro
loc_cRes = "FAIL"

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()

    loc_cRes = "gnConnHandle=" + TRANSFORM(gnConnHandle)

    loc_oForm = CREATEOBJECT("FormSIGPRCNB")

    IF VARTYPE(loc_oForm) = "O"
        loc_cRes = loc_cRes + " | OK" + ;
            " W=" + TRANSFORM(loc_oForm.Width) + ;
            " H=" + TRANSFORM(loc_oForm.Height) + ;
            " | GrdOpe.ColCount=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page1.grd_4c_Operacoes.ColumnCount) + ;
            " | GrdTit.ColCount=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.grd_4c_Titulos.ColumnCount) + ;
            " Col2Cap=" + loc_oForm.pgf_4c_Paginas.Page2.grd_4c_Titulos.Column2.Header1.Caption + ;
            " Col8Cap=" + loc_oForm.pgf_4c_Paginas.Page2.grd_4c_Titulos.Column8.Header1.Caption + ;
            " Col8Order=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.grd_4c_Titulos.Column8.ColumnOrder) + ;
            " | BtnEncerrarP2.Caption=" + loc_oForm.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Encerrar.Caption + ;
            " | CntMarcaP2.Visible=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.cnt_4c_Marca.Visible)

        *-- Marcar/Desmarcar Tudo (Page1) - cursor pode estar vazio (sem
        *-- conexao real com o SQL Server), mas o metodo nao pode estourar.
        loc_oForm.BtnMarcarTudoClick()
        loc_oForm.BtnDesmarcarTudoClick()
        loc_cRes = loc_cRes + " | PosMarcarDesmarcarP1: OK"

        *-- Processar sem preencher os filtros obrigatorios - deve exibir
        *-- MsgAviso (capturado no ArquivoErroTeste) e sair sem excecao.
        loc_oForm.BtnProcessarClick()
        loc_cRes = loc_cRes + " | PosBtnProcessarClickVazio: OK"

        *-- Voltar (Page2) - RecordSource ja vazio, so garante que nao
        *-- estoura mesmo sem ter processado nada antes.
        loc_oForm.BtnVoltarClick()
        loc_cRes = loc_cRes + " | PosBtnVoltarClick: ActivePage=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage)

        loc_oForm.Release()
    ELSE
        loc_cRes = loc_cRes + " | FAIL VARTYPE=" + VARTYPE(loc_oForm)
    ENDIF
CATCH TO loc_oErro
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "EXCEPTION: " + loc_oErro.Message + ;
               " Linha:" + TRANSFORM(loc_oErro.LineNo) + " Proc:" + loc_oErro.Procedure
ENDTRY

IF FILE("C:\4c\automation\vfp_error_sigprcnb_f7.txt")
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "DIALOGOS: " + FILETOSTR("C:\4c\automation\vfp_error_sigprcnb_f7.txt")
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\instantiate_sigprcnb_f7_result.txt")
QUIT
