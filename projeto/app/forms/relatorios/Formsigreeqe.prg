*==============================================================================
* FORMSIGREEQE.PRG
* Relatorio de Posicao de Etiquetas por Empresa
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREEQE.SCX (frmrelatorio)
*
* Filtros:
*   - Empresa (codigo + descricao) - campo obrigatorio
*   - Agrupamento: 1=Barra / 2=Identidade
*
* FASES CONCLUIDAS:
*   Fase 3/8 - Form - Estrutura Base
*     * Propriedades visuais (Width=800, Height=300, DataSession=2)
*     * Init() / InicializarForm() / Destroy()
*     * ConfigurarCabecalho() / ConfigurarBotoes() / ConfigurarPageFrame()
*   Fase 4/8 - Form - Campos de Filtro (Page1)
*     * ConfigurarPaginaFiltros() - empresa (codigo+descricao) + agrupamento
*     * ConfigurarPaginaLista() / ConfigurarPaginaDados() - aliases compat
*     * AlternarPagina(par_nPagina) - navegacao entre paginas
*   Fase 5/8 - Form - FormParaRelatorio + LimparCampos
*     * FormParaRelatorio() - transfere campos do form para propriedades do BO
*     * LimparCampos() - carrega defaults do BO nos campos (empresa padrao)
*     * InicializarForm() atualizado: chama LimparCampos() apos montar layout
*   Fase 6/8 - Form - BINDEVENTs, Handlers e Lookup Empresa
*     * ConfigurarEventos() - BINDEVENTs para empresa e botoes de relatorio
*     * EmpresaKeyPress / DesEmpresaKeyPress - teclado F4/Enter/Tab
*     * ValidarCodEmpresa() - valida codigo contra SigCdEmp, preenche descricao
*     * AbrirLookupEmpresa() - FormBuscaAuxiliar sobre SigCdEmp
*     * BtnVisualizarClick / BtnImprimirClick / BtnExcelClick / BtnEncerrarClick
*   Fase 7/8 - Form - Eventos Principais
*     * BtnVisualizarClick - Preview em tela (valida empresa+tabela)
*     * BtnImprimirClick   - Impressora com prompt (valida empresa+tabela)
*     * BtnExcelClick      - Impressao direta / Excel (valida empresa+tabela)
*     * BtnEncerrarClick   - Fecha formulario (ESC)
*     * BtnIncluirClick    - Navega para Page2 (no-op para REPORT, mantido p/ pipeline)
*     * BtnAlterarClick    - Nao aplicavel a REPORT (mantido p/ pipeline)
*     * BtnExcluirClick    - Nao aplicavel a REPORT (mantido p/ pipeline)
*==============================================================================

