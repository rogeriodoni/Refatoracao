# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSIGREGDP.prg] Procedure vazia (sem codigo): BOParaForm

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

## CONTEXTO DO ERRO


## ERROS COMUNS E SOLUCOES (Consultar CLAUDE.md)
- "Property PAGE1 is not found" -> Definir .PageCount ANTES de acessar .Page1
- "Property BACKCOLOR is not found" em PageFrame -> Remover BackColor do PageFrame, usar Page1.BackColor
- "RETURN/RETRY not allowed in TRY/CATCH" -> Usar variavel loc_lResultado e RETURN fora do TRY
- "Property ALLOWDELETE is not found" -> Grid VFP9 nao tem AllowDelete/AllowEdit/AllowAddNew
- "Property VISIBLE is not found" em Page -> Pages NAO tem .Visible, apenas PageFrame tem
- "Property ERASEPAGE is not found" -> PageFrame NAO tem ErasePage
- "Unknown member BUTTON1" -> OptionGroup: usar .Buttons(1) ao inves de .Button1
- "Property FONTNAME is not found" em OptionGroup -> OptionGroup NAO tem FontName/FontSize, definir nas Buttons(N)
- "Property FONTNAME is not found" em Grid -> SetAll("FontName",...,"Column") invalido, usar Grid.FontName diretamente
- "Alias XXX is not found" -> Criar cursor ANTES de definir ControlSource
- "Property THIS_CNOMETABELA is not found" -> Usar this_cTabela (nao this_cNomeTabela)
- "Property OBTERTODOS is not found" -> Usar Buscar("") (nao ObterTodos)
- "Property RELEASE is not found" -> Custom/BO NAO tem Release(), usar = .NULL.
- "Function argument value, type, or count is invalid" em FormParaBO -> Se TextBox.Value ja eh numerico, NAO usar VAL()
- "Unknown member PAGE1" apos WITH PageFrame -> Mover config das Pages para FORA do WITH block
- "PAGE1" ou "COLUMN1" apos .Name -> NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1 no resto do codigo)
- BINDEVENT nao funciona -> Metodo deve ser PUBLIC (sem PROTECTED)
- "Incorrect syntax near" em SQL com EscaparSQL/FormatarDataSQL -> Estas funcoes JA INCLUEM aspas. NUNCA adicionar aspas extras: usar campo = " + EscaparSQL(val), NAO campo = '" + EscaparSQL(val) + "'"
- TIMEOUT sem mensagem de erro visivel -> Provavelmente dialog modal de erro travando VFP

## REGRAS OBRIGATORIAS
- Corrigir APENAS o erro indicado, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- NAO alterar nomes de tabelas/colunas do banco (PILAR 2)
- Manter nomenclatura padronizada _4c_ (PILAR 3)
- Strings SQL longas DEVEM ser quebradas com `+;` (continuation) a cada 3-4 campos - NUNCA numa unica linha
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREGDP.prg):
*==============================================================================
* FORMSIGREGDP.PRG
* Emiss" + CHR(227) + "o Global de Duplicatas/Boletos (SIGREGDP)
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREGDP.SCX (frmrelatorio)
*
* Layout: Cabecalho + CommandGroup de 4 botoes + PageFrame de 1 pagina
*   - Cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo (cnt_4c_Cabecalho)
*   - 4 botoes do framework relatorio (cmg_4c_Botoes: Visualizar/Imprimir/DocExcel/Sair)
*   - PageFrame de 1 pagina (pgf_4c_Paginas.Page1 = "Sele" + CHR(231) + CHR(227) + "o")
*     hospeda filtros (Serie, NF Ini/Fim, optSelecao), botao Processar,
*     Grid com checkboxes (cursor_4c_Dados equivalente TmpNFis) e botoes
*     de marcacao SelTudo/Desmarcar
*==============================================================================

DEFINE CLASS FormSIGREGDP AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=700)
    Height      = 700
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

    *-- Referencia ao BO de relatorio
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
    *   1. Define Caption e Picture (fundo do form)
    *   2. Instancia SIGREGDPBO
    *   3. Monta cabecalho escuro com titulo (Top=0, Height=80)
    *   4. Monta CommandGroup de 4 botoes (Visualizar/Imprimir/DocExcel/Sair)
    *   5. Monta PageFrame de 1 pagina hospedando filtros, grid e selecao
    *   6. Adiciona filtros, grid e botoes de selecao na Page1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.Caption = "Emiss" + CHR(227) + "o Global de Duplicatas/Boletos"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Verificar conexao SQL (exceto em modo validacao UI)
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle < 0
                    MsgErro("Erro de conex" + CHR(227) + "o com banco de dados.", "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Instanciar Business Object de relatorio
            IF loc_lContinuar
                THIS.this_oRelatorio = CREATEOBJECT("SIGREGDPBO")
                IF VARTYPE(THIS.this_oRelatorio) != "O"
                    MsgErro("Erro ao criar SIGREGDPBO" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Cabecalho escuro com titulo (equivalente cntSombra/lblTitulo do frmrelatorio)
                THIS.ConfigurarCabecalho()

                *-- CommandGroup com 4 botoes (Visualizar/Imprimir/DocExcel/Sair)
                THIS.ConfigurarBotoes()

                *-- PageFrame de 1 pagina ("Sele" + CHR(231) + CHR(227) + "o") - hospeda filtros e grid
                THIS.ConfigurarPageFrame()

                *-- Filtros, Grid e botoes de selecao dentro da Page1 (via wrapper)
                THIS.ConfigurarPaginaLista()

                THIS.LimparCampos()
                THIS.AjustarBotoesPorModo()
                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormSIGREGDP:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro com titulo do relatorio
    *   Equivalente ao cntSombra/lblSombra/lblTitulo do framework frmrelatorio
    *   BackColor=RGB(100,100,100) cinza medio OPACO (BackStyle=1)
    *   Titulo branco sobre fundo escuro (ForeColor=RGB(255,255,255))
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Sombra do texto (efeito 3D - texto preto ligeiramente deslocado)
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 17
            .Left      = 12
            .AutoSize  = .T.
            .Caption   = "Emiss" + CHR(227) + "o Global de Duplicatas/Boletos"
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Titulo principal (texto branco sobre fundo cinza escuro)
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 20
            .Left      = 10
            .AutoSize  = .T.
            .Caption   = "Emiss" + CHR(227) + "o Global de Duplicatas/Boletos"
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
    *   Geometria EXATA do framework frmrelatorio (btnReport do original):
    *   Left=528, Top=0, Width=273, Height=80, ButtonCount=4
    *   Incremento entre botoes: 66px (Left: 5, 71, 137, 203)
    *   Buttons(4).Cancel = .T. (ESC fecha o form)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 528
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Botao 1: Visualizar (preview duplicatas/boletos)
        WITH THIS.cmg_4c_Botoes.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Width           = 65
            .Height          = 70
            .Caption         = "Visualizar"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")

        *-- Botao 2: Imprimir (emite duplicatas/boletos selecionados)
        WITH THIS.cmg_4c_Botoes.Buttons(2)
            .Top             = 5
            .Left            = 71
            .Width           = 65
            .Height          = 70
            .Caption         = "Imprimir"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")

        *-- Botao 3: DocExcel (exporta cursor para planilha Excel)
        WITH THIS.cmg_4c_Botoes.Buttons(3)
            .Top             = 5
            .Left            = 137
            .Width           = 65
            .Height          = 70
            .Caption         = "DocExcel"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoIcones + "excel.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")

        *-- Botao 4: Sair (fecha o formulario, Cancel=.T. => ESC fecha)
        WITH THIS.cmg_4c_Botoes.Buttons(4)
            .Top             = 5
            .Left            = 203
            .Width           = 65
            .Height          = 70
            .Caption         = "Sair"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoIcones + "otao_encerrar.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Cancel          = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame de 1 pagina ("Sele" + CHR(231) + CHR(227) + "o")
    *   O form legado SIGREGDP e FLAT, mas no novo padrao os controles de
    *   selecao e o grid sao agrupados em um PageFrame de 1 pagina para
    *   consistencia arquitetural com o restante do sistema (FormSIGREAUP,
    *   FormSIGREADS, etc.).
    *
    *   Geometria: Top=85 (logo apos cabecalho 80px + 5px folga), cobre o
    *   restante do form ate o bottom. Tabs=.F. (sem abas visiveis).
    *   Os filtros, grid e botoes de selecao serao adicionados DENTRO da Page1.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        loc_oPgf.PageCount = 1

        *-- Logo abaixo do cabecalho (80px) ate o fim do form
        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

        loc_oPgf.Page1.Caption   = "Sele" + CHR(231) + CHR(227) + "o"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Agrupa toda configuracao da Page1 (filtros + grid + selecao)
    *   Chamado por InicializarForm(). Para formsrelatorio de 1 pagina, "lista"
    *   corresponde a pagina unica que contem filtros, grid e botoes de selecao.
    *
    *   Os filtros sao divididos em duas metades:
    *     - ConfigurarPaginaDados(): primeira metade (Serie + NF Inicial)
    *     - ConfigurarFiltros(): segunda metade (NF Final + opt_4c_Selecao + Processar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarFiltros()
        THIS.ConfigurarGrade()
        THIS.ConfigurarBotoesSelecao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Primeira metade dos campos de filtro do relatorio
    *   Para frmrelatorio, "Dados" corresponde aos parametros de selecao.
    *   Esta metade adiciona Serie (Say1/Get_Serie) e NF Inicial (Say2/Get_NFIni).
    *
    *   Posicoes Top compensadas em -85 (form_top - PageFrame.Top=85):
    *     Say1 Top=138 -> 53, Get_Serie Top=135 -> 50
    *     Say2 Top=138 -> 53, Get_NFIni Top=135 -> 50
    *
    *   BINDEVENT do TxtSerie (lookup F4/ENTER/TAB) registrado aqui pois
    *   o controle eh criado neste metodo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Label Serie (Say1: Top=138 -> 53, Left=100)
        loc_oPagina.AddObject("lbl_4c_Serie", "Label")
        WITH loc_oPagina.lbl_4c_Serie
            .Top       = 53
            .Left      = 100
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "S" + CHR(233) + "rie : "
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Serie (Get_Serie: Top=135 -> 50, Left=145, Width=34)
        loc_oPagina.AddObject("txt_4c_Serie", "TextBox")
        WITH loc_oPagina.txt_4c_Serie
            .Top       = 50
            .Left      = 145
            .Width     = 34
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 3
            .Value     = ""
            .ForeColor = RGB(0, 0, 0)
            .TabIndex  = 2
            .Visible   = .T.
        ENDWITH

        *-- Label NF Inicial (Say2: Top=138 -> 53, Left=217)
        loc_oPagina.AddObject("lbl_4c_NfIni", "Label")
        WITH loc_oPagina.lbl_4c_NfIni
            .Top       = 53
            .Left      = 217
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "NF Inicial : "
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox NF Inicial (Get_NFIni: Top=135 -> 50, Left=283, Width=55)
        loc_oPagina.AddObject("txt_4c_NFIni", "TextBox")
        WITH loc_oPagina.txt_4c_NFIni
            .Top       = 50
            .Left      = 283
            .Width     = 55
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "999999"
            .MaxLength = 6
            .Alignment = 3
            .Value     = ""
            .ForeColor = RGB(0, 0, 0)
            .TabIndex  = 4
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENT do TxtSerie - lookup F4/ENTER/TAB na tabela SigCnFNf
        BINDEVENT(loc_oPagina.txt_4c_Serie, "KeyPress", THIS, "TeclaSerieKeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Ativa pagina especificada do PageFrame
    *   Para este relatorio (1 pagina), apenas garante visibilidade do PageFrame.
    *   Mantido para consistencia arquitetural com demais forms do sistema.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        loc_nPagina = IIF(par_nPagina >= 1, par_nPagina, 1)
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            IF loc_nPagina <= THIS.pgf_4c_Paginas.PageCount
                THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltros - Segunda metade dos filtros (NF Final, opt_Selecao, Processar)
    *   Posicoes Top compensadas em -85 (form_top - PageFrame.Top=85)
    *   Originais:
    *     Say3 Top=163, Get_NFFim Top=160 (-> Top=78/75)
    *     optSelecao Top=135 (-> Top=50)
    *     Processar Top=92 (-> Top=7)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltros()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Label NF Final (Say3: Top=163 -> 78, Left=225)
        loc_oPagina.AddObject("lbl_4c_NfFim", "Label")
        WITH loc_oPagina.lbl_4c_NfFim
            .Top       = 78
            .Left      = 225
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "NF Final : "
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox NF Final (Get_NFFim: Top=160 -> 75, Left=283, Width=55)
        loc_oPagina.AddObject("txt_4c_NFFim", "TextBox")
        WITH loc_oPagina.txt_4c_NFFim
            .Top       = 75
            .Left      = 283
            .Width     = 55
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "999999"
            .MaxLength = 6
            .Alignment = 3
            .Value     = ""
            .ForeColor = RGB(0, 0, 0)
            .TabIndex  = 6
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup tipo de selecao (Duplicatas / Boletos Bancarios)
        *   Original optSelecao: Top=135 -> 50, Left=346, W=141, H=48
        loc_oPagina.AddObject("opt_4c_Selecao", "OptionGroup")
        WITH loc_oPagina.opt_4c_Selecao
            .Top         = 50
            .Left        = 346
            .Width       = 141
            .Height      = 48
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .ButtonCount = 2
            .TabIndex    = 7
            .Value       = 1
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Duplicatas"
                .Top       = 5
                .Left      = 5
                .Height    = 15
                .Width     = 77
                .FontBold  = .T.
                .BackStyle = 0
                .AutoSize  = .T.
                .Style     = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Boletos Banc" + CHR(225) + "rios"
                .Top       = 25
                .Left      = 5
                .Height    = 15
                .Width     = 118
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .T.
                .Style     = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Botao Processar (Top=92 -> 7, Left=668, W=75, H=75)
        loc_oPagina.AddObject("cmd_4c_Processar", "CommandButton")
        WITH loc_oPagina.cmd_4c_Processar
            .Top             = 7
            .Left            = 668
            .Width           = 75
            .Height          = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .Caption         = "Processar"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .TabIndex        = 8
            .Visible         = .T.
        ENDWITH

        *-- BINDEVENT do botao Processar (TxtSerie.KeyPress vinculado em ConfigurarPaginaDados)
        BINDEVENT(loc_oPagina.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrade - Grid com 8 colunas (equivalente Grade/TmpNFis original)
    *   Coluna 1: CheckBox (Flag) - W=20
    *   Coluna 2: NFis (Numero) - W=45
    *   Coluna 3: Datas (Data) - W=70 - ColumnOrder=5
    *   Coluna 4: Digito - W=16 - ColumnOrder=3
    *   Coluna 5: Vecto - W=70 - ColumnOrder=7
    *   Coluna 6: Valor - W=80
    *   Coluna 7: Conta (Emitente/Destinatario) - W=160 - ColumnOrder=4
    *   Coluna 8: Operacao (Emps+Dopes+Numes) - W=170
    *   Original Grade: Top=192 -> 107, Left=72, W=671, H=329
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Dados

        WITH loc_oGrid
            .Top                = 107
            .Left               = 72
            .Width              = 671
            .Height             = 329
            .ColumnCount        = 8
            .FontName           = "Tahoma"
            .FontSize           = 8
            .AllowHeaderSizing  = .F.
            .AllowRowSizing     = .F.
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .ScrollBars         = 2
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .RecordSource       = THIS.this_oRelatorio.this_cCursorDados
            .Visible            = .T.

            *-- Column1: CheckBox Flag (W=20)
            *-- ORDEM CRITICA: AddObject -> CurrentControl -> ControlSource
            .Column1.Width             = 20
            .Column1.Movable           = .F.
            .Column1.Resizable         = .F.
            .Column1.ReadOnly          = .F.
            .Column1.Sparse            = .F.
            .Column1.FontName          = "Tahoma"
            .Column1.FontSize          = 8
            .Column1.Header1.Caption   = ""
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Column1.Header1.ForeColor = RGB(90, 90, 90)
            .Column1.AddObject("Check1", "CheckBox")
            .Column1.Check1.Caption    = ""
            .Column1.Check1.BackStyle  = 0
            .Column1.Check1.Alignment  = 0
            .Column1.Check1.AutoSize   = .T.
            .Column1.Check1.Value      = 0
            .Column1.CurrentControl    = "Check1"
            .Column1.ControlSource     = THIS.this_oRelatorio.this_cCursorDados + ".flag"

            *-- Column2: NFis - Numero (W=45)
            .Column2.ControlSource     = THIS.this_oRelatorio.this_cCursorDados + ".nfis"
            .Column2.Width             = 45
            .Column2.Movable           = .F.
            .Column2.Resizable         = .F.
            .Column2.ReadOnly          = .T.
            .Column2.FontBold          = .T.
            .Column2.FontName          = "Tahoma"
            .Column2.FontSize          = 8
            .Column2.Header1.Caption   = "N" + CHR(250) + "mero"
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.FontSize  = 8
            .Column2.Header1.Alignment = 2
            .Column2.Header1.ForeColor = RGB(90, 90, 90)
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin      = 0
            .Column2.Text1.ReadOnly    = .T.
            .Column2.Text1.ForeColor   = RGB(0, 0, 0)
            .Column2.Text1.BackColor   = RGB(255, 255, 255)

            *-- Column3: Datas - Data (W=70, ColumnOrder=5)
            .Column3.ControlSource     = THIS.this_oRelatorio.this_cCursorDados + ".datas"
            .Column3.Width             = 70
            .Column3.ColumnOrder       = 5
            .Column3.Movable           = .F.
            .Column3.Resizable         = .F.
            .Column3.ReadOnly          = .T.
            .Column3.FontName          = "Tahoma"
            .Column3.FontSize          = 8
            .Column3.Header1.Caption   = "Data"
            .Column3.Header1.FontName  = "Tahoma"
            .Column3.Header1.FontSize  = 8
            .Column3.Header1.Alignment = 2
            .Column3.Header1.ForeColor = RGB(90, 90, 90)
            .Column3.Text1.BorderStyle = 0
            .Column3.Text1.Margin      = 0
            .Column3.Text1.ReadOnly    = .T.
            .Column3.Text1.ForeColor   = RGB(0, 0, 0)
            .Column3.Text1.BackColor   = RGB(255, 255, 255)

            *-- Column4: Digito (W=16, ColumnOrder=3)
            .Column4.ControlSource     = THIS.this_oRelatorio.this_cCursorDados + ".digito"
            .Column4.Width             = 16
            .Column4.ColumnOrder       = 3
            .Column4.Movable           = .F.
            .Column4.Resizable         = .F.
            .Column4.ReadOnly          = .T.
            .Column4.FontName          = "Tahoma"
            .Column4.FontSize          = 8
            .Column4.Header1.Caption   = ""
            .Column4.Header1.FontName  = "Tahoma"
            .Column4.Header1.FontSize  = 8
            .Column4.Header1.Alignment = 2
            .Column4.Header1.ForeColor = RGB(90, 90, 90)
            .Column4.Text1.BorderStyle = 0
            .Column4.Text1.Margin      = 0
            .Column4.Text1.ReadOnly    = .T.
            .Column4.Text1.ForeColor   = RGB(0, 0, 0)
            .Column4.Text1.BackColor   = RGB(255, 255, 255)

            *-- Column5: Vecto (W=70, ColumnOrder=7)
            .Column5.ControlSource     = THIS.this_oRelatorio.this_cCursorDados + ".vecto"
            .Column5.Width             = 70
            .Column5.ColumnOrder       = 7
            .Column5.Movable           = .F.
            .Column5.Resizable         = .F.
            .Column5.ReadOnly          = .T.
            .Column5.FontName          = "Tahoma"
            .Column5.FontSize          = 8
            .Column5.Header1.Caption   = "Vecto"
            .Column5.Header1.FontName  = "Tahoma"
            .Column5.Header1.FontSize  = 8
            .Column5.Header1.Alignment = 2
            .Column5.Header1.ForeColor = RGB(90, 90, 90)
            .Column5.Text1.BorderStyle = 0
            .Column5.Text1.Margin      = 0
            .Column5.Text1.ReadOnly    = .T.
            .Column5.Text1.ForeColor   = RGB(0, 0, 0)
            .Column5.Text1.BackColor   = RGB(255, 255, 255)

            *-- Column6: Valor (W=80)
            .Column6.ControlSource     = THIS.this_oRelatorio.this_cCursorDados + ".valor"
            .Column6.Width             = 80
            .Column6.Movable           = .F.
            .Column6.Resizable         = .F.
            .Column6.ReadOnly          = .T.
            .Column6.InputMask         = "999,999,999.99"
            .Column6.FontName          = "Tahoma"
            .Column6.FontSize          = 8
            .Column6.Header1.Caption   = "Valor"
            .Column6.Header1.FontName  = "Tahoma"
            .Column6.Header1.FontSize  = 8
            .Column6.Header1.Alignment = 2
            .Column6.Header1.ForeColor = RGB(90, 90, 90)
            .Column6.Text1.BorderStyle = 0
            .Column6.Text1.Margin      = 0
            .Column6.Text1.ReadOnly    = .T.
            .Column6.Text1.ForeColor   = RGB(0, 0, 0)
            .Column6.Text1.BackColor   = RGB(255, 255, 255)

            *-- Column7: Conta/Emitente-Destinatario (W=160, ColumnOrder=4)
            .Column7.ControlSource     = THIS.this_oRelatorio.this_cCursorDados + ".conta"
            .Column7.Width             = 160
            .Column7.ColumnOrder       = 4
            .Column7.Movable           = .F.
            .Column7.Resizable         = .F.
            .Column7.ReadOnly          = .T.
            .Column7.FontName          = "Tahoma"
            .Column7.FontSize          = 8
            .Column7.Header1.Caption   = "Emitente / Destinat" + CHR(225) + "rio"
            .Column7.Header1.FontName  = "Tahoma"
            .Column7.Header1.FontSize  = 8
            .Column7.Header1.Alignment = 2
            .Column7.Header1.ForeColor = RGB(90, 90, 90)
            .Column7.Text1.BorderStyle = 0
            .Column7.Text1.Margin      = 0
            .Column7.Text1.ReadOnly    = .T.
            .Column7.Text1.ForeColor   = RGB(0, 0, 0)
            .Column7.Text1.BackColor   = RGB(255, 255, 255)

            *-- Column8: Operacao = Emps+Dopes+STR(Numes) (W=170)
            .Column8.ControlSource     = THIS.this_oRelatorio.this_cCursorDados + ".emps + " + ;
                                          THIS.this_oRelatorio.this_cCursorDados + ".dopes + " + ;
                                          "STR(" + THIS.this_oRelatorio.this_cCursorDados + ".numes, 6)"
            .Column8.Width             = 170
            .Column8.Movable           = .F.
            .Column8.Resizable         = .F.
            .Column8.ReadOnly          = .T.
            .Column8.FontName          = "Tahoma"
            .Column8.FontSize          = 8
            .Column8.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
            .Column8.Header1.FontName  = "Tahoma"
            .Column8.Header1.FontSize  = 8
            .Column8.Header1.Alignment = 2
            .Column8.Header1.ForeColor = RGB(90, 90, 90)
            .Column8.Text1.BorderStyle = 0
            .Column8.Text1.Margin      = 0
            .Column8.Text1.ReadOnly    = .T.
            .Column8.Text1.ForeColor   = RGB(0, 0, 0)
            .Column8.Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesSelecao - Botoes SelTudo (Selecionar) e Desmarcar abaixo do grid
    *   Originais: Top=529 -> 444 na Page1
    *   SelTudo: Left=71, Desmarcar/apaga: Left=117 (W=45, H=45)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesSelecao()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Botao SelTudo (Top=529 -> 444, Left=71, W=45, H=45)
        loc_oPagina.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH loc_oPagina.cmd_4c_SelTudo
            .Top           = 444
            .Left          = 71
            .Width         = 45
            .Height        = 45
            .FontName      = "Verdana"
            .FontSize      = 8
            .Picture       = gc_4c_CaminhoIcones + "a_save1.bmp"
            .Caption       = ""
            .ToolTipText   = "Selecionar Todos"
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer  = 15
            .TabIndex      = 10
            .Visible       = .T.
        ENDWITH

        *-- Botao Desmarcar/apaga (Top=529 -> 444, Left=117, W=45, H=45)
        loc_oPagina.AddObject("cmd_4c_Desmarcar", "CommandButton")
        WITH loc_oPagina.cmd_4c_Desmarcar
            .Top           = 444
            .Left          = 117
            .Width         = 45
            .Height        = 45
            .FontBold      = .F.
            .FontItalic    = .F.
            .FontName      = "Verdana"
            .FontSize      = 8
            .Picture       = gc_4c_CaminhoIcones + "cancelab.bmp"
            .Caption       = ""
            .ToolTipText   = "Desmarcar Todos"
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer  = 15
            .TabIndex      = 11
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.cmd_4c_SelTudo,   "Click", THIS, "BtnSelTudoClick")
        BINDEVENT(loc_oPagina.cmd_4c_Desmarcar, "Click", THIS, "BtnDesmarcarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere filtros do form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        WITH THIS.this_oRelatorio
            .this_cSerieNf = ALLTRIM(loc_oPagina.txt_4c_Serie.Value)
            .this_cNFIni   = ALLTRIM(loc_oPagina.txt_4c_NFIni.Value)
            .this_cNFFim   = ALLTRIM(loc_oPagina.txt_4c_NFFim.Value)
            .this_nSelecao = loc_oPagina.opt_4c_Selecao.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - Executa busca e popula grid (equivalente Processar.Click)
    *   Original: Zap In TmpNFis + Select com Where NFis Between + Where Series
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.PrepararDados()
            MsgErro(THIS.this_oRelatorio.this_cMensagemErro, "Processar")
        ELSE
            loc_oPagina.grd_4c_Dados.Refresh()
        ENDIF
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview de duplicatas/boletos para registros marcados
    *   Equivalente a opcao 1 (Duplicata) ou 2 (Boleto) com Preview
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            MsgErro(THIS.this_oRelatorio.this_cMensagemErro, "Visualizar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Emite duplicatas ou boletos para registros selecionados
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            MsgErro(THIS.this_oRelatorio.this_cMensagemErro, "Imprimir")
        ELSE
            loc_oPagina.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta cursor de dados para Excel
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cArq, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgAviso("Relat" + CHR(243) + "rio n" + CHR(227) + "o inicializado.")
            ELSE
                IF !THIS.this_oRelatorio.this_lProcessado
                    MsgAviso("Execute o Processamento antes de exportar.")
                ELSE
                    IF USED(THIS.this_oRelatorio.this_cCursorDados)
                        loc_cArq = SYS(5) + SYS(2003) + "\SIGREGDP_" + ;
                                   STRTRAN(DTOC(DATE()), "/", "") + "_" + ;
                                   STRTRAN(TIME(), ":", "") + ".xls"
                        SELECT (THIS.this_oRelatorio.this_cCursorDados)
                        COPY TO (loc_cArq) TYPE XLS
                        MsgInfo("Arquivo exportado:" + CHR(13) + loc_cArq)
                        loc_lSucesso = .T.
                    ELSE
                        MsgAviso("Nenhum dado dispon" + CHR(237) + "vel para exporta" + ;
                                 CHR(231) + CHR(227) + "o.")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSIGREGDP.BtnExcelClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSelTudoClick - Marca todos os registros do grid (Flag=.T.)
    *   Equivalente Update TmpNFis Set Flag = .t. + Grade.Refresh
    *--------------------------------------------------------------------------
    PROCEDURE BtnSelTudoClick()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        THIS.this_oRelatorio.SelecionarTodos()
        loc_oPagina.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDesmarcarClick - Desmarca todos os registros do grid (Flag=.F.)
    *   Equivalente Update TmpNFis Set Flag = .f. + Grade.Refresh
    *--------------------------------------------------------------------------
    PROCEDURE BtnDesmarcarClick()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        THIS.this_oRelatorio.DesmarcarTodos()
        loc_oPagina.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Carrega registros na selecao a partir dos filtros
    *   Form de RELATORIO: "Incluir" equivale a INCLUIR notas na grade de selecao
    *   (SigMvNfi + SigMvPar entre NF Inicial..NF Final na Serie informada).
    *   Validacao previa dos filtros e delegacao para BtnProcessarClick().
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oPagina, loc_cSerie, loc_cNfIni, loc_cNfFim
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_cSerie = ALLTRIM(loc_oPagina.txt_4c_Serie.Value)
        loc_cNfIni = ALLTRIM(loc_oPagina.txt_4c_NFIni.Value)
        loc_cNfFim = ALLTRIM(loc_oPagina.txt_4c_NFFim.Value)

        IF EMPTY(loc_cSerie)
            MsgAviso("Informe a S" + CHR(233) + "rie da Nota Fiscal antes de processar.")
            loc_oPagina.txt_4c_Serie.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(loc_cNfIni) OR EMPTY(loc_cNfFim)
            MsgAviso("Informe NF Inicial e NF Final antes de processar.")
            IF EMPTY(loc_cNfIni)
                loc_oPagina.txt_4c_NFIni.SetFocus()
            ELSE
                loc_oPagina.txt_4c_NFFim.SetFocus()
            ENDIF
            RETURN
        ENDIF
        IF VAL(loc_cNfIni) > VAL(loc_cNfFim)
            MsgAviso("NF Inicial deve ser menor ou igual " + CHR(224) + " NF Final.")
            loc_oPagina.txt_4c_NFIni.SetFocus()
            RETURN
        ENDIF

        THIS.BtnProcessarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Altera estado de selecao marcando todos os registros
    *   Form de RELATORIO: "Alterar" equivale a ALTERAR a selecao corrente,
    *   marcando todos os registros disponiveis no grid para emissao em lote.
    *   Equivalente ao SelTudo do legado (Update TmpNFis Set Flag = .t.).
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        IF !THIS.this_oRelatorio.this_lProcessado
            MsgAviso("Execute o Processamento antes de alterar a sele" + ;
                     CHR(231) + CHR(227) + "o.")
            RETURN
        ENDIF
        THIS.BtnSelTudoClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui registros da selecao desmarcando todos
    *   Form de RELATORIO: "Excluir" equivale a EXCLUIR registros da selecao,
    *   ou seja, desmarcar todos os Flag para que nenhuma duplicata/boleto
    *   seja emitido. Equivalente ao apaga do legado (Update Flag = .f.).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        IF !THIS.this_oRelatorio.this_lProcessado
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + ;
                     " registros para excluir da sele" + ;
                     CHR(231) + CHR(227) + "o.")
            RETURN
        ENDIF
        IF !MsgConfirma("Desmarcar todos os registros da sele" + ;
                        CHR(231) + CHR(227) + "o?")
            RETURN
        ENDIF
        THIS.BtnDesmarcarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaSerieKeyPress - Lookup F4 (115) e validacao ENTER (13)/TAB (9) no campo Serie
    *   Original: PROCEDURE Valid de Get_Serie chama fwBuscaExt na tabela SigCnFNf
    *   coluna 'series' para selecionar serie de nota fiscal.
    *   F4 (115) abre lookup sempre (mesmo campo vazio).
    *   ENTER (13)/TAB (9) abre lookup apenas se valor digitado.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaSerieKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_oBusca, loc_oPagina, loc_oTxt

        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_oTxt    = loc_oPagina.txt_4c_Serie
            loc_cValor  = ALLTRIM(loc_oTxt.Value)

            IF par_nKeyCode = 115 OR !EMPTY(loc_cValor)
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
                    gnConnHandle, ;
                    "SigCnFNf", ;
                    "cursor_4c_SerieRemota", ;
                    "series", ;
                    loc_cValor, ;
                    "Sele" + CHR(231) + CHR(227) + "o")

                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.mAddColuna("series", "", "C" + CHR(243) + "digos")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_SerieRemota")
                        SELECT cursor_4c_SerieRemota
                        loc_oTxt.Value = ALLTRIM(series)
                        USE IN cursor_4c_SerieRemota
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reseta campos de filtro para estado inicial
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        IF VARTYPE(loc_oPagina) = "O"
            IF VARTYPE(loc_oPagina.txt_4c_Serie) = "O"
                loc_oPagina.txt_4c_Serie.Value   = ""
            ENDIF
            IF VARTYPE(loc_oPagina.txt_4c_NFIni) = "O"
                loc_oPagina.txt_4c_NFIni.Value   = ""
            ENDIF
            IF VARTYPE(loc_oPagina.txt_4c_NFFim) = "O"
                loc_oPagina.txt_4c_NFFim.Value   = ""
            ENDIF
            IF VARTYPE(loc_oPagina.opt_4c_Selecao) = "O"
                loc_oPagina.opt_4c_Selecao.Value = 1
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Para form de relatorio, equivale a BtnProcessarClick
    *   Processa filtros e popula o grid com as NFs encontradas
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnProcessarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario (alias de BtnSairClick)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Para form de relatorio, delega para BtnImprimirClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Limpa filtros, reseta cursor de dados e atualiza botoes
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()

        IF VARTYPE(THIS.this_oRelatorio) = "O"
            IF USED(THIS.this_oRelatorio.this_cCursorDados)
                ZAP IN (THIS.this_oRelatorio.this_cCursorDados)
            ENDIF
            THIS.this_oRelatorio.this_lProcessado = .F.
        ENDIF

        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
        ENDIF

        THIS.AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Compatibilidade com FormBase; delega para FormParaRelatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Compatibilidade com FormBase
    *   Form de relatorio nao carrega dados do BO de volta para campos de filtro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        *-- Nao aplicavel para form de relatorio (filtros sao definidos pelo usuario)
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita os campos de filtro
    *   par_lHabilitar: .T. = habilitar, .F. = desabilitar
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        IF VARTYPE(loc_oPagina) != "O"
            RETURN
        ENDIF

        IF VARTYPE(loc_oPagina.txt_4c_Serie) = "O"
            loc_oPagina.txt_4c_Serie.Enabled   = par_lHabilitar
        ENDIF
        IF VARTYPE(loc_oPagina.txt_4c_NFIni) = "O"
            loc_oPagina.txt_4c_NFIni.Enabled   = par_lHabilitar
        ENDIF
        IF VARTYPE(loc_oPagina.txt_4c_NFFim) = "O"
            loc_oPagina.txt_4c_NFFim.Enabled   = par_lHabilitar
        ENDIF
        IF VARTYPE(loc_oPagina.opt_4c_Selecao) = "O"
            loc_oPagina.opt_4c_Selecao.Enabled = par_lHabilitar
        ENDIF
        IF VARTYPE(loc_oPagina.cmd_4c_Processar) = "O"
            loc_oPagina.cmd_4c_Processar.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Atualiza o grid com o estado atual do cursor de dados
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        IF VARTYPE(loc_oPagina) != "O"
            RETURN
        ENDIF

        IF VARTYPE(loc_oPagina.grd_4c_Dados) = "O"
            loc_oPagina.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme processamento
    *   Botoes Visualizar/Imprimir/DocExcel e SelTudo/Desmarcar ficam ativos
    *   somente apos PrepararDados() executado com sucesso.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lProcessado, loc_oPagina
        loc_lProcessado = .F.

        IF VARTYPE(THIS.this_oRelatorio) = "O"
            loc_lProcessado = THIS.this_oRelatorio.this_lProcessado
        ENDIF

        IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
            THIS.cmg_4c_Botoes.Buttons(1).Enabled = loc_lProcessado
            THIS.cmg_4c_Botoes.Buttons(2).Enabled = loc_lProcessado
            THIS.cmg_4c_Botoes.Buttons(3).Enabled = loc_lProcessado
        ENDIF

        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPagina) = "O"
            IF VARTYPE(loc_oPagina.cmd_4c_SelTudo) = "O"
                loc_oPagina.cmd_4c_SelTudo.Enabled   = loc_lProcessado
            ENDIF
            IF VARTYPE(loc_oPagina.cmd_4c_Desmarcar) = "O"
                loc_oPagina.cmd_4c_Desmarcar.Enabled = loc_lProcessado
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO e chama DODEFAULT
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGREGDPBO.prg):
*==============================================================================
* SIGREGDPBO.PRG
* Business Object - Emissao Global de Duplicatas/Boletos (SIGREGDP)
* Herda de: RelatorioBase
*
* Funcionalidade:
*   - Filtros: Serie NF, NF Inicial/Final, tipo (Duplicatas ou Boletos)
*   - Carrega SigMvNfi join SigMvPar no cursor de dados (equivalente TmpNFis)
*   - Impressao: chama SigIpDup (Duplicatas) ou SigPrIbl/SigPrIbb (Boletos)
*==============================================================================

DEFINE CLASS SIGREGDPBO AS RelatorioBase

    *-- Identificacao (sem tabela CRUD - form operacional)
    this_cTabela        = ""
    this_cCampoChave    = ""

    *-- Filtros do formulario
    this_cSerieNf       = ""    && Serie da NF (Get_Serie, C(3))
    this_cNFIni         = ""    && NF Inicial (Get_NFIni, C(6))
    this_cNFFim         = ""    && NF Final (Get_NFFim, C(6))
    this_nSelecao       = 0     && 1=Duplicatas, 2=Boletos Bancarios

    *-- Nomes dos cursores de trabalho
    this_cCursorDados   = "cursor_4c_Dados"     && Equivalente a TmpNFis (grid)
    this_cCursorOpFp    = "cursor_4c_OpFp"      && SigOpFp (FPags, ImpDups, ImpBols, ImpNotas)
    this_cCursorPam     = "cursor_4c_Pam"       && SigCdPam (MascNums)
    this_cCursorNfi     = "cursor_4c_NfiFiltro" && SigMvNfi JOIN SigMvPar filtrado
    this_cCursorCli     = "cursor_4c_Cli"       && SigCdCli (RClis - nome do cliente)

    *-- Estado interno
    this_lProcessado    = .F.   && .T. apos PrepararDados() executado com sucesso

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO e cursores auxiliares
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            IF DODEFAULT()
                IF THIS.InicializarCursores()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREGDPBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursores - Cria cursor local de dados e carrega auxiliares
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursores()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            *-- Criar cursor local equivalente ao TmpNFis do legado
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            CREATE CURSOR cursor_4c_Dados ( ;
                flag     L, ;
                datas    D NULL, ;
                nfis     C(6), ;
                valor    N(12,2), ;
                conta    C(40), ;
                digito   N(1), ;
                vecto    C(12), ;
                totnotas N(12,2), ;
                emps     C(3), ;
                dopes    C(20), ;
                numes    N(6), ;
                obs      M NULL, ;
                parcs    N(2) ;
            )

            *-- Em modo validacao UI, nao executar SQLs (sem conexao)
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ELSE
                *-- Carregar SigOpFp (formas de pagamento com flags de impressao)
                loc_cSQL = "SELECT fpags, impdups, impbols, impnotas FROM SigOpFp"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOpFp)
                IF loc_nResult > 0
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao carregar formas de pagamento (SigOpFp)"
                ENDIF

                *-- Carregar SigCdPam (mascara de numeros) - nao critico para funcionamento
                loc_cSQL = "SELECT mascnums FROM SigCdPam"
                SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorPam)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREGDPBO.InicializarCursores")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa NFs conforme filtros (equivalente Processar.Click)
    * Popula cursor_4c_Dados com os registros filtrados e validados
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cSQL2, loc_nResult
        LOCAL loc_cFPags, loc_cCliFors, loc_cNfis, loc_cConta, loc_cVecto
        LOCAL loc_nValos, loc_dDatas, loc_nParcs, loc_nNumes, loc_nTotNot
        LOCAL loc_cEmps, loc_cDopes, loc_cObs, loc_dVencs
        LOCAL loc_nImpDups, loc_nImpBols, loc_nImpNot, loc_nConta
        loc_lSucesso = .F.

        TRY
            *-- ZAP cursor de dados e resetar estado
            IF USED(THIS.this_cCursorDados)
                ZAP IN (THIS.this_cCursorDados)
            ENDIF
            THIS.this_lProcessado = .F.

            *-- Consultar SigMvNfi JOIN SigMvPar com filtros informados
            loc_cSQL = "SELECT a.nfis, a.clifors, a.totnotas, a.emps, a.dopes, a.numes, " + ;
                       "b.fpags, b.parcs, b.valos, b.datas, b.vencs, b.obs " + ;
                       "FROM SigMvNfi a " + ;
                       "INNER JOIN SigMvPar b ON a.empdopnums = b.empdopnums " + ;
                       "WHERE a.nfis BETWEEN " + EscaparSQL(THIS.this_cNFIni) + ;
                       " AND " + EscaparSQL(THIS.this_cNFFim) + ;
                       " AND a.series = " + EscaparSQL(THIS.this_cSerieNf) + ;
                       " ORDER BY a.emps, a.dopes, a.numes, b.fpags, b.parcs"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorNfi)
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao consultar notas fiscais. Verifique a conex" + ;
                                          CHR(227) + "o."
            ELSE
                WAIT WINDOW "Aguarde!!! Selecionando Notas Fiscais..." NOWAIT

                *-- Iterar sobre registros e popular cursor_4c_Dados
                SELECT (THIS.this_cCursorNfi)
                SCAN
                    *-- Capturar todos os valores necessarios antes de trocar de area
                    loc_cFPags   = ALLTRIM(cursor_4c_NfiFiltro.fpags)
                    loc_cCliFors = ALLTRIM(cursor_4c_NfiFiltro.clifors)
                    loc_cNfis    = ALLTRIM(cursor_4c_NfiFiltro.nfis)
                    loc_nValos   = cursor_4c_NfiFiltro.valos
                    loc_dDatas   = TTOD(NVL(cursor_4c_NfiFiltro.datas, CTOT("")))
                    loc_nParcs   = cursor_4c_NfiFiltro.parcs
                    loc_cEmps    = ALLTRIM(cursor_4c_NfiFiltro.emps)
                    loc_cDopes   = ALLTRIM(cursor_4c_NfiFiltro.dopes)
                    loc_nNumes   = cursor_4c_NfiFiltro.numes
                    loc_cObs     = NVL(cursor_4c_NfiFiltro.obs, "")
                    loc_nTotNot  = cursor_4c_NfiFiltro.totnotas
                    loc_dVencs   = cursor_4c_NfiFiltro.vencs

                    *-- Verificar forma de pagamento habilitada em SigOpFp
                    SELECT (THIS.this_cCursorOpFp)
                    LOCATE FOR ALLTRIM(fpags) = loc_cFPags

                    IF !FOUND()
                        SELECT (THIS.this_cCursorNfi)
                        LOOP
                    ENDIF

                    *-- Capturar flags de impressao da forma de pagamento
                    loc_nImpDups = cursor_4c_OpFp.impdups
                    loc_nImpBols = cursor_4c_OpFp.impbols
                    loc_nImpNot  = cursor_4c_OpFp.impnotas

                    *-- Filtrar por tipo de selecao (Duplicatas ou Boletos)
                    IF ((THIS.this_nSelecao = 1) AND (loc_nImpDups <> 1)) OR ;
                       ((THIS.this_nSelecao = 2) AND (loc_nImpBols <> 1))
                        SELECT (THIS.this_cCursorNfi)
                        LOOP
                    ENDIF

                    *-- Numero da parcela (digito)
                    loc_nConta = loc_nParcs

                    *-- Lookup de nome do cliente em SigCdCli
                    loc_cConta = loc_cCliFors
                    loc_cSQL2 = "SELECT rclis FROM SigCdCli WHERE iclis = " + ;
                                EscaparSQL(loc_cCliFors)
                    IF SQLEXEC(gnConnHandle, loc_cSQL2, THIS.this_cCursorCli) > 0
                        SELECT (THIS.this_cCursorCli)
                        IF !EOF()
                            loc_cConta = loc_cCliFors + " " + ALLTRIM(cursor_4c_Cli.rclis)
                        ENDIF
                        USE IN (THIS.this_cCursorCli)
                    ENDIF

                    *-- Calcular campo Vecto: data de vencimento ou forma de pagamento
                    IF loc_nImpNot = 1
                        loc_cVecto = DTOC(TTOD(NVL(loc_dVencs, CTOT(""))))
                    ELSE
                        loc_cVecto = loc_cFPags
                    ENDIF

                    *-- Inserir registro processado no cursor de dados
                    SELECT (THIS.this_cCursorDados)
                    INSERT INTO cursor_4c_Dados ( ;
                        flag, nfis, valor, datas, conta, digito, parcs, ;
                        vecto, totnotas, obs, emps, dopes, numes) ;
                    VALUES ( ;
                        .T., ;
                        loc_cNfis, ;
                        loc_nValos, ;
                        loc_dDatas, ;
                        loc_cConta, ;
                        loc_nConta, ;
                        loc_nParcs, ;
                        loc_cVecto, ;
                        loc_nTotNot, ;
                        loc_cObs, ;
                        loc_cEmps, ;
                        loc_cDopes, ;
                        loc_nNumes ;
                    )

                    SELECT (THIS.this_cCursorNfi)
                ENDSCAN

                WAIT CLEAR

                *-- Verificar resultado e alertar se vazio
                SELECT (THIS.this_cCursorDados)
                GO TOP
                IF EOF()
                    IF THIS.this_nSelecao = 1
                        MsgAviso("Nenhuma Duplicata Selecionada...")
                    ELSE
                        MsgAviso("Nenhum Boleto Banc" + CHR(225) + "rio Selecionado...")
                    ENDIF
                ENDIF

                THIS.this_lProcessado = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREGDPBO.PrepararDados")
            WAIT CLEAR
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Emite duplicatas ou boletos para os registros selecionados
    * Equivalente ao procedure "impressao" do legado
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_nQt, loc_cChave
        loc_lSucesso = .F.

        TRY
            IF !THIS.this_lProcessado
                MsgAviso("Execute o Processamento antes de Imprimir.")
            ELSE
                IF THIS.this_nSelecao = 1
                    *-- Emissao de Duplicatas via funcao legada SigIpDup
                    =SigIpDup("", THIS.this_cSerieNf, .T., .NULL.)
                    loc_lSucesso = .T.
                ELSE
                    *-- Emissao de Boletos Bancarios
                    *-- Montar cursor cabecalho agrupado por NF
                    IF USED("cursor_4c_MvCab")
                        USE IN cursor_4c_MvCab
                    ENDIF
                    SELECT emps, dopes, numes, parcs ;
                        FROM (THIS.this_cCursorDados) ;
                        WHERE flag ;
                        GROUP BY emps, dopes, numes, parcs ;
                        INTO CURSOR cursor_4c_MvCab READWRITE

                    *-- Verificar configuracao de boleto bancario em SigCnFBl
                    loc_cSQL = "SELECT COUNT(*) AS qt FROM SigCnFBl WHERE fpags <> ' '"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgBol")
                    IF loc_nResult < 1
                        MsgErro("Favor Reinicializar o Processo!!!", ;
                                "Falha na Conex" + CHR(227) + "o (SigCnFBl)")
                    ELSE
                        SELECT cursor_4c_CfgBol
                        loc_nQt = NVL(qt, 0)
                        USE IN cursor_4c_CfgBol

                        IF loc_nQt = 0
                            *-- Sem boleto bancario configurado: imprimir simples
                            DO FORM SigPrIbl WITH "", .NULL.
                        ELSE
                            *-- Com boleto bancario: imprimir por NF individualmente
                            SELECT cursor_4c_MvCab
                            SCAN
                                loc_cChave = cursor_4c_MvCab.emps + ;
                                             cursor_4c_MvCab.dopes + ;
                                             STR(cursor_4c_MvCab.numes, 6)
                                DO FORM SigPrIbb WITH loc_cChave, .NULL.
                            ENDSCAN
                        ENDIF

                        loc_lSucesso = .T.
                    ENDIF

                    IF USED("cursor_4c_MvCab")
                        USE IN cursor_4c_MvCab
                    ENDIF
                ENDIF

                *-- Reposicionar cursor de dados no final (comportamento original)
                IF USED(THIS.this_cCursorDados)
                    SELECT (THIS.this_cCursorDados)
                    GO BOTTOM
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREGDPBO.Imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarTodos - Marca Flag=.T. em todos os registros do cursor de dados
    * Equivalente ao botao SelTudo do legado
    *--------------------------------------------------------------------------
    PROCEDURE SelecionarTodos()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorDados)
                UPDATE (THIS.this_cCursorDados) SET flag = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREGDPBO.SelecionarTodos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - Marca Flag=.F. em todos os registros do cursor de dados
    * Equivalente ao botao apaga do legado
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorDados)
                UPDATE (THIS.this_cCursorDados) SET flag = .F.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREGDPBO.DesmarcarTodos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em modo impressao (original: Visualiza oculto)
    * No legado btnReport.Visualiza.Visible = .F. - nao havia preview separado.
    * Delega para Imprimir() para compatibilidade com qualquer chamada residual.
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        RETURN THIS.Imprimir()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Stub (relatorio nao possui chave primaria)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha todos os cursores abertos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED(THIS.this_cCursorOpFp)
            USE IN (THIS.this_cCursorOpFp)
        ENDIF
        IF USED(THIS.this_cCursorPam)
            USE IN (THIS.this_cCursorPam)
        ENDIF
        IF USED(THIS.this_cCursorNfi)
            USE IN (THIS.this_cCursorNfi)
        ENDIF
        IF USED(THIS.this_cCursorCli)
            USE IN (THIS.this_cCursorCli)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

