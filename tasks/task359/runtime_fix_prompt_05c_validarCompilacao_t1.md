# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05c_validarCompilacao
- Tentativa: 1/10
- Mensagem: C:\4c\projeto\app\forms\cadastros\Formccr.prg: loc_oBO.(loc_aPropNm(loc_nI)) = loc_cFisStr | Error in line 5872: Unrecognized command verb. | 

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formccr.prg):
*==============================================================================
* Formccr.prg - Fase 8/8: Form COMPLETO (consolidado)
* Formulario de Grupos de Contas Correntes (SIGCDCCR)
*
* Tabela principal: SigCdGcr (PK: codigos char(10))
* Tipo: CRUD (frmcadastro) com 4 abas internas (Geral/Cadastro/Estoque/Faturamento)
* BO: ccrBO
*==============================================================================

DEFINE CLASS Formccr AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Grupos de Contas"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_oUltimoCntFat   = .NULL.

    *--------------------------------------------------------------------------
    * Init - Retorna DODEFAULT (FormBase.Init chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formccr.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa do formulario
    * Chamado automaticamente pelo FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("ccrBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar ccrBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formccr.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        WITH loc_oPgf
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.
            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(100, 100, 100)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(100, 100, 100)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Cria containers da Page1 (Lista)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Container cabecalho cinza escuro
        loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg1.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD
        loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
        loc_oBotoes = loc_oPg1.cnt_4c_Botoes
        WITH loc_oBotoes
            .Top         = 29
            .Left        =  542
            .Width       = 390
            .Height      = 85
            .BackColor   = RGB(53, 53, 53)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar (canonico: Left=917, Width=90, Height=85)
        loc_oPg1.AddObject("cnt_4c_Saida", "Container")
        loc_oSaida = loc_oPg1.cnt_4c_Saida
        WITH loc_oSaida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de lista
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPg1.grd_4c_Lista

        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 2

        WITH loc_oGrid
            .Top                = 117
            .Left               = 26
            .Width              = 945
            .Height             = 460
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Cria containers da Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oBotoesAcao
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Container Confirmar/Cancelar (Top=33, Left=838, Width=160)
        loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
        loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
        WITH loc_oBotoesAcao
            .Top         = 33
            .Left        = 838
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- Label + TextBox Codigo
        loc_oPg2.AddObject("lbl_4c_LblCodigo", "Label")
        WITH loc_oPg2.lbl_4c_LblCodigo
            .Caption   = "C" + CHR(243) + "digo:"
            .Top       = 47
            .Left      = 39
            .Width     = 42
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPg2.txt_4c_Codigo
            .Value         = ""
            .Top           = 43
            .Left          = 83
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label + TextBox Digito
        loc_oPg2.AddObject("lbl_4c_LblDigito", "Label")
        WITH loc_oPg2.lbl_4c_LblDigito
            .Caption   = "D" + CHR(237) + "g:"
            .Top       = 47
            .Left      = 176
            .Width     = 35
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Digito", "TextBox")
        WITH loc_oPg2.txt_4c_Digito
            .Value         = ""
            .Top           = 43
            .Left          = 214
            .Width         = 19
            .Height        = 23
            .MaxLength     = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label + TextBox Descricao
        loc_oPg2.AddObject("lbl_4c_LblDescr", "Label")
        WITH loc_oPg2.lbl_4c_LblDescr
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o:"
            .Top       = 47
            .Left      = 261
            .Width     = 55
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Descr", "TextBox")
        WITH loc_oPg2.txt_4c_Descr
            .Value         = ""
            .Top           = 43
            .Left          = 318
            .Width         = 290
            .Height        = 23
            .MaxLength     = 40
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label + TextBox Interno
        loc_oPg2.AddObject("lbl_4c_LblInterno", "Label")
        WITH loc_oPg2.lbl_4c_LblInterno
            .Caption   = "Interno:"
            .Top       = 73
            .Left      = 36
            .Width     = 45
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Interno", "TextBox")
        WITH loc_oPg2.txt_4c_Interno
            .Value         = ""
            .Top           = 69
            .Left          = 83
            .Width         = 150
            .Height        = 23
            .MaxLength     = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label + TextBox Classe + DClasses
        loc_oPg2.AddObject("lbl_4c_LblClasse", "Label")
        WITH loc_oPg2.lbl_4c_LblClasse
            .Caption   = "Classe:"
            .Top       = 71
            .Left      = 276
            .Width     = 40
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Classes", "TextBox")
        WITH loc_oPg2.txt_4c_Classes
            .Value         = ""
            .Top           = 68
            .Left          = 318
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_DClasses", "TextBox")
        WITH loc_oPg2.txt_4c_DClasses
            .Value         = ""
            .Top           = 68
            .Left          = 400
            .Width         = 290
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 230)
            .ReadOnly      = .T.
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_Classes, "KeyPress",  THIS, "ClassesKeyPress")
        BINDEVENT(loc_oPg2.txt_4c_Classes, "DblClick",  THIS, "ClassesDblClick")
        BINDEVENT(loc_oPg2.txt_4c_Classes, "KeyPress", THIS, "ClassesLostFocus")

        *-- Label + OptionGroup Codificacao
        loc_oPg2.AddObject("lbl_4c_LblTpCods", "Label")
        WITH loc_oPg2.lbl_4c_LblTpCods
            .Caption   = "Codifica" + CHR(231) + CHR(227) + "o:"
            .Top       = 100
            .Left      = 17
            .Width     = 64
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("obj_4c_Opt_TpCods", "OptionGroup")
        WITH loc_oPg2.obj_4c_Opt_TpCods
            .ButtonCount = 2
            .Top         = 94
            .Left        = 83
            .Width       = 150
            .Height      = 23
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH

        loc_oPg2.obj_4c_Opt_TpCods.Buttons(1).Caption   = "Simples"
        loc_oPg2.obj_4c_Opt_TpCods.Buttons(1).Left      = 5
        loc_oPg2.obj_4c_Opt_TpCods.Buttons(1).Top       = 3
        loc_oPg2.obj_4c_Opt_TpCods.Buttons(1).Width     = 65
        loc_oPg2.obj_4c_Opt_TpCods.Buttons(1).FontName  = "Tahoma"
        loc_oPg2.obj_4c_Opt_TpCods.Buttons(1).FontSize  = 8
        loc_oPg2.obj_4c_Opt_TpCods.Buttons(1).ForeColor = RGB(90, 90, 90)
        loc_oPg2.obj_4c_Opt_TpCods.Buttons(1).Themes    = .F.

        loc_oPg2.obj_4c_Opt_TpCods.Buttons(2).Caption   = "Composto"
        loc_oPg2.obj_4c_Opt_TpCods.Buttons(2).Left      = 75
        loc_oPg2.obj_4c_Opt_TpCods.Buttons(2).Top       = 3
        loc_oPg2.obj_4c_Opt_TpCods.Buttons(2).Width     = 70
        loc_oPg2.obj_4c_Opt_TpCods.Buttons(2).FontName  = "Tahoma"
        loc_oPg2.obj_4c_Opt_TpCods.Buttons(2).FontSize  = 8
        loc_oPg2.obj_4c_Opt_TpCods.Buttons(2).ForeColor = RGB(90, 90, 90)
        loc_oPg2.obj_4c_Opt_TpCods.Buttons(2).Themes    = .F.

        *-- Label + OptionGroup Incluir Empresa
        loc_oPg2.AddObject("lbl_4c_LblTpEmps", "Label")
        WITH loc_oPg2.lbl_4c_LblTpEmps
            .Caption   = "Incluir Empresa:"
            .Top       = 97
            .Left      = 318
            .Width     = 90
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("obj_4c_Opt_TpEmps", "OptionGroup")
        WITH loc_oPg2.obj_4c_Opt_TpEmps
            .ButtonCount = 3
            .Top         = 93
            .Left        = 459
            .Width       = 225
            .Height      = 23
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH

        loc_oPg2.obj_4c_Opt_TpEmps.Buttons(1).Caption   = "N" + CHR(227) + "o"
        loc_oPg2.obj_4c_Opt_TpEmps.Buttons(1).Left      = 5
        loc_oPg2.obj_4c_Opt_TpEmps.Buttons(1).Top       = 3
        loc_oPg2.obj_4c_Opt_TpEmps.Buttons(1).Width     = 40
        loc_oPg2.obj_4c_Opt_TpEmps.Buttons(1).FontName  = "Tahoma"
        loc_oPg2.obj_4c_Opt_TpEmps.Buttons(1).FontSize  = 8
        loc_oPg2.obj_4c_Opt_TpEmps.Buttons(1).ForeColor = RGB(90, 90, 90)
        loc_oPg2.obj_4c_Opt_TpEmps.Buttons(1).Themes    = .F.

        loc_oPg2.obj_4c_Opt_TpEmps.Buttons(2).Caption   = "Sim"
        loc_oPg2.obj_4c_Opt_TpEmps.Buttons(2).Left      = 50
        loc_oPg2.obj_4c_Opt_TpEmps.Buttons(2).Top       = 3
        loc_oPg2.obj_4c_Opt_TpEmps.Buttons(2).Width     = 40
        loc_oPg2.obj_4c_Opt_TpEmps.Buttons(2).FontName  = "Tahoma"
        loc_oPg2.obj_4c_Opt_TpEmps.Buttons(2).FontSize  = 8
        loc_oPg2.obj_4c_Opt_TpEmps.Buttons(2).ForeColor = RGB(90, 90, 90)
        loc_oPg2.obj_4c_Opt_TpEmps.Buttons(2).Themes    = .F.

        loc_oPg2.obj_4c_Opt_TpEmps.Buttons(3).Caption   = "Obrigat" + CHR(243) + "rio"
        loc_oPg2.obj_4c_Opt_TpEmps.Buttons(3).Left      = 95
        loc_oPg2.obj_4c_Opt_TpEmps.Buttons(3).Top       = 3
        loc_oPg2.obj_4c_Opt_TpEmps.Buttons(3).Width     = 85
        loc_oPg2.obj_4c_Opt_TpEmps.Buttons(3).FontName  = "Tahoma"
        loc_oPg2.obj_4c_Opt_TpEmps.Buttons(3).FontSize  = 8
        loc_oPg2.obj_4c_Opt_TpEmps.Buttons(3).ForeColor = RGB(90, 90, 90)
        loc_oPg2.obj_4c_Opt_TpEmps.Buttons(3).Themes    = .F.

        *-- Label + OptionGroup Tipo
        loc_oPg2.AddObject("lbl_4c_LblTpCads", "Label")
        WITH loc_oPg2.lbl_4c_LblTpCads
            .Caption   = "Tipo:"
            .Top       = 124
            .Left      = 52
            .Width     = 30
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("obj_4c_Opt_TpCads", "OptionGroup")
        WITH loc_oPg2.obj_4c_Opt_TpCads
            .ButtonCount = 2
            .Top         = 120
            .Left        = 83
            .Width       = 150
            .Height      = 23
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH

        loc_oPg2.obj_4c_Opt_TpCads.Buttons(1).Caption   = "Pessoa F" + CHR(237) + "sica"
        loc_oPg2.obj_4c_Opt_TpCads.Buttons(1).Left      = 5
        loc_oPg2.obj_4c_Opt_TpCads.Buttons(1).Top       = 3
        loc_oPg2.obj_4c_Opt_TpCads.Buttons(1).Width     = 70
        loc_oPg2.obj_4c_Opt_TpCads.Buttons(1).FontName  = "Tahoma"
        loc_oPg2.obj_4c_Opt_TpCads.Buttons(1).FontSize  = 8
        loc_oPg2.obj_4c_Opt_TpCads.Buttons(1).ForeColor = RGB(90, 90, 90)
        loc_oPg2.obj_4c_Opt_TpCads.Buttons(1).Themes    = .F.

        loc_oPg2.obj_4c_Opt_TpCads.Buttons(2).Caption   = "Pessoa Jur" + CHR(237) + "dica"
        loc_oPg2.obj_4c_Opt_TpCads.Buttons(2).Left      = 80
        loc_oPg2.obj_4c_Opt_TpCads.Buttons(2).Top       = 3
        loc_oPg2.obj_4c_Opt_TpCads.Buttons(2).Width     = 70
        loc_oPg2.obj_4c_Opt_TpCads.Buttons(2).FontName  = "Tahoma"
        loc_oPg2.obj_4c_Opt_TpCads.Buttons(2).FontSize  = 8
        loc_oPg2.obj_4c_Opt_TpCads.Buttons(2).ForeColor = RGB(90, 90, 90)
        loc_oPg2.obj_4c_Opt_TpCads.Buttons(2).Themes    = .F.

        *-- PageFrame interno (abas Geral/Cadastro/Estoque/Faturamento)
        THIS.CriarPageFrameInterno(loc_oPg2)

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarPageFrameInterno - Cria pgf_4c_1 com 4 abas dentro da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarPageFrameInterno(par_oPg2)
        LOCAL loc_oPgf1
        par_oPg2.AddObject("pgf_4c_1", "PageFrame")
        loc_oPgf1 = par_oPg2.pgf_4c_1

        WITH loc_oPgf1
            .Top       = 146
            .Left      = 1
            .Width     = 998
            .Height    = 454
            .Tabs      = .T.
            .PageCount = 4
            .Visible   = .T.
            .Page1.Caption = "Geral"
            .Page2.Caption = "Cadastro"
            .Page3.Caption = "Estoque"
            .Page4.Caption = "Faturamento"
        ENDWITH

        THIS.CriarAbaGeral(loc_oPgf1.Page1)
        THIS.CriarAbaCadastro(loc_oPgf1.Page2)
        THIS.CriarAbaEstoque(loc_oPgf1.Page3)
        THIS.CriarAbaFaturamento(loc_oPgf1.Page4)
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarAbaGeral - Controles da aba Geral (pgf_4c_1.Page1)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarAbaGeral(par_oPg)
        LOCAL loc_oOpt

        *-- Coluna esquerda: opcoes gerais (Left ~92-165)
        *-- Complemento
        par_oPg.AddObject("lbl_4c_LblComple", "Label")
        WITH par_oPg.lbl_4c_LblComple
            .Caption = "Complemento:"
            .Top = 18
            .Left = 92
            .Width = 72
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("obj_4c_Opt_Comple", "OptionGroup")
        loc_oOpt = par_oPg.obj_4c_Opt_Comple
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 15
            .Left = 165
            .Width = 97
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Dados Pessoais
        par_oPg.AddObject("lbl_4c_LblPessoais", "Label")
        WITH par_oPg.lbl_4c_LblPessoais
            .Caption = "Dados Pessoais:"
            .Top = 44
            .Left = 83
            .Width = 80
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("obj_4c_Opt_Pessoais", "OptionGroup")
        loc_oOpt = par_oPg.obj_4c_Opt_Pessoais
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 41
            .Left = 165
            .Width = 97
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Ref. Bancarias
        par_oPg.AddObject("lbl_4c_LblRefbancs", "Label")
        WITH par_oPg.lbl_4c_LblRefbancs
            .Caption = "Ref. Banc" + CHR(225) + "rias:"
            .Top = 70
            .Left = 87
            .Width = 77
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("obj_4c_Opt_RefBancs", "OptionGroup")
        loc_oOpt = par_oPg.obj_4c_Opt_RefBancs
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 67
            .Left = 165
            .Width = 97
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Follow-Up
        par_oPg.AddObject("lbl_4c_LblFollowUp", "Label")
        WITH par_oPg.lbl_4c_LblFollowUp
            .Caption = "Follow-Up:"
            .Top = 97
            .Left = 110
            .Width = 54
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("obj_4c_Opt_FollowUp", "OptionGroup")
        loc_oOpt = par_oPg.obj_4c_Opt_FollowUp
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 94
            .Left = 165
            .Width = 97
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Dados Fiscais
        par_oPg.AddObject("lbl_4c_LblFiscais", "Label")
        WITH par_oPg.lbl_4c_LblFiscais
            .Caption = "Dados Fiscais:"
            .Top = 123
            .Left = 93
            .Width = 71
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("obj_4c_Opt_Fiscais", "OptionGroup")
        loc_oOpt = par_oPg.obj_4c_Opt_Fiscais
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 120
            .Left = 165
            .Width = 97
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Dados Comerciais
        par_oPg.AddObject("lbl_4c_LblDadcoms", "Label")
        WITH par_oPg.lbl_4c_LblDadcoms
            .Caption = "Dados Comerciais:"
            .Top = 148
            .Left = 73
            .Width = 91
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("obj_4c_Opt_DadosCom", "OptionGroup")
        loc_oOpt = par_oPg.obj_4c_Opt_DadosCom
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 146
            .Left = 165
            .Width = 97
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Possui Responsavel
        par_oPg.AddObject("lbl_4c_LblRespos", "Label")
        WITH par_oPg.lbl_4c_LblRespos
            .Caption = "Possui Respons" + CHR(225) + "vel:"
            .Top = 174
            .Left = 63
            .Width = 101
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("obj_4c_Opt_Respos", "OptionGroup")
        loc_oOpt = par_oPg.obj_4c_Opt_Respos
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 171
            .Left = 165
            .Width = 97
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Limite de Credito
        par_oPg.AddObject("lbl_4c_LblLimcres", "Label")
        WITH par_oPg.lbl_4c_LblLimcres
            .Caption = "Limite de Cr" + CHR(233) + "dito:"
            .Top = 199
            .Left = 77
            .Width = 87
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("obj_4c_Opt_LimCre", "OptionGroup")
        loc_oOpt = par_oPg.obj_4c_Opt_LimCre
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 196
            .Left = 165
            .Width = 97
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Comissao
        par_oPg.AddObject("lbl_4c_LblComis", "Label")
        WITH par_oPg.lbl_4c_LblComis
            .Caption = "Comiss" + CHR(227) + "o:"
            .Top = 225
            .Left = 112
            .Width = 52
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("obj_4c_Opt_Comi", "OptionGroup")
        loc_oOpt = par_oPg.obj_4c_Opt_Comi
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 222
            .Left = 165
            .Width = 97
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Coluna central: opcoes gerais (Left ~394-483)
        *-- Dados da Empresa
        par_oPg.AddObject("lbl_4c_LblEmpresas", "Label")
        WITH par_oPg.lbl_4c_LblEmpresas
            .Caption = "Dados da Empresa:"
            .Top = 19
            .Left = 386
            .Width = 96
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("obj_4c_Opt_Empresa", "OptionGroup")
        loc_oOpt = par_oPg.obj_4c_Opt_Empresa
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 15
            .Left = 483
            .Width = 97
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Dados Contabeis
        par_oPg.AddObject("lbl_4c_LblContabs", "Label")
        WITH par_oPg.lbl_4c_LblContabs
            .Caption = "Dados Cont" + CHR(225) + "beis:"
            .Top = 45
            .Left = 394
            .Width = 88
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("obj_4c_Opt_Contabs", "OptionGroup")
        loc_oOpt = par_oPg.obj_4c_Opt_Contabs
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 41
            .Left = 483
            .Width = 97
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Caracteristicas
        par_oPg.AddObject("lbl_4c_LblCaracteris", "Label")
        WITH par_oPg.lbl_4c_LblCaracteris
            .Caption = "Caracter" + CHR(237) + "sticas:"
            .Top = 71
            .Left = 404
            .Width = 78
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("obj_4c_Opt_Caracteris", "OptionGroup")
        loc_oOpt = par_oPg.obj_4c_Opt_Caracteris
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 67
            .Left = 483
            .Width = 97
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Informacoes Cadastrais
        par_oPg.AddObject("lbl_4c_LblInfcads", "Label")
        WITH par_oPg.lbl_4c_LblInfcads
            .Caption = "Informa" + CHR(231) + CHR(245) + "es Cadastrais:"
            .Top = 98
            .Left = 361
            .Width = 121
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("obj_4c_Fwoption1", "OptionGroup")
        loc_oOpt = par_oPg.obj_4c_Fwoption1
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 94
            .Left = 483
            .Width = 97
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Perfil
        par_oPg.AddObject("lbl_4c_LblPerfil", "Label")
        WITH par_oPg.lbl_4c_LblPerfil
            .Caption = "Perfil:"
            .Top = 124
            .Left = 451
            .Width = 31
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("obj_4c_Fwoption2", "OptionGroup")
        loc_oOpt = par_oPg.obj_4c_Fwoption2
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 120
            .Left = 483
            .Width = 97
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Cargos
        par_oPg.AddObject("lbl_4c_LblCargos", "Label")
        WITH par_oPg.lbl_4c_LblCargos
            .Caption = "Cargos:"
            .Top = 149
            .Left = 441
            .Width = 41
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("obj_4c_Opt_Cargo", "OptionGroup")
        loc_oOpt = par_oPg.obj_4c_Opt_Cargo
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 145
            .Left = 483
            .Width = 97
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Checa Limite de Credito
        par_oPg.AddObject("lbl_4c_LblChkLimCr", "Label")
        WITH par_oPg.lbl_4c_LblChkLimCr
            .Caption = "Checa Limite Cr" + CHR(233) + "dito:"
            .Top = 175
            .Left = 377
            .Width = 105
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("obj_4c_Opt_ChkLimCr", "OptionGroup")
        loc_oOpt = par_oPg.obj_4c_Opt_ChkLimCr
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 171
            .Left = 483
            .Width = 97
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Lim.Credito Grupo Valor Moeda
        par_oPg.AddObject("lbl_4c_LblLimVrMoe", "Label")
        WITH par_oPg.lbl_4c_LblLimVrMoe
            .Caption = "Lim.Cr" + CHR(233) + "dito Grupo/Vr/Moeda:"
            .Top = 200
            .Left = 339
            .Width = 143
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("txt_4c_Vrlimc", "TextBox")
        WITH par_oPg.txt_4c_Vrlimc
            .Value = 0
            .Top = 196
            .Left = 586
            .Width = 110
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes = .F.
            .SpecialEffect = 0
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("txt_4c__molimc", "TextBox")
        WITH par_oPg.txt_4c__molimc
            .Value = ""
            .Top = 196
            .Left = 698
            .Width = 32
            .Height = 23
            .MaxLength = 3
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes = .F.
            .SpecialEffect = 0
            .Visible = .T.
        ENDWITH

        *-- Moeda da Comissao
        par_oPg.AddObject("lbl_4c_LblComMoeda", "Label")
        WITH par_oPg.lbl_4c_LblComMoeda
            .Caption = "Moeda da Comiss" + CHR(227) + "o:"
            .Top = 226
            .Left = 380
            .Width = 103
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("txt_4c__cd_moeda", "TextBox")
        WITH par_oPg.txt_4c__cd_moeda
            .Value = ""
            .Top = 222
            .Left = 486
            .Width = 32
            .Height = 23
            .MaxLength = 3
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes = .F.
            .SpecialEffect = 0
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("txt_4c__ds_moeda", "TextBox")
        WITH par_oPg.txt_4c__ds_moeda
            .Value = ""
            .Top = 222
            .Left = 520
            .Width = 150
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,230)
            .ReadOnly = .T.
            .Themes = .F.
            .SpecialEffect = 0
            .Visible = .T.
        ENDWITH

        BINDEVENT(par_oPg.txt_4c__cd_moeda, "KeyPress",  THIS, "MoedaComissaoKeyPress")
        BINDEVENT(par_oPg.txt_4c__cd_moeda, "DblClick",  THIS, "MoedaComissaoDblClick")
        BINDEVENT(par_oPg.txt_4c__cd_moeda, "KeyPress", THIS, "MoedaComissaoLostFocus")
        BINDEVENT(par_oPg.txt_4c__molimc,   "KeyPress",  THIS, "MoedaLimiteKeyPress")
        BINDEVENT(par_oPg.txt_4c__molimc,   "DblClick",  THIS, "MoedaLimiteDblClick")
        BINDEVENT(par_oPg.txt_4c__molimc,   "KeyPress", THIS, "MoedaLimiteLostFocus")

        *-- Grupo Padrao Contabil
        par_oPg.AddObject("lbl_4c_LblGrupolms", "Label")
        WITH par_oPg.lbl_4c_LblGrupolms
            .Caption = "Grupo Padr" + CHR(227) + "o:"
            .Top = 19
            .Left = 678
            .Width = 80
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("txt_4c_Grupo", "TextBox")
        WITH par_oPg.txt_4c_Grupo
            .Value = ""
            .Top = 17
            .Left = 760
            .Width = 120
            .Height = 23
            .MaxLength = 10
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes = .F.
            .SpecialEffect = 0
            .Visible = .T.
        ENDWITH

        BINDEVENT(par_oPg.txt_4c_Grupo, "KeyPress", THIS, "GrupoContabKeyPress")
        BINDEVENT(par_oPg.txt_4c_Grupo, "DblClick", THIS, "GrupoContabDblClick")

        *-- Coletor (11 opcoes) - OptionGroup vertical
        par_oPg.AddObject("lbl_4c_LblColetor", "Label")
        WITH par_oPg.lbl_4c_LblColetor
            .Caption = "Coletor:"
            .Top = 8
            .Left = 700
            .Width = 50
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("obj_4c_Opt_Coletor", "OptionGroup")
        loc_oOpt = par_oPg.obj_4c_Opt_Coletor
        WITH loc_oOpt
            .ButtonCount = 11
            .Top = 12
            .Left = 750
            .Width = 141
            .Height = 210
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH

        LOCAL loc_nI, loc_nTop
        FOR loc_nI = 1 TO 11
            loc_nTop = (loc_nI - 1) * 18 + 5
            loc_oOpt.Buttons(loc_nI).Caption   = STR(loc_nI, 2)
            loc_oOpt.Buttons(loc_nI).Left      = 5
            loc_oOpt.Buttons(loc_nI).Top       = loc_nTop
            loc_oOpt.Buttons(loc_nI).Width     = 130
            loc_oOpt.Buttons(loc_nI).FontName  = "Tahoma"
            loc_oOpt.Buttons(loc_nI).FontSize  = 8
            loc_oOpt.Buttons(loc_nI).ForeColor = RGB(90, 90, 90)
            loc_oOpt.Buttons(loc_nI).Themes    = .F.
        ENDFOR
        loc_oOpt.Buttons(1).Caption  = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Caption  = "Coletor 1"
        loc_oOpt.Buttons(3).Caption  = "Coletor 2"
        loc_oOpt.Buttons(4).Caption  = "Coletor 3"
        loc_oOpt.Buttons(5).Caption  = "Coletor 4"
        loc_oOpt.Buttons(6).Caption  = "Coletor 5"
        loc_oOpt.Buttons(7).Caption  = "Coletor 6"
        loc_oOpt.Buttons(8).Caption  = "Coletor 7"
        loc_oOpt.Buttons(9).Caption  = "Coletor 8"
        loc_oOpt.Buttons(10).Caption = "Coletor 9"
        loc_oOpt.Buttons(11).Caption = "Coletor 10"

        *-- LEAD / Pre-Cadastro
        par_oPg.AddObject("lbl_4c_LblPreCad", "Label")
        WITH par_oPg.lbl_4c_LblPreCad
            .Caption = "LEAD:"
            .Top = 221
            .Left = 719
            .Width = 30
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("obj_4c_OptPreCad", "OptionGroup")
        loc_oOpt = par_oPg.obj_4c_OptPreCad
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 217
            .Left = 751
            .Width = 97
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Linha separadora
        par_oPg.AddObject("lin_4c_Line1", "Line")
        WITH par_oPg.lin_4c_Line1
            .Top = 253
            .Left = 17
            .Width = 959
            .Height = 1
            .BorderColor = RGB(150,150,150)
            .Visible = .T.
        ENDWITH

        *-- Rodape do Relatorio
        par_oPg.AddObject("lbl_4c_LblRodrel", "Label")
        WITH par_oPg.lbl_4c_LblRodrel
            .Caption = "Rodap" + CHR(233) + " do Relat" + CHR(243) + "rio:"
            .Top = 260
            .Left = 103
            .Width = 120
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("obj_4c_GetRodRelCC", "EditBox")
        WITH par_oPg.obj_4c_GetRodRelCC
            .Value = ""
            .Top = 277
            .Left = 103
            .Width = 788
            .Height = 117
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .ScrollBars = 2
            .Themes = .F.
            .SpecialEffect = 0
            .Visible = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarAbaCadastro - Controles da aba Cadastro (pgf_4c_1.Page2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarAbaCadastro(par_oPg)
        LOCAL loc_oOpt

        *-- Linhas separadoras
        par_oPg.AddObject("lin_4c_Cad1", "Line")
        WITH par_oPg.lin_4c_Cad1
            .Top = 341
            .Left = 17
            .Width = 959
            .Height = 1
            .BorderColor = RGB(150,150,150)
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("lin_4c_Cad2", "Line")
        WITH par_oPg.lin_4c_Cad2
            .Top = 29
            .Left = 344
            .Width = 1
            .Height = 312
            .BorderColor = RGB(150,150,150)
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("lin_4c_Cad3", "Line")
        WITH par_oPg.lin_4c_Cad3
            .Top = 29
            .Left = 583
            .Width = 1
            .Height = 312
            .BorderColor = RGB(150,150,150)
            .Visible = .T.
        ENDWITH

        *-- Col 1: CPF/CNPJ Obrigatorio (3 btn)
        par_oPg.AddObject("lbl_4c_LblCpfObrig", "Label")
        WITH par_oPg.lbl_4c_LblCpfObrig
            .Caption = "CPF/CNPJ Obrig.:"
            .Top = 34
            .Left = 17
            .Width = 141
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Opt_CPFObrig", "OptionGroup")
        loc_oOpt = par_oPg.Opt_CPFObrig
        WITH loc_oOpt
            .ButtonCount = 3
            .Top = 34
            .Left = 160
            .Width = 201
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 44
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "Opcional"
        loc_oOpt.Buttons(2).Left = 55
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 65
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.
        loc_oOpt.Buttons(3).Caption = "Obrigat" + CHR(243) + "rio"
        loc_oOpt.Buttons(3).Left = 125
        loc_oOpt.Buttons(3).Top = 3
        loc_oOpt.Buttons(3).Width = 70
        loc_oOpt.Buttons(3).FontName = "Tahoma"
        loc_oOpt.Buttons(3).FontSize = 8
        loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(3).Themes = .F.

        *-- Calc Imediato
        par_oPg.AddObject("lbl_4c_LblCalcImeds", "Label")
        WITH par_oPg.lbl_4c_LblCalcImeds
            .Caption = "Calc. Imediato:"
            .Top = 54
            .Left = 17
            .Width = 141
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("fwoption2", "OptionGroup")
        loc_oOpt = par_oPg.fwoption2
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 54
            .Left = 160
            .Width = 115
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Calcimeds (optCalcIMeds)
        par_oPg.AddObject("lbl_4c_LblCalcIMed2", "Label")
        WITH par_oPg.lbl_4c_LblCalcIMed2
            .Caption = "Calc.Imeds2:"
            .Top = 73
            .Left = 17
            .Width = 141
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("optCalcIMeds", "OptionGroup")
        loc_oOpt = par_oPg.optCalcIMeds
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 73
            .Left = 160
            .Width = 97
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- ObrMails
        par_oPg.AddObject("lbl_4c_LblObrMails", "Label")
        WITH par_oPg.lbl_4c_LblObrMails
            .Caption = "E-mail Obrig.:"
            .Top = 96
            .Left = 17
            .Width = 141
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("getObrMails", "OptionGroup")
        loc_oOpt = par_oPg.getObrMails
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 96
            .Left = 160
            .Width = 97
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- ObrNome
        par_oPg.AddObject("lbl_4c_LblObrNome", "Label")
        WITH par_oPg.lbl_4c_LblObrNome
            .Caption = "Nome Obrig.:"
            .Top = 117
            .Left = 17
            .Width = 141
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("getObrNome", "OptionGroup")
        loc_oOpt = par_oPg.getObrNome
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 117
            .Left = 160
            .Width = 97
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- RazSoc Obrig (Fwoption15)
        par_oPg.AddObject("lbl_4c_LblRazSocObr", "Label")
        WITH par_oPg.lbl_4c_LblRazSocObr
            .Caption = "Raz" + CHR(227) + "o Social Obrig.:"
            .Top = 136
            .Left = 17
            .Width = 141
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Fwoption15", "OptionGroup")
        loc_oOpt = par_oPg.Fwoption15
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 136
            .Left = 160
            .Width = 97
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- ObrSit
        par_oPg.AddObject("lbl_4c_LblObrSit", "Label")
        WITH par_oPg.lbl_4c_LblObrSit
            .Caption = "Situa" + CHR(231) + CHR(227) + "o Obrig.:"
            .Top = 157
            .Left = 17
            .Width = 141
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("getObrSit", "OptionGroup")
        loc_oOpt = par_oPg.getObrSit
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 157
            .Left = 160
            .Width = 97
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- ObrTlm (Telemarketing)
        par_oPg.AddObject("lbl_4c_LblObrTlm", "Label")
        WITH par_oPg.lbl_4c_LblObrTlm
            .Caption = "Telemarketing Obrig.:"
            .Top = 179
            .Left = 17
            .Width = 141
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("getObrTlm", "OptionGroup")
        loc_oOpt = par_oPg.getObrTlm
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 179
            .Left = 160
            .Width = 97
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- ObrCla (Classificacao)
        par_oPg.AddObject("lbl_4c_LblObrCla", "Label")
        WITH par_oPg.lbl_4c_LblObrCla
            .Caption = "Classifica" + CHR(231) + CHR(227) + "o Obrig.:"
            .Top = 201
            .Left = 17
            .Width = 141
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("getObrCla", "OptionGroup")
        loc_oOpt = par_oPg.getObrCla
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 201
            .Left = 160
            .Width = 97
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- ObrSeg (Segmento)
        par_oPg.AddObject("lbl_4c_LblObrSeg", "Label")
        WITH par_oPg.lbl_4c_LblObrSeg
            .Caption = "Segmento Obrig.:"
            .Top = 222
            .Left = 17
            .Width = 141
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("getObrSeg", "OptionGroup")
        loc_oOpt = par_oPg.getObrSeg
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 222
            .Left = 160
            .Width = 97
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Nascimento Obrig (Fwoption6)
        par_oPg.AddObject("lbl_4c_LblNascObr", "Label")
        WITH par_oPg.lbl_4c_LblNascObr
            .Caption = "Nascimento Obrig.:"
            .Top = 241
            .Left = 17
            .Width = 141
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Fwoption6", "OptionGroup")
        loc_oOpt = par_oPg.Fwoption6
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 241
            .Left = 160
            .Width = 97
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Sexo Obrig (Fwoption7)
        par_oPg.AddObject("lbl_4c_LblSexoObr", "Label")
        WITH par_oPg.lbl_4c_LblSexoObr
            .Caption = "Sexo Obrig.:"
            .Top = 262
            .Left = 17
            .Width = 141
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Fwoption7", "OptionGroup")
        loc_oOpt = par_oPg.Fwoption7
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 262
            .Left = 160
            .Width = 97
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Telefone 1 Obrig (Fwoption12)
        par_oPg.AddObject("lbl_4c_LblTel1Obr", "Label")
        WITH par_oPg.lbl_4c_LblTel1Obr
            .Caption = "Telefone 1 Obrig.:"
            .Top = 283
            .Left = 17
            .Width = 141
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Fwoption12", "OptionGroup")
        loc_oOpt = par_oPg.Fwoption12
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 283
            .Left = 160
            .Width = 97
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Telefone 2 Obrig (Fwoption13)
        par_oPg.AddObject("lbl_4c_LblTel2Obr", "Label")
        WITH par_oPg.lbl_4c_LblTel2Obr
            .Caption = "Telefone 2 Obrig.:"
            .Top = 302
            .Left = 17
            .Width = 141
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Fwoption13", "OptionGroup")
        loc_oOpt = par_oPg.Fwoption13
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 302
            .Left = 160
            .Width = 97
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Col 2: Endereco obrigatorio (Left 464)
        *-- Endereco Obrig (Fwoption14)
        par_oPg.AddObject("lbl_4c_LblEndObr", "Label")
        WITH par_oPg.lbl_4c_LblEndObr
            .Caption = "Endere" + CHR(231) + "o Obrig.:"
            .Top = 33
            .Left = 360
            .Width = 103
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Fwoption14", "OptionGroup")
        loc_oOpt = par_oPg.Fwoption14
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 33
            .Left = 464
            .Width = 97
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Numero Obrig (Fwoption8)
        par_oPg.AddObject("lbl_4c_LblNumObr", "Label")
        WITH par_oPg.lbl_4c_LblNumObr
            .Caption = "N" + CHR(250) + "mero Obrig.:"
            .Top = 52
            .Left = 360
            .Width = 103
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Fwoption8", "OptionGroup")
        loc_oOpt = par_oPg.Fwoption8
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 52
            .Left = 464
            .Width = 97
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Bairro Obrig (Fwoption9)
        par_oPg.AddObject("lbl_4c_LblBairroObr", "Label")
        WITH par_oPg.lbl_4c_LblBairroObr
            .Caption = "Bairro Obrig.:"
            .Top = 73
            .Left = 360
            .Width = 103
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Fwoption9", "OptionGroup")
        loc_oOpt = par_oPg.Fwoption9
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 73
            .Left = 464
            .Width = 97
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Cidade Obrig (Fwoption11)
        par_oPg.AddObject("lbl_4c_LblCidObr", "Label")
        WITH par_oPg.lbl_4c_LblCidObr
            .Caption = "Cidade Obrig.:"
            .Top = 92
            .Left = 360
            .Width = 103
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Fwoption11", "OptionGroup")
        loc_oOpt = par_oPg.Fwoption11
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 92
            .Left = 464
            .Width = 97
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Pais Obrig (Fwoption10)
        par_oPg.AddObject("lbl_4c_LblPaisObr", "Label")
        WITH par_oPg.lbl_4c_LblPaisObr
            .Caption = "Pa" + CHR(237) + "s Obrig.:"
            .Top = 112
            .Left = 360
            .Width = 103
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Fwoption10", "OptionGroup")
        loc_oOpt = par_oPg.Fwoption10
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 112
            .Left = 464
            .Width = 97
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- CEP Obrig (Opt_CEPObrig, 3 btn)
        par_oPg.AddObject("lbl_4c_LblCepObr", "Label")
        WITH par_oPg.lbl_4c_LblCepObr
            .Caption = "CEP Obrig.:"
            .Top = 132
            .Left = 360
            .Width = 103
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Opt_CEPObrig", "OptionGroup")
        loc_oOpt = par_oPg.Opt_CEPObrig
        WITH loc_oOpt
            .ButtonCount = 3
            .Top = 132
            .Left = 464
            .Width = 180
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 44
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "Opcional"
        loc_oOpt.Buttons(2).Left = 55
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 65
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.
        loc_oOpt.Buttons(3).Caption = "Obrigat" + CHR(243) + "rio"
        loc_oOpt.Buttons(3).Left = 125
        loc_oOpt.Buttons(3).Top = 3
        loc_oOpt.Buttons(3).Width = 50
        loc_oOpt.Buttons(3).FontName = "Tahoma"
        loc_oOpt.Buttons(3).FontSize = 8
        loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(3).Themes = .F.

        *-- IBGE Obrig (getObrIbge)
        par_oPg.AddObject("lbl_4c_LblIbgeObr", "Label")
        WITH par_oPg.lbl_4c_LblIbgeObr
            .Caption = "IBGE Obrig.:"
            .Top = 190
            .Left = 360
            .Width = 103
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("getObrIbge", "OptionGroup")
        loc_oOpt = par_oPg.getObrIbge
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 190
            .Left = 464
            .Width = 97
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Conta Interna
        par_oPg.AddObject("lbl_4c_LblContint", "Label")
        WITH par_oPg.lbl_4c_LblContint
            .Caption = "Conta Interna:"
            .Top = 349
            .Left = 17
            .Width = 90
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Getcontint", "TextBox")
        WITH par_oPg.Getcontint
            .Value = ""
            .Top = 349
            .Left = 192
            .Width = 73
            .Height = 23
            .MaxLength = 9
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes = .F.
            .SpecialEffect = 0
            .Visible = .T.
        ENDWITH

        *-- Integracao Contabil (Opt_Integ, 3 btn)
        par_oPg.AddObject("lbl_4c_LblIntcont", "Label")
        WITH par_oPg.lbl_4c_LblIntcont
            .Caption = "Integra" + CHR(231) + CHR(227) + "o Contabil:"
            .Top = 373
            .Left = 17
            .Width = 173
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Opt_Integ", "OptionGroup")
        loc_oOpt = par_oPg.Opt_Integ
        WITH loc_oOpt
            .ButtonCount = 3
            .Top = 373
            .Left = 192
            .Width = 316
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "Integra" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 50
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 130
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.
        loc_oOpt.Buttons(3).Caption = "Por Grupo"
        loc_oOpt.Buttons(3).Left = 185
        loc_oOpt.Buttons(3).Top = 3
        loc_oOpt.Buttons(3).Width = 90
        loc_oOpt.Buttons(3).FontName = "Tahoma"
        loc_oOpt.Buttons(3).FontSize = 8
        loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(3).Themes = .F.

        *-- Padrao Preenchimento (Fwoption3, 4 btn)
        par_oPg.AddObject("lbl_4c_LblPadPgrec", "Label")
        WITH par_oPg.lbl_4c_LblPadPgrec
            .Caption = "Padr" + CHR(227) + "o Preenchimento:"
            .Top = 394
            .Left = 17
            .Width = 173
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Fwoption3", "OptionGroup")
        loc_oOpt = par_oPg.Fwoption3
        WITH loc_oOpt
            .ButtonCount = 4
            .Top = 394
            .Left = 192
            .Width = 353
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "Gravar Zero"
        loc_oOpt.Buttons(2).Left = 50
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 80
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.
        loc_oOpt.Buttons(3).Caption = "Gravar Nulo"
        loc_oOpt.Buttons(3).Left = 135
        loc_oOpt.Buttons(3).Top = 3
        loc_oOpt.Buttons(3).Width = 80
        loc_oOpt.Buttons(3).FontName = "Tahoma"
        loc_oOpt.Buttons(3).FontSize = 8
        loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(3).Themes = .F.
        loc_oOpt.Buttons(4).Caption = "Gravar Vazio"
        loc_oOpt.Buttons(4).Left = 220
        loc_oOpt.Buttons(4).Top = 3
        loc_oOpt.Buttons(4).Width = 80
        loc_oOpt.Buttons(4).FontName = "Tahoma"
        loc_oOpt.Buttons(4).FontSize = 8
        loc_oOpt.Buttons(4).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(4).Themes = .F.

        *-- Vincula Conta PG/RC (optVincPgRcs)
        par_oPg.AddObject("lbl_4c_LblVincPgRcs", "Label")
        WITH par_oPg.lbl_4c_LblVincPgRcs
            .Caption = "Vincula Conta PG/RC:"
            .Top = 415
            .Left = 17
            .Width = 173
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("optVincPgRcs", "OptionGroup")
        loc_oOpt = par_oPg.optVincPgRcs
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 415
            .Left = 192
            .Width = 181
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Tit Nao Baixado (OptTitBaixado)
        par_oPg.AddObject("lbl_4c_LblTitBaix", "Label")
        WITH par_oPg.lbl_4c_LblTitBaix
            .Caption = "Visualiza Tit.n" + CHR(227) + "o Baixados:"
            .Top = 435
            .Left = 17
            .Width = 173
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("OptTitBaixado", "OptionGroup")
        loc_oOpt = par_oPg.OptTitBaixado
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 435
            .Left = 192
            .Width = 181
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Col 3: dados adicionais (Left 583+)
        *-- Duplicar Endereco (Fwoption4)
        par_oPg.AddObject("lbl_4c_LblDupEnd", "Label")
        WITH par_oPg.lbl_4c_LblDupEnd
            .Caption = "Duplicar Endere" + CHR(231) + "o:"
            .Top = 34
            .Left = 600
            .Width = 120
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Fwoption4", "OptionGroup")
        loc_oOpt = par_oPg.Fwoption4
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 34
            .Left = 796
            .Width = 131
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Restringe Endereco (Fwoption5)
        par_oPg.AddObject("lbl_4c_LblRestrEnd", "Label")
        WITH par_oPg.lbl_4c_LblRestrEnd
            .Caption = "Restringe Endere" + CHR(231) + "o:"
            .Top = 55
            .Left = 600
            .Width = 120
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Fwoption5", "OptionGroup")
        loc_oOpt = par_oPg.Fwoption5
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 55
            .Left = 796
            .Width = 131
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Bloqueia CPF (Fwoption16)
        par_oPg.AddObject("lbl_4c_LblBlqCpf", "Label")
        WITH par_oPg.lbl_4c_LblBlqCpf
            .Caption = "Bloqueia CPF dup.:"
            .Top = 73
            .Left = 600
            .Width = 120
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Fwoption16", "OptionGroup")
        loc_oOpt = par_oPg.Fwoption16
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 73
            .Left = 796
            .Width = 131
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Mostrar Foto (Opt_MFotos)
        par_oPg.AddObject("lbl_4c_LblMFotos", "Label")
        WITH par_oPg.lbl_4c_LblMFotos
            .Caption = "Mostrar Foto:"
            .Top = 93
            .Left = 600
            .Width = 120
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Opt_MFotos", "OptionGroup")
        loc_oOpt = par_oPg.Opt_MFotos
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 93
            .Left = 796
            .Width = 131
            .Height = 22
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Observacoes (fwoption1, 3 btn)
        par_oPg.AddObject("lbl_4c_LblObservs", "Label")
        WITH par_oPg.lbl_4c_LblObservs
            .Caption = "Observa" + CHR(231) + CHR(245) + "es:"
            .Top = 111
            .Left = 600
            .Width = 120
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("fwoption1", "OptionGroup")
        loc_oOpt = par_oPg.fwoption1
        WITH loc_oOpt
            .ButtonCount = 3
            .Top = 111
            .Left = 797
            .Width = 131
            .Height = 52
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 44
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "Livre"
        loc_oOpt.Buttons(2).Left = 5
        loc_oOpt.Buttons(2).Top = 22
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.
        loc_oOpt.Buttons(3).Caption = "RTF"
        loc_oOpt.Buttons(3).Left = 5
        loc_oOpt.Buttons(3).Top = 41
        loc_oOpt.Buttons(3).Width = 44
        loc_oOpt.Buttons(3).FontName = "Tahoma"
        loc_oOpt.Buttons(3).FontSize = 8
        loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(3).Themes = .F.

        *-- CPF Fixo (optCpffixo, 3 btn)
        par_oPg.AddObject("lbl_4c_LblCpfFixo", "Label")
        WITH par_oPg.lbl_4c_LblCpfFixo
            .Caption = "CPF/CNPJ Fixo:"
            .Top = 163
            .Left = 600
            .Width = 120
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("optCpffixo", "OptionGroup")
        loc_oOpt = par_oPg.optCpffixo
        WITH loc_oOpt
            .ButtonCount = 3
            .Top = 163
            .Left = 798
            .Width = 183
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "Fixar Formato"
        loc_oOpt.Buttons(2).Left = 50
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 80
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.
        loc_oOpt.Buttons(3).Caption = "Fixar CPF"
        loc_oOpt.Buttons(3).Left = 135
        loc_oOpt.Buttons(3).Top = 3
        loc_oOpt.Buttons(3).Width = 45
        loc_oOpt.Buttons(3).FontName = "Tahoma"
        loc_oOpt.Buttons(3).FontSize = 8
        loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(3).Themes = .F.

        *-- Situacao Padrao
        par_oPg.AddObject("lbl_4c_LblSitPad", "Label")
        WITH par_oPg.lbl_4c_LblSitPad
            .Caption = "Situa" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o:"
            .Top = 188
            .Left = 600
            .Width = 120
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("getSituas", "TextBox")
        WITH par_oPg.getSituas
            .Value = ""
            .Top = 188
            .Left = 801
            .Width = 48
            .Height = 23
            .MaxLength = 3
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes = .F.
            .SpecialEffect = 0
            .Visible = .T.
        ENDWITH
        BINDEVENT(par_oPg.getSituas, "KeyPress",  THIS, "SituacaoKeyPress")
        BINDEVENT(par_oPg.getSituas, "DblClick",  THIS, "SituacaoDblClick")
        BINDEVENT(par_oPg.getSituas, "KeyPress", THIS, "SituacaoLostFocus")

        *-- Caracteristicas (optCarac)
        par_oPg.AddObject("lbl_4c_LblCarac", "Label")
        WITH par_oPg.lbl_4c_LblCarac
            .Caption = "Caracter" + CHR(237) + "sticas:"
            .Top = 211
            .Left = 600
            .Width = 120
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("optCarac", "OptionGroup")
        loc_oOpt = par_oPg.optCarac
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 211
            .Left = 796
            .Width = 131
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- AceJob (optAceJob)
        par_oPg.AddObject("lbl_4c_LblAceJob", "Label")
        WITH par_oPg.lbl_4c_LblAceJob
            .Caption = "Aceita Job:"
            .Top = 232
            .Left = 600
            .Width = 120
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("optAceJob", "OptionGroup")
        loc_oOpt = par_oPg.optAceJob
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 232
            .Left = 796
            .Width = 131
            .Height = 23
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Alerta Cadastro (OptAlertaCad)
        par_oPg.AddObject("lbl_4c_LblAlertaCad", "Label")
        WITH par_oPg.lbl_4c_LblAlertaCad
            .Caption = "Alerta Cadastro:"
            .Top = 250
            .Left = 600
            .Width = 120
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("OptAlertaCad", "OptionGroup")
        loc_oOpt = par_oPg.OptAlertaCad
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 250
            .Left = 795
            .Width = 98
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Mensagem de Alerta
        par_oPg.AddObject("lbl_4c_LblMsgAlerta", "Label")
        WITH par_oPg.lbl_4c_LblMsgAlerta
            .Caption = "Mensagem Alerta:"
            .Top = 271
            .Left = 600
            .Width = 120
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("getMsgAlertaC", "EditBox")
        WITH par_oPg.getMsgAlertaC
            .Value = ""
            .Top = 272
            .Left = 799
            .Width = 189
            .Height = 65
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .ScrollBars = 2
            .Themes = .F.
            .SpecialEffect = 0
            .Visible = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarAbaEstoque - Controles da aba Estoque (pgf_4c_1.Page3)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarAbaEstoque(par_oPg)
        LOCAL loc_oOpt

        *-- Linha separadora
        par_oPg.AddObject("lin_4c_Est1", "Line")
        WITH par_oPg.lin_4c_Est1
            .Top = 158
            .Left = 17
            .Width = 959
            .Height = 1
            .BorderColor = RGB(150,150,150)
            .Visible = .T.
        ENDWITH

        *-- Limite de Estoque (Opt_LimEsto)
        par_oPg.AddObject("lbl_4c_LblLimEsto", "Label")
        WITH par_oPg.lbl_4c_LblLimEsto
            .Caption = "Limite de Estoque:"
            .Top = 29
            .Left = 17
            .Width = 156
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Opt_LimEsto", "OptionGroup")
        loc_oOpt = par_oPg.Opt_LimEsto
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 29
            .Left = 174
            .Width = 92
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Verificar Estoque (Opt_VerEst)
        par_oPg.AddObject("lbl_4c_LblVerEst", "Label")
        WITH par_oPg.lbl_4c_LblVerEst
            .Caption = "Verificar Estoque:"
            .Top = 53
            .Left = 17
            .Width = 156
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Opt_VerEst", "OptionGroup")
        loc_oOpt = par_oPg.Opt_VerEst
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 53
            .Left = 174
            .Width = 92
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Est P.Acabar (Opt_EstPAcab)
        par_oPg.AddObject("lbl_4c_LblEstPAcab", "Label")
        WITH par_oPg.lbl_4c_LblEstPAcab
            .Caption = "Est. P.Acabar:"
            .Top = 77
            .Left = 17
            .Width = 156
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Opt_EstPAcab", "OptionGroup")
        loc_oOpt = par_oPg.Opt_EstPAcab
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 77
            .Left = 174
            .Width = 92
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Checa Lim Estoque (opt_ChkLimest)
        par_oPg.AddObject("lbl_4c_LblChkLimEst", "Label")
        WITH par_oPg.lbl_4c_LblChkLimEst
            .Caption = "Checa Lim.Estoque:"
            .Top = 101
            .Left = 17
            .Width = 156
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("opt_ChkLimest", "OptionGroup")
        loc_oOpt = par_oPg.opt_ChkLimest
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 101
            .Left = 174
            .Width = 92
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Centro de Custos (Opt_CCusto)
        par_oPg.AddObject("lbl_4c_LblCCusto", "Label")
        WITH par_oPg.lbl_4c_LblCCusto
            .Caption = "Centro de Custos:"
            .Top = 125
            .Left = 17
            .Width = 156
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Opt_CCusto", "OptionGroup")
        loc_oOpt = par_oPg.Opt_CCusto
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 125
            .Left = 174
            .Width = 92
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Gerar Balancete (Opt_GBals)
        par_oPg.AddObject("lbl_4c_LblGBals", "Label")
        WITH par_oPg.lbl_4c_LblGBals
            .Caption = "Gerar Balan" + CHR(231) + "o:"
            .Top = 191
            .Left = 17
            .Width = 156
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Opt_GBals", "OptionGroup")
        loc_oOpt = par_oPg.Opt_GBals
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 191
            .Left = 174
            .Width = 92
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Grupo Dif Balanco
        par_oPg.AddObject("lbl_4c_LblGrufals", "Label")
        WITH par_oPg.lbl_4c_LblGrufals
            .Caption = "Grupo Dif.Balan" + CHR(231) + "o:"
            .Top = 216
            .Left = 17
            .Width = 156
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Get_grupo", "TextBox")
        WITH par_oPg.Get_grupo
            .Value = ""
            .Top = 216
            .Left = 179
            .Width = 90
            .Height = 23
            .MaxLength = 10
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes = .F.
            .SpecialEffect = 0
            .Visible = .T.
        ENDWITH
        BINDEVENT(par_oPg.Get_grupo, "KeyPress", THIS, "GrupoEstoqueKeyPress")
        BINDEVENT(par_oPg.Get_grupo, "DblClick", THIS, "GrupoEstoqueDblClick")

        *-- Balanco Unificado (Opt_UnifBal, 4 btn)
        par_oPg.AddObject("lbl_4c_LblUnifBal", "Label")
        WITH par_oPg.lbl_4c_LblUnifBal
            .Caption = "Balan" + CHR(231) + "o Unificado:"
            .Top = 242
            .Left = 17
            .Width = 156
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Opt_UnifBal", "OptionGroup")
        loc_oOpt = par_oPg.Opt_UnifBal
        WITH loc_oOpt
            .ButtonCount = 4
            .Top = 242
            .Left = 174
            .Width = 171
            .Height = 43
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "Empresa"
        loc_oOpt.Buttons(2).Left = 50
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 60
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.
        loc_oOpt.Buttons(3).Caption = "Grupo"
        loc_oOpt.Buttons(3).Left = 115
        loc_oOpt.Buttons(3).Top = 3
        loc_oOpt.Buttons(3).Width = 50
        loc_oOpt.Buttons(3).FontName = "Tahoma"
        loc_oOpt.Buttons(3).FontSize = 8
        loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(3).Themes = .F.
        loc_oOpt.Buttons(4).Caption = "Ambos"
        loc_oOpt.Buttons(4).Left = 5
        loc_oOpt.Buttons(4).Top = 23
        loc_oOpt.Buttons(4).Width = 50
        loc_oOpt.Buttons(4).FontName = "Tahoma"
        loc_oOpt.Buttons(4).FontSize = 8
        loc_oOpt.Buttons(4).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(4).Themes = .F.

        *-- Balanco Falhas/Perdas (Opt_FalPers)
        par_oPg.AddObject("lbl_4c_LblFalPers", "Label")
        WITH par_oPg.lbl_4c_LblFalPers
            .Caption = "Balan" + CHR(231) + "o Falhas/Perdas:"
            .Top = 285
            .Left = 17
            .Width = 156
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Opt_FalPers", "OptionGroup")
        loc_oOpt = par_oPg.Opt_FalPers
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 285
            .Left = 174
            .Width = 92
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Bloqueia Divisao OF (Opt_BlqDivOp)
        par_oPg.AddObject("lbl_4c_LblBlqDivOp", "Label")
        WITH par_oPg.lbl_4c_LblBlqDivOp
            .Caption = "Bloqueia Divis" + CHR(227) + "o OF:"
            .Top = 311
            .Left = 17
            .Width = 156
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Opt_BlqDivOp", "OptionGroup")
        loc_oOpt = par_oPg.Opt_BlqDivOp
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 311
            .Left = 174
            .Width = 92
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- OS Pendente (Get_OsPend)
        par_oPg.AddObject("lbl_4c_LblOsPend", "Label")
        WITH par_oPg.lbl_4c_LblOsPend
            .Caption = "OS Pendente Dt.Entrega:"
            .Top = 335
            .Left = 17
            .Width = 156
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Get_OsPend", "OptionGroup")
        loc_oOpt = par_oPg.Get_OsPend
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 335
            .Left = 174
            .Width = 92
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Checa Dup Titulo (ObjDupTit)
        par_oPg.AddObject("lbl_4c_LblDupTit", "Label")
        WITH par_oPg.lbl_4c_LblDupTit
            .Caption = "Checa Dup.T" + CHR(237) + "tulo:"
            .Top = 361
            .Left = 17
            .Width = 156
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("ObjDupTit", "OptionGroup")
        loc_oOpt = par_oPg.ObjDupTit
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 361
            .Left = 174
            .Width = 92
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Col direita: saldo/relevante/etc (Left 469)
        *-- Calcular Saldo (Opt_Saldo)
        par_oPg.AddObject("lbl_4c_LblSaldo", "Label")
        WITH par_oPg.lbl_4c_LblSaldo
            .Caption = "Calcular Saldo:"
            .Top = 29
            .Left = 290
            .Width = 178
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Opt_Saldo", "OptionGroup")
        loc_oOpt = par_oPg.Opt_Saldo
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 29
            .Left = 469
            .Width = 149
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Empresa Relevante (Opt_Relevante)
        par_oPg.AddObject("lbl_4c_LblRelev", "Label")
        WITH par_oPg.lbl_4c_LblRelev
            .Caption = "Empresa Relevante:"
            .Top = 53
            .Left = 290
            .Width = 178
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Opt_Relevante", "OptionGroup")
        loc_oOpt = par_oPg.Opt_Relevante
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 53
            .Left = 469
            .Width = 149
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Bloqueia Consulta GV (Opt_BlqConGV)
        par_oPg.AddObject("lbl_4c_LblBlqConGV", "Label")
        WITH par_oPg.lbl_4c_LblBlqConGV
            .Caption = "Bloqueia Consulta GV:"
            .Top = 77
            .Left = 290
            .Width = 178
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Opt_BlqConGV", "OptionGroup")
        loc_oOpt = par_oPg.Opt_BlqConGV
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 77
            .Left = 469
            .Width = 149
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Patrimonialpor Etiq (Opt_Patrim)
        par_oPg.AddObject("lbl_4c_LblPatrim", "Label")
        WITH par_oPg.lbl_4c_LblPatrim
            .Caption = "Patrimonial/Etiqueta:"
            .Top = 101
            .Left = 290
            .Width = 178
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Opt_Patrim", "OptionGroup")
        loc_oOpt = par_oPg.Opt_Patrim
        WITH loc_oOpt
            .ButtonCount = 2
            .Top = 101
            .Left = 469
            .Width = 149
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "Sim"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 40
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(2).Left = 48
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 44
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.

        *-- Tipo Inventario (OpTipoInvs, 3 btn)
        par_oPg.AddObject("lbl_4c_LblTipoInv", "Label")
        WITH par_oPg.lbl_4c_LblTipoInv
            .Caption = "Tipo Invent" + CHR(225) + "rio:"
            .Top = 125
            .Left = 290
            .Width = 178
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("OpTipoInvs", "OptionGroup")
        loc_oOpt = par_oPg.OpTipoInvs
        WITH loc_oOpt
            .ButtonCount = 3
            .Top = 125
            .Left = 470
            .Width = 371
            .Height = 25
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 44
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "Inventario"
        loc_oOpt.Buttons(2).Left = 54
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 80
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.
        loc_oOpt.Buttons(3).Caption = "Coletor"
        loc_oOpt.Buttons(3).Left = 139
        loc_oOpt.Buttons(3).Top = 3
        loc_oOpt.Buttons(3).Width = 60
        loc_oOpt.Buttons(3).FontName = "Tahoma"
        loc_oOpt.Buttons(3).FontSize = 8
        loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(3).Themes = .F.

        *-- Diferenca de Peso
        par_oPg.AddObject("lbl_4c_LblDifPeso", "Label")
        WITH par_oPg.lbl_4c_LblDifPeso
            .Caption = "Diferen" + CHR(231) + "a Peso:"
            .Top = 191
            .Left = 350
            .Width = 123
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Get_DifPeso", "TextBox")
        WITH par_oPg.Get_DifPeso
            .Value = 0
            .Top = 191
            .Left = 480
            .Width = 68
            .Height = 24
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes = .F.
            .SpecialEffect = 0
            .Visible = .T.
        ENDWITH

        *-- Sinal +/-
        par_oPg.AddObject("lbl_4c_LblSinal", "Label")
        WITH par_oPg.lbl_4c_LblSinal
            .Caption = "Sinal:"
            .Top = 191
            .Left = 550
            .Width = 35
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Get_Sinal", "ComboBox")
        WITH par_oPg.Get_Sinal
            .Value = 1
            .Top = 191
            .Left = 552
            .Width = 48
            .Height = 24
            .RowSourceType = 1
            .RowSource = "+,-"
            .Style = 2
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .Themes = .F.
            .Visible = .T.
        ENDWITH

        *-- Tipo Falhas (Get_tfalhas - P ou Q)
        par_oPg.AddObject("lbl_4c_LblPq", "Label")
        WITH par_oPg.lbl_4c_LblPq
            .Caption = "Tipo:"
            .Top = 191
            .Left = 602
            .Width = 30
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Get_tfalhas", "TextBox")
        WITH par_oPg.Get_tfalhas
            .Value = ""
            .Top = 191
            .Left = 601
            .Width = 17
            .Height = 24
            .MaxLength = 1
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes = .F.
            .SpecialEffect = 0
            .Visible = .T.
        ENDWITH

        *-- Grupo Nao Selecionavel (op_invisivel)
        par_oPg.AddObject("op_invisivel", "CheckBox")
        WITH par_oPg.op_invisivel
            .Caption = "Grupo N" + CHR(227) + "o Selecion" + CHR(225) + "vel"
            .Top = 81
            .Left = 724
            .Width = 137
            .Height = 15
            .Value = 0
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        *-- Dias bloqueio retroativo
        par_oPg.AddObject("lbl_4c_LblDdr", "Label")
        WITH par_oPg.lbl_4c_LblDdr
            .Caption = "Dias Bloq.Ret.:"
            .Top = 30
            .Left = 670
            .Width = 105
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("get_ddr", "TextBox")
        WITH par_oPg.get_ddr
            .Value = 0
            .Top = 30
            .Left = 852
            .Width = 45
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes = .F.
            .SpecialEffect = 0
            .Visible = .T.
        ENDWITH

        *-- Dias bloqueio futuro
        par_oPg.AddObject("lbl_4c_LblDdf", "Label")
        WITH par_oPg.lbl_4c_LblDdf
            .Caption = "Dias Bloq.Fut.:"
            .Top = 54
            .Left = 670
            .Width = 105
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("get_ddf", "TextBox")
        WITH par_oPg.get_ddf
            .Value = 0
            .Top = 54
            .Left = 852
            .Width = 45
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes = .F.
            .SpecialEffect = 0
            .Visible = .T.
        ENDWITH

        *-- Transfere Peso (Chk_TrfPeso, 5 btn)
        par_oPg.AddObject("lbl_4c_LblTrfPeso", "Label")
        WITH par_oPg.lbl_4c_LblTrfPeso
            .Caption = "Transfere Peso:"
            .Top = 216
            .Left = 350
            .Width = 123
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Chk_TrfPeso", "OptionGroup")
        loc_oOpt = par_oPg.Chk_TrfPeso
        WITH loc_oOpt
            .ButtonCount = 5
            .Top = 216
            .Left = 474
            .Width = 186
            .Height = 95
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 80
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "Por Kg"
        loc_oOpt.Buttons(2).Left = 5
        loc_oOpt.Buttons(2).Top = 20
        loc_oOpt.Buttons(2).Width = 80
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.
        loc_oOpt.Buttons(3).Caption = "Por Un"
        loc_oOpt.Buttons(3).Left = 5
        loc_oOpt.Buttons(3).Top = 38
        loc_oOpt.Buttons(3).Width = 80
        loc_oOpt.Buttons(3).FontName = "Tahoma"
        loc_oOpt.Buttons(3).FontSize = 8
        loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(3).Themes = .F.
        loc_oOpt.Buttons(4).Caption = "Por Kg (%)"
        loc_oOpt.Buttons(4).Left = 5
        loc_oOpt.Buttons(4).Top = 56
        loc_oOpt.Buttons(4).Width = 80
        loc_oOpt.Buttons(4).FontName = "Tahoma"
        loc_oOpt.Buttons(4).FontSize = 8
        loc_oOpt.Buttons(4).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(4).Themes = .F.
        loc_oOpt.Buttons(5).Caption = "Por Un (%)"
        loc_oOpt.Buttons(5).Left = 5
        loc_oOpt.Buttons(5).Top = 74
        loc_oOpt.Buttons(5).Width = 80
        loc_oOpt.Buttons(5).FontName = "Tahoma"
        loc_oOpt.Buttons(5).FontSize = 8
        loc_oOpt.Buttons(5).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(5).Themes = .F.

        *-- Agrupa Componentes (op_compagru, 3 btn)
        par_oPg.AddObject("lbl_4c_LblCompagru", "Label")
        WITH par_oPg.lbl_4c_LblCompagru
            .Caption = "Agrupa Comp.:"
            .Top = 337
            .Left = 350
            .Width = 123
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("op_compagru", "OptionGroup")
        loc_oOpt = par_oPg.op_compagru
        WITH loc_oOpt
            .ButtonCount = 3
            .Top = 337
            .Left = 474
            .Width = 186
            .Height = 21
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 44
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "Tipo"
        loc_oOpt.Buttons(2).Left = 54
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 50
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.
        loc_oOpt.Buttons(3).Caption = "Produto"
        loc_oOpt.Buttons(3).Left = 109
        loc_oOpt.Buttons(3).Top = 3
        loc_oOpt.Buttons(3).Width = 60
        loc_oOpt.Buttons(3).FontName = "Tahoma"
        loc_oOpt.Buttons(3).FontSize = 8
        loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(3).Themes = .F.

        *-- Agrupamento
        par_oPg.AddObject("lbl_4c_LblAgrupa", "Label")
        WITH par_oPg.lbl_4c_LblAgrupa
            .Caption = "Agrupamento:"
            .Top = 362
            .Left = 350
            .Width = 123
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Get_Agrupa", "TextBox")
        WITH par_oPg.Get_Agrupa
            .Value = ""
            .Top = 362
            .Left = 480
            .Width = 150
            .Height = 23
            .MaxLength = 10
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes = .F.
            .SpecialEffect = 0
            .Visible = .T.
        ENDWITH

        *-- Controle de Lote (Fwoption1, 3 btn)
        par_oPg.AddObject("lbl_4c_LblCtrlote", "Label")
        WITH par_oPg.lbl_4c_LblCtrlote
            .Caption = "Controle de Lote:"
            .Top = 390
            .Left = 350
            .Width = 123
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Alignment = 1
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("Fwoption1", "OptionGroup")
        loc_oOpt = par_oPg.Fwoption1
        WITH loc_oOpt
            .ButtonCount = 3
            .Top = 390
            .Left = 474
            .Width = 164
            .Height = 21
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            .Visible = .T.
        ENDWITH
        loc_oOpt.Buttons(1).Caption = "N" + CHR(227) + "o"
        loc_oOpt.Buttons(1).Left = 5
        loc_oOpt.Buttons(1).Top = 3
        loc_oOpt.Buttons(1).Width = 44
        loc_oOpt.Buttons(1).FontName = "Tahoma"
        loc_oOpt.Buttons(1).FontSize = 8
        loc_oOpt.Buttons(1).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(1).Themes = .F.
        loc_oOpt.Buttons(2).Caption = "Simples"
        loc_oOpt.Buttons(2).Left = 54
        loc_oOpt.Buttons(2).Top = 3
        loc_oOpt.Buttons(2).Width = 60
        loc_oOpt.Buttons(2).FontName = "Tahoma"
        loc_oOpt.Buttons(2).FontSize = 8
        loc_oOpt.Buttons(2).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(2).Themes = .F.
        loc_oOpt.Buttons(3).Caption = "Completo"
        loc_oOpt.Buttons(3).Left = 119
        loc_oOpt.Buttons(3).Top = 3
        loc_oOpt.Buttons(3).Width = 65
        loc_oOpt.Buttons(3).FontName = "Tahoma"
        loc_oOpt.Buttons(3).FontSize = 8
        loc_oOpt.Buttons(3).ForeColor = RGB(90,90,90)
        loc_oOpt.Buttons(3).Themes = .F.

        *-- Os/Alianca/Fundicao checkboxes (Container1)
        par_oPg.AddObject("cnt_4c_OsAlfun", "Container")
        WITH par_oPg.cnt_4c_OsAlfun
            .Top = 308
            .Left = 354
            .Width = 347
            .Height = 27
            .BackStyle = 1
            .BackColor = RGB(245,245,245)
            .BorderWidth = 0
            .Visible = .T.
        ENDWITH

        par_oPg.cnt_4c_OsAlfun.AddObject("chk_Os", "CheckBox")
        WITH par_oPg.cnt_4c_OsAlfun.chk_Os
            .Caption = "OS"
            .Top = 5
            .Left = 10
            .Width = 45
            .Height = 15
            .Value = 0
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        par_oPg.cnt_4c_OsAlfun.AddObject("chk_Alianca", "CheckBox")
        WITH par_oPg.cnt_4c_OsAlfun.chk_Alianca
            .Caption = "Alian" + CHR(231) + "a"
            .Top = 5
            .Left = 65
            .Width = 65
            .Height = 15
            .Value = 0
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        par_oPg.cnt_4c_OsAlfun.AddObject("chk_Fundicao", "CheckBox")
        WITH par_oPg.cnt_4c_OsAlfun.chk_Fundicao
            .Caption = "Fundi" + CHR(231) + CHR(227) + "o"
            .Top = 5
            .Left = 140
            .Width = 70
            .Height = 15
            .Value = 0
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarAbaFaturamento - Controles da aba Faturamento (pgf_4c_1.Page4)
    * 9 containers de impostos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarAbaFaturamento(par_oPg)
        LOCAL loc_aCfg, loc_nI, loc_oCnt
        LOCAL loc_cNome, loc_cProp, loc_nTop

        *-- Shapes de fundo (borda e separadores de coluna)
        par_oPg.AddObject("shp_4c_Border", "Shape")
        WITH par_oPg.shp_4c_Border
            .Top           = 50
            .Left          = 45
            .Width         = 673
            .Height        = 261
            .BackStyle     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        par_oPg.AddObject("shp_4c_ColGrupo", "Shape")
        WITH par_oPg.shp_4c_ColGrupo
            .Top           = 50
            .Left          = 106
            .Width         = 90
            .Height        = 261
            .BackStyle     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        par_oPg.AddObject("shp_4c_HdrLine", "Shape")
        WITH par_oPg.shp_4c_HdrLine
            .Top           = 71
            .Left          = 45
            .Width         = 671
            .Height        = 1
            .BackStyle     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        par_oPg.AddObject("shp_4c_ColAliq", "Shape")
        WITH par_oPg.shp_4c_ColAliq
            .Top           = 50
            .Left          = 576
            .Width         = 52
            .Height        = 261
            .BackStyle     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- Headers
        par_oPg.AddObject("lbl_4c_HdrImpostos", "Label")
        WITH par_oPg.lbl_4c_HdrImpostos
            .Caption = "Impostos"
            .Top = 53
            .Left = 53
            .Width = 60
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("lbl_4c_HdrGrupo", "Label")
        WITH par_oPg.lbl_4c_HdrGrupo
            .Caption = "Grupo"
            .Top = 53
            .Left = 131
            .Width = 60
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("lbl_4c_HdrConta", "Label")
        WITH par_oPg.lbl_4c_HdrConta
            .Caption = "Conta e Descri" + CHR(231) + CHR(227) + "o"
            .Top = 53
            .Left = 328
            .Width = 150
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("lbl_4c_HdrAliq", "Label")
        WITH par_oPg.lbl_4c_HdrAliq
            .Caption = "Al" + CHR(237) + "quota"
            .Top = 53
            .Left = 579
            .Width = 60
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        par_oPg.AddObject("lbl_4c_HdrReceita", "Label")
        WITH par_oPg.lbl_4c_HdrReceita
            .Caption = "Receita"
            .Top = 53
            .Left = 650
            .Width = 60
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        *-- Array: nome exibicao, prefixo container, prop BO, top, label left
        DIMENSION loc_aCfg(9, 5)
        loc_aCfg(1,1) = "ICMS"
        loc_aCfg(1,2) = "cntIC"
        loc_aCfg(1,3) = "this_cCfgfisics"
        loc_aCfg(1,4) = 75
        loc_aCfg(1,5) = 32
        loc_aCfg(2,1) = "IPI"
        loc_aCfg(2,2) = "cntIP"
        loc_aCfg(2,3) = "this_cCfgfisips"
        loc_aCfg(2,4) = 101
        loc_aCfg(2,5) = 43
        loc_aCfg(3,1) = "II"
        loc_aCfg(3,2) = "cntII"
        loc_aCfg(3,3) = "this_cCfgfisiis"
        loc_aCfg(3,4) = 127
        loc_aCfg(3,5) = 49
        loc_aCfg(4,1) = "ISS"
        loc_aCfg(4,2) = "cntIS"
        loc_aCfg(4,3) = "this_cCfgfisiss"
        loc_aCfg(4,4) = 153
        loc_aCfg(4,5) = 41
        loc_aCfg(5,1) = "IRRF"
        loc_aCfg(5,2) = "cntIR"
        loc_aCfg(5,3) = "this_cCfgfisirs"
        loc_aCfg(5,4) = 179
        loc_aCfg(5,5) = 33
        loc_aCfg(6,1) = "INSS"
        loc_aCfg(6,2) = "cntIN"
        loc_aCfg(6,3) = "this_cCfgfisins"
        loc_aCfg(6,4) = 205
        loc_aCfg(6,5) = 34
        loc_aCfg(7,1) = "PIS"
        loc_aCfg(7,2) = "cntPI"
        loc_aCfg(7,3) = "this_cCfgfispis"
        loc_aCfg(7,4) = 230
        loc_aCfg(7,5) = 41
        loc_aCfg(8,1) = "CSSL"
        loc_aCfg(8,2) = "cntCS"
        loc_aCfg(8,3) = "this_cCfgfiscss"
        loc_aCfg(8,4) = 256
        loc_aCfg(8,5) = 33
        loc_aCfg(9,1) = "COFINS"
        loc_aCfg(9,2) = "cntCO"
        loc_aCfg(9,3) = "this_cCfgfiscos"
        loc_aCfg(9,4) = 282
        loc_aCfg(9,5) = 19

        LOCAL loc_nLblLeft
        FOR loc_nI = 1 TO 9
            loc_cNome    = loc_aCfg(loc_nI, 1)
            loc_cProp    = loc_aCfg(loc_nI, 2)
            loc_nTop     = loc_aCfg(loc_nI, 4)
            loc_nLblLeft = loc_aCfg(loc_nI, 5)

            par_oPg.AddObject(loc_cProp, "Container")
            loc_oCnt = par_oPg.Controls(par_oPg.ControlCount)
            WITH loc_oCnt
                .Top = loc_nTop
                .Left = 45
                .Width = 673
                .Height = 25
                .BackStyle = 1
                .BackColor = RGB(240,240,240)
                .BorderWidth = 0
                .Visible = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Tax", "Label")
            WITH loc_oCnt.lbl_4c_Tax
                .Caption = loc_cNome
                .Top = 5
                .Left = loc_nLblLeft
                .Width = 55
                .Height = 17
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .T.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
                .Visible = .T.
            ENDWITH

            loc_oCnt.AddObject("getCdGrupos", "TextBox")
            WITH loc_oCnt.getCdGrupos
                .Value = ""
                .Top = 2
                .Left = 66
                .Width = 80
                .Height = 21
                .MaxLength = 10
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(90,90,90)
                .BackColor = RGB(255,255,255)
                .Themes = .F.
                .SpecialEffect = 1
                .Visible = .T.
            ENDWITH

            loc_oCnt.AddObject("getCdContas", "TextBox")
            WITH loc_oCnt.getCdContas
                .Value = ""
                .Top = 2
                .Left = 155
                .Width = 80
                .Height = 21
                .MaxLength = 10
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(90,90,90)
                .BackColor = RGB(255,255,255)
                .Themes = .F.
                .SpecialEffect = 1
                .Visible = .T.
            ENDWITH

            loc_oCnt.AddObject("getDsContas", "TextBox")
            WITH loc_oCnt.getDsContas
                .Value = ""
                .Top = 2
                .Left = 237
                .Width = 290
                .Height = 21
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(90,90,90)
                .BackColor = RGB(255,255,230)
                .ReadOnly = .T.
                .Themes = .F.
                .SpecialEffect = 1
                .Visible = .T.
            ENDWITH

            loc_oCnt.AddObject("getPctAliqs", "TextBox")
            WITH loc_oCnt.getPctAliqs
                .Value = 0
                .Top = 2
                .Left = 536
                .Width = 42
                .Height = 21
                .InputMask = "99.99"
                .Alignment = 3
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(90,90,90)
                .BackColor = RGB(255,255,255)
                .Themes = .F.
                .SpecialEffect = 1
                .Visible = .T.
            ENDWITH

            loc_oCnt.AddObject("getReceitas", "TextBox")
            WITH loc_oCnt.getReceitas
                .Value = ""
                .Top = 2
                .Left = 588
                .Width = 80
                .Height = 21
                .MaxLength = 10
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(90,90,90)
                .BackColor = RGB(255,255,255)
                .Themes = .F.
                .SpecialEffect = 1
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCnt.getCdGrupos, "GotFocus",  THIS, "GrupoFatGotFocus")
            BINDEVENT(loc_oCnt.getCdGrupos, "KeyPress",  THIS, "GrupoFatKeyPress")
            BINDEVENT(loc_oCnt.getCdGrupos, "DblClick",  THIS, "GrupoFatDblClick")
            BINDEVENT(loc_oCnt.getCdGrupos, "KeyPress", THIS, "GrupoFatLostFocus")
            BINDEVENT(loc_oCnt.getCdContas, "GotFocus",  THIS, "ContaFatGotFocus")
            BINDEVENT(loc_oCnt.getCdContas, "KeyPress",  THIS, "ContaFatKeyPress")
            BINDEVENT(loc_oCnt.getCdContas, "DblClick",  THIS, "ContaFatDblClick")
            BINDEVENT(loc_oCnt.getCdContas, "KeyPress", THIS, "ContaFatLostFocus")
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Popula cursor_4c_Dados e atualiza grd_4c_Lista
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                CREATE CURSOR cursor_4c_Dados (codigos C(10), descrs C(40))
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    THIS.AtualizarGrid()
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formccr.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarGrid - Wire RecordSource e colunas do grd_4c_Lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarGrid()
        LOCAL loc_oGrid
        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

        loc_oGrid.ColumnCount = 2
        loc_oGrid.RecordSource = "cursor_4c_Dados"
        loc_oGrid.ColumnCount  = 2

        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"

        loc_oGrid.Column1.Width = 120
        loc_oGrid.Column2.Width = 400

        loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
        loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega entre Page1 (Lista=1) e Page2 (Dados=2)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formccr.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita Confirmar conforme modo
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lEdicao
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdicao
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Limpa valores dos campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparDados()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c_Codigo.Value = ""
            loc_oPg2.txt_4c_Digito.Value = ""
            loc_oPg2.txt_4c_Descr.Value  = ""
            loc_oPg2.txt_4c_Interno.Value = ""
            loc_oPg2.txt_4c_Classes.Value = ""
            loc_oPg2.txt_4c_DClasses.Value = ""
            loc_oPg2.obj_4c_Opt_TpCods.Value = 1
            loc_oPg2.obj_4c_Opt_TpEmps.Value = 1
            loc_oPg2.obj_4c_Opt_TpCads.Value = 1
            THIS.LimparAbaGeral(loc_oPg2)
            THIS.LimparAbaCadastro(loc_oPg2)
            THIS.LimparAbaEstoque(loc_oPg2)
            THIS.LimparAbaFaturamento(loc_oPg2)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparAbaGeral
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparAbaGeral(par_oPg2)
        LOCAL loc_oPgAba
        loc_oPgAba = par_oPg2.pgf_4c_1.Page1

        TRY
            loc_oPgAba.obj_4c_Opt_Comple.Value    = 1
            loc_oPgAba.obj_4c_Opt_Pessoais.Value  = 1
            loc_oPgAba.obj_4c_Opt_RefBancs.Value  = 1
            loc_oPgAba.obj_4c_Opt_FollowUp.Value  = 1
            loc_oPgAba.obj_4c_Opt_Fiscais.Value   = 1
            loc_oPgAba.obj_4c_Opt_Empresa.Value   = 1
            loc_oPgAba.obj_4c_Opt_Contabs.Value   = 1
            loc_oPgAba.obj_4c_Opt_Caracteris.Value = 1
            loc_oPgAba.obj_4c_Fwoption1.Value     = 1
            loc_oPgAba.obj_4c_Fwoption2.Value     = 1
            loc_oPgAba.obj_4c_Opt_DadosCom.Value  = 1
            loc_oPgAba.obj_4c_Opt_Respos.Value    = 1
            loc_oPgAba.obj_4c_Opt_LimCre.Value    = 1
            loc_oPgAba.obj_4c_Opt_Comi.Value      = 1
            loc_oPgAba.obj_4c_Opt_Cargo.Value     = 1
            loc_oPgAba.obj_4c_Opt_ChkLimCr.Value  = 1
            loc_oPgAba.obj_4c_OptPreCad.Value     = 1
            loc_oPgAba.obj_4c_Opt_Coletor.Value   = 1
            loc_oPgAba.txt_4c_Vrlimc.Value = 0
            loc_oPgAba.txt_4c__molimc.Value = ""
            loc_oPgAba.txt_4c__cd_moeda.Value = ""
            loc_oPgAba.txt_4c__ds_moeda.Value = ""
            loc_oPgAba.txt_4c_Grupo.Value = ""
            loc_oPgAba.obj_4c_GetRodRelCC.Value = ""
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparAbaGeral")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparAbaCadastro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparAbaCadastro(par_oPg2)
        LOCAL loc_oPgAba
        loc_oPgAba = par_oPg2.pgf_4c_1.Page2

        TRY
            loc_oPgAba.Opt_CPFObrig.Value   = 1
            loc_oPgAba.fwoption2.Value       = 1
            loc_oPgAba.optCalcIMeds.Value    = 1
            loc_oPgAba.getObrMails.Value     = 1
            loc_oPgAba.getObrNome.Value      = 1
            loc_oPgAba.Fwoption15.Value      = 1
            loc_oPgAba.getObrSit.Value       = 1
            loc_oPgAba.getObrTlm.Value       = 1
            loc_oPgAba.getObrCla.Value       = 1
            loc_oPgAba.getObrSeg.Value       = 1
            loc_oPgAba.Fwoption6.Value       = 1
            loc_oPgAba.Fwoption7.Value       = 1
            loc_oPgAba.Fwoption12.Value      = 1
            loc_oPgAba.Fwoption13.Value      = 1
            loc_oPgAba.Fwoption14.Value      = 1
            loc_oPgAba.Fwoption8.Value       = 1
            loc_oPgAba.Fwoption9.Value       = 1
            loc_oPgAba.Fwoption11.Value      = 1
            loc_oPgAba.Fwoption10.Value      = 1
            loc_oPgAba.Opt_CEPObrig.Value    = 1
            loc_oPgAba.getObrIbge.Value      = 1
            loc_oPgAba.Fwoption4.Value       = 1
            loc_oPgAba.Fwoption5.Value       = 1
            loc_oPgAba.Fwoption16.Value      = 1
            loc_oPgAba.Opt_MFotos.Value      = 1
            loc_oPgAba.fwoption1.Value       = 1
            loc_oPgAba.optCpffixo.Value      = 1
            loc_oPgAba.getSituas.Value       = ""
            loc_oPgAba.optCarac.Value        = 1
            loc_oPgAba.optAceJob.Value       = 1
            loc_oPgAba.OptAlertaCad.Value    = 1
            loc_oPgAba.Getcontint.Value      = ""
            loc_oPgAba.Opt_Integ.Value       = 1
            loc_oPgAba.Fwoption3.Value       = 1
            loc_oPgAba.optVincPgRcs.Value    = 1
            loc_oPgAba.OptTitBaixado.Value   = 1
            loc_oPgAba.getMsgAlertaC.Value   = ""
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparAbaCadastro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparAbaEstoque
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparAbaEstoque(par_oPg2)
        LOCAL loc_oPgAba
        loc_oPgAba = par_oPg2.pgf_4c_1.Page3

        TRY
            loc_oPgAba.Opt_LimEsto.Value   = 1
            loc_oPgAba.Opt_VerEst.Value    = 1
            loc_oPgAba.Opt_EstPAcab.Value  = 1
            loc_oPgAba.opt_ChkLimest.Value = 1
            loc_oPgAba.Opt_CCusto.Value    = 1
            loc_oPgAba.Opt_GBals.Value     = 1
            loc_oPgAba.Opt_UnifBal.Value   = 1
            loc_oPgAba.Opt_FalPers.Value   = 1
            loc_oPgAba.Opt_BlqDivOp.Value  = 1
            loc_oPgAba.Opt_Saldo.Value     = 1
            loc_oPgAba.Opt_Relevante.Value = 1
            loc_oPgAba.Opt_BlqConGV.Value  = 1
            loc_oPgAba.Opt_Patrim.Value    = 1
            loc_oPgAba.OpTipoInvs.Value    = 1
            loc_oPgAba.Chk_TrfPeso.Value   = 1
            loc_oPgAba.op_compagru.Value   = 1
            loc_oPgAba.Fwoption1.Value     = 1
            loc_oPgAba.Get_OsPend.Value    = 1
            loc_oPgAba.ObjDupTit.Value     = 1
            loc_oPgAba.Get_grupo.Value     = ""
            loc_oPgAba.Get_DifPeso.Value   = 0
            loc_oPgAba.Get_Sinal.Value     = 1
            loc_oPgAba.Get_tfalhas.Value   = ""
            loc_oPgAba.Get_Agrupa.Value    = ""
            loc_oPgAba.get_ddr.Value       = 0
            loc_oPgAba.get_ddf.Value       = 0
            loc_oPgAba.op_invisivel.Value  = 0
            loc_oPgAba.cnt_4c_OsAlfun.chk_Os.Value       = 0
            loc_oPgAba.cnt_4c_OsAlfun.chk_Alianca.Value  = 0
            loc_oPgAba.cnt_4c_OsAlfun.chk_Fundicao.Value = 0
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparAbaEstoque")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparAbaFaturamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparAbaFaturamento(par_oPg2)
        LOCAL loc_oPgAba, loc_aCnt, loc_nI, loc_oCnt, loc_nIdx
        loc_oPgAba = par_oPg2.pgf_4c_1.Page4

        DIMENSION loc_aCnt(9)
        loc_aCnt(1) = "cntIC"
        loc_aCnt(2) = "cntIP"
        loc_aCnt(3) = "cntII"
        loc_aCnt(4) = "cntIS"
        loc_aCnt(5) = "cntIR"
        loc_aCnt(6) = "cntIN"
        loc_aCnt(7) = "cntPI"
        loc_aCnt(8) = "cntCS"
        loc_aCnt(9) = "cntCO"

        TRY
            FOR loc_nI = 1 TO 9
                IF PEMSTATUS(loc_oPgAba, loc_aCnt(loc_nI), 5)
                    loc_nIdx = THIS.ObterIndiceControle(loc_oPgAba, loc_aCnt(loc_nI))
                    loc_oCnt = loc_oPgAba.Controls(loc_nIdx)
                    IF VARTYPE(loc_oCnt) = "O"
                        loc_oCnt.getCdGrupos.Value = ""
                        loc_oCnt.getCdContas.Value = ""
                        loc_oCnt.getDsContas.Value = ""
                        loc_oCnt.getPctAliqs.Value = 0
                        loc_oCnt.getReceitas.Value = ""
                    ENDIF
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparAbaFaturamento")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos conforme modo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lEdicao
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        TRY
            *-- Codigo: editavel somente em INCLUIR (PK nao muda em ALTERAR)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
                loc_oPg2.txt_4c_Codigo.ReadOnly = !(THIS.this_cModoAtual = "INCLUIR")
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Digito", 5)
                loc_oPg2.txt_4c_Digito.ReadOnly = !loc_lEdicao
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Descr", 5)
                loc_oPg2.txt_4c_Descr.ReadOnly = !loc_lEdicao
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Interno", 5)
                loc_oPg2.txt_4c_Interno.ReadOnly = !loc_lEdicao
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Classes", 5)
                loc_oPg2.txt_4c_Classes.ReadOnly = !loc_lEdicao
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere BO -> controles da Page2
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_oBO, loc_oPgAba, loc_cCfg, loc_nVal
        LOCAL loc_aCnt, loc_nI, loc_oCnt, loc_cProp, loc_cFisStr
        LOCAL loc_cConta, loc_nRet
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        TRY
            *-- Identificacao basica
            loc_oPg2.txt_4c_Codigo.Value  = ALLTRIM(loc_oBO.this_cCodigos)
            loc_oPg2.txt_4c_Digito.Value  = ALLTRIM(loc_oBO.this_cDgcods)
            loc_oPg2.txt_4c_Descr.Value   = ALLTRIM(loc_oBO.this_cDescrs)
            loc_oPg2.txt_4c_Interno.Value = ALLTRIM(loc_oBO.this_cInternos)
            loc_oPg2.txt_4c_Classes.Value = ALLTRIM(loc_oBO.this_cClasses)
            loc_oPg2.txt_4c_DClasses.Value = ALLTRIM(loc_oBO.this_cDClasses)

            *-- Tipos (1-based index = valor numerico + 1)
            loc_oPg2.obj_4c_Opt_TpCods.Value = IIF(loc_oBO.this_nTpcods = 0, 1, loc_oBO.this_nTpcods)
            loc_oPg2.obj_4c_Opt_TpEmps.Value = IIF(loc_oBO.this_nTpemps = 0, 1, loc_oBO.this_nTpemps)
            loc_oPg2.obj_4c_Opt_TpCads.Value = IIF(loc_oBO.this_nTpcads = 0, 1, loc_oBO.this_nTpcads)

            *-- Aba Geral
            loc_oPgAba = loc_oPg2.pgf_4c_1.Page1
            loc_oPgAba.obj_4c_Opt_Comple.Value    = IIF(loc_oBO.this_nComplems = 0, 1, loc_oBO.this_nComplems)
            loc_oPgAba.obj_4c_Opt_Pessoais.Value  = IIF(loc_oBO.this_nPessoais = 0, 1, loc_oBO.this_nPessoais)
            loc_oPgAba.obj_4c_Opt_RefBancs.Value  = IIF(loc_oBO.this_nRefbancs = 0, 1, loc_oBO.this_nRefbancs)
            loc_oPgAba.obj_4c_Opt_FollowUp.Value  = IIF(loc_oBO.this_nFollowups = 0, 1, loc_oBO.this_nFollowups)
            loc_oPgAba.obj_4c_Opt_Fiscais.Value   = IIF(loc_oBO.this_nFiscais = 0, 1, loc_oBO.this_nFiscais)
            loc_oPgAba.obj_4c_Opt_Empresa.Value   = IIF(loc_oBO.this_nEmpresas = 0, 1, loc_oBO.this_nEmpresas)
            loc_oPgAba.obj_4c_Opt_Contabs.Value   = IIF(loc_oBO.this_nContabs = 0, 1, loc_oBO.this_nContabs)
            loc_oPgAba.obj_4c_Opt_Caracteris.Value = IIF(loc_oBO.this_nCaracteris = 0, 1, loc_oBO.this_nCaracteris)
            loc_oPgAba.obj_4c_Fwoption1.Value     = IIF(loc_oBO.this_nInfcads = 0, 1, loc_oBO.this_nInfcads)
            loc_oPgAba.obj_4c_Fwoption2.Value     = IIF(loc_oBO.this_nDadcoms = 0, 1, loc_oBO.this_nDadcoms)
            loc_oPgAba.obj_4c_Opt_DadosCom.Value  = IIF(loc_oBO.this_nDadcoms = 0, 1, loc_oBO.this_nDadcoms)
            loc_oPgAba.obj_4c_Opt_Respos.Value    = IIF(loc_oBO.this_nRespos = 0, 1, loc_oBO.this_nRespos)
            loc_oPgAba.obj_4c_Opt_LimCre.Value    = IIF(loc_oBO.this_nLimcres = 0, 1, loc_oBO.this_nLimcres)
            loc_oPgAba.obj_4c_Opt_Comi.Value      = IIF(loc_oBO.this_nComis = 0, 1, loc_oBO.this_nComis)
            loc_oPgAba.obj_4c_Opt_Cargo.Value     = IIF(loc_oBO.this_nCargos = 0, 1, loc_oBO.this_nCargos)
            loc_oPgAba.obj_4c_Opt_ChkLimCr.Value  = IIF(loc_oBO.this_nChklimcrds = 0, 1, loc_oBO.this_nChklimcrds)
            loc_oPgAba.obj_4c_OptPreCad.Value     = IIF(loc_oBO.this_nPrecad = 0, 1, loc_oBO.this_nPrecad)
            loc_oPgAba.obj_4c_Opt_Coletor.Value   = IIF(loc_oBO.this_nColetors = 0, 1, loc_oBO.this_nColetors + 1)
            loc_oPgAba.txt_4c_Vrlimc.Value        = loc_oBO.this_nVrlimcre
            loc_oPgAba.txt_4c__molimc.Value       = ALLTRIM(loc_oBO.this_cMolimcre)
            loc_oPgAba.txt_4c__cd_moeda.Value     = ALLTRIM(loc_oBO.this_cCommoedas)
            loc_oPgAba.txt_4c_Grupo.Value         = ALLTRIM(loc_oBO.this_cGrupolms)
            loc_oPgAba.obj_4c_GetRodRelCC.Value   = loc_oBO.this_cRodrelcc

            *-- Descreve moeda comissao
            IF !EMPTY(ALLTRIM(loc_oBO.this_cCommoedas))
                IF SQLEXEC(gnConnHandle, "SELECT Dmoes FROM SigCdMoe WHERE RTRIM(Cmoes)=" + ;
                    EscaparSQL(ALLTRIM(loc_oBO.this_cCommoedas)), "cursor_4c_Moe") >= 0
                    IF USED("cursor_4c_Moe") AND RECCOUNT("cursor_4c_Moe") > 0
                        SELECT cursor_4c_Moe
                        loc_oPgAba.txt_4c__ds_moeda.Value = ALLTRIM(NVL(Dmoes, ""))
                    ENDIF
                    IF USED("cursor_4c_Moe")
                        USE IN cursor_4c_Moe
                    ENDIF
                ENDIF
            ELSE
                loc_oPgAba.txt_4c__ds_moeda.Value = ""
            ENDIF

            *-- Aba Cadastro - CfgCdGcr (posicoes)
            loc_oPgAba = loc_oPg2.pgf_4c_1.Page2
            loc_cCfg = PADR(loc_oBO.this_cCfgcdgcr, 40)
            *-- Pos 1: ObrMails
            loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 1, 1)))
            loc_oPgAba.getObrMails.Value  = IIF(loc_nVal = 0, 1, loc_nVal)
            *-- Pos 2: ObrNome
            loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 2, 1)))
            loc_oPgAba.getObrNome.Value   = IIF(loc_nVal = 0, 1, loc_nVal)
            *-- Pos 3: VincPgRcs
            loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 3, 1)))
            loc_oPgAba.optVincPgRcs.Value = IIF(loc_nVal = 0, 1, loc_nVal)
            *-- Pos 4: ObrSit
            loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 4, 1)))
            loc_oPgAba.getObrSit.Value    = IIF(loc_nVal = 0, 1, loc_nVal)
            *-- Pos 5: ObrTlm
            loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 5, 1)))
            loc_oPgAba.getObrTlm.Value    = IIF(loc_nVal = 0, 1, loc_nVal)
            *-- Pos 6: ObrCla
            loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 6, 1)))
            loc_oPgAba.getObrCla.Value    = IIF(loc_nVal = 0, 1, loc_nVal)
            *-- Pos 7: ObrSeg
            loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 7, 1)))
            loc_oPgAba.getObrSeg.Value    = IIF(loc_nVal = 0, 1, loc_nVal)
            *-- Pos 8: CpfFixo
            loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 8, 1)))
            loc_oPgAba.optCpffixo.Value   = IIF(loc_nVal = 0, 1, loc_nVal)
            *-- Pos 9-11: Situacao Padrao
            loc_oPgAba.getSituas.Value    = ALLTRIM(SUBSTR(loc_cCfg, 9, 3))
            *-- Pos 12: Carac
            loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 12, 1)))
            loc_oPgAba.optCarac.Value     = IIF(loc_nVal = 0, 1, loc_nVal)
            *-- Pos 13: AceJob
            loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 13, 1)))
            loc_oPgAba.optAceJob.Value    = IIF(loc_nVal = 0, 1, loc_nVal)
            *-- Pos 14: ObrIbge
            loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 14, 1)))
            loc_oPgAba.getObrIbge.Value   = IIF(loc_nVal = 0, 1, loc_nVal)

            *-- Demais campos da aba Cadastro
            loc_oPgAba.Opt_CPFObrig.Value  = IIF(loc_oBO.this_nCpfobrigs = 0, 1, loc_oBO.this_nCpfobrigs)
            loc_oPgAba.optCalcIMeds.Value  = IIF(loc_oBO.this_nCalcimeds = 0, 1, loc_oBO.this_nCalcimeds)
            loc_oPgAba.Fwoption4.Value     = IIF(loc_oBO.this_nChkendds = 0, 1, loc_oBO.this_nChkendds)
            loc_oPgAba.Fwoption5.Value     = IIF(loc_oBO.this_nChkendrs = 0, 1, loc_oBO.this_nChkendrs)
            loc_oPgAba.Opt_MFotos.Value    = IIF(loc_oBO.this_nMfotos = 0, 1, loc_oBO.this_nMfotos)
            loc_oPgAba.fwoption1.Value     = IIF(loc_oBO.this_nObservas = 0, 1, loc_oBO.this_nObservas)
            loc_oPgAba.Fwoption14.Value    = IIF(loc_oBO.this_nEndobr = 0, 1, loc_oBO.this_nEndobr)
            loc_oPgAba.Fwoption8.Value     = IIF(loc_oBO.this_nNumobr = 0, 1, loc_oBO.this_nNumobr)
            loc_oPgAba.Fwoption9.Value     = IIF(loc_oBO.this_nBairroobr = 0, 1, loc_oBO.this_nBairroobr)
            loc_oPgAba.Fwoption11.Value    = IIF(loc_oBO.this_nCidasobr = 0, 1, loc_oBO.this_nCidasobr)
            loc_oPgAba.Fwoption10.Value    = IIF(loc_oBO.this_nPaisesobr = 0, 1, loc_oBO.this_nPaisesobr)
            loc_oPgAba.Opt_CEPObrig.Value  = IIF(loc_oBO.this_nCepobris = 0, 1, loc_oBO.this_nCepobris)
            loc_oPgAba.Fwoption12.Value    = IIF(loc_oBO.this_nTel1obr = 0, 1, loc_oBO.this_nTel1obr)
            loc_oPgAba.Fwoption13.Value    = IIF(loc_oBO.this_nTel2obr = 0, 1, loc_oBO.this_nTel2obr)
            loc_oPgAba.Fwoption6.Value     = IIF(loc_oBO.this_nNascobr = 0, 1, loc_oBO.this_nNascobr)
            loc_oPgAba.Fwoption7.Value     = IIF(loc_oBO.this_nSexobr = 0, 1, loc_oBO.this_nSexobr)
            loc_oPgAba.Fwoption15.Value    = 1
            loc_oPgAba.Fwoption16.Value    = IIF(loc_oBO.this_nChkendds = 0, 1, loc_oBO.this_nChkendds)
            loc_oPgAba.fwoption2.Value     = 1
            loc_oPgAba.OptAlertaCad.Value  = IIF(loc_oBO.this_nDefhideshow = 0, 1, loc_oBO.this_nDefhideshow)
            loc_oPgAba.getMsgAlertaC.Value = ""
            loc_oPgAba.Getcontint.Value    = ALLTRIM(loc_oBO.this_cContconts)
            loc_oPgAba.Opt_Integ.Value     = IIF(loc_oBO.this_nIntconts = 0, 1, loc_oBO.this_nIntconts)
            loc_oPgAba.Fwoption3.Value     = IIF(loc_oBO.this_nPadpgrecs = 0, 1, loc_oBO.this_nPadpgrecs)
            loc_oPgAba.optVincPgRcs.Value  = IIF(loc_oBO.this_nCtvinculas = 0, 1, loc_oBO.this_nCtvinculas)
            loc_oPgAba.OptTitBaixado.Value = IIF(loc_oBO.this_nTitbaixado = 0, 1, loc_oBO.this_nTitbaixado)

            *-- Aba Estoque
            loc_oPgAba = loc_oPg2.pgf_4c_1.Page3
            loc_oPgAba.Opt_LimEsto.Value   = IIF(loc_oBO.this_nLimestoqs = 0, 1, loc_oBO.this_nLimestoqs)
            loc_oPgAba.Opt_VerEst.Value    = IIF(loc_oBO.this_nVerests = 0, 1, loc_oBO.this_nVerests)
            loc_oPgAba.Opt_EstPAcab.Value  = IIF(loc_oBO.this_nEstoques = 0, 1, loc_oBO.this_nEstoques)
            loc_oPgAba.opt_ChkLimest.Value = IIF(loc_oBO.this_nChklimests = 0, 1, loc_oBO.this_nChklimests)
            loc_oPgAba.Opt_CCusto.Value    = IIF(loc_oBO.this_nCcustos = 0, 1, loc_oBO.this_nCcustos)
            loc_oPgAba.Opt_GBals.Value     = IIF(loc_oBO.this_nGerbals = 0, 1, loc_oBO.this_nGerbals)
            loc_oPgAba.Opt_UnifBal.Value   = IIF(loc_oBO.this_nUnifbals = 0, 1, loc_oBO.this_nUnifbals)
            loc_oPgAba.Opt_FalPers.Value   = IIF(loc_oBO.this_nBalfalpers = 0, 1, loc_oBO.this_nBalfalpers)
            loc_oPgAba.Opt_BlqDivOp.Value  = IIF(loc_oBO.this_nBlqdivops = 0, 1, loc_oBO.this_nBlqdivops)
            loc_oPgAba.Opt_Saldo.Value     = IIF(loc_oBO.this_nCalcsalds = 0, 1, loc_oBO.this_nCalcsalds)
            loc_oPgAba.Opt_Relevante.Value = IIF(loc_oBO.this_nEmprelevs = 0, 1, loc_oBO.this_nEmprelevs)
            loc_oPgAba.Opt_BlqConGV.Value  = IIF(loc_oBO.this_nBlqcongvs = 0, 1, loc_oBO.this_nBlqcongvs)
            loc_oPgAba.Opt_Patrim.Value    = IIF(loc_oBO.this_nPatrietqs = 0, 1, loc_oBO.this_nPatrietqs)
            loc_oPgAba.OpTipoInvs.Value    = IIF(loc_oBO.this_nTipoinvs = 0, 1, loc_oBO.this_nTipoinvs)
            loc_oPgAba.Chk_TrfPeso.Value   = IIF(loc_oBO.this_nTrfpesas = 0, 1, loc_oBO.this_nTrfpesas)
            loc_oPgAba.op_compagru.Value   = IIF(loc_oBO.this_nCompagrus = 0, 1, loc_oBO.this_nCompagrus)
            loc_oPgAba.Fwoption1.Value     = IIF(loc_oBO.this_nCtrlotes = 0, 1, loc_oBO.this_nCtrlotes)
            loc_oPgAba.Get_OsPend.Value    = IIF(loc_oBO.this_nOspends = 0, 1, loc_oBO.this_nOspends)
            loc_oPgAba.ObjDupTit.Value     = IIF(loc_oBO.this_nChktits = 0, 1, loc_oBO.this_nChktits)
            loc_oPgAba.Get_grupo.Value     = ALLTRIM(loc_oBO.this_cGrufals)
            loc_oPgAba.Get_DifPeso.Value   = loc_oBO.this_nDifpesags
            loc_oPgAba.Get_Sinal.Value     = IIF(loc_oBO.this_nSinals = 0, 1, loc_oBO.this_nSinals)
            loc_oPgAba.Get_tfalhas.Value   = ALLTRIM(loc_oBO.this_cPqs)
            loc_oPgAba.Get_Agrupa.Value    = ALLTRIM(loc_oBO.this_cAgrupas)
            loc_oPgAba.get_ddr.Value       = loc_oBO.this_nDdretros
            loc_oPgAba.get_ddf.Value       = loc_oBO.this_nDdfutus
            loc_oPgAba.op_invisivel.Value  = loc_oBO.this_nInvisivel
            *-- OsAlfuns: parse 3-char string
            loc_oPgAba.cnt_4c_OsAlfun.chk_Os.Value       = IIF(SUBSTR(loc_oBO.this_cOsalfuns, 1, 1) = "1", 1, 0)
            loc_oPgAba.cnt_4c_OsAlfun.chk_Alianca.Value  = IIF(SUBSTR(loc_oBO.this_cOsalfuns, 2, 1) = "1", 1, 0)
            loc_oPgAba.cnt_4c_OsAlfun.chk_Fundicao.Value = IIF(SUBSTR(loc_oBO.this_cOsalfuns, 3, 1) = "1", 1, 0)

            *-- Aba Faturamento: desempacotar cfgfisXXX
            loc_oPgAba = loc_oPg2.pgf_4c_1.Page4

            DIMENSION loc_aCnt(9)
            loc_aCnt(1) = "cntIC"
            loc_aCnt(2) = "cntIP"
            loc_aCnt(3) = "cntII"
            loc_aCnt(4) = "cntIS"
            loc_aCnt(5) = "cntIR"
            loc_aCnt(6) = "cntIN"
            loc_aCnt(7) = "cntPI"
            loc_aCnt(8) = "cntCS"
            loc_aCnt(9) = "cntCO"

            LOCAL loc_aProp(9)
            loc_aProp(1) = loc_oBO.this_cCfgfisics
            loc_aProp(2) = loc_oBO.this_cCfgfisips
            loc_aProp(3) = loc_oBO.this_cCfgfisiis
            loc_aProp(4) = loc_oBO.this_cCfgfisiss
            loc_aProp(5) = loc_oBO.this_cCfgfisirs
            loc_aProp(6) = loc_oBO.this_cCfgfisins
            loc_aProp(7) = loc_oBO.this_cCfgfispis
            loc_aProp(8) = loc_oBO.this_cCfgfiscss
            loc_aProp(9) = loc_oBO.this_cCfgfiscos

            FOR loc_nI = 1 TO 9
                IF PEMSTATUS(loc_oPgAba, loc_aCnt(loc_nI), 5)
                    loc_oCnt    = loc_oPgAba.Controls(THIS.ObterIndiceControle(loc_oPgAba, loc_aCnt(loc_nI)))
                    loc_cFisStr = PADR(loc_aProp(loc_nI), 50)
                    loc_cConta  = ALLTRIM(SUBSTR(loc_cFisStr, 11, 10))
                    loc_oCnt.getCdGrupos.Value = ALLTRIM(SUBSTR(loc_cFisStr, 1, 10))
                    loc_oCnt.getCdContas.Value = loc_cConta
                    loc_oCnt.getPctAliqs.Value = VAL(SUBSTR(loc_cFisStr, 21, 5))
                    loc_oCnt.getReceitas.Value = ALLTRIM(SUBSTR(loc_cFisStr, 26, 10))
                    *-- Buscar descricao da conta
                    IF !EMPTY(loc_cConta)
                        IF SQLEXEC(gnConnHandle, "SELECT RClis FROM SigCdCli WHERE RTRIM(IClis)=" + ;
                            EscaparSQL(PADR(loc_cConta, 10)), "cursor_4c_DsCnt") >= 0
                            IF USED("cursor_4c_DsCnt") AND RECCOUNT("cursor_4c_DsCnt") > 0
                                SELECT cursor_4c_DsCnt
                                loc_oCnt.getDsContas.Value = ALLTRIM(NVL(RClis, ""))
                            ENDIF
                            IF USED("cursor_4c_DsCnt")
                                USE IN cursor_4c_DsCnt
                            ENDIF
                        ENDIF
                    ELSE
                        loc_oCnt.getDsContas.Value = ""
                    ENDIF
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterIndiceControle - retorna indice de um controle pelo nome
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterIndiceControle(par_oContainer, par_cNome)
        LOCAL loc_nI
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            IF UPPER(par_oContainer.Controls(loc_nI).Name) = UPPER(par_cNome)
                RETURN loc_nI
            ENDIF
        ENDFOR
        RETURN 1
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere controles da Page2 -> BO
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_oBO, loc_oPgAba, loc_cCfg
        LOCAL loc_aCnt, loc_nI, loc_oCnt, loc_cFisStr
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        TRY
            *-- Identificacao
            loc_oBO.this_cCodigos  = ALLTRIM(NVL(loc_oPg2.txt_4c_Codigo.Value, ""))
            loc_oBO.this_cDgcods   = ALLTRIM(NVL(loc_oPg2.txt_4c_Digito.Value, ""))
            loc_oBO.this_cDescrs   = ALLTRIM(NVL(loc_oPg2.txt_4c_Descr.Value, ""))
            loc_oBO.this_cInternos = ALLTRIM(NVL(loc_oPg2.txt_4c_Interno.Value, ""))
            loc_oBO.this_cClasses  = ALLTRIM(NVL(loc_oPg2.txt_4c_Classes.Value, ""))
            loc_oBO.this_nTpcods   = NVL(loc_oPg2.obj_4c_Opt_TpCods.Value, 1)
            loc_oBO.this_nTpemps   = NVL(loc_oPg2.obj_4c_Opt_TpEmps.Value, 1)
            loc_oBO.this_nTpcads   = NVL(loc_oPg2.obj_4c_Opt_TpCads.Value, 1)

            *-- Aba Geral
            loc_oPgAba = loc_oPg2.pgf_4c_1.Page1
            loc_oBO.this_nComplems    = NVL(loc_oPgAba.obj_4c_Opt_Comple.Value, 1)
            loc_oBO.this_nPessoais    = NVL(loc_oPgAba.obj_4c_Opt_Pessoais.Value, 1)
            loc_oBO.this_nRefbancs    = NVL(loc_oPgAba.obj_4c_Opt_RefBancs.Value, 1)
            loc_oBO.this_nFollowups   = NVL(loc_oPgAba.obj_4c_Opt_FollowUp.Value, 1)
            loc_oBO.this_nFiscais     = NVL(loc_oPgAba.obj_4c_Opt_Fiscais.Value, 1)
            loc_oBO.this_nEmpresas    = NVL(loc_oPgAba.obj_4c_Opt_Empresa.Value, 1)
            loc_oBO.this_nContabs     = NVL(loc_oPgAba.obj_4c_Opt_Contabs.Value, 1)
            loc_oBO.this_nCaracteris  = NVL(loc_oPgAba.obj_4c_Opt_Caracteris.Value, 1)
            loc_oBO.this_nInfcads     = NVL(loc_oPgAba.obj_4c_Fwoption1.Value, 1)
            loc_oBO.this_nDadcoms     = NVL(loc_oPgAba.obj_4c_Opt_DadosCom.Value, 1)
            loc_oBO.this_nRespos      = NVL(loc_oPgAba.obj_4c_Opt_Respos.Value, 1)
            loc_oBO.this_nLimcres     = NVL(loc_oPgAba.obj_4c_Opt_LimCre.Value, 1)
            loc_oBO.this_nComis       = NVL(loc_oPgAba.obj_4c_Opt_Comi.Value, 1)
            loc_oBO.this_nCargos      = NVL(loc_oPgAba.obj_4c_Opt_Cargo.Value, 1)
            loc_oBO.this_nChklimcrds  = NVL(loc_oPgAba.obj_4c_Opt_ChkLimCr.Value, 1)
            loc_oBO.this_nPrecad      = NVL(loc_oPgAba.obj_4c_OptPreCad.Value, 1)
            loc_oBO.this_nColetors    = NVL(loc_oPgAba.obj_4c_Opt_Coletor.Value, 1) - 1
            loc_oBO.this_nVrlimcre    = NVL(loc_oPgAba.txt_4c_Vrlimc.Value, 0)
            loc_oBO.this_cMolimcre    = ALLTRIM(NVL(loc_oPgAba.txt_4c__molimc.Value, ""))
            loc_oBO.this_cCommoedas   = ALLTRIM(NVL(loc_oPgAba.txt_4c__cd_moeda.Value, ""))
            loc_oBO.this_cGrupolms    = ALLTRIM(NVL(loc_oPgAba.txt_4c_Grupo.Value, ""))
            loc_oBO.this_cRodrelcc    = NVL(loc_oPgAba.obj_4c_GetRodRelCC.Value, "")

            *-- Aba Cadastro -> CfgCdGcr (empacotar)
            loc_oPgAba = loc_oPg2.pgf_4c_1.Page2
            loc_cCfg = SPACE(40)
            loc_cCfg = STUFF(loc_cCfg, 1,  1, STR(NVL(loc_oPgAba.getObrMails.Value, 1),  1))
            loc_cCfg = STUFF(loc_cCfg, 2,  1, STR(NVL(loc_oPgAba.getObrNome.Value, 1),   1))
            loc_cCfg = STUFF(loc_cCfg, 3,  1, STR(NVL(loc_oPgAba.optVincPgRcs.Value, 1), 1))
            loc_cCfg = STUFF(loc_cCfg, 4,  1, STR(NVL(loc_oPgAba.getObrSit.Value, 1),    1))
            loc_cCfg = STUFF(loc_cCfg, 5,  1, STR(NVL(loc_oPgAba.getObrTlm.Value, 1),    1))
            loc_cCfg = STUFF(loc_cCfg, 6,  1, STR(NVL(loc_oPgAba.getObrCla.Value, 1),    1))
            loc_cCfg = STUFF(loc_cCfg, 7,  1, STR(NVL(loc_oPgAba.getObrSeg.Value, 1),    1))
            loc_cCfg = STUFF(loc_cCfg, 8,  1, STR(NVL(loc_oPgAba.optCpffixo.Value, 1),   1))
            loc_cCfg = STUFF(loc_cCfg, 9,  3, PADR(ALLTRIM(NVL(loc_oPgAba.getSituas.Value, "")), 3))
            loc_cCfg = STUFF(loc_cCfg, 12, 1, STR(NVL(loc_oPgAba.optCarac.Value, 1),     1))
            loc_cCfg = STUFF(loc_cCfg, 13, 1, STR(NVL(loc_oPgAba.optAceJob.Value, 1),    1))
            loc_cCfg = STUFF(loc_cCfg, 14, 1, STR(NVL(loc_oPgAba.getObrIbge.Value, 1),   1))
            loc_oBO.this_cCfgcdgcr = loc_cCfg

            *-- Outros campos aba Cadastro
            loc_oBO.this_nCpfobrigs   = NVL(loc_oPgAba.Opt_CPFObrig.Value, 1)
            loc_oBO.this_nCalcimeds   = NVL(loc_oPgAba.optCalcIMeds.Value, 1)
            loc_oBO.this_nChkendds    = NVL(loc_oPgAba.Fwoption4.Value, 1)
            loc_oBO.this_nChkendrs    = NVL(loc_oPgAba.Fwoption5.Value, 1)
            loc_oBO.this_nMfotos      = NVL(loc_oPgAba.Opt_MFotos.Value, 1)
            loc_oBO.this_nObservas    = NVL(loc_oPgAba.fwoption1.Value, 1)
            loc_oBO.this_nEndobr      = NVL(loc_oPgAba.Fwoption14.Value, 1)
            loc_oBO.this_nNumobr      = NVL(loc_oPgAba.Fwoption8.Value, 1)
            loc_oBO.this_nBairroobr   = NVL(loc_oPgAba.Fwoption9.Value, 1)
            loc_oBO.this_nCidasobr    = NVL(loc_oPgAba.Fwoption11.Value, 1)
            loc_oBO.this_nPaisesobr   = NVL(loc_oPgAba.Fwoption10.Value, 1)
            loc_oBO.this_nCepobris    = NVL(loc_oPgAba.Opt_CEPObrig.Value, 1)
            loc_oBO.this_nTel1obr     = NVL(loc_oPgAba.Fwoption12.Value, 1)
            loc_oBO.this_nTel2obr     = NVL(loc_oPgAba.Fwoption13.Value, 1)
            loc_oBO.this_nNascobr     = NVL(loc_oPgAba.Fwoption6.Value, 1)
            loc_oBO.this_nSexobr      = NVL(loc_oPgAba.Fwoption7.Value, 1)
            loc_oBO.this_nDefhideshow = NVL(loc_oPgAba.OptAlertaCad.Value, 1)
            loc_oBO.this_cContconts   = ALLTRIM(NVL(loc_oPgAba.Getcontint.Value, ""))
            loc_oBO.this_nIntconts    = NVL(loc_oPgAba.Opt_Integ.Value, 1)
            loc_oBO.this_nPadpgrecs   = NVL(loc_oPgAba.Fwoption3.Value, 1)
            loc_oBO.this_nCtvinculas  = NVL(loc_oPgAba.optVincPgRcs.Value, 1)
            loc_oBO.this_nTitbaixado  = NVL(loc_oPgAba.OptTitBaixado.Value, 1)

            *-- Aba Estoque
            loc_oPgAba = loc_oPg2.pgf_4c_1.Page3
            loc_oBO.this_nLimestoqs  = NVL(loc_oPgAba.Opt_LimEsto.Value, 1)
            loc_oBO.this_nVerests    = NVL(loc_oPgAba.Opt_VerEst.Value, 1)
            loc_oBO.this_nEstoques   = NVL(loc_oPgAba.Opt_EstPAcab.Value, 1)
            loc_oBO.this_nChklimests = NVL(loc_oPgAba.opt_ChkLimest.Value, 1)
            loc_oBO.this_nCcustos    = NVL(loc_oPgAba.Opt_CCusto.Value, 1)
            loc_oBO.this_nGerbals    = NVL(loc_oPgAba.Opt_GBals.Value, 1)
            loc_oBO.this_nUnifbals   = NVL(loc_oPgAba.Opt_UnifBal.Value, 1)
            loc_oBO.this_nBalfalpers = NVL(loc_oPgAba.Opt_FalPers.Value, 1)
            loc_oBO.this_nBlqdivops  = NVL(loc_oPgAba.Opt_BlqDivOp.Value, 1)
            loc_oBO.this_nCalcsalds  = NVL(loc_oPgAba.Opt_Saldo.Value, 1)
            loc_oBO.this_nEmprelevs  = NVL(loc_oPgAba.Opt_Relevante.Value, 1)
            loc_oBO.this_nBlqcongvs  = NVL(loc_oPgAba.Opt_BlqConGV.Value, 1)
            loc_oBO.this_nPatrietqs  = NVL(loc_oPgAba.Opt_Patrim.Value, 1)
            loc_oBO.this_nTipoinvs   = NVL(loc_oPgAba.OpTipoInvs.Value, 1)
            loc_oBO.this_nTrfpesas   = NVL(loc_oPgAba.Chk_TrfPeso.Value, 1)
            loc_oBO.this_nCompagrus  = NVL(loc_oPgAba.op_compagru.Value, 1)
            loc_oBO.this_nCtrlotes   = NVL(loc_oPgAba.Fwoption1.Value, 1)
            loc_oBO.this_nOspends    = NVL(loc_oPgAba.Get_OsPend.Value, 1)
            loc_oBO.this_nChktits    = NVL(loc_oPgAba.ObjDupTit.Value, 1)
            loc_oBO.this_cGrufals    = ALLTRIM(NVL(loc_oPgAba.Get_grupo.Value, ""))
            loc_oBO.this_nDifpesags  = NVL(loc_oPgAba.Get_DifPeso.Value, 0)
            loc_oBO.this_nSinals     = NVL(loc_oPgAba.Get_Sinal.Value, 1)
            loc_oBO.this_cPqs        = ALLTRIM(NVL(loc_oPgAba.Get_tfalhas.Value, ""))
            loc_oBO.this_cAgrupas    = ALLTRIM(NVL(loc_oPgAba.Get_Agrupa.Value, ""))
            loc_oBO.this_nDdretros   = NVL(loc_oPgAba.get_ddr.Value, 0)
            loc_oBO.this_nDdfutus    = NVL(loc_oPgAba.get_ddf.Value, 0)
            loc_oBO.this_nInvisivel  = NVL(loc_oPgAba.op_invisivel.Value, 0)
            loc_oBO.this_cOsalfuns   = IIF(loc_oPgAba.cnt_4c_OsAlfun.chk_Os.Value = 1, "1", "0") + ;
                                       IIF(loc_oPgAba.cnt_4c_OsAlfun.chk_Alianca.Value = 1, "1", "0") + ;
                                       IIF(loc_oPgAba.cnt_4c_OsAlfun.chk_Fundicao.Value = 1, "1", "0")

            *-- Aba Faturamento: empacotar cfgfisXXX
            loc_oPgAba = loc_oPg2.pgf_4c_1.Page4

            DIMENSION loc_aCnt(9)
            loc_aCnt(1) = "cntIC"
            loc_aCnt(2) = "cntIP"
            loc_aCnt(3) = "cntII"
            loc_aCnt(4) = "cntIS"
            loc_aCnt(5) = "cntIR"
            loc_aCnt(6) = "cntIN"
            loc_aCnt(7) = "cntPI"
            loc_aCnt(8) = "cntCS"
            loc_aCnt(9) = "cntCO"

            LOCAL loc_aPropNm(9)
            loc_aPropNm(1) = "this_cCfgfisics"
            loc_aPropNm(2) = "this_cCfgfisips"
            loc_aPropNm(3) = "this_cCfgfisiis"
            loc_aPropNm(4) = "this_cCfgfisiss"
            loc_aPropNm(5) = "this_cCfgfisirs"
            loc_aPropNm(6) = "this_cCfgfisins"
            loc_aPropNm(7) = "this_cCfgfispis"
            loc_aPropNm(8) = "this_cCfgfiscss"
            loc_aPropNm(9) = "this_cCfgfiscos"

            FOR loc_nI = 1 TO 9
                IF PEMSTATUS(loc_oPgAba, loc_aCnt(loc_nI), 5)
                    loc_oCnt    = loc_oPgAba.Controls(THIS.ObterIndiceControle(loc_oPgAba, loc_aCnt(loc_nI)))
                    loc_cFisStr = PADR(ALLTRIM(NVL(loc_oCnt.getCdGrupos.Value, "")), 10) + ;
                                  PADR(ALLTRIM(NVL(loc_oCnt.getCdContas.Value, "")), 10) + ;
                                  PADR(STR(NVL(loc_oCnt.getPctAliqs.Value, 0), 5, 2), 5) + ;
                                  PADR(ALLTRIM(NVL(loc_oCnt.getReceitas.Value, "")), 10) + ;
                                  SPACE(15)
                    loc_oBO.(loc_aPropNm(loc_nI)) = loc_cFisStr
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        THIS.BtnSalvarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Valida, transfere Form->BO e persiste via BO.Salvar()
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso, loc_oPg2
        loc_lSucesso = .F.
        loc_oPg2     = THIS.pgf_4c_Paginas.Page2

        IF EMPTY(ALLTRIM(NVL(loc_oPg2.txt_4c_Codigo.Value, "")))
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o informado.", "Salvar")
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(NVL(loc_oPg2.txt_4c_Descr.Value, "")))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada.", "Salvar")
            RETURN
        ENDIF

        TRY
            THIS.FormParaBO()
            loc_lSucesso = THIS.this_oBusinessObject.Salvar()

            IF loc_lSucesso
                MsgInfo("Registro salvo com sucesso!", "Salvar")
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparDados()
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigos
        loc_cCodigos = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigos = ALLTRIM(NVL(cursor_4c_Dados.codigos, ""))
        ENDIF

        IF EMPTY(loc_cCodigos)
            MsgAviso("Selecione um registro na lista.", "Visualizar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigos)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigos
        loc_cCodigos = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigos = ALLTRIM(NVL(cursor_4c_Dados.codigos, ""))
        ENDIF

        IF EMPTY(loc_cCodigos)
            MsgAviso("Selecione um registro na lista.", "Alterar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigos)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigos, loc_lConfirma
        loc_cCodigos  = ""
        loc_lConfirma = .F.

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigos = ALLTRIM(NVL(cursor_4c_Dados.codigos, ""))
        ENDIF

        IF EMPTY(loc_cCodigos)
            MsgAviso("Selecione um registro na lista.", "Excluir")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Deseja excluir o grupo de contas correntes selecionado?", "Excluir")
        IF !loc_lConfirma
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigos)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cFiltro
        loc_cFiltro = INPUTBOX("Informe c" + CHR(243) + "digo ou descri" + CHR(231) + CHR(227) + ;
            "o (vazio = todos):", "Buscar")

        IF VARTYPE(loc_cFiltro) = "C"
            IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                THIS.AtualizarGrid()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ClassesKeyPress - Abre picker de Classe (SigCdCss) ao pressionar F4
    *--------------------------------------------------------------------------
    PROCEDURE ClassesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaClasses()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ClassesDblClick
    *--------------------------------------------------------------------------
    PROCEDURE ClassesDblClick()
        THIS.AbrirBuscaClasses()
    ENDPROC

    *--------------------------------------------------------------------------
    * ClassesLostFocus - Valida classe ao sair do campo
    *--------------------------------------------------------------------------
    PROCEDURE ClassesLostFocus()
        LOCAL loc_oPg2, loc_cCls
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cCls = ALLTRIM(NVL(loc_oPg2.txt_4c_Classes.Value, ""))

        IF EMPTY(loc_cCls)
            loc_oPg2.txt_4c_DClasses.Value = ""
            RETURN
        ENDIF

        TRY
            IF SQLEXEC(gnConnHandle, "SELECT Descrs FROM SigCdCss WHERE RTRIM(Classes)=" + ;
                EscaparSQL(loc_cCls), "cursor_4c_Css") >= 0
                IF USED("cursor_4c_Css") AND RECCOUNT("cursor_4c_Css") > 0
                    SELECT cursor_4c_Css
                    loc_oPg2.txt_4c_DClasses.Value = ALLTRIM(NVL(Descrs, ""))
                ELSE
                    THIS.AbrirBuscaClasses()
                ENDIF
                IF USED("cursor_4c_Css")
                    USE IN cursor_4c_Css
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ClassesLostFocus")
            IF USED("cursor_4c_Css")
                USE IN cursor_4c_Css
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaClasses - FormBuscaAuxiliar para SigCdCss
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaClasses()
        LOCAL loc_oBusca, loc_oPg2
        loc_oBusca = .NULL.
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCss", "cursor_4c_BuscaClasse", "Classes", ;
                ALLTRIM(NVL(loc_oPg2.txt_4c_Classes.Value, "")), ;
                "Selecionar Classe")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro OR !loc_oBusca.this_lSelecionou
                    loc_oBusca.mAddColuna("Classes", "", "Classe")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClasse")
                    SELECT cursor_4c_BuscaClasse
                    loc_oPg2.txt_4c_Classes.Value  = ALLTRIM(NVL(Classes, ""))
                    loc_oPg2.txt_4c_DClasses.Value = ALLTRIM(NVL(Descrs, ""))
                ELSE
                    IF !loc_oBusca.this_lSelecionou
                        loc_oPg2.txt_4c_Classes.Value  = ""
                        loc_oPg2.txt_4c_DClasses.Value = ""
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaClasse")
                USE IN cursor_4c_BuscaClasse
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaClasses")
            IF USED("cursor_4c_BuscaClasse")
                USE IN cursor_4c_BuscaClasse
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MoedaComissaoKeyPress - Abre picker de Moeda Comissao ao F4
    *--------------------------------------------------------------------------
    PROCEDURE MoedaComissaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaMoedaComissao()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * MoedaComissaoDblClick
    *--------------------------------------------------------------------------
    PROCEDURE MoedaComissaoDblClick()
        THIS.AbrirBuscaMoedaComissao()
    ENDPROC

    *--------------------------------------------------------------------------
    * MoedaComissaoLostFocus - Valida moeda comissao ao sair
    *--------------------------------------------------------------------------
    PROCEDURE MoedaComissaoLostFocus()
        LOCAL loc_oPgAba, loc_cMoe
        loc_oPgAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1
        loc_cMoe   = ALLTRIM(NVL(loc_oPgAba.txt_4c__cd_moeda.Value, ""))

        IF EMPTY(loc_cMoe)
            loc_oPgAba.txt_4c__ds_moeda.Value = ""
            RETURN
        ENDIF

        TRY
            IF SQLEXEC(gnConnHandle, "SELECT Dmoes FROM SigCdMoe WHERE RTRIM(Cmoes)=" + ;
                EscaparSQL(loc_cMoe), "cursor_4c_MoeVal") >= 0
                IF USED("cursor_4c_MoeVal") AND RECCOUNT("cursor_4c_MoeVal") > 0
                    SELECT cursor_4c_MoeVal
                    loc_oPgAba.txt_4c__ds_moeda.Value = ALLTRIM(NVL(Dmoes, ""))
                ELSE
                    THIS.AbrirBuscaMoedaComissao()
                ENDIF
                IF USED("cursor_4c_MoeVal")
                    USE IN cursor_4c_MoeVal
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MoedaComissaoLostFocus")
            IF USED("cursor_4c_MoeVal")
                USE IN cursor_4c_MoeVal
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaMoedaComissao - FormBuscaAuxiliar para SigCdMoe (comissao)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaMoedaComissao()
        LOCAL loc_oBusca, loc_oPgAba
        loc_oBusca = .NULL.
        loc_oPgAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoeCom", "Cmoes", ;
                ALLTRIM(NVL(loc_oPgAba.txt_4c__cd_moeda.Value, "")), ;
                "Selecionar Moeda Comiss" + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro OR !loc_oBusca.this_lSelecionou
                    loc_oBusca.mAddColuna("Cmoes", "", "C" + CHR(243) + "d.")
                    loc_oBusca.mAddColuna("Dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeCom")
                    SELECT cursor_4c_BuscaMoeCom
                    loc_oPgAba.txt_4c__cd_moeda.Value = ALLTRIM(NVL(Cmoes, ""))
                    loc_oPgAba.txt_4c__ds_moeda.Value = ALLTRIM(NVL(Dmoes, ""))
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaMoeCom")
                USE IN cursor_4c_BuscaMoeCom
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaMoedaComissao")
            IF USED("cursor_4c_BuscaMoeCom")
                USE IN cursor_4c_BuscaMoeCom
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MoedaLimiteKeyPress - F4 para moeda limite de credito
    *--------------------------------------------------------------------------
    PROCEDURE MoedaLimiteKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaMoedaLimite()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * MoedaLimiteDblClick
    *--------------------------------------------------------------------------
    PROCEDURE MoedaLimiteDblClick()
        THIS.AbrirBuscaMoedaLimite()
    ENDPROC

    *--------------------------------------------------------------------------
    * MoedaLimiteLostFocus - Valida moeda limite ao sair
    *--------------------------------------------------------------------------
    PROCEDURE MoedaLimiteLostFocus()
        LOCAL loc_oPgAba, loc_cMoe
        loc_oPgAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1
        loc_cMoe   = ALLTRIM(NVL(loc_oPgAba.txt_4c__molimc.Value, ""))

        IF EMPTY(loc_cMoe)
            RETURN
        ENDIF

        TRY
            IF SQLEXEC(gnConnHandle, "SELECT Dmoes FROM SigCdMoe WHERE RTRIM(Cmoes)=" + ;
                EscaparSQL(loc_cMoe), "cursor_4c_MoeL") >= 0
                IF !USED("cursor_4c_MoeL") OR RECCOUNT("cursor_4c_MoeL") = 0
                    THIS.AbrirBuscaMoedaLimite()
                ENDIF
                IF USED("cursor_4c_MoeL")
                    USE IN cursor_4c_MoeL
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MoedaLimiteLostFocus")
            IF USED("cursor_4c_MoeL")
                USE IN cursor_4c_MoeL
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaMoedaLimite - FormBuscaAuxiliar para SigCdMoe (limite)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaMoedaLimite()
        LOCAL loc_oBusca, loc_oPgAba
        loc_oBusca = .NULL.
        loc_oPgAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoeLim", "Cmoes", ;
                ALLTRIM(NVL(loc_oPgAba.txt_4c__molimc.Value, "")), ;
                "Selecionar Moeda Limite")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro OR !loc_oBusca.this_lSelecionou
                    loc_oBusca.mAddColuna("Cmoes", "", "C" + CHR(243) + "d.")
                    loc_oBusca.mAddColuna("Dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeLim")
                    SELECT cursor_4c_BuscaMoeLim
                    loc_oPgAba.txt_4c__molimc.Value = ALLTRIM(NVL(Cmoes, ""))
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaMoeLim")
                USE IN cursor_4c_BuscaMoeLim
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaMoedaLimite")
            IF USED("cursor_4c_BuscaMoeLim")
                USE IN cursor_4c_BuscaMoeLim
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrupoContabKeyPress - F4 para grupo contabil padrao
    *--------------------------------------------------------------------------
    PROCEDURE GrupoContabKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrupoContab()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GrupoContabDblClick
    *--------------------------------------------------------------------------
    PROCEDURE GrupoContabDblClick()
        THIS.AbrirBuscaGrupoContab()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGrupoContab - FormBuscaAuxiliar para grupo contabil
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaGrupoContab()
        LOCAL loc_oBusca, loc_oPgAba
        loc_oBusca = .NULL.
        loc_oPgAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGrp", "codigos", ;
                ALLTRIM(NVL(loc_oPgAba.txt_4c_Grupo.Value, "")), ;
                "Selecionar Grupo Cont" + CHR(225) + "bil")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro OR !loc_oBusca.this_lSelecionou
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                    SELECT cursor_4c_BuscaGrp
                    loc_oPgAba.txt_4c_Grupo.Value = ALLTRIM(NVL(codigos, ""))
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGrp")
                USE IN cursor_4c_BuscaGrp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaGrupoContab")
            IF USED("cursor_4c_BuscaGrp")
                USE IN cursor_4c_BuscaGrp
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * SituacaoKeyPress - F4 abre picker de Situacao Padrao (SigCdCst)
    *--------------------------------------------------------------------------
    PROCEDURE SituacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaSituacao()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * SituacaoDblClick - DblClick abre picker de Situacao
    *--------------------------------------------------------------------------
    PROCEDURE SituacaoDblClick()
        THIS.AbrirBuscaSituacao()
    ENDPROC

    *--------------------------------------------------------------------------
    * SituacaoLostFocus - Valida Situacao ao sair do campo
    *--------------------------------------------------------------------------
    PROCEDURE SituacaoLostFocus()
        LOCAL loc_oPgAba, loc_cSit
        loc_oPgAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2
        loc_cSit   = ALLTRIM(NVL(loc_oPgAba.getSituas.Value, ""))

        IF EMPTY(loc_cSit)
            RETURN
        ENDIF

        TRY
            IF SQLEXEC(gnConnHandle, "SELECT codigos FROM SigCdCst WHERE RTRIM(codigos)=" + ;
                EscaparSQL(loc_cSit) + " AND autos <> 2", "cursor_4c_SitVal") >= 0
                IF !USED("cursor_4c_SitVal") OR RECCOUNT("cursor_4c_SitVal") = 0
                    THIS.AbrirBuscaSituacao()
                ENDIF
                IF USED("cursor_4c_SitVal")
                    USE IN cursor_4c_SitVal
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SituacaoLostFocus")
            IF USED("cursor_4c_SitVal")
                USE IN cursor_4c_SitVal
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaSituacao - FormBuscaAuxiliar para SigCdCst (Situacao Padrao)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaSituacao()
        LOCAL loc_oBusca, loc_oPgAba
        loc_oBusca = .NULL.
        loc_oPgAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCst", "cursor_4c_BuscaSit", "codigos", ;
                ALLTRIM(NVL(loc_oPgAba.getSituas.Value, "")), ;
                "Selecionar Situa" + CHR(231) + CHR(227) + "o", ;
                .F., .F., "autos <> 2")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro OR !loc_oBusca.this_lSelecionou
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "d.")
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSit")
                    SELECT cursor_4c_BuscaSit
                    loc_oPgAba.getSituas.Value = ALLTRIM(NVL(codigos, ""))
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaSit")
                USE IN cursor_4c_BuscaSit
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaSituacao")
            IF USED("cursor_4c_BuscaSit")
                USE IN cursor_4c_BuscaSit
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrupoEstoqueKeyPress - F4 abre picker de Grupo Diferenca Balanco (Estoque)
    *--------------------------------------------------------------------------
    PROCEDURE GrupoEstoqueKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrupoEstoque()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GrupoEstoqueDblClick - DblClick abre picker de grupo (Estoque)
    *--------------------------------------------------------------------------
    PROCEDURE GrupoEstoqueDblClick()
        THIS.AbrirBuscaGrupoEstoque()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGrupoEstoque - FormBuscaAuxiliar SigCdGcr para aba Estoque
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaGrupoEstoque()
        LOCAL loc_oBusca, loc_oPgAba
        loc_oBusca = .NULL.
        loc_oPgAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page3

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGrpEst", "codigos", ;
                ALLTRIM(NVL(loc_oPgAba.Get_grupo.Value, "")), ;
                "Selecionar Grupo")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro OR !loc_oBusca.this_lSelecionou
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrpEst")
                    SELECT cursor_4c_BuscaGrpEst
                    loc_oPgAba.Get_grupo.Value = ALLTRIM(NVL(codigos, ""))
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGrpEst")
                USE IN cursor_4c_BuscaGrpEst
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaGrupoEstoque")
            IF USED("cursor_4c_BuscaGrpEst")
                USE IN cursor_4c_BuscaGrpEst
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrupoFatKeyPress - F4 abre picker de Grupo no container fiscal ativo
    *--------------------------------------------------------------------------
    PROCEDURE GrupoFatKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrupoFat()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GrupoFatDblClick - DblClick abre picker de Grupo no container fiscal ativo
    *--------------------------------------------------------------------------
    PROCEDURE GrupoFatDblClick()
        THIS.AbrirBuscaGrupoFat()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrupoFatLostFocus - Ao sair de getCdGrupos: limpa dependentes se vazio
    * Nao pode usar THIS.ActiveControl.Parent (foco ja mudou); usa propriedade
    * armazenada por GrupoFatGotFocus
    *--------------------------------------------------------------------------
    PROCEDURE GrupoFatLostFocus()
        LOCAL loc_oCnt
        TRY
            IF VARTYPE(THIS.this_oUltimoCntFat) = "O" AND !ISNULL(THIS.this_oUltimoCntFat)
                loc_oCnt = THIS.this_oUltimoCntFat
                IF EMPTY(ALLTRIM(NVL(loc_oCnt.getCdGrupos.Value, "")))
                    loc_oCnt.getCdContas.Value = ""
                    loc_oCnt.getDsContas.Value = ""
                    loc_oCnt.getPctAliqs.Value = 0
                    loc_oCnt.getReceitas.Value = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "GrupoFatLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrupoFatGotFocus - Armazena container ativo ao entrar em getCdGrupos
    *--------------------------------------------------------------------------
    PROCEDURE GrupoFatGotFocus()
        IF VARTYPE(THIS.ActiveControl) = "O" AND ;
                VARTYPE(THIS.ActiveControl.Parent) = "O"
            THIS.this_oUltimoCntFat = THIS.ActiveControl.Parent
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGrupoFat - FormBuscaAuxiliar SigCdGcr para container fiscal
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaGrupoFat()
        LOCAL loc_oBusca, loc_oCnt
        loc_oBusca = .NULL.

        IF VARTYPE(THIS.ActiveControl) # "O" OR ;
                VARTYPE(THIS.ActiveControl.Parent) # "O"
            RETURN
        ENDIF
        loc_oCnt = THIS.ActiveControl.Parent

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGrpFat", "codigos", ;
                ALLTRIM(NVL(loc_oCnt.getCdGrupos.Value, "")), ;
                "Selecionar Grupo")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro OR !loc_oBusca.this_lSelecionou
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrpFat")
                    SELECT cursor_4c_BuscaGrpFat
                    loc_oCnt.getCdGrupos.Value = ALLTRIM(NVL(codigos, ""))
                    *-- Limpa conta ao trocar grupo
                    loc_oCnt.getCdContas.Value = ""
                    loc_oCnt.getDsContas.Value = ""
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGrpFat")
                USE IN cursor_4c_BuscaGrpFat
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaGrupoFat")
            IF USED("cursor_4c_BuscaGrpFat")
                USE IN cursor_4c_BuscaGrpFat
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaFatKeyPress - F4 abre picker de Conta no container fiscal ativo
    *--------------------------------------------------------------------------
    PROCEDURE ContaFatKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaContaFat()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaFatDblClick - DblClick abre picker de Conta no container fiscal ativo
    *--------------------------------------------------------------------------
    PROCEDURE ContaFatDblClick()
        THIS.AbrirBuscaContaFat()
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaFatLostFocus - Ao sair de getCdContas: limpa descricao se vazio
    *--------------------------------------------------------------------------
    PROCEDURE ContaFatLostFocus()
        LOCAL loc_oCnt
        TRY
            IF VARTYPE(THIS.this_oUltimoCntFat) = "O" AND !ISNULL(THIS.this_oUltimoCntFat)
                loc_oCnt = THIS.this_oUltimoCntFat
                IF EMPTY(ALLTRIM(NVL(loc_oCnt.getCdContas.Value, "")))
                    loc_oCnt.getDsContas.Value = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ContaFatLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaFatGotFocus - Armazena container ativo ao entrar em getCdContas
    *--------------------------------------------------------------------------
    PROCEDURE ContaFatGotFocus()
        IF VARTYPE(THIS.ActiveControl) = "O" AND ;
                VARTYPE(THIS.ActiveControl.Parent) = "O"
            THIS.this_oUltimoCntFat = THIS.ActiveControl.Parent
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaContaFat - FormBuscaAuxiliar SigCdCli para container fiscal
    * Filtra por grupo (getCdGrupos) se informado
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaContaFat()
        LOCAL loc_oBusca, loc_oCnt, loc_cGrupo, loc_cFiltro
        loc_oBusca = .NULL.

        IF VARTYPE(THIS.ActiveControl) # "O" OR ;
                VARTYPE(THIS.ActiveControl.Parent) # "O"
            RETURN
        ENDIF
        loc_oCnt   = THIS.ActiveControl.Parent
        loc_cGrupo = ALLTRIM(NVL(loc_oCnt.getCdGrupos.Value, ""))
        loc_cFiltro = IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaCntFat", "iclis", ;
                ALLTRIM(NVL(loc_oCnt.getCdContas.Value, "")), ;
                "Selecionar Conta", .F., .F., loc_cFiltro)

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro OR !loc_oBusca.this_lSelecionou
                    loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("rclis",  "", "Nome/Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCntFat")
                    SELECT cursor_4c_BuscaCntFat
                    loc_oCnt.getCdContas.Value = ALLTRIM(NVL(iclis, ""))
                    loc_oCnt.getDsContas.Value = ALLTRIM(NVL(rclis, ""))
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaCntFat")
                USE IN cursor_4c_BuscaCntFat
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaContaFat")
            IF USED("cursor_4c_BuscaCntFat")
                USE IN cursor_4c_BuscaCntFat
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Recursivo, torna tudo visivel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos; chama FormBase.Destroy como ultima linha
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            THIS.this_oUltimoCntFat = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formccr.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\ccrBO.prg):
*==============================================================================
* ccrBO.prg - Business Object para Grupos de Contas Correntes (SigCdGcr)
* Herda de BusinessBase
* Tabela: SigCdGcr  |  PK: codigos
*==============================================================================

