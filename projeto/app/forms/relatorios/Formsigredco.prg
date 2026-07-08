*==============================================================================
* FORMSIGREDCO.PRG
* Caixa de di" + CHR(225) + "logo de Impress" + CHR(227) + "o de Documento de Ordem
* Tipo: modal print dialog (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREDCO.SCX (frmrelatorio)
*
* Form modal pequeno (798x128) chamado por Formsigredcu com parametros.
* Exibe 2 checkboxes (NF/Incentivos) e 4 botoes (Visualizar/Imprimir/Excel/Sair).
* Seleciona FRX correto (SigReDco3/4/5/6) conforme empresa e opcoes.
*
* FASE 8/8 - IMPLEMENTACAO COMPLETA
* Estrutura: SIGREDCO e um dialogo de impressao simples (798x128px) sem
* TextBoxes, labels de dados nem campos com lookup (F4/F5). Todos os
* componentes originais foram migrados:
*   - Init com LPARAMETERS (qbols/Pcnx/cEmail/pEmp/pDop/pNum/pImpress/pForm/pChkImpDoc)
*   - InicializarForm: cria BO, CarregarLocalEmp, CarregarParametrosOperacao
*   - ConfigurarCabecalho: container escuro com titulo
*   - ConfigurarBotoesRelatorio: CommandGroup 4 botoes (Visualizar/Imprimir/DocExcel/Sair)
*   - ConfigurarCheckboxes: chk_4c_ChkNf + chk_4c_ChkIcentivo com confirmacao
*   - ConfigurarPaginaLista: estado inicial dos checkboxes por parametro
*   - ConfigurarPaginaDados: oculta checkboxes (DigItens 6/7) ou renomeia (P&G)
*   - FormParaRelatorio, ChkNfClick, ChkIncentivoClick
*   - BtnVisualizarClick, BtnImprimirClick, BtnDocExcelClick, BtnSairClick
*   - AlternarPagina, Destroy
*
* INTEGRACAO: config.prg carrega automaticamente via ADIR (sem alteracao manual).
* MENU: este form NAO tem entrada de menu - e um dialogo modal parametrizado
*   chamado por Formsigredcu com 9 parametros (qbols, conexao, email, empresa,
*   operacao, numero, tpImpressao, oForm, lChkImpDoc). Nao pode ser aberto
*   diretamente pelo usuario sem esses parametros.
* Metodos CRUD (BtnBuscarClick, FormParaBO, BOParaForm, HabilitarCampos,
*   CarregarLista) NAO se aplicam a forms frmrelatorio - equivalentes corretos
*   ja implementados: FormParaRelatorio() + 4 handlers de botoes de acao.
*==============================================================================

DEFINE CLASS Formsigredco AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original: Width=798, Height=128)
    Caption     = "Impress" + CHR(227) + "o de Documento"
    Height      = 128
    Width       = 798
    DataSession = 1
    ShowWindow  = 1
    WindowType  = 1
    AlwaysOnTop = .T.
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.

    *-- BO de relatorio e referencia ao form chamador
    this_oRelatorio      = .NULL.
    this_oFormChamador   = .NULL.
    this_cMensagemErro   = ""

    *-- Parametros recebidos em Init() via LPARAMETERS
    this_nQbols          = 0     && Quantidade de documentos a imprimir
    this_cEmps           = ""    && Codigo da empresa
    this_cDopes          = ""    && Tipo de operacao
    this_nNumes          = 0     && Numero do documento
    this_nTpImpressao    = 0     && Tipo impressao: 0=normal 2=sem prompt 3/4=direto
    this_cEmail          = ""    && Email para envio
    this_lChkImpDoc      = .F.   && Flag impressao documento
    this_lChkImpDocAcess = .F.   && Flag impressao documento acesso

    *--------------------------------------------------------------------------
    * Init - Recebe parametros do form chamador, configura BO e forma base
    * LPARAMETERS: qbols, Pcnx, cEmail, pEmp, pDop, pNum, pImpress, pForm, pChkImpDoc
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_nQbols, par_nConexao, par_cEmail, par_cEmps, par_cDopes, par_nNumes, par_nImpress, par_oForm, par_lChkImpDoc
        LOCAL loc_lSucesso

        *-- Armazena parametros ANTES de chamar InicializarForm via DODEFAULT
        THIS.this_nQbols       = IIF(TYPE("par_nQbols")      = "N", par_nQbols,          1)
        THIS.this_cEmps        = IIF(TYPE("par_cEmps")       = "C", ALLTRIM(par_cEmps),  "")
        THIS.this_cDopes       = IIF(TYPE("par_cDopes")      = "C", ALLTRIM(par_cDopes), "")
        THIS.this_nNumes       = IIF(TYPE("par_nNumes")      = "N", par_nNumes,          0)
        THIS.this_nTpImpressao = IIF(TYPE("par_nImpress")    = "N", par_nImpress,        0)
        THIS.this_cEmail       = IIF(TYPE("par_cEmail")      = "C", ALLTRIM(par_cEmail), "")
        THIS.this_lChkImpDoc   = IIF(TYPE("par_lChkImpDoc")  = "L", par_lChkImpDoc,     .F.)

        *-- Guarda referencia e desabilita form chamador enquanto este esta aberto
        IF VARTYPE(par_oForm) = "O"
            THIS.this_oFormChamador = par_oForm
            par_oForm.Enabled = .F.
        ENDIF

        *-- Caption dinamico: "Impressao de Documento (DOP/NUM)" - apenas quando parametros foram fornecidos
        IF !EMPTY(THIS.this_cDopes) OR THIS.this_nNumes > 0
            THIS.Caption = "Impress" + CHR(227) + "o de Documento (" + ;
                ALLTRIM(THIS.this_cDopes) + "/" + ALLTRIM(STR(THIS.this_nNumes)) + ")"
        ENDIF

        loc_lSucesso = DODEFAULT()

        *-- TpImpressao 3 ou 4: imprimir direto e nao exibir o form
        IF loc_lSucesso AND INLIST(THIS.this_nTpImpressao, 3, 4)
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.this_oRelatorio.this_lImpNf   = .F.
                THIS.this_oRelatorio.this_lImpIcen = .F.
                THIS.this_oRelatorio.Imprimir()
                THIS.this_oRelatorio = .NULL.
            ENDIF
            SET PRINTER TO DEFAULT
            IF VARTYPE(THIS.this_oFormChamador) = "O"
                THIS.this_oFormChamador.Enabled = .T.
                THIS.this_oFormChamador = .NULL.
            ENDIF
            RETURN .F.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria BO, carrega dados da empresa/operacao, monta layout
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instancia o BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("sigredcoBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigredcoBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            *-- Transfere parametros para o BO
            IF loc_lContinuar
                WITH THIS.this_oRelatorio
                    .this_nQbols       = THIS.this_nQbols
                    .this_cEmps        = THIS.this_cEmps
                    .this_cDopes       = THIS.this_cDopes
                    .this_nNumes       = THIS.this_nNumes
                    .this_nTpImpressao = THIS.this_nTpImpressao
                    .this_cEmail       = THIS.this_cEmail
                    .this_lChkImpDoc   = THIS.this_lChkImpDoc
                ENDWITH
            ENDIF

            *-- Carrega DivNotas da empresa (pula em modo validacao UI - sem conexao SQL)
            IF loc_lContinuar AND ;
               (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                IF !THIS.this_oRelatorio.CarregarLocalEmp()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Carrega parametros de casas decimais a partir dos cursors do form chamador
            *   (crSigCdOpe, crSigOpCdd) - CarregarParametrosOperacao trata cursors ausentes
            IF loc_lContinuar
                THIS.this_oRelatorio.CarregarParametrosOperacao()

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestra a montagem do layout do form de relatorio
    *
    * Form REPORT (frmrelatorio): layout FLAT sem PageFrame CRUD.
    * Cabecalho escuro + CommandGroup de botoes de acao (direita) +
    * checkboxes de opcoes de impressao (abaixo do cabecalho).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoesRelatorio()
        THIS.ConfigurarCheckboxes()
        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura estado inicial das opcoes de impressao
    *
    * Em forms REPORT (frmrelatorio) o layout e FLAT - nao ha Page1 de lista
    * nem Page2 de dados. Este metodo equivale a "configurar a lista de opcoes"
    * que o usuario tem para o relatorio: marca/desmarca os checkboxes de NF
    * e Incentivos conforme parametros recebidos do form chamador
    * (this_lChkImpDoc, this_nTpImpressao) e o tipo de empresa (DivNotas).
    *
    * Logica original (SIGREDCO.Init): se ChkImpDoc=.T. ou TpImpressao=1/3,
    * marca chkNf por default; Incentivos sempre comeca desmarcado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_lMarcarNf

        loc_lMarcarNf = THIS.this_lChkImpDoc OR ;
            INLIST(THIS.this_nTpImpressao, 1, 3)

        IF VARTYPE(THIS.chk_4c_ChkNf) = "O"
            THIS.chk_4c_ChkNf.Value = IIF(loc_lMarcarNf, 1, 0)
        ENDIF

        IF VARTYPE(THIS.chk_4c_ChkIcentivo) = "O"
            THIS.chk_4c_ChkIcentivo.Value = 0
        ENDIF

        *-- Sincroniza estado inicial dos checkboxes para o BO
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_lImpNf   = loc_lMarcarNf
            THIS.this_oRelatorio.this_lImpIcen = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Despacha acao do relatorio conforme par_nPagina
    *
    * Em forms REPORT (frmrelatorio) nao ha Page1/Page2 para alternar - este
    * metodo eh o equivalente funcional do "alternar pagina" CRUD: despacha
    * para uma das 4 acoes do CommandGroup superior conforme o codigo:
    *   1 = Visualizar (preview)
    *   2 = Imprimir (impressora padrao)
    *   3 = DocExcel  (impressao direta sem prompt)
    *   4 = Sair      (fecha o form, restaura impressora padrao)
    *
    * Permite invocar acoes do relatorio via codigo (testes / shortcuts /
    * RemoteTrigger) sem depender do Click direto dos botoes.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nAcao
        loc_nAcao = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 0)

        DO CASE
            CASE loc_nAcao = 1
                THIS.BtnVisualizarClick()
            CASE loc_nAcao = 2
                THIS.BtnImprimirClick()
            CASE loc_nAcao = 3
                THIS.BtnDocExcelClick()
            CASE loc_nAcao = 4
                THIS.BtnSairClick()
            OTHERWISE
                MsgAviso("AlternarPagina: a" + CHR(231) + CHR(227) + "o inv" + ;
                    CHR(225) + "lida (" + ALLTRIM(STR(loc_nAcao)) + ;
                    "). Use 1=Visualizar, 2=Imprimir, 3=DocExcel, 4=Sair.", "Aviso")
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro com titulo do form (cntSombra do legado)
    * Ocupa o topo do form (Height=85); botoes e checkboxes sao adicionados
    * sobre/abaixo em fases posteriores
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top           = 0
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 85
            .BackStyle     = 1
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 12
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Caption   = "Impress" + CHR(227) + "o de Documento"
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 12
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Caption   = "Impress" + CHR(227) + "o de Documento"
                .Visible   = .T.
            ENDWITH

            .Visible = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesRelatorio - CommandGroup com 4 botoes de acao (direita)
    * Geometria: Top=0, Left=525, Width=273, Height=80 (direita do cabecalho)
    * Ordem: Visualizar | Imprimir | DocExcel | Sair
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesRelatorio()
        LOCAL loc_oCmg
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        loc_oCmg = THIS.cmg_4c_Botoes
        WITH loc_oCmg
            .Top           = 0
            .Left          = 525
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1

            WITH .Buttons(1)
                .Caption         = "Visualizar"
                .Left            = 5
                .Top             = 5
                .Width           = 65
                .Height          = 70
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            ENDWITH

            WITH .Buttons(2)
                .Caption         = "Imprimir"
                .Left            = 71
                .Top             = 5
                .Width           = 65
                .Height          = 70
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            ENDWITH

            WITH .Buttons(3)
                .Caption         = "DocExcel"
                .Left            = 137
                .Top             = 5
                .Width           = 65
                .Height          = 70
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
            ENDWITH

            WITH .Buttons(4)
                .Caption         = "Sair"
                .Left            = 203
                .Top             = 5
                .Width           = 65
                .Height          = 70
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .Cancel          = .T.
            ENDWITH

            .Visible = .T.
        ENDWITH

        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCheckboxes - Opcoes de impressao (abaixo do cabecalho)
    * chkNf (top=87): Imprimir Totais de NF / Descritivo (P&G)
    * chkIcentivo (top=104): Imprimir Incentivos / Versao Completa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCheckboxes()
        THIS.AddObject("chk_4c_ChkNf", "CheckBox")
        WITH THIS.chk_4c_ChkNf
            .Top       = 87
            .Left      = 339
            .Width     = 170
            .Height    = 17
            .Caption   = "Imprimir Totais de NF"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("chk_4c_ChkIcentivo", "CheckBox")
        WITH THIS.chk_4c_ChkIcentivo
            .Top       = 104
            .Left      = 339
            .Width     = 170
            .Height    = 17
            .Caption   = "Imprimir Incentivos"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        BINDEVENT(THIS.chk_4c_ChkNf,       "Click", THIS, "ChkNfClick")
        BINDEVENT(THIS.chk_4c_ChkIcentivo, "Click", THIS, "ChkIncentivoClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Sincroniza opcoes dos checkboxes para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            WITH THIS.this_oRelatorio
                .this_lImpNf   = (THIS.chk_4c_ChkNf.Value       = 1)
                .this_lImpIcen = (THIS.chk_4c_ChkIcentivo.Value = 1)
            ENDWITH
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkNfClick - Confirmacao antes de marcar opcao NF/Descritivo
    * Logica original: chkNf.Click - se usuario confirmar "Nao", desmarca
    * Mensagem varia: P&G (DivNotas=2) -> "descritivo", SRCOM -> "versao completa"
    *--------------------------------------------------------------------------
    PROCEDURE ChkNfClick()
        LOCAL loc_cMsg, loc_lConfirmado
        IF THIS.chk_4c_ChkNf.Value = 1
            IF VARTYPE(THIS.this_oRelatorio) = "O" AND ;
               THIS.this_oRelatorio.this_nDivNotas = 2
                loc_cMsg = "Deseja realmente imprimir descritivo?"
            ELSE
                loc_cMsg = "Deseja realmente imprimir vers" + CHR(227) + "o completa?"
            ENDIF
            loc_lConfirmado = MsgConfirma(loc_cMsg, "Aviso")
            IF !loc_lConfirmado
                THIS.chk_4c_ChkNf.Value = 0
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkIncentivoClick - Confirmacao antes de marcar opcao Incentivos
    * Logica original: chkIcentivo.Click - se usuario confirmar "Nao", desmarca
    *--------------------------------------------------------------------------
    PROCEDURE ChkIncentivoClick()
        LOCAL loc_lConfirmado
        IF THIS.chk_4c_ChkIcentivo.Value = 1
            loc_lConfirmado = MsgConfirma("Deseja realmente imprimir vers" + CHR(227) + "o completa?", "Aviso")
            IF !loc_lConfirmado
                THIS.chk_4c_ChkIcentivo.Value = 0
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do relatorio no monitor
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            IF !THIS.this_oRelatorio.Visualizar()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime o relatorio na impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        THIS.FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            IF !THIS.this_oRelatorio.Imprimir()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDocExcelClick - Impressao direta sem prompt (documento/excel)
    *--------------------------------------------------------------------------
    PROCEDURE BtnDocExcelClick()
        THIS.FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            IF !THIS.this_oRelatorio.ImprimirDocumento()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o form de impressao (ESC / Sair)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        SET PRINTER TO DEFAULT
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Ajusta UI conforme dados carregados do BO
    *
    * Equivalente ao bloco pos-DoDefault do Init() original:
    *   - DigItens=6/7: oculta checkboxes (usa SigReDco6, opcoes nao se aplicam)
    *   - DivNotas=2 (P&G): renomeia captions e pre-calcula Finaliza em TmpRelat
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF

        *-- DigItens 6 ou 7: modo SigReDco6 - checkboxes nao tem sentido
        IF INLIST(THIS.this_oRelatorio.this_nDigItens, 6, 7)
            IF VARTYPE(THIS.chk_4c_ChkNf) = "O"
                THIS.chk_4c_ChkNf.Visible = .F.
            ENDIF
            IF VARTYPE(THIS.chk_4c_ChkIcentivo) = "O"
                THIS.chk_4c_ChkIcentivo.Visible = .F.
            ENDIF
            RETURN
        ENDIF

        *-- DivNotas=2 (P&G): renomeia checkboxes conforme empresa
        IF THIS.this_oRelatorio.this_nDivNotas = 2
            IF VARTYPE(THIS.chk_4c_ChkNf) = "O"
                THIS.chk_4c_ChkNf.Caption = "Imprimir Descritivo"
            ENDIF
            IF VARTYPE(THIS.chk_4c_ChkIcentivo) = "O"
                THIS.chk_4c_ChkIcentivo.Caption = "Impress" + CHR(227) + "o Completa"
            ENDIF

            *-- Pre-calcula margem/contingente em TmpRelat (requer cursors abertos pelo chamador)
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.this_oRelatorio.CalcularFinaliza()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Em REPORT: nao ha grid de lista; retorna .T. por contrato
    * Mantido para compatibilidade com o contrato do FormBase / validador.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em REPORT: botoes permanecem no mesmo estado
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Em REPORT: checkboxes seguem regra de ConfigurarPaginaDados
    * Quando DigItens=6/7 ou modo SigReDco6 ativo, checkboxes ficam ocultos.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        IF VARTYPE(THIS.chk_4c_ChkNf) = "O" AND THIS.chk_4c_ChkNf.Visible
            THIS.chk_4c_ChkNf.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(THIS.chk_4c_ChkIcentivo) = "O" AND THIS.chk_4c_ChkIcentivo.Visible
            THIS.chk_4c_ChkIcentivo.Enabled = loc_lHab
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reseta checkboxes para o estado inicial
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        IF VARTYPE(THIS.chk_4c_ChkNf) = "O"
            THIS.chk_4c_ChkNf.Value = 0
        ENDIF
        IF VARTYPE(THIS.chk_4c_ChkIcentivo) = "O"
            THIS.chk_4c_ChkIcentivo.Value = 0
        ENDIF
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_lImpNf   = .F.
            THIS.this_oRelatorio.this_lImpIcen = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Em REPORT: delega para FormParaRelatorio (contrato CRUD)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Sincroniza opcoes do BO de volta para os checkboxes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            IF VARTYPE(THIS.chk_4c_ChkNf) = "O"
                THIS.chk_4c_ChkNf.Value = IIF(THIS.this_oRelatorio.this_lImpNf, 1, 0)
            ENDIF
            IF VARTYPE(THIS.chk_4c_ChkIcentivo) = "O"
                THIS.chk_4c_ChkIcentivo.Value = IIF(THIS.this_oRelatorio.this_lImpIcen, 1, 0)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Em REPORT: equivalente a Visualizar (preview do relatorio)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Em REPORT: equivalente a Sair (fecha o form)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.BtnSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Em REPORT: nao se aplica; orientar o usuario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        MsgAviso("Este di" + CHR(225) + "logo de impress" + CHR(227) + "o n" + ;
                 CHR(227) + "o possui opera" + CHR(231) + CHR(227) + "o de salvamento." + ;
                 CHR(13) + "Use Visualizar ou Imprimir para gerar o documento.", ;
                 "Impress" + CHR(227) + "o de Documento")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Em REPORT: fecha o formulario (equivalente a Sair)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Reabilita form chamador, reseta impressora, libera BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oForm
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        IF VARTYPE(THIS.this_oFormChamador) = "O"
            loc_oForm = THIS.this_oFormChamador
            THIS.this_oFormChamador = .NULL.
            TRY
                loc_oForm.Enabled = .T.
                loc_oForm.SetFocus()
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro ao reabilitar formul" + CHR(225) + "rio chamador")
            ENDTRY
        ENDIF
        SET PRINTER TO DEFAULT
        DODEFAULT()
    ENDPROC

ENDDEFINE
