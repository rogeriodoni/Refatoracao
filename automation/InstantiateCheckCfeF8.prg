*==============================================================================
* InstantiateCheckCfeF8.prg - Probe da Fase 8/8 do FormSIGOPCFE
*
* Grava o resultado INCREMENTALMENTE para que travamento/erro fatal deixe
* visivel ATE ONDE chegou, e instala ON ERROR para que erro de runtime FORA de
* TRY/CATCH va para o log em vez de abrir dialogo modal (que num processo
* headless congela o VFP).
*
* Os hooks FormParaBO/BOParaForm/LimparCampos sao PROTECTED em FormBase e o
* escopo herdado NAO se alarga em VFP9 - chamados de fora estouram "Property
* <NOME> is not found". Por isso o probe usa a subclasse FormSIGOPCFE_Probe,
* que expoe um ProbeHooks() chamando-os por THIS. (de DENTRO da hierarquia).
*
* NAO batizar o helper de log como "Log": LOG() eh funcao nativa do VFP
* (logaritmo) e vence a PROCEDURE do script, estourando erro 11 em toda
* chamada.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_ProbeLog
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\InstantiateCheckCfeF8_err.txt"
gc_4c_ProbeLog         = "C:\4c\automation\InstantiateCheckCfeF8.txt"

STRTOFILE("CK1 pre-config" + CHR(13) + CHR(10), gc_4c_ProbeLog)

ON ERROR DO ProbeErro WITH ERROR(), MESSAGE(), LINENO(), PROGRAM()

CD C:\4c\projeto\app\start
DO config.prg
= ProbeAnota("CK2 pos-config")

*-- config.prg redefine gb_4c_ValidandoUI = .F. -> restaurar DEPOIS
gb_4c_ValidandoUI = .T.

*-- ConfigurarAmbiente() NAO retorna nesta maquina: montar PATH e carregar
*-- so o necessario, na mao.
LOCAL loc_cPath
loc_cPath = gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + ;
            gcCaminhoForms + "," + gcCaminhoIcones
SET PATH TO (loc_cPath)

SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")        ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")      ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "fwprogressbar.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")         ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")        ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "SIGOPCFEBO.prg")        ADDITIVE
SET PROCEDURE TO (gcCaminhoForms   + "operacionais\FormSIGOPCFE.prg") ADDITIVE
= ProbeAnota("CK3 pos-setprocedure")

PUBLIC gnConnHandle
gnConnHandle = -1

PUBLIC goForm
goForm = .NULL.

TRY
    goForm = CREATEOBJECT("FormSIGOPCFE_Probe")
CATCH TO loErr
    = ProbeAnota("EXCECAO CREATEOBJECT: " + loErr.Message + " Ln=" + ;
                 TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure)
ENDTRY

IF VARTYPE(goForm) != "O"
    = ProbeAnota("1 INSTANCIA FALHOU VARTYPE=" + VARTYPE(goForm))
