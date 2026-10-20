*-- Instanciacao de Formsigprnfe (task659, Fase 8).
*-- Prova que a tela ABRE e que os hooks novos (FormParaBO / BOParaForm /
*-- HabilitarCampos / BtnCancelarClick / ChecarDirs) rodam sem estourar.
SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_nfe659f8.txt"

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()
PUBLIC gnConnHandle
gnConnHandle = -1

LOCAL loForm, loErr, lcOut, loPnl
lcOut = ""
TRY
    loForm = CREATEOBJECT("Formsigprnfe")
CATCH TO loErr
    lcOut = lcOut + "EXCECAO: " + loErr.Message + " Ln=" + TRANSFORM(loErr.LineNo) + ;
            " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY

IF VARTYPE(loForm) = "O"
    loPnl = loForm.cnt_4c_Operacoes
    lcOut = lcOut + "INSTANCIA: OK  BaseClass=" + loForm.BaseClass + ;
        "  Caption=[" + loForm.Caption + "]" + CHR(13) + CHR(10)

    lcOut = lcOut + "Versao=[" + loForm.this_cVersao + "] VersaoL=[" + ;
        loForm.this_cVersaoL + "] ValidaIE=" + TRANSFORM(loForm.this_lValidaIE) + CHR(13) + CHR(10)
    lcOut = lcOut + "lbl_4c_Versao.Caption=[" + loPnl.lbl_4c_Versao.Caption + "]" + CHR(13) + CHR(10)

    *-- Defaults do Init legado que o BOParaForm leva para a tela
    lcOut = lcOut + "DtIni=[" + TRANSFORM(loPnl.txt_4c_DtIni.Value) + "] DtFin=[" + ;
        TRANSFORM(loPnl.txt_4c_DtFin.Value) + "] Emps=[" + ;
        TRANSFORM(loPnl.txt_4c_Emps.Value) + "] Regime=[" + ;
        TRANSFORM(loPnl.cbo_4c_CmbRegime.Value) + "]" + CHR(13) + CHR(10)
    lcOut = lcOut + "OptTipos=" + TRANSFORM(loPnl.obj_4c_OptTipos.Value) + ;
        " OptProc=" + TRANSFORM(loPnl.obj_4c_OptProcessados.Value) + ;
        " OptAcao=" + TRANSFORM(loPnl.obj_4c_OptAcao.Value) + ;
        " OptAmb=" + TRANSFORM(loPnl.obj_4c_OptAmbiente.Value) + ;
        " OptImp=" + TRANSFORM(loPnl.obj_4c_OptImpressao.Value) + ;
        " OptCont=" + TRANSFORM(loPnl.obj_4c_OptContin.Value) + CHR(13) + CHR(10)
    lcOut = lcOut + "CmdInu.Visible=" + TRANSFORM(loPnl.cmd_4c_CmdInu.Visible) + ;
        "  cnt_4c_Inu.Visible=" + TRANSFORM(loForm.cnt_4c_Inu.Visible) + CHR(13) + CHR(10)

    *-- FormParaBO / BOParaForm herdam o PROTECTED de FormBase: nao da para
    *-- chamar de fora. Aqui se prova (a) que existem e (b) que rodaram -
    *-- BOParaForm no Init (os defaults acima vieram dele) e FormParaBO
    *-- dentro de CarregarLista, que le os criterios antes de consultar.
    lcOut = lcOut + "PEMSTATUS FormParaBO=" + TRANSFORM(PEMSTATUS(loForm, "FormParaBO", 5)) + ;
        " BOParaForm=" + TRANSFORM(PEMSTATUS(loForm, "BOParaForm", 5)) + CHR(13) + CHR(10)

    TRY
        *-- Suja os criterios na TELA e confirma que FormParaBO (chamado por
        *-- dentro de CarregarLista) levou TODOS eles para o BO
        loPnl.obj_4c_OptAcao.Value     = 4
        loPnl.obj_4c_OptAmbiente.Value = 2
        loPnl.obj_4c_OptContin.Value   = 3
        loPnl.chk_4c_ChkHVerao.Value   = 1
        loPnl.chk_4c_OptSub.Value      = 1
        loPnl.txt_4c_InuIni.Value      = "00000001"
        loPnl.txt_4c_InuFim.Value      = "00000009"

        lcOut = lcOut + "CarregarLista()=" + TRANSFORM(loForm.CarregarLista()) + CHR(13) + CHR(10)
        WITH loForm.this_oBusinessObject
            lcOut = lcOut + "  BO apos FormParaBO: Emps=[" + TRANSFORM(.this_cEmps) + ;
                "] Series=[" + TRANSFORM(.this_cSeries) + "] DtIni=[" + TRANSFORM(.this_dDtIni) + ;
                "] Acao=" + TRANSFORM(.this_nAcao) + " Amb=" + TRANSFORM(.this_nAmbiente) + ;
                " Imp=" + TRANSFORM(.this_nImpressao) + " Contin=" + TRANSFORM(.this_nContin) + ;
                " HVerao=" + TRANSFORM(.this_lHVerao) + " Arq=" + TRANSFORM(.this_lArq) + ;
                " Venc=" + TRANSFORM(.this_lVenc) + " Sub=" + TRANSFORM(.this_lOptSub) + ;
                " InuIni=[" + TRANSFORM(.this_cInuIni) + "] InuFim=[" + TRANSFORM(.this_cInuFim) + ;
                "] IniContin=[" + TRANSFORM(.this_dIniContin) + "]" + CHR(13) + CHR(10)
        ENDWITH
        lcOut = lcOut + "  CmdInu.Visible apos Acao=4: " + ;
            TRANSFORM(loPnl.cmd_4c_CmdInu.Visible) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "ERRO FormParaBO/CarregarLista: " + loErr.Message + " Ln=" + ;
            TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    *-- HabilitarCampos nos dois sentidos (par desabilita/reabilita)
    TRY
        loForm.HabilitarCampos(.F.)
        lcOut = lcOut + "HabilitarCampos(.F.): Emps=" + TRANSFORM(loPnl.txt_4c_Emps.Enabled) + ;
            " Regime=" + TRANSFORM(loPnl.cbo_4c_CmbRegime.Enabled) + ;
            " Proc1=" + TRANSFORM(loPnl.obj_4c_OptProcessados.Buttons(1).Enabled) + CHR(13) + CHR(10)
        loForm.HabilitarCampos(.T.)
        lcOut = lcOut + "HabilitarCampos(.T.): Emps=" + TRANSFORM(loPnl.txt_4c_Emps.Enabled) + ;
            " Regime=" + TRANSFORM(loPnl.cbo_4c_CmbRegime.Enabled) + ;
            " Arquivos=" + TRANSFORM(loPnl.txt_4c_Arquivos.Enabled) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "ERRO HabilitarCampos: " + loErr.Message + " Ln=" + ;
            TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    *-- Par de volta dos botoes (regra #40): selecionado -> livre
    TRY
        loForm.AjustarBotoesPorModo(.T.)
        lcOut = lcOut + "Modo SELECIONADO: Emps=" + TRANSFORM(loPnl.txt_4c_Emps.Enabled) + ;
            " Selecionar=" + TRANSFORM(loForm.cmd_4c_CmdSelecionar.Enabled) + ;
            " Limpar=" + TRANSFORM(loForm.obj_4c_CmdBtnForm.Buttons(1).Enabled) + CHR(13) + CHR(10)
        loForm.LimparSelecao()
        lcOut = lcOut + "Apos LimparSelecao: Emps=" + TRANSFORM(loPnl.txt_4c_Emps.Enabled) + ;
            " Selecionar=" + TRANSFORM(loForm.cmd_4c_CmdSelecionar.Enabled) + ;
            " Limpar=" + TRANSFORM(loForm.obj_4c_CmdBtnForm.Buttons(1).Enabled) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "ERRO par de volta: " + loErr.Message + " Ln=" + ;
            TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    *-- BtnCancelarClick: fecha o painel de inutilizacao pelo funil
    TRY
        loForm.cnt_4c_Inu.Visible = .T.
        loForm.BtnCancelarClick()
        lcOut = lcOut + "BtnCancelarClick: cnt_4c_Inu.Visible=" + ;
            TRANSFORM(loForm.cnt_4c_Inu.Visible) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "ERRO BtnCancelarClick: " + loErr.Message + " Ln=" + ;
            TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    *-- ChecarDirs sem conexao: nao pode estourar
    TRY
        lcOut = lcOut + "ChecarDirs()=" + TRANSFORM(loForm.ChecarDirs()) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "ERRO ChecarDirs: " + loErr.Message + " Ln=" + ;
            TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    loForm.Release()
ELSE
    lcOut = lcOut + "INSTANCIA: FALHOU  VARTYPE=" + VARTYPE(loForm) + CHR(13) + CHR(10)
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    lcOut = lcOut + "--- ERROS CAPTURADOS ---" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste)
ENDIF

STRTOFILE(lcOut, "C:\4c\automation\instantiate_nfe659f8_result.txt")
QUIT
