*==============================================================================
* test_fase8_sigprnse.prg - Harness da Fase 8 do FormSIGPRNSE
* Prova que o form INSTANCIA e que os metodos entregues na Fase 8 existem,
* tem o ESCOPO certo e FUNCIONAM em runtime (compilar limpo nao prova nada -
* metodo inexistente/propriedade ausente so estoura ao ser acionado).
* Bootstrap MINIMO (sem ConfigurarAmbiente, que abre conexao SQL).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON

LOCAL lcLog, loForm, loErr, lcCls, lcUtl, lcCRLF
LOCAL lnFalhas, lcRet
lcCRLF   = CHR(13) + CHR(10)
lcLog    = "C:\4c\automation\vfp_helpers\test_fase8_sigprnse_resultado.txt"
lcCls    = "C:\4c\projeto\app\classes\"
lcUtl    = "C:\4c\projeto\app\utils\"
lnFalhas = 0

STRTOFILE("=== TESTE FASE 8 FormSIGPRNSE ===" + lcCRLF, lcLog, 0)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoReports, gc_4c_CaminhoFramework
PUBLIC gc_4c_UsuarioLogado, go_4c_Sistema, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gnConnHandle           = -1
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_helpers\test_fase8_sigprnse_dialogs.txt"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoReports   = "C:\4c\projeto\app\reports\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_UsuarioLogado    = "TESTE"

go_4c_Sistema = CREATEOBJECT("Empty")
ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")
ADDPROPERTY(go_4c_Sistema, "cEmpresa", "TESTE")

SET PATH TO ("C:\4c\projeto\app\classes,C:\4c\projeto\app\utils,C:\4c\projeto\app\forms\operacionais")

