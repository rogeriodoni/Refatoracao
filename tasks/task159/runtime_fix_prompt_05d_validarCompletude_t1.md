# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[Formsigprccp.prg] Procedure vazia (sem codigo): BtnIncluirClick
[Formsigprccp.prg] Procedure vazia (sem codigo): BtnAlterarClick
[Formsigprccp.prg] Procedure vazia (sem codigo): BtnVisualizarClick
[Formsigprccp.prg] Procedure vazia (sem codigo): BtnExcluirClick
[Formsigprccp.prg] Procedure vazia (sem codigo): AlternarPagina
[Formsigprccp.prg] Procedure vazia (sem codigo): BtnBuscarClick
[Formsigprccp.prg] Procedure vazia (sem codigo): CarregarLista
[Formsigprccp.prg] Indicador de pendencia: *-- Campos dependente

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprccp.prg):
*=============================================================================
* Formsigprccp.prg
* Rec" + CHR(225) + "lculo de Pre" + CHR(231) + "os (SIGPRCCP)
* Tipo: OPERACIONAL - layout flat customizado (sem PageFrame)
* Migrado de: SIGPRCCP.SCX
*=============================================================================

DEFINE CLASS Formsigprccp AS FormBase

    *-- Propriedades visuais
    Height      = 600
    Width       = 1000
    Caption     = "Rec" + CHR(225) + "lculo de Pre" + CHR(231) + "os"
    AutoCenter  = .T.
    BorderStyle = 2
    TitleBar    = 0
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    ShowTips    = .T.
    KeyPreview  = .T.

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""
    this_lAutomatico     = .F.

    *==========================================================================
    PROCEDURE Init(par_lAutomatico)
    *==========================================================================
        IF PCOUNT() > 0
            THIS.this_lAutomatico = par_lAutomatico
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigprccpBO")
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigprccp.", "Erro")
            ELSE
                *-- Configurar base visual do form (equivalente ao PageFrame em CRUD)
                THIS.ConfigurarPageFrame()

                *-- Inicializar cursores do BO
                THIS.this_oBusinessObject.CarregarDadosAuxiliares()
                THIS.this_oBusinessObject.CriarCursorDados()

                *-- Construir interface
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarFiltros()
                THIS.ConfigurarOpcoes()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarBotoes()
                THIS.TornarControlesVisiveis()
                THIS.ConfigurarBINDEVENTs()
                THIS.InicializarValores()

                *-- Modo automatico
                IF THIS.this_lAutomatico
                    THIS.this_oBusinessObject.this_lAutomatico = .T.
                    THIS.this_oBusinessObject.ProcessaAutomatico()
                    THIS.grd_4c_Produto.Refresh
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Configura a base visual do form
    * Form OPERACIONAL: layout FLAT (sem PageFrame). Este metodo configura
    * as propriedades base do form (Picture, BackColor, ClipControls) que em
    * um form CRUD estariam num PageFrame com Page1/Page2.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
        THIS.Picture     = gc_4c_CaminhoBase + "..\..\..\Framework\imagens\new_background.jpg"
        THIS.BackColor   = RGB(255, 255, 255)
        THIS.ClipControls = .F.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
    *==========================================================================
        LOCAL loc_oCnt
        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra
        WITH loc_oCnt
            .Top        = 0
            .Left       = 0
            .Width      = THIS.Width
            .Height     = 80
            .BorderWidth= 0
            .BackColor  = RGB(100,100,100)
            .Visible    = .T.
            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .AutoSize      = .F.
                .BackStyle     = 0
                .Caption       = THIS.Parent.Caption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width
                .ForeColor     = RGB(0,0,0)
                .Visible       = .T.
            ENDWITH
            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .AutoSize   = .F.
                .BackStyle  = 0
                .Caption    = THIS.Parent.Caption
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = THIS.Width
                .ForeColor  = RGB(255,255,255)
                .Visible    = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltros
    *==========================================================================
        LOCAL loc_o

        *-- Label "Filtros" (titulo secao)
        THIS.AddObject("lbl_4c_SecFiltros", "Label")
        WITH THIS.lbl_4c_SecFiltros
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 12
            .BackStyle = 0
            .Caption   = "Filtros"
            .Height    = 21
            .Left      = 11
            .Top       = 94
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        *-- ----------------------------------------------------------------
        *-- ROW 1: Fornecedor (Top=88)
        *-- ----------------------------------------------------------------
        THIS.AddObject("lbl_4c_Fornecedor", "Label")
        WITH THIS.lbl_4c_Fornecedor
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Fornecedor :"
            .Height    = 15
            .Left      = 79
            .Top       = 92
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CFornecs", "TextBox")
        WITH THIS.txt_4c_CFornecs
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderStyle   = 1
            .Format        = "K!"
            .Height        = 23
            .Left          = 145
            .MaxLength     = 10
            .SpecialEffect = 1
            .Top           = 88
            .Width         = 80
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DFornecs", "TextBox")
        WITH THIS.txt_4c_DFornecs
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 23
            .Left          = 228
            .MaxLength     = 40
            .SpecialEffect = 1
            .Top           = 88
            .Width         = 197
            .ReadOnly      = .T.
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- ----------------------------------------------------------------
        *-- ROW 2: Grande Grupo (Top=113)
        *-- ----------------------------------------------------------------
        THIS.AddObject("lbl_4c_MercI", "Label")
        WITH THIS.lbl_4c_MercI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Grande Grupo :"
            .Height    = 15
            .Left      = 67
            .Top       = 117
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_MercI", "TextBox")
        WITH THIS.txt_4c_MercI
            .BorderStyle   = 1
            .Height        = 23
            .Left          = 145
            .MaxLength     = 3
            .SpecialEffect = 1
            .Top           = 113
            .Width         = 31
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_AteMercI", "Label")
        WITH THIS.lbl_4c_AteMercI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .Left      = 179
            .Top       = 117
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_MercF", "TextBox")
        WITH THIS.txt_4c_MercF
            .BorderStyle   = 1
            .Height        = 23
            .Left          = 198
            .MaxLength     = 3
            .SpecialEffect = 1
            .Top           = 113
            .Width         = 31
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- ----------------------------------------------------------------
        *-- ROW 3: Grupo (Top=138)
        *-- ----------------------------------------------------------------
        THIS.AddObject("lbl_4c_CGrui", "Label")
        WITH THIS.lbl_4c_CGrui
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Grupo :"
            .Height    = 15
            .Left      = 105
            .Top       = 142
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CGrui", "TextBox")
        WITH THIS.txt_4c_CGrui
            .BorderStyle   = 1
            .Height        = 23
            .Left          = 145
            .MaxLength     = 3
            .SpecialEffect = 1
            .Top           = 138
            .Width         = 31
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_AteCGrui", "Label")
        WITH THIS.lbl_4c_AteCGrui
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .Left      = 179
            .Top       = 142
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CGruf", "TextBox")
        WITH THIS.txt_4c_CGruf
            .BorderStyle   = 1
            .Height        = 23
            .Left          = 198
            .MaxLength     = 3
            .SpecialEffect = 1
            .Top           = 138
            .Width         = 31
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- ----------------------------------------------------------------
        *-- ROW 4: Subgrupo (Top=163)
        *-- ----------------------------------------------------------------
        THIS.AddObject("lbl_4c_SGruI", "Label")
        WITH THIS.lbl_4c_SGruI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Subgrupo :"
            .Height    = 15
            .Left      = 88
            .Top       = 167
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_SGruI", "TextBox")
        WITH THIS.txt_4c_SGruI
            .BorderStyle   = 1
            .Height        = 23
            .Left          = 145
            .MaxLength     = 6
            .SpecialEffect = 1
            .Top           = 163
            .Width         = 52
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_AteSGruI", "Label")
        WITH THIS.lbl_4c_AteSGruI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .Left      = 201
            .Top       = 167
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_SGruF", "TextBox")
        WITH THIS.txt_4c_SGruF
            .BorderStyle   = 1
            .Height        = 23
            .Left          = 220
            .MaxLength     = 6
            .SpecialEffect = 1
            .Top           = 163
            .Width         = 52
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- ----------------------------------------------------------------
        *-- ROW 5: Unidade (Top=189)
        *-- ----------------------------------------------------------------
        THIS.AddObject("lbl_4c_CUniI", "Label")
        WITH THIS.lbl_4c_CUniI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Unidade :"
            .Height    = 15
            .Left      = 95
            .Top       = 193
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CUniI", "TextBox")
        WITH THIS.txt_4c_CUniI
            .BorderStyle   = 1
            .Height        = 23
            .Left          = 145
            .MaxLength     = 3
            .SpecialEffect = 1
            .Top           = 189
            .Width         = 31
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_AteCUniI", "Label")
        WITH THIS.lbl_4c_AteCUniI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .Left      = 179
            .Top       = 193
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CUnif", "TextBox")
        WITH THIS.txt_4c_CUnif
            .BorderStyle   = 1
            .Height        = 23
            .Left          = 198
            .MaxLength     = 3
            .SpecialEffect = 1
            .Top           = 189
            .Width         = 31
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- ----------------------------------------------------------------
        *-- ROW 6: Moeda (Top=213)
        *-- ----------------------------------------------------------------
        THIS.AddObject("lbl_4c_MoeI", "Label")
        WITH THIS.lbl_4c_MoeI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Moeda :"
            .Height    = 15
            .Left      = 102
            .Top       = 217
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_MoeI", "TextBox")
        WITH THIS.txt_4c_MoeI
            .BorderStyle   = 1
            .Height        = 23
            .Left          = 145
            .MaxLength     = 3
            .SpecialEffect = 1
            .Top           = 213
            .Width         = 31
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_AteMoeI", "Label")
        WITH THIS.lbl_4c_AteMoeI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .Left      = 179
            .Top       = 217
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_MoeF", "TextBox")
        WITH THIS.txt_4c_MoeF
            .BorderStyle   = 1
            .Height        = 23
            .Left          = 198
            .MaxLength     = 3
            .SpecialEffect = 1
            .Top           = 213
            .Width         = 31
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- ----------------------------------------------------------------
        *-- RIGHT COLUMN: Linha (Top=88)
        *-- ----------------------------------------------------------------
        THIS.AddObject("lbl_4c_LinhI", "Label")
        WITH THIS.lbl_4c_LinhI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Linha :"
            .Height    = 15
            .Left      = 503
            .Top       = 92
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_LinhI", "TextBox")
        WITH THIS.txt_4c_LinhI
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 23
            .Left          = 539
            .MaxLength     = 10
            .SpecialEffect = 1
            .Top           = 88
            .Width         = 84
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_AteLinhI", "Label")
        WITH THIS.lbl_4c_AteLinhI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .Left      = 627
            .Top       = 92
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_LinhF", "TextBox")
        WITH THIS.txt_4c_LinhF
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 23
            .Left          = 649
            .MaxLength     = 10
            .SpecialEffect = 1
            .Top           = 88
            .Width         = 84
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- RIGHT COLUMN: Grupo Venda/Colecao (Top=113)
        THIS.AddObject("lbl_4c_ColI", "Label")
        WITH THIS.lbl_4c_ColI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Grupo Venda :"
            .Height    = 15
            .Left      = 466
            .Top       = 117
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_ColI", "TextBox")
        WITH THIS.txt_4c_ColI
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 23
            .Left          = 539
            .MaxLength     = 10
            .SpecialEffect = 1
            .Top           = 113
            .Width         = 84
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_AteColI", "Label")
        WITH THIS.lbl_4c_AteColI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .Left      = 627
            .Top       = 117
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_ColF", "TextBox")
        WITH THIS.txt_4c_ColF
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 23
            .Left          = 649
            .MaxLength     = 10
            .SpecialEffect = 1
            .Top           = 113
            .Width         = 84
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- RIGHT COLUMN: Markup (Top=138)
        THIS.AddObject("lbl_4c_MrkI", "Label")
        WITH THIS.lbl_4c_MrkI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Markup :"
            .Height    = 15
            .Left      = 493
            .Top       = 142
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_MrkI", "TextBox")
        WITH THIS.txt_4c_MrkI
            .Alignment     = 3
            .BorderStyle   = 1
            .Value         = 0
            .Format        = "K"
            .Height        = 23
            .InputMask     = "999.99"
            .Left          = 539
            .MaxLength     = 0
            .SpecialEffect = 1
            .Top           = 138
            .Width         = 84
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_AteMrkI", "Label")
        WITH THIS.lbl_4c_AteMrkI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .Left      = 627
            .Top       = 142
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_MrkF", "TextBox")
        WITH THIS.txt_4c_MrkF
            .Alignment     = 3
            .BorderStyle   = 1
            .Value         = 0
            .Format        = "K"
            .Height        = 23
            .InputMask     = "999.99"
            .Left          = 649
            .MaxLength     = 0
            .SpecialEffect = 1
            .Top           = 138
            .Width         = 84
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- RIGHT COLUMN: Encargo (Top=163)
        THIS.AddObject("lbl_4c_EncI", "Label")
        WITH THIS.lbl_4c_EncI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Encargo :"
            .Height    = 15
            .Left      = 486
            .Top       = 167
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_EncI", "TextBox")
        WITH THIS.txt_4c_EncI
            .Alignment     = 3
            .BorderStyle   = 1
            .Value         = 0
            .Format        = "K"
            .Height        = 23
            .InputMask     = "999.99"
            .Left          = 539
            .MaxLength     = 0
            .SpecialEffect = 1
            .Top           = 163
            .Width         = 84
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_AteEncI", "Label")
        WITH THIS.lbl_4c_AteEncI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .Left      = 627
            .Top       = 167
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_EncF", "TextBox")
        WITH THIS.txt_4c_EncF
            .Alignment     = 3
            .BorderStyle   = 1
            .Value         = 0
            .Format        = "K"
            .Height        = 23
            .InputMask     = "999.99"
            .Left          = 649
            .MaxLength     = 0
            .SpecialEffect = 1
            .Top           = 163
            .Width         = 84
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- RIGHT COLUMN: Variacao % + Feitio (Top=189)
        THIS.AddObject("lbl_4c_Variacao", "Label")
        WITH THIS.lbl_4c_Variacao
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Varia" + CHR(231) + CHR(227) + "o ( % ) : "
            .Height    = 15
            .Left      = 456
            .Top       = 193
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Variacao", "TextBox")
        WITH THIS.txt_4c_Variacao
            .Alignment     = 3
            .BorderStyle   = 1
            .Value         = 0
            .Format        = "K"
            .Height        = 23
            .InputMask     = "999.99"
            .Left          = 539
            .MaxLength     = 0
            .SpecialEffect = 1
            .Top           = 189
            .Width         = 80
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Feitio", "Label")
        WITH THIS.lbl_4c_Feitio
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "C" + CHR(243) + "digo MKP : "
            .Height    = 15
            .Left      = 639
            .Top       = 193
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Feitio", "TextBox")
        WITH THIS.txt_4c_Feitio
            .BorderStyle   = 1
            .Height        = 23
            .Left          = 709
            .MaxLength     = 2
            .SpecialEffect = 1
            .Top           = 189
            .Width         = 24
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarOpcoes
    *==========================================================================
        *-- OptionGroup Ideal/Venda (fwoption1) em (Left=234, Top=211)
        THIS.AddObject("opg_4c_OpcaoM", "OptionGroup")
        WITH THIS.opg_4c_OpcaoM
            .ButtonCount = 2
            .Value       = 1
            .Height      = 26
            .Left        = 234
            .Top         = 211
            .Width       = 106
            .BackStyle   = 0
            .Visible     = .T.
            .Buttons(1).Caption     = "\<Ideal"
            .Buttons(1).Left        = 5
            .Buttons(1).Top         = 5
            .Buttons(1).AutoSize    = .T.
            .Buttons(1).Themes      = .F.
            .Buttons(2).Caption     = "\<Venda"
            .Buttons(2).Left        = 53
            .Buttons(2).Top         = 6
            .Buttons(2).AutoSize    = .T.
            .Buttons(2).Themes      = .F.
        ENDWITH

        *-- OptionGroup Situacao (Left=536, Top=214)
        THIS.AddObject("lbl_4c_Situacao", "Label")
        WITH THIS.lbl_4c_Situacao
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
            .Left      = 486
            .Top       = 217
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("opg_4c_Situacao", "OptionGroup")
        WITH THIS.opg_4c_Situacao
            .ButtonCount = 3
            .Value       = 3
            .Height      = 21
            .Left        = 536
            .Top         = 214
            .Width       = 189
            .BackStyle   = 0
            .Visible     = .T.
            .Buttons(1).Caption     = "\<Ativos"
            .Buttons(1).Left        = 5
            .Buttons(1).Top         = 3
            .Buttons(1).AutoSize    = .T.
            .Buttons(1).Themes      = .F.
            .Buttons(2).Caption     = "\<Inativos"
            .Buttons(2).Left        = 59
            .Buttons(2).Top         = 2
            .Buttons(2).AutoSize    = .F.
            .Buttons(2).Themes      = .F.
            .Buttons(3).FontName    = "Tahoma"
            .Buttons(3).FontSize    = 8
            .Buttons(3).Caption     = "\<Todos"
            .Buttons(3).Height      = 17
            .Buttons(3).Left        = 125
            .Buttons(3).Top         = 2
            .Buttons(3).Width       = 61
            .Buttons(3).AutoSize    = .F.
            .Buttons(3).ForeColor   = RGB(90,90,90)
            .Buttons(3).Themes      = .F.
        ENDWITH

        *-- OptionGroup Compra (Left=536, Top=234)
        THIS.AddObject("lbl_4c_Compra", "Label")
        WITH THIS.lbl_4c_Compra
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Compra :"
            .Left      = 490
            .Top       = 237
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("opg_4c_Compra", "OptionGroup")
        WITH THIS.opg_4c_Compra
            .ButtonCount = 3
            .Value       = 3
            .Height      = 21
            .Left        = 536
            .Top         = 234
            .Width       = 204
            .BackStyle   = 0
            .Visible     = .T.
            .Buttons(1).Caption     = "\<Comprar"
            .Buttons(1).Left        = 5
            .Buttons(1).Top         = 3
            .Buttons(1).AutoSize    = .T.
            .Buttons(1).Themes      = .F.
            .Buttons(2).Caption     = "\<N" + CHR(227) + "o Comprar"
            .Buttons(2).Left        = 67
            .Buttons(2).Top         = 3
            .Buttons(2).AutoSize    = .T.
            .Buttons(2).Themes      = .F.
            .Buttons(3).FontName    = "Tahoma"
            .Buttons(3).FontSize    = 8
            .Buttons(3).Caption     = "\<Todos"
            .Buttons(3).Height      = 17
            .Buttons(3).Left        = 152
            .Buttons(3).Top         = 2
            .Buttons(3).Width       = 61
            .Buttons(3).ForeColor   = RGB(90,90,90)
            .Buttons(3).AutoSize    = .F.
            .Buttons(3).Themes      = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados
    *==========================================================================
        *-- Linha separadora
        THIS.AddObject("lin_4c_Sep", "Line")
        WITH THIS.lin_4c_Sep
            .Height = 0
            .Left   = 13
            .Top    = 258
            .Width  = 738
            .Visible= .T.
        ENDWITH

        *-- Label "Dados" (titulo secao)
        THIS.AddObject("lbl_4c_SecDados", "Label")
        WITH THIS.lbl_4c_SecDados
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 12
            .BackStyle = 0
            .Caption   = "Dados"
            .Height    = 21
            .Left      = 12
            .Top       = 270
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        *-- Label "Recalcula :" e OptionGroup Recalc (8 opcoes)
        THIS.AddObject("lbl_4c_Recalcula", "Label")
        WITH THIS.lbl_4c_Recalcula
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Recalcula :"
            .Left      = 89
            .Top       = 263
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("opg_4c_Recalc", "OptionGroup")
        WITH THIS.opg_4c_Recalc
            .ButtonCount = 8
            .Value       = 1
            .Height      = 41
            .Left        = 142
            .Top         = 258
            .Width       = 439
            .BackStyle   = 0
            .Visible     = .T.
            *-- Row 1: Composicao, Custo Venda, Ambos, Peso Componentes
            .Buttons(1).FontName    = "Tahoma"
            .Buttons(1).FontSize    = 8
            .Buttons(1).Caption     = "\<Composi" + CHR(231) + CHR(227) + "o"
            .Buttons(1).Left        = 5
            .Buttons(1).Top         = 5
            .Buttons(1).AutoSize    = .T.
            .Buttons(1).ForeColor   = RGB(90,90,90)
            .Buttons(1).Themes      = .F.
            .Buttons(2).FontName    = "Tahoma"
            .Buttons(2).FontSize    = 8
            .Buttons(2).Caption     = "Custo \<Venda"
            .Buttons(2).Left        = 98
            .Buttons(2).Top         = 5
            .Buttons(2).AutoSize    = .T.
            .Buttons(2).ForeColor   = RGB(90,90,90)
            .Buttons(2).Themes      = .F.
            .Buttons(3).FontName    = "Tahoma"
            .Buttons(3).FontSize    = 8
            .Buttons(3).Caption     = "\<Ambos"
            .Buttons(3).Height      = 15
            .Buttons(3).Left        = 213
            .Buttons(3).Top         = 5
            .Buttons(3).Width       = 50
            .Buttons(3).AutoSize    = .T.
            .Buttons(3).ForeColor   = RGB(90,90,90)
            .Buttons(3).Themes      = .F.
            .Buttons(4).FontName    = "Tahoma"
            .Buttons(4).FontSize    = 8
            .Buttons(4).Caption     = "Peso Componentes"
            .Buttons(4).Height      = 15
            .Buttons(4).Left        = 312
            .Buttons(4).Top         = 4
            .Buttons(4).Width       = 110
            .Buttons(4).AutoSize    = .T.
            .Buttons(4).ForeColor   = RGB(90,90,90)
            .Buttons(4).Themes      = .F.
            *-- Row 2: Cambio, Cambio Inteiros, Markup Custo, Markup Venda
            .Buttons(5).FontName    = "Tahoma"
            .Buttons(5).FontSize    = 8
            .Buttons(5).Caption     = "C" + CHR(226) + "m\<bio"
            .Buttons(5).Height      = 15
            .Buttons(5).Left        = 5
            .Buttons(5).Top         = 23
            .Buttons(5).Width       = 53
            .Buttons(5).AutoSize    = .T.
            .Buttons(5).ForeColor   = RGB(90,90,90)
            .Buttons(5).Themes      = .F.
            .Buttons(6).FontName    = "Tahoma"
            .Buttons(6).FontSize    = 8
            .Buttons(6).Caption     = "C" + CHR(226) + "mbio (Inteiros)"
            .Buttons(6).Height      = 15
            .Buttons(6).Left        = 98
            .Buttons(6).Top         = 23
            .Buttons(6).Width       = 101
            .Buttons(6).AutoSize    = .T.
            .Buttons(6).ForeColor   = RGB(90,90,90)
            .Buttons(6).Themes      = .F.
            .Buttons(7).FontName    = "Tahoma"
            .Buttons(7).FontSize    = 8
            .Buttons(7).Caption     = "Markup Custo"
            .Buttons(7).Height      = 15
            .Buttons(7).Left        = 213
            .Buttons(7).Top         = 23
            .Buttons(7).Width       = 84
            .Buttons(7).AutoSize    = .T.
            .Buttons(7).ForeColor   = RGB(90,90,90)
            .Buttons(7).Themes      = .F.
            .Buttons(8).FontName    = "Tahoma"
            .Buttons(8).FontSize    = 8
            .Buttons(8).Caption     = "Markup Venda"
            .Buttons(8).Height      = 15
            .Buttons(8).Left        = 312
            .Buttons(8).Top         = 22
            .Buttons(8).Width       = 86
            .Buttons(8).AutoSize    = .T.
            .Buttons(8).ForeColor   = RGB(90,90,90)
            .Buttons(8).Themes      = .F.
        ENDWITH

        *-- Reajuste (Left=148, Top=300)
        THIS.AddObject("lbl_4c_Reajuste", "Label")
        WITH THIS.lbl_4c_Reajuste
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Reajuste :"
            .Height    = 15
            .Left      = 91
            .Top       = 304
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Reajuste", "TextBox")
        WITH THIS.txt_4c_Reajuste
            .Alignment     = 3
            .BorderStyle   = 1
            .Value         = 0
            .Format        = "K"
            .Height        = 23
            .InputMask     = "999,999.999"
            .Left          = 148
            .MaxLength     = 0
            .SpecialEffect = 1
            .Top           = 300
            .Width         = 80
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- Novo Markup % (Left=148, Top=326)
        THIS.AddObject("lbl_4c_NMrk", "Label")
        WITH THIS.lbl_4c_NMrk
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Novo Markup :"
            .Height    = 15
            .Left      = 71
            .Top       = 330
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_NMrk", "TextBox")
        WITH THIS.txt_4c_NMrk
            .Alignment     = 3
            .BorderStyle   = 1
            .Value         = 0
            .Format        = "K"
            .Height        = 23
            .InputMask     = "999,999.99"
            .Left          = 148
            .MaxLength     = 0
            .SpecialEffect = 1
            .Top           = 326
            .Width         = 80
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- Novo Encargo (Left=326, Top=300)
        THIS.AddObject("lbl_4c_Encargo", "Label")
        WITH THIS.lbl_4c_Encargo
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Novo Encargo : "
            .Height    = 15
            .Left      = 245
            .Top       = 304
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Encargo", "TextBox")
        WITH THIS.txt_4c_Encargo
            .Alignment     = 3
            .BorderStyle   = 1
            .Value         = 0
            .Format        = "K"
            .Height        = 23
            .InputMask     = "999,999.99"
            .Left          = 326
            .MaxLength     = 0
            .SpecialEffect = 1
            .Top           = 300
            .Width         = 80
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- Atualiza Val.Venda (Left=544, Top=298)
        THIS.AddObject("lbl_4c_PVen", "Label")
        WITH THIS.lbl_4c_PVen
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Atualiza Val.Venda :"
            .Height    = 15
            .Left      = 448
            .Top       = 304
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("opg_4c_PVen", "OptionGroup")
        WITH THIS.opg_4c_PVen
            .ButtonCount = 2
            .Value       = 2
            .Height      = 27
            .Left        = 544
            .Top         = 298
            .Width       = 102
            .BackStyle   = 0
            .Visible     = .T.
            .Buttons(1).Caption     = "\<Sim"
            .Buttons(1).Left        = 5
            .Buttons(1).Top         = 5
            .Buttons(1).AutoSize    = .T.
            .Buttons(1).Themes      = .F.
            .Buttons(2).Caption     = "\<N" + CHR(227) + "o"
            .Buttons(2).Height      = 17
            .Buttons(2).Left        = 53
            .Buttons(2).Top         = 5
            .Buttons(2).Width       = 44
            .Buttons(2).AutoSize    = .F.
            .Buttons(2).Themes      = .F.
        ENDWITH

        *-- Novo MKP code (Left=326, Top=326)
        THIS.AddObject("lbl_4c_NewMkp", "Label")
        WITH THIS.lbl_4c_NewMkp
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Novo MKP : "
            .Height    = 15
            .Left      = 264
            .Top       = 330
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_NewMkp", "TextBox")
        WITH THIS.txt_4c_NewMkp
            .BorderStyle   = 1
            .Height        = 23
            .Left          = 326
            .MaxLength     = 2
            .SpecialEffect = 1
            .Top           = 326
            .Width         = 24
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Layout operacional (substitui Page1 do CRUD)
    * Form OPERACIONAL flat: grid de resultados + imagem de produto
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
        THIS.ConfigurarGrid()
        THIS.ConfigurarImagem()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid
    *==========================================================================
        LOCAL loc_oGrd
        THIS.AddObject("grd_4c_Produto", "Grid")
        loc_oGrd = THIS.grd_4c_Produto
        WITH loc_oGrd
            .ColumnCount   = 9
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 244
            .Left          = 12
            .RowHeight     = 16
            .ScrollBars    = 2
            .Top           = 351
            .Width         = 935
            .RecordSource  = "cursor_4c_Dados"
            .RecordMark    = .F.
            .DeleteMark    = .F.
            .Visible       = .T.

            *-- Column1: Checkbox (lMarca)
            .Column1.Alignment     = 3
            .Column1.Width         = 17
            .Column1.Movable       = .F.
            .Column1.Resizable     = .F.
            .Column1.Sparse        = .F.
            .Column1.Header1.Caption   = ""
            .Column1.Header1.Alignment = 2
            .Column1.Header1.ForeColor = RGB(36,84,155)
            .Column1.RemoveObject("Text1")
            .Column1.AddObject("chk_4c_Marca", "CheckBox")
            WITH .Column1.chk_4c_Marca
                .Caption = ""
                .Width   = 17
                .Height  = 17
                .Value   = 0
                .Visible = .T.
            ENDWITH
            .Column1.CurrentControl = "chk_4c_Marca"
            .Column1.ControlSource  = "cursor_4c_Dados.lMarca"

            *-- Column2: CPros (Produto)
            .Column2.FontName      = "Tahoma"
            .Column2.FontSize      = 8
            .Column2.Width         = 108
            .Column2.Movable       = .F.
            .Column2.Resizable     = .F.
            .Column2.ControlSource = "cursor_4c_Dados.CPros"
            .Column2.Header1.Caption   = "Produto"
            .Column2.Header1.Alignment = 2
            .Column2.Header1.ForeColor = RGB(36,84,155)
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin      = 0
            .Column2.Text1.ReadOnly    = .T.

            *-- Column3: DPros (Descricao)
            .Column3.FontName      = "Tahoma"
            .Column3.FontSize      = 8
            .Column3.Width         = 290
            .Column3.Movable       = .F.
            .Column3.Resizable     = .F.
            .Column3.ControlSource = "cursor_4c_Dados.DPros"
            .Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Column3.Header1.Alignment = 2
            .Column3.Header1.ForeColor = RGB(36,84,155)
            .Column3.Text1.Margin      = 0
            .Column3.Text1.ReadOnly    = .T.

            *-- Column4: ValAnt (Venda Ant.)
            .Column4.FontName      = "Tahoma"
            .Column4.FontSize      = 8
            .Column4.Width         = 80
            .Column4.Movable       = .F.
            .Column4.Resizable     = .F.
            .Column4.ControlSource = "cursor_4c_Dados.ValAnt"
            .Column4.Header1.Caption   = "Venda Ant."
            .Column4.Header1.Alignment = 2
            .Column4.Header1.ForeColor = RGB(36,84,155)
            WITH .Column4.Text1
                .InputMask  = "999,999,999.99"
                .Margin     = 0
                .ReadOnly   = .T.
            ENDWITH

            *-- Column5: ValAtu (Venda Atual)
            .Column5.FontName      = "Tahoma"
            .Column5.FontSize      = 8
            .Column5.Width         = 80
            .Column5.Movable       = .F.
            .Column5.Resizable     = .F.
            .Column5.ControlSource = "cursor_4c_Dados.ValAtu"
            .Column5.Header1.Caption   = "Venda Atual"
            .Column5.Header1.Alignment = 2
            .Column5.Header1.ForeColor = RGB(36,84,155)
            WITH .Column5.Text1
                .InputMask  = "999,999,999.99"
                .Margin     = 0
                .ReadOnly   = .T.
            ENDWITH

            *-- Column6: PVarias (Variacao %)
            .Column6.FontName      = "Tahoma"
            .Column6.FontSize      = 8
            .Column6.Width         = 80
            .Column6.Movable       = .F.
            .Column6.Resizable     = .F.
            .Column6.ReadOnly      = .T.
            .Column6.ControlSource = "cursor_4c_Dados.PVarias"
            .Column6.Header1.Caption   = "Varia" + CHR(231) + CHR(227) + "o (%)"
            .Column6.Header1.Alignment = 2
            .Column6.Header1.ForeColor = RGB(36,84,155)
            WITH .Column6.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .InputMask   = "999,999.99"
                .ForeColor   = RGB(0,0,0)
                .BackColor   = RGB(255,255,255)
            ENDWITH

            *-- Column7: CustoAfs (Custo Ant.)
            .Column7.FontName      = "Tahoma"
            .Column7.FontSize      = 8
            .Column7.Width         = 80
            .Column7.Movable       = .F.
            .Column7.Resizable     = .F.
            .Column7.ReadOnly      = .T.
            .Column7.ControlSource = "cursor_4c_Dados.CustoAfs"
            .Column7.Header1.Caption   = "Custo Ant."
            .Column7.Header1.Alignment = 2
            WITH .Column7.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .InputMask   = "999,999,999.9999"
                .ForeColor   = RGB(0,0,0)
                .BackColor   = RGB(255,255,255)
            ENDWITH

            *-- Column8: CustoFs (Custo Atual)
            .Column8.FontName      = "Tahoma"
            .Column8.FontSize      = 8
            .Column8.Width         = 80
            .Column8.Movable       = .F.
            .Column8.Resizable     = .F.
            .Column8.ReadOnly      = .T.
            .Column8.ControlSource = "cursor_4c_Dados.CustoFs"
            .Column8.Header1.Caption   = "Custo Atual"
            .Column8.Header1.Alignment = 2
            WITH .Column8.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .InputMask   = "999,999,999.9999"
                .ForeColor   = RGB(0,0,0)
                .BackColor   = RGB(255,255,255)
            ENDWITH

            *-- Column9: CVarias (Variacao Custo %)
            .Column9.FontName      = "Tahoma"
            .Column9.FontSize      = 8
            .Column9.Width         = 80
            .Column9.Movable       = .F.
            .Column9.Resizable     = .F.
            .Column9.ReadOnly      = .T.
            .Column9.ControlSource = "cursor_4c_Dados.CVarias"
            .Column9.Header1.Caption   = "Varia" + CHR(231) + CHR(227) + "o Cto (%)"
            .Column9.Header1.Alignment = 2
            WITH .Column9.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .InputMask   = "999,999.99"
                .ForeColor   = RGB(0,0,0)
                .BackColor   = RGB(255,255,255)
            ENDWITH

            .Refresh
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarImagem
    *==========================================================================
        THIS.AddObject("img_4c_FigJpg", "Image")
        WITH THIS.img_4c_FigJpg
            .Stretch = 1
            .Height  = 190
            .Left    = 764
            .Top     = 128
            .Width   = 223
            .Visible = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes
    *==========================================================================
        LOCAL loc_cIco

        loc_cIco = gc_4c_CaminhoIcones

        *-- Botao Imprimir (Left=700, Top=3)
        THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
        WITH THIS.cmd_4c_Imprimir
            .Top        = 3
            .Left       = 700
            .Height     = 75
            .Width      = 60
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .WordWrap   = .T.
            .Picture    = loc_cIco + "geral_impressora_normal_60.jpg"
            .Caption    = "\<Imprimir"
            .ForeColor  = RGB(90,90,90)
            .BackColor  = RGB(255,255,255)
            .Themes     = .T.
            .Enabled    = .F.
            .Visible    = fChecaAcesso("SigPrCcp", "IMPRIMIR")
        ENDWITH

        *-- Botao Processar (Left=767, Top=5)
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top        = 5
            .Left       = 767
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .WordWrap   = .T.
            .Picture    = loc_cIco + "geral_processar_60.jpg"
            .Caption    = "\<Processar"
            .ForeColor  = RGB(90,90,90)
            .BackColor  = RGB(255,255,255)
            .Themes     = .T.
            .Visible    = .T.
        ENDWITH

        *-- Botao Atualizar (Left=843, Top=5)
        THIS.AddObject("cmd_4c_Atualizar", "CommandButton")
        WITH THIS.cmd_4c_Atualizar
            .Top        = 5
            .Left       = 843
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .WordWrap   = .T.
            .Picture    = loc_cIco + "cadastro_salvar_60.jpg"
            .Caption    = "\<Atualizar"
            .ForeColor  = RGB(90,90,90)
            .BackColor  = RGB(255,255,255)
            .Themes     = .T.
            .Enabled    = .F.
            .Visible    = .T.
        ENDWITH

        *-- Container Encerrar canonico (Left=917)
        THIS.AddObject("cnt_4c_Saida", "Container")
        WITH THIS.cnt_4c_Saida
            .Top        = 0
            .Left       = 917
            .Height     = 85
            .Width      = 90
            .BackStyle  = 0
            .BorderWidth= 0
            .Visible    = .T.
            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Top        = 5
                .Left       = 917
                .Height     = 75
                .Width      = 90
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = loc_cIco + "cadastro_sair_60.jpg"
                .Caption    = "Encerrar"
                .ForeColor  = RGB(90,90,90)
                .BackColor  = RGB(255,255,255)
                .Cancel     = .T.
                .Visible    = .T.
            ENDWITH
        ENDWITH

        *-- Botao Selecionar Tudo (Left=955, Top=433)
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top      = 433
            .Left     = 955
            .Height   = 26
            .Width    = 26
            .Picture  = loc_cIco + "geral_marcar_26.jpg"
            .Caption  = ""
            .TabStop  = .F.
            .ToolTipText = "Selecionar Tudo"
            .Themes   = .T.
            .Visible  = .T.
        ENDWITH

        *-- Botao Desmarcar Tudo (Left=955, Top=473)
        THIS.AddObject("cmd_4c_Desmarcar", "CommandButton")
        WITH THIS.cmd_4c_Desmarcar
            .Top      = 473
            .Left     = 955
            .Height   = 26
            .Width    = 26
            .Picture  = loc_cIco + "cadastro_excluir_26.jpg"
            .Caption  = ""
            .TabStop  = .F.
            .ToolTipText = "Desmarcar Tudo"
            .Themes   = .T.
            .Visible  = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis
    *==========================================================================
        LOCAL loc_i, loc_oCtrl
        FOR loc_i = 1 TO THIS.ControlCount
            loc_oCtrl = THIS.Controls(loc_i)
            IF VARTYPE(loc_oCtrl) = "O" AND PEMSTATUS(loc_oCtrl, "Visible", 5)
                IF UPPER(loc_oCtrl.Name) != "IMG_4C_FIGJPG"
                    loc_oCtrl.Visible = .T.
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs
    *==========================================================================
        *-- Botoes de acao
        BINDEVENT(THIS.cmd_4c_Processar, "Click",  THIS, "BtnProcessarClick")
        BINDEVENT(THIS.cmd_4c_Atualizar, "Click",  THIS, "BtnAtualizarClick")
        BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(THIS.cmd_4c_Imprimir,  "Click",  THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmd_4c_SelTudo,   "Click",  THIS, "BtnSelTudoClick")
        BINDEVENT(THIS.cmd_4c_Desmarcar, "Click",  THIS, "BtnDesmarcarClick")

        *-- Grid
        BINDEVENT(THIS.grd_4c_Produto, "AfterRowColChange", THIS, "GrdAfterRowColChange")

        *-- Imagem
        BINDEVENT(THIS.img_4c_FigJpg, "DblClick", THIS, "ImgFigJpgDblClick")

        *-- Opc Recalc (para atualizar estado dos campos)
        BINDEVENT(THIS.opg_4c_Recalc, "InteractiveChange", THIS, "OpcRecalcMudou")

        *-- Fornecedor lookup
        BINDEVENT(THIS.txt_4c_CFornecs, "DblClick",   THIS, "AbrirBuscaFornecedor")
        BINDEVENT(THIS.txt_4c_CFornecs, "KeyPress",   THIS, "TeclaFornecedor")
        BINDEVENT(THIS.txt_4c_CFornecs, "KeyPress",  THIS, "ValidarFornecedor")

        *-- Grande Grupo lookup
        BINDEVENT(THIS.txt_4c_MercI, "DblClick",  THIS, "AbrirBuscaMercI")
        BINDEVENT(THIS.txt_4c_MercI, "KeyPress",  THIS, "TeclaMercI")
        BINDEVENT(THIS.txt_4c_MercF, "DblClick",  THIS, "AbrirBuscaMercF")
        BINDEVENT(THIS.txt_4c_MercF, "KeyPress",  THIS, "TeclaMercF")

        *-- Grupo lookup
        BINDEVENT(THIS.txt_4c_CGrui, "DblClick",  THIS, "AbrirBuscaCGrui")
        BINDEVENT(THIS.txt_4c_CGrui, "KeyPress",  THIS, "TeclaCGrui")
        BINDEVENT(THIS.txt_4c_CGruf, "DblClick",  THIS, "AbrirBuscaCGruf")
        BINDEVENT(THIS.txt_4c_CGruf, "KeyPress",  THIS, "TeclaCGruf")

        *-- Subgrupo lookup
        BINDEVENT(THIS.txt_4c_SGruI, "DblClick",  THIS, "AbrirBuscaSGruI")
        BINDEVENT(THIS.txt_4c_SGruI, "KeyPress",  THIS, "TeclaSGruI")
        BINDEVENT(THIS.txt_4c_SGruF, "DblClick",  THIS, "AbrirBuscaSGruF")
        BINDEVENT(THIS.txt_4c_SGruF, "KeyPress",  THIS, "TeclaSGruF")

        *-- Unidade lookup
        BINDEVENT(THIS.txt_4c_CUniI, "DblClick",  THIS, "AbrirBuscaCUniI")
        BINDEVENT(THIS.txt_4c_CUniI, "KeyPress",  THIS, "TeclaCUniI")
        BINDEVENT(THIS.txt_4c_CUnif, "DblClick",  THIS, "AbrirBuscaCUnif")
        BINDEVENT(THIS.txt_4c_CUnif, "KeyPress",  THIS, "TeclaCUnif")

        *-- Moeda lookup
        BINDEVENT(THIS.txt_4c_MoeI, "DblClick",  THIS, "AbrirBuscaMoeI")
        BINDEVENT(THIS.txt_4c_MoeI, "KeyPress",  THIS, "TeclaMoeI")
        BINDEVENT(THIS.txt_4c_MoeF, "DblClick",  THIS, "AbrirBuscaMoeF")
        BINDEVENT(THIS.txt_4c_MoeF, "KeyPress",  THIS, "TeclaMoeF")

        *-- Linha lookup
        BINDEVENT(THIS.txt_4c_LinhI, "DblClick",  THIS, "AbrirBuscaLinhI")
        BINDEVENT(THIS.txt_4c_LinhI, "KeyPress",  THIS, "TeclaLinhI")
        BINDEVENT(THIS.txt_4c_LinhF, "DblClick",  THIS, "AbrirBuscaLinhF")
        BINDEVENT(THIS.txt_4c_LinhF, "KeyPress",  THIS, "TeclaLinhF")

        *-- Colecao lookup
        BINDEVENT(THIS.txt_4c_ColI, "DblClick",  THIS, "AbrirBuscaColI")
        BINDEVENT(THIS.txt_4c_ColI, "KeyPress",  THIS, "TeclaColI")
        BINDEVENT(THIS.txt_4c_ColF, "DblClick",  THIS, "AbrirBuscaColF")
        BINDEVENT(THIS.txt_4c_ColF, "KeyPress",  THIS, "TeclaColF")

        *-- Feitio lookup
        BINDEVENT(THIS.txt_4c_Feitio,  "DblClick",  THIS, "AbrirBuscaFeitio")
        BINDEVENT(THIS.txt_4c_Feitio,  "KeyPress",  THIS, "TeclaFeitio")
        BINDEVENT(THIS.txt_4c_NewMkp,  "DblClick",  THIS, "AbrirBuscaNewMkp")
        BINDEVENT(THIS.txt_4c_NewMkp,  "KeyPress",  THIS, "TeclaNewMkp")

        *-- Validacoes mutuas Reajuste/NMrk/Variacao
        BINDEVENT(THIS.txt_4c_Reajuste, "KeyPress", THIS, "ValidarReajuste")
        BINDEVENT(THIS.txt_4c_NMrk,     "KeyPress", THIS, "ValidarNMrk")
        BINDEVENT(THIS.txt_4c_Variacao,  "KeyPress", THIS, "ValidarVariacao")
        BINDEVENT(THIS.txt_4c_Encargo,   "KeyPress", THIS, "ValidarEncargo")
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarValores
    *==========================================================================
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    * Atualiza Enabled dos campos conforme estado atual
    *==========================================================================
    PROCEDURE AtualizarEstadoCampos
        LOCAL loc_lRecalc2, loc_lReajZero
        loc_lRecalc2  = (THIS.opg_4c_Recalc.Value = 2)
        loc_lReajZero = (THIS.txt_4c_Reajuste.Value = 0)

        THIS.txt_4c_Reajuste.Enabled = !loc_lRecalc2
        THIS.txt_4c_NMrk.Enabled    = (!loc_lRecalc2) AND loc_lReajZero
        THIS.txt_4c_Variacao.Enabled = (!loc_lRecalc2) AND loc_lReajZero
        THIS.txt_4c_NewMkp.Enabled   = INLIST(THIS.opg_4c_Recalc.Value, 7, 8)
    ENDPROC

    *==========================================================================
    * HANDLERS - Botoes
    *==========================================================================
    PROCEDURE BtnProcessarClick
        LOCAL loc_lSucesso, loc_nVaria, loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        *-- Verificar reprocessamento
        IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            IF !MsgConfirma("Existem Dados Gerados. Deseja Reprocessar?")
                RETURN
            ENDIF
        ENDIF

        *-- Limpar dados anteriores
        IF USED("cursor_4c_Dados")
            ZAP IN cursor_4c_Dados
        ENDIF

        *-- Validar NewMkp para opcoes 7 e 8
        IF INLIST(THIS.opg_4c_Recalc.Value, 7, 8) AND EMPTY(ALLTRIM(THIS.txt_4c_NewMkp.Value))
            MsgAviso("Favor Informar o Novo C" + CHR(243) + "digo do MKP!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_NewMkp.SetFocus()
            RETURN
        ENDIF

        *-- Copiar valores do form para o BO
        loc_oBO.this_cFornecs  = ALLTRIM(THIS.txt_4c_CFornecs.Value)
        loc_oBO.this_cMercI    = ALLTRIM(THIS.txt_4c_MercI.Value)
        loc_oBO.this_cMercF    = ALLTRIM(THIS.txt_4c_MercF.Value)
        loc_oBO.this_cGruI     = ALLTRIM(THIS.txt_4c_CGrui.Value)
        loc_oBO.this_cGruF     = ALLTRIM(THIS.txt_4c_CGruf.Value)
        loc_oBO.this_cSGruI    = ALLTRIM(THIS.txt_4c_SGruI.Value)
        loc_oBO.this_cSGruF    = ALLTRIM(THIS.txt_4c_SGruF.Value)
        loc_oBO.this_cCuniI    = ALLTRIM(THIS.txt_4c_CUniI.Value)
        loc_oBO.this_cCuniF    = ALLTRIM(THIS.txt_4c_CUnif.Value)
        loc_oBO.this_cLinI     = ALLTRIM(THIS.txt_4c_LinhI.Value)
        loc_oBO.this_cLinF     = ALLTRIM(THIS.txt_4c_LinhF.Value)
        loc_oBO.this_cColI     = ALLTRIM(THIS.txt_4c_ColI.Value)
        loc_oBO.this_cColF     = ALLTRIM(THIS.txt_4c_ColF.Value)
        loc_oBO.this_cMoeI     = ALLTRIM(THIS.txt_4c_MoeI.Value)
        loc_oBO.this_cMoeF     = ALLTRIM(THIS.txt_4c_MoeF.Value)
        loc_oBO.this_nMrkI     = THIS.txt_4c_MrkI.Value
        loc_oBO.this_nMrkF     = THIS.txt_4c_MrkF.Value
        loc_oBO.this_nEncI     = THIS.txt_4c_EncI.Value
        loc_oBO.this_nEncF     = THIS.txt_4c_EncF.Value
        loc_oBO.this_cFeitio   = ALLTRIM(THIS.txt_4c_Feitio.Value)
        loc_oBO.this_nSituacao = THIS.opg_4c_Situacao.Value
        loc_oBO.this_nCompra   = THIS.opg_4c_Compra.Value
        loc_oBO.this_nFoption1 = THIS.opg_4c_OpcaoM.Value
        loc_oBO.this_nRecalc   = THIS.opg_4c_Recalc.Value
        loc_oBO.this_nReajuste = THIS.txt_4c_Reajuste.Value
        loc_oBO.this_nNMrk     = THIS.txt_4c_NMrk.Value
        loc_oBO.this_nEncargo  = THIS.txt_4c_Encargo.Value
        loc_oBO.this_nPven     = THIS.opg_4c_PVen.Value
        loc_oBO.this_cNewMkp   = ALLTRIM(THIS.txt_4c_NewMkp.Value)

        *-- Processar
        IF loc_oBO.Processar()
            *-- Filtrar por variacao
            loc_nVaria = THIS.txt_4c_Variacao.Value
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                IF loc_nVaria > 0
                    DELETE FOR PVarias < loc_nVaria
                ENDIF
                IF loc_nVaria < 0
                    DELETE FOR PVarias > loc_nVaria
                ENDIF
                SET ORDER TO CPros
                GO TOP
            ENDIF
            THIS.cmd_4c_Atualizar.Enabled = .T.
            THIS.cmd_4c_Imprimir.Enabled  = .T.
            THIS.grd_4c_Produto.Refresh
        ENDIF
    ENDPROC

    PROCEDURE BtnAtualizarClick
        THIS.this_oBusinessObject.AtualizarPrecos(.F.)
    ENDPROC

    PROCEDURE BtnEncerrarClick
        THIS.Release()
    ENDPROC

    PROCEDURE BtnImprimirClick
        DO FORM SigPrCcr
    ENDPROC

    PROCEDURE BtnSelTudoClick
        IF USED("cursor_4c_Dados")
            UPDATE cursor_4c_Dados SET lMarca = 1
            THIS.grd_4c_Produto.Refresh
        ENDIF
    ENDPROC

    PROCEDURE BtnDesmarcarClick
        IF USED("cursor_4c_Dados")
            UPDATE cursor_4c_Dados SET lMarca = 0
            THIS.grd_4c_Produto.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLER - OpcRecalc mudou
    *==========================================================================
    PROCEDURE OpcRecalcMudou
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    * HANDLER - Grid AfterRowColChange
    *==========================================================================
    PROCEDURE GrdAfterRowColChange(par_nColIndex)
        LOCAL loc_cCodPro, loc_cSql, loc_cArq, loc_cFoto
        loc_cCodPro = ""

        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodPro = ALLTRIM(NVL(cursor_4c_Dados.CPros, ""))
        ENDIF

        THIS.img_4c_FigJpg.Visible  = .F.
        THIS.img_4c_FigJpg.Picture  = ""

        IF !EMPTY(loc_cCodPro) AND gnConnHandle > 0
            loc_cSql = "SELECT FigJpgs FROM SigCdPro WHERE Cpros = " + EscaparSQL(loc_cCodPro)
            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_FigTemp") >= 1
                IF RECCOUNT("cursor_4c_FigTemp") > 0
                    SELECT cursor_4c_FigTemp
                    GO TOP
                    IF !ISNULL(cursor_4c_FigTemp.FigJpgs) AND !EMPTY(cursor_4c_FigTemp.FigJpgs)
                        loc_cArq  = SYS(2023) + "\TempCj.jpg"
                        loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_FigTemp.FigJpgs, ;
                                    "data:image/png;base64,", ""), ;
                                    "data:image/jpeg;base64,", ""), ;
                                    "data:image/jpg;base64,", ""), 14)
                        STRTOFILE(loc_cFoto, loc_cArq, 0)
                        THIS.img_4c_FigJpg.Picture = loc_cArq
                        THIS.img_4c_FigJpg.Visible = .T.
                    ENDIF
                ENDIF
                IF USED("cursor_4c_FigTemp")
                    USE IN cursor_4c_FigTemp
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLER - Imagem DblClick (zoom)
    *==========================================================================
    PROCEDURE ImgFigJpgDblClick
        LOCAL loc_cArq, loc_cCodPro, loc_cSql, loc_cFoto
        loc_cArq    = SYS(2023) + "\" + SYS(2015) + ".Jpg"
        loc_cCodPro = ""

        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodPro = ALLTRIM(NVL(cursor_4c_Dados.CPros, ""))
        ENDIF

        IF !EMPTY(loc_cCodPro) AND gnConnHandle > 0
            loc_cSql = "SELECT cpros, FigJpgs FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCodPro)
            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_FigZoom") >= 1
                IF RECCOUNT("cursor_4c_FigZoom") > 0
                    SELECT cursor_4c_FigZoom
                    GO TOP
                    IF !EMPTY(cursor_4c_FigZoom.FigJpgs) AND !ISNULL(cursor_4c_FigZoom.FigJpgs)
                        loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_FigZoom.FigJpgs, ;
                                    "data:image/png;base64,", ""), ;
                                    "data:image/jpeg;base64,", ""), ;
                                    "data:image/jpg;base64,", ""), 14)
                        STRTOFILE(loc_cFoto, loc_cArq, 0)
                        IF FILE(loc_cArq)
                            DO FORM SigOpZom WITH loc_cArq, ;
                                "Produto : " + loc_cCodPro + " - " + ALLTRIM(NVL(cursor_4c_FigZoom.cpros, "")), ;
                                " "
                            DELETE FILE (loc_cArq)
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_FigZoom")
                    USE IN cursor_4c_FigZoom
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * VALIDADORES
    *==========================================================================
    PROCEDURE ValidarReajuste
        IF THIS.txt_4c_Reajuste.Value > 0
            THIS.txt_4c_NMrk.Value = 0
            THIS.txt_4c_NMrk.Refresh
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    PROCEDURE ValidarNMrk
        IF THIS.txt_4c_NMrk.Value > 0
            THIS.txt_4c_Reajuste.Value = 0
            THIS.txt_4c_Reajuste.Refresh
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    PROCEDURE ValidarVariacao
        IF THIS.txt_4c_Variacao.Value > 0
            THIS.txt_4c_Reajuste.Value = 0
            THIS.txt_4c_Reajuste.Refresh
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    PROCEDURE ValidarEncargo
        IF THIS.txt_4c_Encargo.Value < 0
            MsgAviso("Valor Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Encargo.Value = 0
            THIS.txt_4c_Encargo.SetFocus()
        ENDIF
    ENDPROC

    PROCEDURE ValidarFornecedor
        LOCAL loc_cCod, loc_cDesc, loc_cSql
        loc_cCod  = ALLTRIM(THIS.txt_4c_CFornecs.Value)
        loc_cDesc = ""

        IF !EMPTY(loc_cCod)
            IF !fAcessoContas(gc_4c_UsuarioLogado, "", "C", loc_cCod, .NULL., .NULL.)
                MsgAviso("Acesso Negado...", "Aten" + CHR(231) + CHR(227) + "o")
                THIS.txt_4c_CFornecs.Value = ""
                THIS.txt_4c_DFornecs.Value = ""
                RETURN
            ENDIF
            *-- Buscar descricao
            IF gnConnHandle > 0
                loc_cSql = "SELECT Nomes FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod)
                IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_FornTmp") >= 1
                    IF RECCOUNT("cursor_4c_FornTmp") > 0
                        SELECT cursor_4c_FornTmp
                        GO TOP
                        loc_cDesc = ALLTRIM(NVL(cursor_4c_FornTmp.Nomes, ""))
                    ENDIF
                    IF USED("cursor_4c_FornTmp")
                        USE IN cursor_4c_FornTmp
                    ENDIF
                ENDIF
            ENDIF
            THIS.txt_4c_DFornecs.Value = loc_cDesc
        ELSE
            THIS.txt_4c_CFornecs.Value = ""
            THIS.txt_4c_DFornecs.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - Metodos helper interno
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaGenerica(par_cTabela, par_cAlias, par_cChave, par_cValor, par_cTitulo, par_oCampo)
        LOCAL loc_oForm, loc_cDesc
        loc_cDesc = ""

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            par_cTabela, par_cAlias, par_cChave, par_cValor, par_cTitulo)

        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            IF USED(par_cAlias)
                par_oCampo.Value = ALLTRIM(EVALUATE(par_cAlias + "." + par_cChave))
            ENDIF
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna(par_cChave, "", "C" + CHR(243) + "digo")
            IF USED(par_cAlias)
                SELECT (par_cAlias)
                IF FCOUNT() > 1
                    loc_oForm.mAddColuna(FIELD(2), "", "Descri" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou AND USED(par_cAlias)
                par_oCampo.Value = ALLTRIM(EVALUATE(par_cAlias + "." + par_cChave))
            ENDIF
            ENDIF
        ENDIF

        IF USED(par_cAlias)
            USE IN (par_cAlias)
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *==========================================================================
    * LOOKUPS - Fornecedor
    *==========================================================================
    PROCEDURE AbrirBuscaFornecedor
        LOCAL loc_cVal
        loc_cVal = ALLTRIM(THIS.txt_4c_CFornecs.Value)
        THIS.AbrirBuscaGenerica("SigCdCli", "cursor_4c_FornBus", "Iclis", loc_cVal, ;
            "Fornecedor", THIS.txt_4c_CFornecs)
        THIS.ValidarFornecedor()
    ENDPROC

    PROCEDURE TeclaFornecedor(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaFornecedor()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - Grande Grupo
    *==========================================================================
    PROCEDURE AbrirBuscaMercI
        THIS.AbrirBuscaGenerica("SigCdGpr", "cursor_4c_MercBus", "Codigos", ;
            ALLTRIM(THIS.txt_4c_MercI.Value), "Grande Grupo", THIS.txt_4c_MercI)
    ENDPROC

    PROCEDURE TeclaMercI(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaMercI()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaMercF
        THIS.AbrirBuscaGenerica("SigCdGpr", "cursor_4c_MercBus", "Codigos", ;
            ALLTRIM(THIS.txt_4c_MercF.Value), "Grande Grupo", THIS.txt_4c_MercF)
    ENDPROC

    PROCEDURE TeclaMercF(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaMercF()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - Grupo
    *==========================================================================
    PROCEDURE AbrirBuscaCGrui
        THIS.AbrirBuscaGenerica("SigCdGrp", "cursor_4c_GrpBus", "CGrus", ;
            ALLTRIM(THIS.txt_4c_CGrui.Value), "Grupo", THIS.txt_4c_CGrui)
    ENDPROC

    PROCEDURE TeclaCGrui(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaCGrui()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaCGruf
        THIS.AbrirBuscaGenerica("SigCdGrp", "cursor_4c_GrpBus", "CGrus", ;
            ALLTRIM(THIS.txt_4c_CGruf.Value), "Grupo", THIS.txt_4c_CGruf)
    ENDPROC

    PROCEDURE TeclaCGruf(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaCGruf()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - Subgrupo
    *==========================================================================
    PROCEDURE AbrirBuscaSGruI
        THIS.AbrirBuscaGenerica("SigCdPsg", "cursor_4c_SgrBus", "Codigos", ;
            ALLTRIM(THIS.txt_4c_SGruI.Value), "Subgrupo", THIS.txt_4c_SGruI)
    ENDPROC

    PROCEDURE TeclaSGruI(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaSGruI()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaSGruF
        THIS.AbrirBuscaGenerica("SigCdPsg", "cursor_4c_SgrBus", "Codigos", ;
            ALLTRIM(THIS.txt_4c_SGruF.Value), "Subgrupo", THIS.txt_4c_SGruF)
    ENDPROC

    PROCEDURE TeclaSGruF(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaSGruF()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - Unidade
    *==========================================================================
    PROCEDURE AbrirBuscaCUniI
        THIS.AbrirBuscaGenerica("SigCdUni", "cursor_4c_UniBus", "CUnis", ;
            ALLTRIM(THIS.txt_4c_CUniI.Value), "Unidade", THIS.txt_4c_CUniI)
    ENDPROC

    PROCEDURE TeclaCUniI(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaCUniI()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaCUnif
        THIS.AbrirBuscaGenerica("SigCdUni", "cursor_4c_UniBus", "CUnis", ;
            ALLTRIM(THIS.txt_4c_CUnif.Value), "Unidade", THIS.txt_4c_CUnif)
    ENDPROC

    PROCEDURE TeclaCUnif(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaCUnif()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - Linha
    *==========================================================================
    PROCEDURE AbrirBuscaLinhI
        THIS.AbrirBuscaGenerica("SigCdLin", "cursor_4c_LinBus", "Linhas", ;
            ALLTRIM(THIS.txt_4c_LinhI.Value), "Linha", THIS.txt_4c_LinhI)
    ENDPROC

    PROCEDURE TeclaLinhI(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaLinhI()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaLinhF
        THIS.AbrirBuscaGenerica("SigCdLin", "cursor_4c_LinBus", "Linhas", ;
            ALLTRIM(THIS.txt_4c_LinhF.Value), "Linha", THIS.txt_4c_LinhF)
    ENDPROC

    PROCEDURE TeclaLinhF(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaLinhF()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - Colecao
    *==========================================================================
    PROCEDURE AbrirBuscaColI
        THIS.AbrirBuscaGenerica("SigCdCol", "cursor_4c_ColBus", "Colecoes", ;
            ALLTRIM(THIS.txt_4c_ColI.Value), "Cole" + CHR(231) + CHR(227) + "o", THIS.txt_4c_ColI)
    ENDPROC

    PROCEDURE TeclaColI(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaColI()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaColF
        THIS.AbrirBuscaGenerica("SigCdCol", "cursor_4c_ColBus", "Colecoes", ;
            ALLTRIM(THIS.txt_4c_ColF.Value), "Cole" + CHR(231) + CHR(227) + "o", THIS.txt_4c_ColF)
    ENDPROC

    PROCEDURE TeclaColF(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaColF()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - Moeda
    *==========================================================================
    PROCEDURE AbrirBuscaMoeI
        THIS.AbrirBuscaGenerica("SigCdMoe", "cursor_4c_MoeBus", "CMoes", ;
            ALLTRIM(THIS.txt_4c_MoeI.Value), "Moeda", THIS.txt_4c_MoeI)
    ENDPROC

    PROCEDURE TeclaMoeI(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaMoeI()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaMoeF
        THIS.AbrirBuscaGenerica("SigCdMoe", "cursor_4c_MoeBus", "CMoes", ;
            ALLTRIM(THIS.txt_4c_MoeF.Value), "Moeda", THIS.txt_4c_MoeF)
    ENDPROC

    PROCEDURE TeclaMoeF(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaMoeF()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - Feitio (MKP atual)
    *==========================================================================
    PROCEDURE AbrirBuscaFeitio
        LOCAL loc_oForm, loc_cVal, loc_cSql
        loc_cVal = ALLTRIM(THIS.txt_4c_Feitio.Value)

        IF gnConnHandle > 0
            loc_cSql = "SELECT Cods, Descs, Moedas, Acrescs FROM SigPrFti"
            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_FtiBus") >= 1
                IF !USED("cursor_4c_FtiBus")
                    RETURN
                ENDIF
                SELECT cursor_4c_FtiBus
                INDEX ON Cods TAG Cods ADDITIVE

                IF !SEEK(loc_cVal, "cursor_4c_FtiBus", "Cods")
                    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                        "SigPrFti", "cursor_4c_FtiBus2", "Cods", loc_cVal, "Feitios")
                    IF !ISNULL(loc_oForm)
                        loc_oForm.mAddColuna("Cods",  "", "Cod")
                        loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oForm.Show()
                        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_FtiBus2")
                            THIS.txt_4c_Feitio.Value = ALLTRIM(cursor_4c_FtiBus2.Cods)
                        ENDIF
                        IF USED("cursor_4c_FtiBus2")
                            USE IN cursor_4c_FtiBus2
                        ENDIF
                        loc_oForm.Release()
                    ENDIF
                ELSE
                    THIS.txt_4c_Feitio.Value = ALLTRIM(cursor_4c_FtiBus.Cods)
                ENDIF

                IF USED("cursor_4c_FtiBus")
                    USE IN cursor_4c_FtiBus
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TeclaFeitio(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaFeitio()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - Novo MKP (opcoes 7 e 8)
    *==========================================================================
    PROCEDURE AbrirBuscaNewMkp
        LOCAL loc_oForm, loc_cVal, loc_cSql
        loc_cVal = ALLTRIM(THIS.txt_4c_NewMkp.Value)

        IF gnConnHandle > 0
            loc_cSql = "SELECT Cods, Descs, Moedas, Acrescs FROM SigPrFti WHERE Tipos = 1"
            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_MkpBus") >= 1
                IF !USED("cursor_4c_MkpBus")
                    RETURN
                ENDIF
                SELECT cursor_4c_MkpBus
                INDEX ON Cods TAG Cods ADDITIVE

                IF !SEEK(loc_cVal, "cursor_4c_MkpBus", "Cods")
                    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                        "SigPrFti", "cursor_4c_MkpBus2", "Cods", loc_cVal, "Feitios")
                    IF !ISNULL(loc_oForm)
                        loc_oForm.mAddColuna("Cods",  "", "Cod")
                        loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oForm.Show()
                        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_MkpBus2")
                            THIS.txt_4c_NewMkp.Value = ALLTRIM(cursor_4c_MkpBus2.Cods)
                        ENDIF
                        IF USED("cursor_4c_MkpBus2")
                            USE IN cursor_4c_MkpBus2
                        ENDIF
                        loc_oForm.Release()
                    ENDIF
                ELSE
                    THIS.txt_4c_NewMkp.Value = ALLTRIM(cursor_4c_MkpBus.Cods)
                ENDIF

                IF USED("cursor_4c_MkpBus")
                    USE IN cursor_4c_MkpBus
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TeclaNewMkp(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaNewMkp()
        ENDIF
    ENDPROC

    *==========================================================================
    * Overrides de FormBase: CRUD nao se aplica a este form OPERACIONAL.
    * Estes metodos existem para evitar "file not found" se FormBase os
    * chamar via KeyPreview (F2/F3/F4/F5).
    *==========================================================================
    PROCEDURE BtnIncluirClick
    ENDPROC

    PROCEDURE BtnAlterarClick
    ENDPROC

    PROCEDURE BtnVisualizarClick
    ENDPROC

    PROCEDURE BtnExcluirClick
    ENDPROC

    *==========================================================================
    * AlternarPagina - Form OPERACIONAL com layout flat, sem paginacao
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Override de FormBase (form OPERACIONAL nao tem Buscar)
    *==========================================================================
    PROCEDURE BtnBuscarClick
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Override de FormBase. Em OPERACIONAL o "salvar" equivale
    * a aplicar as alteracoes de preco calculadas (AtualizarPrecos).
    *==========================================================================
    PROCEDURE BtnSalvarClick
        THIS.this_oBusinessObject.AtualizarPrecos(.F.)
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Override de FormBase. Cancela: limpa cursor, zera
    * campos calculados e volta ao estado inicial de captura.
    *==========================================================================
    PROCEDURE BtnCancelarClick
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            ZAP
            THIS.grd_4c_Produto.Refresh
        ENDIF
        THIS.this_oBusinessObject.this_lProcessado = .F.
        THIS.cmd_4c_Atualizar.Enabled = .F.
        THIS.cmd_4c_Imprimir.Enabled  = .F.
    ENDPROC

    *==========================================================================
    * CarregarLista - Override de FormBase (form OPERACIONAL nao tem lista CRUD)
    *==========================================================================
    PROCEDURE CarregarLista
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Override de FormBase. Em OPERACIONAL o controle
    * de estado dos botoes eh feito por AtualizarEstadoCampos() em funcao do
    * flag this_lProcessado do BO.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita TODOS os campos de captura em
    * funcao do estado do processamento. Enquanto lProcessado = .F., filtros
    * e opcoes ficam habilitados para permitir configurar antes de "Processar".
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lEnabled

        IF PCOUNT() < 1
            loc_lEnabled = .T.
        ELSE
            loc_lEnabled = par_lHabilitar
        ENDIF

        *-- Fornecedor
        THIS.txt_4c_CFornecs.Enabled = loc_lEnabled
        THIS.txt_4c_DFornecs.Enabled = .F.  && sempre readonly (descricao)

        *-- Grande Grupo (MercI/MercF)
        THIS.txt_4c_MercI.Enabled = loc_lEnabled
        THIS.txt_4c_MercF.Enabled = loc_lEnabled

        *-- Grupo
        THIS.txt_4c_CGrui.Enabled = loc_lEnabled
        THIS.txt_4c_CGruf.Enabled = loc_lEnabled

        *-- Subgrupo
        THIS.txt_4c_SGruI.Enabled = loc_lEnabled
        THIS.txt_4c_SGruF.Enabled = loc_lEnabled

        *-- Unidade
        THIS.txt_4c_CUniI.Enabled = loc_lEnabled
        THIS.txt_4c_CUnif.Enabled = loc_lEnabled

        *-- Linha
        THIS.txt_4c_LinhI.Enabled = loc_lEnabled
        THIS.txt_4c_LinhF.Enabled = loc_lEnabled

        *-- Colecao
        THIS.txt_4c_ColI.Enabled = loc_lEnabled
        THIS.txt_4c_ColF.Enabled = loc_lEnabled

        *-- Moeda
        THIS.txt_4c_MoeI.Enabled = loc_lEnabled
        THIS.txt_4c_MoeF.Enabled = loc_lEnabled

        *-- Markup
        THIS.txt_4c_MrkI.Enabled = loc_lEnabled
        THIS.txt_4c_MrkF.Enabled = loc_lEnabled

        *-- Encargo (filtro)
        THIS.txt_4c_EncI.Enabled = loc_lEnabled
        THIS.txt_4c_EncF.Enabled = loc_lEnabled

        *-- Variacao (filtro pos-processamento)
        THIS.txt_4c_Variacao.Enabled = loc_lEnabled

        *-- Feitio (Codigo MKP atual)
        THIS.txt_4c_Feitio.Enabled = loc_lEnabled

        *-- Situacao / Compra / OpcaoM (opcoes gerais)
        THIS.opg_4c_Situacao.Enabled = loc_lEnabled
        THIS.opg_4c_Compra.Enabled   = loc_lEnabled
        THIS.opg_4c_OpcaoM.Enabled   = loc_lEnabled

        *-- Recalcula
        THIS.opg_4c_Recalc.Enabled = loc_lEnabled

        *-- Atualiza Val.Venda
        THIS.opg_4c_PVen.Enabled = loc_lEnabled

        *-- Campos dependentes do modo de recalculo (Reajuste, NMrk, Encargo, NewMkp)
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    * LimparCampos - Zera todos os campos de captura e o cursor de resultados.
    *==========================================================================
    PROCEDURE LimparCampos
        *-- Fornecedor
        THIS.txt_4c_CFornecs.Value = ""
        THIS.txt_4c_DFornecs.Value = ""

        *-- Grande Grupo
        THIS.txt_4c_MercI.Value = ""
        THIS.txt_4c_MercF.Value = ""

        *-- Grupo
        THIS.txt_4c_CGrui.Value = ""
        THIS.txt_4c_CGruf.Value = ""

        *-- Subgrupo
        THIS.txt_4c_SGruI.Value = ""
        THIS.txt_4c_SGruF.Value = ""

        *-- Unidade
        THIS.txt_4c_CUniI.Value = ""
        THIS.txt_4c_CUnif.Value = ""

        *-- Linha
        THIS.txt_4c_LinhI.Value = ""
        THIS.txt_4c_LinhF.Value = ""

        *-- Colecao
        THIS.txt_4c_ColI.Value = ""
        THIS.txt_4c_ColF.Value = ""

        *-- Moeda
        THIS.txt_4c_MoeI.Value = ""
        THIS.txt_4c_MoeF.Value = ""

        *-- Markup
        THIS.txt_4c_MrkI.Value = 0
        THIS.txt_4c_MrkF.Value = 0

        *-- Encargo (filtro)
        THIS.txt_4c_EncI.Value = 0
        THIS.txt_4c_EncF.Value = 0

        *-- Variacao
        THIS.txt_4c_Variacao.Value = 0

        *-- Feitio / NewMkp
        THIS.txt_4c_Feitio.Value = ""
        THIS.txt_4c_NewMkp.Value = ""

        *-- Novos parametros de recalculo
        THIS.txt_4c_Reajuste.Value = 0
        THIS.txt_4c_NMrk.Value     = 0
        THIS.txt_4c_Encargo.Value  = 0

        *-- Opcoes: valores default do legado
        THIS.opg_4c_Situacao.Value = 1  && 1 = Ativos
        THIS.opg_4c_Compra.Value   = 3  && 3 = Todos
        THIS.opg_4c_OpcaoM.Value   = 1
        THIS.opg_4c_Recalc.Value   = 1  && 1 = Reajuste
        THIS.opg_4c_PVen.Value     = 2  && 2 = Nao

        *-- Cursor de resultados
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            ZAP
            THIS.grd_4c_Produto.Refresh
        ENDIF

        *-- Imagem
        THIS.img_4c_FigJpg.Visible = .F.
        THIS.img_4c_FigJpg.Picture = ""

        *-- Reset do estado de processamento
        THIS.this_oBusinessObject.this_lProcessado = .F.
        THIS.cmd_4c_Atualizar.Enabled = .F.
        THIS.cmd_4c_Imprimir.Enabled  = .F.

        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    * FormParaBO - Copia TODOS os valores dos controles do form para o BO
    * antes de qualquer operacao (Processar, AtualizarPrecos).
    *==========================================================================
    PROCEDURE FormParaBO
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        *-- Fornecedor
        loc_oBO.this_cFornecs  = ALLTRIM(THIS.txt_4c_CFornecs.Value)
        loc_oBO.this_cDFornecs = ALLTRIM(THIS.txt_4c_DFornecs.Value)

        *-- Grande Grupo (MercI/MercF)
        loc_oBO.this_cMercI = ALLTRIM(THIS.txt_4c_MercI.Value)
        loc_oBO.this_cMercF = ALLTRIM(THIS.txt_4c_MercF.Value)

        *-- Grupo
        loc_oBO.this_cGruI = ALLTRIM(THIS.txt_4c_CGrui.Value)
        loc_oBO.this_cGruF = ALLTRIM(THIS.txt_4c_CGruf.Value)

        *-- Subgrupo
        loc_oBO.this_cSGruI = ALLTRIM(THIS.txt_4c_SGruI.Value)
        loc_oBO.this_cSGruF = ALLTRIM(THIS.txt_4c_SGruF.Value)

        *-- Unidade
        loc_oBO.this_cCuniI = ALLTRIM(THIS.txt_4c_CUniI.Value)
        loc_oBO.this_cCuniF = ALLTRIM(THIS.txt_4c_CUnif.Value)

        *-- Linha
        loc_oBO.this_cLinI = ALLTRIM(THIS.txt_4c_LinhI.Value)
        loc_oBO.this_cLinF = ALLTRIM(THIS.txt_4c_LinhF.Value)

        *-- Colecao
        loc_oBO.this_cColI = ALLTRIM(THIS.txt_4c_ColI.Value)
        loc_oBO.this_cColF = ALLTRIM(THIS.txt_4c_ColF.Value)

        *-- Moeda
        loc_oBO.this_cMoeI = ALLTRIM(THIS.txt_4c_MoeI.Value)
        loc_oBO.this_cMoeF = ALLTRIM(THIS.txt_4c_MoeF.Value)

        *-- Markup
        loc_oBO.this_nMrkI = THIS.txt_4c_MrkI.Value
        loc_oBO.this_nMrkF = THIS.txt_4c_MrkF.Value

        *-- Encargo (filtro)
        loc_oBO.this_nEncI = THIS.txt_4c_EncI.Value
        loc_oBO.this_nEncF = THIS.txt_4c_EncF.Value

        *-- Variacao (filtro pos-processamento)
        loc_oBO.this_nVariacao = THIS.txt_4c_Variacao.Value

        *-- Codigo MKP atual / novo
        loc_oBO.this_cFeitio = ALLTRIM(THIS.txt_4c_Feitio.Value)
        loc_oBO.this_cNewMkp = ALLTRIM(THIS.txt_4c_NewMkp.Value)

        *-- Parametros de recalculo
        loc_oBO.this_nReajuste = THIS.txt_4c_Reajuste.Value
        loc_oBO.this_nNMrk     = THIS.txt_4c_NMrk.Value
        loc_oBO.this_nEncargo  = THIS.txt_4c_Encargo.Value

        *-- Opcoes
        loc_oBO.this_nSituacao = THIS.opg_4c_Situacao.Value
        loc_oBO.this_nCompra   = THIS.opg_4c_Compra.Value
        loc_oBO.this_nFoption1 = THIS.opg_4c_OpcaoM.Value
        loc_oBO.this_nRecalc   = THIS.opg_4c_Recalc.Value
        loc_oBO.this_nPven     = THIS.opg_4c_PVen.Value
    ENDPROC

    *==========================================================================
    * BOParaForm - Reflete TODAS as propriedades do BO nos controles do form.
    * Usado apos carga de configuracao inicial (crSigCdCcp do legado).
    *==========================================================================
    PROCEDURE BOParaForm
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        *-- Fornecedor
        THIS.txt_4c_CFornecs.Value = loc_oBO.this_cFornecs
        THIS.txt_4c_DFornecs.Value = loc_oBO.this_cDFornecs

        *-- Grande Grupo
        THIS.txt_4c_MercI.Value = loc_oBO.this_cMercI
        THIS.txt_4c_MercF.Value = loc_oBO.this_cMercF

        *-- Grupo
        THIS.txt_4c_CGrui.Value = loc_oBO.this_cGruI
        THIS.txt_4c_CGruf.Value = loc_oBO.this_cGruF

        *-- Subgrupo
        THIS.txt_4c_SGruI.Value = loc_oBO.this_cSGruI
        THIS.txt_4c_SGruF.Value = loc_oBO.this_cSGruF

        *-- Unidade
        THIS.txt_4c_CUniI.Value = loc_oBO.this_cCuniI
        THIS.txt_4c_CUnif.Value = loc_oBO.this_cCuniF

        *-- Linha
        THIS.txt_4c_LinhI.Value = loc_oBO.this_cLinI
        THIS.txt_4c_LinhF.Value = loc_oBO.this_cLinF

        *-- Colecao
        THIS.txt_4c_ColI.Value = loc_oBO.this_cColI
        THIS.txt_4c_ColF.Value = loc_oBO.this_cColF

        *-- Moeda
        THIS.txt_4c_MoeI.Value = loc_oBO.this_cMoeI
        THIS.txt_4c_MoeF.Value = loc_oBO.this_cMoeF

        *-- Markup
        THIS.txt_4c_MrkI.Value = loc_oBO.this_nMrkI
        THIS.txt_4c_MrkF.Value = loc_oBO.this_nMrkF

        *-- Encargo (filtro)
        THIS.txt_4c_EncI.Value = loc_oBO.this_nEncI
        THIS.txt_4c_EncF.Value = loc_oBO.this_nEncF

        *-- Variacao
        THIS.txt_4c_Variacao.Value = loc_oBO.this_nVariacao

        *-- Codigo MKP atual / novo
        THIS.txt_4c_Feitio.Value = loc_oBO.this_cFeitio
        THIS.txt_4c_NewMkp.Value = loc_oBO.this_cNewMkp

        *-- Parametros de recalculo
        THIS.txt_4c_Reajuste.Value = loc_oBO.this_nReajuste
        THIS.txt_4c_NMrk.Value     = loc_oBO.this_nNMrk
        THIS.txt_4c_Encargo.Value  = loc_oBO.this_nEncargo

        *-- Opcoes
        THIS.opg_4c_Situacao.Value = loc_oBO.this_nSituacao
        THIS.opg_4c_Compra.Value   = loc_oBO.this_nCompra
        THIS.opg_4c_OpcaoM.Value   = loc_oBO.this_nFoption1
        THIS.opg_4c_Recalc.Value   = loc_oBO.this_nRecalc
        THIS.opg_4c_PVen.Value     = loc_oBO.this_nPven

        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy
    *==========================================================================
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprccpBO.prg):
*-- sigprccpBO.prg
*-- BO para Recalculo de Precos (SIGPRCCP)
*-- Fase 1/8: BO - Propriedades e Init
*-- Tabela principal: SigPrCpo | Chave: cIdChaves

DEFINE CLASS sigprccpBO AS BusinessBase

    *-- ===================================================================
    *-- IDENTIFICACAO DA ENTIDADE
    *-- ===================================================================
    this_cTabela      = "SigPrCpo"
    this_cCampoChave  = "cIdChaves"

    *-- ===================================================================
    *-- FILTROS - FAIXA DE GRANDE GRUPO (SigCdGpr)
    *-- ===================================================================
    this_cMercI    = ""     && Grande Grupo inicial (getMercI, MaxLen=3)
    this_cMercF    = ""     && Grande Grupo final   (getMercF, MaxLen=3)

    *-- ===================================================================
    *-- FILTROS - FAIXA DE GRUPO (SigCdGrp)
    *-- ===================================================================
    this_cGruI     = ""     && Grupo inicial (getCgrui, CGrus, MaxLen=3)
    this_cGruF     = ""     && Grupo final   (getCgruf, CGrus, MaxLen=3)

    *-- ===================================================================
    *-- FILTROS - FAIXA DE SUBGRUPO (SigCdPsg)
    *-- ===================================================================
    this_cSGruI    = ""     && Subgrupo inicial (getSgruI, Codigos, MaxLen=6)
    this_cSGruF    = ""     && Subgrupo final   (getSgruF, Codigos, MaxLen=6)

    *-- ===================================================================
    *-- FILTROS - FAIXA DE UNIDADE (SigCdUni)
    *-- ===================================================================
    this_cCuniI    = ""     && Unidade inicial (getCunii, CUnis, MaxLen=3)
    this_cCuniF    = ""     && Unidade final   (getCunif, CUnis, MaxLen=3)

    *-- ===================================================================
    *-- FILTROS - FAIXA DE LINHA (SigCdLin)
    *-- ===================================================================
    this_cLinI     = ""     && Linha inicial (GetLini, Linhas, MaxLen=10)
    this_cLinF     = ""     && Linha final   (GetLinf, Linhas, MaxLen=10)

    *-- ===================================================================
    *-- FILTROS - FAIXA DE COLECAO (SigCdCol)
    *-- ===================================================================
    this_cColI     = ""     && Colecao inicial (GetColi, Colecoes, MaxLen=10)
    this_cColF     = ""     && Colecao final   (GetColf, Colecoes, MaxLen=10)

    *-- ===================================================================
    *-- FILTROS - FAIXA DE MOEDA (SigCdMoe)
    *-- ===================================================================
    this_cMoeI     = ""     && Moeda inicial (GetMoedai, CMoes, MaxLen=3)
    this_cMoeF     = ""     && Moeda final   (GetMoedaf, CMoes, MaxLen=3)

    *-- ===================================================================
    *-- FILTROS - FAIXA DE MARKUP E ENCARGO (NUMERICOS)
    *-- ===================================================================
    this_nMrkI     = 0      && Markup inicial  (GetMrki)
    this_nMrkF     = 0      && Markup final    (GetMrkf)
    this_nEncI     = 0      && Encargo inicial (Get_EncI)
    this_nEncF     = 0      && Encargo final   (Get_Encf)

    *-- ===================================================================
    *-- FILTROS - FORNECEDOR (fAcessoContas)
    *-- ===================================================================
    this_cFornecs  = ""     && Fornecedor codigo      (getCFornecs, Ifors, MaxLen=10)
    this_cDFornecs = ""     && Fornecedor descricao   (getDFornecs, somente leitura, MaxLen=40)

    *-- ===================================================================
    *-- PARAMETROS DE PROCESSAMENTO - RECALCULO
    *-- ===================================================================
    this_nReajuste = 0      && Percentual de reajuste aplicado ao preco (Get_Reajuste)
    this_nNMrk     = 0      && Novo Markup                              (GetnMrk)
    this_nVariacao = 0      && Percentual de variacao para filtro pos-processamento (Get_Variacao)
    this_nEncargo  = 0      && Novo Encargo percentual                  (get_Encargo)
    this_cFeitio   = ""     && Codigo MKP atual (Get_Feitio, SigPrFti.Cods, MaxLen=2)
    this_cNewMkp   = ""     && Novo codigo MKP  (getNewMkp, SigPrFti.Cods, MaxLen=2)

    *-- ===================================================================
    *-- OPCOES DE PROCESSAMENTO (OPTIONGROUPS)
    *-- ===================================================================

    && Opc_situacao: 1=Ativos, 2=Inativos, 3=Todos (default VFP=1, nao definido no SCX)
    this_nSituacao = 1

    && Opc_pven: 1=Sim, 2=Nao  (default SCX Value=2 = Nao)
    this_nPven     = 2

    && Opc_Recalc: 1=Composicao, 2=CustoVenda, 3=Ambos, 4=PesoComp,
    &&             5=Cambio, 6=CambioInteiros, 7=MarkupCusto, 8=MarkupVenda
    this_nRecalc   = 1

    && Opc_Compra: 1=Comprar, 2=NaoComprar, 3=Todos  (default SCX Value=3)
    this_nCompra   = 3

    && fwoption1: 1=Ideal, 2=Venda  (default SCX Value=1)
    this_nFoption1 = 1

    *-- ===================================================================
    *-- PARAMETROS DO SISTEMA (carregados de SigCdPam e SigCdPaC)
    *-- ===================================================================
    this_nArreds      = 0   && Arredondamento de precos (SigCdPam.Arreds)
    this_nCalcCusts   = 0   && Metodo de calculo de custo (SigCdPaC.Calccusts)
    this_nNChkSubGrs  = 0   && Flag subgrupo por faixa de preco (SigCdPaC.NCHKSUBGRS)

    *-- ===================================================================
    *-- PROPRIEDADES DE REGISTRO SigPrCpo (composicao de produto)
    *-- Usadas para operacoes CRUD individuais em registros de composicao
    *-- ===================================================================
    this_cIdChaves   = ""    && Chave primaria (cidchaves C(20))
    this_cCats       = ""    && Categoria composicao (cats C(6))
    this_cCgrus      = ""    && Grupo do produto principal (cgrus C(3))
    this_cCpros      = ""    && Codigo do produto principal (cpros C(14))
    this_dDatatrans  = {}    && Data de transferencia (datatrans DATETIME NULL)
    this_cDcompos    = ""    && Descricao da composicao (dcompos C(40))
    this_cDscgrp     = ""    && Descricao do subgrupo (dscgrp C(20))
    this_cEtiqs      = ""    && Etiqueta (etiqs C(1))
    this_cGrupos     = ""    && Grupo (grupos C(10))
    this_cMats       = ""    && Codigo do material/componente (mats C(14))
    this_cMoeds      = ""    && Moeda (moeds C(3))
    this_cObscompos  = ""    && Observacao da composicao (obscompos C(10))
    this_nOrdems     = 0     && Ordem sequencial (ordems N(2,0))
    this_nPcompos    = 0     && Percentual composicao (pcompos N(11,3))
    this_nQtds       = 0     && Quantidade (qtds N(8,3))
    this_nQtscons    = 0     && Quantidade consumo (qtscons N(8,3))
    this_cUnicompos  = ""    && Unidade composicao (unicompos C(3))
    this_cCompos     = ""    && Composicao (compos C(10))
    this_nOrdcompos  = 0     && Ordem composicao (ordcompos N(2,0))
    this_nQtdcvs     = 0     && Quantidade custo venda (qtdcvs N(11,3))
    this_nVlrcvs     = 0     && Valor custo venda (vlrcvs N(11,2))
    this_dDtmovs     = {}    && Data movimento (dtmovs DATETIME NULL)
    this_cCunips     = ""    && Unidade preco (cunips C(3))
    this_nMarkcvs    = 0     && Markup custo venda (markcvs N(9,6))
    this_nPesos      = 0     && Peso (pesos N(8,3))
    this_nTotas      = 0     && Total (totas N(11,3))
    this_nTpalts     = 0     && Tipo alteracao (tpalts N(1,0))
    this_nVlrpvs     = 0     && Valor preco venda (vlrpvs N(11,2))
    this_nOrdts      = 0     && Ordem (ordts N(2,0))
    this_cTipos      = ""    && Tipo (tipos C(20))
    this_cMatriz     = ""    && Matriz (matriz C(14))
    this_cObsofs     = ""    && Observacao oficina (obsofs C(120))
    this_nPedraPrincipal = 0 && Pedra principal flag (PedraPrincipal N(1,0))

    *-- ===================================================================
    *-- ESTADO DE PROCESSAMENTO
    *-- ===================================================================
    this_lAutomatico  = .F. && Modo automatico (parametro pAuto do Init legado)
    this_cPro         = ""  && Produto atual sendo processado (PRIVATE pPro no legado)
    this_lProcessado  = .F. && Indica se Processar() foi executado com sucesso

    *-- ===================================================================
    *-- METODOS
    *-- ===================================================================

    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigPrCpo"
            THIS.this_cCampoChave = "cIdChaves"

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar sigprccpBO: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosAuxiliares - Carrega cursores auxiliares para processamento
    * Chamado pelo Form no InicializarForm() antes de qualquer Processar()
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosAuxiliares()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Parametros SigCdPam (arredondamento de preco)
            loc_cSQL = "SELECT TOP 1 Arreds FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AuxPam")
            IF loc_nResult > 0 AND !EOF("cursor_4c_AuxPam")
                SELECT cursor_4c_AuxPam
                THIS.this_nArreds = NVL(cursor_4c_AuxPam.Arreds, 0)
                THIS.this_nArreds = IIF(THIS.this_nArreds = 0, 1, THIS.this_nArreds)
            ENDIF
            IF USED("cursor_4c_AuxPam")
                USE IN cursor_4c_AuxPam
            ENDIF

            *-- Parametros SigCdPaC (metodo calculo custo e flag subgrupo)
            loc_cSQL = "SELECT TOP 1 Calccusts, NCHKSUBGRS FROM SigCdPaC"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AuxPaC")
            IF loc_nResult > 0 AND !EOF("cursor_4c_AuxPaC")
                SELECT cursor_4c_AuxPaC
                THIS.this_nCalcCusts  = NVL(cursor_4c_AuxPaC.CalcCusts, 0)
                THIS.this_nNChkSubGrs = NVL(cursor_4c_AuxPaC.NCHKSUBGRS, 0)
            ENDIF
            IF USED("cursor_4c_AuxPaC")
                USE IN cursor_4c_AuxPaC
            ENDIF

            *-- Moedas (SigCdMoe)
            IF USED("CrSigCdMoe")
                USE IN CrSigCdMoe
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdMoe"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdMoe")
            IF loc_nResult > 0
                SELECT CrSigCdMoe
                INDEX ON Cmoes TAG Cmoes
                INDEX ON Dmoes TAG Dmoes
            ENDIF

            *-- Cotacoes de cambio (SigCdCot)
            IF USED("CrSigCdCot")
                USE IN CrSigCdCot
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdCot"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdCot")
            IF loc_nResult > 0
                SELECT CrSigCdCot
                INDEX ON cmoes+DTOS(datas)+horas TAG Cotacaos
                INDEX ON cmoes+DTOS(datas) TAG cMoeData
            ENDIF

            *-- Grupos de produto (SigCdGrp)
            IF USED("CrSigCdGrp")
                USE IN CrSigCdGrp
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdGrp"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdGrp")
            IF loc_nResult > 0
                SELECT CrSigCdGrp
                INDEX ON Cgrus TAG Cgrus
            ENDIF

            *-- Unidades de medida (SigCdUni)
            IF USED("CrSigCdUni")
                USE IN CrSigCdUni
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdUni"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdUni")
            IF loc_nResult > 0
                SELECT CrSigCdUni
                INDEX ON CUnis TAG cUnis
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar dados auxiliares: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorDados - Cria cursor_4c_Dados para exibicao no grid de produtos
    * Estrutura espelha o cursor CrProdutos do legado
    *--------------------------------------------------------------------------
    PROCEDURE CriarCursorDados()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Dados ( ;
            lMarca   N(1)     NULL, ;
            CPros    C(14)    NULL, ;
            DPros    C(40)    NULL, ;
            ValAnt   N(14,2)  NULL, ;
            ValAtu   N(14,2)  NULL, ;
            CustoAfs N(12,4)  NULL, ;
            CustoFs  N(12,4)  NULL, ;
            PVarias  N(8,2)   NULL, ;
            CVarias  N(8,2)   NULL  ;
        )
        SET NULL OFF
        SELECT cursor_4c_Dados
        INDEX ON CPros TAG CPros
        SET ORDER TO
        GO TOP
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConstruirWhereClause - Constroi clausula WHERE a partir das propriedades de filtro
    * Retorna: string com condicoes (sem a palavra WHERE)
    *--------------------------------------------------------------------------
    FUNCTION ConstruirWhereClause()
        LOCAL loc_nConta, loc_lcWhere, loc_lcInicio, loc_lcFinal
        LOCAL loc_laCampo(7), loc_laVarI(7), loc_laVarF(7)

        loc_laCampo(1) = "CGrus"
        loc_laCampo(2) = "Cunis"
        loc_laCampo(3) = "Linhas"
        loc_laCampo(4) = "Colecoes"
        IF THIS.this_nFoption1 = 2
            loc_laCampo(5) = "Moevs"
        ELSE
            loc_laCampo(5) = "Moedas"
        ENDIF
        loc_laCampo(6) = "SGrus"
        loc_laCampo(7) = "Mercs"

        loc_laVarI(1) = ALLTRIM(THIS.this_cGruI)
        loc_laVarI(2) = ALLTRIM(THIS.this_cCuniI)
        loc_laVarI(3) = ALLTRIM(THIS.this_cLinI)
        loc_laVarI(4) = ALLTRIM(THIS.this_cColI)
        loc_laVarI(5) = ALLTRIM(THIS.this_cMoeI)
        loc_laVarI(6) = ALLTRIM(THIS.this_cSGruI)
        loc_laVarI(7) = ALLTRIM(THIS.this_cMercI)

        loc_laVarF(1) = ALLTRIM(THIS.this_cGruF)
        loc_laVarF(2) = ALLTRIM(THIS.this_cCuniF)
        loc_laVarF(3) = ALLTRIM(THIS.this_cLinF)
        loc_laVarF(4) = ALLTRIM(THIS.this_cColF)
        loc_laVarF(5) = ALLTRIM(THIS.this_cMoeF)
        loc_laVarF(6) = ALLTRIM(THIS.this_cSGruF)
        loc_laVarF(7) = ALLTRIM(THIS.this_cMercF)

        loc_lcWhere = " "
        FOR loc_nConta = 1 TO 7
            loc_lcInicio = loc_laVarI(loc_nConta)
            loc_lcFinal  = loc_laVarF(loc_nConta)

            IF (loc_nConta > 1) AND ;
               (!EMPTY(loc_lcInicio) OR !EMPTY(loc_lcFinal)) AND ;
               !EMPTY(ALLTRIM(loc_lcWhere))
                loc_lcWhere = loc_lcWhere + " AND "
            ENDIF

            IF EMPTY(loc_lcInicio)
                IF !EMPTY(loc_lcFinal)
                    loc_lcWhere = loc_lcWhere + loc_laCampo(loc_nConta) + " <= '" + loc_lcFinal + "'"
                ENDIF
            ELSE
                IF EMPTY(loc_lcFinal)
                    loc_lcWhere = loc_lcWhere + loc_laCampo(loc_nConta) + " >= '" + loc_lcInicio + "'"
                ELSE
                    loc_lcWhere = loc_lcWhere + loc_laCampo(loc_nConta) + ;
                                  " BETWEEN '" + loc_lcInicio + "' AND '" + loc_lcFinal + "'"
                ENDIF
            ENDIF
        ENDFOR

        loc_lcWhere = ALLTRIM(loc_lcWhere)
        IF EMPTY(loc_lcWhere)
            loc_lcWhere = "1=1"
        ENDIF

        *-- Filtro situacao (Ativos=1, Inativos=2, Todos=3)
        IF THIS.this_nSituacao = 1 OR THIS.this_nSituacao = 2
            loc_lcWhere = loc_lcWhere + " AND Situas = " + TRANSFORM(THIS.this_nSituacao)
        ENDIF

        *-- Filtro fornecedor
        IF !EMPTY(ALLTRIM(THIS.this_cFornecs))
            loc_lcWhere = loc_lcWhere + " AND Ifors = '" + ALLTRIM(THIS.this_cFornecs) + "'"
        ENDIF

        *-- Filtro compra/ForaLinha (1=Comprar, 2=NaoComprar, 3=Todos)
        IF THIS.this_nCompra = 1
            loc_lcWhere = loc_lcWhere + " AND ForaLinha = 0"
        ENDIF
        IF THIS.this_nCompra = 2
            loc_lcWhere = loc_lcWhere + " AND ForaLinha = 1"
        ENDIF

        RETURN loc_lcWhere
    ENDFUNC

    *--------------------------------------------------------------------------
    * Processar - Recalcula precos dos produtos conforme parametros definidos
    * nas propriedades this_* do BO.
    * Retorna .T. se processamento bem-sucedido, .F. se erro.
    * Apos Processar(): cursor_4c_Dados e CrSigCdPro ficam prontos para AtualizarPrecos()
    *--------------------------------------------------------------------------
    PROCEDURE Processar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_lnMrki, loc_lnMrkf, loc_lnEncI, loc_lnEncF
        LOCAL loc_lcWhere, loc_lcQuery
        LOCAL loc_lnArred, loc_lnPvenda, loc_lnReajuste, loc_lnMarkup, loc_lnEncarg
        LOCAL loc_lnTpRecal, loc_lcFeitio, loc_lnOpcaoM
        LOCAL loc_lcFtiNew

        loc_lSucesso = .F.

        loc_lnMrki     = THIS.this_nMrkI
        loc_lnMrkf     = THIS.this_nMrkF
        loc_lnEncI     = THIS.this_nEncI
        loc_lnEncF     = THIS.this_nEncF
        loc_lnArred    = IIF(THIS.this_nArreds = 0, 1, THIS.this_nArreds)
        loc_lnPvenda   = THIS.this_nPven
        loc_lnReajuste = 1 + (THIS.this_nReajuste / 100)
        loc_lnMarkup   = THIS.this_nNMrk
        loc_lnEncarg   = THIS.this_nEncargo
        loc_lnTpRecal  = THIS.this_nRecalc
        loc_lcFeitio   = ALLTRIM(THIS.this_cFeitio)
        loc_lnOpcaoM   = THIS.this_nFoption1
        loc_lcFtiNew   = ALLTRIM(THIS.this_cNewMkp)

        IF INLIST(loc_lnTpRecal, 7, 8) AND EMPTY(loc_lcFtiNew)
            IF !THIS.this_lAutomatico
                MsgAviso("Favor Informar o Novo C" + CHR(243) + "digo do MKP!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
            RETURN .F.
        ENDIF

        *-- Construir clausula WHERE e carregar produtos
        loc_lcWhere = THIS.ConstruirWhereClause()

        loc_lcQuery = "SELECT * FROM SigCdPro " + ;
                      "WHERE " + loc_lcWhere + ;
                      IIF(loc_lnMrki > 0, " AND Margems BETWEEN " + ;
                          FormatarNumeroSQL(loc_lnMrki) + " AND " + ;
                          FormatarNumeroSQL(loc_lnMrkf), "") + ;
                      IIF(loc_lnEncI > 0, " AND Encargos BETWEEN " + ;
                          FormatarNumeroSQL(loc_lnEncI) + " AND " + ;
                          FormatarNumeroSQL(loc_lnEncF), "") + ;
                      IIF(!EMPTY(loc_lcFeitio), " AND ( cFtios = '" + loc_lcFeitio + ;
                          "' OR cFtioCs = '" + loc_lcFeitio + "' )", "")

        IF USED("CrSigCdPro")
            USE IN CrSigCdPro
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "CrSigCdPro")
        IF loc_nResult < 1
            IF !THIS.this_lAutomatico
                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + CHR(227) + "o (CrSigCdPro)")
            ENDIF
            RETURN .F.
        ENDIF
        SELECT CrSigCdPro
        INDEX ON CPros TAG CPros

        *-- Estrutura de composicao vazia para acumular calculos de todos produtos
        loc_lcQuery = "SELECT * FROM SigPrCpo WHERE 1=0"
        IF USED("TmpPrCpo")
            USE IN TmpPrCpo
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "TmpPrCpo")
        IF loc_nResult < 1
            IF !THIS.this_lAutomatico
                MsgErro("Favor Reinicializar o Processo!!!", "Falha (TmpPrCpo)")
            ENDIF
            RETURN .F.
        ENDIF
        SELECT TmpPrCpo
        INDEX ON CPros TAG CPros

        *-- Feitios de markup (SigPrFti)
        IF USED("CrSigPrFti")
            USE IN CrSigPrFti
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigPrFti", "CrSigPrFti")
        IF loc_nResult < 1
            IF !THIS.this_lAutomatico
                MsgErro("Favor Reinicializar o Processo!!!", "Falha (CrSigPrFti)")
            ENDIF
            RETURN .F.
        ENDIF
        SELECT CrSigPrFti
        INDEX ON Cods TAG Cods

        *-- Feitios por grupo (SigPrFto + SigCdGrp)
        IF USED("CrSigPrFtiG")
            USE IN CrSigPrFtiG
        ENDIF
        loc_cSQL = "SELECT a.*, b.Dgrus FROM SigPrFto a, SigCdGrp b " + ;
                   "WHERE a.Cgrus = b.Cgrus AND a.Cgrus <> ' '"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigPrFtiG")
        IF loc_nResult < 1
            IF !THIS.this_lAutomatico
                MsgErro("Favor Reinicializar o Processo!!!", "Falha (CrSigPrFtiG)")
            ENDIF
            RETURN .F.
        ENDIF
        SELECT CrSigPrFtiG
        INDEX ON Cods TAG Cods

        *-- Feitios por produto (SigPrFto + SigCdPro)
        IF USED("CrSigPrFtiP")
            USE IN CrSigPrFtiP
        ENDIF
        loc_cSQL = "SELECT a.*, b.Dpros FROM SigPrFto a, SigCdPro b " + ;
                   "WHERE a.Cpros = b.Cpros AND a.CGrus = ' '"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigPrFtiP")
        IF loc_nResult < 1
            IF !THIS.this_lAutomatico
                MsgErro("Favor Reinicializar o Processo!!!", "Falha (CrSigPrFtiP)")
            ENDIF
            RETURN .F.
        ENDIF
        SELECT CrSigPrFtiP
        INDEX ON Cods TAG Cods

        *-- Cursor acumulador de totais por grupo/produto/moeda (para calculo de feitio de venda)
        IF USED("TotGrupo")
            USE IN TotGrupo
        ENDIF
        CREATE CURSOR TotGrupo (Grupo C(3), Cpros C(14), ValGrupo N(12,3), Moeda C(3))
        INDEX ON Grupo+Cpros+Moeda TAG GruMoe

        *-- Preparar cursor_4c_Dados (grid de resultados)
        THIS.CriarCursorDados()

        TRY
            IF loc_lnTpRecal = 4
                *------------------------------------------------------------------
                *-- CASO 4: Recalculo de Pesos dos Componentes
                *------------------------------------------------------------------
                SELECT CrSigCdPro
                GO TOP
                SCAN
                    THIS.this_cPro = ALLTRIM(CrSigCdPro.CPros)
                    loc_cSQL = "SELECT * FROM SigPrCpo WHERE CPros = '" + THIS.this_cPro + "'"
                    IF USED("TmpCompo")
                        USE IN TmpCompo
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpCompo")
                    IF loc_nResult < 1
                        IF !THIS.this_lAutomatico
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha (TmpCompo)")
                        ENDIF
                        loc_lSucesso = .F.
                    ENDIF

                    LOCAL loc_llAtu
                    loc_llAtu = .F.

                    SELECT TmpCompo
                    SCAN
                        LOCAL loc_lnMtlP, loc_lnValP
                        loc_lnMtlP = 1
                        IF !EMPTY(ALLTRIM(TmpCompo.Mats))
                            loc_cSQL = "SELECT a.PesoMs, b.CfgGerGprs " + ;
                                       "FROM SigCdPro a, SigCdGrp b " + ;
                                       "WHERE a.CPros = '" + ALLTRIM(TmpCompo.Mats) + "' " + ;
                                       "AND a.CGrus = b.CGrus"
                            IF USED("LocalProCp")
                                USE IN LocalProCp
                            ENDIF
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalProCp")
                            IF loc_nResult < 1
                                IF !THIS.this_lAutomatico
                                    MsgErro("Favor Reinicializar o Processo!!!", "Falha (LocalProCp)")
                                ENDIF
                                loc_lSucesso = .F.
                            ENDIF
                            GO TOP IN LocalProCp
                            IF !EOF("LocalProCp") AND (LocalProCp.PesoMs > 0) AND ;
                               (INT(VAL(SUBSTR(ALLTRIM(LocalProCp.CfgGerGprs), 9, 1))) > 1)
                                IF INT(VAL(SUBSTR(ALLTRIM(LocalProCp.CfgGerGprs), 9, 1))) = 2
                                    IF !EMPTY(ALLTRIM(TmpCompo.UniCompos))
                                        IF !EMPTY(ALLTRIM(TmpCompo.CUniPs)) AND (TmpCompo.Pesos > 0)
                                            loc_lnMtlP = TmpCompo.Pesos
                                        ENDIF
                                        loc_lnValP = LocalProCp.PesoMs * loc_lnMtlP
                                        loc_cSQL = "UPDATE SigPrCpo SET Qtds = " + ;
                                                   FormatarNumeroSQL(loc_lnValP) + ;
                                                   " WHERE cIdChaves = '" + ALLTRIM(TmpCompo.cIdChaves) + "'"
                                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                            IF !THIS.this_lAutomatico
                                                MsgAviso("Os Pesos N" + CHR(227) + "o Foram Calculados!", "Aten" + CHR(231) + CHR(227) + "o!!!")
                                            ENDIF
                                            loc_lSucesso = .F.
                                        ENDIF
                                        loc_llAtu = .T.
                                    ENDIF
                                ELSE
                                    IF !EMPTY(ALLTRIM(TmpCompo.CUniPs))
                                        IF !EMPTY(ALLTRIM(TmpCompo.UniCompos)) AND (TmpCompo.Qtds > 0)
                                            loc_lnMtlP = TmpCompo.Qtds
                                        ENDIF
                                        loc_lnValP = LocalProCp.PesoMs * loc_lnMtlP
                                        loc_cSQL = "UPDATE SigPrCpo SET Pesos = " + ;
                                                   FormatarNumeroSQL(loc_lnValP) + ;
                                                   " WHERE cIdChaves = '" + ALLTRIM(TmpCompo.cIdChaves) + "'"
                                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                            IF !THIS.this_lAutomatico
                                                MsgAviso("Os Pesos N" + CHR(227) + "o Foram Calculados!", "Aten" + CHR(231) + CHR(227) + "o!!!")
                                            ENDIF
                                            loc_lSucesso = .F.
                                        ENDIF
                                        loc_llAtu = .T.
                                    ENDIF
                                ENDIF
                                IF USED("LocalProCp")
                                    USE IN LocalProCp
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDSCAN

                    IF loc_llAtu
                        SELECT cursor_4c_Dados
                        INSERT INTO cursor_4c_Dados (lMarca, CPros, DPros) ;
                            VALUES (0, CrSigCdPro.CPros, CrSigCdPro.DPros)
                    ENDIF

                    IF USED("TmpCompo")
                        USE IN TmpCompo
                    ENDIF
                    SELECT CrSigCdPro
                ENDSCAN

            ELSE
                *------------------------------------------------------------------
                *-- CASO GERAL: Recalculo de precos (todos os outros lnTpRecal)
                *------------------------------------------------------------------
                SELECT CrSigCdPro
                GO TOP
                SCAN
                    LOCAL loc_lnTQtde, loc_lnTotal, loc_lnTotCv, loc_lnTotpCv, loc_lnTotEstM
                    LOCAL loc_lnMoec, loc_lnMoecf, loc_lnMoedac, loc_lnMoeft
                    LOCAL loc_lnMoep, loc_lnMoev
                    LOCAL loc_lnCusto, loc_lnfPeso, loc_lnFator, loc_lnFeitio, loc_lnFeitioC
                    LOCAL loc_lnIdeal, loc_lnIdealCv, loc_lnMarkUpa, loc_lnCustof
                    LOCAL loc_lcMarkCus, loc_lcMarkVen, loc_lcFtioV
                    LOCAL loc_lcMoeAlias, loc_lnQtdeqs

                    THIS.this_cPro = ALLTRIM(CrSigCdPro.CPros)

                    IF EMPTY(ALLTRIM(CrSigCdPro.Moedas))
                        REPLACE Moedas WITH CrSigCdPro.Moecs IN CrSigCdPro
                    ENDIF

                    *-- Carregar composicao do produto via SQL
                    loc_cSQL = "SELECT * FROM SigPrCpo WHERE Cpros = '" + THIS.this_cPro + "'"
                    IF USED("CrSigPrCpo")
                        USE IN CrSigPrCpo
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigPrCpo")
                    IF loc_nResult < 1
                        IF !THIS.this_lAutomatico
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha (CrSigPrCpo)")
                        ENDIF
                        loc_lSucesso = .F.
                    ENDIF
                    SELECT CrSigPrCpo
                    INDEX ON CPros TAG CPros

                    *-- Registrar no grid: codigo, descricao, valor anterior, custo anterior
                    SELECT cursor_4c_Dados
                    INSERT INTO cursor_4c_Dados (lMarca, CPros, DPros, ValAnt, CustoAfs) ;
                        VALUES (0, CrSigCdPro.CPros, CrSigCdPro.DPros, ;
                                CrSigCdPro.Pvens, CrSigCdPro.CustoFs)

                    STORE 0 TO loc_lnTQtde, loc_lnTotal, loc_lnTotCv, loc_lnTotpCv, loc_lnTotEstM

                    *-- Limpar TotGrupo para este produto
                    SELECT TotGrupo
                    ZAP

                    *-- Calcular taxa cambio moeda custo (Moecs)
                    loc_lcMoeAlias = ALLTRIM(CrSigCdPro.Moecs)
                    IF !EMPTY(loc_lcMoeAlias) AND SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                        loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                        loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                    ELSE
                        loc_lnQtdeqs = 1
                    ENDIF
                    loc_lnMoec = fBuscarCotacao(loc_lcMoeAlias, DATE()) * loc_lnQtdeqs

                    *-- Taxa cambio moeda principal (Moedas) para acumulo do SCAN
                    loc_lcMoeAlias = ALLTRIM(CrSigCdPro.Moedas)
                    IF !EMPTY(loc_lcMoeAlias) AND SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                        loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                        loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                    ELSE
                        loc_lnQtdeqs = 1
                    ENDIF
                    loc_lnMoedac = fBuscarCotacao(loc_lcMoeAlias, DATETIME()) * loc_lnQtdeqs

                    =SEEK(ALLTRIM(CrSigCdPro.Cgrus), "CrSigCdGrp", "Cgrus")

                    *--------------------------------------------------------------
                    *-- SCAN componentes da composicao
                    *--------------------------------------------------------------
                    SELECT CrSigPrCpo
                    =SEEK(THIS.this_cPro, "CrSigPrCpo", "CPros")
                    SCAN WHILE ALLTRIM(CPros) = THIS.this_cPro
                        LOCAL loc_llOk, loc_lnMoem, loc_lnMoevC
                        loc_lnMoem = 1
                        loc_lnMoevC = 1

                        IF EMPTY(ALLTRIM(CrSigPrCpo.Mats))
                            LOOP
                        ENDIF

                        loc_llOk = .T.

                        *-- Verificar material principal (excluir da composicao)
                        loc_cSQL = "SELECT DISTINCT MatPrincs FROM SigCdPro " + ;
                                   "WHERE MatPrincs <> Space(14) AND MatPrincs = '" + ;
                                   ALLTRIM(CrSigPrCpo.Mats) + "'"
                        IF USED("crMatPrinc")
                            USE IN crMatPrinc
                        ENDIF
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crMatPrinc")
                        IF loc_nResult >= 1 AND RECCOUNT("crMatPrinc") >= 1
                            loc_llOk = .F.
                        ENDIF

                        IF loc_llOk
                            loc_cSQL = "SELECT Custofs, MoeCusfs, Cunis, Cgrus, Moevs, cUniPs, pVens " + ;
                                       "FROM SigCdPro WHERE Cpros = '" + ALLTRIM(CrSigPrCpo.Mats) + "'"
                            IF USED("CrCompoPro")
                                USE IN CrCompoPro
                            ENDIF
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrCompoPro")
                            IF loc_nResult < 1
                                IF !THIS.this_lAutomatico
                                    MsgErro("Favor Reinicializar o Processo!!!", "Falha (CrCompoPro)")
                                ENDIF
                                loc_lSucesso = .F.
                            ENDIF

                            =SEEK(ALLTRIM(CrSigPrCpo.Cgrus), "CrSigCdGrp", "Cgrus")

                            IF !EOF("CrCompoPro") AND (loc_lnTpRecal <> 2)
                                IF CrSigCdGrp.pvCompos = 2
                                    REPLACE PCompos WITH CrCompoPro.Pvens, ;
                                            Moeds   WITH CrCompoPro.Moevs ;
                                            IN CrSigPrCpo
                                ELSE
                                    REPLACE PCompos WITH CrCompoPro.CustoFs, ;
                                            Moeds   WITH CrCompoPro.MoeCusfs ;
                                            IN CrSigPrCpo
                                ENDIF
                                REPLACE UniCompos WITH CrCompoPro.Cunis, ;
                                        CUniPs    WITH CrCompoPro.CUniPs, ;
                                        Cgrus     WITH CrCompoPro.Cgrus, ;
                                        DtMovs    WITH DATETIME() ;
                                        IN CrSigPrCpo
                            ENDIF

                            LOCAL loc_lnValgr
                            loc_lnValgr = CrSigPrCpo.PCompos * ;
                                          IIF(CrSigCdGrp.chkInstalas = 2, CrSigPrCpo.Pesos, CrSigPrCpo.Qtds)

                            SELECT TotGrupo
                            SET ORDER TO GruMoe
                            IF !SEEK(ALLTRIM(CrSigPrCpo.Cgrus)+ALLTRIM(CrSigPrCpo.CPros)+ALLTRIM(CrSigPrCpo.Moeds))
                                INSERT INTO TotGrupo (Grupo, Cpros, Moeda) ;
                                    VALUES (CrSigPrCpo.Cgrus, CrSigPrCpo.Mats, CrSigPrCpo.Moeds)
                            ENDIF
                            REPLACE ValGrupo WITH ValGrupo + loc_lnValgr IN TotGrupo

                            *-- Taxa cambio moeda do componente
                            loc_lcMoeAlias = ALLTRIM(CrSigPrCpo.Moeds)
                            IF !EMPTY(loc_lcMoeAlias) AND SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                                loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                                loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                            ELSE
                                loc_lnQtdeqs = 1
                            ENDIF
                            loc_lnMoem = fBuscarCotacao(loc_lcMoeAlias, DATETIME()) * loc_lnQtdeqs

                            *-- Taxa cambio moeda venda do componente
                            loc_lcMoeAlias = ALLTRIM(CrCompoPro.Moevs)
                            IF !EMPTY(loc_lcMoeAlias) AND SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                                loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                                loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                            ELSE
                                loc_lnQtdeqs = 1
                            ENDIF
                            loc_lnMoevC = fBuscarCotacao(loc_lcMoeAlias, DATETIME()) * loc_lnQtdeqs

                            IF EMPTY(ALLTRIM(CrSigPrCpo.Moeds))
                                IF USED("CrCompoPro")
                                    USE IN CrCompoPro
                                ENDIF
                                SELECT CrSigPrCpo
                                LOOP
                            ENDIF

                            IF loc_lnTpRecal <> 1
                                =SEEK(ALLTRIM(CrSigPrCpo.UniCompos), "CrSigCdUni", "cUnis")
                                =SEEK(ALLTRIM(CrSigPrCpo.Cgrus), "CrSigCdGrp", "Cgrus")

                                LOCAL loc_lnVlrCvs, loc_lnQtdCvs, loc_lnMarkCv2
                                LOCAL loc_lnCotMcf, loc_lnCotMpv
                                IF CrSigCdGrp.PCustVens <> 0
                                    loc_lnVlrCvs = ROUND(CrSigPrCpo.PCompos * (1 + CrSigCdGrp.PCustVens/100), 3)
                                ELSE
                                    loc_lnVlrCvs = CrSigPrCpo.PCompos
                                ENDIF
                                IF CrSigCdUni.PCustVens <> 0
                                    loc_lnQtdCvs = ROUND(CrSigPrCpo.Qtds * (1 + CrSigCdUni.PCustVens/100), 3)
                                ELSE
                                    loc_lnQtdCvs = CrSigPrCpo.Qtds
                                ENDIF

                                IF ALLTRIM(CrSigPrCpo.Moeds) <> ALLTRIM(CrCompoPro.Moevs)
                                    loc_lcMoeAlias = ALLTRIM(CrSigPrCpo.Moeds)
                                    IF SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                                        loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                                        loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                                    ELSE
                                        loc_lnQtdeqs = 1
                                    ENDIF
                                    loc_lnCotMcf = fBuscarCotacao(loc_lcMoeAlias, DATETIME()) * loc_lnQtdeqs

                                    loc_lcMoeAlias = ALLTRIM(CrCompoPro.Moevs)
                                    IF SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                                        loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                                        loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                                    ELSE
                                        loc_lnQtdeqs = 1
                                    ENDIF
                                    loc_lnCotMpv = fBuscarCotacao(loc_lcMoeAlias, DATETIME()) * loc_lnQtdeqs

                                    loc_lnMarkCv2 = ROUND(IIF(loc_lnVlrCvs = 0, 0, ;
                                                    (CrCompoPro.Pvens * loc_lnCotMpv / IIF(loc_lnCotMcf=0,1,loc_lnCotMcf)) / loc_lnVlrCvs), 6)
                                ELSE
                                    loc_lnMarkCv2 = ROUND(IIF(loc_lnVlrCvs = 0, 0, CrCompoPro.Pvens / loc_lnVlrCvs), 6)
                                ENDIF

                                REPLACE VlrCvs  WITH loc_lnVlrCvs, ;
                                        QtdCvs  WITH loc_lnQtdCvs, ;
                                        MarkCvs WITH loc_lnMarkCv2, ;
                                        DtMovs  WITH DATETIME(), ;
                                        VlrPvs  WITH CrCompoPro.Pvens ;
                                        IN CrSigPrCpo

                                loc_lnTotCv  = loc_lnTotCv  + ((CrSigPrCpo.VlrCvs * CrSigPrCpo.QtdCvs) * loc_lnMoem / IIF(loc_lnMoec=0,1,loc_lnMoec))
                                loc_lnTotpCv = loc_lnTotpCv + ((CrSigPrCpo.VlrPvs * CrSigPrCpo.QtdCvs) * loc_lnMoevC / IIF(loc_lnMoedac=0,1,loc_lnMoedac))
                            ENDIF

                            IF USED("CrCompoPro")
                                USE IN CrCompoPro
                            ENDIF
                        ELSE
                            *-- Material principal: calcular apenas cambio do componente
                            loc_lcMoeAlias = ALLTRIM(CrSigPrCpo.Moeds)
                            IF !EMPTY(loc_lcMoeAlias) AND SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                                loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                                loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                            ELSE
                                loc_lnQtdeqs = 1
                            ENDIF
                            loc_lnMoem = fBuscarCotacao(loc_lcMoeAlias, DATETIME()) * loc_lnQtdeqs
                        ENDIF

                        IF loc_lnTpRecal <> 2
                            =SEEK(ALLTRIM(CrSigPrCpo.Cgrus), "CrSigCdGrp", "Cgrus")
                            IF INLIST(CrSigCdGrp.BPesos, 1, 3)
                                LOCAL loc_lcUniPeso, loc_lnFatorU
                                loc_lcUniPeso = IIF(CrSigCdGrp.BPesos = 1, ;
                                                    ALLTRIM(CrSigPrCpo.UniCompos), ALLTRIM(CrSigPrCpo.CUniPs))
                                IF SEEK(loc_lcUniPeso, "CrSigCdUni", "cUnis")
                                    loc_lnFatorU = IIF(CrSigCdUni.Fators = 0, 1, CrSigCdUni.Fators)
                                    SELECT CrSigPrCpo
                                    loc_lnTQtde = loc_lnTQtde + ;
                                                  (IIF(CrSigCdGrp.BPesos = 1, CrSigPrCpo.Qtds, CrSigPrCpo.Pesos) * loc_lnFatorU)
                                ENDIF
                            ENDIF
                            IF CrSigCdGrp.AtuComps <> 2
                                loc_lnTotal = loc_lnTotal + ;
                                              (CrSigPrCpo.PCompos * ;
                                               IIF(CrSigCdGrp.chkInstalas = 2, CrSigPrCpo.Pesos, CrSigPrCpo.Qtds)) * ;
                                              loc_lnMoem / IIF(loc_lnMoec=0,1,loc_lnMoec)
                            ENDIF
                        ENDIF

                        IF CrSigCdGrp.cvestims = 1
                            loc_lnTotEstM = loc_lnTotEstM + ;
                                            (CrSigPrCpo.PCompos * CrSigPrCpo.Qtds) * ;
                                            loc_lnMoem / IIF(loc_lnMoedac=0,1,loc_lnMoedac)
                        ENDIF
                        SELECT CrSigPrCpo
                    ENDSCAN

                    *-- Atualizar codigo de feitio se opcao 7 ou 8
                    SELECT CrSigCdPro
                    loc_lcMarkCus = ALLTRIM(CrSigCdPro.cftiocs)
                    loc_lcMarkVen = ALLTRIM(CrSigCdPro.cftios)
                    IF INLIST(loc_lnTpRecal, 7, 8)
                        IF loc_lnTpRecal = 7 AND !EMPTY(loc_lcFtiNew)
                            loc_lcMarkCus = loc_lcFtiNew
                        ENDIF
                        IF loc_lnTpRecal = 8 AND !EMPTY(loc_lcFtiNew)
                            loc_lcMarkVen = loc_lcFtiNew
                        ENDIF
                        REPLACE cftiocs WITH loc_lcMarkCus, ;
                                cftios  WITH loc_lcMarkVen ;
                                IN CrSigCdPro
                    ENDIF

                    *-- Acumular composicao calculada em TmpPrCpo
                    SELECT CrSigPrCpo
                    GO TOP
                    SCAN
                        SCATTER MEMO MEMVAR
                        SELECT TmpPrCpo
                        APPEND BLANK
                        GATHER MEMVAR
                        SELECT CrSigPrCpo
                    ENDSCAN

                    *-- Criar LocalTGrupo a partir de CrSigPrCpo (para calculo feitio custo)
                    IF USED("LocalTGrupo")
                        USE IN LocalTGrupo
                    ENDIF
                    SELECT Cgrus AS Grupo, Mats AS Cpros, dCompos AS Dgrus, ;
                           Moeds AS Moeda, Pesos, Qtds, PCompos, ;
                           0.000 AS ValGrupo, OrdTs ;
                    FROM CrSigPrCpo ;
                    ORDER BY 1, 2, 3 ;
                    INTO CURSOR LocalTGrupo READWRITE
                    =SEEK(ALLTRIM(CrSigCdPro.Cgrus), "CrSigCdGrp", "Cgrus")
                    UPDATE LocalTGrupo SET ValGrupo = ;
                        IIF(CrSigCdGrp.chkInstalas = 2, Pesos, Qtds) * PCompos

                    *-- Calcular pftiocs (feitio de custo) se aplicavel
                    IF !EMPTY(loc_lcMarkCus)
                        loc_cSQL = "SELECT * FROM SigPrFti WHERE Cods = '" + loc_lcMarkCus + "'"
                        IF USED("TmpFtio")
                            USE IN TmpFtio
                        ENDIF
                        SQLEXEC(gnConnHandle, loc_cSQL, "TmpFtio")
                        SELECT TmpFtio
                        IF RECCOUNT() > 0 AND TmpFtio.Acrescs = 0 AND ;
                           TmpFtio.Valors = 0 AND loc_lnTpRecal <> 2
                            loc_cSQL = "SELECT a.*, IsNull(b.Dgrus,'') AS Dgrus " + ;
                                       "FROM SigPrFto a LEFT JOIN SigCdGrp b ON a.Cgrus = b.Cgrus " + ;
                                       "WHERE a.Cods = '" + loc_lcMarkCus + "' " + ;
                                       "AND (a.Cgrus <> ' ' OR a.Ordem <> 0) ORDER BY a.Cods"
                            IF USED("TmpFtioC")
                                USE IN TmpFtioC
                            ENDIF
                            SQLEXEC(gnConnHandle, loc_cSQL, "TmpFtioC")

                            LOCAL loc_lnVacm, loc_lnVFt, loc_lnVcoef, loc_lnVadic

                            IF TmpFtio.AplsCus <> 1
                                loc_lnVacm = 0
                                loc_lnVFt  = 0
                                SELECT LocalTGrupo
                                GO TOP
                                SCAN
                                    SELECT TmpFtioC
                                    LOCATE FOR ALLTRIM(Cgrus) = ALLTRIM(LocalTGrupo.Grupo) AND ;
                                              ALLTRIM(Cpros) = ALLTRIM(LocalTGrupo.Cpros)
                                    IF EOF("TmpFtioC")
                                        LOCATE FOR ALLTRIM(Cgrus) = ALLTRIM(LocalTGrupo.Grupo) AND EMPTY(Cpros)
                                    ENDIF
                                    IF EOF("TmpFtioC")
                                        LOCATE FOR Ordem = LocalTGrupo.OrdTs AND EMPTY(Cpros)
                                    ENDIF
                                    IF !EOF("TmpFtioC")
                                        LOCAL loc_lnCoefC, loc_lnMoeFtiC, loc_lnMoeGrpC
                                        loc_lnCoefC   = IIF(EOF("TmpFtioC"), 1, TmpFtioC.Coefs)
                                        loc_lnMoeFtiC = 1
                                        loc_lnMoeGrpC = 1
                                        IF !EMPTY(ALLTRIM(TmpFtio.Moedas)) AND ;
                                           ALLTRIM(TmpFtio.Moedas) <> ALLTRIM(LocalTGrupo.Moeda)
                                            loc_lnMoeFtiC = fBuscarCotacao(ALLTRIM(TmpFtio.Moedas), DATETIME())
                                            loc_lnMoeGrpC = fBuscarCotacao(ALLTRIM(LocalTGrupo.Moeda), DATETIME())
                                        ENDIF
                                        loc_lnVcoef = ROUND(LocalTGrupo.ValGrupo * ;
                                                      loc_lnMoeGrpC / IIF(loc_lnMoeFtiC=0,1,loc_lnMoeFtiC), 3)
                                        loc_lnVadic = ROUND(loc_lnVcoef * loc_lnCoefC - loc_lnVcoef, 3)
                                        loc_lnVacm  = loc_lnVacm + loc_lnVcoef + loc_lnVadic
                                        loc_lnVFt   = loc_lnVFt + loc_lnVadic
                                    ENDIF
                                    SELECT LocalTGrupo
                                ENDSCAN
                            ELSE
                                loc_lnVacm = CrSigCdPro.PCuss
                                loc_lnVFt  = 0
                            ENDIF

                            *-- Componentes individuais de produto (ordem=0, cgrus=' ')
                            loc_cSQL = "SELECT a.*, b.Dpros FROM SigPrFto a, SigCdPro b " + ;
                                       "WHERE a.Cods = '" + loc_lcMarkCus + "' " + ;
                                       "AND a.Cpros = b.Cpros AND a.Cgrus = Space(3) AND a.Ordem = 0 " + ;
                                       "ORDER BY a.Seqs"
                            IF USED("TmpFtioC")
                                USE IN TmpFtioC
                            ENDIF
                            SQLEXEC(gnConnHandle, loc_cSQL, "TmpFtioC")
                            SELECT TmpFtioC
                            SCAN
                                loc_lnVcoef = loc_lnVacm
                                IF TmpFtio.DivMults = 1
                                    loc_lnVadic = ROUND(loc_lnVcoef * TmpFtioC.Coefs - loc_lnVcoef, 3)
                                ELSE
                                    loc_lnVadic = ROUND(loc_lnVcoef / (1 - TmpFtioC.Coefs/100) - loc_lnVcoef, 3)
                                ENDIF
                                loc_lnVacm = loc_lnVacm + loc_lnVadic
                                loc_lnVFt  = loc_lnVFt + loc_lnVadic
                            ENDSCAN
                            REPLACE pftiocs WITH loc_lnVFt IN CrSigCdPro
                        ENDIF
                    ENDIF

                    *-- Calcular pftios (feitio de markup de venda) usando TotGrupo
                    loc_lcFtioV = ALLTRIM(loc_lcMarkVen)
                    =SEEK(loc_lcFtioV, "CrSigPrFti", "Cods")
                    IF !EOF("CrSigPrFti") AND loc_lnTpRecal <> 2
                        IF CrSigPrFti.Acrescs = 0 AND CrSigPrFti.Valors = 0
                            loc_lcMoeAlias = ALLTRIM(CrSigPrFti.Moedas)
                            IF !EMPTY(loc_lcMoeAlias) AND SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                                loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                                loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                            ELSE
                                loc_lnQtdeqs = 1
                            ENDIF
                            LOCAL loc_lnMoeCftiV
                            loc_lnMoeCftiV = fBuscarCotacao(loc_lcMoeAlias, DATETIME()) * loc_lnQtdeqs

                            SELECT CrSigPrFtiG
                            SET ORDER TO Cods
                            SET KEY TO loc_lcFtioV

                            LOCAL loc_lnVacmV, loc_lnVFtV
                            loc_lnVacmV = 0
                            loc_lnVFtV  = 0

                            SELECT TotGrupo
                            SCAN
                                SELECT CrSigPrFtiG
                                LOCATE FOR ALLTRIM(Cgrus) = ALLTRIM(TotGrupo.Grupo) AND ;
                                          ALLTRIM(Cpros) = ALLTRIM(TotGrupo.Cpros)
                                IF EOF("CrSigPrFtiG")
                                    LOCATE FOR ALLTRIM(Cgrus) = ALLTRIM(TotGrupo.Grupo)
                                ENDIF

                                LOCAL loc_lnCoefV, loc_lnMoeGrpV
                                loc_lnCoefV  = IIF(EOF("CrSigPrFtiG"), 1, CrSigPrFtiG.Coefs)
                                loc_lnMoeGrpV = 1
                                IF !EMPTY(ALLTRIM(CrSigPrFti.Moedas)) AND ;
                                   ALLTRIM(CrSigPrFti.Moedas) <> ALLTRIM(TotGrupo.Moeda)
                                    loc_lnMoeGrpV = fBuscarCotacao(ALLTRIM(TotGrupo.Moeda), DATETIME())
                                    loc_lnVcoef = ROUND(TotGrupo.ValGrupo * ;
                                                  loc_lnMoeGrpV / IIF(loc_lnMoeCftiV=0,1,loc_lnMoeCftiV), 3)
                                ELSE
                                    loc_lnVcoef = TotGrupo.ValGrupo
                                ENDIF
                                loc_lnVadic  = ROUND(loc_lnVcoef * loc_lnCoefV - loc_lnVcoef, 3)
                                loc_lnVacmV  = loc_lnVacmV + loc_lnVcoef + loc_lnVadic
                                loc_lnVFtV   = loc_lnVFtV + loc_lnVadic
                                SELECT TotGrupo
                            ENDSCAN

                            SELECT CrSigPrFtiP
                            SET ORDER TO Cods
                            SET KEY TO loc_lcFtioV
                            SELECT CrSigPrFtiP
                            SCAN
                                loc_lnVcoef = loc_lnVacmV
                                IF CrSigPrFti.DivMults = 1
                                    loc_lnVadic = ROUND(loc_lnVcoef * CrSigPrFtiP.Coefs - loc_lnVcoef, 3)
                                ELSE
                                    loc_lnVadic = ROUND(loc_lnVcoef / (1 - CrSigPrFtiP.Coefs/100) - loc_lnVcoef, 3)
                                ENDIF
                                loc_lnVacmV = loc_lnVacmV + loc_lnVadic
                                loc_lnVFtV  = loc_lnVFtV + loc_lnVadic
                            ENDSCAN
                            REPLACE pftios WITH loc_lnVFtV, ;
                                    mFtios WITH CrSigPrFti.Moedas, ;
                                    Moedas WITH IIF(EMPTY(ALLTRIM(CrSigCdPro.Moedas)), ;
                                                    CrSigPrFti.Moedas, CrSigCdPro.Moedas) ;
                                    IN CrSigCdPro
                        ELSE
                            REPLACE mFtios WITH CrSigPrFti.Moedas, ;
                                    pftios WITH CrSigPrFti.Valors * CrSigCdPro.PesoMs ;
                                    IN CrSigCdPro
                        ENDIF
                    ENDIF

                    *-- Acumular peso e custo totais
                    IF loc_lnTQtde <> 0
                        REPLACE PesoMs WITH loc_lnTQtde IN CrSigCdPro
                    ENDIF
                    IF loc_lnTotal <> 0
                        REPLACE PCuss WITH loc_lnTotal IN CrSigCdPro
                    ENDIF

                    *-- Aplicar reajuste de markup e encargo
                    IF loc_lnTpRecal <> 2
                        IF loc_lnMarkup > 0
                            REPLACE Margems WITH loc_lnMarkup IN CrSigCdPro
                        ELSE
                            REPLACE Margems WITH CrSigCdPro.Margems * loc_lnReajuste IN CrSigCdPro
                        ENDIF
                        IF loc_lnEncarg <> 0
                            REPLACE Encargos WITH loc_lnEncarg IN CrSigCdPro
                        ENDIF
                    ENDIF

                    *-- Calcular preco ideal
                    loc_lnCusto   = CrSigCdPro.PCuss
                    loc_lnfPeso   = CrSigCdPro.PesoMs * CrSigCdPro.Fcustos
                    loc_lnFator   = CrSigCdPro.Margems
                    loc_lnFeitio  = CrSigCdPro.pftios
                    loc_lnFeitioC = CrSigCdPro.pftiocs

                    *-- Taxas de cambio finais para calculo de preco
                    loc_lcMoeAlias = ALLTRIM(CrSigCdPro.Moecs)
                    IF !EMPTY(loc_lcMoeAlias) AND SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                        loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                        loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                    ELSE
                        loc_lnQtdeqs = 1
                    ENDIF
                    loc_lnMoec = fBuscarCotacao(loc_lcMoeAlias, DATE()) * loc_lnQtdeqs

                    loc_lcMoeAlias = ALLTRIM(CrSigCdPro.Moepcs)
                    IF !EMPTY(loc_lcMoeAlias) AND SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                        loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                        loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                    ELSE
                        loc_lnQtdeqs = 1
                    ENDIF
                    loc_lnMoep = fBuscarCotacao(loc_lcMoeAlias, DATE()) * loc_lnQtdeqs

                    loc_lcMoeAlias = ALLTRIM(CrSigCdPro.Moevs)
                    IF !EMPTY(loc_lcMoeAlias) AND SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                        loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                        loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                    ELSE
                        loc_lnQtdeqs = 1
                    ENDIF
                    loc_lnMoev = fBuscarCotacao(loc_lcMoeAlias, DATE()) * loc_lnQtdeqs

                    loc_lcMoeAlias = ALLTRIM(CrSigCdPro.MoeCusfs)
                    IF !EMPTY(loc_lcMoeAlias) AND SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                        loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                        loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                    ELSE
                        loc_lnQtdeqs = 1
                    ENDIF
                    loc_lnMoecf = fBuscarCotacao(loc_lcMoeAlias, DATE()) * loc_lnQtdeqs

                    loc_lcMoeAlias = ALLTRIM(CrSigCdPro.Moedas)
                    IF !EMPTY(loc_lcMoeAlias) AND SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                        loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                        loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                    ELSE
                        loc_lnQtdeqs = 1
                    ENDIF
                    loc_lnMoedac = fBuscarCotacao(loc_lcMoeAlias, DATE()) * loc_lnQtdeqs

                    loc_lcMoeAlias = ALLTRIM(CrSigCdPro.mFtios)
                    IF !EMPTY(loc_lcMoeAlias) AND SEEK(loc_lcMoeAlias, "CrSigCdMoe", "Cmoes")
                        loc_lnQtdeqs  = IIF(EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)) OR CrSigCdMoe.Qtdeqs = 0, 1, CrSigCdMoe.Qtdeqs)
                        loc_lcMoeAlias = IIF(!EMPTY(ALLTRIM(CrSigCdMoe.Moeqs)), ALLTRIM(CrSigCdMoe.Moeqs), loc_lcMoeAlias)
                    ELSE
                        loc_lnQtdeqs = 1
                    ENDIF
                    loc_lnMoeft = fBuscarCotacao(loc_lcMoeAlias, DATE()) * loc_lnQtdeqs

                    *-- Ajuste de moedas do feitio
                    IF ALLTRIM(CrSigCdPro.mFtios) <> ALLTRIM(CrSigCdPro.MoeCusfs)
                        loc_lnFeitio = loc_lnFeitio * loc_lnMoeft / IIF(loc_lnMoecf=0,1,loc_lnMoecf)
                    ENDIF
                    IF ALLTRIM(CrSigCdPro.Moepcs) <> ALLTRIM(CrSigCdPro.MoeCusfs)
                        loc_lnFeitioC = loc_lnFeitioC * loc_lnMoep / IIF(loc_lnMoecf=0,1,loc_lnMoecf)
                    ENDIF
                    IF ALLTRIM(CrSigCdPro.Moecs) <> ALLTRIM(CrSigCdPro.MoeCusfs)
                        loc_lnCustof = loc_lnCusto * loc_lnMoec / IIF(loc_lnMoecf=0,1,loc_lnMoecf)
                    ELSE
                        loc_lnCustof = loc_lnCusto
                    ENDIF
                    loc_lnCustof = loc_lnCustof + loc_lnFeitioC

                    *-- Aplicar peso ou fator de custo
                    IF THIS.this_nCalcCusts = 2
                        IF ALLTRIM(CrSigCdPro.Moepcs) <> ALLTRIM(CrSigCdPro.MoeCusfs)
                            loc_lnCustof = loc_lnCustof * IIF(CrSigCdPro.Fcustos = 0, 1, ;
                                           CrSigCdPro.Fcustos * loc_lnMoep / IIF(loc_lnMoecf=0,1,loc_lnMoecf))
                        ELSE
                            loc_lnCustof = loc_lnCustof * IIF(CrSigCdPro.Fcustos = 0, 1, CrSigCdPro.Fcustos)
                        ENDIF
                    ELSE
                        IF ALLTRIM(CrSigCdPro.Moepcs) <> ALLTRIM(CrSigCdPro.MoeCusfs)
                            loc_lnCustof = loc_lnCustof + (loc_lnfPeso * loc_lnMoep / IIF(loc_lnMoecf=0,1,loc_lnMoecf))
                        ELSE
                            loc_lnCustof = loc_lnCustof + loc_lnfPeso
                        ENDIF
                    ENDIF

                    *-- Se feitio de venda sem acrescimo, zerar fator (markup)
                    LOCAL loc_lnFtioAcrescs, loc_lnFtioValors
                    loc_lnFtioAcrescs = 0
                    loc_lnFtioValors  = 0
                    loc_lcFtioV = ALLTRIM(CrSigCdPro.cftios)
                    IF !EMPTY(loc_lcFtioV) AND SEEK(loc_lcFtioV, "CrSigPrFti", "Cods")
                        loc_lnFtioAcrescs = CrSigPrFti.Acrescs
                        loc_lnFtioValors  = CrSigPrFti.Valors
                    ENDIF
                    IF !EMPTY(loc_lcFtioV) AND loc_lnFtioAcrescs = 0 AND loc_lnFtioValors = 0
                        loc_lnFator = 0
                    ENDIF

                    *-- Preco ideal
                    IF ALLTRIM(CrSigCdPro.MoeCusfs) <> ALLTRIM(CrSigCdPro.Moedas)
                        loc_lnIdeal = (loc_lnCustof + loc_lnFeitio) * ;
                                      loc_lnMoecf / IIF(loc_lnMoedac=0,1,loc_lnMoedac) * ;
                                      IIF(loc_lnFator=0,1,loc_lnFator)
                    ELSE
                        loc_lnIdeal = (loc_lnCustof + loc_lnFeitio) * IIF(loc_lnFator=0,1,loc_lnFator)
                    ENDIF

                    IF !EMPTY(loc_lcFtioV) AND loc_lnFtioAcrescs = 0 AND loc_lnFtioValors = 0
                        REPLACE Margems WITH IIF(loc_lnCustof = 0, 0, ;
                                               ROUND(loc_lnIdeal / loc_lnCustof, 6)) ;
                                IN CrSigCdPro
                    ENDIF

                    *-- IdealCv (valor ideal pelo cambio/grupo)
                    =SEEK(ALLTRIM(CrSigCdPro.Cgrus), "CrSigCdGrp", "Cgrus")
                    IF CrSigCdGrp.TpCalcPs = 4
                        loc_lnIdealCv = loc_lnCusto * CrSigCdPro.MarkupA
                    ELSE
                        loc_lnIdealCv = loc_lnIdeal
                    ENDIF

                    *-- Arredondamento por faixa de grupo
                    IF !EOF("CrSigCdGrp") AND CrSigCdGrp.Arredcs <> 0 AND CrSigCdGrp.TpCalcPs <> 2
                        LOCAL loc_lnFatArred, loc_lnSoma
                        loc_lnFatArred = CrSigCdGrp.Arredcs
                        loc_lnSoma = loc_lnFatArred
                        DO WHILE loc_lnSoma < loc_lnIdealCv
                            loc_lnSoma = loc_lnSoma + loc_lnFatArred
                        ENDDO
                        loc_lnIdealCv = loc_lnSoma
                        loc_lnIdeal = loc_lnIdealCv
                    ENDIF

                    *-- Recalculo por cambio (opcoes 5 e 6)
                    IF INLIST(loc_lnTpRecal, 5, 6)
                        LOCAL loc_lnCotId, loc_lnCotVd, loc_lnPvenCamb, loc_lnVlVen
                        loc_lnCotId   = fBuscarCotacao(ALLTRIM(CrSigCdPro.Moedas), DATETIME())
                        loc_lnCotVd   = fBuscarCotacao(ALLTRIM(CrSigCdPro.Moevs), DATETIME())
                        loc_lnPvenCamb = CrSigCdPro.Pvideals * loc_lnCotId / IIF(loc_lnCotVd=0,1,loc_lnCotVd)
                        loc_lnVlVen   = loc_lnPvenCamb / IIF(CrSigCdPro.Encargos<>0, CrSigCdPro.Encargos, 1)
                        IF loc_lnTpRecal = 6
                            loc_lnPvenCamb = INT(CrSigCdPro.Pvideals * loc_lnCotId / IIF(loc_lnCotVd=0,1,loc_lnCotVd))
                            loc_lnVlVen = INT(loc_lnPvenCamb / IIF(CrSigCdPro.Encargos<>0, CrSigCdPro.Encargos, 1))
                        ENDIF
                        SELECT CrSigCdPro
                        REPLACE Pvens WITH loc_lnVlVen
                    ENDIF

                    *-- Atualizar campos de preco em CrSigCdPro
                    IF loc_lnTpRecal <> 2
                        REPLACE CustoFs  WITH loc_lnCustof IN CrSigCdPro
                        REPLACE Pvideals WITH loc_lnIdeal  IN CrSigCdPro
                        REPLACE Pvens    WITH IIF(loc_lnPvenda = 1, ;
                                               loc_lnIdeal / IIF(CrSigCdPro.Encargos<>0, CrSigCdPro.Encargos, 1), ;
                                               CrSigCdPro.Pvens) ;
                                           IN CrSigCdPro
                        IF loc_lnTotEstM > 0
                            REPLACE Valors WITH loc_lnTotEstM IN CrSigCdPro
                        ENDIF
                    ENDIF

                    loc_lnMarkUpa = IIF(CrSigCdPro.CustoFs = 0, 0, ;
                                        ROUND((CrSigCdPro.Pvens * loc_lnMoev) / ;
                                              (CrSigCdPro.CustoFs * IIF(loc_lnMoecf=0,1,loc_lnMoecf)), 3))
                    REPLACE MarkupA WITH loc_lnMarkUpa IN CrSigCdPro

                    *-- Atualizar grid com valores calculados
                    SELECT cursor_4c_Dados
                    IF SEEK(ALLTRIM(CrSigCdPro.CPros), "cursor_4c_Dados", "CPros")
                        REPLACE ValAtu  WITH CrSigCdPro.Pvens, ;
                                CustoFs WITH CrSigCdPro.CustoFs ;
                                IN cursor_4c_Dados
                        REPLACE PVarias WITH IIF(cursor_4c_Dados.ValAnt = 0, 0, ;
                                              ((cursor_4c_Dados.ValAtu/cursor_4c_Dados.ValAnt - 1)*100)) ;
                                IN cursor_4c_Dados
                        REPLACE CVarias WITH IIF(cursor_4c_Dados.CustoAfs = 0, 0, ;
                                              ((cursor_4c_Dados.CustoFs/cursor_4c_Dados.CustoAfs - 1)*100)) ;
                                IN cursor_4c_Dados
                    ENDIF
                    SELECT CrSigCdPro
                ENDSCAN
            ENDIF

            loc_lSucesso = .T.
            THIS.this_lProcessado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro no processamento: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarPrecos - Persiste precos calculados por Processar() no banco
    * par_lAutomatico: .T. = modo automatico (sem confirmacoes)
    * Retorna .T. se atualizacao bem-sucedida
    * PRE-REQUISITO: Processar() deve ter sido chamado antes
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarPrecos(par_lAutomatico)
        LOCAL loc_lSucesso, loc_llReturn, loc_cSQL
        LOCAL loc_lcCPros, loc_lcHora, loc_lcOrigem, loc_lcIdChaves
        LOCAL loc_lnResult, loc_llImpEtiq

        loc_lSucesso = .F.
        loc_llReturn = .T.

        IF VARTYPE(par_lAutomatico) <> "L"
            par_lAutomatico = THIS.this_lAutomatico
        ENDIF

        *-- Confirmar atualizacao
        IF !par_lAutomatico
            IF !MsgConfirma("Atualiza ???", "Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os")
                RETURN .F.
            ENDIF
            loc_llImpEtiq = MsgConfirma("Confirma a Impress" + CHR(227) + "o das Etiquetas?", "")
        ELSE
            loc_llImpEtiq = .F.
        ENDIF

        *-- Selecionar apenas produtos marcados (lMarca=1)
        IF USED("CsProdutos")
            USE IN CsProdutos
        ENDIF
        SELECT * FROM cursor_4c_Dados WHERE lMarca = 1 ORDER BY CPros ;
            INTO CURSOR CsProdutos READWRITE
        SELECT CsProdutos
        GO TOP
        IF EOF()
            IF !par_lAutomatico
                MsgAviso("Nenhum Produto Selecionado !!!", "Sele" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
            ENDIF
            RETURN .F.
        ENDIF

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

            SELECT CsProdutos
            GO TOP
            SCAN
                loc_lcCPros = ALLTRIM(CsProdutos.CPros)

                *-- Verificar se produto existe em CrSigCdPro (calculado por Processar)
                IF !SEEK(loc_lcCPros, "CrSigCdPro", "CPros")
                    SELECT CsProdutos
                    LOOP
                ENDIF

                *-- Registrar historico de precos em SigCdPrc (antes da atualizacao)
                loc_lcHora   = SUBSTR(TTOC(DATETIME()), 12, 8)
                loc_lcOrigem = TTOC(DATETIME()) + " SigPrCcp"
                loc_lcIdChaves = fUniqueIds()

                loc_cSQL = "INSERT INTO SigCdPrc (" + ;
                           "cidchaves, dataalts, horaalts, usuaalts, origem, " + ;
                           "matprincs, dtcomps, cbars, cgrus, clfiscals, colecoes, comis, " + ;
                           "cpros, cunis, custofs, cvens, datas, datatrans, dpros, dtfilms, " + ;
                           "fcustos, flagctabs, fvendas, icms, ifors, linhas, locals, margems, " + ;
                           "moecs, moecusfs, moedas, moepcs, moepvs, moevs, notas, obspeds, " + ;
                           "obspes, origmercs, pcuss, pesoms, pvens, pvideals, qmins, reffs, " + ;
                           "sittricms, tcomps, tipos, transps, valors, varias, situas, dtincs, " + ;
                           "sgrus, metals, teors, cftios, codservs, mftios, pftios, codcors, " + ;
                           "codtams, compos, montadescs, digimaxs, ordcompos, ean13, cproeqs, " + ;
                           "qtdcpnts, impetiqs, chkfunds, casas, mercs, pesobs, tamhs, tamls, " + ;
                           "tamps, tptribs, volumes, ipis, dpro2s, encoms, codacbs, cravcers, " + ;
                           "cunips, obsetqs, ultcomps, vultcomps, multcomps, markupa, tinsts, " + ;
                           "cclass, nivelqs, cftiocs, pftiocs, usuincs, diasinas, idecpros, " + ;
                           "fabrproprs, qtminfabs, tents, codfinp, codmatp, consigs, ltminsv, " + ;
                           "status, aliqipis, codgarras, descecfs, encargos, idpro, nidentfixa, " + ;
                           "pesobris, pesometal, pesopdrs, extipi, iats, dtsituas, conjunts)" + ;
                           " SELECT " + ;
                           EscaparSQL(loc_lcIdChaves) + ", GETDATE(), " + ;
                           EscaparSQL(loc_lcHora) + ", " + ;
                           EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ", " + ;
                           EscaparSQL(loc_lcOrigem) + ", " + ;
                           "matprincs, dtcomps, cbars, cgrus, clfiscals, colecoes, comis, " + ;
                           "cpros, cunis, custofs, cvens, datas, datatrans, dpros, dtfilms, " + ;
                           "fcustos, flagctabs, fvendas, icms, ifors, linhas, locals, margems, " + ;
                           "moecs, moecusfs, moedas, moepcs, moepvs, moevs, notas, obspeds, " + ;
                           "obspes, origmercs, pcuss, pesoms, pvens, pvideals, qmins, reffs, " + ;
                           "sittricms, tcomps, tipos, transps, valors, varias, situas, dtincs, " + ;
                           "sgrus, metals, teors, cftios, codservs, mftios, pftios, codcors, " + ;
                           "codtams, compos, montadescs, digimaxs, ordcompos, ean13, cproeqs, " + ;
                           "qtdcpnts, impetiqs, chkfunds, casas, mercs, pesobs, tamhs, tamls, " + ;
                           "tamps, tptribs, volumes, ipis, dpro2s, encoms, codacbs, cravcers, " + ;
                           "cunips, obsetqs, ultcomps, vultcomps, multcomps, markupa, tinsts, " + ;
                           "cclass, nivelqs, cftiocs, pftiocs, usuincs, diasinas, idecpros, " + ;
                           "fabrproprs, qtminfabs, tents, codfinp, codmatp, consigs, ltminsv, " + ;
                           "status, aliqipis, codgarras, descecfs, encargos, idpro, nidentfixa, " + ;
                           "pesobris, pesometal, pesopdrs, extipi, iats, dtsituas, conjunts " + ;
                           "FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_lcCPros)
                loc_lnResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_lnResult < 1
                    IF !par_lAutomatico
                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (SigCdPrc)")
                    ENDIF
                    loc_llReturn = .F.
                    EXIT
                ENDIF

                *-- Historico de composicao em SigPrCp2
                SELECT TmpPrCpo
                SET ORDER TO CPros
                =SEEK(loc_lcCPros, "TmpPrCpo", "CPros")
                SCAN WHILE ALLTRIM(CPros) = loc_lcCPros
                    loc_lcIdChaves = fUniqueIds()
                    loc_lcHora     = SUBSTR(TTOC(DATETIME()), 12, 8)
                    loc_cSQL = "INSERT INTO SIGPRCP2 (" + ;
                               "cidchaves, dataalts, horaalts, usuaalts, " + ;
                               "cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, " + ;
                               "grupos, mats, moeds, obscompos, ordems, pcompos, qtds, " + ;
                               "qtscons, unicompos, compos, ordcompos, qtdcvs, vlrcvs, " + ;
                               "dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, " + ;
                               "ordts, tipos, matriz, obsofs) VALUES (" + ;
                               EscaparSQL(loc_lcIdChaves) + ", GETDATE(), " + ;
                               EscaparSQL(loc_lcHora) + ", " + ;
                               EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.cats))      + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.cgrus))     + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.cpros))     + ", " + ;
                               "NULL, " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.dcompos))   + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.dscgrp))    + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.etiqs))     + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.grupos))    + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.mats))      + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.moeds))     + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.obscompos)) + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.ordems)   + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.pcompos)  + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.qtds)     + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.qtscons)  + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.unicompos)) + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.compos))   + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.ordcompos) + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.qtdcvs)   + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.vlrcvs)   + ", " + ;
                               "GETDATE(), " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.cunips))    + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.markcvs)  + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.pesos)    + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.totas)    + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.tpalts)   + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.vlrpvs)   + ", " + ;
                               FormatarNumeroSQL(TmpPrCpo.ordts)    + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.tipos))    + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.matriz))   + ", " + ;
                               EscaparSQL(ALLTRIM(TmpPrCpo.obsofs))   + ")"
                    loc_lnResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_lnResult < 1
                        IF !par_lAutomatico
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha (SigPrCp2)")
                        ENDIF
                        loc_llReturn = .F.
                        EXIT
                    ENDIF
                    SELECT TmpPrCpo
                ENDSCAN

                IF !loc_llReturn
                    EXIT
                ENDIF

                *-- Deletar SigPrPrt para este produto
                SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigPrPrt WHERE CPros = " + EscaparSQL(loc_lcCPros))

                *-- Atualizar preco principal em SigCdPro
                SELECT CrSigCdPro
                IF SEEK(loc_lcCPros, "CrSigCdPro", "CPros")
                    loc_cSQL = "UPDATE SigCdPro SET " + ;
                               "CustoFs  = " + FormatarNumeroSQL(CrSigCdPro.CustoFs)  + ", " + ;
                               "Pvideals = " + FormatarNumeroSQL(CrSigCdPro.Pvideals) + ", " + ;
                               "Pvens    = " + FormatarNumeroSQL(CrSigCdPro.Pvens)    + ", " + ;
                               "Margems  = " + FormatarNumeroSQL(CrSigCdPro.Margems)  + ", " + ;
                               "Encargos = " + FormatarNumeroSQL(CrSigCdPro.Encargos) + ", " + ;
                               "PesoMs   = " + FormatarNumeroSQL(CrSigCdPro.PesoMs)   + ", " + ;
                               "PCuss    = " + FormatarNumeroSQL(CrSigCdPro.PCuss)    + ", " + ;
                               "MarkupA  = " + FormatarNumeroSQL(CrSigCdPro.MarkupA)  + ", " + ;
                               "pftios   = " + FormatarNumeroSQL(CrSigCdPro.pftios)   + ", " + ;
                               "mFtios   = " + EscaparSQL(ALLTRIM(CrSigCdPro.mFtios)) + ", " + ;
                               "Moedas   = " + EscaparSQL(ALLTRIM(CrSigCdPro.Moedas)) + ", " + ;
                               "pftiocs  = " + FormatarNumeroSQL(CrSigCdPro.pftiocs)  + ", " + ;
                               "cftios   = " + EscaparSQL(ALLTRIM(CrSigCdPro.cftios)) + ", " + ;
                               "cftiocs  = " + EscaparSQL(ALLTRIM(CrSigCdPro.cftiocs))+ ", " + ;
                               "Valors   = " + FormatarNumeroSQL(CrSigCdPro.Valors)   + ", " + ;
                               "ImpEtiqs = " + IIF(loc_llImpEtiq, "1", "0") + " " + ;
                               "WHERE cpros = " + EscaparSQL(loc_lcCPros)
                    loc_lnResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_lnResult < 1
                        IF !par_lAutomatico
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha UPDATE SigCdPro")
                        ENDIF
                        loc_llReturn = .F.
                        EXIT
                    ENDIF
                ENDIF

                *-- Atualizar composicao em SigPrCpo com valores calculados
                SELECT TmpPrCpo
                SET ORDER TO CPros
                =SEEK(loc_lcCPros, "TmpPrCpo", "CPros")
                SCAN WHILE ALLTRIM(CPros) = loc_lcCPros
                    loc_cSQL = "UPDATE SigPrCpo SET " + ;
                               "PCompos   = " + FormatarNumeroSQL(TmpPrCpo.PCompos)   + ", " + ;
                               "Moeds     = " + EscaparSQL(ALLTRIM(TmpPrCpo.Moeds))   + ", " + ;
                               "UniCompos = " + EscaparSQL(ALLTRIM(TmpPrCpo.UniCompos))+ ", " + ;
                               "CUniPs    = " + EscaparSQL(ALLTRIM(TmpPrCpo.CUniPs))  + ", " + ;
                               "Cgrus     = " + EscaparSQL(ALLTRIM(TmpPrCpo.Cgrus))   + ", " + ;
                               "DtMovs    = GETDATE(), " + ;
                               "VlrCvs    = " + FormatarNumeroSQL(TmpPrCpo.VlrCvs)   + ", " + ;
                               "QtdCvs    = " + FormatarNumeroSQL(TmpPrCpo.QtdCvs)   + ", " + ;
                               "MarkCvs   = " + FormatarNumeroSQL(TmpPrCpo.MarkCvs)  + ", " + ;
                               "VlrPvs    = " + FormatarNumeroSQL(TmpPrCpo.VlrPvs)   + " " + ;
                               "WHERE cIdChaves = " + EscaparSQL(ALLTRIM(TmpPrCpo.cIdChaves))
                    SQLEXEC(gnConnHandle, loc_cSQL)
                    SELECT TmpPrCpo
                ENDSCAN

                SELECT CsProdutos
            ENDSCAN

            *-- Atualizar subgrupo por faixa de preco (se configurado)
            IF loc_llReturn AND THIS.this_nNChkSubGrs = 1
                SELECT CrSigCdPro
                GO TOP
                SCAN
                    IF !SEEK(ALLTRIM(CrSigCdPro.CPros), "cursor_4c_Dados", "CPros")
                        SELECT CrSigCdPro
                        LOOP
                    ENDIF
                    IF cursor_4c_Dados.lMarca <> 1
                        SELECT CrSigCdPro
                        LOOP
                    ENDIF
                    loc_cSQL = "SELECT * FROM SigCdPsg WHERE CGrus = '" + ALLTRIM(CrSigCdPro.cGrus) + ;
                               "' ORDER BY nFaixaFins"
                    IF USED("csSigCdPsg")
                        USE IN csSigCdPsg
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csSigCdPsg")
                    IF loc_nResult < 1
                        IF !par_lAutomatico
                            MsgErro("Favor reinicializar o processo !!!", "Falha (csSigCdPsg)")
                        ENDIF
                        loc_llReturn = .F.
                        EXIT
                    ENDIF
                    LOCAL loc_lnPVens
                    loc_lnPVens = IIF(CrSigCdPro.pVens = 0, CrSigCdPro.pvideals, CrSigCdPro.pVens)
                    SELECT csSigCdPsg
                    LOCATE FOR nFaixaFins >= loc_lnPVens
                    IF !EOF("csSigCdPsg")
                        loc_cSQL = "UPDATE SigCdPro SET sGrus = " + ;
                                   EscaparSQL(ALLTRIM(csSigCdPsg.Codigos)) + ;
                                   " WHERE cpros = " + EscaparSQL(ALLTRIM(CrSigCdPro.CPros))
                        SQLEXEC(gnConnHandle, loc_cSQL)
                    ENDIF
                    IF USED("csSigCdPsg")
                        USE IN csSigCdPsg
                    ENDIF
                    SELECT CrSigCdPro
                ENDSCAN
            ENDIF

            IF loc_llReturn
                SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                IF !par_lAutomatico
                    MsgInfo("Processamento Finalizado com Sucesso !!!", "")
                ENDIF
                loc_lSucesso = .T.
            ELSE
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                IF !par_lAutomatico
                    MsgErro("Falha na Atualiza" + CHR(231) + CHR(227) + "o. Reinicie o Processo !!!", "Arquivo")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            MsgErro("Erro ao atualizar precos: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessaAutomatico - Processa configuracoes de recalculo de SigCdCcp
    * automaticamente, sem interacao com usuario
    *--------------------------------------------------------------------------
    PROCEDURE ProcessaAutomatico()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_lnOldSel, loc_lnVaria

        loc_lSucesso = .F.
        loc_lnOldSel = SELECT()

        TRY
            loc_cSQL = "SELECT * FROM SigCdCcp WHERE Inativas <> 1"
            IF USED("crSigCdCcp")
                USE IN crSigCdCcp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCcp")
            IF loc_nResult < 1
                MsgErro("Favor Reinicializar o Processo!!!", "Falha (SigCdCcp)")
                loc_lSucesso = .F.
            ENDIF

            SELECT crSigCdCcp
            GO TOP
            SCAN
                THIS.CriarCursorDados()

                THIS.this_cFornecs  = ALLTRIM(crSigCdCcp.cfornecs)
                THIS.this_cMercI    = ALLTRIM(crSigCdCcp.merci)
                THIS.this_cMercF    = ALLTRIM(crSigCdCcp.mercf)
                THIS.this_cGruI     = ALLTRIM(crSigCdCcp.cgrui)
                THIS.this_cGruF     = ALLTRIM(crSigCdCcp.cgruf)
                THIS.this_cSGruI    = ALLTRIM(crSigCdCcp.sgrui)
                THIS.this_cSGruF    = ALLTRIM(crSigCdCcp.sgruf)
                THIS.this_cCuniI    = ALLTRIM(crSigCdCcp.cunii)
                THIS.this_cCuniF    = ALLTRIM(crSigCdCcp.cunif)
                THIS.this_cLinI     = ALLTRIM(crSigCdCcp.lini)
                THIS.this_cLinF     = ALLTRIM(crSigCdCcp.linf)
                THIS.this_cColI     = ALLTRIM(crSigCdCcp.coli)
                THIS.this_cColF     = ALLTRIM(crSigCdCcp.colf)
                THIS.this_cMoeI     = ALLTRIM(crSigCdCcp.moedai)
                THIS.this_cMoeF     = ALLTRIM(crSigCdCcp.moedaf)
                THIS.this_nFoption1 = NVL(crSigCdCcp.opcmoedatp, 1)
                THIS.this_nMrkI     = NVL(crSigCdCcp.mrki, 0)
                THIS.this_nMrkF     = NVL(crSigCdCcp.mrkf, 0)
                THIS.this_nEncI     = NVL(crSigCdCcp.enci, 0)
                THIS.this_nEncF     = NVL(crSigCdCcp.encf, 0)
                THIS.this_nVariacao = NVL(crSigCdCcp.variacao, 0)
                THIS.this_cFeitio   = ALLTRIM(crSigCdCcp.feitio)
                THIS.this_nSituacao = NVL(crSigCdCcp.opcsit, 3)
                THIS.this_nRecalc   = NVL(crSigCdCcp.opcrecalc, 1)
                THIS.this_nReajuste = NVL(crSigCdCcp.reajuste, 0)
                THIS.this_nEncargo  = NVL(crSigCdCcp.encargo, 0)
                THIS.this_nNMrk     = NVL(crSigCdCcp.nmrk, 0)
                THIS.this_nPven     = NVL(crSigCdCcp.opcpven, 2)
                THIS.this_cNewMkp   = ALLTRIM(crSigCdCcp.newmkp)

                IF THIS.Processar()
                    *-- Filtrar por variacao
                    loc_lnVaria = THIS.this_nVariacao
                    IF loc_lnVaria > 0
                        DELETE FROM cursor_4c_Dados WHERE PVarias < loc_lnVaria
                    ENDIF
                    IF loc_lnVaria < 0
                        DELETE FROM cursor_4c_Dados WHERE PVarias > loc_lnVaria
                    ENDIF
                    *-- Marcar todos como selecionados para atualizacao
                    UPDATE cursor_4c_Dados SET lMarca = 1

                    IF !THIS.AtualizarPrecos(.T.)
                        EXIT
                    ENDIF
                ENDIF

                SELECT crSigCdCcp
            ENDSCAN

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro no processamento automatico: " + loc_oErro.Message, "Erro")
        ENDTRY

        SELECT (loc_lnOldSel)
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega TODAS as colunas do cursor SigPrCpo nas
    * propriedades this_* do BO. Usado para operacoes CRUD individuais em
    * registros de composicao de produto.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor n" + CHR(227) + "o est" + CHR(225) + " aberto: " + par_cAliasCursor
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)

            *-- Chave primaria e identificacao
            THIS.this_cIdChaves  = ALLTRIM(NVL(cidchaves, ""))
            THIS.this_cCats      = ALLTRIM(NVL(cats,      ""))
            THIS.this_cCgrus     = ALLTRIM(NVL(cgrus,     ""))
            THIS.this_cCpros     = ALLTRIM(NVL(cpros,     ""))
            THIS.this_cPro       = THIS.this_cCpros

            *-- Datas
            IF TYPE(par_cAliasCursor + ".datatrans") != "U"
                THIS.this_dDatatrans = IIF(ISNULL(datatrans), {}, datatrans)
            ENDIF
            IF TYPE(par_cAliasCursor + ".dtmovs") != "U"
                THIS.this_dDtmovs = IIF(ISNULL(dtmovs), {}, dtmovs)
            ENDIF

            *-- Descricoes e textos
            THIS.this_cDcompos   = ALLTRIM(NVL(dcompos,   ""))
            THIS.this_cDscgrp    = ALLTRIM(NVL(dscgrp,    ""))
            THIS.this_cEtiqs     = ALLTRIM(NVL(etiqs,     ""))
            THIS.this_cGrupos    = ALLTRIM(NVL(grupos,    ""))
            THIS.this_cMats      = ALLTRIM(NVL(mats,      ""))
            THIS.this_cMoeds     = ALLTRIM(NVL(moeds,     ""))
            THIS.this_cObscompos = ALLTRIM(NVL(obscompos, ""))
            THIS.this_cUnicompos = ALLTRIM(NVL(unicompos, ""))
            THIS.this_cCompos    = ALLTRIM(NVL(compos,    ""))
            THIS.this_cCunips    = ALLTRIM(NVL(cunips,    ""))
            THIS.this_cTipos     = ALLTRIM(NVL(tipos,     ""))
            THIS.this_cMatriz    = ALLTRIM(NVL(matriz,    ""))
            THIS.this_cObsofs    = ALLTRIM(NVL(obsofs,    ""))

            *-- Valores numericos
            THIS.this_nOrdems    = NVL(ordems,    0)
            THIS.this_nPcompos   = NVL(pcompos,   0)
            THIS.this_nQtds      = NVL(qtds,      0)
            THIS.this_nQtscons   = NVL(qtscons,   0)
            THIS.this_nOrdcompos = NVL(ordcompos, 0)
            THIS.this_nQtdcvs    = NVL(qtdcvs,    0)
            THIS.this_nVlrcvs    = NVL(vlrcvs,    0)
            THIS.this_nMarkcvs   = NVL(markcvs,   0)
            THIS.this_nPesos     = NVL(pesos,     0)
            THIS.this_nTotas     = NVL(totas,     0)
            THIS.this_nTpalts    = NVL(tpalts,    0)
            THIS.this_nVlrpvs    = NVL(vlrpvs,    0)
            THIS.this_nOrdts     = NVL(ordts,     0)

            *-- PedraPrincipal (coluna case-sensitive no SQL Server, mas VFP e case-insensitive)
            IF TYPE(par_cAliasCursor + ".PedraPrincipal") != "U"
                THIS.this_nPedraPrincipal = NVL(PedraPrincipal, 0)
            ENDIF

            THIS.this_lNovoRegistro   = .F.
            THIS.this_lDadosAlterados = .F.

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar do cursor: " + loc_oErro.Message
            MsgErro("Erro ao carregar dados de composi" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigPrCpo (composicao de produto)
    * Chamado por BusinessBase.Salvar() quando this_lNovoRegistro = .T.
    * Registra auditoria apos INSERT bem-sucedido.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            *-- Gerar chave primaria se vazia (padrao: cpros + ordems)
            IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
                THIS.this_cIdChaves = LEFT(ALLTRIM(THIS.this_cCpros) + PADL(TRANSFORM(THIS.this_nOrdems), 6, "0"), 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigPrCpo (" + ;
                       "cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, " + ;
                       "grupos, mats, moeds, obscompos, ordems, pcompos, qtds, " + ;
                       "qtscons, unicompos, compos, ordcompos, cidchaves, qtdcvs, " + ;
                       "vlrcvs, dtmovs, cunips, markcvs, pesos, totas, tpalts, " + ;
                       "vlrpvs, ordts, tipos, matriz, obsofs, PedraPrincipal" + ;
                       ") VALUES (" + ;
                       EscaparSQL(THIS.this_cCats)      + ", " + ;
                       EscaparSQL(THIS.this_cCgrus)     + ", " + ;
                       EscaparSQL(THIS.this_cCpros)     + ", " + ;
                       IIF(EMPTY(THIS.this_dDatatrans), "NULL", FormatarDataSQL(THIS.this_dDatatrans)) + ", " + ;
                       EscaparSQL(THIS.this_cDcompos)   + ", " + ;
                       EscaparSQL(THIS.this_cDscgrp)    + ", " + ;
                       EscaparSQL(THIS.this_cEtiqs)     + ", " + ;
                       EscaparSQL(THIS.this_cGrupos)    + ", " + ;
                       EscaparSQL(THIS.this_cMats)      + ", " + ;
                       EscaparSQL(THIS.this_cMoeds)     + ", " + ;
                       EscaparSQL(THIS.this_cObscompos) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdems)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPcompos)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtscons)   + ", " + ;
                       EscaparSQL(THIS.this_cUnicompos) + ", " + ;
                       EscaparSQL(THIS.this_cCompos)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdcompos) + ", " + ;
                       EscaparSQL(THIS.this_cIdChaves)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdcvs)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nVlrcvs)    + ", " + ;
                       IIF(EMPTY(THIS.this_dDtmovs), "NULL", FormatarDataSQL(THIS.this_dDtmovs)) + ", " + ;
                       EscaparSQL(THIS.this_cCunips)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nMarkcvs)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesos)     + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTotas)     + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTpalts)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nVlrpvs)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdts)     + ", " + ;
                       EscaparSQL(THIS.this_cTipos)     + ", " + ;
                       EscaparSQL(THIS.this_cMatriz)    + ", " + ;
                       EscaparSQL(THIS.this_cObsofs)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPedraPrincipal) + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                *-- Registrar auditoria
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao inserir registro em SigPrCpo"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir composi" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente em SigPrCpo
    * Chamado por BusinessBase.Salvar() quando this_lNovoRegistro = .F.
    * Registra auditoria apos UPDATE bem-sucedido.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
            THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria vazia - n" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel atualizar"
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigPrCpo SET " + ;
                       "cats = "      + EscaparSQL(THIS.this_cCats)      + ", " + ;
                       "cgrus = "     + EscaparSQL(THIS.this_cCgrus)     + ", " + ;
                       "cpros = "     + EscaparSQL(THIS.this_cCpros)     + ", " + ;
                       "datatrans = " + IIF(EMPTY(THIS.this_dDatatrans), "NULL", FormatarDataSQL(THIS.this_dDatatrans)) + ", " + ;
                       "dcompos = "   + EscaparSQL(THIS.this_cDcompos)   + ", " + ;
                       "dscgrp = "    + EscaparSQL(THIS.this_cDscgrp)    + ", " + ;
                       "etiqs = "     + EscaparSQL(THIS.this_cEtiqs)     + ", " + ;
                       "grupos = "    + EscaparSQL(THIS.this_cGrupos)    + ", " + ;
                       "mats = "      + EscaparSQL(THIS.this_cMats)      + ", " + ;
                       "moeds = "     + EscaparSQL(THIS.this_cMoeds)     + ", " + ;
                       "obscompos = " + EscaparSQL(THIS.this_cObscompos) + ", " + ;
                       "ordems = "    + FormatarNumeroSQL(THIS.this_nOrdems)    + ", " + ;
                       "pcompos = "   + FormatarNumeroSQL(THIS.this_nPcompos)   + ", " + ;
                       "qtds = "      + FormatarNumeroSQL(THIS.this_nQtds)      + ", " + ;
                       "qtscons = "   + FormatarNumeroSQL(THIS.this_nQtscons)   + ", " + ;
                       "unicompos = " + EscaparSQL(THIS.this_cUnicompos) + ", " + ;
                       "compos = "    + EscaparSQL(THIS.this_cCompos)    + ", " + ;
                       "ordcompos = " + FormatarNumeroSQL(THIS.this_nOrdcompos) + ", " + ;
                       "qtdcvs = "    + FormatarNumeroSQL(THIS.this_nQtdcvs)    + ", " + ;
                       "vlrcvs = "    + FormatarNumeroSQL(THIS.this_nVlrcvs)    + ", " + ;
                       "dtmovs = "    + IIF(EMPTY(THIS.this_dDtmovs), "NULL", FormatarDataSQL(THIS.this_dDtmovs)) + ", " + ;
                       "cunips = "    + EscaparSQL(THIS.this_cCunips)    + ", " + ;
                       "markcvs = "   + FormatarNumeroSQL(THIS.this_nMarkcvs)   + ", " + ;
                       "pesos = "     + FormatarNumeroSQL(THIS.this_nPesos)     + ", " + ;
                       "totas = "     + FormatarNumeroSQL(THIS.this_nTotas)     + ", " + ;
                       "tpalts = "    + FormatarNumeroSQL(THIS.this_nTpalts)    + ", " + ;
                       "vlrpvs = "    + FormatarNumeroSQL(THIS.this_nVlrpvs)    + ", " + ;
                       "ordts = "     + FormatarNumeroSQL(THIS.this_nOrdts)     + ", " + ;
                       "tipos = "     + EscaparSQL(THIS.this_cTipos)     + ", " + ;
                       "matriz = "    + EscaparSQL(THIS.this_cMatriz)    + ", " + ;
                       "obsofs = "    + EscaparSQL(THIS.this_cObsofs)    + ", " + ;
                       "PedraPrincipal = " + FormatarNumeroSQL(THIS.this_nPedraPrincipal) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                *-- Registrar auditoria
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao atualizar registro em SigPrCpo"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar composi" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro atual de SigPrCpo pela chave primaria
    * Chamado por BusinessBase.Excluir() apos passar por AntesDeExcluir().
    * Registra auditoria apos DELETE bem-sucedido.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
            THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria vazia - n" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel excluir"
            RETURN .F.
        ENDIF

        TRY
            *-- Registrar auditoria ANTES do DELETE (chave ainda existe)
            THIS.RegistrarAuditoria("DELETE")

            loc_cSQL = "DELETE FROM SigPrCpo WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao excluir registro de SigPrCpo"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao excluir composi" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

