# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigPrCtr.prg] Procedure vazia (sem codigo): GrdEstoqueAfterRowColChange
[FormSigPrCtr.prg] Indicador de pendencia: *-- Buscar todos os elementos <det> independente

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigPrCtr.prg):
*==============================================================================
* FormSigPrCtr.prg - Controle de Movimentacoes por XML
* Migrado de: SIGPRCTR (frmcadastro)
* Fase 8/8: COMPLETO - todos os metodos implementados
*
* Estrutura: PageFrame externo (pgf_4c_Paginas)
*   Page1 (Lista): cabecalho + filtro periodo + grd_4c_Lista + botoes CRUD
*   Page2 (Dados): pgf_4c_Abas (2 sub-paginas) + botoes Confirmar/Cancelar
*     pgf_4c_Abas.Page1 (Dados): lbl + txt_4c_Grupo/Conta/Dconta/Cpf/Moeda + opt_4c_Custo
*     pgf_4c_Abas.Page2 (Itens): grdDisponivel + grdItemXml
*==============================================================================

DEFINE CLASS FormSigPrCtr AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity) - EXATAS do original (layout.json)
    Height       = 620
    Width        = 1200
    Caption      = "Controle de Movimentacoes por XML"
    AutoCenter   = .T.
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2
    FontName     = "Tahoma"
    FontSize     = 8
    ForeColor    = RGB(90, 90, 90)
    DataSession  = 2

    *-- Business Object e estado do formulario
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_cMensagemErro   = ""

    *-- Filtros de periodo (espelham os filtros do BO para os TextBoxes)
    this_dDtInicio = {}
    this_dDtFim    = {}

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Chamado automaticamente por FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Caption com acentos (CHR codes obrigatorios - CLAUDE.md regra 4)
            THIS.Caption = "Controle de Movimenta" + CHR(231) + CHR(245) + "es por XML"

            *-- Instanciar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrCtrBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"

                *-- Filtro inicial: hoje (replica comportamento do legado)
                THIS.this_dDtInicio = DATE()
                THIS.this_dDtFim    = DATE()

                *-- Propagar filtros para o BO
                THIS.this_oBusinessObject.this_dFiltroInicio = THIS.this_dDtInicio
                THIS.this_oBusinessObject.this_dFiltroFim    = THIS.this_dDtFim

                *-- Configurar estrutura visual
                THIS.ConfigurarPageFrame()

                *-- Carregar lista inicial (pular se validando UI sem conexao SQL)
                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    IF !THIS.CarregarLista()
                        *-- Falha ao carregar nao impede abertura do formulario
                    ENDIF
                ENDIF

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"
                loc_lSucesso                   = .T.

            ELSE
                MostrarErro("Erro ao criar SigPrCtrBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Linha: " + TRANSFORM(loException.LineNo) + ;
                                      " - " + loException.Message
            MostrarErro("Erro ao inicializar FormSigPrCtr:" + CHR(13) + ;
                THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame externo com 2 paginas (Lista/Dados)
    * PageFrame.Top = -29 para ocultar abas -> compensacao +29 nos controles
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.
        ENDWITH

        THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
        THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)

        THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
        THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Lista)
    * Original: SIGPRCTR.Pagina.Lista
    * Contem: cabecalho, filtro periodo, botoes CRUD, grd_4c_Lista
    * Compensacao PageFrame.Top=-29: todos os controles com Top += 29
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_oGrid   = .NULL.

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho com fundo escuro (cntSombra no legado)
        *-- Top = 2 + 29 (compensacao PageFrame.Top=-29) = 31
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = "Controle de Movimenta" + CHR(231) + CHR(245) + "es por XML"
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Controle de Movimenta" + CHR(231) + CHR(245) + "es por XML"
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (canonico framework: Left=542, Width=390, Height=85)
        *-- Top = 0 + 29 (compensacao) = 29
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (Left=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Visualizar (Left=80)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Alterar (Left=155)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Excluir (Left=230)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Buscar (Left=305)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Container saida - PADRAO CANONICO (CLAUDE.md regra #10: Left=917, Width=90)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Encerrar (canonico: Left=5, Width=75, Height=75)
        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Filtro de periodo (original: Label1/Dt_inicial/Dt_final em Pagina.Lista)
        *-- Original top=106 -> compensacao +29 -> top=135
        loc_oPagina.AddObject("lbl_4c_LabelPeriodo", "Label")
        WITH loc_oPagina.lbl_4c_LabelPeriodo
            .Caption   = "Per" + CHR(237) + "odo :"
            .Top       = 135
            .Left      = 440
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Original top=102 -> compensacao +29 -> top=131
        loc_oPagina.AddObject("txt_4c_DtInicio", "TextBox")
        WITH loc_oPagina.txt_4c_DtInicio
            .Value     = DATE()
            .Top       = 131
            .Left      = 495
            .Width     = 80
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Format    = "D"
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LabelSep", "Label")
        WITH loc_oPagina.lbl_4c_LabelSep
            .Caption   = "-"
            .Top       = 135
            .Left      = 582
            .Width     = 10
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtFim", "TextBox")
        WITH loc_oPagina.txt_4c_DtFim
            .Value     = DATE()
            .Top       = 131
            .Left      = 598
            .Width     = 80
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Format    = "D"
            .Visible   = .T.
        ENDWITH

        *-- Grid de lista (Grade no legado: abaixo dos filtros)
        *-- Top=160 (abaixo dos filtros ~135+21=156); Width=form.Width-15; Height=450
        *-- ColumnCount e RecordSource/ControlSource: definidos FORA de WITH (Problema 36)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista

        loc_oGrid.Top          = 160
        loc_oGrid.Left         = 5
        loc_oGrid.Width        = THIS.Width - 15
        loc_oGrid.Height       = 450
        loc_oGrid.ColumnCount  = 6
        loc_oGrid.FontName     = "Verdana"
        loc_oGrid.FontSize     = 8
        loc_oGrid.ForeColor    = RGB(90, 90, 90)
        loc_oGrid.BackColor    = RGB(255, 255, 255)
        loc_oGrid.GridLineColor      = RGB(238, 238, 238)
        loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
        loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
        loc_oGrid.HighlightStyle     = 2
        loc_oGrid.DeleteMark   = .F.
        loc_oGrid.RecordMark   = .F.
        loc_oGrid.RowHeight    = 16
        loc_oGrid.ScrollBars   = 3
        loc_oGrid.GridLines    = 3
        loc_oGrid.Visible      = .T.

        *-- BINDEVENTs dos botoes CRUD (metodos devem ser PUBLIC para BINDEVENT)
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        *-- BINDEVENTs dos filtros de periodo (LostFocus replica Valid/LostFocus do legado)
        BINDEVENT(loc_oPagina.txt_4c_DtInicio, "KeyPress", THIS, "DtInicioLostFocus")
        BINDEVENT(loc_oPagina.txt_4c_DtFim,    "KeyPress", THIS, "DtFimLostFocus")

        *-- BINDEVENT do grid: par_nColIndex obrigatorio (Problema 38)
        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridListaAfterRowColChange")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * Cria: cnt_4c_BotoesAcao (Confirmar/Cancelar), pgf_4c_Abas (2 sub-paginas)
    * Campos e grids de pgf_4c_Abas adicionados nas Fases 5-6
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oPgfAbas
        loc_oPagina  = THIS.pgf_4c_Paginas.Page2
        loc_oPgfAbas = .NULL.

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes de acao (Confirmar/Cancelar)
        *-- Top = 4 + 29 (compensacao) = 33; Left = 1030 (lado direito)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 1030
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (salvar)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Cancelar
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- BINDEVENTs dos botoes de acao (PUBLIC para BINDEVENT)
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- PageFrame interno (Pageframe1 no legado: top=3, left=-1, width=1199, height=624)
        *-- Top = 3 + 29 (compensacao) = 32
        loc_oPagina.AddObject("pgf_4c_Abas", "PageFrame")
        loc_oPgfAbas = loc_oPagina.pgf_4c_Abas

        loc_oPgfAbas.Top       = 32
        loc_oPgfAbas.Left      = -1
        loc_oPgfAbas.Width     = 1199
        loc_oPgfAbas.Height    = 624
        loc_oPgfAbas.PageCount = 2
        loc_oPgfAbas.Tabs      = .T.
        loc_oPgfAbas.Visible   = .T.

        *-- Page1 (Dados): campos do cabecalho da sessao + grdEstoque (Fase 6)
        loc_oPgfAbas.Page1.Caption   = "Dados"
        loc_oPgfAbas.Page1.BackColor = RGB(255, 255, 255)

        *-- Page2 (Itens): grdDisponivel + grdItemXml (Fase 6)
        loc_oPgfAbas.Page2.Caption   = "Itens"
        loc_oPgfAbas.Page2.BackColor = RGB(255, 255, 255)

        *-- Fases 5-6: campos das abas Dados e Itens
        THIS.ConfigurarAbaDados()
        THIS.ConfigurarAbaItens()

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAbaDados - Configura pgf_4c_Abas.Page1 (Dados) com campos Fase 5
    * Original: SIGPRCTR.Pagina.Dados.Pageframe1.Page1
    * Contem: Fornecedor (Grupo/Conta/Dconta/Cpf) + Moeda + opt_4c_Custo
    * Sem compensacao Top: pgf_4c_Abas tem Tabs=.T. (coordenadas originais diretas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAbaDados()
        LOCAL loc_oPage, loc_oOpt
        loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        loc_oOpt  = .NULL.

        *-- Label Fornecedores (Say4: top=69, left=228)
        loc_oPage.AddObject("lbl_4c_Fornecedores", "Label")
        WITH loc_oPage.lbl_4c_Fornecedores
            .Caption   = "Fornecedores:"
            .Top       = 69
            .Left      = 228
            .Width     = 75
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Grupo (Get_Grupo: top=66, left=307, width=85)
        loc_oPage.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPage.txt_4c_Grupo
            .Value     = ""
            .Top       = 66
            .Left      = 307
            .Width     = 85
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Conta (Get_Conta: top=66, left=394, width=85)
        loc_oPage.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPage.txt_4c_Conta
            .Value     = ""
            .Top       = 66
            .Left      = 394
            .Width     = 85
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- TextBox CPF/CNPJ (Get_cpf: top=66, left=481, width=146)
        loc_oPage.AddObject("txt_4c_Cpf", "TextBox")
        WITH loc_oPage.txt_4c_Cpf
            .Value     = ""
            .Top       = 66
            .Left      = 481
            .Width     = 146
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- CommandButton Consulta (Bot_Consulta: top=70, left=667, width=40, height=40)
        *-- Standalone icon button: Themes=.T. obrigatorio (memoria)
        loc_oPage.AddObject("cmd_4c_Consulta", "CommandButton")
        WITH loc_oPage.cmd_4c_Consulta
            .Caption         = ""
            .Top             = 70
            .Left            = 667
            .Width           = 40
            .Height          = 40
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_26.jpg"
            .PicturePosition = 4
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .ToolTipText     = "Consultar"
            .Visible         = .T.
        ENDWITH

        *-- CommandButton Cadastros (btnCadastros: top=70, left=708, width=40, height=40)
        loc_oPage.AddObject("cmd_4c_Cadastros", "CommandButton")
        WITH loc_oPage.cmd_4c_Cadastros
            .Caption         = ""
            .Top             = 70
            .Left            = 708
            .Width           = 40
            .Height          = 40
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 4
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .ToolTipText     = "Cadastros"
            .Visible         = .T.
        ENDWITH

        *-- TextBox Dconta (Get_Dconta: top=89, left=307, width=357) - somente leitura (display)
        loc_oPage.AddObject("txt_4c_Dconta", "TextBox")
        WITH loc_oPage.txt_4c_Dconta
            .Value     = ""
            .Top       = 89
            .Left      = 307
            .Width     = 357
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(230, 230, 230)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Label Precificacao (Say1: top=114, left=237)
        loc_oPage.AddObject("lbl_4c_Precificacao", "Label")
        WITH loc_oPage.lbl_4c_Precificacao
            .Caption   = "Precifica" + CHR(231) + CHR(227) + "o:"
            .Top       = 114
            .Left      = 237
            .Width     = 65
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Custo (Opt_Custo: top=113, left=303, width=255, height=17, buttons=2)
        *-- Problema 30: NAO setar .Value em Buttons(N); usar OptionGroup.Value para default
        loc_oPage.AddObject("opt_4c_Custo", "OptionGroup")
        loc_oOpt = loc_oPage.opt_4c_Custo

        loc_oOpt.Top         = 113
        loc_oOpt.Left        = 303
        loc_oOpt.Width       = 255
        loc_oOpt.Height      = 17
        loc_oOpt.ButtonCount = 2
        loc_oOpt.Value       = 1
        loc_oOpt.BackStyle   = 0
        loc_oOpt.Visible     = .T.

        WITH loc_oOpt.Buttons(1)
            .Caption   = "Custo"
            .Top       = 0
            .Left      = 0
            .Width     = 120
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .F.
        ENDWITH

        WITH loc_oOpt.Buttons(2)
            .Caption   = "Pre" + CHR(231) + "o de Venda"
            .Top       = 0
            .Left      = 125
            .Width     = 130
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .F.
        ENDWITH

        *-- Label Moeda (Say3: top=137, left=262)
        loc_oPage.AddObject("lbl_4c_Moeda", "Label")
        WITH loc_oPage.lbl_4c_Moeda
            .Caption   = "Moeda:"
            .Top       = 137
            .Left      = 262
            .Width     = 42
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Moeda (Get_Moeda: top=134, left=307, width=85)
        loc_oPage.AddObject("txt_4c_Moeda", "TextBox")
        WITH loc_oPage.txt_4c_Moeda
            .Value     = ""
            .Top       = 134
            .Left      = 307
            .Width     = 85
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Shape1 decorativo (top=2, left=912, width=90, height=110)
        loc_oPage.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPage.shp_4c_Shape1
            .Top         = 2
            .Left        = 912
            .Width       = 90
            .Height      = 110
            .BackStyle   = 1
            .BackColor   = RGB(192, 192, 192)
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH

        *-- Label Diretorio (Say2: top=160, left=253)
        loc_oPage.AddObject("lbl_4c_Diretorio", "Label")
        WITH loc_oPage.lbl_4c_Diretorio
            .Caption   = "Diret" + CHR(243) + "rio:"
            .Top       = 160
            .Left      = 253
            .Width     = 52
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Arquivo (Get_Arquivo: top=157, left=307, width=357; When=.F. no original -> ReadOnly)
        loc_oPage.AddObject("txt_4c_Arquivo", "TextBox")
        WITH loc_oPage.txt_4c_Arquivo
            .Value         = ""
            .Top           = 157
            .Left          = 307
            .Width         = 357
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(230, 230, 230)
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- CommandButton BrowseArquivo (Command12: top=157, left=667, width=20, height=20)
        loc_oPage.AddObject("cmd_4c_BrowseArquivo", "CommandButton")
        WITH loc_oPage.cmd_4c_BrowseArquivo
            .Caption  = "..."
            .Top      = 157
            .Left     = 667
            .Width    = 20
            .Height   = 20
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .T.
            .Visible  = .T.
        ENDWITH

        *-- Label "Carregar produtos que constam nos XML's :" (Label1: top=184, left=55)
        loc_oPage.AddObject("lbl_4c_OpcaoFil", "Label")
        WITH loc_oPage.lbl_4c_OpcaoFil
            .Caption   = "Carregar produtos que constam nos XML" + CHR(39) + "s :"
            .Top       = 184
            .Left      = 55
            .Width     = 246
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Opt_Fil (top=179, left=303, width=192, height=24, 3 botoes)
        *-- Problema 30: NAO setar .Value em Buttons(N); usar OptionGroup.Value para default
        loc_oPage.AddObject("opt_4c_Fil", "OptionGroup")
        loc_oOpt = loc_oPage.opt_4c_Fil

        loc_oOpt.Top         = 179
        loc_oOpt.Left        = 303
        loc_oOpt.Width       = 192
        loc_oOpt.Height      = 24
        loc_oOpt.ButtonCount = 3
        loc_oOpt.Value       = 1
        loc_oOpt.BackStyle   = 0
        loc_oOpt.Visible     = .T.

        WITH loc_oOpt.Buttons(1)
            .Caption   = "Todos"
            .Top       = 3
            .Left      = 0
            .Width     = 58
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
        ENDWITH

        WITH loc_oOpt.Buttons(2)
            .Caption   = "Cadastrados"
            .Top       = 3
            .Left      = 60
            .Width     = 84
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
        ENDWITH

        WITH loc_oOpt.Buttons(3)
            .Caption   = "N" + CHR(227) + "o Cad."
            .Top       = 3
            .Left      = 146
            .Width     = 46
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
        ENDWITH

        *-- Label "Movimentacoes:" (Say5: top=204, left=203)
        loc_oPage.AddObject("lbl_4c_Movimentacoes", "Label")
        WITH loc_oPage.lbl_4c_Movimentacoes
            .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es:"
            .Top       = 204
            .Left      = 203
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Grid grd_4c_Estoque (top=206, left=307, width=545, height=340, 6 colunas)
        *-- Problema 36: ColumnCount FORA do WITH (criacao imediata das colunas)
        *-- Headers definidos aqui; RecordSource/ControlSource definidos em CarregarGradeEstoque
        loc_oPage.AddObject("grd_4c_Estoque", "Grid")
        loc_oPage.grd_4c_Estoque.ColumnCount = 6
        WITH loc_oPage.grd_4c_Estoque
            .Top       = 206
            .Left      = 307
            .Width     = 545
            .Height    = 340
            .FontName  = "Tahoma"
            .FontSize  = 8
            .GridLines = 1
            .ReadOnly  = .T.
            .Visible   = .T.
            .RecordMark   = .F.
            .DeleteMark   = .F.
        ENDWITH
        WITH loc_oPage.grd_4c_Estoque.Column1
            .Width     = 25
            .Resizable = .F.
        ENDWITH
        loc_oPage.grd_4c_Estoque.Column1.Header1.Caption = " "
        WITH loc_oPage.grd_4c_Estoque.Column2
            .Width = 65
        ENDWITH
        loc_oPage.grd_4c_Estoque.Column2.Header1.Caption = "Empresa"
        WITH loc_oPage.grd_4c_Estoque.Column3
            .Width = 120
        ENDWITH
        loc_oPage.grd_4c_Estoque.Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
        WITH loc_oPage.grd_4c_Estoque.Column4
            .Width = 80
        ENDWITH
        loc_oPage.grd_4c_Estoque.Column4.Header1.Caption = "Numero"
        WITH loc_oPage.grd_4c_Estoque.Column5
            .Width = 130
        ENDWITH
        loc_oPage.grd_4c_Estoque.Column5.Header1.Caption = "Grupo"
        WITH loc_oPage.grd_4c_Estoque.Column6
            .Width = 125
        ENDWITH
        loc_oPage.grd_4c_Estoque.Column6.Header1.Caption = "Conta"

        *-- CommandGroup cgp_4c_Operacao (cmdOperacao: top=334, left=857, width=85, height=85)
        loc_oPage.AddObject("cgp_4c_Operacao", "CommandGroup")
        WITH loc_oPage.cgp_4c_Operacao
            .Top         = 334
            .Left        = 857
            .Width       = 85
            .Height      = 85
            .ButtonCount = 1
            .BackStyle   = 1
            .BackColor   = RGB(192, 192, 192)
            .Visible     = .T.
        ENDWITH
        WITH loc_oPage.cgp_4c_Operacao.Buttons(1)
            .Caption  = "Acessar"
            .Top      = 5
            .Left     = 5
            .Width    = 75
            .Height   = 75
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
        ENDWITH

        *-- CommandButton cmd_4c_Processar (processar: top=7, left=962, standalone/icon)
        *-- Standalone CommandButton com picture: Themes=.T. obrigatorio (memoria)
        loc_oPage.AddObject("cmd_4c_Processar", "CommandButton")
        WITH loc_oPage.cmd_4c_Processar
            .Caption         = "Processar"
            .Top             = 7
            .Left            = 917
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .PicturePosition = 4
            .Themes          = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Visible         = .T.
        ENDWITH

        *-- BINDEVENTs (todos os handlers devem ser PUBLIC para BINDEVENT)
        BINDEVENT(loc_oPage.txt_4c_Grupo,         "KeyPress",         THIS, "ValidarGrupoAba")
        BINDEVENT(loc_oPage.txt_4c_Grupo,         "KeyPress",          THIS, "TeclaGrupoAba")
        BINDEVENT(loc_oPage.txt_4c_Conta,         "KeyPress",         THIS, "ValidarContaAba")
        BINDEVENT(loc_oPage.txt_4c_Conta,         "KeyPress",          THIS, "TeclaContaAba")
        BINDEVENT(loc_oPage.txt_4c_Cpf,           "KeyPress",         THIS, "ValidarCpfAba")
        BINDEVENT(loc_oPage.txt_4c_Moeda,         "KeyPress",         THIS, "ValidarMoedaAba")
        BINDEVENT(loc_oPage.txt_4c_Moeda,         "KeyPress",          THIS, "TeclaMoedaAba")
        BINDEVENT(loc_oPage.cmd_4c_Consulta,      "Click",             THIS, "BtnConsultaAbaClick")
        BINDEVENT(loc_oPage.cmd_4c_Cadastros,     "Click",             THIS, "BtnCadastrosAbaClick")
        BINDEVENT(loc_oPage.cmd_4c_BrowseArquivo, "Click",             THIS, "BtnBrowseArquivoClick")
        BINDEVENT(loc_oPage.cmd_4c_Processar,     "Click",             THIS, "BtnProcessarClick")
        BINDEVENT(loc_oPage.cgp_4c_Operacao,      "Click",             THIS, "CgpOperacaoClick")
        BINDEVENT(loc_oPage.grd_4c_Estoque,       "AfterRowColChange", THIS, "GrdEstoqueAfterRowColChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAbaItens - Configura pgf_4c_Abas.Page2 (Itens) com grids e campos
    * Original: SIGPRCTR.Pagina.Dados.Pageframe1.Page2
    * grd_4c_Disponivel (crMovimentos), grd_4c_ItemXml (crDistribui)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAbaItens()
        LOCAL loc_oPage, loc_oGrd
        loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
        loc_oGrd  = .NULL.

        *-- Shape5 decorativo (top=1, left=424, width=282, height=113)
        loc_oPage.AddObject("shp_4c_Shape5", "Shape")
        WITH loc_oPage.shp_4c_Shape5
            .Top         = 1
            .Left        = 424
            .Width       = 282
            .Height      = 113
            .BackStyle   = 1
            .BackColor   = RGB(192, 192, 192)
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH

        *-- Image FigJpg (top=3, left=426, width=278, height=109)
        loc_oPage.AddObject("img_4c_FigJpg", "Image")
        WITH loc_oPage.img_4c_FigJpg
            .Top      = 3
            .Left     = 426
            .Width    = 278
            .Height   = 109
            .Stretch  = 2
            .Visible  = .T.
        ENDWITH

        *-- Label "Procurar Produto :" (lbl_produto: top=74, left=8, width=91)
        loc_oPage.AddObject("lbl_4c_Produto", "Label")
        WITH loc_oPage.lbl_4c_Produto
            .Caption   = "Procurar Produto :"
            .Top       = 74
            .Left      = 8
            .Width     = 108
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox get_produto_inicial (top=90, left=8, width=108)
        loc_oPage.AddObject("txt_4c_ProdutoInicial", "TextBox")
        WITH loc_oPage.txt_4c_ProdutoInicial
            .Value    = ""
            .Top      = 90
            .Left     = 8
            .Width    = 108
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- TextBox Sistema (readonly, top=113, left=8, width=684, height=20)
        loc_oPage.AddObject("txt_4c_Sistema", "TextBox")
        WITH loc_oPage.txt_4c_Sistema
            .Value     = ""
            .Top       = 113
            .Left      = 8
            .Width     = 684
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Arquivo/display (readonly, top=113, left=691, width=495, height=20)
        loc_oPage.AddObject("txt_4c_Arquivo", "TextBox")
        WITH loc_oPage.txt_4c_Arquivo
            .Value     = ""
            .Top       = 113
            .Left      = 691
            .Width     = 495
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Visible   = .T.
        ENDWITH

        *-- Grid grd_4c_Disponivel (crMovimentos: top=134, left=8, width=684, height=344, 7 cols)
        *-- Problema 36: ColumnCount FORA do WITH; Problema 32: Headers APOS RecordSource
        loc_oPage.AddObject("grd_4c_Disponivel", "Grid")
        loc_oPage.grd_4c_Disponivel.ColumnCount = 7
        WITH loc_oPage.grd_4c_Disponivel
            .Top       = 134
            .Left      = 8
            .Width     = 684
            .Height    = 344
            .FontName  = "Tahoma"
            .FontSize  = 8
            .GridLines = 1
            .Visible   = .T.
            .RecordMark   = .F.
            .DeleteMark   = .F.
        ENDWITH
        WITH loc_oPage.grd_4c_Disponivel.Column1
            .Width = 80
        ENDWITH
        WITH loc_oPage.grd_4c_Disponivel.Column2
            .Width = 200
        ENDWITH
        WITH loc_oPage.grd_4c_Disponivel.Column3
            .Width = 80
        ENDWITH
        WITH loc_oPage.grd_4c_Disponivel.Column4
            .Width = 70
        ENDWITH
        WITH loc_oPage.grd_4c_Disponivel.Column5
            .Width = 80
        ENDWITH
        WITH loc_oPage.grd_4c_Disponivel.Column6
            .Width = 80
        ENDWITH
        WITH loc_oPage.grd_4c_Disponivel.Column7
            .Width = 94
        ENDWITH

        *-- Grid grd_4c_ItemXml (crDistribui: top=134, left=693, width=493, height=344, 4 cols)
        loc_oPage.AddObject("grd_4c_ItemXml", "Grid")
        loc_oPage.grd_4c_ItemXml.ColumnCount = 4
        WITH loc_oPage.grd_4c_ItemXml
            .Top       = 134
            .Left      = 693
            .Width     = 493
            .Height    = 344
            .FontName  = "Tahoma"
            .FontSize  = 8
            .GridLines = 1
            .Visible   = .T.
            .RecordMark   = .F.
            .DeleteMark   = .F.
        ENDWITH
        WITH loc_oPage.grd_4c_ItemXml.Column1
            .Width = 100
        ENDWITH
        WITH loc_oPage.grd_4c_ItemXml.Column2
            .Width = 220
        ENDWITH
        WITH loc_oPage.grd_4c_ItemXml.Column3
            .Width = 80
        ENDWITH
        WITH loc_oPage.grd_4c_ItemXml.Column4
            .Width = 93
        ENDWITH

        *-- CommandButton btnExcluirSis (top=479, left=663, width=40, height=37)
        loc_oPage.AddObject("cmd_4c_BtnExcluirSis", "CommandButton")
        WITH loc_oPage.cmd_4c_BtnExcluirSis
            .Caption         = ""
            .Top             = 479
            .Left            = 663
            .Width           = 40
            .Height          = 37
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 4
            .Themes          = .T.
            .ToolTipText     = "Remover produto da lista"
            .Visible         = .T.
        ENDWITH

        *-- CommandButton btnExcluirArq (top=479, left=1146, width=40, height=37)
        loc_oPage.AddObject("cmd_4c_BtnExcluirArq", "CommandButton")
        WITH loc_oPage.cmd_4c_BtnExcluirArq
            .Caption         = ""
            .Top             = 479
            .Left            = 1146
            .Width           = 40
            .Height          = 37
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 4
            .Themes          = .T.
            .ToolTipText     = "Remover item XML da lista"
            .Visible         = .T.
        ENDWITH

        *-- Label "Movimentacao :" (Say3: top=483, left=40, width=78)
        loc_oPage.AddObject("lbl_4c_Movimentacao", "Label")
        WITH loc_oPage.lbl_4c_Movimentacao
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
            .Top       = 483
            .Left      = 40
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox getEmps (top=480, left=122, width=65)
        loc_oPage.AddObject("txt_4c_Emps", "TextBox")
        WITH loc_oPage.txt_4c_Emps
            .Value     = ""
            .Top       = 480
            .Left      = 122
            .Width     = 65
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Visible   = .T.
        ENDWITH

        *-- TextBox getDopes (top=480, left=188, width=205)
        loc_oPage.AddObject("txt_4c_Dopes", "TextBox")
        WITH loc_oPage.txt_4c_Dopes
            .Value     = ""
            .Top       = 480
            .Left      = 188
            .Width     = 205
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Visible   = .T.
        ENDWITH

        *-- TextBox getNumes (top=480, left=393, width=65)
        loc_oPage.AddObject("txt_4c_Numes", "TextBox")
        WITH loc_oPage.txt_4c_Numes
            .Value     = ""
            .Top       = 480
            .Left      = 393
            .Width     = 65
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Visible   = .T.
        ENDWITH

        *-- TextBox getcIdChaves (top=480, left=459, width=173)
        loc_oPage.AddObject("txt_4c_CIdChaves", "TextBox")
        WITH loc_oPage.txt_4c_CIdChaves
            .Value     = ""
            .Top       = 480
            .Left      = 459
            .Width     = 173
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Visible   = .T.
        ENDWITH

        *-- Label "Ref. Fornecedor :" (lbl_ref_fornecedor: top=505, left=30, width=88)
        loc_oPage.AddObject("lbl_4c_RefFornecedor", "Label")
        WITH loc_oPage.lbl_4c_RefFornecedor
            .Caption   = "Ref. Fornecedor :"
            .Top       = 505
            .Left      = 30
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox get_ref_fornecedor (top=502, left=122, width=190)
        loc_oPage.AddObject("txt_4c_RefFornecedor", "TextBox")
        WITH loc_oPage.txt_4c_RefFornecedor
            .Value     = ""
            .Top       = 502
            .Left      = 122
            .Width     = 190
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Visible   = .T.
        ENDWITH

        *-- Label "Custo :" (Say5: top=527, left=81, width=37)
        loc_oPage.AddObject("lbl_4c_Custo", "Label")
        WITH loc_oPage.lbl_4c_Custo
            .Caption   = "Custo :"
            .Top       = 527
            .Left      = 81
            .Width     = 40
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox get_precoMov (top=524, left=122, width=108)
        loc_oPage.AddObject("txt_4c_PrecoMov", "TextBox")
        WITH loc_oPage.txt_4c_PrecoMov
            .Value     = 0
            .Top       = 524
            .Left      = 122
            .Width     = 108
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Visible   = .T.
        ENDWITH

        *-- Label "Preco Venda :" (lbl_pr_venda: top=549, left=49, width=69)
        loc_oPage.AddObject("lbl_4c_PrVenda", "Label")
        WITH loc_oPage.lbl_4c_PrVenda
            .Caption   = "Pre" + CHR(231) + "o Venda :"
            .Top       = 549
            .Left      = 49
            .Width     = 75
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox get_pr_venda (top=546, left=122, width=108)
        loc_oPage.AddObject("txt_4c_PrVenda", "TextBox")
        WITH loc_oPage.txt_4c_PrVenda
            .Value     = 0
            .Top       = 546
            .Left      = 122
            .Width     = 108
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Visible   = .T.
        ENDWITH

        *-- TextBox get_pr_venda_moeda (top=546, left=231, width=31)
        loc_oPage.AddObject("txt_4c_PrVendaMoeda", "TextBox")
        WITH loc_oPage.txt_4c_PrVendaMoeda
            .Value     = ""
            .Top       = 546
            .Left      = 231
            .Width     = 31
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Visible   = .T.
        ENDWITH

        *-- Label "Peso :" (Say1: top=550, left=348, width=32)
        loc_oPage.AddObject("lbl_4c_Peso", "Label")
        WITH loc_oPage.lbl_4c_Peso
            .Caption   = "Peso :"
            .Top       = 550
            .Left      = 348
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox get_peso_medio (top=547, left=383, width=75)
        loc_oPage.AddObject("txt_4c_PesoMedio", "TextBox")
        WITH loc_oPage.txt_4c_PesoMedio
            .Value     = 0
            .Top       = 547
            .Left      = 383
            .Width     = 75
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Visible   = .T.
        ENDWITH

        *-- Label "Preco Custo :" (Say2: top=571, left=51, width=67)
        loc_oPage.AddObject("lbl_4c_PrecoCusto", "Label")
        WITH loc_oPage.lbl_4c_PrecoCusto
            .Caption   = "Pre" + CHR(231) + "o Custo :"
            .Top       = 571
            .Left      = 51
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox get_custofs (top=568, left=122, width=108)
        loc_oPage.AddObject("txt_4c_Custofs", "TextBox")
        WITH loc_oPage.txt_4c_Custofs
            .Value     = 0
            .Top       = 568
            .Left      = 122
            .Width     = 108
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Visible   = .T.
        ENDWITH

        *-- TextBox get_moecusfs (top=568, left=231, width=31)
        loc_oPage.AddObject("txt_4c_Moecusfs", "TextBox")
        WITH loc_oPage.txt_4c_Moecusfs
            .Value     = ""
            .Top       = 568
            .Left      = 231
            .Width     = 31
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENTs de Page2 (Itens)
        BINDEVENT(loc_oPage.grd_4c_Disponivel, "AfterRowColChange", THIS, "GrdDisponivelAfterRowColChange")
        BINDEVENT(loc_oPage.cmd_4c_BtnExcluirSis, "Click",          THIS, "BtnExcluirSisClick")
        BINDEVENT(loc_oPage.cmd_4c_BtnExcluirArq, "Click",          THIS, "BtnExcluirArqClick")
        BINDEVENT(loc_oPage.txt_4c_ProdutoInicial, "KeyPress",     THIS, "ProdutoInicialLostFocus")
        BINDEVENT(loc_oPage.img_4c_FigJpg,        "Click",          THIS, "ImgFigJpgClick")
    ENDPROC

    *==========================================================================
    * HANDLERS DOS CAMPOS DE pgf_4c_Abas.Page1 (PUBLIC para BINDEVENT)
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarGrupoAba - LostFocus: valida codigo de grupo em SigCdGcr
    * Original: Get_Grupo.Valid -> fAcessoContab(Usuar,'C',This.Value,...)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupoAba(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPage, loc_cGrupo, loc_nRet
        loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        loc_cGrupo = ""
        loc_nRet   = 0

        IF TYPE("loc_oPage.txt_4c_Grupo") != "O"
            RETURN
        ENDIF

        loc_cGrupo = ALLTRIM(NVL(loc_oPage.txt_4c_Grupo.Value, ""))

        IF EMPTY(loc_cGrupo)
            RETURN
        ENDIF

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Codigos FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo), ;
                "cursor_4c_BuscaGrupo")

            IF loc_nRet > 0 AND USED("cursor_4c_BuscaGrupo") AND !EOF("cursor_4c_BuscaGrupo")
                *-- Grupo valido
            ELSE
                THIS.AbrirBuscaGrupoAba()
            ENDIF

            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em ValidarGrupoAba")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaGrupoAba - KeyPress: F4 abre picker de grupo
    * LPARAMETERS obrigatorio para KeyPress via BINDEVENT (memoria Erro18)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaGrupoAba(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrupoAba()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGrupoAba - FormBuscaAuxiliar para SigCdGcr
    * SigCdGcr: Codigos (PK) e Descrs (com 'r' - irregularidade, memoria #115)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaGrupoAba()
        LOCAL loc_oPage, loc_oBusca, loc_cGrupo
        loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        loc_oBusca = .NULL.
        loc_cGrupo = ""

        IF TYPE("loc_oPage.txt_4c_Grupo") != "O"
            RETURN
        ENDIF

        loc_cGrupo = ALLTRIM(NVL(loc_oPage.txt_4c_Grupo.Value, ""))

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
                "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos LIKE " + ;
                    EscaparSQL(loc_cGrupo + "%") + " ORDER BY Codigos", ;
                "cursor_4c_BusGrupo", ;
                gnConnHandle)

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Codigos", "@!", "Grupo")
                loc_oBusca.mAddColuna("Descrs",  "",   "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BusGrupo") AND !EOF("cursor_4c_BusGrupo")
                        loc_oPage.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BusGrupo.Codigos)
                    ENDIF
                ELSE
                    loc_oPage.txt_4c_Grupo.Value = ""
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em AbrirBuscaGrupoAba")
        ENDTRY

        IF USED("cursor_4c_BusGrupo")
            USE IN cursor_4c_BusGrupo
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarContaAba - LostFocus: valida conta em SigCdCli; preenche Dconta e CPF
    * Original: Get_Conta.Valid -> fAcessoContas(...) + preenche Get_Dconta + CPF
    *--------------------------------------------------------------------------
    PROCEDURE ValidarContaAba(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPage, loc_cConta, loc_nRet
        loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        loc_cConta = ""
        loc_nRet   = 0

        IF TYPE("loc_oPage.txt_4c_Conta") != "O"
            RETURN
        ENDIF

        loc_cConta = ALLTRIM(NVL(loc_oPage.txt_4c_Conta.Value, ""))

        IF EMPTY(loc_cConta)
            IF TYPE("loc_oPage.txt_4c_Dconta") = "O"
                loc_oPage.txt_4c_Dconta.Value = ""
            ENDIF
            IF TYPE("loc_oPage.txt_4c_Cpf") = "O"
                loc_oPage.txt_4c_Cpf.Value = ""
            ENDIF
            RETURN
        ENDIF

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta), ;
                "cursor_4c_BuscaConta")

            IF loc_nRet > 0 AND USED("cursor_4c_BuscaConta") AND !EOF("cursor_4c_BuscaConta")
                IF TYPE("loc_oPage.txt_4c_Dconta") = "O"
                    loc_oPage.txt_4c_Dconta.Value = ALLTRIM(NVL(cursor_4c_BuscaConta.Rclis, ""))
                ENDIF
                IF TYPE("loc_oPage.txt_4c_Cpf") = "O"
                    loc_oPage.txt_4c_Cpf.Value = ALLTRIM(NVL(cursor_4c_BuscaConta.Cpfs, ""))
                ENDIF
            ELSE
                THIS.AbrirBuscaContaAba()
            ENDIF

            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em ValidarContaAba")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaContaAba - KeyPress: F4 abre picker de conta
    *--------------------------------------------------------------------------
    PROCEDURE TeclaContaAba(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaContaAba()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaContaAba - FormBuscaAuxiliar para SigCdCli
    * Apos selecao, preenche Dconta (Rclis) e Cpf (Cpfs) automaticamente
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaContaAba()
        LOCAL loc_oPage, loc_oBusca, loc_cConta
        loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        loc_oBusca = .NULL.
        loc_cConta = ""

        IF TYPE("loc_oPage.txt_4c_Conta") != "O"
            RETURN
        ENDIF

        loc_cConta = ALLTRIM(NVL(loc_oPage.txt_4c_Conta.Value, ""))

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
                "SELECT Iclis, Rclis, Cpfs FROM SigCdCli WHERE Iclis LIKE " + ;
                    EscaparSQL(loc_cConta + "%") + " ORDER BY Iclis", ;
                "cursor_4c_BusConta", ;
                gnConnHandle)

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Iclis", "@!", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Rclis", "",   "Nome")
                loc_oBusca.mAddColuna("Cpfs",  "@!", "CPF/CNPJ")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BusConta") AND !EOF("cursor_4c_BusConta")
                        loc_oPage.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BusConta.Iclis)
                        IF TYPE("loc_oPage.txt_4c_Dconta") = "O"
                            loc_oPage.txt_4c_Dconta.Value = ALLTRIM(NVL(cursor_4c_BusConta.Rclis, ""))
                        ENDIF
                        IF TYPE("loc_oPage.txt_4c_Cpf") = "O"
                            loc_oPage.txt_4c_Cpf.Value = ALLTRIM(NVL(cursor_4c_BusConta.Cpfs, ""))
                        ENDIF
                    ENDIF
                ELSE
                    loc_oPage.txt_4c_Conta.Value = ""
                    IF TYPE("loc_oPage.txt_4c_Dconta") = "O"
                        loc_oPage.txt_4c_Dconta.Value = ""
                    ENDIF
                    IF TYPE("loc_oPage.txt_4c_Cpf") = "O"
                        loc_oPage.txt_4c_Cpf.Value = ""
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em AbrirBuscaContaAba")
        ENDTRY

        IF USED("cursor_4c_BusConta")
            USE IN cursor_4c_BusConta
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCpfAba - LostFocus: valida formato CPF/CNPJ; busca reversa em SigCdCli
    * Original: Get_cpf.Valid -> valida 11 ou 14 digitos; preenche Conta e Dconta
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCpfAba(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPage, loc_cCpf, loc_cDigitos, loc_nLen, loc_nRet
        loc_oPage    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        loc_cCpf     = ""
        loc_cDigitos = ""
        loc_nLen     = 0
        loc_nRet     = 0

        IF TYPE("loc_oPage.txt_4c_Cpf") != "O"
            RETURN
        ENDIF

        loc_cCpf = ALLTRIM(NVL(loc_oPage.txt_4c_Cpf.Value, ""))

        IF EMPTY(loc_cCpf)
            RETURN
        ENDIF

        *-- Remover mascaras .-/ para contar apenas digitos
        loc_cDigitos = STRTRAN(STRTRAN(STRTRAN(loc_cCpf, ".", ""), "-", ""), "/", "")
        loc_nLen     = LEN(ALLTRIM(loc_cDigitos))

        IF loc_nLen != 11 AND loc_nLen != 14
            MsgAviso("CPF deve ter 11 d" + CHR(237) + "gitos ou CNPJ 14 d" + CHR(237) + "gitos!", ;
                "CPF/CNPJ inv" + CHR(225) + "lido")
            loc_oPage.txt_4c_Cpf.SetFocus()
            RETURN
        ENDIF

        *-- Busca reversa: SigCdCli por Cpfs -> preenche Conta e Dconta
        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE Cpfs = " + EscaparSQL(loc_cCpf), ;
                "cursor_4c_BuscaCpf")

            IF loc_nRet > 0 AND USED("cursor_4c_BuscaCpf") AND !EOF("cursor_4c_BuscaCpf")
                IF TYPE("loc_oPage.txt_4c_Conta") = "O"
                    loc_oPage.txt_4c_Conta.Value = ALLTRIM(NVL(cursor_4c_BuscaCpf.Iclis, ""))
                ENDIF
                IF TYPE("loc_oPage.txt_4c_Dconta") = "O"
                    loc_oPage.txt_4c_Dconta.Value = ALLTRIM(NVL(cursor_4c_BuscaCpf.Rclis, ""))
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaCpf")
                USE IN cursor_4c_BuscaCpf
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em ValidarCpfAba")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMoedaAba - LostFocus: valida codigo de moeda em SigCdMoe
    * Original: Get_Moeda.Valid -> fwbuscaext em SigCdMoe (CMoes/DMoes)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarMoedaAba(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPage, loc_cMoeda, loc_nRet
        loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        loc_cMoeda = ""
        loc_nRet   = 0

        IF TYPE("loc_oPage.txt_4c_Moeda") != "O"
            RETURN
        ENDIF

        loc_cMoeda = ALLTRIM(NVL(loc_oPage.txt_4c_Moeda.Value, ""))

        IF EMPTY(loc_cMoeda)
            RETURN
        ENDIF

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cMoeda), ;
                "cursor_4c_BuscaMoeda")

            IF loc_nRet > 0 AND USED("cursor_4c_BuscaMoeda") AND !EOF("cursor_4c_BuscaMoeda")
                *-- Moeda valida
            ELSE
                THIS.AbrirBuscaMoedaAba()
            ENDIF

            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em ValidarMoedaAba")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaMoedaAba - KeyPress: F4 abre picker de moeda
    *--------------------------------------------------------------------------
    PROCEDURE TeclaMoedaAba(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaMoedaAba()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaMoedaAba - FormBuscaAuxiliar para SigCdMoe
    * Substitui fwbuscaext original de Get_Moeda.Valid
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaMoedaAba()
        LOCAL loc_oPage, loc_oBusca, loc_cMoeda
        loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        loc_oBusca = .NULL.
        loc_cMoeda = ""

        IF TYPE("loc_oPage.txt_4c_Moeda") != "O"
            RETURN
        ENDIF

        loc_cMoeda = ALLTRIM(NVL(loc_oPage.txt_4c_Moeda.Value, ""))

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
                "SELECT CMoes, DMoes FROM SigCdMoe WHERE CMoes LIKE " + ;
                    EscaparSQL(loc_cMoeda + "%") + " ORDER BY CMoes", ;
                "cursor_4c_BusMoeda", ;
                gnConnHandle)

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("CMoes", "@!", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("DMoes", "",   "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BusMoeda") AND !EOF("cursor_4c_BusMoeda")
                        loc_oPage.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BusMoeda.CMoes)
                    ENDIF
                ELSE
                    loc_oPage.txt_4c_Moeda.Value = ""
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em AbrirBuscaMoedaAba")
        ENDTRY

        IF USED("cursor_4c_BusMoeda")
            USE IN cursor_4c_BusMoeda
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS DE pgf_4c_Abas.Page1 - Arquivo/Processar/Estoque (PUBLIC)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnBrowseArquivoClick - Original: Command12.Click -> GetFile([XML])
    *--------------------------------------------------------------------------
    PROCEDURE BtnBrowseArquivoClick()
        LOCAL loc_oPage, loc_cArquivo
        loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        loc_cArquivo = ""

        loc_cArquivo = GETFILE("XML", "Selecionar arquivo XML", "Selecionar")

        IF !EMPTY(loc_cArquivo) AND TYPE("loc_oPage.txt_4c_Arquivo") = "O"
            loc_oPage.txt_4c_Arquivo.Value = loc_cArquivo
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - Original: processar.Click (150 linhas)
    * Valida entradas, chama CarregarArquivosXml + CarregarItemXML + CarregarGradeEstoque
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick()
        LOCAL loc_oPage, loc_oPage2, loc_cArquivo, loc_cConta, loc_cCpf
        loc_oPage    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        loc_oPage2   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
        loc_cArquivo = ""
        loc_cConta   = ""
        loc_cCpf     = ""

        IF TYPE("loc_oPage.txt_4c_Arquivo") = "O"
            loc_cArquivo = ALLTRIM(NVL(loc_oPage.txt_4c_Arquivo.Value, ""))
        ENDIF
        IF TYPE("loc_oPage.txt_4c_Conta") = "O"
            loc_cConta = ALLTRIM(NVL(loc_oPage.txt_4c_Conta.Value, ""))
        ENDIF
        IF TYPE("loc_oPage.txt_4c_Cpf") = "O"
            loc_cCpf = ALLTRIM(NVL(loc_oPage.txt_4c_Cpf.Value, ""))
        ENDIF

        IF EMPTY(loc_cArquivo)
            MsgAviso("Nenhum Diret" + CHR(243) + "rio Foi Informado.", "Aviso")
            RETURN
        ENDIF

        IF EMPTY(loc_cConta)
            MsgAviso("Nenhum Fornecedor Foi Informado.", "Aviso")
            RETURN
        ENDIF

        IF EMPTY(loc_cCpf)
            MsgAviso("CNPJ/CPF do Fornecedor N" + CHR(227) + "o Informado", "Aviso")
            RETURN
        ENDIF

        TRY
            THIS.CarregarArquivosXml(loc_cArquivo)
            THIS.CarregarItemXML()
            THIS.CarregarGradeEstoque()

            *-- Atualiza display do arquivo na Page2 (Itens)
            IF TYPE("loc_oPage2.txt_4c_Arquivo") = "O"
                loc_oPage2.txt_4c_Arquivo.Value = loc_cArquivo
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em BtnProcessarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CgpOperacaoClick - Original: cmdOperacao.Valid -> SigCdOpe/SigCdOpd lookup
    * Verifica tipo de operacao e abre SigMvExp ou SigMvObj
    *--------------------------------------------------------------------------
    PROCEDURE CgpOperacaoClick()
        LOCAL loc_oPage, loc_cEmps, loc_cDopes, loc_cNumes, loc_nRet
        loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        loc_cEmps  = ""
        loc_cDopes = ""
        loc_cNumes = ""
        loc_nRet   = 0

        IF !USED("cursor_4c_Estoque") OR EOF("cursor_4c_Estoque")
            MsgAviso("Selecione um registro na grade!", "Aten" + CHR(231) + CHR(227) + "o!")
            RETURN
        ENDIF

        SELECT cursor_4c_Estoque
        loc_cEmps  = ALLTRIM(NVL(cursor_4c_Estoque.Emps,  ""))
        loc_cDopes = ALLTRIM(NVL(cursor_4c_Estoque.Dopes, ""))
        loc_cNumes = ALLTRIM(NVL(cursor_4c_Estoque.Numes, ""))

        IF EMPTY(loc_cEmps) OR EMPTY(loc_cDopes) OR EMPTY(loc_cNumes)
            MsgAviso("Selecione um registro na grade!", "Aten" + CHR(231) + CHR(227) + "o!")
            RETURN
        ENDIF

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopes), ;
                "cursor_4c_TmpOpe")

            IF loc_nRet > 0 AND USED("cursor_4c_TmpOpe") AND !EOF("cursor_4c_TmpOpe")
                MsgAviso("Formul" + CHR(225) + "rio SigMvExp ainda n" + CHR(227) + "o migrado.", ;
                    "Indispon" + CHR(237) + "vel")
            ELSE
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Dopps FROM SigCdOpd WHERE Dopps = " + EscaparSQL(loc_cDopes), ;
                    "cursor_4c_TmpOpd")

                IF loc_nRet > 0 AND USED("cursor_4c_TmpOpd") AND !EOF("cursor_4c_TmpOpd")
                    MsgAviso("Formul" + CHR(225) + "rio SigMvObj ainda n" + CHR(227) + "o migrado.", ;
                        "Indispon" + CHR(237) + "vel")
                ELSE
                    MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada em SigCdOpe/SigCdOpd.", ;
                        "Aviso")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em CgpOperacaoClick")
        ENDTRY

        IF USED("cursor_4c_TmpOpe")
            USE IN cursor_4c_TmpOpe
        ENDIF
        IF USED("cursor_4c_TmpOpd")
            USE IN cursor_4c_TmpOpd
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdEstoqueAfterRowColChange - AfterRowColChange de grd_4c_Estoque
    * par_nColIndex obrigatorio para BINDEVENT AfterRowColChange (Problema 38)
    *--------------------------------------------------------------------------
    PROCEDURE GrdEstoqueAfterRowColChange(par_nColIndex)
        *-- Grid e readonly; cgp_4c_Operacao le o registro corrente no momento do click
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGradeEstoque - Popula grd_4c_Estoque com SigMvCab disponiveis
    * Original: MontaGrade (25 linhas) -> SELECT SigMvCab + joins + filtros
    * Problema 36: ColumnCount FORA WITH; Problema 32: Headers APOS RecordSource
    * Problema 48: ControlSource APOS RecordSource
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGradeEstoque()
        LOCAL loc_oPage, loc_oGrd, loc_cConta, loc_nOpt, loc_nRet
        LOCAL loc_cSql, loc_cFiltro
        loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        loc_cConta = ""
        loc_nOpt   = 1
        loc_nRet   = 0
        loc_cSql   = ""
        loc_cFiltro = ""

        IF TYPE("loc_oPage.grd_4c_Estoque") != "O"
            RETURN
        ENDIF

        *-- Ler filtros da Page1
        IF TYPE("loc_oPage.txt_4c_Conta") = "O"
            loc_cConta = ALLTRIM(NVL(loc_oPage.txt_4c_Conta.Value, ""))
        ENDIF
        IF TYPE("loc_oPage.opt_4c_Fil") = "O"
            loc_nOpt = NVL(loc_oPage.opt_4c_Fil.Value, 1)
        ENDIF

        *-- Montar filtro por Conta
        IF !EMPTY(loc_cConta)
            loc_cFiltro = " AND a.ContaOs = " + EscaparSQL(loc_cConta)
        ENDIF

        *-- Filtro por Opt_Fil: 2=Cadastrados, 3=Nao Cadastrados
        DO CASE
            CASE loc_nOpt = 2
                loc_cFiltro = loc_cFiltro + " AND a.EmpDopNums IN (SELECT cpros FROM SigCdPro WHERE situas <> 'I')"
            CASE loc_nOpt = 3
                loc_cFiltro = loc_cFiltro + " AND a.EmpDopNums NOT IN (SELECT cpros FROM SigCdPro WHERE situas <> 'I')"
        ENDCASE

        loc_cSql = "SELECT 0 AS nMarca, a.Emps, a.Dopes, a.Numes, " + ;
            "a.EmpDopNums AS OriDopNums, a.grupoOs AS Grupos, a.contaOs AS Contas " + ;
            "FROM SigMvCab a " + ;
            "JOIN sigcdope b ON a.dopes = b.dopes " + ;
            "JOIN SigOpCdd c ON b.dopes = c.dopes " + ;
            "WHERE Distribui = 3 AND a.chksubn = 0 " + ;
            "AND a.GrupoOs <> SPACE(10) AND a.ContaOs <> SPACE(10)" + ;
            loc_cFiltro

        TRY
            *-- Limpar RecordSource antes de recriar (Problema 36)
            loc_oPage.grd_4c_Estoque.RecordSource = ""

            IF USED("cursor_4c_Estoque")
                USE IN cursor_4c_Estoque
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_Estoque")

            IF loc_nRet > 0 AND USED("cursor_4c_Estoque")
                loc_oGrd = loc_oPage.grd_4c_Estoque

                *-- Problema 36: ColumnCount FORA de WITH
                loc_oGrd.ColumnCount = 6
                *-- Problema 36: RecordSource FORA de WITH
                loc_oGrd.ColumnCount = 5
                loc_oGrd.RecordSource = "cursor_4c_Estoque"

                *-- Problema 32: Headers APOS RecordSource
                loc_oGrd.Column1.Header1.Caption = " "
                loc_oGrd.Column2.Header1.Caption = "Empresa"
                loc_oGrd.Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
                loc_oGrd.Column4.Header1.Caption = "Numero"
                loc_oGrd.Column5.Header1.Caption = "Grupo"
                loc_oGrd.Column6.Header1.Caption = "Conta"

                *-- Problema 48: ControlSource APOS RecordSource
                loc_oGrd.Column1.ControlSource = "cursor_4c_Estoque.nMarca"
                loc_oGrd.Column2.ControlSource = "cursor_4c_Estoque.Emps"
                loc_oGrd.Column3.ControlSource = "cursor_4c_Estoque.Dopes"
                loc_oGrd.Column4.ControlSource = "cursor_4c_Estoque.Numes"
                loc_oGrd.Column5.ControlSource = "cursor_4c_Estoque.Grupos"
                loc_oGrd.Column6.ControlSource = "cursor_4c_Estoque.Contas"

                WITH loc_oGrd
                    .Column1.Width = 25
                    .Column2.Width = 65
                    .Column3.Width = 120
                    .Column4.Width = 80
                    .Column5.Width = 130
                    .Column6.Width = 125
                    .ReadOnly      = .T.
                ENDWITH

                loc_oGrd.Refresh()
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em CarregarGradeEstoque")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarArquivosXml - Original: carregarquivos (122 linhas)
    * Parseia NF-e XML via MSXML.DOMDOCUMENT e popula cursor crItens
    *--------------------------------------------------------------------------
    PROCEDURE CarregarArquivosXml(par_cArquivo)
        LOCAL loc_oXml, loc_oItens, loc_oDet, loc_nTotal, loc_i
        LOCAL loc_cProd, loc_cDescr, loc_nQtd, loc_nValUni, loc_nValTot
        LOCAL loc_cUnid, loc_cCfop, loc_cNcm, loc_nDesc, loc_nFrete
        LOCAL loc_lResultado
        loc_oXml       = .NULL.
        loc_oItens     = .NULL.
        loc_oDet       = .NULL.
        loc_nTotal     = 0
        loc_i          = 0
        loc_lResultado = .T.

        IF EMPTY(par_cArquivo) OR !FILE(par_cArquivo)
            MsgAviso("Arquivo XML n" + CHR(227) + "o encontrado: " + par_cArquivo, "Aviso")
            RETURN
        ENDIF

        TRY
            *-- Limpar cursor anterior
            IF USED("crItens")
                USE IN crItens
            ENDIF

            SET NULL ON
            CREATE CURSOR crItens ;
                (codigo C(15), Descr C(50), quant N(12,3), valor_uni N(12,4), ;
                 valor_tot N(12,4), unid C(5), cfop C(4), ncm C(8), ;
                 desconto N(12,2), frete N(12,2))
            SET NULL OFF

            loc_oXml       = CREATEOBJECT("MSXML.DOMDOCUMENT")
            loc_oXml.Async = .F.

            IF !loc_oXml.Load(par_cArquivo)
                MsgAviso(par_cArquivo + " est" + CHR(225) + " corrompido.", "Aviso")
                loc_lResultado = .F.
            ENDIF

            IF loc_lResultado
                *-- Buscar todos os elementos <det> independente da estrutura (nfeProc ou NFe)
                loc_oItens = loc_oXml.selectNodes("//det")
                IF ISNULL(loc_oItens)
                    MsgAviso("Nenhum item encontrado no XML.", "Aviso")
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            IF loc_lResultado
                loc_nTotal = loc_oItens.length

                DO WHILE loc_i < loc_nTotal
                    loc_oDet    = loc_oItens.item(loc_i)

                    loc_cProd   = THIS.XmlGetNodeText(loc_oDet, "cProd")
                    loc_cDescr  = THIS.XmlGetNodeText(loc_oDet, "xProd")
                    loc_nQtd    = VAL(THIS.XmlGetNodeText(loc_oDet, "qCom"))
                    loc_nValUni = VAL(THIS.XmlGetNodeText(loc_oDet, "vUnCom"))
                    loc_nValTot = VAL(THIS.XmlGetNodeText(loc_oDet, "vProd"))
                    loc_cUnid   = THIS.XmlGetNodeText(loc_oDet, "uCom")
                    loc_cCfop   = THIS.XmlGetNodeText(loc_oDet, "CFOP")
                    loc_cNcm    = THIS.XmlGetNodeText(loc_oDet, "NCM")
                    loc_nDesc   = VAL(THIS.XmlGetAnyNodeText(loc_oDet, "vDesc,vdesc"))
                    loc_nFrete  = VAL(THIS.XmlGetAnyNodeText(loc_oDet, "vFrete,vfrete"))

                    SELECT crItens
                    INSERT INTO crItens VALUES ;
                        (PADR(ALLTRIM(NVL(loc_cProd,  "")), 15), ;
                         PADR(ALLTRIM(NVL(loc_cDescr, "")), 50), ;
                         loc_nQtd, loc_nValUni, loc_nValTot, ;
                         PADR(ALLTRIM(NVL(loc_cUnid, "")), 5), ;
                         PADR(ALLTRIM(NVL(loc_cCfop, "")), 4), ;
                         PADR(ALLTRIM(NVL(loc_cNcm,  "")), 8), ;
                         loc_nDesc, loc_nFrete)

                    loc_i = loc_i + 1
                ENDDO
            ENDIF

        CATCH TO loException
            MsgErro(loException.Message, "Erro em CarregarArquivosXml")
        ENDTRY

        loc_oXml   = .NULL.
        loc_oItens = .NULL.
        loc_oDet   = .NULL.
    ENDPROC

    *--------------------------------------------------------------------------
    * XmlGetNodeText - Helper: retorna texto de um no XML pelo tag
    *--------------------------------------------------------------------------
    FUNCTION XmlGetNodeText(par_oParent, par_cTag)
        LOCAL loc_oNode, loc_cResult
        loc_oNode  = .NULL.
        loc_cResult = ""

        TRY
            loc_oNode = par_oParent.selectSingleNode(".//" + par_cTag)
            IF !ISNULL(loc_oNode) AND VARTYPE(loc_oNode) = "O"
                loc_cResult = NVL(loc_oNode.text, "")
            ENDIF
        CATCH TO loException
            *-- Tag ausente ou objeto invalido; retorna "" sem interromper o parsing
            MsgErro(loException.Message, "XmlGetNodeText [" + par_cTag + "]")
        ENDTRY

        loc_oNode = .NULL.
        RETURN loc_cResult
    ENDFUNC

    *--------------------------------------------------------------------------
    * XmlGetAnyNodeText - Helper: tenta multiplos tags (lista separada por virgula)
    *--------------------------------------------------------------------------
    FUNCTION XmlGetAnyNodeText(par_oParent, par_cTags)
        LOCAL loc_cResult, loc_cTag, loc_oNode, loc_i, loc_nCount
        LOCAL ARRAY loc_aTags[1]
        loc_cResult = ""
        loc_oNode   = .NULL.

        TRY
            loc_nCount = ALINES(loc_aTags, par_cTags, 1, ",")
            FOR loc_i = 1 TO loc_nCount
                loc_cTag = ALLTRIM(loc_aTags[loc_i])
                IF !EMPTY(loc_cTag)
                    loc_oNode = par_oParent.selectSingleNode(".//" + loc_cTag)
                    IF !ISNULL(loc_oNode) AND VARTYPE(loc_oNode) = "O"
                        loc_cResult = NVL(loc_oNode.text, "")
                        IF !EMPTY(loc_cResult)
                            EXIT
                        ENDIF
                    ENDIF
                ENDIF
            ENDFOR
        CATCH TO loException
            MsgErro(loException.Message, "Erro em XmlGetAnyNodeText")
        ENDTRY

        loc_oNode = .NULL.
        RETURN loc_cResult
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarItemXML - Original: CarregarItemXML (159 linhas)
    * Para cada item em crItens, busca em SigCdPro por ifors
    * Encontrado -> crMovimentos (grd_4c_Disponivel)
    * Nao encontrado -> crDistribui (grd_4c_ItemXml)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarItemXML()
        LOCAL loc_oPage, loc_cConta, loc_nOpt, loc_nRet, loc_lResultado
        LOCAL loc_cProd, loc_cDescr, loc_nQtd, loc_nValTot
        LOCAL loc_cCpros, loc_cDpros, loc_cReffs, loc_nPesoms, loc_nPvens
        LOCAL loc_cMoevs, loc_nCustofs, loc_cMoecusfs, loc_nFcustos, loc_cCodCors
        loc_oPage      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        loc_lResultado = .F.
        loc_cConta     = ""
        loc_nOpt       = 1

        IF !USED("crItens") OR RECCOUNT("crItens") = 0
            MsgAviso("Nenhum item XML carregado. Selecione e processe um arquivo XML primeiro.", "Aviso")
            RETURN
        ENDIF

        *-- Ler filtros
        IF TYPE("loc_oPage.txt_4c_Conta") = "O"
            loc_cConta = ALLTRIM(NVL(loc_oPage.txt_4c_Conta.Value, ""))
        ENDIF
        IF TYPE("loc_oPage.opt_4c_Fil") = "O"
            loc_nOpt = NVL(loc_oPage.opt_4c_Fil.Value, 1)
        ENDIF

        TRY
            *-- Limpar cursores anteriores
            IF USED("crMovimentos")
                USE IN crMovimentos
            ENDIF
            IF USED("crDistribui")
                USE IN crDistribui
            ENDIF

            SET NULL ON
            CREATE CURSOR crMovimentos ;
                (Cpros C(15), Dpros C(50), reffs C(25), pesoms N(12,3), ;
                 pvens N(12,2), moevs C(3), custofs N(12,2), moecusfs C(3), ;
                 fcustos N(12,2), Emps C(4), Dopes C(10), Numes C(10), ;
                 CodCors C(5), CdChaves C(36), Qtds N(12,3), ;
                 QtdBaixa N(12,3), QtdRes N(12,3), QtdSaldo N(12,3))

            CREATE CURSOR crDistribui ;
                (refForn C(25), Descr C(50), Qtds N(12,3), Valor N(12,2))
            SET NULL OFF

            *-- Iterar crItens e tentar localizar em SigCdPro por ifors (ref fornecedor)
            SELECT crItens
            GO TOP IN crItens
            SCAN
                loc_cProd   = ALLTRIM(NVL(crItens.codigo, ""))
                loc_nQtd    = NVL(crItens.quant, 0)
                loc_nValTot = NVL(crItens.valor_tot, 0)
                loc_cDescr  = ALLTRIM(NVL(crItens.Descr, ""))

                IF EMPTY(loc_cProd)
                    SELECT crItens
                    LOOP
                ENDIF

                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 a.cpros, a.dpros, a.reffs, a.pesoms, a.pvens, a.moevs, " + ;
                    "a.custofs, a.moecusfs, a.fcustos, a.CodCors " + ;
                    "FROM SigCdPro a " + ;
                    "WHERE a.ifors = " + EscaparSQL(loc_cProd) + " AND a.situas <> 'I'", ;
                    "cursor_4c_BusPro")

                IF loc_nRet > 0 AND USED("cursor_4c_BusPro") AND !EOF("cursor_4c_BusPro")
                    *-- Produto encontrado -> crMovimentos (exceto quando Opt=3=Nao Cad.)
                    IF loc_nOpt <> 3
                        loc_cCpros    = PADR(ALLTRIM(NVL(cursor_4c_BusPro.cpros,    "")), 15)
                        loc_cDpros    = PADR(ALLTRIM(NVL(cursor_4c_BusPro.dpros,    "")), 50)
                        loc_cReffs    = PADR(ALLTRIM(NVL(cursor_4c_BusPro.reffs,    "")), 25)
                        loc_nPesoms   = NVL(cursor_4c_BusPro.pesoms,   0)
                        loc_nPvens    = NVL(cursor_4c_BusPro.pvens,    0)
                        loc_cMoevs    = PADR(ALLTRIM(NVL(cursor_4c_BusPro.moevs,    "")), 3)
                        loc_nCustofs  = NVL(cursor_4c_BusPro.custofs,  0)
                        loc_cMoecusfs = PADR(ALLTRIM(NVL(cursor_4c_BusPro.moecusfs, "")), 3)
                        loc_nFcustos  = NVL(cursor_4c_BusPro.fcustos,  0)
                        loc_cCodCors  = PADR(ALLTRIM(NVL(cursor_4c_BusPro.CodCors,  "")), 5)

                        SELECT crMovimentos
                        INSERT INTO crMovimentos VALUES ;
                            (loc_cCpros, loc_cDpros, loc_cReffs, ;
                             loc_nPesoms, loc_nPvens, loc_cMoevs, ;
                             loc_nCustofs, loc_cMoecusfs, loc_nFcustos, ;
                             PADR("", 4), PADR("", 10), PADR("", 10), ;
                             loc_cCodCors, PADR("", 36), ;
                             loc_nQtd, 0, 0, 0)
                    ENDIF
                ELSE
                    *-- Produto NAO encontrado -> crDistribui (exceto quando Opt=2=Cadastrados)
                    IF loc_nOpt <> 2
                        SELECT crDistribui
                        INSERT INTO crDistribui VALUES ;
                            (PADR(ALLTRIM(loc_cProd), 25), ;
                             PADR(ALLTRIM(loc_cDescr), 50), ;
                             loc_nQtd, loc_nValTot)
                    ENDIF
                ENDIF

                IF USED("cursor_4c_BusPro")
                    USE IN cursor_4c_BusPro
                ENDIF

                SELECT crItens
            ENDSCAN

            loc_lResultado = .T.

        CATCH TO loException
            MsgErro(loException.Message, "Erro em CarregarItemXML")
        ENDTRY

        IF loc_lResultado
            THIS.CarregarGradeDisponivel()
            THIS.CarregarGradeItemXml()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGradeDisponivel - Seta RecordSource de grd_4c_Disponivel -> crMovimentos
    * Problema 36/32/48: ColumnCount/RecordSource/ControlSource na ordem certa
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGradeDisponivel()
        LOCAL loc_oPage2, loc_oGrd
        loc_oPage2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
        loc_oGrd   = .NULL.

        IF TYPE("loc_oPage2.grd_4c_Disponivel") != "O"
            RETURN
        ENDIF

        IF !USED("crMovimentos")
            RETURN
        ENDIF

        TRY
            loc_oGrd = loc_oPage2.grd_4c_Disponivel
            loc_oGrd.RecordSource = ""
            loc_oGrd.ColumnCount  = 7
            loc_oGrd.RecordSource = "crMovimentos"

            *-- Problema 32: Headers APOS RecordSource
            loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "digo"
            loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            loc_oGrd.Column3.Header1.Caption = "Valor"
            loc_oGrd.Column4.Header1.Caption = "Quantidade"
            loc_oGrd.Column5.Header1.Caption = "Baixado"
            loc_oGrd.Column6.Header1.Caption = "Reservado"
            loc_oGrd.Column7.Header1.Caption = "Saldo"

            *-- Problema 48: ControlSource APOS RecordSource
            loc_oGrd.Column1.ControlSource = "crMovimentos.Cpros"
            loc_oGrd.Column2.ControlSource = "crMovimentos.Dpros"
            loc_oGrd.Column3.ControlSource = "crMovimentos.pvens"
            loc_oGrd.Column4.ControlSource = "crMovimentos.Qtds"
            loc_oGrd.Column5.ControlSource = "crMovimentos.QtdBaixa"
            loc_oGrd.Column6.ControlSource = "crMovimentos.QtdRes"
            loc_oGrd.Column7.ControlSource = "crMovimentos.QtdSaldo"

            WITH loc_oGrd
                .Column1.Width = 80
                .Column2.Width = 200
                .Column3.Width = 80
                .Column4.Width = 70
                .Column5.Width = 80
                .Column6.Width = 80
                .Column7.Width = 94
            ENDWITH

            loc_oGrd.Refresh()

            *-- Disparar handler para popular campos de detalhe da 1a linha
            IF !EOF("crMovimentos")
                THIS.GrdDisponivelAfterRowColChange(1)
            ENDIF

        CATCH TO loException
            MsgErro(loException.Message, "Erro em CarregarGradeDisponivel")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGradeItemXml - Seta RecordSource de grd_4c_ItemXml -> crDistribui
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGradeItemXml()
        LOCAL loc_oPage2, loc_oGrd
        loc_oPage2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
        loc_oGrd   = .NULL.

        IF TYPE("loc_oPage2.grd_4c_ItemXml") != "O"
            RETURN
        ENDIF

        IF !USED("crDistribui")
            RETURN
        ENDIF

        TRY
            loc_oGrd = loc_oPage2.grd_4c_ItemXml
            loc_oGrd.RecordSource = ""
            loc_oGrd.ColumnCount  = 4
            loc_oGrd.RecordSource = "crDistribui"

            loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "digo"
            loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            loc_oGrd.Column3.Header1.Caption = "Quantidade"
            loc_oGrd.Column4.Header1.Caption = "Valor"

            loc_oGrd.Column1.ControlSource = "crDistribui.refForn"
            loc_oGrd.Column2.ControlSource = "crDistribui.Descr"
            loc_oGrd.Column3.ControlSource = "crDistribui.Qtds"
            loc_oGrd.Column4.ControlSource = "crDistribui.Valor"

            WITH loc_oGrd
                .Column1.Width = 100
                .Column2.Width = 220
                .Column3.Width = 80
                .Column4.Width = 93
            ENDWITH

            loc_oGrd.Refresh()

        CATCH TO loException
            MsgErro(loException.Message, "Erro em CarregarGradeItemXml")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS DE pgf_4c_Abas.Page2 (Itens) (PUBLIC para BINDEVENT)
    *==========================================================================

    *--------------------------------------------------------------------------
    * GrdDisponivelAfterRowColChange - Popula campos de detalhe do produto corrente
    * Original: grdDisponivel.Procedure (111 linhas) -> atualiza campos display
    *--------------------------------------------------------------------------
    PROCEDURE GrdDisponivelAfterRowColChange(par_nColIndex)
        LOCAL loc_oPage2
        loc_oPage2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2

        IF !USED("crMovimentos") OR EOF("crMovimentos")
            RETURN
        ENDIF

        SELECT crMovimentos

        *-- Atualizar campos de detalhe na Page2 a partir de crMovimentos
        IF TYPE("loc_oPage2.txt_4c_RefFornecedor") = "O"
            loc_oPage2.txt_4c_RefFornecedor.Value = ALLTRIM(NVL(crMovimentos.reffs,    ""))
        ENDIF
        IF TYPE("loc_oPage2.txt_4c_PrVenda") = "O"
            loc_oPage2.txt_4c_PrVenda.Value       = NVL(crMovimentos.pvens, 0)
        ENDIF
        IF TYPE("loc_oPage2.txt_4c_PrVendaMoeda") = "O"
            loc_oPage2.txt_4c_PrVendaMoeda.Value  = ALLTRIM(NVL(crMovimentos.moevs,    ""))
        ENDIF
        IF TYPE("loc_oPage2.txt_4c_PesoMedio") = "O"
            loc_oPage2.txt_4c_PesoMedio.Value     = NVL(crMovimentos.pesoms, 0)
        ENDIF
        IF TYPE("loc_oPage2.txt_4c_Custofs") = "O"
            loc_oPage2.txt_4c_Custofs.Value       = NVL(crMovimentos.custofs, 0)
        ENDIF
        IF TYPE("loc_oPage2.txt_4c_Moecusfs") = "O"
            loc_oPage2.txt_4c_Moecusfs.Value      = ALLTRIM(NVL(crMovimentos.moecusfs, ""))
        ENDIF
        IF TYPE("loc_oPage2.txt_4c_PrecoMov") = "O"
            loc_oPage2.txt_4c_PrecoMov.Value      = NVL(crMovimentos.fcustos, 0)
        ENDIF
        IF TYPE("loc_oPage2.txt_4c_Emps") = "O"
            loc_oPage2.txt_4c_Emps.Value          = ALLTRIM(NVL(crMovimentos.Emps,  ""))
        ENDIF
        IF TYPE("loc_oPage2.txt_4c_Dopes") = "O"
            loc_oPage2.txt_4c_Dopes.Value         = ALLTRIM(NVL(crMovimentos.Dopes, ""))
        ENDIF
        IF TYPE("loc_oPage2.txt_4c_Numes") = "O"
            loc_oPage2.txt_4c_Numes.Value         = ALLTRIM(NVL(crMovimentos.Numes, ""))
        ENDIF
        IF TYPE("loc_oPage2.txt_4c_CIdChaves") = "O"
            loc_oPage2.txt_4c_CIdChaves.Value     = ALLTRIM(NVL(crMovimentos.CdChaves, ""))
        ENDIF

        *-- Imagem: apenas limpar (carregada via ImgFigJpgClick)
        IF TYPE("loc_oPage2.img_4c_FigJpg") = "O"
            loc_oPage2.img_4c_FigJpg.Picture = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirSisClick - Original: btnExcluirSis.Click -> DELETE em crMovimentos
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirSisClick()
        LOCAL loc_oPage2, loc_oGrd
        loc_oPage2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2

        IF !INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
            RETURN
        ENDIF

        IF !USED("crMovimentos") OR EOF("crMovimentos")
            RETURN
        ENDIF

        TRY
            SELECT crMovimentos
            IF !EOF()
                DELETE
            ENDIF

            *-- Posicionar no proximo registro disponivel
            SET DELETED ON
            IF !EOF()
                SKIP
                SKIP -1
            ELSE
                GO TOP
            ENDIF

            *-- Atualizar grade e campos de detalhe
            IF TYPE("loc_oPage2.grd_4c_Disponivel") = "O"
                loc_oPage2.grd_4c_Disponivel.Refresh()
            ENDIF

            IF !EOF("crMovimentos")
                THIS.GrdDisponivelAfterRowColChange(1)
            ENDIF

        CATCH TO loException
            MsgErro(loException.Message, "Erro em BtnExcluirSisClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirArqClick - Original: btnExcluirArq.Click -> DELETE em crDistribui
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirArqClick()
        LOCAL loc_oPage2
        loc_oPage2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2

        IF !INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
            RETURN
        ENDIF

        IF !USED("crDistribui") OR EOF("crDistribui")
            RETURN
        ENDIF

        TRY
            SELECT crDistribui
            IF !EOF()
                DELETE
            ENDIF

            SET DELETED ON
            IF !EOF()
                SKIP
                SKIP -1
            ELSE
                GO TOP
            ENDIF

            IF TYPE("loc_oPage2.grd_4c_ItemXml") = "O"
                loc_oPage2.grd_4c_ItemXml.Refresh()
            ENDIF

        CATCH TO loException
            MsgErro(loException.Message, "Erro em BtnExcluirArqClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ProdutoInicialLostFocus - Original: get_produto_inicial.Valid
    * Navega grd_4c_Disponivel para o produto digitado
    *--------------------------------------------------------------------------
    PROCEDURE ProdutoInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPage2, loc_cProd, loc_nRec
        loc_oPage2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
        loc_cProd  = ""
        loc_nRec   = 0

        IF TYPE("loc_oPage2.txt_4c_ProdutoInicial") != "O"
            RETURN
        ENDIF

        loc_cProd = ALLTRIM(NVL(loc_oPage2.txt_4c_ProdutoInicial.Value, ""))

        IF EMPTY(loc_cProd) OR !USED("crMovimentos")
            RETURN
        ENDIF

        TRY
            SELECT crMovimentos
            loc_nRec = RECNO()
            GO TOP

            LOCATE FOR Cpros = PADR(loc_cProd, 15)

            IF EOF()
                GO loc_nRec
            ENDIF

            IF TYPE("loc_oPage2.grd_4c_Disponivel") = "O"
                loc_oPage2.grd_4c_Disponivel.Refresh()
            ENDIF

            THIS.GrdDisponivelAfterRowColChange(1)

        CATCH TO loException
            MsgErro(loException.Message, "Erro em ProdutoInicialLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ImgFigJpgClick - Original: FigJpg.Click -> carrega imagem do produto
    * Busca SigCdPro.FigJpgs, salva em temp e exibe na img_4c_FigJpg
    *--------------------------------------------------------------------------
    PROCEDURE ImgFigJpgClick()
        LOCAL loc_oPage2, loc_cCpros, loc_cArqTemp, loc_nRet
        loc_oPage2  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
        loc_cCpros  = ""
        loc_cArqTemp = ""
        loc_nRet    = 0

        IF !USED("crMovimentos") OR EOF("crMovimentos")
            RETURN
        ENDIF

        SELECT crMovimentos
        loc_cCpros = ALLTRIM(NVL(crMovimentos.Cpros, ""))

        IF EMPTY(loc_cCpros)
            RETURN
        ENDIF

        TRY
            loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"

            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCpros), ;
                "cursor_4c_TmpFig")

            IF loc_nRet > 0 AND USED("cursor_4c_TmpFig") AND !EOF("cursor_4c_TmpFig")
                IF !ISNULL(cursor_4c_TmpFig.FigJpgs) AND !EMPTY(cursor_4c_TmpFig.FigJpgs)
                    STRTOFILE(cursor_4c_TmpFig.FigJpgs, loc_cArqTemp)
                    IF FILE(loc_cArqTemp) AND TYPE("loc_oPage2.img_4c_FigJpg") = "O"
                        loc_oPage2.img_4c_FigJpg.Picture = loc_cArqTemp
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_TmpFig")
                USE IN cursor_4c_TmpFig
            ENDIF

        CATCH TO loException
            MsgErro(loException.Message, "Erro em ImgFigJpgClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarSessaoXml - Grava todos os produtos de crMovimentos como linhas SigPrCtr
    * Original: cgp_Salva.salva.Click (106 linhas) - padrao multi-row INSERT
    * Para cada linha de crMovimentos (nao deletadas): chama BO.Inserir()
    *--------------------------------------------------------------------------
    PROCEDURE GravarSessaoXml()
        LOCAL loc_oPage, loc_cCodigos, loc_cConta, loc_cArquivo, loc_cMoeda
        LOCAL loc_nOpt, loc_lResultado, loc_nContador
        LOCAL loc_cCpros, loc_cCodCors, loc_nQtds, loc_cEmps, loc_cDopes
        LOCAL loc_cNumes, loc_cCdChaves, loc_cDescr
        loc_oPage      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        loc_lResultado = .F.
        loc_nContador  = 0
        loc_cCodigos   = ""
        loc_cConta     = ""
        loc_cArquivo   = ""
        loc_cMoeda     = ""
        loc_nOpt       = 1

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Business Object n" + CHR(227) + "o inicializado.", "Erro")
            RETURN
        ENDIF

        IF !USED("crMovimentos")
            MsgAviso("Nenhum produto para salvar. Processe um arquivo XML primeiro.", "Aviso")
            RETURN
        ENDIF

        *-- Verificar se ha registros em crMovimentos (RECCOUNT ignora SET DELETED)
        IF RECCOUNT("crMovimentos") = 0
            MsgAviso("Nenhum produto para salvar. Processe um arquivo XML primeiro.", "Aviso")
            RETURN
        ENDIF
        SET DELETED ON

        *-- Ler campos da Page1
        IF TYPE("loc_oPage.txt_4c_Conta") = "O"
            loc_cConta = ALLTRIM(NVL(loc_oPage.txt_4c_Conta.Value, ""))
        ENDIF
        IF TYPE("loc_oPage.txt_4c_Arquivo") = "O"
            loc_cArquivo = ALLTRIM(NVL(loc_oPage.txt_4c_Arquivo.Value, ""))
        ENDIF
        IF TYPE("loc_oPage.txt_4c_Moeda") = "O"
            loc_cMoeda = ALLTRIM(NVL(loc_oPage.txt_4c_Moeda.Value, ""))
        ENDIF
        IF TYPE("loc_oPage.opt_4c_Custo") = "O"
            loc_nOpt = NVL(loc_oPage.opt_4c_Custo.Value, 1)
        ENDIF

        IF EMPTY(loc_cConta)
            MsgAviso("Conta obrigat" + CHR(243) + "ria.", "Aviso")
            RETURN
        ENDIF

        TRY
            *-- Obter Codigos da sessao (gerar novo ou usar existente)
            loc_cCodigos = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCodigos, ""))

            IF EMPTY(loc_cCodigos)
                THIS.this_oBusinessObject.GerarNovoCodigos()
                loc_cCodigos = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCodigos, ""))
            ELSE
                *-- Alterar: excluir linhas anteriores antes de reinserir
                THIS.this_oBusinessObject.ExcluirLinhasSessao(loc_cCodigos)
            ENDIF

            IF EMPTY(loc_cCodigos)
                MsgErro("Falha ao gerar c" + CHR(243) + "digo da sess" + CHR(227) + "o.", "Erro")
                loc_lResultado = .F.
            ELSE
                *-- Inserir cada linha de crMovimentos (nao deletados)
                SELECT crMovimentos
                GO TOP IN crMovimentos
                SCAN
                    loc_cCpros    = ALLTRIM(NVL(crMovimentos.Cpros,    ""))
                    loc_cCodCors  = ALLTRIM(NVL(crMovimentos.CodCors,  ""))
                    loc_nQtds     = NVL(crMovimentos.Qtds, 0)
                    loc_cEmps     = ALLTRIM(NVL(crMovimentos.Emps,     ""))
                    loc_cDopes    = ALLTRIM(NVL(crMovimentos.Dopes,    ""))
                    loc_cNumes    = ALLTRIM(NVL(crMovimentos.Numes,    ""))
                    loc_cCdChaves = ALLTRIM(NVL(crMovimentos.CdChaves, ""))

                    IF EMPTY(loc_cCpros)
                        SELECT crMovimentos
                        LOOP
                    ENDIF

                    THIS.this_oBusinessObject.this_cCodigos    = loc_cCodigos
                    THIS.this_oBusinessObject.this_cCpros      = loc_cCpros
                    THIS.this_oBusinessObject.this_cCodCors    = loc_cCodCors
                    THIS.this_oBusinessObject.this_cCodTams    = ""
                    THIS.this_oBusinessObject.this_cOriDopNums = PADR(loc_cEmps,5) + PADR(loc_cDopes,10) + PADR(loc_cNumes,10)
                    THIS.this_oBusinessObject.this_cFkChaves   = loc_cCdChaves
                    THIS.this_oBusinessObject.this_nQtds       = loc_nQtds
                    THIS.this_oBusinessObject.this_nQtdOs      = 0
                    THIS.this_oBusinessObject.this_cContas     = loc_cConta
                    THIS.this_oBusinessObject.this_cArquivo    = loc_cArquivo
                    THIS.this_oBusinessObject.this_cMoedas     = loc_cMoeda
                    THIS.this_oBusinessObject.this_nPrecific   = loc_nOpt
                    THIS.this_oBusinessObject.this_dDatas      = DATE()
                    THIS.this_oBusinessObject.this_cUsuars     = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))

                    IF !THIS.this_oBusinessObject.Inserir()
                        MsgErro("Falha ao inserir produto " + loc_cCpros + ".", "Erro")
                        loc_lResultado = .F.
                        SELECT crMovimentos
                        EXIT
                    ELSE
                        loc_nContador = loc_nContador + 1
                        loc_lResultado = .T.
                    ENDIF

                    SELECT crMovimentos
                ENDSCAN
            ENDIF

        CATCH TO loException
            MsgErro(loException.Message, "Erro em GravarSessaoXml")
        ENDTRY

        IF loc_lResultado AND loc_nContador > 0
            MsgInfo(LTRIM(STR(loc_nContador)) + " produto(s) salvo(s) com sucesso!", "Sucesso")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConsultaAbaClick - Original: Bot_Consulta.Click -> DO Form SigOpCgv
    *--------------------------------------------------------------------------
    PROCEDURE BtnConsultaAbaClick()
        MsgAviso("Formul" + CHR(225) + "rio SigOpCgv ainda n" + CHR(227) + "o migrado.", ;
            "Indispon" + CHR(237) + "vel")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCadastrosAbaClick - Original: btnCadastros.Click -> DO Form SIGCDCTA
    *--------------------------------------------------------------------------
    PROCEDURE BtnCadastrosAbaClick()
        MsgAviso("Formul" + CHR(225) + "rio SIGCDCTA ainda n" + CHR(227) + "o migrado.", ;
            "Indispon" + CHR(237) + "vel")
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Zera campos de pgf_4c_Abas.Page1 e Page2 para nova inclusao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPage, loc_oPage2
        loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        loc_oPage2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2

        *-- Page1 (Dados)
        IF TYPE("loc_oPage.txt_4c_Grupo") = "O"
            loc_oPage.txt_4c_Grupo.Value = ""
        ENDIF
        IF TYPE("loc_oPage.txt_4c_Conta") = "O"
            loc_oPage.txt_4c_Conta.Value = ""
        ENDIF
        IF TYPE("loc_oPage.txt_4c_Dconta") = "O"
            loc_oPage.txt_4c_Dconta.Value = ""
        ENDIF
        IF TYPE("loc_oPage.txt_4c_Cpf") = "O"
            loc_oPage.txt_4c_Cpf.Value = ""
        ENDIF
        IF TYPE("loc_oPage.txt_4c_Moeda") = "O"
            loc_oPage.txt_4c_Moeda.Value = ""
        ENDIF
        IF TYPE("loc_oPage.opt_4c_Custo") = "O"
            loc_oPage.opt_4c_Custo.Value = 1
        ENDIF
        IF TYPE("loc_oPage.txt_4c_Arquivo") = "O"
            loc_oPage.txt_4c_Arquivo.Value = ""
        ENDIF
        IF TYPE("loc_oPage.opt_4c_Fil") = "O"
            loc_oPage.opt_4c_Fil.Value = 1
        ENDIF
        IF TYPE("loc_oPage.grd_4c_Estoque") = "O"
            loc_oPage.grd_4c_Estoque.RecordSource = ""
        ENDIF

        *-- Page2 (Itens)
        IF TYPE("loc_oPage2.txt_4c_Sistema") = "O"
            loc_oPage2.txt_4c_Sistema.Value = ""
        ENDIF
        IF TYPE("loc_oPage2.txt_4c_Arquivo") = "O"
            loc_oPage2.txt_4c_Arquivo.Value = ""
        ENDIF
        IF TYPE("loc_oPage2.grd_4c_Disponivel") = "O"
            loc_oPage2.grd_4c_Disponivel.RecordSource = ""
        ENDIF
        IF TYPE("loc_oPage2.grd_4c_ItemXml") = "O"
            loc_oPage2.grd_4c_ItemXml.RecordSource = ""
        ENDIF
        IF TYPE("loc_oPage2.img_4c_FigJpg") = "O"
            loc_oPage2.img_4c_FigJpg.Picture = ""
        ENDIF

        *-- Limpar cursores de processamento XML
        IF USED("crMovimentos")
            USE IN crMovimentos
        ENDIF
        IF USED("crDistribui")
            USE IN crDistribui
        ENDIF
        IF USED("crItens")
            USE IN crItens
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega cursor_4c_Dados e configura grd_4c_Lista
    * Chama Buscar() no BO, seta RecordSource e redefine cabecalhos
    * REGRA: ControlSource APOS RecordSource (evita auto-bind - Problema 48)
    * REGRA: Header1.Caption APOS RecordSource (evita reset - Problema 32)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.
        loc_oGrid      = .NULL.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    THIS.this_oBusinessObject.this_dFiltroInicio = THIS.this_dDtInicio
                    THIS.this_oBusinessObject.this_dFiltroFim    = THIS.this_dDtFim

                    IF THIS.this_oBusinessObject.Buscar("")
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                        *-- RecordSource FORA de WITH (Problema 36: criacao imediata das colunas)
                        loc_oGrid.ColumnCount = 6
                        loc_oGrid.RecordSource = "cursor_4c_Dados"

                        *-- ControlSource APOS RecordSource (Problema 48: auto-bind)
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Datas"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.OriDopNums"
                        loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Usuars"
                        loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Contas"
                        loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.Rclis"

                        loc_oGrid.Column1.Width = 80
                        loc_oGrid.Column2.Width = 120
                        loc_oGrid.Column3.Width = 100
                        loc_oGrid.Column4.Width = 100
                        loc_oGrid.Column5.Width = 100
                        loc_oGrid.Column6.Width = 680

                        *-- Cabecalhos APOS RecordSource (Problema 2/32: reset automatico)
                        loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                        loc_oGrid.Column2.Header1.Caption = "Data"
                        loc_oGrid.Column3.Header1.Caption = "Mov. Origem"
                        loc_oGrid.Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
                        loc_oGrid.Column5.Header1.Caption = "Conta"
                        loc_oGrid.Column6.Header1.Caption = "Nome"

                        THIS.FormatarGridLista(loc_oGrid)
                        loc_lResultado = .T.
                    ELSE
                        loc_lResultado = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em FormSigPrCtr.CarregarLista:" + CHR(13) + ;
                loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid de lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
            .SetAll("ForeColor", RGB(90, 90, 90), "Column")
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
            loc_lResultado = .T.
        CATCH TO loException
            MostrarErro("Erro em FormSigPrCtr.AlternarPagina:" + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Deve iterar Pages E Controls para PageFrames (FORMCOR_LICOES Problema 6)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * HANDLERS DOS BOTOES CRUD (PUBLIC - necessario para BINDEVENT)
    * REGRA: metodos Btn*Click NAO devem ser PROTECTED (Problema 17)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara formulario para inclusao de nova sessao
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        *-- Preparar BO para INSERT; setar modo ANTES de HabilitarCampos (Problema 19)
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Abre sessao selecionada em modo somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF NOT USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.Codigos, ""))

        IF EMPTY(loc_cCodigo)
            MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.ActivePage = 1
        ELSE
            MsgErro("Erro ao carregar registro.", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Abre sessao selecionada para edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF NOT USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.Codigos, ""))

        IF EMPTY(loc_cCodigo)
            MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            *-- EditarRegistro prepara BO para UPDATE (Problema 18)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.ActivePage = 1
        ELSE
            MsgErro("Erro ao carregar registro para edi" + CHR(231) + CHR(227) + "o.", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui sessao selecionada apos confirmacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lConfirmado
        loc_cCodigo     = ""
        loc_lConfirmado = .F.

        IF NOT USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.Codigos, ""))

        IF EMPTY(loc_cCodigo)
            MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        *-- MsgConfirma retorna LOGICAL (.T./.F.) - nunca comparar com = 6 (Problema 50)
        loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro" + ;
            CHR(13) + "C" + CHR(243) + "digo: " + loc_cCodigo + " ?", ;
            "Confirmar Exclus" + CHR(227) + "o")

        IF loc_lConfirmado
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                *-- Form chama Excluir() PUBLIC; BO sobrescreve ExecutarExclusao() (Problema 57)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                    THIS.CarregarLista()
                ELSE
                    MsgErro("Erro ao excluir registro!", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao carregar registro para exclus" + CHR(227) + "o!", "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Aplica filtros de periodo e recarrega a lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oPg1, loc_dIni, loc_dFim
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_dIni = DATE()
        loc_dFim = DATE()

        IF TYPE("loc_oPg1.txt_4c_DtInicio") = "O"
            loc_dIni = loc_oPg1.txt_4c_DtInicio.Value
        ENDIF

        IF TYPE("loc_oPg1.txt_4c_DtFim") = "O"
            loc_dFim = loc_oPg1.txt_4c_DtFim.Value
        ENDIF

        *-- Validar periodo antes de buscar
        IF VARTYPE(loc_dIni) = "D" AND VARTYPE(loc_dFim) = "D"
            IF loc_dIni > loc_dFim
                MsgAviso("Data inicial n" + CHR(227) + "o pode ser maior que a data final!", ;
                    "Per" + CHR(237) + "odo inv" + CHR(225) + "lido")
                RETURN
            ENDIF
        ENDIF

        THIS.this_dDtInicio = loc_dIni
        THIS.this_dDtFim    = loc_dFim
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salva sessao XML: padrao multi-row (DELETE + loop INSERT)
    * SigPrCtr armazena multiplas linhas por sessao (uma por produto)
    * Delega para GravarSessaoXml que faz ExcluirLinhasSessao + BO.Inserir por linha
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        THIS.GravarSessaoXml()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e retorna para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * DtInicioLostFocus - Sincroniza data inicio; ajusta DtFim se necessario
    * Original: Dt_inicial.Valid -> ajusta Dt_final se necessario
    *--------------------------------------------------------------------------
    PROCEDURE DtInicioLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg1, loc_dIni, loc_dFim
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_dIni = DATE()
        loc_dFim = DATE()

        IF TYPE("loc_oPg1.txt_4c_DtInicio") != "O" OR TYPE("loc_oPg1.txt_4c_DtFim") != "O"
            RETURN
        ENDIF

        loc_dIni = loc_oPg1.txt_4c_DtInicio.Value
        loc_dFim = loc_oPg1.txt_4c_DtFim.Value

        *-- Se data inicial > data final, ajusta data final (replica legado: Dt_inicial.Valid)
        IF VARTYPE(loc_dIni) = "D" AND VARTYPE(loc_dFim) = "D"
            IF loc_dIni > loc_dFim
                loc_oPg1.txt_4c_DtFim.Value = loc_dIni
                THIS.this_dDtFim = loc_dIni
            ENDIF
        ENDIF

        THIS.this_dDtInicio = loc_dIni
    ENDPROC

    *--------------------------------------------------------------------------
    * DtFimLostFocus - Sincroniza data fim e recarrega lista
    * Original: Dt_final.LostFocus -> Requery TmpSigPrCtr + Grade.SetFocus
    *--------------------------------------------------------------------------
    PROCEDURE DtFimLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg1, loc_dIni, loc_dFim
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_dIni = DATE()
        loc_dFim = DATE()

        IF TYPE("loc_oPg1.txt_4c_DtInicio") != "O" OR TYPE("loc_oPg1.txt_4c_DtFim") != "O"
            RETURN
        ENDIF

        loc_dIni = loc_oPg1.txt_4c_DtInicio.Value
        loc_dFim = loc_oPg1.txt_4c_DtFim.Value

        *-- Se data final < data inicial, ajusta data inicial (replica legado: Dt_final.Valid)
        IF VARTYPE(loc_dIni) = "D" AND VARTYPE(loc_dFim) = "D"
            IF loc_dFim < loc_dIni
                loc_oPg1.txt_4c_DtInicio.Value = loc_dFim
                THIS.this_dDtInicio = loc_dFim
            ENDIF
        ENDIF

        THIS.this_dDtFim = loc_dFim

        *-- Recarregar lista (replica legado: Requery + Grade.SetFocus)
        THIS.CarregarLista()

        IF TYPE("loc_oPg1.grd_4c_Lista") = "O"
            loc_oPg1.grd_4c_Lista.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GridListaAfterRowColChange - Habilita/desabilita botoes conforme selecao
    * par_nColIndex obrigatorio para AfterRowColChange (Problema 38)
    *--------------------------------------------------------------------------
    PROCEDURE GridListaAfterRowColChange(par_nColIndex)
        LOCAL loc_oPg1, loc_lTemRegistro
        loc_oPg1         = THIS.pgf_4c_Paginas.Page1
        loc_lTemRegistro = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")

        IF TYPE("loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar") = "O"
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos de Page2 por modo
    * par_lHabilitar: .T. = editar; .F. = somente leitura
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_oPage
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_oPage = loc_oPg2.pgf_4c_Abas.Page1

        IF TYPE("loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar") = "O"
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
        ENDIF

        *-- Campos de pgf_4c_Abas.Page1 (Fases 5-6)
        *-- Nota: cmd_4c_Consulta/Cadastros/Processar (icon-only) NAO desabilitar (icone some)
        IF TYPE("loc_oPage.txt_4c_Grupo") = "O"
            loc_oPage.txt_4c_Grupo.Enabled        = par_lHabilitar
            loc_oPage.txt_4c_Conta.Enabled        = par_lHabilitar
            loc_oPage.txt_4c_Cpf.Enabled          = par_lHabilitar
            loc_oPage.txt_4c_Moeda.Enabled        = par_lHabilitar
            loc_oPage.opt_4c_Custo.Enabled        = par_lHabilitar
        ENDIF
        IF TYPE("loc_oPage.opt_4c_Fil") = "O"
            loc_oPage.opt_4c_Fil.Enabled          = par_lHabilitar
            loc_oPage.cmd_4c_BrowseArquivo.Enabled = par_lHabilitar
        ENDIF

        *-- Habilitar botoes de excluir em Page2 (Itens)
        LOCAL loc_oPage2
        loc_oPage2 = loc_oPg2.pgf_4c_Abas.Page2
        IF TYPE("loc_oPage2.cmd_4c_BtnExcluirSis") = "O"
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados dos campos de Page2 para o Business Object
    * Retorna .T. se BO disponivel para receber dados (campos adicionados Fases 5-6)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPage, loc_lResultado
        loc_oPage     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        loc_lResultado = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        TRY
            IF TYPE("loc_oPage.txt_4c_Conta") = "O"
                THIS.this_oBusinessObject.this_cContas = ;
                    ALLTRIM(NVL(loc_oPage.txt_4c_Conta.Value, ""))
            ENDIF

            IF TYPE("loc_oPage.txt_4c_Moeda") = "O"
                THIS.this_oBusinessObject.this_cMoedas = ;
                    ALLTRIM(NVL(loc_oPage.txt_4c_Moeda.Value, ""))
            ENDIF

            IF TYPE("loc_oPage.opt_4c_Custo") = "O"
                THIS.this_oBusinessObject.this_nPrecific = loc_oPage.opt_4c_Custo.Value
            ENDIF

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro(loException.Message, "Erro em FormParaBO")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Carrega dados do BO nos campos de Page2
    * Sincroniza tambem os filtros de periodo da Page1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg1, loc_oPage, loc_cConta, loc_nRet
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
        loc_cConta = ""
        loc_nRet   = 0

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        *-- Sincronizar datas do BO com os campos de filtro da lista
        IF VARTYPE(THIS.this_oBusinessObject.this_dFiltroInicio) = "D"
            THIS.this_dDtInicio = THIS.this_oBusinessObject.this_dFiltroInicio
            IF TYPE("loc_oPg1.txt_4c_DtInicio") = "O"
                loc_oPg1.txt_4c_DtInicio.Value = THIS.this_dDtInicio
            ENDIF
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject.this_dFiltroFim) = "D"
            THIS.this_dDtFim = THIS.this_oBusinessObject.this_dFiltroFim
            IF TYPE("loc_oPg1.txt_4c_DtFim") = "O"
                loc_oPg1.txt_4c_DtFim.Value = THIS.this_dDtFim
            ENDIF
        ENDIF

        *-- Fase 5: preencher campos de pgf_4c_Abas.Page1 a partir do BO
        IF TYPE("loc_oPage.txt_4c_Conta") = "O"
            loc_cConta = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cContas, ""))
            loc_oPage.txt_4c_Conta.Value = loc_cConta
        ENDIF

        IF TYPE("loc_oPage.txt_4c_Moeda") = "O"
            loc_oPage.txt_4c_Moeda.Value = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cMoedas, ""))
        ENDIF

        IF TYPE("loc_oPage.opt_4c_Custo") = "O"
            loc_oPage.opt_4c_Custo.Value = IIF(THIS.this_oBusinessObject.this_nPrecific > 0, ;
                THIS.this_oBusinessObject.this_nPrecific, 1)
        ENDIF

        *-- Buscar Dconta (Rclis) e Cpf (Cpfs) de SigCdCli para campos display-only
        IF !EMPTY(loc_cConta)
            TRY
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Rclis, Cpfs FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta), ;
                    "cursor_4c_BoParaForm")

                IF loc_nRet > 0 AND USED("cursor_4c_BoParaForm") AND !EOF("cursor_4c_BoParaForm")
                    IF TYPE("loc_oPage.txt_4c_Dconta") = "O"
                        loc_oPage.txt_4c_Dconta.Value = ALLTRIM(NVL(cursor_4c_BoParaForm.Rclis, ""))
                    ENDIF
                    IF TYPE("loc_oPage.txt_4c_Cpf") = "O"
                        loc_oPage.txt_4c_Cpf.Value = ALLTRIM(NVL(cursor_4c_BoParaForm.Cpfs, ""))
                    ENDIF
                ENDIF

                IF USED("cursor_4c_BoParaForm")
                    USE IN cursor_4c_BoParaForm
                ENDIF
            CATCH TO loException
                MsgErro(loException.Message, "Erro em BOParaForm")
            ENDTRY
        ENDIF

        *-- Fase 6: carregar grdEstoque ao entrar em modo edicao
        THIS.CarregarGradeEstoque()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo atual
    * Modos: LISTA, INCLUIR, ALTERAR, VISUALIZAR
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lTemRegistro, loc_lEditar
        loc_oPg1         = THIS.pgf_4c_Paginas.Page1
        loc_oPg2         = THIS.pgf_4c_Paginas.Page2
        loc_lTemRegistro = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
        loc_lEditar      = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        *-- Botoes CRUD na Page1
        IF TYPE("loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir") = "O"
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .T.
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .T.
        ENDIF

        *-- Botoes de acao na Page2 (Confirmar so habilitado ao editar)
        IF TYPE("loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar") = "O"
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditar
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos ao fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_Linhas")
                USE IN cursor_4c_Linhas
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
            IF USED("cursor_4c_NovoCod")
                USE IN cursor_4c_NovoCod
            ENDIF
            IF USED("cursor_4c_BoParaForm")
                USE IN cursor_4c_BoParaForm
            ENDIF

            *-- Cursores de processamento XML (legado: crDistribui, crMovimentos)
            IF USED("crDistribui")
                USE IN crDistribui
            ENDIF
            IF USED("crMovimentos")
                USE IN crMovimentos
            ENDIF
            IF USED("crItens")
                USE IN crItens
            ENDIF
            IF USED("csPrNAOCad")
                USE IN csPrNAOCad
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em FormSigPrCtr.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrCtrBO.prg):
*==============================================================================
* SigPrCtrBO.prg - Business Object: Controle de Movimentacoes por XML
* Tabela: SigPrCtr
* Chave: Codigos (identificador de sessao de processamento)
*
* Cada sessao (Codigos) agrupa multiplas linhas em SigPrCtr,
* uma por produto processado no XML. O padrao de gravacao e:
*   DELETE todas as linhas do Codigos + INSERT novas linhas.
*==============================================================================

