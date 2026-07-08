*==============================================================================
* FormSigPrCtc.prg - Cotacoes por Operacoes
* Herda de: FormBase
* Migracao de: SIGPRCTC.SCX
*
* Pilares:
*   UX   -> pixel-perfect com layout do sistema novo (PageFrame + containers)
*   BD   -> tabela SIGPRCTC (EmpDopNums / cMoes / Valos / pkChaves)
*   CODE -> arquitetura em camadas (FormBase / SigPrCtcBO)
*
* Uso:
*   loForm = CREATEOBJECT("FormSigPrCtc", loParentForm, nDataSes, cEscolha, cEmps, cDopes, nNumes)
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()
*   ENDIF
*==============================================================================

DEFINE CLASS FormSigPrCtc AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cota" + CHR(231) + CHR(245) + "es por Opera" + CHR(231) + CHR(245) + "es"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Business Object e controle de modo
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *-- Referencia ao formulario pai (dialogo modal aberto de outro form)
    this_oParentForm = .NULL.

    *-- Chave combinada de operacao (pcEmps + pcDopes + STR(pnNumes,6))
    this_pcEdn = ""

    *-- Componentes individuais da chave de operacao
    this_pcEmps  = ""
    this_pcDopes = ""
    this_pnNumes = 0

    *-- Restricao de operacao passada pelo pai (INSERIR / ALTERAR / VISUALIZAR)
    this_pcEscolha = ""

    *-- Flags de rastreamento da sessao de edicao
    this_lHouveIns  = .F.
    this_lHouveExcl = .F.

    *==========================================================================
    * Init - Recebe parametros do form pai e delega ao FormBase.Init
    *==========================================================================
    PROCEDURE Init(par_oParentForm, par_nDataSes, par_cEscolha, par_cEmps, par_cDopes, par_nNumes)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_oParentForm) = "O"
                THIS.this_oParentForm         = par_oParentForm
                THIS.this_oParentForm.Enabled = .F.
            ENDIF

            THIS.this_pcEscolha = IIF(VARTYPE(par_cEscolha) = "C", ALLTRIM(par_cEscolha), "")
            THIS.this_pcEmps    = IIF(VARTYPE(par_cEmps)    = "C", par_cEmps,              "")
            THIS.this_pcDopes   = IIF(VARTYPE(par_cDopes)   = "C", par_cDopes,             "")
            THIS.this_pnNumes   = IIF(VARTYPE(par_nNumes)   = "N", par_nNumes,             0)
            THIS.this_pcEdn     = ALLTRIM(THIS.this_pcEmps) + ALLTRIM(THIS.this_pcDopes) + ;
                                  STR(THIS.this_pnNumes, 6)

            THIS.Caption = "Cota" + CHR(231) + CHR(245) + "es " + ;
                           PROPER(ALLTRIM(THIS.this_pcEdn))

            loc_lSucesso = DODEFAULT()
        CATCH TO loException
            MsgErro("Erro ao inicializar FormSigPrCtc: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura base (chamado pelo FormBase.Init)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        *-- Skip carga de dados durante validacao UI (RETURN permitido FORA do TRY)
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            THIS.ConfigurarPageFrame()
            RETURN .T.
        ENDIF

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrCtcBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cEscolha = THIS.this_pcEscolha
                THIS.this_oBusinessObject.this_cEmps    = THIS.this_pcEmps
                THIS.this_oBusinessObject.this_cDopes   = THIS.this_pcDopes
                THIS.this_oBusinessObject.this_nNumes   = THIS.this_pnNumes
                THIS.this_oBusinessObject.this_cEmpDopNums = THIS.this_pcEdn

                IF PEMSTATUS(THIS.this_oBusinessObject, "InicializarCursor", 5)
                    THIS.this_oBusinessObject.InicializarCursor()
                ENDIF

                THIS.ConfigurarPageFrame()

                THIS.this_cModoAtual = "LISTA"

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SigPrCtcBO", "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em InicializarForm: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * e os containers principais vazios (populados nas fases seguintes)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf, loc_oPg1, loc_oPg2

        TRY
            *-- PageFrame principal (Top=-29 esconde as abas)
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")
            loc_oPgf = THIS.pgf_4c_Paginas
            WITH loc_oPgf
                .PageCount   = 2
                .Top         = -29
                .Left        = 0
                .Width       = THIS.Width
                .Height      = THIS.Height + 29
                .Tabs        = .F.
                .TabStyle    = 1
                .Themes      = .F.
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            *-- Page1 (Lista): grade de cotacoes + botoes CRUD
            loc_oPg1 = loc_oPgf.Page1
            loc_oPg1.Caption   = "Lista"
            loc_oPg1.BackColor = RGB(255, 255, 255)

            *-- Container do cabecalho (barra escura superior com titulo)
            loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPg1.cnt_4c_Cabecalho
                .Top         = 2 + 29
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            *-- Container dos botoes CRUD (lado direito da Page1)
            loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
            WITH loc_oPg1.cnt_4c_Botoes
                .Top         = 0 + 29
                .Left        = 542
                .Width       = 390
                .Height      = 85
                .BackStyle   = 1
                .BackColor   = RGB(53, 53, 53)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            *-- Page2 (Dados): campos de edicao + botoes Salvar/Cancelar
            loc_oPg2 = loc_oPgf.Page2
            loc_oPg2.Caption   = "Dados"
            loc_oPg2.BackColor = RGB(255, 255, 255)

            *-- Container dos botoes de acao (Salvar/Cancelar) na Page2
            loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
            WITH loc_oPg2.cnt_4c_BotoesAcao
                .Top         = 4 + 29
                .Left        = 842
                .Width       = 160
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            loc_oPgf.ActivePage = 1
        CATCH TO loException
            MsgErro("Erro ao configurar PageFrame: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Percorre PageFrame.Pages e Containers filhos
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oCtrl, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oCtrl) = "O"
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF

                IF UPPER(loc_oCtrl.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oCtrl.PageCount
                        THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_nP))
                    NEXT
                ENDIF

                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oCtrl)
                ENDIF
            ENDIF
        NEXT
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos e reabilita o formulario pai
    *==========================================================================
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oParentForm) = "O"
                IF PEMSTATUS(THIS.this_oParentForm, "Enabled", 5)
                    THIS.this_oParentForm.Enabled = .T.
                ENDIF
            ENDIF

            IF USED("cursor_4c_CtMoe")
                USE IN cursor_4c_CtMoe
            ENDIF
            IF USED("cursor_4c_Totais")
                USE IN cursor_4c_Totais
            ENDIF
            IF USED("cursor_4c_StgCtc")
                USE IN cursor_4c_StgCtc
            ENDIF

            THIS.this_oBusinessObject = .NULL.
            THIS.this_oParentForm     = .NULL.

            DODEFAULT()
        CATCH TO loException
            MsgErro("Erro em FormSigPrCtc.Destroy: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE
