# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[Formsigprcom.prg] Procedure vazia (sem codigo): GridListaAfterRowColChange

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprcom.prg):
*==============================================================================
* Formsigprcom.prg - Formulario: Estoque Maximo
* Tipo: CRUD (frmcadastro) com grid editavel na Page2
* Tabela: SigCdMax | PK: cidchaves
* SCX Original: sigprcom.SCX | Task: task165
* Fase 7/8: Eventos principais (BtnIncluir/Alterar/Visualizar/Excluir)
*==============================================================================

*------------------------------------------------------------------------------
* DEFINE CLASS Formsigprcom AS FormBase
*------------------------------------------------------------------------------
DEFINE CLASS Formsigprcom AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    *-- Caption sem acento na declaracao; setado com CHR() em InicializarForm
    Height      = 675
    Width       = 1000
    Caption     = "Estoque Maximo"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Business Object
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *-- Modo externo: form pode ser chamado com produto pre-selecionado
    *-- _Acesso=C -> WindowType=1, produto fixo; _Acesso=.NULL. -> modo normal
    this_pProduto    = .NULL.   && Produto passado externamente (tipo C = modo externo)
    this_cPcExterno  = ""       && Contexto de retorno (formulario chamador)
    this_cPcCPros    = ""       && Codigo do produto para modo externo
    this_cPcDPros    = ""       && Descricao do produto para modo externo
    this_cPcCGrus    = ""       && Grupo do produto para modo externo
    this_cPcIFors    = ""       && Fornecedor para modo externo
    this_cPcReffs    = ""       && Referencia do fornecedor para modo externo

    *-- Flags de controle do produto ativo na Page2
    this_lTemCor     = .F.      && Produto tem controle de cor
    this_lTemTam     = .F.      && Produto tem controle de tamanho
    this_nTipoEstos  = 0        && Tipo de estoque (de SigCdGrp.tipoestos)

    *-- Controle de operacao
    this_nBusca      = 0        && Coluna de busca ativa (1=cpros, 2=dpros, etc.)
    this_lAcCopiar   = .F.      && Permissao de copiar produto entre empresas
    this_lPlCancelar = .F.      && Flag: cancelou a operacao atual
    this_cPcEscolha  = "INSERIR" && Modo corrente: INSERIR/ALTERAR/CONSULTAR/PROCURAR

    *==========================================================================
    * INIT - Inicializacao do formulario
    * REGRA: apenas DODEFAULT() - FormBase.Init() chama InicializarForm()
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loException
            MsgErro("Erro em Formsigprcom.Init: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura principal (chamado pelo FormBase)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Caption com acento correto (CHR() obrigatorio em .PRG)
            THIS.Caption = "Estoque M" + CHR(225) + "ximo"

            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("sigprcomBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar sigprcomBO!", "Erro Cr" + CHR(237) + "tico")
                loc_lSucesso = .F.
            ELSE
                *-- Configurar estrutura de paginas
                THIS.ConfigurarPageFrame()

                *-- Carregar lista inicial (pula se validando UI sem conexao SQL)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em InicializarForm: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * PageFrame.Top = -29 para ocultar abas; todos controles internos +29 no Top
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf, loc_oPg1, loc_oPg2

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        WITH loc_oPgf
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.
        ENDWITH

        *-- Page1 (Lista) - background do framework
        loc_oPg1 = loc_oPgf.Page1
        WITH loc_oPg1
            .Caption = "Lista"
            .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            .Visible = .T.
        ENDWITH

        *-- Page2 (Dados) - background do framework
        loc_oPg2 = loc_oPgf.Page2
        WITH loc_oPg2
            .Caption = "Dados"
            .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            .Visible = .T.
        ENDWITH

        *-- Configurar containers em cada pagina
        THIS.ConfigurarPaginaLista(loc_oPg1)
        THIS.ConfigurarPaginaDados(loc_oPg2)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Containers base da Page1 (Lista)
    * Grade e botoes CRUD serao adicionados na Fase 4
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista(par_oPagina)
        LOCAL loc_oPag
        loc_oPag = par_oPagina

        *----------------------------------------------------------------------
        * Container cabecalho (cntSombra do legado)
        * Original: Top=1, Left=-1, Width=1008, Height=80
        * Com compensacao PageFrame -29: Top = 1 + 29 = 30
        *----------------------------------------------------------------------
        loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPag.cnt_4c_Cabecalho
            .Top           = 30
            .Left          = -1
            .Width         = THIS.Width + 2
            .Height        = 80
            .BackColor     = RGB(100, 100, 100)
            .SpecialEffect = 0
            .BorderWidth   = 0
            .Visible       = .T.
        ENDWITH

        *-- Label sombra (offset de 3px cria efeito de sombra)
        loc_oPag.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPag.cnt_4c_Cabecalho.lbl_4c_Sombra
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 10
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label titulo principal (branco, sobre a sombra preta)
        loc_oPag.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPag.cnt_4c_Cabecalho.lbl_4c_Titulo
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 10
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Container botoes CRUD (Grupo_op do legado)
        * Original: Left=544, Top=-1, Width=385, Height=85
        * Com compensacao: Top = -1 + 29 = 28
        * Botoes: Incluir, Visualizar, Alterar, Excluir, Buscar
        *----------------------------------------------------------------------
        loc_oPag.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPag.cnt_4c_Botoes
            .Top         = 28
            .Left        =  542
            .Width       = 390
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPag.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPag.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        loc_oPag.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPag.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        loc_oPag.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPag.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        loc_oPag.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPag.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        loc_oPag.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPag.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *----------------------------------------------------------------------
        * Container Saida - PADRAO CANONICO (prevalece sobre PILAR 1)
        * Original Grupo_Saida: Left=919, Top=-1 -> canonico: Left=917, Top=29
        * BackStyle=0 (transparente): fundo vem da Page.Picture
        *----------------------------------------------------------------------
        loc_oPag.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPag.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Encerrar (PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75)
        loc_oPag.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPag.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPag.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *----------------------------------------------------------------------
        * Botao Copiar Produto (standalone, sobre o cabecalho)
        * Original btnCopiar: Top=4, Left=474 -> Com compensacao: Top=33
        *----------------------------------------------------------------------
        loc_oPag.AddObject("cmd_4c_BtnCopiar", "CommandButton")
        WITH loc_oPag.cmd_4c_BtnCopiar
            .Caption         = "Copiar Produto"
            .Top             = 33
            .Left            = 474
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "geral_copiar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Enabled         = THIS.this_lAcCopiar
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag.cmd_4c_BtnCopiar, "Click", THIS, "BtnCopiarClick")

        *----------------------------------------------------------------------
        * Grid principal de listagem (Grade do legado)
        * Original: Top=102, Left=14, Width=971, Height=553
        * Com compensacao PageFrame -29: Top = 102 + 29 = 131
        * ColumnCount OBRIGATORIO fora de WITH (Problema 36)
        *----------------------------------------------------------------------
        loc_oPag.AddObject("grd_4c_Lista", "Grid")
        loc_oPag.grd_4c_Lista.ColumnCount = 7
        WITH loc_oPag.grd_4c_Lista
            .Top           = 131
            .Left          = 14
            .Width         = 971
            .Height        = 553
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .GridLineColor = RGB(238, 238, 238)
            .ForeColor     = RGB(90, 90, 90)
            .RecordSource  = ""
            .Visible       = .T.
            .RecordMark   = .F.
            .DeleteMark   = .F.
        ENDWITH
        BINDEVENT(loc_oPag.grd_4c_Lista, "AfterRowColChange", THIS, "GridListaAfterRowColChange")

        *----------------------------------------------------------------------
        * Container flutuante de copia de produto entre empresas
        * Original cntCopia: Top=161, Left=256, Width=486, Height=373, visible=.F.
        * Com compensacao: Top = 161 + 29 = 190
        * BackStyle=1 (opaco) obrigatorio: BackStyle=0 sobre grid = ghost trails no scroll
        *----------------------------------------------------------------------
        loc_oPag.AddObject("cnt_4c_Copia", "Container")
        WITH loc_oPag.cnt_4c_Copia
            .Top           = 190
            .Left          = 256
            .Width         = 486
            .Height        = 373
            .BackStyle     = 1
            .BackColor     = RGB(210, 210, 210)
            .SpecialEffect = 0
            .BorderWidth   = 1
            .Visible       = .F.
        ENDWITH

        LOCAL loc_oCopia
        loc_oCopia = loc_oPag.cnt_4c_Copia

        *-- Botao Processar (cmd_4c_CmdProcessa)
        loc_oCopia.AddObject("cmd_4c_CmdProcessa", "CommandButton")
        WITH loc_oCopia.cmd_4c_CmdProcessa
            .Caption         = "Processar"
            .Top             = 3
            .Left            = 256
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCopia.cmd_4c_CmdProcessa, "Click", THIS, "CmdProcessaClick")

        *-- Botao Confirmar copia (cmd_4c_CmdCopiar)
        loc_oCopia.AddObject("cmd_4c_CmdCopiar", "CommandButton")
        WITH loc_oCopia.cmd_4c_CmdCopiar
            .Caption         = "Confirmar"
            .Top             = 3
            .Left            = 332
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "geral_copiar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCopia.cmd_4c_CmdCopiar, "Click", THIS, "CmdCopiarClick")

        *-- Botao Sair do painel de copia (cmd_4c_CmdSair)
        loc_oCopia.AddObject("cmd_4c_CmdSair", "CommandButton")
        WITH loc_oCopia.cmd_4c_CmdSair
            .Caption         = "Encerrar"
            .Top             = 3
            .Left            = 407
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCopia.cmd_4c_CmdSair, "Click", THIS, "CmdSairCopiaClick")

        *-- Label "Empresa Origem :" (lbl_empresa original)
        loc_oCopia.AddObject("lbl_4c_Lbl_empresa", "Label")
        WITH loc_oCopia.lbl_4c_Lbl_empresa
            .AutoSize  = .F.
            .Caption   = "Empresa Origem :"
            .Top       = 35
            .Left      = 35
            .Width     = 87
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label "Empresa Destino :" (Say2 original)
        loc_oCopia.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCopia.lbl_4c_Label2
            .AutoSize  = .F.
            .Caption   = "Empresa Destino :"
            .Top       = 60
            .Left      = 33
            .Width     = 89
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Empresa Origem (GetEmpOs original)
        loc_oCopia.AddObject("txt_4c_EmpOs", "TextBox")
        WITH loc_oCopia.txt_4c_EmpOs
            .Top     = 31
            .Left    = 124
            .Width   = 31
            .Height  = 23
            .Value   = ""
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oCopia.txt_4c_EmpOs, "KeyPress", THIS, "EmpOrigLostFocus")

        *-- TextBox Empresa Destino (GetEmpDs original) - inicia desabilitada
        loc_oCopia.AddObject("txt_4c_EmpDs", "TextBox")
        WITH loc_oCopia.txt_4c_EmpDs
            .Top     = 56
            .Left    = 124
            .Width   = 31
            .Height  = 23
            .Value   = ""
            .Enabled = .F.
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oCopia.txt_4c_EmpDs, "KeyPress", THIS, "EmpDestLostFocus")

        *-- Label "Procura Produto :" (Say1 original)
        loc_oCopia.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCopia.lbl_4c_Label1
            .AutoSize  = .F.
            .Caption   = "Procura Produto :"
            .Top       = 85
            .Left      = 35
            .Width     = 89
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Produto filtro de copia (GetProduto original)
        loc_oCopia.AddObject("txt_4c_Produto", "TextBox")
        WITH loc_oCopia.txt_4c_Produto
            .Top     = 81
            .Left    = 124
            .Width   = 108
            .Height  = 23
            .Value   = ""
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oCopia.txt_4c_Produto, "KeyPress", THIS, "ProdutoCopiaLostFocus")

        *-- Botao Marcar (Marcar original) - oculto, revelado apos Processar
        loc_oCopia.AddObject("cmd_4c_Marcar", "CommandButton")
        WITH loc_oCopia.cmd_4c_Marcar
            .Caption       = ""
            .Top           = 234
            .Left          = 434
            .Width         = 40
            .Height        = 40
            .SpecialEffect = 0
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oCopia.cmd_4c_Marcar, "Click", THIS, "CmdMarcarClick")

        *-- Botao Desmarcar (Desmarcar original) - oculto, revelado apos Processar
        loc_oCopia.AddObject("cmd_4c_Desmarcar", "CommandButton")
        WITH loc_oCopia.cmd_4c_Desmarcar
            .Caption       = ""
            .Top           = 274
            .Left          = 434
            .Width         = 40
            .Height        = 40
            .SpecialEffect = 0
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oCopia.cmd_4c_Desmarcar, "Click", THIS, "CmdDesmarcarClick")

        *-- Labels de legenda de cores (Say3-Say8 do legado)
        loc_oCopia.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oCopia.lbl_4c_Label3
            .AutoSize  = .F.
            .Caption   = "Vermelho : "
            .Top       = 317
            .Left      = 40
            .Width     = 74
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(192, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCopia.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oCopia.lbl_4c_Label4
            .AutoSize  = .F.
            .Caption   = "Produtos existem na Origem e no Destino."
            .Top       = 317
            .Left      = 118
            .Width     = 204
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCopia.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oCopia.lbl_4c_Label6
            .AutoSize  = .F.
            .Caption   = "Azul : "
            .Top       = 333
            .Left      = 45
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 192)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCopia.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oCopia.lbl_4c_Label5
            .AutoSize  = .F.
            .Caption   = "Produtos existem no Destino mas n" + CHR(227) + "o existem na Origem"
            .Top       = 333
            .Left      = 118
            .Width     = 274
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCopia.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oCopia.lbl_4c_Label7
            .AutoSize  = .F.
            .Caption   = "Preto : "
            .Top       = 349
            .Left      = 45
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCopia.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oCopia.lbl_4c_Label8
            .AutoSize  = .F.
            .Caption   = "Produtos existem na Origem mas n" + CHR(227) + "o existem no Destino"
            .Top       = 349
            .Left      = 118
            .Width     = 274
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Grid de itens para copia (GrdItens original)
        *-- ColumnCount OBRIGATORIO fora de WITH (Problema 36)
        *-- Column1 tem CheckBox; ReadOnly=.F. para permitir marcar registros
        loc_oCopia.AddObject("grd_4c_Dados", "Grid")
        loc_oCopia.grd_4c_Dados.ColumnCount = 6
        WITH loc_oCopia.grd_4c_Dados
            .Top           = 131
            .Left          = 27
            .Width         = 403
            .Height        = 184
            .ReadOnly      = .F.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .GridLineColor = RGB(238, 238, 238)
            .ForeColor     = RGB(90, 90, 90)
            .RecordSource  = ""
            .Visible       = .T.
            .RecordMark   = .F.
            .DeleteMark   = .F.
        ENDWITH

        *-- CheckBox na Column1 (Check1 original): marca registro para copia
        loc_oCopia.grd_4c_Dados.Column1.AddObject("chk_4c_Check1", "CheckBox")
        WITH loc_oCopia.grd_4c_Dados.Column1
            .CurrentControl = "chk_4c_Check1"
            .Sparse         = .F.
            .Width          = 30
            .ReadOnly       = .F.
        ENDWITH
        WITH loc_oCopia.grd_4c_Dados.Column1.chk_4c_Check1
            .Caption = ""
            .Width   = 25
            .Height  = 17
        ENDWITH
        loc_oCopia.grd_4c_Dados.Column1.Header1.Caption = ""

        *-- Tornar controles visiveis (cnt_4c_Copia permanece oculto)
        THIS.TornarControlesVisiveis(loc_oPag)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2 (Dados): botoes + primeiros 50% dos campos
    * Fase 5/8: Container acao + Produto (codigo/descricao) + Grupo (codigo/desc)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados(par_oPagina)
        LOCAL loc_oPag
        loc_oPag = par_oPagina

        *----------------------------------------------------------------------
        * Container botoes acao (Grupo_Salva do legado)
        * Original: Left=843, Top=-3, Width=160, Height=85
        * Com compensacao PageFrame -29: Top = -3 + 29 = 26
        *----------------------------------------------------------------------
        loc_oPag.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPag.cnt_4c_BotoesAcao
            .Top         = 26
            .Left        = 843
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (salva dados do grid de estoque maximo)
        loc_oPag.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (descarta e volta para lista)
        loc_oPag.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        * Label "Produto :" e campos de produto
        * Say1: Top=79+29=108, Left=260, Width=47, Height=15
        * get_produto: Top=75+29=104, Left=309, Width=108, Height=23
        * getDpro:     Top=75+29=104, Left=419, Width=360, Height=23
        * get_produto: When=INSERIR/PROCURAR sem produto externo; Valid=lookup SigCdPro
        * getDpro: When=INSERIR/PROCURAR sem codigo; Valid=lookup SigCdPro por descricao
        *----------------------------------------------------------------------
        loc_oPag.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag.lbl_4c_Label1
            .AutoSize  = .F.
            .Caption   = "Produto :"
            .Top       = 108
            .Left      = 260
            .Width     = 47
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c__produto", "TextBox")
        WITH loc_oPag.txt_4c__produto
            .Top     = 104
            .Left    = 309
            .Width   = 108
            .Height  = 23
            .Value   = ""
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPag.txt_4c__produto, "KeyPress", THIS, "ValidarProdutoCodigo")

        loc_oPag.AddObject("txt_4c_Dpro", "TextBox")
        WITH loc_oPag.txt_4c_Dpro
            .Top     = 104
            .Left    = 419
            .Width   = 360
            .Height  = 23
            .Value   = ""
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPag.txt_4c_Dpro, "KeyPress", THIS, "ValidarProdutoDescricao")

        *----------------------------------------------------------------------
        * Label "Grupo :" e campos de grupo
        * Say8:    Top=105+29=134, Left=269, Width=38, Height=15
        * getCgru: Top=101+29=130, Left=309, Width=31, Height=23  (When=.F.)
        * getDgru: Top=101+29=130, Left=343, Width=150, Height=23 (When=.F.)
        * Ambos os campos de grupo sao sempre somente-leitura (When retorna .F.)
        *----------------------------------------------------------------------
        loc_oPag.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPag.lbl_4c_Label8
            .AutoSize  = .F.
            .Caption   = "Grupo :"
            .Top       = 134
            .Left      = 269
            .Width     = 38
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Cgru", "TextBox")
        WITH loc_oPag.txt_4c_Cgru
            .Top      = 130
            .Left     = 309
            .Width    = 31
            .Height   = 23
            .Value    = ""
            .ReadOnly = .T.
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Dgru", "TextBox")
        WITH loc_oPag.txt_4c_Dgru
            .Top      = 130
            .Left     = 343
            .Width    = 150
            .Height   = 23
            .Value    = ""
            .ReadOnly = .T.
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Label "Fornecedor :" + campos fornecedor (read-only, exibe dados do produto)
        * Say11: Top=130+29=159, Left=243, Width=64, Height=15
        * getIfor: Top=127+29=156, Left=309, Width=80 (When=.F. -> sempre somente-leitura)
        * getDfor: Top=127+29=156, Left=392, Width=220 (When=.F. -> sempre somente-leitura)
        *----------------------------------------------------------------------
        loc_oPag.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPag.lbl_4c_Label11
            .AutoSize  = .F.
            .Caption   = "Fornecedor :"
            .Top       = 159
            .Left      = 243
            .Width     = 64
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Ifor", "TextBox")
        WITH loc_oPag.txt_4c_Ifor
            .Top      = 156
            .Left     = 309
            .Width    = 80
            .Height   = 23
            .Value    = ""
            .ReadOnly = .T.
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Dfor", "TextBox")
        WITH loc_oPag.txt_4c_Dfor
            .Top      = 156
            .Left     = 392
            .Width    = 220
            .Height   = 23
            .Value    = ""
            .ReadOnly = .T.
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Label "Ref. Fornecedor :" + campo referencia (read-only, exibe ref. do produto)
        * Say12: Top=156+29=185, Left=219, Width=88, Height=15
        * getRefs: Top=153+29=182, Left=309, Width=150 (When=.F. -> somente-leitura)
        *----------------------------------------------------------------------
        loc_oPag.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPag.lbl_4c_Label12
            .AutoSize  = .F.
            .Caption   = "Ref. Fornecedor :"
            .Top       = 185
            .Left      = 219
            .Width     = 88
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Refs", "TextBox")
        WITH loc_oPag.txt_4c_Refs
            .Top      = 182
            .Left     = 309
            .Width    = 150
            .Height   = 23
            .Value    = ""
            .ReadOnly = .T.
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Label "Situacao :" + OptionGroup (exibe situacao do produto; sempre Enabled=.F.)
        * Say19: Top=105+29=134, Left=505
        * Opc_situacao: Top=100+29=129, Left=555, Width=117, Height=25 (When=.F.)
        * Problema 30: cada Button precisa de Left, Top, AutoSize (evita sobreposicao)
        * Regra 9.1: NAO usar PUBLIC em DEFINE CLASS; .Value so no OptionGroup (nao em Buttons)
        *----------------------------------------------------------------------
        loc_oPag.AddObject("lbl_4c_Label19", "Label")
        WITH loc_oPag.lbl_4c_Label19
            .AutoSize  = .F.
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
            .Top       = 134
            .Left      = 505
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("obj_4c_Opc_situacao", "OptionGroup")
        WITH loc_oPag.obj_4c_Opc_situacao
            .ButtonCount = 2
            .Top         = 129
            .Left        = 555
            .Width       = 122
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Enabled     = .F.
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPag.obj_4c_Opc_situacao.Buttons(1)
            .Caption   = "Ativo"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .Width     = 50
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPag.obj_4c_Opc_situacao.Buttons(2)
            .Caption   = "Inativo"
            .BackStyle = 0
            .Left      = 62
            .Top       = 5
            .Width     = 50
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *----------------------------------------------------------------------
        * Botao Excluir linha (btnExcluir original)
        * Top=385+29=414, Left=700, Width=40, Height=40, Caption="" (icone-only)
        * Exclui linha da empresa corrente no grid de estoque maximo
        * Memory: standalone cmd icone-only: Themes=.T. para renderizar icone sem texto
        * Visible=.F. inicialmente; setado .T. em BtnIncluirClick e BtnAlterarClick
        *----------------------------------------------------------------------
        loc_oPag.AddObject("cmd_4c_BtnExcluir", "CommandButton")
        WITH loc_oPag.cmd_4c_BtnExcluir
            .Caption         = ""
            .Top             = 414
            .Left            = 700
            .Width           = 40
            .Height          = 40
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .AutoSize        = .F.
            .Visible         = .F.
        ENDWITH
        BINDEVENT(loc_oPag.cmd_4c_BtnExcluir, "Click", THIS, "BtnExcluirLinhaClick")

        *----------------------------------------------------------------------
        * Grid editavel de estoque maximo (gradei original)
        * Top=181+29=210, Left=309, Width=387, Height=472, ColumnCount=5
        * ReadOnly=.F.: usuario edita empresa/qtde/tamanho/cor/departamento
        * Problema 36: ColumnCount FORA de WITH (colunas criadas imediatamente)
        * RecordSource, ControlSource e Headers configurados em VincularGridPage2()
        * Column3 (codtams): habilitado se this_lTemTam=.T.
        * Column4 (codcores): habilitado se this_lTemCor=.T.
        * F4 em Column3/4/5: abre lookup via GradeKeyPressPage2
        *----------------------------------------------------------------------
        loc_oPag.AddObject("grd_4c_Dados", "Grid")
        loc_oPag.grd_4c_Dados.ColumnCount = 5
        WITH loc_oPag.grd_4c_Dados
            .Top           = 210
            .Left          = 309
            .Width         = 387
            .Height        = 472
            .ReadOnly      = .F.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .GridLineColor = RGB(238, 238, 238)
            .ForeColor     = RGB(90, 90, 90)
            .RowHeight     = 16
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .ScrollBars    = 2
            .RecordSource  = ""
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPag.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChangePage2")
        BINDEVENT(loc_oPag.grd_4c_Dados, "KeyPress", THIS, "GradeKeyPressPage2")

        *-- Tornar controles visiveis
        THIS.TornarControlesVisiveis(loc_oPag)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados e vincula ao grid da Page1
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ELSE
                loc_lSucesso = THIS.this_oBusinessObject.Buscar("")

                IF loc_lSucesso
                    THIS.VincularGridLista()
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarLista: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * EXCECAO: cnt_4c_Copia inicia oculto (painel de copia de produto)
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_cNome

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_cNome = UPPER(ALLTRIM(loc_oObjeto.Name))

                *-- Pular container flutuante de copia (deve iniciar oculto)
                *-- Recursao nos filhos para prepara-los quando o container for mostrado
                IF INLIST(loc_cNome, "CNT_4C_COPIA")
                    IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                *-- Trata PageFrame: itera Pages
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                *-- Trata containers com filhos
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata visual do grid da lista (Page1)
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * VincularGridLista - Vincula cursor_4c_Dados ao grd_4c_Lista
    * Problemas 34/36/48/32: reset RS -> ColumnCount fora WITH -> RS -> ControlSource -> Header
    *==========================================================================
    PROCEDURE VincularGridLista()
        LOCAL loc_oGrd

        TRY
            IF USED("cursor_4c_Dados")
                loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                *-- Problema 34: reset RecordSource antes de reconectar
                loc_oGrd.RecordSource = ""

                *-- Problema 36: ColumnCount FORA de WITH
                loc_oGrd.ColumnCount = 7

                *-- Reconectar RecordSource
                loc_oGrd.ColumnCount = 3
                loc_oGrd.RecordSource = "cursor_4c_Dados"

                *-- Problema 48: ControlSource APOS RecordSource
                WITH loc_oGrd
                    .Column1.ControlSource = "cursor_4c_Dados.cpros"
                    .Column2.ControlSource = "cursor_4c_Dados.dpros"
                    .Column3.ControlSource = "cursor_4c_Dados.rclis"
                    .Column4.ControlSource = "cursor_4c_Dados.ifors"
                    .Column5.ControlSource = "cursor_4c_Dados.reffs"
                    .Column6.ControlSource = "cursor_4c_Dados.cgrus"
                    .Column7.ControlSource = "cursor_4c_Dados.dgrus"
                ENDWITH

                *-- Problema 32: Header captions APOS RecordSource
                loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "d. Produto"
                loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrd.Column3.Header1.Caption = "Raz" + CHR(227) + "o Social"
                loc_oGrd.Column4.Header1.Caption = "Fornecedor"
                loc_oGrd.Column5.Header1.Caption = "Refer" + CHR(234) + "ncia"
                loc_oGrd.Column6.Header1.Caption = "Grupo"
                loc_oGrd.Column7.Header1.Caption = "Desc. Grupo"

                *-- Larguras das colunas (total = 950, cabe em Width=971)
                WITH loc_oGrd
                    .Column1.Width = 100
                    .Column2.Width = 280
                    .Column3.Width = 180
                    .Column4.Width = 70
                    .Column5.Width = 130
                    .Column6.Width = 60
                    .Column7.Width = 130
                ENDWITH

                THIS.FormatarGridLista(loc_oGrd)
                loc_oGrd.Refresh
            ENDIF
        CATCH TO loException
            MsgErro("Erro em VincularGridLista: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ELSE
                THIS.this_cModoAtual = "DADOS"
            ENDIF
        CATCH TO loException
            MsgErro("Erro em AlternarPagina: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Modo INSERIR: navega para Page2
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_cPcEscolha = "INSERIR"
            THIS.this_lTemCor    = .F.
            THIS.this_lTemTam    = .F.
            THIS.this_nTipoEstos = 0
            THIS.LimparPage2()
            THIS.pgf_4c_Paginas.Page2.cmd_4c_BtnExcluir.Visible = .T.
            THIS.AlternarPagina(2)
        CATCH TO loException
            MsgErro("Erro em BtnIncluirClick: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Modo CONSULTAR: carrega produto e navega para Page2
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lSucesso, loc_cCpros
        loc_lSucesso = .F.
        loc_cCpros   = ""

        TRY
            IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cCpros   = ALLTRIM(cpros)
                loc_lSucesso = THIS.this_oBusinessObject.BuscarCabecalhoProduto(loc_cCpros)

                IF loc_lSucesso
                    loc_lSucesso = THIS.this_oBusinessObject.BuscarPorProduto(loc_cCpros)
                ENDIF

                IF loc_lSucesso
                    THIS.this_lTemCor    = THIS.this_oBusinessObject.this_lTemCor
                    THIS.this_lTemTam    = THIS.this_oBusinessObject.this_lTemTam
                    THIS.this_nTipoEstos = THIS.this_oBusinessObject.this_nTipoEstos
                    THIS.this_cPcEscolha = "CONSULTAR"
                    THIS.pgf_4c_Paginas.Page2.txt_4c__produto.Value    = ALLTRIM(loc_cCpros)
                    THIS.PreencherCabecalhoProduto()
                    THIS.VincularGridPage2()
                    THIS.pgf_4c_Paginas.Page2.cmd_4c_BtnExcluir.Visible = .F.
                    THIS.AlternarPagina(2)
                ENDIF
            ELSE
                MsgAviso("Selecione um produto para visualizar.", "Aviso")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BtnVisualizarClick: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Modo ALTERAR: carrega produto e navega para Page2
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_lSucesso, loc_cCpros
        loc_lSucesso = .F.
        loc_cCpros   = ""

        TRY
            IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cCpros   = ALLTRIM(cpros)
                loc_lSucesso = THIS.this_oBusinessObject.BuscarCabecalhoProduto(loc_cCpros)

                IF loc_lSucesso
                    loc_lSucesso = THIS.this_oBusinessObject.BuscarPorProduto(loc_cCpros)
                ENDIF

                IF loc_lSucesso
                    THIS.this_lTemCor    = THIS.this_oBusinessObject.this_lTemCor
                    THIS.this_lTemTam    = THIS.this_oBusinessObject.this_lTemTam
                    THIS.this_nTipoEstos = THIS.this_oBusinessObject.this_nTipoEstos
                    THIS.this_cPcEscolha = "ALTERAR"
                    THIS.pgf_4c_Paginas.Page2.txt_4c__produto.Value    = ALLTRIM(loc_cCpros)
                    THIS.PreencherCabecalhoProduto()
                    THIS.VincularGridPage2()
                    THIS.pgf_4c_Paginas.Page2.cmd_4c_BtnExcluir.Visible = .T.
                    THIS.AlternarPagina(2)
                ENDIF
            ELSE
                MsgAviso("Selecione um produto para alterar.", "Aviso")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BtnAlterarClick: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui todas as linhas de SigCdMax do produto selecionado
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lConfirma, loc_cCpros, loc_lSucesso
        loc_lConfirma = .F.
        loc_cCpros    = ""
        loc_lSucesso  = .F.

        TRY
            IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cCpros    = ALLTRIM(cpros)
                loc_lConfirma = MsgConfirma("Excluir todos os registros do produto " + loc_cCpros + "?", ;
                    "Confirmar Exclus" + CHR(227) + "o")
            ELSE
                MsgAviso("Selecione um produto para excluir.", "Aviso")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BtnExcluirClick: " + loException.Message, "Erro")
        ENDTRY

        IF loc_lConfirma
            THIS.this_oBusinessObject.this_cCidchaves = ""
            THIS.this_oBusinessObject.this_cCpros     = loc_cCpros
            loc_lSucesso = THIS.this_oBusinessObject.Excluir()

            IF loc_lSucesso
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Abre busca auxiliar em SigCdPro e filtra o grid
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oForm, loc_cFiltro
        loc_cFiltro = ""

        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_Busca", "cpros", "", ;
                "Buscar Produto")

            IF VARTYPE(loc_oForm) = "O" AND !ISNULL(loc_oForm)
                IF !loc_oForm.this_lAchouRegistro
                    loc_oForm.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                    loc_oForm.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oForm.Show()
                ENDIF

                IF loc_oForm.this_lSelecionou AND USED("cursor_4c_Busca")
                    GO TOP IN cursor_4c_Busca
                    SELECT cursor_4c_Busca
                    loc_cFiltro = "a.cpros = " + EscaparSQL(ALLTRIM(cpros))
                ENDIF

                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF

                loc_oForm.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BtnBuscarClick: " + loException.Message, "Erro")
        ENDTRY

        *-- Recarregar lista com filtro (vazio = todos os produtos)
        THIS.this_oBusinessObject.Buscar(loc_cFiltro)
        THIS.VincularGridLista()
    ENDPROC

    *==========================================================================
    * BtnCopiarClick - Mostra/oculta o painel de copia entre empresas
    *==========================================================================
    PROCEDURE BtnCopiarClick()
        LOCAL loc_oPag1

        TRY
            loc_oPag1 = THIS.pgf_4c_Paginas.Page1

            IF !loc_oPag1.cnt_4c_Copia.Visible
                *-- Mostrar painel: desabilitar controles principais
                loc_oPag1.cnt_4c_Copia.Visible       = .T.
                loc_oPag1.cmd_4c_BtnCopiar.Enabled   = .F.
                loc_oPag1.grd_4c_Lista.Enabled        = .F.
                loc_oPag1.cnt_4c_Botoes.Enabled       = .F.
                loc_oPag1.cnt_4c_Saida.Enabled        = .F.
            ELSE
                THIS.CmdSairCopiaClick()
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BtnCopiarClick: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdSairCopiaClick - Fecha painel de copia e reabilita controles principais
    *==========================================================================
    PROCEDURE CmdSairCopiaClick()
        LOCAL loc_oPag1

        TRY
            loc_oPag1 = THIS.pgf_4c_Paginas.Page1

            loc_oPag1.cnt_4c_Copia.Visible       = .F.
            loc_oPag1.cmd_4c_BtnCopiar.Enabled   = THIS.this_lAcCopiar
            loc_oPag1.grd_4c_Lista.Enabled        = .T.
            loc_oPag1.cnt_4c_Botoes.Enabled       = .T.
            loc_oPag1.cnt_4c_Saida.Enabled        = .T.

            WITH loc_oPag1.cnt_4c_Copia
                .txt_4c_EmpOs.Value       = ""
                .txt_4c_EmpDs.Value       = ""
                .txt_4c_EmpDs.Enabled     = .F.
                .txt_4c_Produto.Value     = ""
                .grd_4c_Dados.RecordSource = ""
                .cmd_4c_Marcar.Visible    = .F.
                .cmd_4c_Desmarcar.Visible = .F.
            ENDWITH

            IF USED("cursor_4c_Copia")
                USE IN cursor_4c_Copia
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CmdSairCopiaClick: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * EmpOrigLostFocus - Habilita/desabilita campo Empresa Destino
    *==========================================================================
    PROCEDURE EmpOrigLostFocus()
        LOCAL loc_oCopia

        TRY
            loc_oCopia = THIS.pgf_4c_Paginas.Page1.cnt_4c_Copia

            IF !EMPTY(ALLTRIM(loc_oCopia.txt_4c_EmpOs.Value))
                loc_oCopia.txt_4c_EmpDs.Enabled = .T.
            ELSE
                loc_oCopia.txt_4c_EmpDs.Enabled = .F.
                loc_oCopia.txt_4c_EmpDs.Value   = ""
            ENDIF
        CATCH TO loException
            MsgErro("Erro em EmpOrigLostFocus: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * EmpDestLostFocus - Valida que empresa destino != empresa origem
    *==========================================================================
    PROCEDURE EmpDestLostFocus()
        LOCAL loc_oCopia, loc_cEmpO, loc_cEmpD

        TRY
            loc_oCopia = THIS.pgf_4c_Paginas.Page1.cnt_4c_Copia
            loc_cEmpO  = ALLTRIM(loc_oCopia.txt_4c_EmpOs.Value)
            loc_cEmpD  = ALLTRIM(loc_oCopia.txt_4c_EmpDs.Value)

            IF !EMPTY(loc_cEmpD) AND loc_cEmpO = loc_cEmpD
                MsgAviso("Empresa Destino n" + CHR(227) + "o pode ser igual a Empresa Origem!", "Aviso")
                loc_oCopia.txt_4c_EmpDs.Value = ""
                loc_oCopia.txt_4c_EmpDs.SetFocus
            ENDIF
        CATCH TO loException
            MsgErro("Erro em EmpDestLostFocus: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ProdutoCopiaLostFocus - Navega no grid de copia ao digitar produto
    *==========================================================================
    PROCEDURE ProdutoCopiaLostFocus()
        LOCAL loc_oCopia, loc_cProd

        TRY
            loc_oCopia = THIS.pgf_4c_Paginas.Page1.cnt_4c_Copia
            loc_cProd  = ALLTRIM(loc_oCopia.txt_4c_Produto.Value)

            IF !EMPTY(loc_cProd) AND USED("cursor_4c_Copia")
                SELECT cursor_4c_Copia
                SET NEAR ON
                SEEK loc_cProd
                SET NEAR OFF
                loc_oCopia.grd_4c_Dados.Refresh
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ProdutoCopiaLostFocus: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdProcessaClick - Carrega cursor_4c_Copia e vincula ao grd_4c_Dados
    * Problemas 34/36/48/32 aplicados ao grd_4c_Dados
    *==========================================================================
    PROCEDURE CmdProcessaClick()
        LOCAL loc_oCopia, loc_cEmpO, loc_cEmpD, loc_cProd, loc_oGrd, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_oCopia = THIS.pgf_4c_Paginas.Page1.cnt_4c_Copia
            loc_cEmpO  = ALLTRIM(loc_oCopia.txt_4c_EmpOs.Value)
            loc_cEmpD  = ALLTRIM(loc_oCopia.txt_4c_EmpDs.Value)
            loc_cProd  = ALLTRIM(loc_oCopia.txt_4c_Produto.Value)

            IF EMPTY(loc_cEmpO)
                MsgAviso("Digite uma Empresa de Origem para realizar a C" + CHR(243) + "pia!", "Aviso")
                loc_oCopia.txt_4c_EmpOs.SetFocus
            ELSE
                IF EMPTY(loc_cEmpD)
                    MsgAviso("Digite uma Empresa de Destino para realizar a C" + CHR(243) + "pia!", "Aviso")
                    loc_oCopia.txt_4c_EmpDs.SetFocus
                ELSE
                    loc_lSucesso = THIS.this_oBusinessObject.CarregarCursorCopia(loc_cProd, loc_cEmpO, loc_cEmpD)

                    IF loc_lSucesso AND USED("cursor_4c_Copia")
                        loc_oGrd = loc_oCopia.grd_4c_Dados

                        *-- Problema 34: reset antes de reconectar
                        loc_oGrd.RecordSource = ""

                        *-- Problema 36: ColumnCount FORA de WITH
                        loc_oGrd.ColumnCount = 6

                        *-- Reconectar RecordSource
                        loc_oGrd.ColumnCount = 6
                        loc_oGrd.RecordSource = "cursor_4c_Copia"

                        *-- Problema 48: ControlSource APOS RecordSource
                        loc_oGrd.Column1.ControlSource = "cursor_4c_Copia.marcas"
                        loc_oGrd.Column2.ControlSource = "cursor_4c_Copia.cpros"
                        loc_oGrd.Column3.ControlSource = "cursor_4c_Copia.qmaxs"
                        loc_oGrd.Column4.ControlSource = "cursor_4c_Copia.codtams"
                        loc_oGrd.Column5.ControlSource = "cursor_4c_Copia.codcores"
                        loc_oGrd.Column6.ControlSource = "cursor_4c_Copia.deptos"

                        *-- Problema 32: Header captions APOS RecordSource
                        loc_oGrd.Column1.Header1.Caption = ""
                        loc_oGrd.Column2.Header1.Caption = "Produto"
                        loc_oGrd.Column3.Header1.Caption = "Qtde. M" + CHR(225) + "x."
                        loc_oGrd.Column4.Header1.Caption = "Tam"
                        loc_oGrd.Column5.Header1.Caption = "Cor"
                        loc_oGrd.Column6.Header1.Caption = "Departamento"

                        WITH loc_oGrd
                            .Column1.Width = 30
                            .Column2.Width = 100
                            .Column3.Width = 70
                            .Column4.Width = 50
                            .Column5.Width = 50
                            .Column6.Width = 90
                        ENDWITH

                        loc_oGrd.Refresh

                        *-- Revelar botoes de marcacao em massa
                        loc_oCopia.cmd_4c_Marcar.Visible    = .T.
                        loc_oCopia.cmd_4c_Desmarcar.Visible = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CmdProcessaClick: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdCopiarClick - Executa copia dos registros marcados e fecha painel
    *==========================================================================
    PROCEDURE CmdCopiarClick()
        LOCAL loc_oCopia, loc_cEmpO, loc_cEmpD, loc_cProd, loc_lSucesso, loc_nCopiados
        loc_lSucesso  = .F.
        loc_nCopiados = 0

        TRY
            loc_oCopia = THIS.pgf_4c_Paginas.Page1.cnt_4c_Copia
            loc_cEmpO  = ALLTRIM(loc_oCopia.txt_4c_EmpOs.Value)
            loc_cEmpD  = ALLTRIM(loc_oCopia.txt_4c_EmpDs.Value)
            loc_cProd  = ALLTRIM(loc_oCopia.txt_4c_Produto.Value)

            loc_lSucesso = THIS.this_oBusinessObject.CopiarEstoqueProduto(loc_cProd, loc_cEmpO, loc_cEmpD)

            IF loc_lSucesso
                loc_nCopiados = THIS.this_oBusinessObject.this_nQmaxs
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CmdCopiarClick: " + loException.Message, "Erro")
        ENDTRY

        IF loc_lSucesso
            MsgInfo("Foram copiados " + ALLTRIM(STR(loc_nCopiados)) + " registro(s).", ;
                "C" + CHR(243) + "pia Conclu" + CHR(237) + "da")
            THIS.CmdSairCopiaClick()
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdMarcarClick - Marca todos os registros eleg?veis no cursor_4c_Copia
    *==========================================================================
    PROCEDURE CmdMarcarClick()
        TRY
            THIS.this_oBusinessObject.MarcarTodosParaCopia(.T.)
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Copia.grd_4c_Dados.Refresh
        CATCH TO loException
            MsgErro("Erro em CmdMarcarClick: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdDesmarcarClick - Desmarca todos os registros no cursor_4c_Copia
    *==========================================================================
    PROCEDURE CmdDesmarcarClick()
        TRY
            THIS.this_oBusinessObject.MarcarTodosParaCopia(.F.)
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Copia.grd_4c_Dados.Refresh
        CATCH TO loException
            MsgErro("Erro em CmdDesmarcarClick: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GridListaAfterRowColChange - Handler AfterRowColChange do grd_4c_Lista
    * BINDEVENT exige parametro declarado no handler
    *==========================================================================
    PROCEDURE GridListaAfterRowColChange(par_nColIndex)
        *-- Sem acao na Page1: apenas aceita o evento para evitar erro de parametro
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Confirmar: salva registros de estoque maximo do produto
    * PUBLIC obrigatorio: BINDEVENT nao funciona com PROTECTED
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso, loc_oPag2, loc_cCpros
        loc_lSucesso = .F.
        loc_cCpros   = ""

        TRY
            loc_oPag2  = THIS.pgf_4c_Paginas.Page2
            loc_cCpros = ALLTRIM(loc_oPag2.txt_4c__produto.Value)

            IF THIS.this_cPcEscolha = "INSERIR" AND EMPTY(loc_cCpros)
                MsgAviso("Produto inv" + CHR(225) + "lido! Informe o c" + CHR(243) + "digo do produto.", "Aviso")
                loc_oPag2.txt_4c__produto.SetFocus
                loc_lSucesso = .F.
            ELSE
                loc_lSucesso = THIS.this_oBusinessObject.SalvarGridEstoque(loc_cCpros)

                IF loc_lSucesso
                    IF !EMPTY(THIS.this_cPcExterno)
                        THIS.this_lPlCancelar = .F.
                        THIS.Release()
                    ELSE
                        THIS.this_cPcEscolha = "INSERIR"
                        THIS.this_lTemCor    = .F.
                        THIS.this_lTemTam    = .F.
                        THIS.this_nTipoEstos = 0
                        THIS.AlternarPagina(1)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BtnSalvarClick: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Descarta alteracoes e volta para lista (ou fecha)
    * PUBLIC obrigatorio: BINDEVENT nao funciona com PROTECTED
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_lPlCancelar = .T.

            IF !EMPTY(THIS.this_cPcExterno)
                THIS.Release()
            ELSE
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BtnCancelarClick: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarProdutoCodigo - LostFocus de txt_4c__produto: lookup em SigCdPro
    * Carrega descricao, grupo, fornecedor e monta grid ao selecionar produto
    *==========================================================================
    PROCEDURE ValidarProdutoCodigo()
        LOCAL loc_oPag2, loc_cCpros, loc_oBusca
        loc_oPag2  = .NULL.
        loc_cCpros = ""

        TRY
            loc_oPag2  = THIS.pgf_4c_Paginas.Page2
            loc_cCpros = ALLTRIM(loc_oPag2.txt_4c__produto.Value)

            *-- Somente processar em modo INSERIR/PROCURAR sem produto externo
            IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "PROCURAR") OR !EMPTY(THIS.this_cPcCPros)
                *-- Nao processar lookup
            ELSE
                IF !EMPTY(loc_cCpros)
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                        "SigCdPro", "cursor_4c_Busca", "cpros", loc_cCpros, ;
                        "Produtos")

                    IF VARTYPE(loc_oBusca) = "O"
                        IF !loc_oBusca.this_lAchouRegistro
                            loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                            loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                            loc_oBusca.Show()
                        ENDIF

                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                            GO TOP IN cursor_4c_Busca
                            SELECT cursor_4c_Busca
                            loc_oPag2.txt_4c__produto.Value = ALLTRIM(cpros)
                            loc_oPag2.txt_4c_Dpro.Value     = ALLTRIM(dpros)
                            THIS.this_oBusinessObject.BuscarCabecalhoProduto(ALLTRIM(cpros))
                            THIS.PreencherCabecalhoProduto()
                            THIS.AcertarGridPorProduto(ALLTRIM(cpros))
                        ELSE
                            loc_oPag2.txt_4c__produto.Value = ""
                        ENDIF

                        IF USED("cursor_4c_Busca")
                            USE IN cursor_4c_Busca
                        ENDIF

                        loc_oBusca.Release()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ValidarProdutoCodigo: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarProdutoDescricao - LostFocus de txt_4c_Dpro: lookup por descricao
    * Habilitado apenas em INSERIR/PROCURAR quando codigo ainda nao informado
    *==========================================================================
    PROCEDURE ValidarProdutoDescricao()
        LOCAL loc_oPag2, loc_cDpro, loc_oBusca
        loc_oPag2 = .NULL.
        loc_cDpro = ""

        TRY
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2
            loc_cDpro = ALLTRIM(loc_oPag2.txt_4c_Dpro.Value)

            *-- Somente em INSERIR/PROCURAR sem codigo nem produto externo
            IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "PROCURAR") OR ;
               !EMPTY(THIS.this_cPcCPros) OR ;
               !EMPTY(ALLTRIM(loc_oPag2.txt_4c__produto.Value))
                *-- Nao processar lookup
            ELSE
                IF !EMPTY(loc_cDpro)
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                        "SigCdPro", "cursor_4c_Busca", "dpros", loc_cDpro, ;
                        "Produtos")

                    IF VARTYPE(loc_oBusca) = "O"
                        IF !loc_oBusca.this_lAchouRegistro
                            loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                            loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                            loc_oBusca.Show()
                        ENDIF

                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                            GO TOP IN cursor_4c_Busca
                            SELECT cursor_4c_Busca
                            loc_oPag2.txt_4c_Dpro.Value    = ALLTRIM(dpros)
                            loc_oPag2.txt_4c__produto.Value = ALLTRIM(cpros)
                            THIS.this_oBusinessObject.BuscarCabecalhoProduto(ALLTRIM(cpros))
                            THIS.PreencherCabecalhoProduto()
                            THIS.AcertarGridPorProduto(ALLTRIM(cpros))
                        ELSE
                            loc_oPag2.txt_4c_Dpro.Value = ""
                        ENDIF

                        IF USED("cursor_4c_Busca")
                            USE IN cursor_4c_Busca
                        ENDIF

                        loc_oBusca.Release()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ValidarProdutoDescricao: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PreencherCabecalhoProduto - Popula campos de display (grupo, fornecedor)
    * com dados do BO apos lookup bem-sucedido de produto
    *==========================================================================
    PROCEDURE PreencherCabecalhoProduto()
        LOCAL loc_oPag2

        TRY
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2

            WITH THIS.this_oBusinessObject
                loc_oPag2.txt_4c_Cgru.Value               = .this_cCgrus
                loc_oPag2.txt_4c_Dgru.Value               = .this_cDgrus
                loc_oPag2.txt_4c_Ifor.Value               = .this_cIfors
                loc_oPag2.txt_4c_Dfor.Value               = .this_cRclis
                loc_oPag2.txt_4c_Refs.Value               = .this_cReffs
                loc_oPag2.obj_4c_Opc_situacao.Value       = IIF(.this_nSituas = 2, 2, 1)
            ENDWITH
        CATCH TO loException
            MsgErro("Erro em PreencherCabecalhoProduto: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AcertarGridPorProduto - Carrega grade de estoque maximo do produto
    * Chamado apos selecao de produto; atualiza flags lTemCor/lTemTam
    *==========================================================================
    PROCEDURE AcertarGridPorProduto(par_cCpros)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !EMPTY(par_cCpros)
                loc_lSucesso = THIS.this_oBusinessObject.BuscarPorProduto(par_cCpros)

                IF loc_lSucesso
                    THIS.this_lTemCor    = THIS.this_oBusinessObject.this_lTemCor
                    THIS.this_lTemTam    = THIS.this_oBusinessObject.this_lTemTam
                    THIS.this_nTipoEstos = THIS.this_oBusinessObject.this_nTipoEstos

                    *-- Em modo INSERIR sem dados, garantir pelo menos uma linha em branco
                    IF THIS.this_cPcEscolha = "INSERIR" AND ;
                       (!USED("cursor_4c_MaxProduto") OR RECCOUNT("cursor_4c_MaxProduto") = 0)
                        THIS.this_oBusinessObject.InserirLinhaCursorLocal(par_cCpros)
                    ENDIF

                    THIS.VincularGridPage2()
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em AcertarGridPorProduto: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VincularGridPage2 - Vincula cursor_4c_MaxProduto ao grd_4c_Dados (Page2)
    * Problemas 34/36/48/32: reset RS -> ColumnCount fora WITH -> RS -> ControlSource -> Header
    * Column3 (codtams): ReadOnly se produto nao tem tamanho
    * Column4 (codcores): ReadOnly se produto nao tem cor
    * CONSULTAR: todas as colunas ReadOnly
    *==========================================================================
    PROCEDURE VincularGridPage2()
        LOCAL loc_oGrd, loc_lTemTam, loc_lTemCor, loc_lConsultar

        TRY
            IF USED("cursor_4c_MaxProduto")
                loc_oGrd       = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
                loc_lTemTam    = THIS.this_lTemTam
                loc_lTemCor    = THIS.this_lTemCor
                loc_lConsultar = (THIS.this_cPcEscolha = "CONSULTAR")

                *-- Problema 34: reset RecordSource antes de reconectar
                loc_oGrd.RecordSource = ""

                *-- Problema 36: ColumnCount FORA de WITH
                loc_oGrd.ColumnCount = 5

                *-- Reconectar RecordSource
                loc_oGrd.ColumnCount = 5
                loc_oGrd.RecordSource = "cursor_4c_MaxProduto"

                *-- Problema 48: ControlSource APOS RecordSource
                loc_oGrd.Column1.ControlSource = "cursor_4c_MaxProduto.emps"
                loc_oGrd.Column2.ControlSource = "cursor_4c_MaxProduto.qmaxs"
                loc_oGrd.Column3.ControlSource = "cursor_4c_MaxProduto.codtams"
                loc_oGrd.Column4.ControlSource = "cursor_4c_MaxProduto.codcores"
                loc_oGrd.Column5.ControlSource = "cursor_4c_MaxProduto.deptos"

                *-- Problema 32: Header captions APOS RecordSource
                loc_oGrd.Column1.Header1.Caption = "Empresa"
                loc_oGrd.Column2.Header1.Caption = "Qtde. M" + CHR(225) + "x."
                loc_oGrd.Column3.Header1.Caption = "Tam"
                loc_oGrd.Column4.Header1.Caption = "Cor"
                loc_oGrd.Column5.Header1.Caption = "Departamento"

                WITH loc_oGrd
                    .Column1.Width = 40
                    .Column2.Width = 80
                    .Column3.Width = 70
                    .Column4.Width = 70
                    .Column5.Width = 100
                ENDWITH

                IF loc_lConsultar
                    loc_oGrd.Column1.ReadOnly = .T.
                    loc_oGrd.Column2.ReadOnly = .T.
                    loc_oGrd.Column3.ReadOnly = .T.
                    loc_oGrd.Column4.ReadOnly = .T.
                    loc_oGrd.Column5.ReadOnly = .T.
                ELSE
                    loc_oGrd.Column1.ReadOnly = .F.
                    loc_oGrd.Column2.ReadOnly = .F.
                    loc_oGrd.Column3.ReadOnly = !loc_lTemTam
                    loc_oGrd.Column4.ReadOnly = !loc_lTemCor
                    loc_oGrd.Column5.ReadOnly = .F.
                ENDIF

                loc_oGrd.Refresh
            ENDIF
        CATCH TO loException
            MsgErro("Erro em VincularGridPage2: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirLinhaClick - Exclui linha da empresa corrente no grid de estoque
    * Disponivel apenas em INSERIR/ALTERAR (cmd_4c_BtnExcluir.Visible=.F. em CONSULTAR)
    *==========================================================================
    PROCEDURE BtnExcluirLinhaClick()
        LOCAL loc_lConfirma, loc_cCpros, loc_cEmps, loc_lSucesso
        loc_lConfirma = .F.
        loc_cCpros    = ""
        loc_cEmps     = ""
        loc_lSucesso  = .F.

        TRY
            IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
                *-- Nao processar fora do modo de edicao
            ELSE
                IF USED("cursor_4c_MaxProduto") AND RECCOUNT("cursor_4c_MaxProduto") > 0 AND !EOF("cursor_4c_MaxProduto")
                SELECT cursor_4c_MaxProduto
                loc_cCpros    = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__produto.Value)
                loc_cEmps     = ALLTRIM(emps)
                loc_lConfirma = MsgConfirma("Excluir linha da empresa '" + loc_cEmps + "'?", ;
                    "Confirmar Exclus" + CHR(227) + "o")
            ELSE
                MsgAviso("Nenhuma linha selecionada para exclus" + CHR(227) + "o.", "Aviso")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BtnExcluirLinhaClick: " + loException.Message, "Erro")
        ENDTRY

        IF loc_lConfirma AND !EMPTY(loc_cCpros) AND !EMPTY(loc_cEmps)
            loc_lSucesso = THIS.this_oBusinessObject.ExcluirLinhaEmpresa(loc_cCpros, loc_cEmps)

            IF loc_lSucesso
                THIS.this_oBusinessObject.BuscarPorProduto(loc_cCpros)

                IF !USED("cursor_4c_MaxProduto") OR RECCOUNT("cursor_4c_MaxProduto") = 0
                    THIS.this_oBusinessObject.InserirLinhaCursorLocal(loc_cCpros)
                ENDIF

                THIS.VincularGridPage2()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * GradeAfterRowColChangePage2 - Handler AfterRowColChange do grd_4c_Dados
    * Atualiza ReadOnly de Column3/4 conforme flags lTemTam/lTemCor
    *==========================================================================
    PROCEDURE GradeAfterRowColChangePage2(par_nColIndex)
        LOCAL loc_oGrd

        TRY
            IF THIS.this_cPcEscolha != "CONSULTAR" AND USED("cursor_4c_MaxProduto")
                loc_oGrd = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
                loc_oGrd.Column3.ReadOnly = !THIS.this_lTemTam
                loc_oGrd.Column4.ReadOnly = !THIS.this_lTemCor
                loc_oGrd.Refresh
            ENDIF
        CATCH TO loException
            MsgErro("Erro em GradeAfterRowColChangePage2: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GradeKeyPressPage2 - Handler KeyPress do grd_4c_Dados (Page2)
    * F4(28): abre lookup de Tamanho(col3)/Cor(col4)/Departamento(col5)
    * Tab(9) em col5 na ultima linha: insere nova linha via MNovaLinha
    *==========================================================================
    PROCEDURE GradeKeyPressPage2(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oGrd, loc_nCol, loc_lUltimaLinha

        TRY
            IF THIS.this_cPcEscolha != "CONSULTAR" AND USED("cursor_4c_MaxProduto")
                loc_oGrd = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
                loc_nCol = loc_oGrd.ActiveColumn

                DO CASE
                CASE par_nKeyCode = 28 AND loc_nCol = 3 AND THIS.this_lTemTam
                    THIS.AbrirLookupTamanhoGrid()
                    NODEFAULT

                CASE par_nKeyCode = 28 AND loc_nCol = 4 AND THIS.this_lTemCor
                    THIS.AbrirLookupCorGrid()
                    NODEFAULT

                CASE par_nKeyCode = 28 AND loc_nCol = 5
                    THIS.AbrirLookupDepartamentoGrid()
                    NODEFAULT

                CASE par_nKeyCode = 9 AND loc_nCol = 5
                    SELECT cursor_4c_MaxProduto
                    loc_lUltimaLinha = (RECNO() = RECCOUNT())
                    IF loc_lUltimaLinha
                        THIS.MNovaLinha()
                        NODEFAULT
                    ENDIF
                ENDCASE
            ENDIF
        CATCH TO loException
            MsgErro("Erro em GradeKeyPressPage2: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupTamanhoGrid - Abre FormBuscaAuxiliar para SigCdTam (coluna 3)
    * Colunas: cods (codigo), descs (descricao)
    *==========================================================================
    PROCEDURE AbrirLookupTamanhoGrid()
        LOCAL loc_oForm, loc_cValAtual

        TRY
            IF USED("cursor_4c_MaxProduto")
                SELECT cursor_4c_MaxProduto
                loc_cValAtual = ALLTRIM(codtams)

                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdTam", "cursor_4c_BuscaTam", "cods", loc_cValAtual, ;
                    "Tamanhos")

                IF VARTYPE(loc_oForm) = "O"
                    IF !loc_oForm.this_lAchouRegistro
                        loc_oForm.mAddColuna("cods",  "", "C" + CHR(243) + "d.")
                        loc_oForm.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oForm.Show()
                    ENDIF

                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaTam")
                        GO TOP IN cursor_4c_BuscaTam
                        SELECT cursor_4c_BuscaTam
                        loc_cValAtual = ALLTRIM(cods)

                        SELECT cursor_4c_MaxProduto
                        REPLACE codtams WITH loc_cValAtual
                    ENDIF

                    IF USED("cursor_4c_BuscaTam")
                        USE IN cursor_4c_BuscaTam
                    ENDIF

                    loc_oForm.Release()
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em AbrirLookupTamanhoGrid: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupCorGrid - Abre FormBuscaAuxiliar para SigCdCor (coluna 4)
    * Colunas: cods (codigo), descs (descricao)
    *==========================================================================
    PROCEDURE AbrirLookupCorGrid()
        LOCAL loc_oForm, loc_cValAtual

        TRY
            IF USED("cursor_4c_MaxProduto")
                SELECT cursor_4c_MaxProduto
                loc_cValAtual = ALLTRIM(codcores)

                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdCor", "cursor_4c_BuscaCor", "cods", loc_cValAtual, ;
                    "Cores")

                IF VARTYPE(loc_oForm) = "O"
                    IF !loc_oForm.this_lAchouRegistro
                        loc_oForm.mAddColuna("cods",  "", "C" + CHR(243) + "d.")
                        loc_oForm.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oForm.Show()
                    ENDIF

                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCor")
                        GO TOP IN cursor_4c_BuscaCor
                        SELECT cursor_4c_BuscaCor
                        loc_cValAtual = ALLTRIM(cods)

                        SELECT cursor_4c_MaxProduto
                        REPLACE codcores WITH loc_cValAtual
                    ENDIF

                    IF USED("cursor_4c_BuscaCor")
                        USE IN cursor_4c_BuscaCor
                    ENDIF

                    loc_oForm.Release()
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em AbrirLookupCorGrid: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupDepartamentoGrid - Abre FormBuscaAuxiliar para SigCdDpt (coluna 5)
    * Colunas: codigos (codigo), Descricaos (descricao)
    *==========================================================================
    PROCEDURE AbrirLookupDepartamentoGrid()
        LOCAL loc_oForm, loc_cValAtual

        TRY
            IF USED("cursor_4c_MaxProduto")
                SELECT cursor_4c_MaxProduto
                loc_cValAtual = ALLTRIM(deptos)

                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdDpt", "cursor_4c_BuscaDpt", "codigos", loc_cValAtual, ;
                    "Departamentos")

                IF VARTYPE(loc_oForm) = "O"
                    IF !loc_oForm.this_lAchouRegistro
                        loc_oForm.mAddColuna("codigos",    "", "C" + CHR(243) + "d.")
                        loc_oForm.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oForm.Show()
                    ENDIF

                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaDpt")
                        GO TOP IN cursor_4c_BuscaDpt
                        SELECT cursor_4c_BuscaDpt
                        loc_cValAtual = ALLTRIM(codigos)

                        SELECT cursor_4c_MaxProduto
                        REPLACE deptos WITH PADR(loc_cValAtual, 10)
                    ENDIF

                    IF USED("cursor_4c_BuscaDpt")
                        USE IN cursor_4c_BuscaDpt
                    ENDIF

                    loc_oForm.Release()
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em AbrirLookupDepartamentoGrid: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * MNovaLinha - Insere nova linha em branco no cursor_4c_MaxProduto
    * Chamado pelo Tab na ultima coluna da ultima linha do grid
    *==========================================================================
    PROCEDURE MNovaLinha()
        LOCAL loc_cCpros, loc_oGrd

        TRY
            loc_cCpros = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__produto.Value)

            IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
                *-- Nao inserir linha em modo leitura
            ELSE
                IF EMPTY(loc_cCpros)
                MsgAviso("Selecione um produto antes de adicionar linha.", "Aviso")
            ELSE
                THIS.this_oBusinessObject.InserirLinhaCursorLocal(loc_cCpros)

                IF USED("cursor_4c_MaxProduto")
                    GO BOTTOM IN cursor_4c_MaxProduto
                    loc_oGrd = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
                    loc_oGrd.ActivateCell(RECNO("cursor_4c_MaxProduto"), 1)
                    loc_oGrd.Refresh
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em MNovaLinha: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparPage2 - Limpa campos da Page2 (chamado em modo INSERIR)
    *==========================================================================
    PROCEDURE LimparPage2()
        LOCAL loc_oPag2

        TRY
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2

            loc_oPag2.txt_4c__produto.Value     = ""
            loc_oPag2.txt_4c_Dpro.Value         = ""
            loc_oPag2.txt_4c_Cgru.Value         = ""
            loc_oPag2.txt_4c_Dgru.Value         = ""
            loc_oPag2.txt_4c_Ifor.Value         = ""
            loc_oPag2.txt_4c_Dfor.Value         = ""
            loc_oPag2.txt_4c_Refs.Value         = ""
            loc_oPag2.obj_4c_Opc_situacao.Value = 1
            loc_oPag2.grd_4c_Dados.RecordSource = ""

            IF USED("cursor_4c_MaxProduto")
                USE IN cursor_4c_MaxProduto
            ENDIF
        CATCH TO loException
            MsgErro("Erro em LimparPage2: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere campos do form para o Business Object
    * Neste form especial, a edicao acontece no grid (cursor_4c_MaxProduto).
    * FormParaBO captura o produto selecionado e as flags de modo.
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oPag2
        loc_oPag2 = .NULL.

        TRY
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2

            WITH THIS.this_oBusinessObject
                .this_cCpros     = ALLTRIM(loc_oPag2.txt_4c__produto.Value)
                .this_cDpros     = ALLTRIM(loc_oPag2.txt_4c_Dpro.Value)
                .this_cCgrus     = ALLTRIM(loc_oPag2.txt_4c_Cgru.Value)
                .this_cDgrus     = ALLTRIM(loc_oPag2.txt_4c_Dgru.Value)
                .this_cIfors     = ALLTRIM(loc_oPag2.txt_4c_Ifor.Value)
                .this_cRclis     = ALLTRIM(loc_oPag2.txt_4c_Dfor.Value)
                .this_cReffs     = ALLTRIM(loc_oPag2.txt_4c_Refs.Value)
                .this_nSituas    = loc_oPag2.obj_4c_Opc_situacao.Value
                .this_lTemCor    = THIS.this_lTemCor
                .this_lTemTam    = THIS.this_lTemTam
                .this_nTipoEstos = THIS.this_nTipoEstos
            ENDWITH
        CATCH TO loException
            MsgErro("Erro em FormParaBO: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere propriedades do BO para os campos do form
    * Popula os campos de exibicao da Page2 com dados do BO.
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oPag2
        loc_oPag2 = .NULL.

        TRY
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2

            WITH THIS.this_oBusinessObject
                loc_oPag2.txt_4c__produto.Value        = ALLTRIM(.this_cCpros)
                loc_oPag2.txt_4c_Dpro.Value            = ALLTRIM(.this_cDpros)
                loc_oPag2.txt_4c_Cgru.Value            = ALLTRIM(.this_cCgrus)
                loc_oPag2.txt_4c_Dgru.Value            = ALLTRIM(.this_cDgrus)
                loc_oPag2.txt_4c_Ifor.Value            = ALLTRIM(.this_cIfors)
                loc_oPag2.txt_4c_Dfor.Value            = ALLTRIM(.this_cRclis)
                loc_oPag2.txt_4c_Refs.Value            = ALLTRIM(.this_cReffs)
                loc_oPag2.obj_4c_Opc_situacao.Value    = IIF(.this_nSituas = 2, 2, 1)
            ENDWITH
        CATCH TO loException
            MsgErro("Erro em BOParaForm: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos editaveis da Page2
    * par_lHabilitar: .T.=habilitar, .F.=desabilitar
    * Campos de grupo/fornecedor/referencia sempre somente-leitura (When=.F. no legado)
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPag2, loc_lModoInsercao
        loc_oPag2      = .NULL.
        loc_lModoInsercao = .F.

        TRY
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2

            *-- Campo produto: habilitado apenas em INSERIR/PROCURAR sem produto externo
            loc_lModoInsercao = par_lHabilitar AND ;
                                INLIST(THIS.this_cPcEscolha, "INSERIR", "PROCURAR") AND ;
                                EMPTY(THIS.this_cPcCPros)

            loc_oPag2.txt_4c__produto.Enabled = loc_lModoInsercao
            loc_oPag2.txt_4c_Dpro.Enabled     = loc_lModoInsercao AND ;
                                                 EMPTY(ALLTRIM(loc_oPag2.txt_4c__produto.Value))

            *-- Campos somente-leitura (grupo/fornecedor/referencia/situacao): sempre desabilitados
            loc_oPag2.txt_4c_Cgru.Enabled              = .F.
            loc_oPag2.txt_4c_Dgru.Enabled              = .F.
            loc_oPag2.txt_4c_Ifor.Enabled              = .F.
            loc_oPag2.txt_4c_Dfor.Enabled              = .F.
            loc_oPag2.txt_4c_Refs.Enabled              = .F.
            loc_oPag2.obj_4c_Opc_situacao.Enabled      = .F.

            *-- Botao Excluir linha: visivel apenas em INSERIR/ALTERAR
            loc_oPag2.cmd_4c_BtnExcluir.Visible = ;
                INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
        CATCH TO loException
            MsgErro("Erro em HabilitarCampos: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme this_cPcEscolha
    * LISTA: botoes CRUD habilitados, botoes acao Page2 ocultos
    * INSERIR/ALTERAR: botoes acao Page2 habilitados; cmd_4c_BtnExcluir visivel
    * CONSULTAR: grid somente-leitura; cmd_4c_BtnExcluir oculto
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPag2, loc_lEdicao
        loc_oPag2  = .NULL.
        loc_lEdicao = .F.

        TRY
            loc_oPag2   = THIS.pgf_4c_Paginas.Page2
            loc_lEdicao = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")

            *-- Botao Confirmar: sempre habilitado quando na Page2
            loc_oPag2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.

            *-- Botao Cancelar: sempre habilitado
            loc_oPag2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.

            *-- Botao Excluir linha: visivel apenas em edicao
            loc_oPag2.cmd_4c_BtnExcluir.Visible = loc_lEdicao

            *-- Grid editavel/readonly conforme modo
            IF THIS.this_cPcEscolha = "CONSULTAR"
                WITH loc_oPag2.grd_4c_Dados
                    .Column1.ReadOnly = .T.
                    .Column2.ReadOnly = .T.
                    .Column3.ReadOnly = .T.
                    .Column4.ReadOnly = .T.
                    .Column5.ReadOnly = .T.
                ENDWITH
            ELSE
                WITH loc_oPag2.grd_4c_Dados
                    .Column1.ReadOnly = .F.
                    .Column2.ReadOnly = .F.
                    .Column3.ReadOnly = !THIS.this_lTemTam
                    .Column4.ReadOnly = !THIS.this_lTemCor
                    .Column5.ReadOnly = .F.
                ENDWITH
            ENDIF

            THIS.HabilitarCampos(loc_lEdicao)
        CATCH TO loException
            MsgErro("Erro em AjustarBotoesPorModo: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * DESTROY - Limpeza ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        *-- Fechar cursores de dados abertos
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_MaxProduto")
            USE IN cursor_4c_MaxProduto
        ENDIF
        IF USED("cursor_4c_Copia")
            USE IN cursor_4c_Copia
        ENDIF
        IF USED("cursor_4c_Cabecalho")
            USE IN cursor_4c_Cabecalho
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprcomBO.prg):
*==============================================================================
* sigprcomBO.prg - Business Object: Estoque M?ximo
* Tabela: SigCdMax
* PK: cidchaves (CHAR 20 - UUID)
* Autor: Migra??o VFP9 - task165
*==============================================================================

*------------------------------------------------------------------------------
* DEFINE CLASS sigprcomBO AS BusinessBase
*------------------------------------------------------------------------------
DEFINE CLASS sigprcomBO AS BusinessBase

    *-- Propriedades da tabela SigCdMax (schema.sql)
    this_cCidchaves = ""    && cidchaves CHAR(20) PK - UUID
    this_cCpros     = ""    && cpros     CHAR(14) - C?digo do produto
    this_cEmps      = ""    && emps      CHAR(3)  - C?digo da empresa
    this_nQmaxs     = 0     && qmaxs     NUMERIC(7,2) - Qtde. m?xima
    this_cCodtams   = ""    && codtams   CHAR(4)  - C?digo do tamanho
    this_cCodcores  = ""    && codcores  CHAR(4)  - C?digo da cor
    this_cDeptos    = ""    && deptos    CHAR(10) - C?digo do departamento
    this_cOrdems    = ""    && ordems    CHAR(1)  - Ordem

    *-- Propriedades de exibi??o (joins com SigCdPro, SigCdCli, SigCdGrp)
    this_cDpros     = ""    && SigCdPro.dpros   - Descri??o do produto
    this_cIfors     = ""    && SigCdPro.ifors   - C?digo do fornecedor
    this_cReffs     = ""    && SigCdPro.reffs   - Refer?ncia do fornecedor
    this_cCgrus     = ""    && SigCdPro.cgrus   - C?digo do grupo
    this_nSituas    = 1     && SigCdPro.situas  - Situa??o (1=Ativo, 2=Inativo)
    this_cRclis     = ""    && SigCdCli.rclis   - Nome do fornecedor
    this_cDgrus     = ""    && SigCdGrp.dgrus   - Descri??o do grupo

    *-- Flags de configura??o do produto (carregados de SigCdPro/SigCdGrp)
    this_lTemCor    = .F.   && Produto tem controle de cor
    this_lTemTam    = .F.   && Produto tem controle de tamanho
    this_nTipoEstos = 0     && Tipo de estoque (SigCdGrp.tipoestos)

    *--------------------------------------------------------------------------
    * Init - Inicializa??o do BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdMax"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave prim?ria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista produtos com estoque m?ximo (SELECT principal da Page1)
    * par_cFiltro: filtro adicional WHERE (opcional)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF TYPE("par_cFiltro") != "C"
            par_cFiltro = ""
        ENDIF

        TRY
            loc_cSQL = "SELECT a.cpros, b.dpros, b.ifors, b.reffs," + ;
                       " b.cgrus, b.situas, c.rclis, g.dgrus" + ;
                       " FROM SigCdMax a" + ;
                       " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                       " LEFT JOIN SigCdCli c ON b.ifors = c.iclis" + ;
                       " LEFT JOIN SigCdGrp g ON b.cgrus = g.cgrus"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + ;
                       " GROUP BY a.cpros, b.dpros, b.ifors, b.reffs," + ;
                       " b.cgrus, b.situas, c.rclis, g.dgrus"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Dados") = 0
                    GOTO TOP IN cursor_4c_Dados
                ELSE
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar produtos: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarPorProduto - Carrega linhas de SigCdMax para um produto espec?fico
    * Popula cursor_4c_MaxProduto com emps/qmaxs/codtams/codcores/deptos
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPorProduto(par_cCpros)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF TYPE("par_cCpros") != "C" OR EMPTY(ALLTRIM(par_cCpros))
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT cidchaves, emps, qmaxs, codtams, codcores, deptos, ordems" + ;
                       " FROM SigCdMax" + ;
                       " WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCpros)) + ;
                       " ORDER BY emps, codtams, codcores"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxProduto")

            IF loc_nResultado >= 0
                IF !EMPTY(ALLTRIM(par_cCpros))
                    THIS.CarregarFlagsTemCorTam(par_cCpros)
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar estoque m?ximo: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarPorProduto: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCabecalhoProduto - Carrega dados do cabe?alho para um produto
    * Popula cursor_4c_Cabecalho com campos do produto + fornecedor + grupo
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCabecalhoProduto(par_cCpros)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF TYPE("par_cCpros") != "C" OR EMPTY(ALLTRIM(par_cCpros))
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT DISTINCT" + ;
                       " a.cpros, b.dpros, b.ifors, b.reffs," + ;
                       " b.cgrus, b.situas, c.rclis, g.dgrus, a.qmaxs" + ;
                       " FROM SigCdMax a" + ;
                       " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                       " LEFT JOIN SigCdCli c ON b.ifors = c.iclis" + ;
                       " LEFT JOIN SigCdGrp g ON b.cgrus = g.cgrus" + ;
                       " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cCpros))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cabecalho")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Cabecalho") > 0
                    GO TOP IN cursor_4c_Cabecalho
                    SELECT cursor_4c_Cabecalho
                    THIS.this_cCpros   = ALLTRIM(cpros)
                    THIS.this_cDpros   = ALLTRIM(dpros)
                    THIS.this_cIfors   = ALLTRIM(ifors)
                    THIS.this_cRclis   = ALLTRIM(rclis)
                    THIS.this_cReffs   = ALLTRIM(reffs)
                    THIS.this_cCgrus   = ALLTRIM(cgrus)
                    THIS.this_cDgrus   = ALLTRIM(dgrus)
                    THIS.this_nSituas  = NVL(situas, 1)
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar cabe?alho: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarCabecalhoProduto: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega uma linha de SigCdMax pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidchaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF TYPE("par_cCidchaves") != "C" OR EMPTY(ALLTRIM(par_cCidchaves))
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT cidchaves, cpros, emps, qmaxs, codtams," + ;
                       " codcores, deptos, ordems" + ;
                       " FROM SigCdMax" + ;
                       " WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cCidchaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarPorCodigo: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de um cursor
    * REGRA: SEMPRE usar SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
            THIS.this_cCpros     = TratarNulo(cpros,     "C")
            THIS.this_cEmps      = TratarNulo(emps,      "C")
            THIS.this_nQmaxs     = TratarNulo(qmaxs,     "N")
            THIS.this_cCodtams   = TratarNulo(codtams,   "C")
            THIS.this_cCodcores  = TratarNulo(codcores,  "C")
            THIS.this_cDeptos    = TratarNulo(deptos,    "C")
            THIS.this_cOrdems    = TratarNulo(ordems,    "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarFlagsTemCorTam - Verifica se produto tem cor/tamanho ativos
    * Popula this_lTemCor, this_lTemTam, this_nTipoEstos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarFlagsTemCorTam(par_cCpros)
        LOCAL loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        IF TYPE("par_cCpros") != "C" OR EMPTY(ALLTRIM(par_cCpros))
            THIS.this_lTemCor    = .F.
            THIS.this_lTemTam    = .F.
            THIS.this_nTipoEstos = 0
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT b.cores, b.tams, b.tipoestos" + ;
                       " FROM SigCdPro a" + ;
                       " INNER JOIN SigCdGrp b ON b.cgrus = a.cgrus" + ;
                       " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cCpros))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProGru")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ProGru") > 0
                GO TOP IN cursor_4c_ProGru
                SELECT cursor_4c_ProGru
                THIS.this_nTipoEstos = NVL(tipoestos, 0)
                THIS.this_lTemCor = INLIST(THIS.this_nTipoEstos, 2, 4) OR NVL(cores, 0) = 1
                THIS.this_lTemTam = INLIST(THIS.this_nTipoEstos, 3, 4) OR NVL(tams, 0) = 1
                loc_lSucesso = .T.
            ELSE
                THIS.this_lTemCor    = .F.
                THIS.this_lTemTam    = .F.
                THIS.this_nTipoEstos = 0
            ENDIF

            IF USED("cursor_4c_ProGru")
                USE IN cursor_4c_ProGru
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarFlagsTemCorTam: " + loException.Message, "Erro")
            THIS.this_lTemCor    = .F.
            THIS.this_lTemTam    = .F.
            THIS.this_nTipoEstos = 0
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirLinhaCursorLocal - Insere nova linha no cursor local de estoque
    * Usado para adicionar linha vazia no grid (nova empresa)
    *--------------------------------------------------------------------------
    PROCEDURE InserirLinhaCursorLocal(par_cCpros)
        LOCAL loc_lSucesso, loc_cCidchave
        loc_lSucesso = .F.

        IF !USED("cursor_4c_MaxProduto")
            RETURN .F.
        ENDIF

        TRY

            loc_cCidchave = GerarUUID()

            INSERT INTO cursor_4c_MaxProduto ;
                (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos, ordems) ;
                VALUES (loc_cCidchave, par_cCpros, "", 0, "", "", "", "")

            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro("Erro em InserirLinhaCursorLocal: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarUUID - Gera identificador ?nico (substitui fUniqueIds do legado)
    *--------------------------------------------------------------------------
    PROCEDURE GerarUUID()
        RETURN SUBSTR(SYS(3), 1, 20)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir (PROTECTED) - Insere uma linha de SigCdMax no banco
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Gerar cidchaves se vazio
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                THIS.this_cCidchaves = THIS.GerarUUID()
            ENDIF

            loc_cSQL = "INSERT INTO SigCdMax" + ;
                       " (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos, ordems)" + ;
                       " VALUES (" + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cCidchaves), 20)) + "," + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cCpros),     14)) + "," + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cEmps),       3)) + "," + ;
                       FormatarNumeroSQL(THIS.this_nQmaxs)                  + "," + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cCodtams),    4)) + "," + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cCodcores),   4)) + "," + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cDeptos),    10)) + "," + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cOrdems),     1)) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Inserir: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar (PROTECTED) - Atualiza uma linha de SigCdMax no banco
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdMax SET" + ;
                       " emps    = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cEmps),     3)) + "," + ;
                       " qmaxs   = " + FormatarNumeroSQL(THIS.this_nQmaxs)               + "," + ;
                       " codtams = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCodtams),  4)) + "," + ;
                       " codcores= " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCodcores), 4)) + "," + ;
                       " deptos  = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cDeptos),  10)) + "," + ;
                       " ordems  = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cOrdems),   1)) + ;
                       " WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Atualizar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao (PROTECTED) - Remove todas as linhas de um produto
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cCidchaves)) AND EMPTY(ALLTRIM(THIS.this_cCpros))
            MsgAviso("Nenhum registro selecionado para exclus" + CHR(227) + "o!")
            RETURN .F.
        ENDIF

        TRY

            *-- Excluir pelo cidchaves (linha espec?fica)
            IF !EMPTY(ALLTRIM(THIS.this_cCidchaves))
                loc_cSQL = "DELETE FROM SigCdMax" + ;
                           " WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))
            ELSE
                *-- Excluir todas as linhas do produto
                loc_cSQL = "DELETE FROM SigCdMax" + ;
                           " WHERE cpros = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCpros), 14))
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ExecutarExclusao: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarGridEstoque - Persiste o cursor_4c_MaxProduto no banco (UPDATE/INSERT)
    * Chamado ao salvar o grid de estoque m?ximo por produto
    *--------------------------------------------------------------------------
    PROCEDURE SalvarGridEstoque(par_cCpros)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        IF TYPE("par_cCpros") != "C" OR EMPTY(ALLTRIM(par_cCpros))
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_MaxProduto")
            RETURN .F.
        ENDIF

        TRY
            *-- Remover linhas vazias (sem empresa) antes de salvar
            loc_cSQL = "DELETE FROM SigCdMax" + ;
                       " WHERE cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCpros), 14)) + ;
                       " AND emps = '   '"
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Iterar sobre o cursor e salvar cada linha
            SELECT cursor_4c_MaxProduto
            GO TOP

            DO WHILE !EOF("cursor_4c_MaxProduto")
                SELECT cursor_4c_MaxProduto

                IF !EMPTY(ALLTRIM(emps))
                    THIS.this_cCidchaves = ALLTRIM(cidchaves)
                    THIS.this_cCpros     = PADR(ALLTRIM(par_cCpros), 14)
                    THIS.this_cEmps      = ALLTRIM(emps)
                    THIS.this_nQmaxs     = NVL(qmaxs, 0)
                    THIS.this_cCodtams   = ALLTRIM(codtams)
                    THIS.this_cCodcores  = ALLTRIM(codcores)
                    THIS.this_cDeptos    = ALLTRIM(deptos)
                    THIS.this_cOrdems    = ALLTRIM(ordems)

                    *-- Verificar se j? existe no banco
                    LOCAL loc_nCheck
                    loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdMax" + ;
                               " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
                    loc_nCheck = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Check")

                    LOCAL loc_lExiste
                    loc_lExiste = .F.
                    IF loc_nCheck >= 0 AND RECCOUNT("cursor_4c_Check") > 0
                        SELECT cursor_4c_Check
                        loc_lExiste = (NVL(qtd, 0) > 0)
                    ENDIF

                    IF USED("cursor_4c_Check")
                        USE IN cursor_4c_Check
                    ENDIF

                    IF loc_lExiste
                        THIS.this_lNovoRegistro = .F.
                    ELSE
                        THIS.this_lNovoRegistro = .T.
                        IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                            THIS.this_cCidchaves = THIS.GerarUUID()
                        ENDIF
                    ENDIF

                    IF !THIS.Salvar()
                        loc_lSucesso = .F.
                        EXIT
                    ENDIF
                ENDIF

                SELECT cursor_4c_MaxProduto
                SKIP
            ENDDO

            loc_lSucesso = .T.
            THIS.RegistrarAuditoria("SAVE_GRID")
        CATCH TO loException
            MsgErro("Erro em SalvarGridEstoque: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirLinhaEmpresa - Remove linha de estoque m?ximo de uma empresa
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirLinhaEmpresa(par_cCpros, par_cEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF TYPE("par_cCpros") != "C" OR EMPTY(ALLTRIM(par_cCpros))
            RETURN .F.
        ENDIF

        TRY
            IF EMPTY(ALLTRIM(par_cEmps))
                *-- Excluir todas as linhas do produto sem empresa
                loc_cSQL = "DELETE FROM SigCdMax" + ;
                           " WHERE cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCpros), 14)) + ;
                           " AND RTRIM(emps) = ''"
            ELSE
                *-- Excluir linhas da empresa espec?fica
                loc_cSQL = "DELETE FROM SigCdMax" + ;
                           " WHERE cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCpros), 14)) + ;
                           " AND emps = " + EscaparSQL(PADR(ALLTRIM(par_cEmps), 3))
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir empresa: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ExcluirLinhaEmpresa: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarEstoqueProduto - Copia registros de estoque entre empresas
    * par_cCpros: produto a copiar (vazio = todos)
    * par_cEmpO: empresa de origem
    * par_cEmpD: empresa de destino
    * Retorna n?mero de registros copiados
    *--------------------------------------------------------------------------
    PROCEDURE CopiarEstoqueProduto(par_cCpros, par_cEmpO, par_cEmpD)
        LOCAL loc_cSQL, loc_nResultado, loc_nCopiados, loc_lSucesso
        loc_lSucesso  = .F.
        loc_nCopiados = 0

        IF EMPTY(ALLTRIM(par_cEmpO)) OR EMPTY(ALLTRIM(par_cEmpD))
            MsgErro("Empresa origem e destino s" + CHR(227) + "o obrigat" + CHR(243) + "rias!", "Aviso")
            RETURN .F.
        ENDIF

        IF ALLTRIM(par_cEmpO) = ALLTRIM(par_cEmpD)
            MsgErro("Empresa destino n" + CHR(227) + "o pode ser igual " + CHR(224) + " empresa origem!", "Aviso")
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_Copia")
            RETURN .F.
        ENDIF

        TRY
            SELECT cursor_4c_Copia
            GO TOP

            DO WHILE !EOF("cursor_4c_Copia")
                SELECT cursor_4c_Copia

                IF NVL(marcas, 0) = 1 AND NVL(existes, 0) = 0
                    LOCAL loc_cNovoId
                    loc_cNovoId = THIS.GerarUUID()

                    loc_cSQL = "INSERT INTO SigCdMax" + ;
                               " (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos, ordems)" + ;
                               " VALUES (" + ;
                               EscaparSQL(loc_cNovoId)                              + "," + ;
                               EscaparSQL(PADR(ALLTRIM(cpros),       14))           + "," + ;
                               EscaparSQL(PADR(ALLTRIM(par_cEmpD),    3))           + "," + ;
                               FormatarNumeroSQL(NVL(qmaxs, 0))                     + "," + ;
                               EscaparSQL(PADR(ALLTRIM(codtams),      4))           + "," + ;
                               EscaparSQL(PADR(ALLTRIM(codcores),     4))           + "," + ;
                               EscaparSQL(PADR(ALLTRIM(deptos),      10))           + "," + ;
                               EscaparSQL(" ")                                      + ;
                               ")"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        loc_nCopiados = loc_nCopiados + 1
                    ENDIF
                ENDIF

                SKIP
            ENDDO

            loc_lSucesso = .T.
            THIS.RegistrarAuditoria("COPY")
        CATCH TO loException
            MsgErro("Erro em CopiarEstoqueProduto: " + loException.Message, "Erro")
        ENDTRY

        *-- Retornar n?mero de copiados via propriedade
        THIS.this_nQmaxs = loc_nCopiados

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCursorCopia - Carrega cursor_4c_Copia para copiar entre empresas
    * Mostra quais produtos existem na origem e compara com o destino
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCursorCopia(par_cCpros, par_cEmpO, par_cEmpD)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(par_cEmpO)) OR EMPTY(ALLTRIM(par_cEmpD))
            RETURN .F.
        ENDIF

        TRY
            *-- Union: nao existem no destino | existem em ambos | existem no destino mas nao na origem
            loc_cSQL = "SELECT 1 AS marcas, 0 AS existes," + ;
                       " a.cpros, a.emps, a.qmaxs, a.codtams, a.codcores, a.deptos, a.cidchaves" + ;
                       " FROM SigCdMax a" + ;
                       " WHERE a.emps = " + EscaparSQL(PADR(ALLTRIM(par_cEmpO), 3))

            IF !EMPTY(ALLTRIM(par_cCpros))
                loc_cSQL = loc_cSQL + " AND a.cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCpros), 14))
            ENDIF

            loc_cSQL = loc_cSQL + ;
                       " AND (a.cpros + a.codtams + a.codcores) NOT IN (" + ;
                       " SELECT b.cpros + b.codtams + b.codcores FROM SigCdMax b" + ;
                       " WHERE b.emps = " + EscaparSQL(PADR(ALLTRIM(par_cEmpD), 3)) + ")" + ;
                       " UNION ALL" + ;
                       " SELECT 0 AS marcas, 1 AS existes," + ;
                       " a.cpros, a.emps, a.qmaxs, a.codtams, a.codcores, a.deptos, a.cidchaves" + ;
                       " FROM SigCdMax a" + ;
                       " WHERE a.emps = " + EscaparSQL(PADR(ALLTRIM(par_cEmpO), 3))

            IF !EMPTY(ALLTRIM(par_cCpros))
                loc_cSQL = loc_cSQL + " AND a.cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCpros), 14))
            ENDIF

            loc_cSQL = loc_cSQL + ;
                       " AND a.cpros + a.codtams + a.codcores IN (" + ;
                       " SELECT b.cpros + b.codtams + b.codcores FROM SigCdMax b" + ;
                       " WHERE b.emps = " + EscaparSQL(PADR(ALLTRIM(par_cEmpD), 3)) + ")" + ;
                       " UNION ALL" + ;
                       " SELECT 0 AS marcas, 2 AS existes," + ;
                       " a.cpros, a.emps, a.qmaxs, a.codtams, a.codcores, a.deptos, a.cidchaves" + ;
                       " FROM SigCdMax a" + ;
                       " WHERE a.emps = " + EscaparSQL(PADR(ALLTRIM(par_cEmpD), 3))

            IF !EMPTY(ALLTRIM(par_cCpros))
                loc_cSQL = loc_cSQL + " AND a.cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCpros), 14))
            ENDIF

            loc_cSQL = loc_cSQL + ;
                       " AND a.cpros + a.codtams + a.codcores NOT IN (" + ;
                       " SELECT b.cpros + b.codtams + b.codcores FROM SigCdMax b" + ;
                       " WHERE b.emps = " + EscaparSQL(PADR(ALLTRIM(par_cEmpO), 3)) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Copia")

            IF loc_nResultado >= 0
                GO TOP IN cursor_4c_Copia
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar c" + CHR(243) + "pia: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarCursorCopia: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodosParaCopia - Marca/desmarca todos registros do cursor_4c_Copia
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodosParaCopia(par_lMarcar)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED("cursor_4c_Copia")
            RETURN .F.
        ENDIF

        TRY
            LOCAL loc_nMarca
            loc_nMarca = IIF(par_lMarcar, 1, 0)

            UPDATE cursor_4c_Copia SET marcas = loc_nMarca WHERE existes = 0

            GO TOP IN cursor_4c_Copia
            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro("Erro em MarcarTodosParaCopia: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