DEFINE CLASS SigPrCtrBO AS BusinessBase

    *-- Identificacao da sessao de processamento (grupo de linhas)
    this_cCodigos   = ""    && C(10) - Chave da sessao (PK do grupo)

    *-- Chave individual de cada linha
    this_cPkChave   = ""    && C(15) - Chave unica por linha (fUniqueIds)

    *-- Produto
    this_cCpros     = ""    && C(15) - Codigo do produto
    this_cCodCors   = ""    && C(6)  - Codigo da cor
    this_cCodTams   = ""    && C(6)  - Codigo do tamanho

    *-- Movimento de origem
    this_cOriDopNums = ""   && C(30) - Numero(s) de DOP de origem
    this_cFkChaves   = ""   && C(15) - FK para SigMvItn.cidchaves

    *-- Quantidades
    this_nQtds   = 0        && N(12,2) - Quantidade total do XML
    this_nQtdOs  = 0        && N(12,2) - Quantidade disponivel/OS

    *-- Identificacao do fornecedor/conta
    this_cContas = ""       && C(10) - Codigo da conta (fornecedor)

    *-- Arquivo XML processado
    this_cArquivo = ""      && C(255) - Caminho do arquivo XML

    *-- Moeda e precificacao
    this_cMoedas  = ""      && C(10) - Codigo da moeda
    this_nPrecific = 0      && N(2,0) - Opcao de precificacao (1=Custo Total, 2=Composicao)

    *-- Auditoria de insercao
    this_dDatas  = {/ /}    && T - Data/hora de processamento (INSERT)
    this_cUsuars = ""       && C(6)  - Usuario que processou (INSERT)

    *-- Auditoria de alteracao
    this_dDtAlts  = {/ /}   && T - Data/hora da alteracao
    this_cUsuAlts = ""       && C(6)  - Usuario que alterou

    *-- Filtros de periodo para Buscar()
    this_dFiltroInicio = {}  && Data inicial do filtro
    this_dFiltroFim    = {}  && Data final do filtro

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrCtr"
        THIS.this_cCampoChave = "Codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista sessoes agrupadas por periodo
    * par_cFiltro: filtro adicional de data (formato "ldDatai" e "ldDataf")
    * Retorna cursor_4c_Dados: Codigos, Datas, OriDopNums, Usuars, Contas, Rclis
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        LOCAL ldDatai, ldDataf
        loc_lSucesso = .F.

        TRY
            ldDatai = FormatarDataSQL(IIF(!EMPTY(THIS.this_dFiltroInicio), THIS.this_dFiltroInicio, DATE()))
            ldDataf = FormatarDataSQL(IIF(!EMPTY(THIS.this_dFiltroFim), THIS.this_dFiltroFim, DATE()))

            loc_cSQL = "SELECT DISTINCT a.Codigos, MAX(a.Datas) AS Datas," + ;
                       " a.OriDopNums, a.Usuars, a.Contas, b.Rclis" + ;
                       " FROM SigPrCtr a" + ;
                       " JOIN SigCdCli b ON a.Contas = b.Iclis" + ;
                       " WHERE a.Datas >= " + ldDatai + ;
                       " AND a.Datas < DATEADD(day, 1, " + ldDataf + ")"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " AND " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + ;
                       " GROUP BY a.Codigos, a.OriDopNums, a.Usuars, a.Contas, b.Rclis" + ;
                       " ORDER BY MAX(a.Datas) DESC"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar sessoes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarLinhasSessao - Carrega todas as linhas de uma sessao (para grid Page1)
    * Retorna cursor_4c_Linhas: todas as colunas de SigPrCtr para o Codigos
    *--------------------------------------------------------------------------
    PROCEDURE BuscarLinhasSessao(par_cCodigos)
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Codigos, a.PkChave, a.Cpros, a.CodCors, a.CodTams," + ;
                       " a.OriDopNums, a.Qtds, a.QtdOs, a.Contas, a.Arquivo," + ;
                       " a.Moedas, a.Precific, a.fkChaves," + ;
                       " a.Datas, a.Usuars, a.DtAlts, a.UsuAlts" + ;
                       " FROM SigPrCtr a" + ;
                       " WHERE a.Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " ORDER BY a.Cpros"

            IF USED("cursor_4c_Linhas")
                USE IN cursor_4c_Linhas
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Linhas")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar linhas da sessao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.BuscarLinhasSessao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega a primeira linha de uma sessao pelo Codigos
    * Usado para validacao e para preencher campos de cabecalho da sessao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigos)
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 a.Codigos, a.PkChave, a.Cpros, a.CodCors, a.CodTams," + ;
                       " a.OriDopNums, a.Qtds, a.QtdOs, a.Contas, a.Arquivo," + ;
                       " a.Moedas, a.Precific, a.fkChaves," + ;
                       " a.Datas, a.Usuars, a.DtAlts, a.UsuAlts" + ;
                       " FROM SigPrCtr a" + ;
                       " WHERE a.Codigos = " + EscaparSQL(par_cCodigos)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar sessao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    * SEMPRE usar SELECT (par_cAliasCursor) antes de acessar campos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos    = TratarNulo(Codigos,    "C")
                THIS.this_cPkChave    = TratarNulo(PkChave,    "C")
                THIS.this_cCpros      = TratarNulo(Cpros,      "C")
                THIS.this_cCodCors    = TratarNulo(CodCors,    "C")
                THIS.this_cCodTams    = TratarNulo(CodTams,    "C")
                THIS.this_cOriDopNums = TratarNulo(OriDopNums, "C")
                THIS.this_nQtds       = TratarNulo(Qtds,       "N")
                THIS.this_nQtdOs      = TratarNulo(QtdOs,      "N")
                THIS.this_cContas     = TratarNulo(Contas,     "C")
                THIS.this_cArquivo    = TratarNulo(Arquivo,    "C")
                THIS.this_cMoedas     = TratarNulo(Moedas,     "C")
                THIS.this_nPrecific   = TratarNulo(Precific,   "N")
                THIS.this_cFkChaves   = TratarNulo(fkChaves,   "C")
                THIS.this_dDatas      = TratarNulo(Datas,      "T")
                THIS.this_cUsuars     = TratarNulo(Usuars,     "C")
                THIS.this_dDtAlts     = TratarNulo(DtAlts,     "T")
                THIS.this_cUsuAlts    = TratarNulo(UsuAlts,    "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere UMA linha na tabela SigPrCtr (chamada em loop pela form)
    * PROTECTED - chamado por BusinessBase.Salvar()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigPrCtr" + ;
                       " (Codigos, PkChave, Cpros, CodCors, CodTams," + ;
                       "  OriDopNums, Qtds, QtdOs, Contas, Arquivo," + ;
                       "  Moedas, Precific, fkChaves, Datas, Usuars)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cPkChave)) + ", " + ;
                       EscaparSQL(THIS.this_cCpros) + ", " + ;
                       EscaparSQL(THIS.this_cCodCors) + ", " + ;
                       EscaparSQL(THIS.this_cCodTams) + ", " + ;
                       EscaparSQL(THIS.this_cOriDopNums) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdOs) + ", " + ;
                       EscaparSQL(THIS.this_cContas) + ", " + ;
                       EscaparSQL(THIS.this_cArquivo) + ", " + ;
                       EscaparSQL(THIS.this_cMoedas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPrecific) + ", " + ;
                       EscaparSQL(THIS.this_cFkChaves) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao inserir linha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza campos de auditoria de uma linha existente
    * PROTECTED - Para o padrao de edicao: DELETE + re-INSERT via GravarSessao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigPrCtr SET" + ;
                       " Qtds = " + FormatarNumeroSQL(THIS.this_nQtds) + "," + ;
                       " QtdOs = " + FormatarNumeroSQL(THIS.this_nQtdOs) + "," + ;
                       " Contas = " + EscaparSQL(THIS.this_cContas) + "," + ;
                       " Arquivo = " + EscaparSQL(THIS.this_cArquivo) + "," + ;
                       " Moedas = " + EscaparSQL(THIS.this_cMoedas) + "," + ;
                       " Precific = " + FormatarNumeroSQL(THIS.this_nPrecific) + "," + ;
                       " DtAlts = GETDATE()," + ;
                       " UsuAlts = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " WHERE PkChave = " + EscaparSQL(THIS.this_cPkChave)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar linha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove TODAS as linhas da sessao (PROTECTED)
    * Chamado por BusinessBase.Excluir()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrCtr WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao excluir sessao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirLinhasSessao - Remove TODAS as linhas de uma sessao (PUBLIC)
    * Usado pela form no inicio do ciclo de gravacao (ALTERAR)
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirLinhasSessao(par_cCodigos)
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCodigos))
                MsgErro("Codigos nao informado para exclusao de linhas.", "Erro")
            ELSE
                loc_cSQL = "DELETE FROM SigPrCtr WHERE Codigos = " + EscaparSQL(par_cCodigos)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir linhas da sessao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.ExcluirLinhasSessao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarNovoCodigos - Gera um novo identificador numerico de sessao
    * Retorna string C(10) com numero sequencial unico para SigPrCtr
    *--------------------------------------------------------------------------
    PROCEDURE GerarNovoCodigos()
        LOCAL loc_cCodigos, loc_cSQL, loc_nResult, loc_nMaxCod
        loc_cCodigos = ""
        loc_nMaxCod  = 0

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(CAST(LTRIM(RTRIM(Codigos)) AS BIGINT)), 0) + 1" + ;
                       " AS NovoCodigos FROM SigPrCtr"

            IF USED("cursor_4c_NovoCod")
                USE IN cursor_4c_NovoCod
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NovoCod")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_NovoCod") > 0
                SELECT cursor_4c_NovoCod
                loc_nMaxCod = cursor_4c_NovoCod.NovoCodigos
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.GerarNovoCodigos")
        ENDTRY

        IF USED("cursor_4c_NovoCod")
            USE IN cursor_4c_NovoCod
        ENDIF

        IF loc_nMaxCod > 0
            loc_cCodigos = ALLTRIM(STR(loc_nMaxCod, 10))
        ENDIF

        RETURN loc_cCodigos
    ENDPROC

ENDDEFINE