ELSE
    = ProbeAnota("1 INSTANCIA OK BaseClass=" + goForm.BaseClass + ;
                 " ParentClass=" + goForm.ParentClass + ;
                 " Caption=[" + goForm.Caption + "]")

    = ProbeAnota("2 TABINDEX Grupo=" + TRANSFORM(goForm.txt_4c_Grupo.TabIndex) + ;
          " DGrupo=" + TRANSFORM(goForm.txt_4c__Dgrupo.TabIndex) + ;
          " Conta="  + TRANSFORM(goForm.txt_4c_Conta.TabIndex) + ;
          " DConta=" + TRANSFORM(goForm.txt_4c_Dconta.TabIndex) + ;
          " Mat="    + TRANSFORM(goForm.txt_4c_Mat.TabIndex) + ;
          " DMat="   + TRANSFORM(goForm.txt_4c_DMat.TabIndex) + ;
          " ChkSal=" + TRANSFORM(goForm.chk_4c_Chk_Saldo.TabIndex) + ;
          " ChkFal=" + TRANSFORM(goForm.chk_4c_ChkFalha.TabIndex) + ;
          " Proc="   + TRANSFORM(goForm.cmd_4c_Processa.TabIndex) + ;
          " Say1="   + TRANSFORM(goForm.lbl_4c_Label1.TabIndex) + ;
          " CntMsg=" + TRANSFORM(goForm.cnt_4c_Mensagem.TabIndex) + ;
          " Grade="  + TRANSFORM(goForm.grd_4c_Dados.TabIndex) + ;
          " Vis="    + TRANSFORM(goForm.cmd_4c_Visualizar.TabIndex) + ;
          " Imp="    + TRANSFORM(goForm.cmd_4c_Imprimir.TabIndex) + ;
          " Saida="  + TRANSFORM(goForm.cmd_4c_Saida.TabIndex) + ;
          " Say2="   + TRANSFORM(goForm.lbl_4c_Label2.TabIndex) + ;
          " Say5="   + TRANSFORM(goForm.lbl_4c_Label5.TabIndex) + ;
          "  (esperado 1..17 na ordem do SCX)")

    = ProbeAnota("3 INICIAL ResultadoValido=" + TRANSFORM(goForm.this_lResultadoValido) + ;
          " Grade.Visible=" + TRANSFORM(goForm.grd_4c_Dados.Visible) + ;
          " Vis.Enabled="   + TRANSFORM(goForm.cmd_4c_Visualizar.Enabled) + ;
          " Imp.Enabled="   + TRANSFORM(goForm.cmd_4c_Imprimir.Enabled) + ;
          "  (esperado .T. .T. .T. .T.)")

    = ProbeAnota("4 WHEN Mat vazio -> DMat.Enabled=" + ;
                 TRANSFORM(goForm.txt_4c_DMat.Enabled) + "  (esperado .T.)")

    goForm.txt_4c_Mat.Value = "123"
    goForm.HabilitarCampos(.T.)
    = ProbeAnota("5 WHEN Mat=123 -> DMat.Enabled=" + TRANSFORM(goForm.txt_4c_DMat.Enabled) + ;
          " Grupo.Enabled=" + TRANSFORM(goForm.txt_4c_Grupo.Enabled) + ;
          "  (esperado .F. .T.)")

    goForm.HabilitarCampos(.F.)
    = ProbeAnota("6 MESTRA .F. -> Mat.Enabled=" + TRANSFORM(goForm.txt_4c_Mat.Enabled) + ;
          " Grupo.Enabled=" + TRANSFORM(goForm.txt_4c_Grupo.Enabled) + ;
          " ChkFal.Enabled=" + TRANSFORM(goForm.chk_4c_ChkFalha.Enabled) + ;
          "  (esperado .F. .F. .F.)")
    goForm.HabilitarCampos(.T.)

    goForm.this_lResultadoValido = .F.
    goForm.AjustarBotoesPorModo()
    = ProbeAnota("7 SEM RESULTADO Grade.Visible=" + TRANSFORM(goForm.grd_4c_Dados.Visible) + ;
          " Vis.Enabled=" + TRANSFORM(goForm.cmd_4c_Visualizar.Enabled) + ;
          " Imp.Enabled=" + TRANSFORM(goForm.cmd_4c_Imprimir.Enabled) + ;
          "  (esperado .F. .F. .F.)")

    goForm.this_lResultadoValido = .T.
    goForm.AjustarBotoesPorModo()
    = ProbeAnota("8 COM RESULTADO Grade.Visible=" + TRANSFORM(goForm.grd_4c_Dados.Visible) + ;
          " Vis.Enabled=" + TRANSFORM(goForm.cmd_4c_Visualizar.Enabled) + ;
          "  (esperado .T. .T.)")

    *-- Hooks PROTECTED: alcancados de DENTRO da hierarquia
    = ProbeAnota(goForm.ProbeHooks())

    goForm.CarregarDados()
    = ProbeAnota("12 CarregarDados RecordSource=[" + goForm.grd_4c_Dados.RecordSource + ;
          "] Cols=" + TRANSFORM(goForm.grd_4c_Dados.ColumnCount) + ;
          " H1=[" + goForm.grd_4c_Dados.Column1.Header1.Caption + "]" + ;
          " W=" + TRANSFORM(goForm.grd_4c_Dados.Column1.Width) + "/" + ;
          TRANSFORM(goForm.grd_4c_Dados.Column2.Width) + "/" + ;
          TRANSFORM(goForm.grd_4c_Dados.Column3.Width) + "/" + ;
          TRANSFORM(goForm.grd_4c_Dados.Column4.Width) + "/" + ;
          TRANSFORM(goForm.grd_4c_Dados.Column5.Width) + ;
          "  (esperado 80/196/80/86/83)")

    goForm.txt_4c_Mat.Value = ""
    TRY
        goForm.CmdProcessaClick()
        = ProbeAnota("13 CmdProcessaClick sem material OK Mensagem.Visible=" + ;
              TRANSFORM(goForm.cnt_4c_Mensagem.Visible) + ;
              " Mat.Enabled=" + TRANSFORM(goForm.txt_4c_Mat.Enabled) + ;
              "  (esperado .F. .T.)")
    CATCH TO loErr
        = ProbeAnota("13 EXCECAO CmdProcessaClick: " + loErr.Message + " Ln=" + ;
              TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure)
    ENDTRY

    goForm = .NULL.
    = ProbeAnota("14 LIBERADO")
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    = ProbeAnota("--- ArquivoErroTeste ---" + CHR(13) + CHR(10) + ;
                 FILETOSTR(gc_4c_ArquivoErroTeste))