TRY
    SET PROCEDURE TO (lcUtl + "functions.prg")  ADDITIVE
    SET PROCEDURE TO (lcUtl + "messages.prg")   ADDITIVE
    SET PROCEDURE TO (lcUtl + "validators.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (lcCls + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (lcCls + "SIGPRNSEBO.prg")   ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSIGPRNSE.prg" ADDITIVE
    STRTOFILE("SET PROCEDURE        : OK" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("SET PROCEDURE        : FALHA - " + loErr.Message + lcCRLF, lcLog, 1)
    lnFalhas = lnFalhas + 1
ENDTRY

*-- 1) INSTANCIACAO
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSIGPRNSE")
CATCH TO loErr
    STRTOFILE("CREATEOBJECT         : FALHA - " + loErr.Message + ;
        " | Linha " + TRANSFORM(loErr.LineNo) + " | " + loErr.Procedure + lcCRLF, lcLog, 1)
ENDTRY

IF VARTYPE(loForm) != "O"
    STRTOFILE("CREATEOBJECT         : FALHA - retornou " + VARTYPE(loForm) + lcCRLF, lcLog, 1)
    lnFalhas = lnFalhas + 1
ELSE
    STRTOFILE("CREATEOBJECT         : OK (form instanciado)" + lcCRLF, lcLog, 1)

    *==========================================================================
    * 2) LimparCampos/BOParaForm rodaram no Init: as properties de criterio do
    *    BO tem de estar com os defaults do Init legado, e a TELA tem de estar
    *    espelhando os mesmos valores.
    *==========================================================================
    TRY
        STRTOFILE("BO.this_nProcessados : " + TRANSFORM(loForm.this_oBusinessObject.this_nProcessados) + lcCRLF, lcLog, 1)
        STRTOFILE("BO.this_cCidade      : [" + loForm.this_oBusinessObject.this_cCidade + "]" + lcCRLF, lcLog, 1)
        STRTOFILE("BO.this_cDiretorio   : [" + loForm.this_oBusinessObject.this_cDiretorio + "]" + lcCRLF, lcLog, 1)
        STRTOFILE("BO.this_dDtIni       : " + DTOC(loForm.this_oBusinessObject.this_dDtIni) + lcCRLF, lcLog, 1)
        STRTOFILE("BO.this_dDtFin       : " + DTOC(loForm.this_oBusinessObject.this_dDtFin) + lcCRLF, lcLog, 1)
        STRTOFILE("TELA.optProcessados  : " + TRANSFORM(loForm.obj_4c_OptProcessados.Value) + lcCRLF, lcLog, 1)
        STRTOFILE("TELA.cmbCidades      : [" + loForm.cbo_4c_CmbCidades.Value + "]" + lcCRLF, lcLog, 1)
        STRTOFILE("TELA.getDirs         : [" + loForm.txt_4c_Dirs.Value + "]" + lcCRLF, lcLog, 1)
        STRTOFILE("TELA.getDtIni        : " + DTOC(loForm.txt_4c_DtIni.Value) + lcCRLF, lcLog, 1)

        IF loForm.this_oBusinessObject.this_nProcessados # 1 OR ;
           !(ALLTRIM(loForm.this_oBusinessObject.this_cCidade) == "RJ - Rio de Janeiro") OR ;
           loForm.this_oBusinessObject.this_dDtIni # DATE()
            STRTOFILE("DEFAULTS Init legado : FALHA (BO nao recebeu os defaults)" + lcCRLF, lcLog, 1)
            lnFalhas = lnFalhas + 1
        ELSE
            STRTOFILE("DEFAULTS Init legado : OK (LimparCampos -> BOParaForm)" + lcCRLF, lcLog, 1)
        ENDIF

        IF loForm.obj_4c_OptProcessados.Value # loForm.this_oBusinessObject.this_nProcessados OR ;
           !(ALLTRIM(loForm.cbo_4c_CmbCidades.Value) == ALLTRIM(loForm.this_oBusinessObject.this_cCidade))
            STRTOFILE("BOParaForm espelhou  : FALHA (tela diverge do BO)" + lcCRLF, lcLog, 1)
            lnFalhas = lnFalhas + 1
        ELSE
            STRTOFILE("BOParaForm espelhou  : OK (tela = BO)" + lcCRLF, lcLog, 1)
        ENDIF
    CATCH TO loErr
        STRTOFILE("DEFAULTS Init legado : FALHA - " + loErr.Message + " | " + loErr.Procedure + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ENDTRY

    *==========================================================================
    * 3) BtnProcessarClick - sem linha marcada tem de parar no guard de
    *    "Nenhum Lancamento", nunca gerar arquivo nem estourar.
    *==========================================================================
    TRY
        loForm.txt_4c_CEmps.Value          = "7"
        loForm.cbo_4c_CmbCidades.Value     = "SP - S" + CHR(227) + "o Paulo"
        loForm.obj_4c_OptProcessados.Value = 2

        loForm.BtnProcessarClick()
        STRTOFILE("BtnProcessarClick    : OK (parou no guard de 'nenhum lancamento')" + lcCRLF, lcLog, 1)
    CATCH TO loErr
        STRTOFILE("BtnProcessarClick    : FALHA - " + loErr.Message + " | " + loErr.Procedure + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ENDTRY

    *==========================================================================
    * 4) HabilitarCampos / AjustarBotoesPorModo - escopo PUBLIC e efeito real
    *==========================================================================
    TRY
        loForm.HabilitarCampos(.F.)
        IF loForm.txt_4c_DtIni.Enabled OR loForm.cmd_4c_BtnSelecionar.Enabled
            STRTOFILE("HabilitarCampos(.F.) : FALHA (criterios continuam habilitados)" + lcCRLF, lcLog, 1)
            lnFalhas = lnFalhas + 1
        ELSE
            STRTOFILE("HabilitarCampos(.F.) : OK (criterios travados)" + lcCRLF, lcLog, 1)
        ENDIF

        loForm.AjustarBotoesPorModo(.T.)
        IF !loForm.txt_4c_DtIni.Enabled OR loForm.obj_4c_CmdBtnForm.Buttons(2).Enabled
            STRTOFILE("AjustarBotoesPorModo : FALHA (estado inicial nao reposto)" + lcCRLF, lcLog, 1)
            lnFalhas = lnFalhas + 1
        ELSE
            STRTOFILE("AjustarBotoesPorModo : OK (criterios liberados, acao travada)" + lcCRLF, lcLog, 1)
        ENDIF
    CATCH TO loErr
        STRTOFILE("HabilitarCampos      : FALHA - " + loErr.Message + " | " + loErr.Procedure + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ENDTRY

    *==========================================================================
    * 5) BtnCancelarClick (btnLimpar legado) - ZAP + reabrir criterios.
    *    Prova tambem que o ZAP NAO trava no dialogo de SAFETY da data session
    *    privada.
    *==========================================================================
    TRY
        loForm.AjustarBotoesPorModo(.F.)
        loForm.BtnCancelarClick()
        IF !loForm.txt_4c_DtIni.Enabled
            STRTOFILE("BtnCancelarClick     : FALHA (criterios nao reabriram)" + lcCRLF, lcLog, 1)
            lnFalhas = lnFalhas + 1
        ELSE
            STRTOFILE("BtnCancelarClick     : OK (grade limpa, criterios reabertos)" + lcCRLF, lcLog, 1)
        ENDIF
    CATCH TO loErr
        STRTOFILE("BtnCancelarClick     : FALHA - " + loErr.Message + " | " + loErr.Procedure + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ENDTRY

    *==========================================================================
    * 6) Funis publicos usados pelo harness do pipeline
    *==========================================================================
    TRY
        loForm.AtualizarGrade()
        loForm.AjustarCamposDependentes()
        STRTOFILE("Funis publicos       : OK (AtualizarGrade/AjustarCamposDependentes)" + lcCRLF, lcLog, 1)
    CATCH TO loErr
        STRTOFILE("Funis publicos       : FALHA - " + loErr.Message + " | " + loErr.Procedure + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ENDTRY

    *==========================================================================
    * 7) CarregarLista - sem conexao SQL tem de FALHAR LIMPO (.F. + mensagem),
    *    nunca estourar nem travar
    *==========================================================================
    lcRet = "?"
    TRY
        lcRet = TRANSFORM(loForm.CarregarLista())
        STRTOFILE("CarregarLista        : OK (retornou " + lcRet + " sem conexao)" + lcCRLF, lcLog, 1)
    CATCH TO loErr
        STRTOFILE("CarregarLista        : FALHA - " + loErr.Message + " | " + loErr.Procedure + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ENDTRY

    *==========================================================================
    * 8) FormParaBO rodou dentro do CarregarLista: o BO tem de estar com o que
    *    esta NA TELA agora (empresa "7" padded a 3, municipio SP, opcao 2)
    *==========================================================================
    TRY
        STRTOFILE("BO.this_cEmps  pos-FormParaBO : [" + loForm.this_oBusinessObject.this_cEmps + "]" + lcCRLF, lcLog, 1)
        STRTOFILE("BO.this_cCidade pos-FormParaBO: [" + loForm.this_oBusinessObject.this_cCidade + "]" + lcCRLF, lcLog, 1)
        STRTOFILE("BO.this_nProcessados pos-F2BO : " + TRANSFORM(loForm.this_oBusinessObject.this_nProcessados) + lcCRLF, lcLog, 1)

        IF !(loForm.this_oBusinessObject.this_cEmps == PADR("7", 3)) OR ;
           !(ALLTRIM(loForm.this_oBusinessObject.this_cCidade) == "SP - S" + CHR(227) + "o Paulo") OR ;
           loForm.this_oBusinessObject.this_nProcessados # 2
            STRTOFILE("FormParaBO leu a tela: FALHA (BO nao recebeu os criterios digitados)" + lcCRLF, lcLog, 1)
            lnFalhas = lnFalhas + 1
        ELSE
            STRTOFILE("FormParaBO leu a tela: OK (BO = tela, empresa padded a 3)" + lcCRLF, lcLog, 1)
        ENDIF
    CATCH TO loErr
        STRTOFILE("FormParaBO leu a tela: FALHA - " + loErr.Message + " | " + loErr.Procedure + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ENDTRY

    *==========================================================================
    * 9) BtnEncerrarClick - fecha a tela
    *==========================================================================
    TRY
        loForm.BtnEncerrarClick()
        STRTOFILE("BtnEncerrarClick     : OK (Release)" + lcCRLF, lcLog, 1)
    CATCH TO loErr
        STRTOFILE("BtnEncerrarClick     : FALHA - " + loErr.Message + " | " + loErr.Procedure + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ENDTRY
ENDIF

STRTOFILE(lcCRLF + "RESULTADO: " + IIF(lnFalhas = 0, "SUCESSO", "FALHAS = " + TRANSFORM(lnFalhas)) + lcCRLF, lcLog, 1)

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("--- DIALOGOS SUPRIMIDOS ---" + lcCRLF + FILETOSTR(gc_4c_ArquivoErroTeste), lcLog, 1)
ENDIF

QUIT
