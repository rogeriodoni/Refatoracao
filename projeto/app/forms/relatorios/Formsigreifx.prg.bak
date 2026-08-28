*==============================================================================
* FORMSIGREIFX.PRG
* Formul" + CHR(225) + "rio de impress" + CHR(227) + "o de documentos comerciais
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREIFX.SCX (frmrelatorio)
*
* Chamado via: DO FORM Formsigreifx WITH pEmp, pDop, pNum, pImp, pChkImpDoc
* Par" + CHR(226) + "metros:
*   pEmp       = C" + CHR(243) + "digo da empresa (C, 3)
*   pDop       = C" + CHR(243) + "digo da opera" + CHR(231) + CHR(227) + "o (C, 20)
*   pNum       = N" + CHR(250) + "mero do documento (N, 6)
*   pImp       = Tipo impress" + CHR(227) + "o: 0=normal, 2/4=direto, 3/4=auto-print, 5=auto-visualizar
*   pChkImpDoc = .T. = verificar hist" + CHR(243) + "rico de impress" + CHR(227) + "o ao abrir
*
* Filtros (hospedados em pgf_4c_Paginas.Page1 "Filtros"):
*   - chk_4c_ChkObs   : Imprimir obs de moedas/cota" + CHR(231) + CHR(245) + "es (vis" + CHR(237) + "vel: Docus 3/6/11)
*   - chk_4c_ChkImagem: Imprimir imagem do produto (vis" + CHR(237) + "vel: Docus 6/10)
*
* Width=845, Height=130 (id" + CHR(234) + "nticos ao original)
*==============================================================================