ENDIF

= ProbeAnota("FIM")
QUIT

PROCEDURE ProbeAnota(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_ProbeLog, 1)
    RETURN .T.
ENDPROC

PROCEDURE ProbeErro(par_nErro, par_cMensagem, par_nLinha, par_cPrograma)
    STRTOFILE("ON ERROR #" + TRANSFORM(par_nErro) + " " + par_cMensagem + ;
              " Ln=" + TRANSFORM(par_nLinha) + " Prog=" + par_cPrograma + ;
              CHR(13) + CHR(10), gc_4c_ProbeLog, 1)
    RETURN
ENDPROC

*==============================================================================
* FormSIGOPCFE_Probe - subclasse SO do probe: expoe os hooks PROTECTED
* (FormParaBO/BOParaForm/LimparCampos) chamando-os por THIS., de dentro da
* hierarquia, que eh a unica forma de exercita-los sem alterar o FormBase.
*==============================================================================
DEFINE CLASS FormSIGOPCFE_Probe AS FormSIGOPCFE

    PROCEDURE ProbeHooks()
        LOCAL loc_cOut
        loc_cOut = ""

        THIS.txt_4c_Mat.Value       = "ABC123"
        THIS.txt_4c_DMat.Value      = "PRODUTO TESTE"
        THIS.txt_4c_Grupo.Value     = "G01"
        THIS.txt_4c__Dgrupo.Value   = "GRUPO TESTE"
        THIS.txt_4c_Conta.Value     = "C01"
        THIS.txt_4c_Dconta.Value    = "CONTA TESTE"
        THIS.chk_4c_Chk_Saldo.Value = 1
        THIS.chk_4c_ChkFalha.Value  = 1
        THIS.FormParaBO()
        loc_cOut = loc_cOut + "9 FormParaBO BO.Mat=[" + THIS.this_oBusinessObject.this_cMaterial + ;
              "] BO.DescMat=[" + THIS.this_oBusinessObject.this_cDescMaterial + ;
              "] BO.Grupo=[" + THIS.this_oBusinessObject.this_cGrupo + ;
              "] BO.Conta=[" + THIS.this_oBusinessObject.this_cConta + ;
              "] SemZero=" + TRANSFORM(THIS.this_oBusinessObject.this_lNaoMostrarSaldosZerados) + ;
              " SemFalha=" + TRANSFORM(THIS.this_oBusinessObject.this_lNaoChecarFalha) + ;
              CHR(13) + CHR(10)

        THIS.this_oBusinessObject.this_cMaterial       = "ZZZ999"
        THIS.this_oBusinessObject.this_cDescGrupo      = "OUTRO GRUPO"
        THIS.this_oBusinessObject.this_lNaoChecarFalha = .F.
        THIS.BOParaForm()
        loc_cOut = loc_cOut + "10 BOParaForm Mat=[" + ALLTRIM(THIS.txt_4c_Mat.Value) + ;
              "] DGrupo=[" + ALLTRIM(THIS.txt_4c__Dgrupo.Value) + ;
              "] ChkFal.Value=" + TRANSFORM(THIS.chk_4c_ChkFalha.Value) + ;
              " UltMatValidado=[" + THIS.this_cUltimoMatValidado + "]" + ;
              "  (esperado ZZZ999 / OUTRO GRUPO / 0 / ZZZ999)" + CHR(13) + CHR(10)

        THIS.LimparCampos()
        loc_cOut = loc_cOut + "11 LimparCampos Mat=[" + ALLTRIM(THIS.txt_4c_Mat.Value) + ;
              "] Conta=[" + ALLTRIM(THIS.txt_4c_Conta.Value) + ;
              "] ChkSal=" + TRANSFORM(THIS.chk_4c_Chk_Saldo.Value) + ;
              " BO.Mat=[" + THIS.this_oBusinessObject.this_cMaterial + ;
              "] BO.Qtde=" + TRANSFORM(THIS.this_oBusinessObject.this_nQtdeRegistros) + ;
              " Saldo.Recs=" + TRANSFORM(IIF(USED("cursor_4c_Saldo"), RECCOUNT("cursor_4c_Saldo"), -1)) + ;
              " DMat.Enabled=" + TRANSFORM(THIS.txt_4c_DMat.Enabled) + ;
              " Grade.Visible=" + TRANSFORM(THIS.grd_4c_Dados.Visible)

        RETURN loc_cOut
    ENDPROC

ENDDEFINE
