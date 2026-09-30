SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_ccpf8.txt"

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()
PUBLIC gnConnHandle
gnConnHandle = -1

LOCAL loForm, loErr, lcOut
lcOut = ""
TRY
    loForm = CREATEOBJECT("Formsigprccp", .F.)
CATCH TO loErr
    lcOut = lcOut + "EXCECAO: " + loErr.Message + " Ln=" + TRANSFORM(loErr.LineNo) + ;
            " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY

IF VARTYPE(loForm) = "O"
    lcOut = lcOut + "INSTANCIA: OK  BaseClass=" + loForm.BaseClass + ;
        "  Caption=[" + loForm.Caption + "]" + CHR(13) + CHR(10)
    lcOut = lcOut + "Modo inicial=[" + loForm.this_cModoAtual + "]" + CHR(13) + CHR(10)

    *-- Estado inicial dos botoes (legado: Atualiza/Impressao desabilitados)
    lcOut = lcOut + "Atualizar.Enabled=" + TRANSFORM(loForm.cmg_4c_Acoes.Buttons(2).Enabled) + ;
        "  Imprimir.Enabled=" + TRANSFORM(loForm.cmd_4c_Imprimir.Enabled) + CHR(13) + CHR(10)

    *-- Defaults vindos do BO via BOParaForm
    lcOut = lcOut + "OpcMoeda=" + TRANSFORM(loForm.obj_4c_OpcaoMoeda.Value) + ;
        " Situacao=" + TRANSFORM(loForm.obj_4c_Situacao.Value) + ;
        " Compra=" + TRANSFORM(loForm.obj_4c_Compra.Value) + ;
        " Recalcula=" + TRANSFORM(loForm.obj_4c_Recalcula.Value) + ;
        " AtualizaVenda=" + TRANSFORM(loForm.obj_4c_AtualizaVenda.Value) + CHR(13) + CHR(10)

    *-- HabilitarCampos(.F.) / (.T.)
    TRY
        loForm.HabilitarCampos(.F.)
        lcOut = lcOut + "HabilitarCampos(.F.): GrupoI.Enabled=" + ;
            TRANSFORM(loForm.txt_4c_GrupoI.Enabled) + ;
            " SelTudo.Visible=" + TRANSFORM(loForm.cmd_4c_SelTudo.Visible) + CHR(13) + CHR(10)
        loForm.HabilitarCampos(.T.)
        lcOut = lcOut + "HabilitarCampos(.T.): GrupoI.Enabled=" + ;
            TRANSFORM(loForm.txt_4c_GrupoI.Enabled) + ;
            " DescForn.Enabled=" + TRANSFORM(loForm.txt_4c_DescFornecedor.Enabled) + ;
            " SelTudo.Visible=" + TRANSFORM(loForm.cmd_4c_SelTudo.Visible) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "ERRO HabilitarCampos: " + loErr.Message + " Ln=" + ;
            TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    *-- AjustarBotoesPorModo com grade vazia mesmo em modo PROCESSADO
    TRY
        loForm.this_cModoAtual = "PROCESSADO"
        loForm.AjustarBotoesPorModo()
        lcOut = lcOut + "PROCESSADO c/ grade vazia -> Atualizar.Enabled=" + ;
            TRANSFORM(loForm.cmg_4c_Acoes.Buttons(2).Enabled) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "ERRO AjustarBotoesPorModo: " + loErr.Message + " Ln=" + ;
            TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    *-- LimparCampos (PROTECTED - via os hooks publicos que o usam)
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

STRTOFILE(lcOut, "C:\4c\automation\instantiate_ccpf8_result.txt")
QUIT