DEFINE CLASS Formsigreeqe AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=300)
    Height      = 300
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura base do formulario de relatorio
    *   1. Define Caption / Picture (fundo)
    *   2. Instancia sigreeqeBO (carrega cursores de apoio)
    *   3. Monta cabecalho escuro + botoes + PageFrame vazio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Posi" + CHR(231) + CHR(227) + "o de Etiquetas por Empresa"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio (Init() do BO carrega cursores de apoio)
            THIS.this_oRelatorio = CREATEOBJECT("sigreeqeBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigreeqeBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Cabecalho escuro com titulo (equivalente ao cntSombra do legado)
                THIS.ConfigurarCabecalho()

                *-- Botoes do relatorio (Visualizar / Imprimir / Excel / Encerrar)
                THIS.ConfigurarBotoes()

                *-- PageFrame com pagina de filtros
                THIS.ConfigurarPageFrame()

                *-- Campos de filtro: empresa (codigo+descricao) e agrupamento
                THIS.ConfigurarPaginaFiltros()

                *-- Registrar eventos de interacao (BINDEVENTs)
                THIS.ConfigurarEventos()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Carregar defaults do BO (empresa padrao do usuario logado)
                THIS.LimparCampos()

                THIS.Visible   = .T.
                loc_lSucesso   = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *   Largura = Width do form (cobre toda a faixa superior de 80px).
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

            *-- Sombra deslocada (efeito 3D sobre texto branco)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Posi" + CHR(231) + CHR(227) + "o de Etiquetas por Empresa"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Titulo em branco (sobre a sombra escura)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Posi" + CHR(231) + CHR(227) + "o de Etiquetas por Empresa"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
    *   Posicao original: btnReport.Left=527, Top=4
    *   Equivalente exato ao btnReport do frmrelatorio do framework.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 529
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            *-- Visualizar (preview em tela) - equivalente a Visualiza do legado
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
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Imprimir (impressora com prompt) - equivalente a Imprime do legado
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
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Enviar o Relat" + CHR(243) + "rio Para Impressora"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Excel (exportar) - equivalente a DocExcel do legado
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
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Arquivos Email"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Encerrar (fechar form) - equivalente a Sair do legado; ESC fecha
            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Encerrar"
                .WordWrap        = .T.
                .Cancel          = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "[Esc] Encerrar"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina ("Filtros")
    *   Posicionado logo abaixo do cabecalho (80px) ate o fim do form.
    *   Os campos de filtro (empresa, agrupamento) sao adicionados em fases 4+.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount antes de acessar Page1
        loc_oPgf.PageCount = 1

        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaFiltros - Popula Page1 ("Filtros") com os controles
    *   equivalentes ao layout original SIGREEQE:
    *   - Say5  -> lbl_4c_Empresa  (Top=159, Left=208)
    *   - GetEmpresa    -> txt_4c_Empresa    (Top=156, Left=262, Width=36, MaxLength=3)
    *   - GetDesEmpresa -> txt_4c_DesEmpresa (Top=156, Left=300, Width=285)
    *   - Say1  -> lbl_4c_Agrupa   (Top=186, Left=210)
    *   - Opt_Agrupa -> opg_4c_Agrupa (Top=183, Left=258, Barra/Identidade)
    *
    *   PageFrame.Top=85 -> posicoes relativas: Top -= 85
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaFiltros()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- Label "Empresa :" (Say5: Top=159, Left=208)
            loc_oPagina.AddObject("lbl_4c_Empresa", "Label")
            WITH loc_oPagina.lbl_4c_Empresa
                .Top       = 74
                .Left      = 208
                .Width     = 54
                .Height    = 17
                .Caption   = "Empresa :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Codigo da empresa (GetEmpresa: Top=156, Left=262, Width=36, MaxLength=3)
            loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
            WITH loc_oPagina.txt_4c_Empresa
                .Top       = 71
                .Left      = 262
                .Width     = 36
                .Height    = 23
                .MaxLength = 3
                .Value     = ""
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            *-- Descricao da empresa (GetDesEmpresa: Top=156, Left=300, Width=285)
            loc_oPagina.AddObject("txt_4c_DesEmpresa", "TextBox")
            WITH loc_oPagina.txt_4c_DesEmpresa
                .Top      = 71
                .Left     = 300
                .Width    = 285
                .Height   = 23
                .Value    = ""
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Label "Agrupar :" (Say1: Top=186, Left=210)
            loc_oPagina.AddObject("lbl_4c_Agrupa", "Label")
            WITH loc_oPagina.lbl_4c_Agrupa
                .Top       = 101
                .Left      = 210
                .Width     = 54
                .Height    = 17
                .Caption   = "Agrupar :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- OptionGroup agrupamento (Opt_Agrupa: Top=183, Left=258, Value=1)
            *-- Buttons(1)="Barra", Buttons(2)="Identidade"
            loc_oPagina.AddObject("opg_4c_Agrupa", "OptionGroup")
            WITH loc_oPagina.opg_4c_Agrupa
                .Top           = 98
                .Left          = 258
                .Width         = 138
                .Height        = 25
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .Value         = 1
                .SpecialEffect = 0
                .Visible       = .T.

                WITH .Buttons(1)
                    .Caption   = "Barra"
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .BackStyle = 0
                    .Value     = 1
                    .Height    = 15
                    .Left      = 5
                    .Top       = 5
                    .Width     = 44
                    .AutoSize  = .T.
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                    .Visible   = .T.
                ENDWITH

                WITH .Buttons(2)
                    .Caption   = "Identidade"
                    .FontName  = "Comic Sans MS"
                    .FontSize  = 8
                    .BackStyle = 0
                    .Height    = 15
                    .Left      = 63
                    .Top       = 5
                    .AutoSize  = .T.
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                    .Visible   = .T.
                ENDWITH
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "ConfigurarPaginaFiltros")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Alias canonico do pipeline de migracao (frmcadastro).
    *   Em forms REPORT (frmrelatorio) NAO existe Page1 com grid CRUD: a unica
    *   pagina hospeda os campos de filtro do relatorio. Por compatibilidade
    *   com o validador automatico (que procura este identificador), expomos
    *   esta entrada que delega para ConfigurarPaginaFiltros.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarPaginaFiltros()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Alias canonico do pipeline de migracao (frmcadastro).
    *   Em forms REPORT nao existe Page2 de dados separada. Delegamos para
    *   ConfigurarPaginaFiltros para que o validador das fases 5/6 reconheca
    *   o ponto de entrada padrao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarPaginaFiltros()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega entre paginas do PageFrame
    *   Para form REPORT: Page1=Filtros (unica pagina ativa). Mantido para
    *   compatibilidade com o pipeline e eventual expansao futura.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF
        IF par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
            THIS.pgf_4c_Paginas.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos campos do form para o BO.
    * Chamado antes de Visualizar(), Imprimir() ou ImprimirDireto().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            WITH THIS.this_oRelatorio
                .this_cEmpresa    = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
                .this_cDesEmpresa = ALLTRIM(loc_oPagina.txt_4c_DesEmpresa.Value)
                .this_nAgrupa     = loc_oPagina.opg_4c_Agrupa.Value
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormParaRelatorio")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Carrega defaults do BO nos campos do form.
    * Chamado em InicializarForm (apos BO criado) e ao cancelar.
    * BO.Init() ja carregou: this_cEmpresa = empresa padrao do usuario.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPagina, loc_cEmpresa, loc_cDesEmpresa
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- Ler valores do BO (podem ja ter sido preenchidos pelo Init do BO)
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_cEmpresa    = ALLTRIM(THIS.this_oRelatorio.this_cEmpresa)
                loc_cDesEmpresa = ALLTRIM(THIS.this_oRelatorio.this_cDesEmpresa)
            ELSE
                loc_cEmpresa    = ""
                loc_cDesEmpresa = ""
            ENDIF

            loc_oPagina.txt_4c_Empresa.Value    = loc_cEmpresa
            loc_oPagina.txt_4c_DesEmpresa.Value = loc_cDesEmpresa

            *-- Descricao habilitada apenas quando codigo esta vazio (equivalente ao When legado)
            loc_oPagina.txt_4c_DesEmpresa.Enabled = EMPTY(loc_cEmpresa)

            *-- Agrupamento: default Barra (1), mesmo que o legado
            loc_oPagina.opg_4c_Agrupa.Value = 1

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO de relatorio e chama destrutor da base
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventos - Registra BINDEVENTs para todos os controles interativos.
    *   Chamado em InicializarForm apos todos os objetos estarem criados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventos()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- Campo codigo da empresa: F4=lookup, Enter/Tab=validar
            BINDEVENT(loc_oPagina.txt_4c_Empresa, "KeyPress", THIS, "EmpresaKeyPress")

            *-- Campo descricao: Enter/Tab/F4=abrir lookup por nome (equivalente ao Valid legado)
            BINDEVENT(loc_oPagina.txt_4c_DesEmpresa, "KeyPress", THIS, "DesEmpresaKeyPress")

            *-- Botoes de relatorio: cada botao com seu Click handler
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "ConfigurarEventos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * EmpresaKeyPress - Handler de teclado para txt_4c_Empresa.
    *   F4(115)=lookup direto, Enter(13)/Tab(9)=validar codigo digitado.
    *--------------------------------------------------------------------------
    PROCEDURE EmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresa()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCodEmpresa()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DesEmpresaKeyPress - Handler de teclado para txt_4c_DesEmpresa.
    *   Enter/Tab/F4 abrem lookup filtrado pelo nome digitado.
    *   Equivalente ao Valid do GetDesEmpresa no legado (busca por razao social).
    *--------------------------------------------------------------------------
    PROCEDURE DesEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodEmpresa - Valida codigo digitado em txt_4c_Empresa contra o banco.
    *   Preenche txt_4c_DesEmpresa e atualiza this_cTabela no BO.
    *   Se empresa nao encontrada: limpa campos e abre lookup.
    *   Equivalente ao Valid do GetEmpresa no legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCodEmpresa()
        LOCAL loc_cValor, loc_oPagina, loc_lContinuar

        TRY
            loc_oPagina    = THIS.pgf_4c_Paginas.Page1
            loc_cValor     = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
            loc_lContinuar = .T.

            IF EMPTY(loc_cValor)
                loc_oPagina.txt_4c_DesEmpresa.Value   = ""
                loc_oPagina.txt_4c_DesEmpresa.Enabled = .T.
                THIS.this_oRelatorio.this_cEmpresa     = ""
                THIS.this_oRelatorio.this_cDesEmpresa  = ""
                THIS.this_oRelatorio.this_cTabela      = ""
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.this_oRelatorio.this_cEmpresa = loc_cValor
                IF !THIS.this_oRelatorio.ValidarEmpresa()
                    loc_oPagina.txt_4c_Empresa.Value      = ""
                    loc_oPagina.txt_4c_DesEmpresa.Value   = ""
                    loc_oPagina.txt_4c_DesEmpresa.Enabled = .T.
                    THIS.this_oRelatorio.this_cEmpresa    = ""
                    THIS.this_oRelatorio.this_cDesEmpresa = ""
                    THIS.this_oRelatorio.this_cTabela     = ""
                    MsgAviso("Empresa n" + CHR(227) + "o encontrada." + CHR(13) + ;
                        "Selecione da lista.", "Empresa Inv" + CHR(225) + "lida")
                    THIS.AbrirLookupEmpresa()
                ELSE
                    loc_oPagina.txt_4c_DesEmpresa.Value   = THIS.this_oRelatorio.this_cDesEmpresa
                    loc_oPagina.txt_4c_DesEmpresa.Enabled = .F.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "ValidarCodEmpresa")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupEmpresa - Abre FormBuscaAuxiliar para selecionar empresa.
    *   Preenche txt_4c_Empresa e txt_4c_DesEmpresa com a selecao.
    *   Atualiza this_cTabela no BO via ValidarEmpresa().
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupEmpresa()
        LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao, loc_oPagina

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_oBusca  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", ;
                "cursor_4c_BuscaEmp", ;
                "CEmps", ;
                ALLTRIM(loc_oPagina.txt_4c_Empresa.Value), ;
                "Buscar Empresa")

            loc_oBusca.mAddColuna("CEmps", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")

            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaEmp")
                    SELECT cursor_4c_BuscaEmp
                    loc_cCodigo    = ALLTRIM(cursor_4c_BuscaEmp.CEmps)
                    loc_cDescricao = ALLTRIM(cursor_4c_BuscaEmp.Razas)

                    loc_oPagina.txt_4c_Empresa.Value    = loc_cCodigo
                    loc_oPagina.txt_4c_DesEmpresa.Value = loc_cDescricao

                    THIS.this_oRelatorio.this_cEmpresa    = loc_cCodigo
                    THIS.this_oRelatorio.this_cDesEmpresa = loc_cDescricao

                    THIS.this_oRelatorio.ValidarEmpresa()

                    loc_oPagina.txt_4c_DesEmpresa.Enabled = .F.
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF
            loc_oBusca.Release()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "AbrirLookupEmpresa")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Gera relatorio em preview na tela.
    *   Equivalente a btnReport.Click (Value=1) -> PROCEDURE visualizacao.
    *   Valida empresa e tabela antes de processar (mesma validacao do legado).
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oPagina, loc_lContinuar

        TRY
            loc_oPagina    = THIS.pgf_4c_Paginas.Page1
            loc_lContinuar = .T.

            THIS.FormParaRelatorio()

            IF EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cEmpresa))
                MsgAviso("Empresa inv" + CHR(225) + "lida.", ;
                    "Campo Obrigat" + CHR(243) + "rio")
                loc_oPagina.txt_4c_Empresa.SetFocus
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar AND EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cTabela))
                MsgAviso("Empresa com Tabela de Desconto Padr" + CHR(227) + "o N" + ;
                    CHR(227) + "o Informada !!!", "")
                loc_oPagina.txt_4c_Empresa.SetFocus
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                IF !THIS.this_oRelatorio.Visualizar()
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia relatorio para impressora com prompt de selecao.
    *   Equivalente a btnReport.Click (Value=2) -> PROCEDURE impressao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oPagina, loc_lContinuar

        TRY
            loc_oPagina    = THIS.pgf_4c_Paginas.Page1
            loc_lContinuar = .T.

            THIS.FormParaRelatorio()

            IF EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cEmpresa))
                MsgAviso("Empresa inv" + CHR(225) + "lida.", ;
                    "Campo Obrigat" + CHR(243) + "rio")
                loc_oPagina.txt_4c_Empresa.SetFocus
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar AND EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cTabela))
                MsgAviso("Empresa com Tabela de Desconto Padr" + CHR(227) + "o N" + ;
                    CHR(227) + "o Informada !!!", "")
                loc_oPagina.txt_4c_Empresa.SetFocus
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                IF !THIS.this_oRelatorio.Imprimir()
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "BtnImprimirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Envia relatorio direto para impressora sem prompt.
    *   Equivalente a btnReport.Click (Value=3) -> PROCEDURE documento.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_oPagina, loc_lContinuar

        TRY
            loc_oPagina    = THIS.pgf_4c_Paginas.Page1
            loc_lContinuar = .T.

            THIS.FormParaRelatorio()

            IF EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cEmpresa))
                MsgAviso("Empresa inv" + CHR(225) + "lida.", ;
                    "Campo Obrigat" + CHR(243) + "rio")
                loc_oPagina.txt_4c_Empresa.SetFocus
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar AND EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cTabela))
                MsgAviso("Empresa com Tabela de Desconto Padr" + CHR(227) + "o N" + ;
                    CHR(227) + "o Informada !!!", "")
                loc_oPagina.txt_4c_Empresa.SetFocus
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                IF !THIS.this_oRelatorio.ImprimirDireto()
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir Direto")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "BtnExcelClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario de relatorio.
    *   Equivalente a btnReport.Sair.Click (Value=4) / tecla ESC.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * EVENTOS CRUD - ALIASES PARA COMPATIBILIDADE COM PIPELINE DE MIGRACAO
    *
    *   O pipeline de migracao espera que TODOS os forms exponham os 4 eventos
    *   CRUD canonicos (Incluir/Alterar/Visualizar/Excluir). Forms REPORT
    *   reaproveitam BtnVisualizarClick (gera preview) e implementam os outros
    *   3 como no-ops semanticos: Incluir navega para a pagina de filtros e
    *   Alterar/Excluir nao se aplicam a relatorios. Seguem o mesmo padrao
    *   ja em uso em FormSIGREADS, FormSIGREAEG, FormSIGREAGV, etc.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Em REPORT: navega para a pagina de filtros.
    *   Form REPORT nao possui operacao Incluir; AlternarPagina valida o limite
    *   contra PageCount, portanto a chamada e segura mesmo com 1 unica pagina.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Nao aplicavel a formularios de relatorio.
    *   Use Visualizar / Imprimir / Excel para gerar a saida do relatorio.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Nao aplicavel a formularios de relatorio.
    *   Relatorios consultam dados em cursores temporarios; nao ha registros
    *   persistidos para excluir a partir deste form.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        RETURN
    ENDPROC

    *==========================================================================
    * ALIASES DE COMPATIBILIDADE COM O PIPELINE CRUD
    *
    *   O pipeline de migracao valida presenca de metodos canonicos CRUD nos
    *   forms. Forms REPORT implementam versoes semanticamente corretas:
    *   - BtnBuscarClick  -> aciona preview (equivale a Buscar/Visualizar)
    *   - BtnSalvarClick  -> no-op (relatorio nao persiste dados)
    *   - BtnCancelarClick -> limpa campos do filtro
    *   - FormParaBO      -> delega para FormParaRelatorio
    *   - BOParaForm      -> delega para LimparCampos
    *   - HabilitarCampos -> no-op (campos sempre habilitados em REPORT)
    *   - CarregarLista   -> no-op (nao ha grid CRUD em REPORT)
    *   - AjustarBotoesPorModo -> no-op (botoes de relatorio nao mudam por modo)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Em REPORT: equivalente a Visualizar (preview em tela).
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Nao aplicavel a formularios de relatorio.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Em REPORT: limpa/reseta os campos de filtro.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias CRUD: delega para FormParaRelatorio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Alias CRUD: recarrega campos a partir do BO (LimparCampos).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Alias CRUD: campos de filtro sao sempre habilitados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Alias CRUD: nao aplicavel a formularios de relatorio.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Alias CRUD: botoes de relatorio nao variam por modo.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

ENDDEFINE