DEFINE CLASS Formsigreifx AS FormBase

    *-- Dimens" + CHR(245) + "es exatas do original (Width=845, Height=130)
    Height      = 130
    Width       = 845
    DataSession = 2
    ShowWindow = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    WindowType  = 1
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.
    FontName    = "Arial"
    FontSize    = 9
    Caption     = "Documento"

    *-- Par" + CHR(226) + "metros recebidos do c" + CHR(243) + "digo chamador
    this_cEmps           = ""    && C" + CHR(243) + "digo da empresa (PADR 3 chars)
    this_cDopes          = ""    && C" + CHR(243) + "digo da opera" + CHR(231) + CHR(227) + "o (PADR 20 chars)
    this_nNumes          = 0     && N" + CHR(250) + "mero do documento
    this_nTpImpressao    = 0     && Tipo: 0=normal, 2/4=direto, 3/4=auto-print, 5=auto-visualizar
    this_lPChkImpDoc     = .F.   && Verificar hist" + CHR(243) + "rico de impress" + CHR(227) + "o

    *-- Refer" + CHR(234) + "ncia ao BO de relat" + CHR(243) + "rio
    this_oRelatorio      = .NULL.
    this_cMensagemErro   = ""

    *--------------------------------------------------------------------------
    * Init - Recebe par" + CHR(226) + "metros do c" + CHR(243) + "digo chamador
    * Salva par" + CHR(226) + "metros como propriedades ANTES de DODEFAULT() para que
    * InicializarForm() possa us" + CHR(225) + "-los ao ser chamada por FormBase.Init().
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cEmp, par_cDop, par_nNum, par_nImp, par_lChkImpDoc)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cEmps        = PADR(IIF(VARTYPE(par_cEmp) = "C", par_cEmp, ""), 3)
            THIS.this_cDopes       = PADR(IIF(VARTYPE(par_cDop) = "C", par_cDop, ""), 20)
            THIS.this_nNumes       = IIF(VARTYPE(par_nNum) = "N", par_nNum, 0)
            THIS.this_nTpImpressao = IIF(VARTYPE(par_nImp) = "N", par_nImp, 0)
            THIS.this_lPChkImpDoc  = IIF(VARTYPE(par_lChkImpDoc) = "L", par_lChkImpDoc, .F.)

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inicializar Formsigreifx")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta UI, cria BO, configura visibilidade por Docus
    * Retorna .F. tanto em erro quanto no modo auto-execu" + CHR(231) + CHR(227) + "o (form n" + CHR(227) + "o aparece).
    * REGRA: NUNCA usar RETURN dentro de TRY/CATCH - usar flags loc_lContinuar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_nDocus, loc_nResultado, loc_lContinuar, loc_lAutoExec
        loc_lSucesso   = .F.
        loc_nDocus     = 0
        loc_lContinuar = .T.
        loc_lAutoExec  = .F.

        TRY
            IF !EMPTY(ALLTRIM(THIS.this_cDopes)) OR THIS.this_nNumes > 0
                THIS.Caption = "Impress" + CHR(227) + "o de Documento (" + ;
                               ALLTRIM(THIS.this_cDopes) + "/" + ;
                               ALLTRIM(STR(THIS.this_nNumes)) + ")"
            ENDIF

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Criar BO de impress" + CHR(227) + "o de documentos
            THIS.this_oRelatorio = CREATEOBJECT("sigreifxBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigreifxBO", "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Transferir par" + CHR(226) + "metros para o BO antes de qualquer opera" + CHR(231) + CHR(227) + "o
                THIS.this_oRelatorio.this_cEmps        = THIS.this_cEmps
                THIS.this_oRelatorio.this_cDopes       = THIS.this_cDopes
                THIS.this_oRelatorio.this_nNumes       = THIS.this_nNumes
                THIS.this_oRelatorio.this_nTpImpressao = THIS.this_nTpImpressao
                THIS.this_oRelatorio.this_lPChkImpDoc  = THIS.this_lPChkImpDoc

                *-- Consulta leve em SigCdOpe para obter Docus (tipo do documento)
                *   Necess" + CHR(225) + "rio para visibilidade dos checkboxes ANTES de PrepararDados()
                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT Docus FROM SigCdOpe WHERE Dopes = " + EscaparSQL(THIS.this_cDopes), ;
                        "cursor_4c_TmpDocType")
                    IF loc_nResultado > 0 AND USED("cursor_4c_TmpDocType")
                        GO TOP IN cursor_4c_TmpDocType
                        IF !EOF("cursor_4c_TmpDocType")
                            loc_nDocus = cursor_4c_TmpDocType.Docus
                        ENDIF
                        USE IN cursor_4c_TmpDocType
                    ENDIF
                ENDIF

                *-- Montar cabecalho escuro superior (equivalente ao cntSombra do legado)
                THIS.ConfigurarCabecalho()

                *-- Montar botoes de acao (equivalente ao btnReport do legado)
                THIS.ConfigurarBotoes()

                *-- PageFrame com 1 pagina ("Filtros") - agrupa os checkboxes de opcoes
                THIS.ConfigurarPageFrame()

                *-- Montar campos de filtro: 1a metade (ConfigurarPaginaDados) + 2a metade (ConfigurarCheckBoxes)
                THIS.ConfigurarPaginaDados(loc_nDocus)
                THIS.ConfigurarCheckBoxes(loc_nDocus)

                *-- Verificar historico de impressao e ajustar habilitacao dos botoes
                IF THIS.this_lPChkImpDoc
                    THIS.VerificarHistoricoImpressao()
                ENDIF

                *-- Vincular eventos dos botoes (BINDEVENT exige metodos PUBLIC)
                THIS.VincularEventos()

                *-- Atualizar titulo no cabecalho
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Modo auto-impressao (TpImpressao 3 ou 4): executa e sinaliza fechamento
                IF INLIST(THIS.this_nTpImpressao, 3, 4)
                    THIS.FormParaRelatorio()
                    THIS.this_oRelatorio.Imprimir()
                    loc_lAutoExec  = .T.
                    loc_lContinuar = .F.
                ENDIF

                *-- Modo auto-visualizacao (TpImpressao = 5): executa e sinaliza fechamento
                IF loc_lContinuar AND THIS.this_nTpImpressao = 5
                    THIS.FormParaRelatorio()
                    THIS.this_oRelatorio.Visualizar()
                    loc_lAutoExec  = .T.
                    loc_lContinuar = .F.
                ENDIF

                IF loc_lContinuar
                    THIS.Visible = .T.
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY

        *-- Modo auto-execucao retorna .F. para que o form nao seja exibido
        IF loc_lAutoExec
            RETURN .F.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro superior com titulo do documento
    *   Equivalente ao cntSombra do legado (Top=-1, Width=848, Height=80).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .AutoSize  = .F.
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = ""
                .FontName  = "Arial"
                .FontSize  = 12
                .FontBold  = .T.
                .ForeColor = RGB(60, 60, 60)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .AutoSize  = .T.
                .Caption   = ""
                .FontName  = "Arial"
                .FontSize  = 12
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup de botoes do relatorio (btnReport legado)
    *   Padrao canonico frmrelatorio: cmg_4c_Botoes CommandGroup, ButtonCount=4.
    *   Left=578 EXATO do original (btnReport.Left=578, Width=845).
    *   Buttons: Visualizar(1), Imprimir(2), Excel(3), Sair(4).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_cIcones
        loc_cIcones = IIF(TYPE("gc_4c_CaminhoIcones") = "C", gc_4c_CaminhoIcones, "")

        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 578   && EXATO do original: btnReport.Left = 578
            .Width         = 267   && 845 - 578 = 267
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .Caption         = "Visualizar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Gerar o Documento no V" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
                IF !EMPTY(loc_cIcones)
                    .Picture = loc_cIcones + "relatorio_video_26.jpg"
                ENDIF
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Caption         = "Imprimir"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Enviar o Documento Para Impressora"
                .Themes          = .F.
                .Visible         = .T.
                IF !EMPTY(loc_cIcones)
                    .Picture = loc_cIcones + "relatorio_impressora_26.jpg"
                ENDIF
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "\<Arquivos Email"
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Arquivos Email"
                .Themes          = .F.
                .Visible         = .T.
                IF !EMPTY(loc_cIcones)
                    .Picture = loc_cIcones + "geral_envelope_32.jpg"
                ENDIF
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Sair"
                .WordWrap        = .T.
                .Cancel          = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "[Esc] Sair"
                .Themes          = .F.
                .Visible         = .T.
                IF !EMPTY(loc_cIcones)
                    .Picture = loc_cIcones + "relatorio_sair_60.jpg"
                ENDIF
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina ("Filtros") para os checkboxes
    *   O form legado SIGREIFX e FLAT (sem PageFrame), mas no novo padrao
    *   os campos de filtro sao agrupados em um PageFrame de 1 pagina para
    *   consistencia com o restante do sistema (Page1 = "Filtros" hospeda
    *   chk_4c_ChkObs e chk_4c_ChkImagem).
    *
    *   Geometria: cobre o form inteiro (Top=0, Height=THIS.Height).
    *     Top    = 0
    *     Left   = 0
    *     Width  = THIS.Width
    *     Height = THIS.Height  (= 130 para form de 130 de altura)
    *     Tabs   = .F.   (esconder abas, ja que ha apenas 1 pagina logica)
    *   ZOrder(1) envia o PageFrame ao fundo: cnt_4c_Cabecalho e
    *   cmg_4c_Botoes (adicionados antes) ficam visualmente sobre ele.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        loc_oPgf.PageCount = 1

        *-- PageFrame cobre o form inteiro; cabecalho/botoes ficam sobre ele (z-order)
        loc_oPgf.Top    = 0
        loc_oPgf.Left   = 0
        loc_oPgf.Width  = THIS.Width
        loc_oPgf.Height = THIS.Height
        loc_oPgf.Tabs   = .F.

        loc_oPgf.Visible = .T.

        *-- Enviar ao fundo: cnt_4c_Cabecalho e cmg_4c_Botoes ficam por cima
        loc_oPgf.ZOrder(1)

        *-- Configurar Page1 (estilo, fontes, cores) via metodo dedicado
        THIS.ConfigurarPaginaLista()

        *-- Ativar Page1 (unica pagina logica deste form REPORT)
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 do pgf_4c_Paginas
    *   Em forms CRUD, este metodo configura a pagina de listagem (grid).
    *   Neste form REPORT (frmrelatorio), Page1 hospeda os checkboxes de
    *   filtros de impressao (chk_4c_ChkObs, chk_4c_ChkImagem); portanto,
    *   este metodo aplica apenas o estilo visual da pagina - os controles
    *   sao adicionados separadamente por ConfigurarCheckBoxes() pois sua
    *   visibilidade depende do tipo do documento (Docus) consultado em
    *   InicializarForm().
    *
    *   PILAR 1 (UX): Page1.BackColor e ForeColor seguem o padrao do
    *   framework frmrelatorio (fundo branco, texto cinza 90,90,90).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina

        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        IF THIS.pgf_4c_Paginas.PageCount < 1
            RETURN
        ENDIF

        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Estilo visual da Page1 (Filtros)
        loc_oPagina.Caption   = "Filtros"
        loc_oPagina.FontName  = "Tahoma"
        loc_oPagina.FontSize  = 8
        loc_oPagina.BackColor = RGB(255, 255, 255)
        loc_oPagina.ForeColor = RGB(90, 90, 90)
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Ativa a pagina indicada do pgf_4c_Paginas
    *   par_nPagina: numero da pagina (1 .. PageCount)
    *
    *   Em forms CRUD, este metodo alterna entre Page1 (Lista) e Page2 (Dados).
    *   Neste form REPORT, ha apenas Page1 (Filtros), mas o metodo realiza
    *   validacao de limites (1 .. PageCount), define ActivePage e garante
    *   que a pagina ativa esteja visivel - logica reutilizavel caso novas
    *   paginas de filtros sejam adicionadas no futuro (ex: filtros avancados).
    *
    *   Retorno: .T. se a pagina foi ativada com sucesso, .F. caso contrario.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lOk, loc_nPagina, loc_oPgf
        loc_lOk     = .F.
        loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)

        TRY
            loc_oPgf = THIS.pgf_4c_Paginas
            IF VARTYPE(loc_oPgf) = "O"
                *-- Limitar entre 1 e PageCount
                IF loc_nPagina < 1
                    loc_nPagina = 1
                ENDIF
                IF loc_nPagina > loc_oPgf.PageCount
                    loc_nPagina = loc_oPgf.PageCount
                ENDIF

                *-- Garantir que o PageFrame esteja visivel antes de ativar
                loc_oPgf.Visible    = .T.
                loc_oPgf.ActivePage = loc_nPagina

                loc_lOk = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Campos de filtro da pagina de opcoes (1a metade)
    *   Para forms REPORT, "PaginaDados" corresponde a pagina de filtros de
    *   impressao (Page1 unica, sem Page2 CRUD). Adiciona o primeiro campo
    *   de opcao de impressao.
    *
    *   Campos adicionados (1a metade - Phase 5):
    *     - chk_4c_ChkObs: Imprimir Obs Moedas/Cotacoes (visivel Docus 3/6/11)
    *       Top=89, Left=36 relativo a Page1 (original Top=89, PageFrame.Top=0)
    *
    *   par_nDocus: tipo do documento obtido de SigCdOpe.Docus
    *   REGRA: CheckBox.Value SEMPRE NUMERICO (1=marcado, 0=desmarcado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados(par_nDocus)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- chkObs: Imprimir Observacao de Moedas/Cotacoes
        loc_oPagina.AddObject("chk_4c_ChkObs", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkObs
            .Top           = 89
            .Left          = 36
            .AutoSize      = .T.
            .Alignment     = 0
            .Caption       = "Imprimir Observa" + CHR(231) + CHR(227) + "o de Moedas/Cota" + CHR(231) + CHR(245) + "es"
            .SpecialEffect = 1
            .FontName      = "Arial"
            .FontSize      = 9
            IF INLIST(par_nDocus, 3, 6, 11)
                *-- Visivel: Docus Fixo Horizontal (3/11) e Fixo Vertical (6)
                .Value   = 1
                .Visible = .T.
            ELSE
                *-- Oculto: valor = 1 apenas se Docus=6 (Fixo Vertical sem checkbox visivel)
                .Value   = IIF(par_nDocus = 6, 1, 0)
                .Visible = .F.
            ENDIF
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCheckBoxes - Campos de filtro da pagina de opcoes (2a metade)
    *   Complementa ConfigurarPaginaDados() adicionando o segundo campo de
    *   opcao de impressao (chk_4c_ChkImagem).
    *
    *   Campos adicionados (2a metade - Phase 6):
    *     - chk_4c_ChkImagem: Imprimir Imagem do produto (visivel Docus 6/10)
    *       Top=105, Left=36 relativo a Page1 (original Top=105, PageFrame.Top=0)
    *
    *   par_nDocus: tipo do documento obtido de SigCdOpe.Docus
    *   REGRA: CheckBox.Value SEMPRE NUMERICO (1=marcado, 0=desmarcado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCheckBoxes(par_nDocus)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- chkImagem: Imprimir Imagem do produto
        loc_oPagina.AddObject("chk_4c_ChkImagem", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkImagem
            .Top           = 105
            .Left          = 36
            .AutoSize      = .T.
            .Alignment     = 0
            .Caption       = "Imprimir Imagem"
            .Value         = 1
            .SpecialEffect = 1
            .FontName      = "Arial"
            .FontSize      = 9
            *-- Visivel apenas para Docus 6 (Fixo Vertical) e 10 (Tres Vias)
            .Visible       = INLIST(par_nDocus, 6, 10)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarHistoricoImpressao - Verifica se o documento ja foi impresso
    *   Se SigOpCdc.chkImpDoc = 1 e SigMvCab.Impress <> 0:
    *     - Consulta permissao de reimpressao via fChecaAcesso
    *     - Desabilita botoes Imprimir e Excel se sem permissao
    *   REGRA: NUNCA usar RETURN dentro de TRY/CATCH - usar flags loc_lContinuar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VerificarHistoricoImpressao()
        LOCAL loc_nResultado, loc_lChkImpDoc, loc_nNDopes
        LOCAL loc_lcEdn, loc_lImpresso, loc_lAcesso, loc_lContinuar
        loc_lChkImpDoc = .F.
        loc_nNDopes    = 0
        loc_lImpresso  = .F.
        loc_lAcesso    = .T.
        loc_lContinuar = .T.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Verificar se a operacao tem controle de impressao (SigOpCdc.chkImpDoc)
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT a.NDopes, b.chkImpDoc " + ;
                    "FROM SigCdOpe a, SigOpCdc b " + ;
                    "WHERE a.Dopes = " + EscaparSQL(THIS.this_cDopes) + " " + ;
                    "AND b.Dopes = a.Dopes", ;
                    "cursor_4c_TmpChkDoc")
                IF loc_nResultado < 1 OR !USED("cursor_4c_TmpChkDoc")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                GO TOP IN cursor_4c_TmpChkDoc
                IF EOF("cursor_4c_TmpChkDoc")
                    loc_lContinuar = .F.
                ELSE
                    loc_lChkImpDoc = (cursor_4c_TmpChkDoc.chkImpDoc <> 0)
                    loc_nNDopes    = cursor_4c_TmpChkDoc.NDopes
                ENDIF
                USE IN cursor_4c_TmpChkDoc
                IF !loc_lChkImpDoc
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Verificar se o documento ja foi impresso em SigMvCab.Impress
                loc_lcEdn = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Impress FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_lcEdn), ;
                    "cursor_4c_TmpImpress")
                IF loc_nResultado < 1 OR !USED("cursor_4c_TmpImpress")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                GO TOP IN cursor_4c_TmpImpress
                loc_lImpresso = (!EOF("cursor_4c_TmpImpress") AND cursor_4c_TmpImpress.Impress <> 0)
                USE IN cursor_4c_TmpImpress
                IF !loc_lImpresso
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Documento ja impresso: verificar permissao de reimpressao
                TRY
                    loc_lAcesso = fChecaAcesso(PADL(TRANSFORM(loc_nNDopes), 8, "0"), "REIMPDOC")
                CATCH
                    loc_lAcesso = .F.
                ENDTRY

                *-- Ajustar habilitacao dos botoes de impressao e exportacao
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = loc_lAcesso  && Imprimir
                THIS.cmg_4c_Botoes.Buttons(3).Enabled = loc_lAcesso  && Excel
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao verificar hist" + CHR(243) + "rico de impress" + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularEventos - BINDEVENT dos botoes de acao
    *   Os handlers devem ser PUBLIC para BINDEVENT funcionar corretamente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularEventos()
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere estado dos checkboxes para o BO
    *   Chamado antes de qualquer operacao de impressao/visualizacao/exportacao.
    *   CheckBox.Value e NUMERICO (1=marcado, 0=desmarcado) - comparar com = 1
    *--------------------------------------------------------------------------
    PROCEDURE FormParaRelatorio()
        LOCAL loc_oPagina
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            THIS.this_oRelatorio.this_lChkObs    = (loc_oPagina.chk_4c_ChkObs.Value    = 1)
            THIS.this_oRelatorio.this_lChkImagem = (loc_oPagina.chk_4c_ChkImagem.Value = 1)
        CATCH
            *-- Checkboxes nao disponiveis - manter defaults do BO
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Nao aplicavel a formularios de relatorio (frmrelatorio)
    *   Form REPORT nao possui operacao Incluir - usar Visualizar/Imprimir/Excel.
    *   Mantido por padrao do pipeline de migracao (Fase 7 valida assinatura).
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Nao aplicavel a formularios de relatorio (frmrelatorio)
    *   Form REPORT nao possui operacao Alterar - usar Visualizar/Imprimir/Excel.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Nao aplicavel a formularios de relatorio (frmrelatorio)
    *   Form REPORT nao possui operacao Excluir - usar Visualizar/Imprimir/Excel.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Prepara dados e exibe relatorio em tela (PREVIEW)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            MsgErro("BO n" + CHR(227) + "o inicializado", "Erro")
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Visualizar")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Prepara dados e imprime o documento
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            MsgErro("BO n" + CHR(227) + "o inicializado", "Erro")
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Imprimir")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDocExcelClick - Exporta dados do documento para cursor crExcel
    *--------------------------------------------------------------------------
    PROCEDURE BtnDocExcelClick()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            MsgErro("BO n" + CHR(227) + "o inicializado", "Erro")
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        THIS.this_oRelatorio.DocumentoExcel()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reinicia checkboxes de filtro para valores padrao
    *   Chamado por FormBase em certas transicoes de estado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND THIS.pgf_4c_Paginas.PageCount >= 1
                LOCAL loc_oPagina
                loc_oPagina = THIS.pgf_4c_Paginas.Page1
                IF VARTYPE(loc_oPagina.chk_4c_ChkObs) = "O"
                    loc_oPagina.chk_4c_ChkObs.Value = 1
                ENDIF
                IF VARTYPE(loc_oPagina.chk_4c_ChkImagem) = "O"
                    loc_oPagina.chk_4c_ChkImagem.Value = 1
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Nao aplicavel a formularios de relatorio (frmrelatorio)
    *   Forms REPORT nao possuem campos editaveis no sentido CRUD.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias para FormParaRelatorio() (compatibilidade com FormBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Nao aplicavel a formularios de relatorio (frmrelatorio)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Nao aplicavel a formularios de relatorio (frmrelatorio)
    *   Forms REPORT nao possuem grid de lista.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme permissoes
    *   Em forms REPORT, Imprimir e Excel sao controlados por permissao de
    *   reimpressao (VerificarHistoricoImpressao). Visualizar e Sair: sempre on.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) = "O" AND VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(2).Enabled = THIS.this_oRelatorio.this_lAcImprimir
            THIS.cmg_4c_Botoes.Buttons(3).Enabled = THIS.this_oRelatorio.this_lAcExcel
            THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Nao aplicavel a formularios de relatorio (frmrelatorio)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario (alias para BtnSairClick)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Nao aplicavel a formularios de relatorio (frmrelatorio)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Fecha o formulario sem imprimir
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o formulario
    *   this_oRelatorio = .NULL. dispara Destroy() do BO (RelatorioBase/Custom)
    *   que limpa cursores temporarios e arquivos de imagem.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
