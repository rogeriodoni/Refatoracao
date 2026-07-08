# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSIGRECPM.prg] Procedure vazia (sem codigo): AlternarPagina
[FormSIGRECPM.prg] Procedure vazia (sem codigo): BtnSalvarClick

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGRECPM.prg):
*==============================================================================
* FORMSIGRECPM.PRG
* Relat" + CHR(243) + "rio de Composi" + CHR(231) + CHR(227) + "o por OP (SIGRECPM)
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGRECPM.SCX (frmrelatorio)
*
* Estrutura:
*   - Cabecalho escuro (cnt_4c_Cabecalho)
*   - CommandGroup botoes (cmg_4c_Botoes): Visualizar/Imprimir/Excel/Encerrar
*   - PageFrame (pgf_4c_Paginas): 1 pagina de filtros
*
* Tabelas: SigCdNei, SigCdNec, SigCdPro, SigOpPic, SigPdMvf, SigCdEmp
* FRX Analitico: SigReCPM.frx
* FRX Sintetico: SigReC2P.frx
*==============================================================================

DEFINE CLASS FormSIGRECPM AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=350)
    Height      = 350
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
    *   2. Cria SIGRECPMBO e valida instancia
    *   3. Monta cabecalho escuro + botoes + PageFrame
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Listagem de Composi" + CHR(231) + CHR(227) + "o por OP"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SIGRECPMBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGRECPMBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaDados()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")

                THIS.LimparCampos()
                THIS.Visible = .T.
                loc_lSucesso = .T.
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
    *   Width = THIS.Width para cobrir toda a faixa superior (nunca THIS.Width-60).
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
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Listagem de Composi" + CHR(231) + CHR(227) + "o por OP"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Listagem de Composi" + CHR(231) + CHR(227) + "o por OP"
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
    * ConfigurarBotoes - CommandGroup de botoes de relatorio (btnReport area)
    *   Geometria EXATA do framework frmrelatorio:
    *     cmg_4c_Botoes: Top=0, Left=529, Width=273, Height=80, ButtonCount=4
    *   Lefts dos botoes: Buttons(1)=5, (2)=71, (3)=137, (4)=203
    *   Eventos Click vinculados nas fases seguintes (Fase 7).
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

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .Caption         = "Visualizar"
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

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "Excel"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Exportar para Excel"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Encerrar"
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
    * ConfigurarPageFrame - PageFrame com 1 pagina (Filtros)
    *   Posicionado logo abaixo do cabecalho (top=85) ate o limite inferior.
    *   Controles de filtro sao adicionados em ConfigurarPaginaLista (Fase 5).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

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
    * ConfigurarPaginaDados - Adiciona controles de filtro na Page1
    *   Em forms REPORT (frmrelatorio) o layout e flat: nao ha Page de Lista
    *   nem Page de Dados separadas. Todos os filtros ficam em uma unica Page1.
    *   O nome ConfigurarPaginaDados segue a conv. do pipeline de migracao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag, loc_oErro
        TRY
            loc_oPag = THIS.pgf_4c_Paginas.Page1

            *-- Linha 1: Periodo
            loc_oPag.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPag.lbl_4c_Label1
                .Top       = 12
                .Left      = 219
                .Width     = 50
                .Height    = 18
                .Caption   = "Per" + CHR(237) + "odo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_DtInicial", "TextBox")
            WITH loc_oPag.txt_4c_DtInicial
                .Top           = 8
                .Left          = 267
                .Width         = 80
                .Height        = 25
                .Value         = {}
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label6", "Label")
            WITH loc_oPag.lbl_4c_Label6
                .Top       = 13
                .Left      = 355
                .Width     = 20
                .Height    = 18
                .Caption   = "at" + CHR(233)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_DtFinal", "TextBox")
            WITH loc_oPag.txt_4c_DtFinal
                .Top           = 8
                .Left          = 381
                .Width         = 80
                .Height        = 25
                .Value         = {}
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            *-- Linha 2: Empresa
            loc_oPag.AddObject("lbl_4c_Lbl_empresa", "Label")
            WITH loc_oPag.lbl_4c_Lbl_empresa
                .Top       = 39
                .Left      = 214
                .Width     = 50
                .Height    = 18
                .Caption   = "Empresa :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Empresa", "TextBox")
            WITH loc_oPag.txt_4c_Empresa
                .Top           = 35
                .Left          = 267
                .Width         = 31
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_DEmpresa", "TextBox")
            WITH loc_oPag.txt_4c_DEmpresa
                .Top           = 35
                .Left          = 300
                .Width         = 339
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            *-- Linha 3: Movimentacao / Faixa de numeros
            loc_oPag.AddObject("lbl_4c_Lbl_dopes", "Label")
            WITH loc_oPag.lbl_4c_Lbl_dopes
                .Top       = 66
                .Left      = 186
                .Width     = 78
                .Height    = 18
                .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Operacao", "TextBox")
            WITH loc_oPag.txt_4c_Operacao
                .Top           = 62
                .Left          = 267
                .Width         = 184
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label1b", "Label")
            WITH loc_oPag.lbl_4c_Label1b
                .Top       = 67
                .Left      = 475
                .Width     = 21
                .Height    = 15
                .Caption   = "de :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_OperacaoI", "TextBox")
            WITH loc_oPag.txt_4c_OperacaoI
                .Top           = 62
                .Left          = 500
                .Width         = 55
                .Height        = 25
                .Value         = 0
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label9", "Label")
            WITH loc_oPag.lbl_4c_Label9
                .Top       = 67
                .Left      = 561
                .Width     = 18
                .Height    = 15
                .Caption   = "at" + CHR(233)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_OperacaoF", "TextBox")
            WITH loc_oPag.txt_4c_OperacaoF
                .Top           = 62
                .Left          = 584
                .Width         = 55
                .Height        = 25
                .Value         = 0
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            *-- Linha 4: Grupo Origem
            loc_oPag.AddObject("lbl_4c_Label5", "Label")
            WITH loc_oPag.lbl_4c_Label5
                .Top       = 93
                .Left      = 189
                .Width     = 75
                .Height    = 18
                .Caption   = "Grupo Origem :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_GrOrigem", "TextBox")
            WITH loc_oPag.txt_4c_GrOrigem
                .Top           = 89
                .Left          = 267
                .Width         = 80
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_DsGrOrigem", "TextBox")
            WITH loc_oPag.txt_4c_DsGrOrigem
                .Top           = 89
                .Left          = 350
                .Width         = 312
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            *-- Linha 5: Conta Origem
            loc_oPag.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPag.lbl_4c_Label2
                .Top       = 120
                .Left      = 189
                .Width     = 75
                .Height    = 18
                .Caption   = "Conta Origem :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_ContaO", "TextBox")
            WITH loc_oPag.txt_4c_ContaO
                .Top           = 116
                .Left          = 267
                .Width         = 80
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_DContaO", "TextBox")
            WITH loc_oPag.txt_4c_DContaO
                .Top           = 116
                .Left          = 350
                .Width         = 312
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            *-- Linha 6: Grupo Destino
            loc_oPag.AddObject("lbl_4c_Label7", "Label")
            WITH loc_oPag.lbl_4c_Label7
                .Top       = 147
                .Left      = 187
                .Width     = 77
                .Height    = 18
                .Caption   = "Grupo Destino :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_GrDestino", "TextBox")
            WITH loc_oPag.txt_4c_GrDestino
                .Top           = 143
                .Left          = 267
                .Width         = 80
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_DsGrDestino", "TextBox")
            WITH loc_oPag.txt_4c_DsGrDestino
                .Top           = 143
                .Left          = 350
                .Width         = 312
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            *-- Linha 7: Conta Destino
            loc_oPag.AddObject("lbl_4c_Label4", "Label")
            WITH loc_oPag.lbl_4c_Label4
                .Top       = 174
                .Left      = 187
                .Width     = 77
                .Height    = 18
                .Caption   = "Conta Destino :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_ContaD", "TextBox")
            WITH loc_oPag.txt_4c_ContaD
                .Top           = 170
                .Left          = 267
                .Width         = 80
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_DContaD", "TextBox")
            WITH loc_oPag.txt_4c_DContaD
                .Top           = 170
                .Left          = 350
                .Width         = 312
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            *-- Linha 8: O.P.
            loc_oPag.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oPag.lbl_4c_Label3
                .Top       = 201
                .Left      = 233
                .Width     = 31
                .Height    = 15
                .Caption   = "O.P. :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_OP", "TextBox")
            WITH loc_oPag.txt_4c_OP
                .Top           = 197
                .Left          = 267
                .Width         = 86
                .Height        = 25
                .Value         = 0
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            *-- Linha 9: Tipo de relatorio
            loc_oPag.AddObject("lbl_4c_Label2b", "Label")
            WITH loc_oPag.lbl_4c_Label2b
                .Top       = 226
                .Left      = 235
                .Width     = 29
                .Height    = 15
                .Caption   = "Tipo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("obj_4c_Opt_Tipo", "OptionGroup")
            WITH loc_oPag.obj_4c_Opt_Tipo
                .Top         = 223
                .Left        = 262
                .Width       = 175
                .Height      = 25
                .ButtonCount = 2
                .Value       = 1
                .BackStyle   = 0
                .BorderStyle = 0
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "Anal" + CHR(237) + "tico"
                    .Left    = 0
                    .Top     = 0
                    .Width   = 80
                    .Height  = 25
                ENDWITH
                WITH .Buttons(2)
                    .Caption  = "Sint" + CHR(233) + "tico"
                    .Left     = 90
                    .Top      = 0
                    .Width    = 80
                    .Height   = 25
                    .FontName = "Tahoma"
                    .FontSize = 8
                    .Visible  = .T.
                ENDWITH
            ENDWITH

            *-- Container Aguarde (oculto ate o processamento)
            loc_oPag.AddObject("cnt_4c_Aguarde", "Container")
            WITH loc_oPag.cnt_4c_Aguarde
                .Top         = 83
                .Left        = 312
                .Width       = 207
                .Height      = 49
                .BackStyle   = 1
                .BackColor   = RGB(255, 255, 200)
                .BorderWidth = 1
                .Visible     = .F.

                .AddObject("lbl_4c_Aguarde1", "Label")
                WITH .lbl_4c_Aguarde1
                    .Top       = 7
                    .Left      = 69
                    .Width     = 68
                    .Height    = 18
                    .Caption   = "Aguarde..."
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .FontBold  = .T.
                    .ForeColor = RGB(0, 0, 128)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_Aguarde2", "Label")
                WITH .lbl_4c_Aguarde2
                    .Top       = 24
                    .Left      = 24
                    .Width     = 141
                    .Height    = 18
                    .Caption   = "Processando Dados..."
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .FontBold  = .F.
                    .ForeColor = RGB(0, 0, 128)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH
            ENDWITH

            *-- BINDEVENTs para campos com lookup
            BINDEVENT(loc_oPag.txt_4c_Empresa,     "KeyPress", THIS, "TeclaEmpresa")
            BINDEVENT(loc_oPag.txt_4c_Empresa,     "DblClick", THIS, "AbrirBuscaEmpresa")
            BINDEVENT(loc_oPag.txt_4c_DEmpresa,    "KeyPress", THIS, "TeclaDEmpresa")
            BINDEVENT(loc_oPag.txt_4c_Operacao,    "KeyPress", THIS, "TeclaOperacao")
            BINDEVENT(loc_oPag.txt_4c_Operacao,    "DblClick", THIS, "AbrirBuscaOperacao")
            BINDEVENT(loc_oPag.txt_4c_OperacaoI,   "KeyPress", THIS, "TeclaOperacaoI")
            BINDEVENT(loc_oPag.txt_4c_GrOrigem,    "KeyPress", THIS, "TeclaGrOrigem")
            BINDEVENT(loc_oPag.txt_4c_GrOrigem,    "DblClick", THIS, "AbrirBuscaGrOrigem")
            BINDEVENT(loc_oPag.txt_4c_DsGrOrigem,  "KeyPress", THIS, "TeclaDsGrOrigem")
            BINDEVENT(loc_oPag.txt_4c_ContaO,      "KeyPress", THIS, "TeclaContaO")
            BINDEVENT(loc_oPag.txt_4c_ContaO,      "DblClick", THIS, "AbrirBuscaContaO")
            BINDEVENT(loc_oPag.txt_4c_DContaO,     "KeyPress", THIS, "TeclaDContaO")
            BINDEVENT(loc_oPag.txt_4c_GrDestino,   "KeyPress", THIS, "TeclaGrDestino")
            BINDEVENT(loc_oPag.txt_4c_GrDestino,   "DblClick", THIS, "AbrirBuscaGrDestino")
            BINDEVENT(loc_oPag.txt_4c_DsGrDestino, "KeyPress", THIS, "TeclaDsGrDestino")
            BINDEVENT(loc_oPag.txt_4c_ContaD,      "KeyPress", THIS, "TeclaContaD")
            BINDEVENT(loc_oPag.txt_4c_ContaD,      "DblClick", THIS, "AbrirBuscaContaD")
            BINDEVENT(loc_oPag.txt_4c_DContaD,     "KeyPress", THIS, "TeclaDContaD")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura filtros para valores iniciais
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.txt_4c_DtInicial.Value   = THIS.this_oRelatorio.this_dDtInicial
        loc_oPag.txt_4c_DtFinal.Value     = THIS.this_oRelatorio.this_dDtFinal
        loc_oPag.txt_4c_Empresa.Value     = ""
        loc_oPag.txt_4c_DEmpresa.Value    = ""
        loc_oPag.txt_4c_Operacao.Value    = ""
        loc_oPag.txt_4c_OperacaoI.Value   = 0
        loc_oPag.txt_4c_OperacaoF.Value   = 0
        loc_oPag.txt_4c_GrOrigem.Value    = ""
        loc_oPag.txt_4c_DsGrOrigem.Value  = ""
        loc_oPag.txt_4c_ContaO.Value      = ""
        loc_oPag.txt_4c_DContaO.Value     = ""
        loc_oPag.txt_4c_GrDestino.Value   = ""
        loc_oPag.txt_4c_DsGrDestino.Value = ""
        loc_oPag.txt_4c_ContaD.Value      = ""
        loc_oPag.txt_4c_DContaD.Value     = ""
        loc_oPag.txt_4c_OP.Value          = 0
        loc_oPag.obj_4c_Opt_Tipo.Value    = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere campos do form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dDtInicial   = loc_oPag.txt_4c_DtInicial.Value
            .this_dDtFinal     = loc_oPag.txt_4c_DtFinal.Value
            .this_cEmpresa     = ALLTRIM(loc_oPag.txt_4c_Empresa.Value)
            .this_cDEmpresa    = ALLTRIM(loc_oPag.txt_4c_DEmpresa.Value)
            .this_cOperacao    = ALLTRIM(loc_oPag.txt_4c_Operacao.Value)
            .this_nOperacaoI   = loc_oPag.txt_4c_OperacaoI.Value
            .this_nOperacaoF   = loc_oPag.txt_4c_OperacaoF.Value
            .this_cGrOrigem    = ALLTRIM(loc_oPag.txt_4c_GrOrigem.Value)
            .this_cDsGrOrigem  = ALLTRIM(loc_oPag.txt_4c_DsGrOrigem.Value)
            .this_cContaO      = ALLTRIM(loc_oPag.txt_4c_ContaO.Value)
            .this_cDContaO     = ALLTRIM(loc_oPag.txt_4c_DContaO.Value)
            .this_cGrDestino   = ALLTRIM(loc_oPag.txt_4c_GrDestino.Value)
            .this_cDsGrDestino = ALLTRIM(loc_oPag.txt_4c_DsGrDestino.Value)
            .this_cContaD      = ALLTRIM(loc_oPag.txt_4c_ContaD.Value)
            .this_cDContaD     = ALLTRIM(loc_oPag.txt_4c_DContaD.Value)
            .this_nOP          = loc_oPag.txt_4c_OP.Value
            .this_nTipo        = loc_oPag.obj_4c_Opt_Tipo.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - REPORT forms usam layout flat (1 pagina)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
    ENDPROC

    *==========================================================================
    * HANDLERS DOS BOTOES (PUBLIC - obrigatorio para BINDEVENT)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - "Limpar filtros" em form de relatorio
    *   Em CRUD: prepara form para inclusao de novo registro.
    *   Em REPORT: restaura campos de filtro para os valores iniciais.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - "Visualizar" em form de relatorio
    *   Em CRUD: prepara form para alteracao do registro selecionado.
    *   Em REPORT: delega para BtnVisualizarClick (gera preview com filtros).
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Operacao invalida em form de relatorio
    *   Em CRUD: exclui registro selecionado.
    *   Em REPORT: exibe aviso (relatorios nao permitem exclusao).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o dispon" + CHR(237) + "vel neste relat" + CHR(243) + "rio.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oPag
        THIS.FormParaRelatorio()
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.cnt_4c_Aguarde.Visible = .T.
        THIS.Refresh
        IF !THIS.this_oRelatorio.Visualizar()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
        ENDIF
        loc_oPag.cnt_4c_Aguarde.Visible = .F.
    ENDPROC

    PROCEDURE BtnImprimirClick()
        LOCAL loc_oPag
        THIS.FormParaRelatorio()
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.cnt_4c_Aguarde.Visible = .T.
        THIS.Refresh
        IF !THIS.this_oRelatorio.Imprimir()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
        ENDIF
        loc_oPag.cnt_4c_Aguarde.Visible = .F.
    ENDPROC

    PROCEDURE BtnExcelClick()
        MsgAviso("Exporta" + CHR(231) + CHR(227) + "o para Excel n" + CHR(227) + ;
            "o implementada neste relat" + CHR(243) + "rio.", "Excel")
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * LOOKUPS DE EMPRESA (SigCdEmp: cemps / razas)
    *==========================================================================

    PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirBuscaEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oPag, loc_cValor, loc_oForm, loc_cSQL, loc_nRes
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Empresa.Value)

        IF !EMPTY(loc_cValor)
            loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + ;
                       EscaparSQL(loc_cValor)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
            IF loc_nRes > 0
                SELECT cursor_4c_EmpVal
                IF !EOF()
                    loc_oPag.txt_4c_DEmpresa.Value = ALLTRIM(razas)
                    USE IN cursor_4c_EmpVal
                    RETURN
                ENDIF
            ENDIF
            IF USED("cursor_4c_EmpVal")
                USE IN cursor_4c_EmpVal
            ENDIF
        ENDIF

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_EmpBusca", "cemps", loc_cValor, "Empresa")
        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            SELECT cursor_4c_EmpBusca
            loc_oPag.txt_4c_Empresa.Value  = ALLTRIM(cemps)
            loc_oPag.txt_4c_DEmpresa.Value = ALLTRIM(razas)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("razas", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                SELECT cursor_4c_EmpBusca
                loc_oPag.txt_4c_Empresa.Value  = ALLTRIM(cemps)
                loc_oPag.txt_4c_DEmpresa.Value = ALLTRIM(razas)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_EmpBusca")
            USE IN cursor_4c_EmpBusca
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE TeclaDEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        IF INLIST(par_nKeyCode, 13, 9, 115)
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF EMPTY(ALLTRIM(loc_oPag.txt_4c_Empresa.Value))
                THIS.AbrirBuscaEmpresa()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS DE OPERACAO (SigCdOpd: dopps)
    *==========================================================================

    PROCEDURE TeclaOperacao(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirBuscaOperacao()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaOperacao()
        LOCAL loc_oPag, loc_cValor, loc_oForm, loc_cSQL, loc_nRes
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Operacao.Value)

        IF !EMPTY(loc_cValor)
            loc_cSQL = "SELECT dopps FROM SigCdOpd WHERE dopps = " + ;
                       EscaparSQL(loc_cValor)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpdVal")
            IF loc_nRes > 0
                SELECT cursor_4c_OpdVal
                IF !EOF()
                    USE IN cursor_4c_OpdVal
                    RETURN
                ENDIF
            ENDIF
            IF USED("cursor_4c_OpdVal")
                USE IN cursor_4c_OpdVal
            ENDIF
        ENDIF

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdOpd", "cursor_4c_OpdBusca", "dopps", loc_cValor, ;
            "Movimenta" + CHR(231) + CHR(227) + "o")
        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            SELECT cursor_4c_OpdBusca
            loc_oPag.txt_4c_Operacao.Value = ALLTRIM(dopps)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("dopps", "", "Movimenta" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                SELECT cursor_4c_OpdBusca
                loc_oPag.txt_4c_Operacao.Value = ALLTRIM(dopps)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_OpdBusca")
            USE IN cursor_4c_OpdBusca
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE TeclaOperacaoI(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        IF INLIST(par_nKeyCode, 13, 9)
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF loc_oPag.txt_4c_OperacaoI.Value <> 0 AND ;
               loc_oPag.txt_4c_OperacaoF.Value = 0
                loc_oPag.txt_4c_OperacaoF.Value = loc_oPag.txt_4c_OperacaoI.Value
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS DE GRUPO ORIGEM (SigCdGcr: codigos / descrs)
    *==========================================================================

    PROCEDURE TeclaGrOrigem(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirBuscaGrOrigem()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaGrOrigem()
        LOCAL loc_oPag, loc_cValor, loc_oForm, loc_cSQL, loc_nRes
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_GrOrigem.Value)

        IF !EMPTY(loc_cValor)
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
                       EscaparSQL(loc_cValor)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcrVal")
            IF loc_nRes > 0
                SELECT cursor_4c_GcrVal
                IF !EOF()
                    loc_oPag.txt_4c_DsGrOrigem.Value = ALLTRIM(descrs)
                    USE IN cursor_4c_GcrVal
                    RETURN
                ENDIF
            ENDIF
            IF USED("cursor_4c_GcrVal")
                USE IN cursor_4c_GcrVal
            ENDIF
        ENDIF

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGcr", "cursor_4c_GcrBuscaO", "codigos", loc_cValor, "Grupo")
        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            SELECT cursor_4c_GcrBuscaO
            loc_oPag.txt_4c_GrOrigem.Value   = ALLTRIM(codigos)
            loc_oPag.txt_4c_DsGrOrigem.Value = ALLTRIM(descrs)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                SELECT cursor_4c_GcrBuscaO
                loc_oPag.txt_4c_GrOrigem.Value   = ALLTRIM(codigos)
                loc_oPag.txt_4c_DsGrOrigem.Value = ALLTRIM(descrs)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_GcrBuscaO")
            USE IN cursor_4c_GcrBuscaO
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE TeclaDsGrOrigem(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        IF INLIST(par_nKeyCode, 13, 9, 115)
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF EMPTY(ALLTRIM(loc_oPag.txt_4c_GrOrigem.Value))
                THIS.AbrirBuscaGrOrigem()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS DE CONTA ORIGEM (SigReCtb: contas / descs)
    *==========================================================================

    PROCEDURE TeclaContaO(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirBuscaContaO()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaContaO()
        LOCAL loc_oPag, loc_cValor, loc_oForm, loc_cSQL, loc_nRes
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_ContaO.Value)

        IF !EMPTY(loc_cValor)
            loc_cSQL = "SELECT contas, descs FROM SigReCtb WHERE contas = " + ;
                       EscaparSQL(loc_cValor)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaOVal")
            IF loc_nRes > 0
                SELECT cursor_4c_ContaOVal
                IF !EOF()
                    loc_oPag.txt_4c_DContaO.Value = ALLTRIM(descs)
                    USE IN cursor_4c_ContaOVal
                    RETURN
                ENDIF
            ENDIF
            IF USED("cursor_4c_ContaOVal")
                USE IN cursor_4c_ContaOVal
            ENDIF
        ENDIF

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigReCtb", "cursor_4c_ContaOBusca", "contas", loc_cValor, ;
            "Conta Origem")
        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            SELECT cursor_4c_ContaOBusca
            loc_oPag.txt_4c_ContaO.Value  = ALLTRIM(contas)
            loc_oPag.txt_4c_DContaO.Value = ALLTRIM(descs)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("contas", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                SELECT cursor_4c_ContaOBusca
                loc_oPag.txt_4c_ContaO.Value  = ALLTRIM(contas)
                loc_oPag.txt_4c_DContaO.Value = ALLTRIM(descs)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_ContaOBusca")
            USE IN cursor_4c_ContaOBusca
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE TeclaDContaO(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        IF INLIST(par_nKeyCode, 13, 9, 115)
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF EMPTY(ALLTRIM(loc_oPag.txt_4c_ContaO.Value))
                THIS.AbrirBuscaContaO()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS DE GRUPO DESTINO (SigCdGcr: codigos / descrs)
    *==========================================================================

    PROCEDURE TeclaGrDestino(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirBuscaGrDestino()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaGrDestino()
        LOCAL loc_oPag, loc_cValor, loc_oForm, loc_cSQL, loc_nRes
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_GrDestino.Value)

        IF !EMPTY(loc_cValor)
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
                       EscaparSQL(loc_cValor)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcrDVal")
            IF loc_nRes > 0
                SELECT cursor_4c_GcrDVal
                IF !EOF()
                    loc_oPag.txt_4c_DsGrDestino.Value = ALLTRIM(descrs)
                    USE IN cursor_4c_GcrDVal
                    RETURN
                ENDIF
            ENDIF
            IF USED("cursor_4c_GcrDVal")
                USE IN cursor_4c_GcrDVal
            ENDIF
        ENDIF

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGcr", "cursor_4c_GcrBuscaD", "codigos", loc_cValor, "Grupo")
        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            SELECT cursor_4c_GcrBuscaD
            loc_oPag.txt_4c_GrDestino.Value   = ALLTRIM(codigos)
            loc_oPag.txt_4c_DsGrDestino.Value = ALLTRIM(descrs)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                SELECT cursor_4c_GcrBuscaD
                loc_oPag.txt_4c_GrDestino.Value   = ALLTRIM(codigos)
                loc_oPag.txt_4c_DsGrDestino.Value = ALLTRIM(descrs)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_GcrBuscaD")
            USE IN cursor_4c_GcrBuscaD
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE TeclaDsGrDestino(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        IF INLIST(par_nKeyCode, 13, 9, 115)
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF EMPTY(ALLTRIM(loc_oPag.txt_4c_GrDestino.Value))
                THIS.AbrirBuscaGrDestino()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS DE CONTA DESTINO (SigReCtb: contas / descs)
    *==========================================================================

    PROCEDURE TeclaContaD(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirBuscaContaD()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaContaD()
        LOCAL loc_oPag, loc_cValor, loc_oForm, loc_cSQL, loc_nRes
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_ContaD.Value)

        IF !EMPTY(loc_cValor)
            loc_cSQL = "SELECT contas, descs FROM SigReCtb WHERE contas = " + ;
                       EscaparSQL(loc_cValor)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaDVal")
            IF loc_nRes > 0
                SELECT cursor_4c_ContaDVal
                IF !EOF()
                    loc_oPag.txt_4c_DContaD.Value = ALLTRIM(descs)
                    USE IN cursor_4c_ContaDVal
                    RETURN
                ENDIF
            ENDIF
            IF USED("cursor_4c_ContaDVal")
                USE IN cursor_4c_ContaDVal
            ENDIF
        ENDIF

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigReCtb", "cursor_4c_ContaDBusca", "contas", loc_cValor, ;
            "Conta Destino")
        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            SELECT cursor_4c_ContaDBusca
            loc_oPag.txt_4c_ContaD.Value  = ALLTRIM(contas)
            loc_oPag.txt_4c_DContaD.Value = ALLTRIM(descs)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("contas", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                SELECT cursor_4c_ContaDBusca
                loc_oPag.txt_4c_ContaD.Value  = ALLTRIM(contas)
                loc_oPag.txt_4c_DContaD.Value = ALLTRIM(descs)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_ContaDBusca")
            USE IN cursor_4c_ContaDBusca
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE TeclaDContaD(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        IF INLIST(par_nKeyCode, 13, 9, 115)
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF EMPTY(ALLTRIM(loc_oPag.txt_4c_ContaD.Value))
                THIS.AbrirBuscaContaD()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Em REPORT: executa preview (equivale a Visualizar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Nao aplicavel em REPORT (sem operacoes CRUD)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Fecha o formulario de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Compatibilidade com contrato FormBase; delega a FormParaRelatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Compatibilidade com contrato FormBase
    *   Em REPORT nao ha dados de registro para trazer de volta ao form.
    *   Restaura apenas as datas iniciais do BO caso ainda estejam em branco.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPag, loc_oErro
        TRY
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                IF EMPTY(loc_oPag.txt_4c_DtInicial.Value)
                    loc_oPag.txt_4c_DtInicial.Value = THIS.this_oRelatorio.this_dDtInicial
                ENDIF
                IF EMPTY(loc_oPag.txt_4c_DtFinal.Value)
                    loc_oPag.txt_4c_DtFinal.Value = THIS.this_oRelatorio.this_dDtFinal
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Em REPORT todos os campos sao sempre editaveis
    *   (nao ha modos INCLUIR/ALTERAR/VISUALIZAR como em CRUD)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.txt_4c_DtInicial.Enabled   = .T.
        loc_oPag.txt_4c_DtFinal.Enabled     = .T.
        loc_oPag.txt_4c_Empresa.Enabled     = .T.
        loc_oPag.txt_4c_DEmpresa.Enabled    = .T.
        loc_oPag.txt_4c_Operacao.Enabled    = .T.
        loc_oPag.txt_4c_OperacaoI.Enabled   = .T.
        loc_oPag.txt_4c_OperacaoF.Enabled   = .T.
        loc_oPag.txt_4c_GrOrigem.Enabled    = .T.
        loc_oPag.txt_4c_DsGrOrigem.Enabled  = .T.
        loc_oPag.txt_4c_ContaO.Enabled      = .T.
        loc_oPag.txt_4c_DContaO.Enabled     = .T.
        loc_oPag.txt_4c_GrDestino.Enabled   = .T.
        loc_oPag.txt_4c_DsGrDestino.Enabled = .T.
        loc_oPag.txt_4c_ContaD.Enabled      = .T.
        loc_oPag.txt_4c_DContaD.Enabled     = .T.
        loc_oPag.txt_4c_OP.Enabled          = .T.
        loc_oPag.obj_4c_Opt_Tipo.Enabled    = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Nao aplicavel em REPORT (sem grid de lista)
    *   Retorna .T. para compatibilidade com FormBase.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Nao aplicavel em REPORT (sem modos CRUD)
    *   Garante que os botoes do CommandGroup permanecem sempre habilitados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
            THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO (NUNCA chamar .Release em Custom)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGRECPMBO.prg):
*==============================================================================
* SIGRECPMBO.PRG
* Business Object para Relatorio de Composicao por OP (SIGRECPM)
* Herda de RelatorioBase
*
* Relatorio: Listagem de Composicao por OP (Analitico/Sintetico)
* FRX Analitico: SigReCPM.frx
* FRX Sintetico: SigReC2P.frx
* Tabelas: SigCdNei, SigCdNec, SigCdPro, SigOpPic, SigPdMvf, SigCdEmp
*==============================================================================

DEFINE CLASS SIGRECPMBO AS RelatorioBase

    *-- Filtro: Empresa
    this_cEmpresa       = ""
    this_cDEmpresa      = ""

    *-- Filtro: Periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtro: Movimentacao/Operacao
    this_cOperacao      = ""

    *-- Filtro: Conta Origem
    this_cContaO        = ""
    this_cDContaO       = ""

    *-- Filtro: Conta Destino
    this_cContaD        = ""
    this_cDContaD       = ""

    *-- Filtro: Grupo Origem
    this_cGrOrigem      = ""
    this_cDsGrOrigem    = ""

    *-- Filtro: Grupo Destino
    this_cGrDestino     = ""
    this_cDsGrDestino   = ""

    *-- Filtro: Faixa de Numeros de Operacao
    this_nOperacaoI     = 0
    this_nOperacaoF     = 0

    *-- Filtro: Numero da OP
    this_nOP            = 0

    *-- Tipo de relatorio: 1=Analitico, 2=Sintetico
    this_nTipo          = 1

    *-- Flags e acumuladores (equivalentes a llope, npeso2s, npesos, nqtd do form legado)
    this_lLlope         = .F.
    this_nPeso2s        = 0
    this_nPesos         = 0
    this_nQtd           = 0

    *-- Cursor principal de dados
    this_cCursorDados   = "cursor_4c_SigRecPM"

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO com valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_dDtInicial = DATE()
        THIS.this_dDtFinal   = DATE()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa query principal e processa cursors intermediarios
    * Replica logica do PROCEDURE processamento do legado SIGRECPM
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSQLEmp, loc_nResEmp, loc_cNomeEmpresa
        LOCAL loc_cTitulo, loc_cPeriodo, loc_cSubTit, loc_cNopRange
        LOCAL loc_cDtIni, loc_cDtFim
        LOCAL loc_nAno, loc_nMes, loc_nDia
        LOCAL loc_cWhere, loc_cWhereNop1, loc_cWhereNop2
        LOCAL loc_cSQL1, loc_cSQL2, loc_cSQLUnion
        LOCAL loc_nResult
        LOCAL loc_nPesos, loc_nPeso2s, loc_nQtd

        loc_lSucesso = .F.
        TRY
            *-- Busca nome da empresa quando filtrado
            loc_cNomeEmpresa = ""
            IF !EMPTY(THIS.this_cEmpresa)
                loc_cSQLEmp = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(THIS.this_cEmpresa)
                loc_nResEmp = SQLEXEC(gnConnHandle, loc_cSQLEmp, "cursor_4c_SigRecPM_Emp")
                IF loc_nResEmp > 0
                    SELECT cursor_4c_SigRecPM_Emp
                    IF !EOF()
                        loc_cNomeEmpresa = ALLTRIM(Razas)
                    ENDIF
                    USE IN cursor_4c_SigRecPM_Emp
                ENDIF
            ENDIF

            *-- Monta cabecalho do relatorio (dbCabecalho usado pelo FRX)
            IF USED("dbCabecalho")
                USE IN dbCabecalho
            ENDIF
            CREATE CURSOR dbCabecalho (NomeEmpresa C(80), Titulo C(80), ;
                                       Periodo C(150), SubTitulo C(80), ;
                                       lCompo L, Total M(4))

            loc_cTitulo = "Listagem de Composi" + CHR(231) + CHR(227) + "o por OP - " + ;
                          IIF(THIS.this_nTipo = 2, "Sint" + CHR(233) + "tico", ;
                              "Anal" + CHR(237) + "tico")

            loc_cPeriodo = "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDtInicial) + ;
                           " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal) + " - " + ;
                           "Empresa: " + IIF(EMPTY(THIS.this_cEmpresa), "Geral", ;
                           THIS.this_cEmpresa + " - " + ALLTRIM(THIS.this_cDEmpresa))

            loc_cSubTit = IIF(THIS.this_nOP <> 0, ;
                              "OP: " + ALLTRIM(STR(THIS.this_nOP, 10)), "")

            IF !EMPTY(THIS.this_cOperacao)
                loc_cNopRange = ""
                IF THIS.this_nOperacaoI <> 0
                    loc_cNopRange = ":" + ALLTRIM(STR(THIS.this_nOperacaoI, 6))
                    IF THIS.this_nOperacaoF <> 0
                        loc_cNopRange = loc_cNopRange + " " + CHR(224) + " " + ;
                                        ALLTRIM(STR(THIS.this_nOperacaoF, 6))
                    ENDIF
                ENDIF
                loc_cSubTit = loc_cSubTit + IIF(!EMPTY(loc_cSubTit), " ", "") + ;
                              "Movimenta" + CHR(231) + CHR(227) + "o (" + ;
                              ALLTRIM(THIS.this_cOperacao) + loc_cNopRange + ")"
            ENDIF

            INSERT INTO dbCabecalho (NomeEmpresa, Titulo, Periodo, SubTitulo) ;
                   VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo, loc_cSubTit)

            *-- Datas para o WHERE: inicio normal, fim com 23:59:59 para cobrir dia inteiro
            loc_cDtIni = FormatarDataSQL(THIS.this_dDtInicial)
            loc_nAno   = YEAR(THIS.this_dDtFinal)
            loc_nMes   = MONTH(THIS.this_dDtFinal)
            loc_nDia   = DAY(THIS.this_dDtFinal)
            loc_cDtFim = "'" + PADL(LTRIM(STR(loc_nAno)), 4, "0") + "-" + ;
                         PADL(LTRIM(STR(loc_nMes)), 2, "0") + "-" + ;
                         PADL(LTRIM(STR(loc_nDia)), 2, "0") + " 23:59:59'"

            *-- WHERE base (compartilhado pelas duas partes do UNION)
            loc_cWhere = " WHERE b.Datas BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim
            IF !EMPTY(THIS.this_cEmpresa)
                loc_cWhere = loc_cWhere + " AND a.Emps = " + EscaparSQL(THIS.this_cEmpresa)
            ENDIF
            IF !EMPTY(THIS.this_cOperacao)
                loc_cWhere = loc_cWhere + " AND a.Dopps = " + EscaparSQL(THIS.this_cOperacao)
            ENDIF
            IF THIS.this_nOperacaoI <> 0
                loc_cWhere = loc_cWhere + " AND a.Numps >= " + ALLTRIM(STR(THIS.this_nOperacaoI))
            ENDIF
            IF THIS.this_nOperacaoF <> 0
                loc_cWhere = loc_cWhere + " AND a.Numps <= " + ALLTRIM(STR(THIS.this_nOperacaoF))
            ENDIF
            IF !EMPTY(THIS.this_cGrOrigem)
                loc_cWhere = loc_cWhere + " AND b.GrupoOs = " + EscaparSQL(THIS.this_cGrOrigem)
            ENDIF
            IF !EMPTY(THIS.this_cContaO)
                loc_cWhere = loc_cWhere + " AND b.ContaOs = " + EscaparSQL(THIS.this_cContaO)
            ENDIF
            IF !EMPTY(THIS.this_cGrDestino)
                loc_cWhere = loc_cWhere + " AND b.GrupoDs = " + EscaparSQL(THIS.this_cGrDestino)
            ENDIF
            IF !EMPTY(THIS.this_cContaD)
                loc_cWhere = loc_cWhere + " AND b.ContaDs = " + EscaparSQL(THIS.this_cContaD)
            ENDIF

            *-- WHERE para parte 1: filtra por Nops (OP direta)
            loc_cWhereNop1 = loc_cWhere
            IF THIS.this_nOP <> 0
                loc_cWhereNop1 = loc_cWhereNop1 + ;
                                 " AND a.Nops = " + ALLTRIM(STR(THIS.this_nOP))
            ENDIF

            *-- WHERE para parte 2: filtra por Nenvs (sub-ordens da OP)
            loc_cWhereNop2 = loc_cWhere
            IF THIS.this_nOP <> 0
                loc_cWhereNop2 = loc_cWhereNop2 + ;
                                 " AND (a.Nenvs = " + ALLTRIM(STR(THIS.this_nOP)) + ;
                                 " AND a.Nops <> " + ALLTRIM(STR(THIS.this_nOP)) + ")"
            ENDIF

            *-- Parte 1 do UNION: Nops como OP direta (a.Nops AS Nenvs)
            loc_cSQL1 = "SELECT DISTINCT 1 AS Tipo, a.emps, a.dopps, a.numps," + ;
                        " b.CidChaves, a.Nops AS Nenvs, a.EmpDnPs, b.Datas,"
            loc_cSQL1 = loc_cSQL1 + ;
                        " b.Grupoos, b.Contaos, b.grupods, b.contads,"
            loc_cSQL1 = loc_cSQL1 + ;
                        " a.servicos, 0 AS Nops, a.cmats, c.dpros, a.Qtds,"
            loc_cSQL1 = loc_cSQL1 + ;
                        " c.cunis, a.peso2s, c.cunips, a.Pesos,"
            loc_cSQL1 = loc_cSQL1 + ;
                        " ISNULL(d.Cpros,'') AS Cpros, ISNULL(d.NopMaes,0) AS NopMaes,"
            loc_cSQL1 = loc_cSQL1 + ;
                        " ISNULL(e.dpros,'') AS DescPro, f.qtds AS Qtd"
            loc_cSQL1 = loc_cSQL1 + ;
                        " FROM SigCdNei a"
            loc_cSQL1 = loc_cSQL1 + ;
                        " INNER JOIN SigCdNec b ON a.empdnps = b.empdnps"
            loc_cSQL1 = loc_cSQL1 + ;
                        " INNER JOIN SigCdPro c ON a.cmats = c.cpros"
            loc_cSQL1 = loc_cSQL1 + ;
                        " LEFT JOIN SigOpPic d ON a.Nops = d.Nops"
            loc_cSQL1 = loc_cSQL1 + ;
                        " LEFT JOIN SigCdPro e ON d.Cpros = e.Cpros"
            loc_cSQL1 = loc_cSQL1 + ;
                        " INNER JOIN SigPdMvf f ON a.EmpDnPs = f.EmpDnPs"
            loc_cSQL1 = loc_cSQL1 + loc_cWhereNop1

            *-- Parte 2 do UNION: Nenvs real (sub-ordens)
            loc_cSQL2 = "SELECT DISTINCT 1 AS Tipo, a.emps, a.dopps, a.numps," + ;
                        " b.CidChaves, a.Nenvs, a.EmpDnPs, b.Datas,"
            loc_cSQL2 = loc_cSQL2 + ;
                        " b.Grupoos, b.Contaos, b.grupods, b.contads,"
            loc_cSQL2 = loc_cSQL2 + ;
                        " a.servicos, 0 AS Nops, a.cmats, c.dpros, a.Qtds,"
            loc_cSQL2 = loc_cSQL2 + ;
                        " c.cunis, a.peso2s, c.cunips, a.Pesos,"
            loc_cSQL2 = loc_cSQL2 + ;
                        " ISNULL(d.Cpros,'') AS Cpros, ISNULL(d.NopMaes,0) AS NopMaes,"
            loc_cSQL2 = loc_cSQL2 + ;
                        " ISNULL(e.dpros,'') AS DescPro, f.qtds AS Qtd"
            loc_cSQL2 = loc_cSQL2 + ;
                        " FROM SigCdNei a"
            loc_cSQL2 = loc_cSQL2 + ;
                        " INNER JOIN SigCdNec b ON a.empdnps = b.empdnps"
            loc_cSQL2 = loc_cSQL2 + ;
                        " INNER JOIN SigCdPro c ON a.cmats = c.cpros"
            loc_cSQL2 = loc_cSQL2 + ;
                        " LEFT JOIN SigOpPic d ON a.Nops = d.Nops"
            loc_cSQL2 = loc_cSQL2 + ;
                        " LEFT JOIN SigCdPro e ON d.Cpros = e.Cpros"
            loc_cSQL2 = loc_cSQL2 + ;
                        " INNER JOIN SigPdMvf f ON a.EmpDnPs = f.EmpDnPs"
            loc_cSQL2 = loc_cSQL2 + loc_cWhereNop2

            loc_cSQLUnion = loc_cSQL1 + " UNION " + loc_cSQL2

            *-- Executa query principal no SQL Server
            IF USED("TmpNensi")
                USE IN TmpNensi
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQLUnion, "TmpNensi")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            ELSE

            *-- Agrupa por material/OP para eliminar duplicatas e calcular totais
            IF USED("crNensi")
                USE IN crNensi
            ENDIF
            SELECT Tipo, Nenvs, dopps, cpros, descpro, cmats, dpros, cunis, cunips, ;
                   MAX(cidchaves) AS cidchaves, MAX(pesos) AS pesos, ;
                   MAX(peso2s) AS peso2s, MAX(qtds) AS Qtds, MAX(qtd) AS qtd ;
                   FROM TmpNensi ;
                   GROUP BY Tipo, Nenvs, dopps, cpros, descpro, cmats, dpros, cunis, cunips ;
                   INTO CURSOR crNensi READWRITE

            SELECT crNensi
            INDEX ON STR(nenvs, 10) + STR(Tipo) + cidchaves + dopps + cmats TAG Mov
            GO TOP

            *-- Agrega por material para calcular totais de peso
            IF USED("crNensi2")
                USE IN crNensi2
            ENDIF
            SELECT 2 AS Tipo, nenvs, cmats, MAX(pesos) AS pesos, ;
                   MAX(peso2s) AS peso2s, MAX(qtds) AS Qtds ;
                   FROM crNensi ;
                   GROUP BY Nenvs, cmats ;
                   INTO CURSOR crNensi2 READWRITE

            SELECT crNensi2
            loc_nPesos  = 0
            loc_nPeso2s = 0
            SUM pesos, peso2s TO loc_nPesos, loc_nPeso2s
            THIS.this_nPesos  = loc_nPesos
            THIS.this_nPeso2s = loc_nPeso2s

            *-- Agrega por OP para calcular total de quantidade
            IF USED("crNensi3")
                USE IN crNensi3
            ENDIF
            SELECT 3 AS Tipo, nenvs, MAX(qtd) AS Qtd ;
                   FROM crNensi ;
                   GROUP BY Nenvs ;
                   INTO CURSOR crNensi3 READWRITE

            SELECT crNensi3
            loc_nQtd = 0
            SUM Qtd TO loc_nQtd
            THIS.this_nQtd = loc_nQtd

            *-- Modo Sintetico: reagrupa por material eliminando detalhe de OP
            IF THIS.this_nTipo = 2
                IF USED("crTmpNensi")
                    USE IN crTmpNensi
                ENDIF
                SELECT 9 AS Tipo, '' AS Dopps, cmats, dpros, cunips, cunis, ;
                       0 AS Qtd, SUM(qtds) AS Qtds, SUM(pesos) AS pesos, ;
                       SUM(peso2s) AS peso2s ;
                       FROM crNensi ;
                       GROUP BY cmats, dpros, cunis, cunips ;
                       ORDER BY cmats ;
                       INTO CURSOR crTmpNensi READWRITE

                SELECT crTmpNensi
                GO TOP
            ELSE
                SELECT crNensi
                GO TOP
            ENDIF

            THIS.this_lLlope = EMPTY(THIS.this_cOperacao)

            loc_lSucesso = .T.
            ENDIF  && loc_nResult >= 1
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados - SIGRECPMBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nTipo = 1
                    REPORT FORM (gc_4c_CaminhoReports + "SigReCPM.frx") PREVIEW NOCONSOLE
                ELSE
                    REPORT FORM (gc_4c_CaminhoReports + "SigReC2P.frx") PREVIEW NOCONSOLE
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar - SIGRECPMBO")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime o relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nTipo = 1
                    REPORT FORM (gc_4c_CaminhoReports + "SigReCPM.frx") ;
                           TO PRINTER PROMPT NOCONSOLE
                ELSE
                    REPORT FORM (gc_4c_CaminhoReports + "SigReC2P.frx") ;
                           TO PRINTER PROMPT NOCONSOLE
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir - SIGRECPMBO")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores de filtro a partir de um cursor
    * Util para restaurar conjuntos de filtros salvos (presets)
    * O cursor deve conter colunas com os mesmos nomes dos filtros do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                loc_lSucesso = .F.
            ENDIF

            SELECT (par_cAliasCursor)
            IF EOF()
                THIS.this_cMensagemErro = "Cursor de filtros vazio"
                loc_lSucesso = .F.
            ENDIF

            *-- Empresa
            IF TYPE(par_cAliasCursor + ".Emps") != "U"
                THIS.this_cEmpresa = TratarNulo(Emps, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DEmps") != "U"
                THIS.this_cDEmpresa = TratarNulo(DEmps, "C")
            ENDIF

            *-- Periodo
            IF TYPE(par_cAliasCursor + ".DtIni") != "U"
                THIS.this_dDtInicial = TratarNulo(DtIni, "D")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DtFim") != "U"
                THIS.this_dDtFinal = TratarNulo(DtFim, "D")
            ENDIF

            *-- Operacao
            IF TYPE(par_cAliasCursor + ".Dopps") != "U"
                THIS.this_cOperacao = TratarNulo(Dopps, "C")
            ENDIF

            *-- Contas
            IF TYPE(par_cAliasCursor + ".Contaos") != "U"
                THIS.this_cContaO = TratarNulo(Contaos, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DContaO") != "U"
                THIS.this_cDContaO = TratarNulo(DContaO, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".Contads") != "U"
                THIS.this_cContaD = TratarNulo(Contads, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DContaD") != "U"
                THIS.this_cDContaD = TratarNulo(DContaD, "C")
            ENDIF

            *-- Grupos
            IF TYPE(par_cAliasCursor + ".Grupoos") != "U"
                THIS.this_cGrOrigem = TratarNulo(Grupoos, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DGrupoOs") != "U"
                THIS.this_cDsGrOrigem = TratarNulo(DGrupoOs, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".Grupods") != "U"
                THIS.this_cGrDestino = TratarNulo(Grupods, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DGrupoDs") != "U"
                THIS.this_cDsGrDestino = TratarNulo(DGrupoDs, "C")
            ENDIF

            *-- Faixa de Operacao
            IF TYPE(par_cAliasCursor + ".NumPsI") != "U"
                THIS.this_nOperacaoI = TratarNulo(NumPsI, "N")
            ENDIF
            IF TYPE(par_cAliasCursor + ".NumPsF") != "U"
                THIS.this_nOperacaoF = TratarNulo(NumPsF, "N")
            ENDIF

            *-- OP
            IF TYPE(par_cAliasCursor + ".Nops") != "U"
                THIS.this_nOP = TratarNulo(Nops, "N")
            ENDIF

            *-- Tipo
            IF TYPE(par_cAliasCursor + ".TipoRel") != "U"
                THIS.this_nTipo = TratarNulo(TipoRel, "N")
                IF THIS.this_nTipo < 1 OR THIS.this_nTipo > 2
                    THIS.this_nTipo = 1
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "CarregarDoCursor - SIGRECPMBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao NAO aplicavel para BOs de relatorio
    * Relatorios nao persistem registros; existem apenas para gerar saida.
    * Sobrescreve para garantir que chamadas indevidas vindas de codigo
    * generico (sweepers, framework) falhem com mensagem clara e auditavel.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de inclus" + CHR(227) + ;
                                  "o n" + CHR(227) + "o aplic" + CHR(225) + "vel para o relat" + ;
                                  CHR(243) + "rio de Composi" + CHR(231) + CHR(227) + "o por OP"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao NAO aplicavel para BOs de relatorio
    * (mesma justificativa de Inserir())
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de altera" + CHR(231) + ;
                                  CHR(227) + "o n" + CHR(227) + "o aplic" + CHR(225) + "vel para o relat" + ;
                                  CHR(243) + "rio de Composi" + CHR(231) + CHR(227) + "o por OP"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador do conjunto de filtros atual
    * Relatorios nao tem chave de registro - usa-se o hash dos filtros
    * para identificar a execucao (util em auditoria/log).
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "SIGRECPM|" + ;
                     ALLTRIM(THIS.this_cEmpresa) + "|" + ;
                     DTOS(THIS.this_dDtInicial) + "|" + ;
                     DTOS(THIS.this_dDtFinal) + "|" + ;
                     ALLTRIM(THIS.this_cOperacao) + "|" + ;
                     ALLTRIM(STR(THIS.this_nOperacaoI, 10)) + "|" + ;
                     ALLTRIM(STR(THIS.this_nOperacaoF, 10)) + "|" + ;
                     ALLTRIM(THIS.this_cContaO) + "|" + ;
                     ALLTRIM(THIS.this_cContaD) + "|" + ;
                     ALLTRIM(THIS.this_cGrOrigem) + "|" + ;
                     ALLTRIM(THIS.this_cGrDestino) + "|" + ;
                     ALLTRIM(STR(THIS.this_nOP, 10)) + "|" + ;
                     ALLTRIM(STR(THIS.this_nTipo, 2))
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio na auditoria
    * par_cOperacao: "VISUALIZAR" ou "IMPRIMIR"
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cChave, loc_cUsuario
        LOCAL loc_cOperacao, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cOperacao = IIF(EMPTY(par_cOperacao), "EXECUTAR", UPPER(ALLTRIM(par_cOperacao)))

            loc_cChave    = THIS.ObterChavePrimaria()
            loc_cUsuario  = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                                gc_4c_UsuarioLogado, "SYSTEM")

            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, Chave, Usuario, DataHora)" + ;
                       " VALUES (" + EscaparSQL("SIGRECPM") + ", " + ;
                       EscaparSQL(loc_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", GETDATE())"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar auditoria do relat" + ;
                                          CHR(243) + "rio"
            ENDIF
        CATCH TO loc_oErro
            *-- Auditoria nunca deve interromper o relatorio; apenas registra erro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