DEFINE CLASS ccrBO AS BusinessBase

    *--------------------------------------------------------------------------
    * IDENTIFICACAO - PK e Descricao
    *--------------------------------------------------------------------------
    this_cCodigos         = ""   && codigos char(10) PK
    this_cDescrs          = ""   && descrs char(40)
    this_cDgcods          = ""   && dgcods char(1) - digito
    this_cInternos        = ""   && internos char(20) - codigo interno
    this_cClasses         = ""   && classes char(10) - FK SigCdCss
    this_cDClasses        = ""   && DClasses virtual (JOIN SigCdCss.Descrs)

    *--------------------------------------------------------------------------
    * TIPO/MODO
    *--------------------------------------------------------------------------
    this_nTpcods          = 0    && tpcods numeric(1,0) - tipo codificacao
    this_nTpemps          = 0    && tpemps numeric(1,0) - tipo empresa
    this_nTpcads          = 0    && tpcads numeric(1,0) - tipo cadastro

    *--------------------------------------------------------------------------
    * ABA GERAL - Opcoes de obrigatoriedade cadastral
    *--------------------------------------------------------------------------
    this_nComplems        = 0    && complems numeric(1,0) - Complemento
    this_nPessoais        = 0    && pessoais numeric(1,0) - Dados Pessoais
    this_nRefbancs        = 0    && refbancs numeric(1,0) - Ref. Bancarias
    this_nFollowups       = 0    && followups numeric(1,0) - Follow-Up
    this_nFiscais         = 0    && fiscais numeric(1,0) - Dados Fiscais
    this_nContabs         = 0    && contabs numeric(1,0) - Dados Contabeis
    this_nEmpresas        = 0    && empresas numeric(1,0) - Dados da Empresa
    this_nCaracteris      = 0    && caracteris numeric(1,0) - Caracteristicas
    this_nRespos          = 0    && respos numeric(1,0) - Possui Responsavel
    this_nLimcres         = 0    && limcres numeric(1,0) - Limite de Credito
    this_nComis           = 0    && comis numeric(1,0) - Comissao
    this_nDadcoms         = 0    && dadcoms numeric(1,0) - Dados Comerciais
    this_nCargos          = 0    && cargos numeric(1,0) - Cargos
    this_nChklimcrds      = 0    && chklimcrds numeric(1,0) - Checa Limite Credito
    this_nColetors        = 0    && coletors numeric(2,0) - Coletor (11 opcoes)
    this_nPrecad          = 0    && precad numeric(1,0) - Pre-Cadastro (LEAD)

    *--------------------------------------------------------------------------
    * ABA GERAL - Grupo padrao contabil / Limite de credito / Moeda
    *--------------------------------------------------------------------------
    this_cGrupolms        = ""   && grupolms char(10) - Grupo Padrao Contabil
    this_nVrlimcre        = 0    && vrlimcre numeric(11,2) - Valor Limite Credito
    this_cMolimcre        = ""   && molimcre char(3) - Moeda Limite Credito
    this_cCommoedas       = ""   && commoedas char(3) - Moeda Comissao
    this_cRodrelcc        = ""   && rodrelcc text - Rodape Relatorio Conta Corrente

    *--------------------------------------------------------------------------
    * ABA CADASTRO - Obrigatoriedades de preenchimento
    *--------------------------------------------------------------------------
    this_cCfgcdgcr        = ""   && cfgcdgcr char(40) - Config flags empacotados

    *-- Posicoes do CfgCdGcr (armazenados em cfgcdgcr):
    *-- Pos 1: ObrMails, Pos 2: ObrNome, Pos 3: VincPgRcs, Pos 4: ObrSit
    *-- Pos 5: Cpffixo, Pos 6: Carac, Pos 7: AceJob

    this_cDescsit         = ""   && descsit char(16) - Situacao Padrao
    this_nCpfobrigs       = 0    && cpfobrigs numeric(1,0) - CPF/CNPJ Obrigatorio
    this_nRgobrigs        = 0    && rgobrigs numeric(1,0) - RG/IE Obrigatorio
    this_nMfotos          = 0    && mfotos numeric(1,0) - Mostrar Foto
    this_nObservas        = 0    && observas numeric(1,0) - Observacao
    this_nInfcads         = 0    && infcads numeric(1,0) - Info Cadastrais
    this_nCalcimeds       = 0    && calcimeds numeric(1,0) - Calc. Imediato
    this_cDesccalcimeds   = ""   && desccalcimeds char(16) - Desc Calc Imediato
    this_nFpublsobr       = 0    && fpublsobr numeric(1,0) - Func.Publico Obrig.
    this_cDescfpubls      = ""   && descfpubls char(16) - Desc Func.Publico
    this_nInfsenha        = 0    && infsenha numeric(1,0) - Info Senha
    this_nLogalt          = 0    && logalt numeric(1,0) - Log Alteracao

    *-- Endereco
    this_nEndobr          = 0    && endobr numeric(1,0) - Endereco Obrigatorio
    this_nNumobr          = 0    && numobr numeric(1,0) - Numero Obrigatorio
    this_nBairroobr       = 0    && bairroobr numeric(1,0) - Bairro Obrigatorio
    this_nCidasobr        = 0    && cidasobr numeric(1,0) - Cidade Obrigatoria
    this_nCepobris        = 0    && cepobris numeric(1,0) - CEP Obrigatorio
    this_nPaisesobr       = 0    && paisesobr numeric(1,0) - Pais Obrigatorio
    this_nChkendds        = 0    && chkendds numeric(1,0) - Checa Duplic. Endereco
    this_nChkendrs        = 0    && chkendrs numeric(1,0) - Checa Restric. Endereco

    *-- Telefone e outros dados pessoais
    this_nTel1obr         = 0    && tel1obr numeric(1,0) - Telefone 1 Obrigatorio
    this_nTel2obr         = 0    && tel2obr numeric(1,0) - Telefone 2 Obrigatorio
    this_nNascobr         = 0    && nascobr numeric(1,0) - Nascimento Obrigatorio
    this_nSexobr          = 0    && sexobr numeric(1,0) - Sexo Obrigatorio
    this_nDtnascobr       = 0    && dtnascobr numeric(1,0) - Data Nasc. Obrigatoria
    this_nDtespobr        = 0    && dtespobr numeric(1,0) - Data Espera Obrigatoria
    this_nObrtelefone     = 0    && Obrtelefone numeric(1,0) - Telefone Obrigatorio
    this_cDesctlm         = ""   && desctlm char(16) - Desc Telemarketing
    this_cDesccla         = ""   && desccla char(16) - Desc Classificacao
    this_cDescseg         = ""   && descseg char(16) - Desc Segmento

    *-- Financeiro no Cadastro
    this_cContconts       = ""   && contconts char(9) - Conta Interna
    this_nIntconts        = 0    && intconts numeric(1,0) - Integracao Contabil
    this_nPadpgrecs       = 0    && padpgrecs numeric(1,0) - Padrao Preenchimento
    this_nCtvinculas      = 0    && ctvinculas numeric(1,0) - Vincula Contas PG/RC
    this_nTitbaixado      = 0    && titbaixado numeric(1,0) - Visualiza Tit.nao Baixados
    this_cContapdr        = ""   && contapdr char(10) - Conta Padrao
    this_nCcustotit       = 0    && ccustotit numeric(1,0) - C.Custo por Titulo

    *-- Alerta Cadastro
    this_nDefhideshow     = 0    && defhideshow numeric(1,0) - Emitir Mensagem Alerta
    this_nCtainatv        = 0    && ctainatv numeric(1,0) - Conta Inativa

    *--------------------------------------------------------------------------
    * ABA ESTOQUE
    *--------------------------------------------------------------------------
    this_nEstoques        = 0    && estoques numeric(1,0) - Avalia Estoque
    this_nLimestoqs       = 0    && limestoqs numeric(1,0) - Limite de Estoque
    this_nVerests         = 0    && verests numeric(1,0) - Verifica Estoque
    this_nEmprelevs       = 0    && emprelevs numeric(1,0) - Empresa Relevante
    this_nBlqcongvs       = 0    && blqcongvs numeric(1,0) - Bloqueia Consulta GV
    this_nCalcsalds       = 0    && calcsalds numeric(1,0) - Calculo de Saldo
    this_nChklimests      = 0    && chklimests numeric(1,0) - Checa Limite Estoque
    this_nPatrietqs       = 0    && patrietqs numeric(1,0) - Patrimonial por Etiqueta
    this_nCcustos         = 0    && ccustos numeric(1,0) - Centro de Custos
    this_nGerbals         = 0    && gerbals numeric(1,0) - Gerar Balanco
    this_nUnifbals        = 0    && unifbals numeric(1,0) - Balanco Unificado
    this_nBalfalpers      = 0    && balfalpers numeric(1,0) - Balanco Falhas/Perdas
    this_nBlqdivops       = 0    && blqdivops numeric(1,0) - Bloqueia Divisao OF
    this_nInvisivel       = 0    && invisivel numeric(1,0) - Grupo nao Selecionavel
    this_nDdfutus         = 0    && ddfutus numeric(5,0) - Dias Bloqueio Futuro
    this_nDdretros        = 0    && ddretros numeric(5,0) - Dias Bloqueio Retroativo
    this_nDdsems          = 0    && ddsems numeric(1,0) - Dias em Semanas
    this_nHordd           = 0    && hordd numeric(4,2) - Hora DD
    this_nTipoinvs        = 0    && tipoinvs numeric(1,0) - Tipo Inventario

    *-- Industria / Fabrica
    this_nTrfpesas        = 0    && trfpesas numeric(1,0) - Transfere Peso
    this_nDifpesags       = 0    && difpesags numeric(9,3) - Diferenca de Peso
    this_nSinals          = 0    && sinals numeric(1,0) - Sinal (+/-)
    this_cPqs             = ""   && pqs char(1) - P ou Q (tipo falha)
    this_nCompagrus       = 0    && compagrus numeric(1,0) - Agrupa Componentes
    this_cAgrupas         = ""   && agrupas char(10) - Agrupamento
    this_nFichatecs       = 0    && fichatecs numeric(1,0) - Ficha Tecnica
    this_cOsalfuns        = ""   && osalfuns char(3) - Os/Alianca/Fundicao flags
    this_cGrufals         = ""   && grufals char(10) - Grupo Falha/Diferenca Balanco
    this_nOspends         = 0    && ospends numeric(1,0) - OS Pendente Dt.Entrega
    this_nChktits         = 0    && chktits numeric(1,0) - Checa Duplicidade Titulo
    this_nTpprecos        = 0    && tpprecos numeric(1,0) - Tipo de Preco
    this_cContafalha      = ""   && contafalha char(10) - Conta Falha
    this_cGrupofalha      = ""   && grupofalha char(10) - Grupo Falha
    this_nCtrlotes        = 0    && ctrlotes numeric(1,0) - Controle de Lote

    *--------------------------------------------------------------------------
    * ABA FATURAMENTO - Configuracoes fiscais por imposto
    * Formato empacotado: grupo(10)+conta(10)+descricao(40)+aliq(9.4)+receita(8)
    *--------------------------------------------------------------------------
    this_cCfgfisics       = ""   && cfgfisics char(50) - ICMS
    this_cCfgfisips       = ""   && cfgfisips char(50) - IPI
    this_cCfgfisiis       = ""   && cfgfisiis char(50) - II
    this_cCfgfisiss       = ""   && cfgfisiss char(50) - ISS
    this_cCfgfisirs       = ""   && cfgfisirs char(50) - IRRF
    this_cCfgfisins       = ""   && cfgfisins char(50) - INSS
    this_cCfgfispis       = ""   && cfgfispis char(50) - PIS
    this_cCfgfiscss       = ""   && cfgfiscss char(50) - CSSL
    this_cCfgfiscos       = ""   && cfgfiscos char(50) - COFINS

    *==========================================================================
    * INIT
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela      = "SigCdGcr"
        THIS.this_cCampoChave  = "codigos"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDPROC

    *==========================================================================
    * Buscar - Carrega lista de grupos de contas correntes no cursor_4c_Dados
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT a.codigos, a.descrs, a.classes, ISNULL(b.Descrs,'') AS DClasses" + ;
                           " FROM SigCdGcr a" + ;
                           " LEFT JOIN SigCdCss b ON a.Classes = b.Classes" + ;
                           " ORDER BY a.codigos"
            ELSE
                loc_cSQL = "SELECT a.codigos, a.descrs, a.classes, ISNULL(b.Descrs,'') AS DClasses" + ;
                           " FROM SigCdGcr a" + ;
                           " LEFT JOIN SigCdCss b ON a.Classes = b.Classes" + ;
                           " WHERE RTRIM(a.codigos) LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                           " OR RTRIM(a.descrs) LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                           " ORDER BY a.codigos"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar grupos de contas correntes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupos de contas correntes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega um registro pelo codigo (PK)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.*, ISNULL(b.Descrs,'') AS DClasses" + ;
                       " FROM SigCdGcr a" + ;
                       " LEFT JOIN SigCdCss b ON a.Classes = b.Classes" + ;
                       " WHERE RTRIM(a.codigos) = " + EscaparSQL(ALLTRIM(par_cCodigos))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar grupo de contas correntes:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos         = TratarNulo(codigos, "C")
            THIS.this_cDescrs          = TratarNulo(descrs, "C")
            THIS.this_cDgcods          = TratarNulo(dgcods, "C")
            THIS.this_cInternos        = TratarNulo(internos, "C")
            THIS.this_cClasses         = TratarNulo(classes, "C")
            THIS.this_cDClasses        = TratarNulo(DClasses, "C")
            THIS.this_nTpcods          = TratarNulo(tpcods, "N")
            THIS.this_nTpemps          = TratarNulo(tpemps, "N")
            THIS.this_nTpcads          = TratarNulo(tpcads, "N")
            THIS.this_nComplems        = TratarNulo(complems, "N")
            THIS.this_nPessoais        = TratarNulo(pessoais, "N")
            THIS.this_nRefbancs        = TratarNulo(refbancs, "N")
            THIS.this_nFollowups       = TratarNulo(followups, "N")
            THIS.this_nFiscais         = TratarNulo(fiscais, "N")
            THIS.this_nContabs         = TratarNulo(contabs, "N")
            THIS.this_nEmpresas        = TratarNulo(empresas, "N")
            THIS.this_nCaracteris      = TratarNulo(caracteris, "N")
            THIS.this_nRespos          = TratarNulo(respos, "N")
            THIS.this_nLimcres         = TratarNulo(limcres, "N")
            THIS.this_nComis           = TratarNulo(comis, "N")
            THIS.this_nDadcoms         = TratarNulo(dadcoms, "N")
            THIS.this_nCargos          = TratarNulo(cargos, "N")
            THIS.this_nChklimcrds      = TratarNulo(chklimcrds, "N")
            THIS.this_nColetors        = TratarNulo(coletors, "N")
            THIS.this_nPrecad          = TratarNulo(precad, "N")
            THIS.this_cGrupolms        = TratarNulo(grupolms, "C")
            THIS.this_nVrlimcre        = TratarNulo(vrlimcre, "N")
            THIS.this_cMolimcre        = TratarNulo(molimcre, "C")
            THIS.this_cCommoedas       = TratarNulo(commoedas, "C")
            THIS.this_cRodrelcc        = TratarNulo(rodrelcc, "C")
            THIS.this_cCfgcdgcr        = TratarNulo(cfgcdgcr, "C")
            THIS.this_cDescsit         = TratarNulo(descsit, "C")
            THIS.this_nCpfobrigs       = TratarNulo(cpfobrigs, "N")
            THIS.this_nRgobrigs        = TratarNulo(rgobrigs, "N")
            THIS.this_nMfotos          = TratarNulo(mfotos, "N")
            THIS.this_nObservas        = TratarNulo(observas, "N")
            THIS.this_nInfcads         = TratarNulo(infcads, "N")
            THIS.this_nCalcimeds       = TratarNulo(calcimeds, "N")
            THIS.this_cDesccalcimeds   = TratarNulo(desccalcimeds, "C")
            THIS.this_nFpublsobr       = TratarNulo(fpublsobr, "N")
            THIS.this_cDescfpubls      = TratarNulo(descfpubls, "C")
            THIS.this_nInfsenha        = TratarNulo(infsenha, "N")
            THIS.this_nLogalt          = TratarNulo(logalt, "N")
            THIS.this_nEndobr          = TratarNulo(endobr, "N")
            THIS.this_nNumobr          = TratarNulo(numobr, "N")
            THIS.this_nBairroobr       = TratarNulo(bairroobr, "N")
            THIS.this_nCidasobr        = TratarNulo(cidasobr, "N")
            THIS.this_nCepobris        = TratarNulo(cepobris, "N")
            THIS.this_nPaisesobr       = TratarNulo(paisesobr, "N")
            THIS.this_nChkendds        = TratarNulo(chkendds, "N")
            THIS.this_nChkendrs        = TratarNulo(chkendrs, "N")
            THIS.this_nTel1obr         = TratarNulo(tel1obr, "N")
            THIS.this_nTel2obr         = TratarNulo(tel2obr, "N")
            THIS.this_nNascobr         = TratarNulo(nascobr, "N")
            THIS.this_nSexobr          = TratarNulo(sexobr, "N")
            THIS.this_nDtnascobr       = TratarNulo(dtnascobr, "N")
            THIS.this_nDtespobr        = TratarNulo(dtespobr, "N")
            THIS.this_nObrtelefone     = TratarNulo(Obrtelefone, "N")
            THIS.this_cDesctlm         = TratarNulo(desctlm, "C")
            THIS.this_cDesccla         = TratarNulo(desccla, "C")
            THIS.this_cDescseg         = TratarNulo(descseg, "C")
            THIS.this_cContconts       = TratarNulo(contconts, "C")
            THIS.this_nIntconts        = TratarNulo(intconts, "N")
            THIS.this_nPadpgrecs       = TratarNulo(padpgrecs, "N")
            THIS.this_nCtvinculas      = TratarNulo(ctvinculas, "N")
            THIS.this_nTitbaixado      = TratarNulo(titbaixado, "N")
            THIS.this_cContapdr        = TratarNulo(contapdr, "C")
            THIS.this_nCcustotit       = TratarNulo(ccustotit, "N")
            THIS.this_nDefhideshow     = TratarNulo(defhideshow, "N")
            THIS.this_nCtainatv        = TratarNulo(ctainatv, "N")
            THIS.this_nEstoques        = TratarNulo(estoques, "N")
            THIS.this_nLimestoqs       = TratarNulo(limestoqs, "N")
            THIS.this_nVerests         = TratarNulo(verests, "N")
            THIS.this_nEmprelevs       = TratarNulo(emprelevs, "N")
            THIS.this_nBlqcongvs       = TratarNulo(blqcongvs, "N")
            THIS.this_nCalcsalds       = TratarNulo(calcsalds, "N")
            THIS.this_nChklimests      = TratarNulo(chklimests, "N")
            THIS.this_nPatrietqs       = TratarNulo(patrietqs, "N")
            THIS.this_nCcustos         = TratarNulo(ccustos, "N")
            THIS.this_nGerbals         = TratarNulo(gerbals, "N")
            THIS.this_nUnifbals        = TratarNulo(unifbals, "N")
            THIS.this_nBalfalpers      = TratarNulo(balfalpers, "N")
            THIS.this_nBlqdivops       = TratarNulo(blqdivops, "N")
            THIS.this_nInvisivel       = TratarNulo(invisivel, "N")
            THIS.this_nDdfutus         = TratarNulo(ddfutus, "N")
            THIS.this_nDdretros        = TratarNulo(ddretros, "N")
            THIS.this_nDdsems          = TratarNulo(ddsems, "N")
            THIS.this_nHordd           = TratarNulo(hordd, "N")
            THIS.this_nTipoinvs        = TratarNulo(tipoinvs, "N")
            THIS.this_nTrfpesas        = TratarNulo(trfpesas, "N")
            THIS.this_nDifpesags       = TratarNulo(difpesags, "N")
            THIS.this_nSinals          = TratarNulo(sinals, "N")
            THIS.this_cPqs             = TratarNulo(pqs, "C")
            THIS.this_nCompagrus       = TratarNulo(compagrus, "N")
            THIS.this_cAgrupas         = TratarNulo(agrupas, "C")
            THIS.this_nFichatecs       = TratarNulo(fichatecs, "N")
            THIS.this_cOsalfuns        = TratarNulo(osalfuns, "C")
            THIS.this_cGrufals         = TratarNulo(grufals, "C")
            THIS.this_nOspends         = TratarNulo(ospends, "N")
            THIS.this_nChktits         = TratarNulo(chktits, "N")
            THIS.this_nTpprecos        = TratarNulo(tpprecos, "N")
            THIS.this_cContafalha      = TratarNulo(contafalha, "C")
            THIS.this_cGrupofalha      = TratarNulo(grupofalha, "C")
            THIS.this_nCtrlotes        = TratarNulo(ctrlotes, "N")
            THIS.this_cCfgfisics       = TratarNulo(cfgfisics, "C")
            THIS.this_cCfgfisips       = TratarNulo(cfgfisips, "C")
            THIS.this_cCfgfisiis       = TratarNulo(cfgfisiis, "C")
            THIS.this_cCfgfisiss       = TratarNulo(cfgfisiss, "C")
            THIS.this_cCfgfisirs       = TratarNulo(cfgfisirs, "C")
            THIS.this_cCfgfisins       = TratarNulo(cfgfisins, "C")
            THIS.this_cCfgfispis       = TratarNulo(cfgfispis, "C")
            THIS.this_cCfgfiscss       = TratarNulo(cfgfiscss, "C")
            THIS.this_cCfgfiscos       = TratarNulo(cfgfiscos, "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - INSERT na tabela SigCdGcr
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdGcr (" + ;
                       "codigos,descrs,dgcods,internos,classes," + ;
                       "tpcods,tpemps,tpcads,complems,pessoais," + ;
                       "refbancs,followups,fiscais,contabs,empresas," + ;
                       "caracteris,respos,limcres,comis,dadcoms," + ;
                       "cargos,chklimcrds,coletors,precad,grupolms," + ;
                       "vrlimcre,molimcre,commoedas,rodrelcc,cfgcdgcr," + ;
                       "descsit,cpfobrigs,rgobrigs,mfotos,observas," + ;
                       "infcads,calcimeds,desccalcimeds,fpublsobr,descfpubls," + ;
                       "infsenha,logalt,endobr,numobr,bairroobr," + ;
                       "cidasobr,cepobris,paisesobr,chkendds,chkendrs," + ;
                       "tel1obr,tel2obr,nascobr,sexobr,dtnascobr," + ;
                       "dtespobr,obrtelefone,desctlm,desccla,descseg," + ;
                       "contconts,intconts,padpgrecs,ctvinculas,titbaixado," + ;
                       "contapdr,ccustotit,defhideshow,ctainatv,estoques," + ;
                       "limestoqs,verests,emprelevs,blqcongvs,calcsalds," + ;
                       "chklimests,patrietqs,ccustos,gerbals,unifbals," + ;
                       "balfalpers,blqdivops,invisivel,ddfutus,ddretros," + ;
                       "ddsems,hordd,tipoinvs,trfpesas,difpesags," + ;
                       "sinals,pqs,compagrus,agrupas,fichatecs," + ;
                       "osalfuns,grufals,ospends,chktits,tpprecos," + ;
                       "contafalha,grupofalha,ctrlotes," + ;
                       "cfgfisics,cfgfisips,cfgfisiis,cfgfisiss,cfgfisirs," + ;
                       "cfgfisins,cfgfispis,cfgfiscss,cfgfiscos" + ;
                       ") VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos) + "," + ;
                       EscaparSQL(THIS.this_cDescrs) + "," + ;
                       EscaparSQL(THIS.this_cDgcods) + "," + ;
                       EscaparSQL(THIS.this_cInternos) + "," + ;
                       EscaparSQL(THIS.this_cClasses) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTpcods) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTpemps) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTpcads) + "," + ;
                       FormatarNumeroSQL(THIS.this_nComplems) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPessoais) + "," + ;
                       FormatarNumeroSQL(THIS.this_nRefbancs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFollowups) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFiscais) + "," + ;
                       FormatarNumeroSQL(THIS.this_nContabs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEmpresas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCaracteris) + "," + ;
                       FormatarNumeroSQL(THIS.this_nRespos) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLimcres) + "," + ;
                       FormatarNumeroSQL(THIS.this_nComis) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDadcoms) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCargos) + "," + ;
                       FormatarNumeroSQL(THIS.this_nChklimcrds) + "," + ;
                       FormatarNumeroSQL(THIS.this_nColetors) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPrecad) + "," + ;
                       EscaparSQL(THIS.this_cGrupolms) + "," + ;
                       FormatarNumeroSQL(THIS.this_nVrlimcre) + "," + ;
                       EscaparSQL(THIS.this_cMolimcre) + "," + ;
                       EscaparSQL(THIS.this_cCommoedas) + "," + ;
                       EscaparSQL(THIS.this_cRodrelcc) + "," + ;
                       EscaparSQL(THIS.this_cCfgcdgcr) + "," + ;
                       EscaparSQL(THIS.this_cDescsit) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCpfobrigs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nRgobrigs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nMfotos) + "," + ;
                       FormatarNumeroSQL(THIS.this_nObservas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nInfcads) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCalcimeds) + "," + ;
                       EscaparSQL(THIS.this_cDesccalcimeds) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFpublsobr) + "," + ;
                       EscaparSQL(THIS.this_cDescfpubls) + "," + ;
                       FormatarNumeroSQL(THIS.this_nInfsenha) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLogalt) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEndobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNumobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nBairroobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCidasobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCepobris) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPaisesobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nChkendds) + "," + ;
                       FormatarNumeroSQL(THIS.this_nChkendrs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTel1obr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTel2obr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNascobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nSexobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDtnascobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDtespobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nObrtelefone) + "," + ;
                       EscaparSQL(THIS.this_cDesctlm) + "," + ;
                       EscaparSQL(THIS.this_cDesccla) + "," + ;
                       EscaparSQL(THIS.this_cDescseg) + "," + ;
                       EscaparSQL(THIS.this_cContconts) + "," + ;
                       FormatarNumeroSQL(THIS.this_nIntconts) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPadpgrecs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCtvinculas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTitbaixado) + "," + ;
                       EscaparSQL(THIS.this_cContapdr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCcustotit) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDefhideshow) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCtainatv) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEstoques) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLimestoqs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nVerests) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEmprelevs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nBlqcongvs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCalcsalds) + "," + ;
                       FormatarNumeroSQL(THIS.this_nChklimests) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPatrietqs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCcustos) + "," + ;
                       FormatarNumeroSQL(THIS.this_nGerbals) + "," + ;
                       FormatarNumeroSQL(THIS.this_nUnifbals) + "," + ;
                       FormatarNumeroSQL(THIS.this_nBalfalpers) + "," + ;
                       FormatarNumeroSQL(THIS.this_nBlqdivops) + "," + ;
                       FormatarNumeroSQL(THIS.this_nInvisivel) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDdfutus) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDdretros) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDdsems) + "," + ;
                       FormatarNumeroSQL(THIS.this_nHordd) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTipoinvs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTrfpesas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDifpesags) + "," + ;
                       FormatarNumeroSQL(THIS.this_nSinals) + "," + ;
                       EscaparSQL(THIS.this_cPqs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCompagrus) + "," + ;
                       EscaparSQL(THIS.this_cAgrupas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFichatecs) + "," + ;
                       EscaparSQL(THIS.this_cOsalfuns) + "," + ;
                       EscaparSQL(THIS.this_cGrufals) + "," + ;
                       FormatarNumeroSQL(THIS.this_nOspends) + "," + ;
                       FormatarNumeroSQL(THIS.this_nChktits) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTpprecos) + "," + ;
                       EscaparSQL(THIS.this_cContafalha) + "," + ;
                       EscaparSQL(THIS.this_cGrupofalha) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCtrlotes) + "," + ;
                       EscaparSQL(THIS.this_cCfgfisics) + "," + ;
                       EscaparSQL(THIS.this_cCfgfisips) + "," + ;
                       EscaparSQL(THIS.this_cCfgfisiis) + "," + ;
                       EscaparSQL(THIS.this_cCfgfisiss) + "," + ;
                       EscaparSQL(THIS.this_cCfgfisirs) + "," + ;
                       EscaparSQL(THIS.this_cCfgfisins) + "," + ;
                       EscaparSQL(THIS.this_cCfgfispis) + "," + ;
                       EscaparSQL(THIS.this_cCfgfiscss) + "," + ;
                       EscaparSQL(THIS.this_cCfgfiscos) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir grupo de contas correntes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir grupo de contas correntes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE na tabela SigCdGcr
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdGcr SET" + ;
                       " descrs=" + EscaparSQL(THIS.this_cDescrs) + "," + ;
                       " dgcods=" + EscaparSQL(THIS.this_cDgcods) + "," + ;
                       " internos=" + EscaparSQL(THIS.this_cInternos) + "," + ;
                       " classes=" + EscaparSQL(THIS.this_cClasses) + "," + ;
                       " tpcods=" + FormatarNumeroSQL(THIS.this_nTpcods) + "," + ;
                       " tpemps=" + FormatarNumeroSQL(THIS.this_nTpemps) + "," + ;
                       " tpcads=" + FormatarNumeroSQL(THIS.this_nTpcads) + "," + ;
                       " complems=" + FormatarNumeroSQL(THIS.this_nComplems) + "," + ;
                       " pessoais=" + FormatarNumeroSQL(THIS.this_nPessoais) + "," + ;
                       " refbancs=" + FormatarNumeroSQL(THIS.this_nRefbancs) + "," + ;
                       " followups=" + FormatarNumeroSQL(THIS.this_nFollowups) + "," + ;
                       " fiscais=" + FormatarNumeroSQL(THIS.this_nFiscais) + "," + ;
                       " contabs=" + FormatarNumeroSQL(THIS.this_nContabs) + "," + ;
                       " empresas=" + FormatarNumeroSQL(THIS.this_nEmpresas) + "," + ;
                       " caracteris=" + FormatarNumeroSQL(THIS.this_nCaracteris) + "," + ;
                       " respos=" + FormatarNumeroSQL(THIS.this_nRespos) + "," + ;
                       " limcres=" + FormatarNumeroSQL(THIS.this_nLimcres) + "," + ;
                       " comis=" + FormatarNumeroSQL(THIS.this_nComis) + "," + ;
                       " dadcoms=" + FormatarNumeroSQL(THIS.this_nDadcoms) + "," + ;
                       " cargos=" + FormatarNumeroSQL(THIS.this_nCargos) + "," + ;
                       " chklimcrds=" + FormatarNumeroSQL(THIS.this_nChklimcrds) + "," + ;
                       " coletors=" + FormatarNumeroSQL(THIS.this_nColetors) + "," + ;
                       " precad=" + FormatarNumeroSQL(THIS.this_nPrecad) + "," + ;
                       " grupolms=" + EscaparSQL(THIS.this_cGrupolms) + "," + ;
                       " vrlimcre=" + FormatarNumeroSQL(THIS.this_nVrlimcre) + "," + ;
                       " molimcre=" + EscaparSQL(THIS.this_cMolimcre) + "," + ;
                       " commoedas=" + EscaparSQL(THIS.this_cCommoedas) + "," + ;
                       " rodrelcc=" + EscaparSQL(THIS.this_cRodrelcc) + "," + ;
                       " cfgcdgcr=" + EscaparSQL(THIS.this_cCfgcdgcr) + "," + ;
                       " descsit=" + EscaparSQL(THIS.this_cDescsit) + "," + ;
                       " cpfobrigs=" + FormatarNumeroSQL(THIS.this_nCpfobrigs) + "," + ;
                       " rgobrigs=" + FormatarNumeroSQL(THIS.this_nRgobrigs) + "," + ;
                       " mfotos=" + FormatarNumeroSQL(THIS.this_nMfotos) + "," + ;
                       " observas=" + FormatarNumeroSQL(THIS.this_nObservas) + "," + ;
                       " infcads=" + FormatarNumeroSQL(THIS.this_nInfcads) + "," + ;
                       " calcimeds=" + FormatarNumeroSQL(THIS.this_nCalcimeds) + "," + ;
                       " desccalcimeds=" + EscaparSQL(THIS.this_cDesccalcimeds) + "," + ;
                       " fpublsobr=" + FormatarNumeroSQL(THIS.this_nFpublsobr) + "," + ;
                       " descfpubls=" + EscaparSQL(THIS.this_cDescfpubls) + "," + ;
                       " infsenha=" + FormatarNumeroSQL(THIS.this_nInfsenha) + "," + ;
                       " logalt=" + FormatarNumeroSQL(THIS.this_nLogalt) + "," + ;
                       " endobr=" + FormatarNumeroSQL(THIS.this_nEndobr) + "," + ;
                       " numobr=" + FormatarNumeroSQL(THIS.this_nNumobr) + "," + ;
                       " bairroobr=" + FormatarNumeroSQL(THIS.this_nBairroobr) + "," + ;
                       " cidasobr=" + FormatarNumeroSQL(THIS.this_nCidasobr) + "," + ;
                       " cepobris=" + FormatarNumeroSQL(THIS.this_nCepobris) + "," + ;
                       " paisesobr=" + FormatarNumeroSQL(THIS.this_nPaisesobr) + "," + ;
                       " chkendds=" + FormatarNumeroSQL(THIS.this_nChkendds) + "," + ;
                       " chkendrs=" + FormatarNumeroSQL(THIS.this_nChkendrs) + "," + ;
                       " tel1obr=" + FormatarNumeroSQL(THIS.this_nTel1obr) + "," + ;
                       " tel2obr=" + FormatarNumeroSQL(THIS.this_nTel2obr) + "," + ;
                       " nascobr=" + FormatarNumeroSQL(THIS.this_nNascobr) + "," + ;
                       " sexobr=" + FormatarNumeroSQL(THIS.this_nSexobr) + "," + ;
                       " dtnascobr=" + FormatarNumeroSQL(THIS.this_nDtnascobr) + "," + ;
                       " dtespobr=" + FormatarNumeroSQL(THIS.this_nDtespobr) + "," + ;
                       " obrtelefone=" + FormatarNumeroSQL(THIS.this_nObrtelefone) + "," + ;
                       " desctlm=" + EscaparSQL(THIS.this_cDesctlm) + "," + ;
                       " desccla=" + EscaparSQL(THIS.this_cDesccla) + "," + ;
                       " descseg=" + EscaparSQL(THIS.this_cDescseg) + "," + ;
                       " contconts=" + EscaparSQL(THIS.this_cContconts) + "," + ;
                       " intconts=" + FormatarNumeroSQL(THIS.this_nIntconts) + "," + ;
                       " padpgrecs=" + FormatarNumeroSQL(THIS.this_nPadpgrecs) + "," + ;
                       " ctvinculas=" + FormatarNumeroSQL(THIS.this_nCtvinculas) + "," + ;
                       " titbaixado=" + FormatarNumeroSQL(THIS.this_nTitbaixado) + "," + ;
                       " contapdr=" + EscaparSQL(THIS.this_cContapdr) + "," + ;
                       " ccustotit=" + FormatarNumeroSQL(THIS.this_nCcustotit) + "," + ;
                       " defhideshow=" + FormatarNumeroSQL(THIS.this_nDefhideshow) + "," + ;
                       " ctainatv=" + FormatarNumeroSQL(THIS.this_nCtainatv) + "," + ;
                       " estoques=" + FormatarNumeroSQL(THIS.this_nEstoques) + "," + ;
                       " limestoqs=" + FormatarNumeroSQL(THIS.this_nLimestoqs) + "," + ;
                       " verests=" + FormatarNumeroSQL(THIS.this_nVerests) + "," + ;
                       " emprelevs=" + FormatarNumeroSQL(THIS.this_nEmprelevs) + "," + ;
                       " blqcongvs=" + FormatarNumeroSQL(THIS.this_nBlqcongvs) + "," + ;
                       " calcsalds=" + FormatarNumeroSQL(THIS.this_nCalcsalds) + "," + ;
                       " chklimests=" + FormatarNumeroSQL(THIS.this_nChklimests) + "," + ;
                       " patrietqs=" + FormatarNumeroSQL(THIS.this_nPatrietqs) + "," + ;
                       " ccustos=" + FormatarNumeroSQL(THIS.this_nCcustos) + "," + ;
                       " gerbals=" + FormatarNumeroSQL(THIS.this_nGerbals) + "," + ;
                       " unifbals=" + FormatarNumeroSQL(THIS.this_nUnifbals) + "," + ;
                       " balfalpers=" + FormatarNumeroSQL(THIS.this_nBalfalpers) + "," + ;
                       " blqdivops=" + FormatarNumeroSQL(THIS.this_nBlqdivops) + "," + ;
                       " invisivel=" + FormatarNumeroSQL(THIS.this_nInvisivel) + "," + ;
                       " ddfutus=" + FormatarNumeroSQL(THIS.this_nDdfutus) + "," + ;
                       " ddretros=" + FormatarNumeroSQL(THIS.this_nDdretros) + "," + ;
                       " ddsems=" + FormatarNumeroSQL(THIS.this_nDdsems) + "," + ;
                       " hordd=" + FormatarNumeroSQL(THIS.this_nHordd) + "," + ;
                       " tipoinvs=" + FormatarNumeroSQL(THIS.this_nTipoinvs) + "," + ;
                       " trfpesas=" + FormatarNumeroSQL(THIS.this_nTrfpesas) + "," + ;
                       " difpesags=" + FormatarNumeroSQL(THIS.this_nDifpesags) + "," + ;
                       " sinals=" + FormatarNumeroSQL(THIS.this_nSinals) + "," + ;
                       " pqs=" + EscaparSQL(THIS.this_cPqs) + "," + ;
                       " compagrus=" + FormatarNumeroSQL(THIS.this_nCompagrus) + "," + ;
                       " agrupas=" + EscaparSQL(THIS.this_cAgrupas) + "," + ;
                       " fichatecs=" + FormatarNumeroSQL(THIS.this_nFichatecs) + "," + ;
                       " osalfuns=" + EscaparSQL(THIS.this_cOsalfuns) + "," + ;
                       " grufals=" + EscaparSQL(THIS.this_cGrufals) + "," + ;
                       " ospends=" + FormatarNumeroSQL(THIS.this_nOspends) + "," + ;
                       " chktits=" + FormatarNumeroSQL(THIS.this_nChktits) + "," + ;
                       " tpprecos=" + FormatarNumeroSQL(THIS.this_nTpprecos) + "," + ;
                       " contafalha=" + EscaparSQL(THIS.this_cContafalha) + "," + ;
                       " grupofalha=" + EscaparSQL(THIS.this_cGrupofalha) + "," + ;
                       " ctrlotes=" + FormatarNumeroSQL(THIS.this_nCtrlotes) + "," + ;
                       " cfgfisics=" + EscaparSQL(THIS.this_cCfgfisics) + "," + ;
                       " cfgfisips=" + EscaparSQL(THIS.this_cCfgfisips) + "," + ;
                       " cfgfisiis=" + EscaparSQL(THIS.this_cCfgfisiis) + "," + ;
                       " cfgfisiss=" + EscaparSQL(THIS.this_cCfgfisiss) + "," + ;
                       " cfgfisirs=" + EscaparSQL(THIS.this_cCfgfisirs) + "," + ;
                       " cfgfisins=" + EscaparSQL(THIS.this_cCfgfisins) + "," + ;
                       " cfgfispis=" + EscaparSQL(THIS.this_cCfgfispis) + "," + ;
                       " cfgfiscss=" + EscaparSQL(THIS.this_cCfgfiscss) + "," + ;
                       " cfgfiscos=" + EscaparSQL(THIS.this_cCfgfiscos) + ;
                       " WHERE codigos=" + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar grupo de contas correntes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar grupo de contas correntes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE da tabela SigCdGcr com verificacao de dependencias
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_cCodigo, loc_nCount, loc_nResultado, loc_lSucesso, loc_lBloqueado
        loc_lSucesso  = .F.
        loc_lBloqueado = .F.
        loc_cCodigo   = EscaparSQL(ALLTRIM(THIS.this_cCodigos))

        TRY
            IF !loc_lBloqueado
                loc_cSQL = "SELECT COUNT(*) AS cnt FROM SigMvCcr WHERE RTRIM(Grupos) = " + loc_cCodigo
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Chk") >= 0
                    SELECT cursor_4c_Chk
                    loc_nCount = cursor_4c_Chk.cnt
                    USE IN cursor_4c_Chk
                    IF loc_nCount > 0
                        loc_lBloqueado = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lBloqueado
                loc_cSQL = "SELECT COUNT(*) AS cnt FROM SigCdCli WHERE RTRIM(Grupos) = " + loc_cCodigo
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Chk") >= 0
                    SELECT cursor_4c_Chk
                    loc_nCount = cursor_4c_Chk.cnt
                    USE IN cursor_4c_Chk
                    IF loc_nCount > 0
                        loc_lBloqueado = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lBloqueado
                loc_cSQL = "SELECT COUNT(*) AS cnt FROM SigMvCab WHERE RTRIM(Grupos) = " + loc_cCodigo
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Chk") >= 0
                    SELECT cursor_4c_Chk
                    loc_nCount = cursor_4c_Chk.cnt
                    USE IN cursor_4c_Chk
                    IF loc_nCount > 0
                        loc_lBloqueado = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lBloqueado
                MsgAviso("Aten" + CHR(231) + CHR(227) + "o!!! Existem Lan" + CHR(231) + "amentos Efetuados Neste Grupo!!!" + CHR(13) + ;
                        "Exclua Todos os Lan" + CHR(231) + "amentos Antes de Excluir o Grupo!!!", "ERRO!!!")
            ELSE
                loc_cSQL = "DELETE FROM SigCdGcr WHERE codigos = " + loc_cCodigo
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir grupo de contas correntes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_Chk")
                USE IN cursor_4c_Chk
            ENDIF
            MsgErro("Erro ao excluir grupo de contas correntes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

