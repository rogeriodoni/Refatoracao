# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05c_validarCompilacao
- Tentativa: 2/10
- Mensagem: C:\4c\projeto\app\classes\SIGRECMVBO.prg: loc_cChave = PADR(ALLTRIM((loc_cCursor)->Cpros), 14) +  PADL(THIS.this_cMes, 2, "0") +  PADL(THIS.this_cAno, 4, "0")
Error in line 751: Function name is missing ).


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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGRECMV.prg):
*==============================================================================
* FORMSIGRECMV.PRG
* Formulario de Relatorio: CMV - Custo Medio de Venda
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGRECMV.SCX (frmrelatorio)
*
* Filtros (Page1 - Filtros):
*   Periodo: Mes (MM) / Ano (AAAA)
*   Moeda: codigo + descricao (SigCdMoe.CMoes / DMoes)
*   Finalizacao da producao: operacao (SigCdOpe.dopes)
*   Custo geral:
*     Grupo: codigo + descricao (SigCdGcr.codigos / descrs)
*     Conta: codigo + descricao (SigCdCli.iclis / rclis)
*
* Posicoes: Page1.Top = Form.Top_original - PageFrame.Top(85)
*==============================================================================

DEFINE CLASS FormSIGRECMV AS FormBase

    *-- Dimensoes exatas do original: Width=800, Height=400
    Height      = 400
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
    * InicializarForm - Cria estrutura visual e instancia BO
    *   1. Caption / Picture (fundo)
    *   2. Cria SIGRECMVBO e carrega dados iniciais (pula em modo UI)
    *   3. Monta cabecalho + PageFrame + controles de filtro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.Caption = "CMV - Custo M" + CHR(233) + "dio de Venda"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("SIGRECMVBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGRECMVBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            *-- Carrega operacoes CMV e config padrao PAC (pula em modo validacao UI)
            IF loc_lContinuar AND ;
               (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                IF !THIS.this_oRelatorio.CarregarDadosIniciais()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao Inicializar")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarPageFrame()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.LimparCampos()
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
    * ConfigurarCabecalho - Container escuro com titulo e cmg_4c_Botoes
    *   cmg_4c_Botoes: 4 botoes Visualizar/Imprimir/Doc.Excel/Sair
    *   Left=527 para form Width=800 (527+273=800, container Width=800)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab, loc_oCmg
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho

        WITH loc_oCab
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
                .Caption   = "CMV - Custo M" + CHR(233) + "dio de Venda"
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
                .Caption   = "CMV - Custo M" + CHR(233) + "dio de Venda"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- CommandGroup com 4 botoes (framework frmrelatorio)
            *   Lefts dos botoes: 5, 71, 137, 203 (incremento 66, Width=65 cada)
            .AddObject("cmg_4c_Botoes", "CommandGroup")
            WITH .cmg_4c_Botoes
                .Top           = 0
                .Left          = 527
                .Width         = THIS.Width
                .Height        = 80
                .ButtonCount   = 4
                .BackStyle     = 0
                .BorderColor   = RGB(136, 189, 188)
                .SpecialEffect = 1
                .Themes        = .F.
                .Visible       = .T.

                WITH .Buttons(1)
                    .Caption         = "Visualizar"
                    .Top             = 5
                    .Left            = 5
                    .Width           = THIS.Width
                    .Height          = 70
                    .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
                    .PicturePosition = 13
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Themes          = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Caption         = "Imprimir"
                    .Top             = 5
                    .Left            = 71
                    .Width           = THIS.Width
                    .Height          = 70
                    .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
                    .PicturePosition = 13
                    .FontName        = "Comic Sans MS"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Themes          = .F.
                ENDWITH

                WITH .Buttons(3)
                    .Caption         = "Doc. Excel"
                    .Top             = 5
                    .Left            = 137
                    .Width           = THIS.Width
                    .Height          = 70
                    .Picture         = gc_4c_CaminhoIcones + "excel.jpg"
                    .PicturePosition = 13
                    .FontName        = "Comic Sans MS"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Themes          = .F.
                ENDWITH

                WITH .Buttons(4)
                    .Caption         = "Sair"
                    .Top             = 5
                    .Left            = 203
                    .Width           = THIS.Width
                    .Height          = 70
                    .Picture         = gc_4c_CaminhoIcones + "otao_encerrar.jpg"
                    .PicturePosition = 13
                    .Cancel          = .T.
                    .FontName        = "Comic Sans MS"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Themes          = .F.
                ENDWITH
            ENDWITH
        ENDWITH

        loc_oCmg = loc_oCab.cmg_4c_Botoes
        BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(loc_oCmg.Buttons(3), "Click", THIS, "BtnGerarExcelClick")
        BINDEVENT(loc_oCmg.Buttons(4), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina de filtros
    *   Form: Width=800, Height=400
    *   Cabecalho Height=80; PageFrame.Top=85, Height=315
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 1
        loc_oPgf.Top       = 85
        loc_oPgf.Left      = -1
        loc_oPgf.Width     = THIS.Width + 2
        loc_oPgf.Height    = THIS.Height - 85
        loc_oPgf.Tabs      = .F.

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
    * ConfigurarPaginaLista - Controles de filtro na Page1
    *   Posicoes: Page1.Top = Form.Top_original - PageFrame.Top(85)
    *   Secoes: Periodo (Mes/Ano), Moeda, Operacao CMV, Custo Geral (Grupo/Conta)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- ===== PERIODO: Mes / Ano (orig top=131/128 -> pg top=46/43) =====

        loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPagina.lbl_4c_Periodo
            .Top       = 46
            .Left      = 199
            .Width     = 28
            .Height    = 18
            .Caption   = "M" + CHR(234) + "s :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Mes", "TextBox")
        WITH loc_oPagina.txt_4c_Mes
            .Top           = 43
            .Left          = 231
            .Width         = 24
            .Height        = 21
            .Value         = ""
            .MaxLength     = 2
            .InputMask     = "99"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Mes, "KeyPress", THIS, "TeclaMes")

        loc_oPagina.AddObject("lbl_4c_PeriodoA", "Label")
        WITH loc_oPagina.lbl_4c_PeriodoA
            .Top       = 45
            .Left      = 267
            .Width     = 28
            .Height    = 18
            .Caption   = "Ano :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Ano", "TextBox")
        WITH loc_oPagina.txt_4c_Ano
            .Top           = 43
            .Left          = 298
            .Width         = 38
            .Height        = 21
            .Value         = ""
            .MaxLength     = 4
            .InputMask     = "9999"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH

        *-- ===== MOEDA: Codigo + Descricao (orig top=162/159 -> pg top=77/74) =====

        loc_oPagina.AddObject("lbl_4c_Moeda", "Label")
        WITH loc_oPagina.lbl_4c_Moeda
            .Top       = 77
            .Left      = 183
            .Width     = 44
            .Height    = 15
            .Caption   = "Moeda : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CdMoeda", "TextBox")
        WITH loc_oPagina.txt_4c_CdMoeda
            .Top           = 74
            .Left          = 231
            .Width         = 31
            .Height        = 21
            .Value         = ""
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CdMoeda, "KeyPress", THIS, "TeclaCdMoeda")
        BINDEVENT(loc_oPagina.txt_4c_CdMoeda, "DblClick", THIS, "CdMoedaDblClick")

        loc_oPagina.AddObject("txt_4c_DsMoeda", "TextBox")
        WITH loc_oPagina.txt_4c_DsMoeda
            .Top           = 74
            .Left          = 264
            .Width         = 115
            .Height        = 21
            .Value         = ""
            .MaxLength     = 60
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DsMoeda, "KeyPress", THIS, "TeclaDsMoeda")
        BINDEVENT(loc_oPagina.txt_4c_DsMoeda, "DblClick", THIS, "DsMoedaDblClick")

        *-- ===== SHAPE2: Finalizacao da producao (orig top=197 -> pg top=112) =====

        loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oPagina.shp_4c_Shape2
            .Top     = 112
            .Left    = 175
            .Width   = 246
            .Height  = 49
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Top       = 115
            .Left      = 182
            .Width     = 137
            .Height    = 18
            .Caption   = "Finaliza" + CHR(231) + CHR(227) + "o da produ" + CHR(231) + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Dopes", "Label")
        WITH loc_oPagina.lbl_4c_Dopes
            .Top       = 138
            .Left      = 194
            .Width     = 56
            .Height    = 18
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_NmOperacao", "TextBox")
        WITH loc_oPagina.txt_4c_NmOperacao
            .Top           = 135
            .Left          = 260
            .Width         = 150
            .Height        = 21
            .Value         = ""
            .MaxLength     = 20
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_NmOperacao, "KeyPress", THIS, "TeclaNmOperacao")
        BINDEVENT(loc_oPagina.txt_4c_NmOperacao, "DblClick", THIS, "NmOperacaoDblClick")

        *-- ===== SHAPE1: Custo geral (orig top=259 -> pg top=174) =====

        loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPagina.shp_4c_Shape1
            .Top     = 174
            .Left    = 174
            .Width   = 481
            .Height  = 72
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Top       = 177
            .Left      = 181
            .Width     = 66
            .Height    = 18
            .Caption   = "Custo geral"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Grupo custo: codigo (orig top=281 -> pg top=196) + descricao (mesma linha)

        loc_oPagina.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPagina.lbl_4c_Label15
            .Top       = 199
            .Left      = 214
            .Width     = 38
            .Height    = 18
            .Caption   = "Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_GrupoMov", "TextBox")
        WITH loc_oPagina.txt_4c_GrupoMov
            .Top           = 196
            .Left          = 260
            .Width         = 80
            .Height        = 21
            .Value         = ""
            .MaxLength     = 20
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_GrupoMov, "KeyPress", THIS, "TeclaGrupoMov")
        BINDEVENT(loc_oPagina.txt_4c_GrupoMov, "DblClick", THIS, "GrupoMovDblClick")

        loc_oPagina.AddObject("txt_4c_DGrupoMov", "TextBox")
        WITH loc_oPagina.txt_4c_DGrupoMov
            .Top           = 196
            .Left          = 342
            .Width         = 304
            .Height        = 21
            .Value         = ""
            .MaxLength     = 60
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(230, 230, 230)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DGrupoMov, "DblClick", THIS, "DGrupoMovDblClick")

        *-- Conta estoque: codigo (orig top=304 -> pg top=219) + descricao

        loc_oPagina.AddObject("lbl_4c_Estoque", "Label")
        WITH loc_oPagina.lbl_4c_Estoque
            .Top       = 222
            .Left      = 215
            .Width     = 38
            .Height    = 18
            .Caption   = "Conta :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CdEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_CdEstoque
            .Top           = 219
            .Left          = 260
            .Width         = 80
            .Height        = 21
            .Value         = ""
            .MaxLength     = 20
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CdEstoque, "KeyPress", THIS, "TeclaCdEstoque")
        BINDEVENT(loc_oPagina.txt_4c_CdEstoque, "DblClick", THIS, "CdEstoqueDblClick")

        loc_oPagina.AddObject("txt_4c_DsEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_DsEstoque
            .Top           = 219
            .Left          = 342
            .Width         = 304
            .Height        = 21
            .Value         = ""
            .MaxLength     = 80
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(230, 230, 230)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DsEstoque, "DblClick", THIS, "DsEstoqueDblClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Form REPORT nao tem Page2 de edicao
    *   Chamado por InicializarForm para manter contrato de interface FormBase
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Popula campos com defaults do BO (mes/ano atual,
    *   operacao/grupo/conta da config PAC) apos CarregarDadosIniciais
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg, loc_oErro
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                WITH THIS.this_oRelatorio
                    loc_oPg.txt_4c_Mes.Value        = .this_cMes
                    loc_oPg.txt_4c_Ano.Value        = .this_cAno
                    loc_oPg.txt_4c_NmOperacao.Value = .this_cNmOperacao
                    loc_oPg.txt_4c_GrupoMov.Value   = .this_cGrupoMov
                    loc_oPg.txt_4c_DGrupoMov.Value  = .this_cDGrupoMov
                    loc_oPg.txt_4c_CdEstoque.Value  = .this_cCdEstoque
                    loc_oPg.txt_4c_DsEstoque.Value  = .this_cDsEstoque
                    loc_oPg.txt_4c_CdMoeda.Value    = .this_cCdMoeda
                    loc_oPg.txt_4c_DsMoeda.Value    = .this_cDsMoeda
                ENDWITH
            ELSE
                WITH loc_oPg
                    .txt_4c_Mes.Value        = ""
                    .txt_4c_Ano.Value        = ""
                    .txt_4c_NmOperacao.Value = ""
                    .txt_4c_GrupoMov.Value   = ""
                    .txt_4c_DGrupoMov.Value  = ""
                    .txt_4c_CdEstoque.Value  = ""
                    .txt_4c_DsEstoque.Value  = ""
                    .txt_4c_CdMoeda.Value    = ""
                    .txt_4c_DsMoeda.Value    = ""
                ENDWITH
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia filtros do form para as propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg, loc_oErro
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                .this_cMes        = ALLTRIM(loc_oPg.txt_4c_Mes.Value)
                .this_cAno        = ALLTRIM(loc_oPg.txt_4c_Ano.Value)
                .this_cNmOperacao = ALLTRIM(loc_oPg.txt_4c_NmOperacao.Value)
                .this_cGrupoMov   = ALLTRIM(loc_oPg.txt_4c_GrupoMov.Value)
                .this_cDGrupoMov  = ALLTRIM(loc_oPg.txt_4c_DGrupoMov.Value)
                .this_cCdEstoque  = ALLTRIM(loc_oPg.txt_4c_CdEstoque.Value)
                .this_cDsEstoque  = ALLTRIM(loc_oPg.txt_4c_DsEstoque.Value)
                .this_cCdMoeda    = ALLTRIM(loc_oPg.txt_4c_CdMoeda.Value)
                .this_cDsMoeda    = ALLTRIM(loc_oPg.txt_4c_DsMoeda.Value)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em FormParaRelatorio")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltrosForm - Valida campos obrigatorios (equivalente ao Click
    *   handler do cmg original: mes+ano+operacao+grupo+conta+moeda)
    *   Retorna .T. se todos os campos obrigatorios estao preenchidos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltrosForm()
        LOCAL loc_oPg, loc_lOK
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        loc_lOK = .T.

        IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Mes.Value)) OR ;
           EMPTY(ALLTRIM(loc_oPg.txt_4c_Ano.Value))
            MsgAviso("M" + CHR(234) + "s e Ano s" + CHR(227) + ;
                     "o obrigat" + CHR(243) + "rios.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_Mes.SetFocus()
            loc_lOK = .F.
        ENDIF

        IF loc_lOK AND EMPTY(ALLTRIM(loc_oPg.txt_4c_NmOperacao.Value))
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o de finaliza" + CHR(231) + ;
                     CHR(227) + "o da produ" + CHR(231) + CHR(227) + "o " + ;
                     CHR(233) + " obrigat" + CHR(243) + "ria.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_NmOperacao.SetFocus()
            loc_lOK = .F.
        ENDIF

        IF loc_lOK AND (EMPTY(ALLTRIM(loc_oPg.txt_4c_GrupoMov.Value)) OR ;
                        EMPTY(ALLTRIM(loc_oPg.txt_4c_CdEstoque.Value)))
            MsgAviso("Grupo e conta do custo da produ" + CHR(231) + CHR(227) + ;
                     "o s" + CHR(227) + "o obrigat" + CHR(243) + "rios.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_lOK = .F.
        ENDIF

        IF loc_lOK AND EMPTY(ALLTRIM(loc_oPg.txt_4c_CdMoeda.Value))
            MsgAviso("Moeda de convers" + CHR(227) + "o " + CHR(233) + ;
                     " obrigat" + CHR(243) + "ria.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_lOK = .F.
        ENDIF

        RETURN loc_lOK
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do relatorio (calcula CMV + REPORT PREVIEW)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            IF THIS.ValidarFiltrosForm()
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Visualizar()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao Visualizar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime direto (calcula CMV + REPORT TO PRINTER)
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oErro
        TRY
            IF THIS.ValidarFiltrosForm()
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Imprimir()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao Imprimir")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnGerarExcelClick - Imprime com dialogo de configuracao de impressora
    *   (equivalente a: Report Form SigReCmv NoConsole To PRINTER Prompt)
    *--------------------------------------------------------------------------
    PROCEDURE BtnGerarExcelClick()
        LOCAL loc_oErro
        TRY
            IF THIS.ValidarFiltrosForm()
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.ImprimirComDialogo()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao Imprimir")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Fecha o formulario (ESC via Buttons(4).Cancel=.T.)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    *  ALIASES DA INTERFACE GENERICA FormBase (CRUD nao aplicavel em REPORT)
    *==========================================================================

    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        THIS.LimparCampos()
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_Mes", 5)
                THIS.pgf_4c_Paginas.Page1.txt_4c_Mes.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROCEDURE BtnConsultarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO / BOParaForm - Aliases genericos da interface FormBase
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos de filtro editaveis
    *   Campos de descricao (DGrupoMov/DsEstoque/DsMoeda) permanecem ReadOnly
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lHab, loc_oErro
        TRY
            loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O"
                IF PEMSTATUS(loc_oPg, "txt_4c_Mes", 5)
                    loc_oPg.txt_4c_Mes.ReadOnly        = !loc_lHab
                    loc_oPg.txt_4c_Ano.ReadOnly        = !loc_lHab
                    loc_oPg.txt_4c_NmOperacao.ReadOnly = !loc_lHab
                    loc_oPg.txt_4c_GrupoMov.ReadOnly   = !loc_lHab
                    loc_oPg.txt_4c_CdEstoque.ReadOnly  = !loc_lHab
                    loc_oPg.txt_4c_CdMoeda.ReadOnly    = !loc_lHab
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Stub de compatibilidade (REPORT nao tem grid CRUD)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Todos os botoes permanecem habilitados em REPORT
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCmg, loc_oErro, loc_nI
        TRY
            IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O" AND ;
               PEMSTATUS(THIS.cnt_4c_Cabecalho, "cmg_4c_Botoes", 5)
                loc_oCmg = THIS.cnt_4c_Cabecalho.cmg_4c_Botoes
                FOR loc_nI = 1 TO loc_oCmg.ButtonCount
                    loc_oCmg.Buttons(loc_nI).Enabled = .T.
                ENDFOR
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Form REPORT tem apenas Page1; foca o primeiro filtro
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_oErro
        TRY
            THIS.pgf_4c_Paginas.Visible = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_Mes", 5)
                THIS.pgf_4c_Paginas.Page1.txt_4c_Mes.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Alternar P" + CHR(225) + "gina")
        ENDTRY
    ENDPROC

    *==========================================================================
    *  HANDLERS DE TECLADO (vinculados via BINDEVENT em ConfigurarPaginaLista)
    *==========================================================================

    *--------------------------------------------------------------------------
    * TeclaMes - KeyPress em txt_4c_Mes
    *   ENTER(13)/TAB(9): valida mes (1-12)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaMes(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMes()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaNmOperacao - KeyPress em txt_4c_NmOperacao
    *   F4(115): abre lookup de operacoes CMV (crSigCdOpe em memoria)
    *   ENTER(13)/TAB(9): valida valor digitado contra crSigCdOpe
    *--------------------------------------------------------------------------
    PROCEDURE TeclaNmOperacao(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaNmOperacao()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarNmOperacao()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaGrupoMov - KeyPress em txt_4c_GrupoMov
    *   F4(115): abre lookup de grupos (SigCdGcr)
    *   ENTER(13)/TAB(9): valida codigo e preenche descricao
    *--------------------------------------------------------------------------
    PROCEDURE TeclaGrupoMov(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrupoMov()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarGrupoMov()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdEstoque - KeyPress em txt_4c_CdEstoque
    *   F4(115): abre lookup de contas (SigCdCli)
    *   ENTER(13)/TAB(9): valida codigo e preenche descricao
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdEstoque(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdEstoque()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEstoque()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdMoeda - KeyPress em txt_4c_CdMoeda
    *   F4(115): abre lookup de moedas (SigCdMoe)
    *   ENTER(13)/TAB(9): valida codigo e preenche descricao
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdMoeda(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdMoeda()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdMoeda()
        ENDIF
    ENDPROC

    *==========================================================================
    *  METODOS DE VALIDACAO (chamados pelos handlers de teclado)
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarMes - Verifica se mes esta no intervalo 1-12
    *   Original: get_mes.Valid: If Val(this.Value) > 12 -> MessageBox + limpar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarMes()
        LOCAL loc_nMes
        loc_nMes = VAL(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Mes.Value))
        IF loc_nMes < 1 OR loc_nMes > 12
            MsgAviso("M" + CHR(234) + "s inv" + CHR(225) + "lido.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            THIS.pgf_4c_Paginas.Page1.txt_4c_Mes.Value = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarNmOperacao - Valida operacao digitada contra cursor crSigCdOpe
    *   Se nao encontrar, abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE ValidarNmOperacao()
        LOCAL loc_cValor, loc_lEncontrou, loc_oErro
        loc_cValor    = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_NmOperacao.Value)
        loc_lEncontrou = .F.

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        TRY
            IF USED("crSigCdOpe")
                SELECT crSigCdOpe
                LOCATE FOR ALLTRIM(dopes) = loc_cValor
                loc_lEncontrou = FOUND()
            ENDIF
            IF !loc_lEncontrou
                THIS.pgf_4c_Paginas.Page1.txt_4c_NmOperacao.Value = ""
                THIS.AbrirBuscaNmOperacao()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, ;
                    "Erro ao Validar Opera" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupoMov - Valida codigo do grupo em SigCdGcr e preenche descricao
    *   Original: getGrupoMov.Valid: fAcessoContab('C', valor, gmov, dgmov)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupoMov()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_lEncontrou, loc_oErro
        loc_cValor    = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_GrupoMov.Value)
        loc_lEncontrou = .F.

        IF EMPTY(loc_cValor)
            THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupoMov.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr " + ;
                       "WHERE codigos = " + EscaparSQL(loc_cValor)
            loc_nResult   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruVal")
            loc_lEncontrou = loc_nResult > 0 AND RECCOUNT("cursor_4c_GruVal") > 0
            IF loc_lEncontrou
                SELECT cursor_4c_GruVal
                THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupoMov.Value = ;
                    ALLTRIM(NVL(descrs, ""))
            ELSE
                THIS.pgf_4c_Paginas.Page1.txt_4c_GrupoMov.Value  = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupoMov.Value = ""
                THIS.AbrirBuscaGrupoMov()
            ENDIF
            IF USED("cursor_4c_GruVal")
                USE IN cursor_4c_GruVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Validar Grupo")
            IF USED("cursor_4c_GruVal")
                USE IN cursor_4c_GruVal
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdEstoque - Valida conta estoque em SigCdCli e preenche descricao
    *   Original: getCdEstoque.Valid: fAcessoContas('C', valor, cdest, dsest)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdEstoque()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_lEncontrou, loc_oErro
        loc_cValor    = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value)
        loc_lEncontrou = .F.

        IF EMPTY(loc_cValor)
            THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 iclis, rclis FROM SigCdCli " + ;
                       "WHERE iclis = " + EscaparSQL(loc_cValor)
            loc_nResult   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstVal")
            loc_lEncontrou = loc_nResult > 0 AND RECCOUNT("cursor_4c_EstVal") > 0
            IF loc_lEncontrou
                SELECT cursor_4c_EstVal
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = ;
                    ALLTRIM(NVL(rclis, ""))
            ELSE
                THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = ""
                THIS.AbrirBuscaCdEstoque()
            ENDIF
            IF USED("cursor_4c_EstVal")
                USE IN cursor_4c_EstVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Validar Conta Estoque")
            IF USED("cursor_4c_EstVal")
                USE IN cursor_4c_EstVal
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdMoeda - Valida codigo da moeda em SigCdMoe e preenche descricao
    *   Original: get_cd_moeda.Valid: fwBuscaExt SigCdMoe CMoes/DMoes
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdMoeda()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_lEncontrou, loc_oErro
        loc_cValor    = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value)
        loc_lEncontrou = .F.

        IF EMPTY(loc_cValor)
            THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe " + ;
                       "WHERE CMoes = " + EscaparSQL(loc_cValor)
            loc_nResult   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal")
            loc_lEncontrou = loc_nResult > 0 AND RECCOUNT("cursor_4c_MoeVal") > 0
            IF loc_lEncontrou
                SELECT cursor_4c_MoeVal
                THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ;
                    ALLTRIM(NVL(CMoes, ""))
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ;
                    ALLTRIM(NVL(DMoes, ""))
            ELSE
                THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ""
                THIS.AbrirBuscaCdMoeda()
            ENDIF
            IF USED("cursor_4c_MoeVal")
                USE IN cursor_4c_MoeVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Validar Moeda")
            IF USED("cursor_4c_MoeVal")
                USE IN cursor_4c_MoeVal
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    *  METODOS DE LOOKUP (abrem FormBuscaAuxiliar)
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirBuscaNmOperacao - Lookup de operacoes CMV a partir de crSigCdOpe
    *   Cursor carregado por SIGRECMVBO.CarregarDadosIniciais (filtro SigCdTom)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaNmOperacao()
        LOCAL loc_oBusca, loc_oPg, loc_oErro, loc_lContinuar
        loc_oPg        = THIS.pgf_4c_Paginas.Page1
        loc_lContinuar = .T.

        TRY
            IF !USED("crSigCdOpe")
                MsgErro("Opera" + CHR(231) + CHR(245) + "es CMV n" + CHR(227) + ;
                        "o carregadas.", "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "crSigCdOpe"
                    loc_oBusca.this_cTitulo = "Selecionar Opera" + CHR(231) + ;
                                              CHR(227) + "o CMV"
                    loc_oBusca.mAddColuna("dopes", "", ;
                        "Opera" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("crSigCdOpe")
                        SELECT crSigCdOpe
                        loc_oPg.txt_4c_NmOperacao.Value = ALLTRIM(dopes)
                    ENDIF
                    loc_oBusca.Release()
                ELSE
                    MsgErro("Erro ao criar janela de busca.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, ;
                    "Erro ao Buscar Opera" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGrupoMov - Lookup de grupos de custo (SigCdGcr)
    *   Original: getGrupoMov via fAcessoContab
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaGrupoMov()
        LOCAL loc_oBusca, loc_oPg, loc_cSQL, loc_nResult, loc_oErro
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruBusca")

            IF loc_nResult > 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_GruBusca"
                    loc_oBusca.this_cTitulo = "Selecionar Grupo de Custo"
                    loc_oBusca.mAddColuna("codigos", "", ;
                        "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs", "", ;
                        "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GruBusca")
                        SELECT cursor_4c_GruBusca
                        loc_oPg.txt_4c_GrupoMov.Value  = ALLTRIM(codigos)
                        loc_oPg.txt_4c_DGrupoMov.Value = ALLTRIM(descrs)
                    ENDIF
                    loc_oBusca.Release()
                ELSE
                    MsgErro("Erro ao criar janela de busca.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao buscar grupos de custo.", "Erro")
            ENDIF

            IF USED("cursor_4c_GruBusca")
                USE IN cursor_4c_GruBusca
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Buscar Grupo")
            IF USED("cursor_4c_GruBusca")
                USE IN cursor_4c_GruBusca
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCdEstoque - Lookup de contas de estoque (SigCdCli)
    *   Original: getCdEstoque via fAcessoContas
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCdEstoque()
        LOCAL loc_oBusca, loc_oPg, loc_cSQL, loc_nResult, loc_oErro
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        TRY
            loc_cSQL = "SELECT iclis, rclis FROM SigCdCli ORDER BY iclis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstBusca")

            IF loc_nResult > 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_EstBusca"
                    loc_oBusca.this_cTitulo = "Selecionar Conta de Estoque"
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("rclis", "", ;
                        "Nome/Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_EstBusca")
                        SELECT cursor_4c_EstBusca
                        loc_oPg.txt_4c_CdEstoque.Value = ALLTRIM(iclis)
                        loc_oPg.txt_4c_DsEstoque.Value = ALLTRIM(rclis)
                    ENDIF
                    loc_oBusca.Release()
                ELSE
                    MsgErro("Erro ao criar janela de busca.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao buscar contas de estoque.", "Erro")
            ENDIF

            IF USED("cursor_4c_EstBusca")
                USE IN cursor_4c_EstBusca
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Buscar Conta Estoque")
            IF USED("cursor_4c_EstBusca")
                USE IN cursor_4c_EstBusca
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCdMoeda - Lookup de moedas (SigCdMoe)
    *   Original: get_cd_moeda.Valid / get_ds_moeda.Valid: fwBuscaExt SigCdMoe
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCdMoeda()
        LOCAL loc_oBusca, loc_oPg, loc_cSQL, loc_nResult, loc_oErro
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        TRY
            loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeBusca")

            IF loc_nResult > 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_MoeBusca"
                    loc_oBusca.this_cTitulo = "Selecionar Moeda"
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DMoes", "", ;
                        "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_MoeBusca")
                        SELECT cursor_4c_MoeBusca
                        loc_oPg.txt_4c_CdMoeda.Value = ALLTRIM(CMoes)
                        loc_oPg.txt_4c_DsMoeda.Value = ALLTRIM(DMoes)
                    ENDIF
                    loc_oBusca.Release()
                ELSE
                    MsgErro("Erro ao criar janela de busca.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao buscar moedas.", "Erro")
            ENDIF

            IF USED("cursor_4c_MoeBusca")
                USE IN cursor_4c_MoeBusca
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Buscar Moeda")
            IF USED("cursor_4c_MoeBusca")
                USE IN cursor_4c_MoeBusca
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    *  HANDLERS DBLCLICK (vinculados via BINDEVENT em ConfigurarPaginaLista)
    *==========================================================================

    *--------------------------------------------------------------------------
    * NmOperacaoDblClick - DblClick em txt_4c_NmOperacao abre busca de operacoes
    *--------------------------------------------------------------------------
    PROCEDURE NmOperacaoDblClick()
        THIS.AbrirBuscaNmOperacao()
    ENDPROC

    *--------------------------------------------------------------------------
    * CdMoedaDblClick - DblClick em txt_4c_CdMoeda abre busca de moedas
    *--------------------------------------------------------------------------
    PROCEDURE CdMoedaDblClick()
        THIS.AbrirBuscaCdMoeda()
    ENDPROC

    *--------------------------------------------------------------------------
    * DsMoedaDblClick - DblClick em txt_4c_DsMoeda abre busca de moedas
    *   (busca pela descricao; equivalente ao original get_ds_moeda.Valid fwBuscaExt)
    *--------------------------------------------------------------------------
    PROCEDURE DsMoedaDblClick()
        THIS.AbrirBuscaCdMoeda()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrupoMovDblClick - DblClick em txt_4c_GrupoMov abre busca de grupos
    *--------------------------------------------------------------------------
    PROCEDURE GrupoMovDblClick()
        THIS.AbrirBuscaGrupoMov()
    ENDPROC

    *--------------------------------------------------------------------------
    * DGrupoMovDblClick - DblClick em txt_4c_DGrupoMov abre busca de grupos
    *--------------------------------------------------------------------------
    PROCEDURE DGrupoMovDblClick()
        THIS.AbrirBuscaGrupoMov()
    ENDPROC

    *--------------------------------------------------------------------------
    * CdEstoqueDblClick - DblClick em txt_4c_CdEstoque abre busca de contas
    *--------------------------------------------------------------------------
    PROCEDURE CdEstoqueDblClick()
        THIS.AbrirBuscaCdEstoque()
    ENDPROC

    *--------------------------------------------------------------------------
    * DsEstoqueDblClick - DblClick em txt_4c_DsEstoque abre busca de contas
    *--------------------------------------------------------------------------
    PROCEDURE DsEstoqueDblClick()
        THIS.AbrirBuscaCdEstoque()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsMoeda - KeyPress em txt_4c_DsMoeda
    *   F4(115): abre lookup de moedas
    *   ENTER(13)/TAB(9): valida descricao digitada contra SigCdMoe
    *   Original: get_ds_moeda.Valid - fwBuscaExt SigCdMoe com campo DMoes
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsMoeda(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdMoeda()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsMoeda - Valida descricao digitada em DsMoeda contra SigCdMoe
    *   Busca por DMoes LIKE valor%; se nao encontrar abre lookup
    *   Original: get_ds_moeda.Valid -> fwBuscaExt 'DMoes' como campo de busca
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsMoeda()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_lEncontrou, loc_oErro
        loc_cValor     = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value)
        loc_lEncontrou = .F.

        IF EMPTY(loc_cValor)
            THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe " + ;
                       "WHERE DMoes LIKE " + EscaparSQL(loc_cValor + "%")
            loc_nResult    = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeDsVal")
            loc_lEncontrou = loc_nResult > 0 AND RECCOUNT("cursor_4c_MoeDsVal") > 0
            IF loc_lEncontrou
                SELECT cursor_4c_MoeDsVal
                THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ;
                    ALLTRIM(NVL(CMoes, ""))
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ;
                    ALLTRIM(NVL(DMoes, ""))
            ELSE
                THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ""
                THIS.AbrirBuscaCdMoeda()
            ENDIF
            IF USED("cursor_4c_MoeDsVal")
                USE IN cursor_4c_MoeDsVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, ;
                    "Erro ao Validar Descri" + CHR(231) + CHR(227) + "o Moeda")
            IF USED("cursor_4c_MoeDsVal")
                USE IN cursor_4c_MoeDsVal
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO (RelatorioBase herda Custom: usar .NULL.)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGRECMVBO.prg):
*==============================================================================
* SIGRECMVBO.PRG
* Business Object para Relatorio CMV - Custo Medio de Venda
*
* Herda de: RelatorioBase
* Tabela: SigCdCmv
* Chave: pkchaves = PADR(cpros,14) + PADL(mes,2,'0') + PADL(ano,4,'0')
* Relatorio: SigReCmv.frx
*==============================================================================

DEFINE CLASS SIGRECMVBO AS RelatorioBase

    *-- Identificacao
    this_cTabela        = "SigCdCmv"
    this_cCampoChave    = "pkchaves"
    this_cMensagemErro  = ""

    *-- Filtros do formulario
    this_cMes           = ""    && Mes do calculo (formato "MM")
    this_cAno           = ""    && Ano do calculo (formato "YYYY")
    this_cNmOperacao    = ""    && Codigo da operacao de finalizacao da producao
    this_cGrupoMov      = ""    && Codigo do grupo de custo - credito (SigCdGcr.codigos)
    this_cDGrupoMov     = ""    && Descricao do grupo de custo - debito (SigCdGcr.descrs)
    this_cCdEstoque     = ""    && Codigo da conta de estoque (SigCdCli.iclis)
    this_cDsEstoque     = ""    && Descricao da conta de estoque (SigCdCli.rclis)
    this_cCdMoeda       = ""    && Codigo da moeda de conversao (SigCdMoe.CMoes)
    this_cDsMoeda       = ""    && Descricao da moeda (SigCdMoe.DMoes)

    *-- Valores calculados durante o processamento
    this_nCustoGrama    = 0     && Custo por grama produzida (lnCusGr no legado)
    this_nTotalCusto    = 0     && Total do custo de producao no periodo
    this_nTotalPeso     = 0     && Total do peso dos itens produzidos
    this_nTotalQtd      = 0     && Total de quantidade dos itens produzidos

    *-- Propriedades de registro SigCdCmv (CRUD individual)
    this_cPkChaves      = ""    && Chave primaria (cpros+mes+ano)
    this_cCpros         = ""    && Codigo do produto
    this_cDatas         = ""    && Periodo "MM/AAAA"
    this_cMoedas        = ""    && Codigo da moeda
    this_nValCuss       = 0     && Valor do custo unitario

    *-- Cursores de trabalho
    this_cCursorDados   = "crVenda"      && Cursor principal para o relatorio
    this_cCursorOpe     = "crSigCdOpe"   && Operacoes CMV filtradas
    this_cCursorPac     = "crSigCdPac"   && Configuracao padrao PAC
    this_cCursorCmv     = "crSigCdCmv"   && Cursor para gravacao em SigCdCmv

    *-- Configuracao do relatorio
    this_cCaminhoFRX    = ""
    this_cTitulo        = ""

    *--------------------------------------------------------------------------
    * Init - Configura titulo e caminho FRX
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTitulo     = "CMV - Custo da Mercadoria Vendida"
            THIS.this_cCaminhoFRX = gc_4c_CaminhoReports + "SigReCmv.frx"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosIniciais - Carrega cursores SigCdOpe/SigCdPac e define
    * valores default para os campos do formulario nas propriedades this_*
    * Retorna .T. se sucesso, .F. se erro
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosIniciais()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                *-- Carrega operacoes CMV (SigCdOpe filtrada por SigCdTom)
                loc_cSQL = "SELECT a.dopes FROM SigCdOpe a " + ;
                           "INNER JOIN SigCdTom b ON a.TipoOps = b.Codigos " + ;
                           "WHERE b.GeraCmvs = 1 AND a.vendas = 1 " + ;
                           "AND a.caixas = 1 AND a.copers = 1"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOpe)
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao carregar opera" + CHR(231) + CHR(245) + "es CMV"
                    EXIT
                ENDIF

                *-- Carrega configuracao padrao PAC
                loc_cSQL = "SELECT GruCmvs, ConCmvs, OpeCmvs FROM SigCdPac"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorPac)
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao carregar configura" + CHR(231) + CHR(227) + CHR(227) + "o PAC"
                    EXIT
                ENDIF

                *-- Mes/ano atual como default
                THIS.this_cMes = PADL(MONTH(DATE()), 2, "0")
                THIS.this_cAno = PADL(YEAR(DATE()), 4, "0")

                *-- Preenche defaults da configuracao PAC
                SELECT (THIS.this_cCursorPac)
                IF !EOF()
                    THIS.this_cNmOperacao = ALLTRIM(NVL(OpeCmvs, ""))
                    THIS.this_cGrupoMov   = ALLTRIM(NVL(GruCmvs, ""))
                    THIS.this_cCdEstoque  = ALLTRIM(NVL(ConCmvs, ""))
                ENDIF

                *-- Busca descricao do grupo de custo (SigCdGcr)
                IF !EMPTY(THIS.this_cGrupoMov)
                    loc_cSQL = "SELECT TOP 1 descrs FROM SigCdGcr WHERE codigos = " + ;
                               EscaparSQL(THIS.this_cGrupoMov)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruDescr")
                    IF loc_nResult > 0
                        SELECT cursor_4c_GruDescr
                        IF !EOF()
                            THIS.this_cDGrupoMov = ALLTRIM(NVL(descrs, ""))
                        ENDIF
                        USE IN cursor_4c_GruDescr
                    ENDIF
                ENDIF

                *-- Busca descricao da conta de estoque (SigCdCli)
                IF !EMPTY(THIS.this_cCdEstoque)
                    loc_cSQL = "SELECT TOP 1 rclis FROM SigCdCli WHERE iclis = " + ;
                               EscaparSQL(THIS.this_cCdEstoque)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContDescr")
                    IF loc_nResult > 0
                        SELECT cursor_4c_ContDescr
                        IF !EOF()
                            THIS.this_cDsEstoque = ALLTRIM(NVL(rclis, ""))
                        ENDIF
                        USE IN cursor_4c_ContDescr
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida campos obrigatorios antes do processamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_lOK
        loc_lOK = .T.

        IF EMPTY(THIS.this_cMes) OR EMPTY(THIS.this_cAno)
            THIS.this_cMensagemErro = "M" + CHR(234) + "s e Ano s" + CHR(227) + "o obrigat" + CHR(243) + "rios."
            loc_lOK = .F.
        ENDIF
        IF loc_lOK AND EMPTY(THIS.this_cNmOperacao)
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de finaliza" + CHR(231) + CHR(227) + "o da produ" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria."
            loc_lOK = .F.
        ENDIF
        IF loc_lOK AND (EMPTY(THIS.this_cGrupoMov) OR EMPTY(THIS.this_cCdEstoque))
            THIS.this_cMensagemErro = "Grupo e conta do custo da produ" + CHR(231) + CHR(227) + "o s" + CHR(227) + "o obrigat" + CHR(243) + "rios."
            loc_lOK = .F.
        ENDIF
        IF loc_lOK AND EMPTY(THIS.this_cCdMoeda)
            THIS.this_cMensagemErro = "Moeda de convers" + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria."
            loc_lOK = .F.
        ENDIF

        RETURN loc_lOK
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacao - Busca cotacao da moeda para a data especificada
    * par_cMoeda: codigo da moeda (SigCdCot.cmoes)
    * par_dData:  data de referencia
    * Retorna: valor numerico da cotacao (1.0 se nao encontrada)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarCotacao(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cSQL, loc_nResult
        loc_nCotacao = 1

        IF EMPTY(par_cMoeda) OR VARTYPE(par_dData) != "D" OR EMPTY(par_dData)
            RETURN 1
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 valos FROM SigCdCot " + ;
                       "WHERE cmoes = " + EscaparSQL(par_cMoeda) + ;
                       " AND datas <= " + FormatarDataSQL(par_dData) + ;
                       " ORDER BY datas DESC"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cotacao")
            IF loc_nResult > 0
                SELECT cursor_4c_Cotacao
                IF !EOF()
                    loc_nCotacao = NVL(valos, 1)
                    IF loc_nCotacao = 0
                        loc_nCotacao = 1
                    ENDIF
                ENDIF
                USE IN cursor_4c_Cotacao
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nCotacao
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Calcula CMV (Custo da Mercadoria Vendida)
    * Reproduz a logica do PROCEDURE processamento do legado
    * Gera cursores crVenda e crCabec para o REPORT FORM
    * Grava em SigCdCmv se usuario confirmar
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cOpeFinal, loc_cGrupo, loc_cConta, loc_cMoeda
        LOCAL loc_nMes, loc_dDtIni, loc_dDtFin, loc_cDtIniSQL, loc_cDtFinSQL
        LOCAL loc_nCotaOpera, loc_lGrava
        LOCAL loc_nSal, loc_cGCM, loc_cMoeOpe, loc_nValor, loc_nCota
        LOCAL loc_nTotCusto, loc_nCusGr
        LOCAL loc_cDopes, loc_nCusto, loc_cMesAtual, loc_cMesItem, loc_cChave
        LOCAL loc_cMesCmvStr, loc_nMesCmv, loc_nAnoCmv, loc_dUltDiaMes
        LOCAL loc_cNmTitulo, loc_cDtPeriodo
        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                IF !THIS.ValidarFiltros()
                    EXIT
                ENDIF

                *-- Captura filtros das propriedades this_*
                loc_cOpeFinal = ALLTRIM(THIS.this_cNmOperacao)
                loc_cGrupo    = ALLTRIM(THIS.this_cGrupoMov)
                loc_cConta    = ALLTRIM(THIS.this_cCdEstoque)
                loc_cMoeda    = ALLTRIM(THIS.this_cCdMoeda)

                *-- Calcula periodo: primeiro e ultimo dia do mes
                loc_nMes   = VAL(THIS.this_cMes)
                loc_dDtIni = DATE(VAL(THIS.this_cAno), loc_nMes, 1)
                IF loc_nMes >= 12
                    loc_dDtFin = DATE(VAL(THIS.this_cAno) + 1, 1, 1) - 1
                ELSE
                    loc_dDtFin = DATE(VAL(THIS.this_cAno), loc_nMes + 1, 1) - 1
                ENDIF
                loc_cDtIniSQL = FormatarDataSQL(loc_dDtIni)
                *-- Data final com 23:59:59 (equivalente a fDtoSQL com hora '23:59:00')
                loc_cDtFinSQL = "'" + PADL(YEAR(loc_dDtFin), 4, "0") + "-" + ;
                                PADL(MONTH(loc_dDtFin), 2, "0") + "-" + ;
                                PADL(DAY(loc_dDtFin), 2, "0") + " 23:59:59'"

                *-- Cotacao da moeda no ultimo dia do mes
                loc_nCotaOpera = THIS.BuscarCotacao(loc_cMoeda, loc_dDtFin)

                *-- Verifica se periodo ja foi calculado
                loc_cSQL = "SELECT DISTINCT valcuss FROM SigCdCmv WHERE datas = " + ;
                           EscaparSQL(PADL(THIS.this_cMes, 2, "0") + "/" + PADL(THIS.this_cAno, 4, "0"))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CustoIte")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao verificar per" + CHR(237) + "odo (CustoIte)"
                    EXIT
                ENDIF

                loc_lGrava = .T.
                SELECT cursor_4c_CustoIte
                IF RECCOUNT("cursor_4c_CustoIte") > 0
                    loc_lGrava = MsgConfirma("Esse per" + CHR(237) + "odo j" + CHR(225) + ;
                                 " foi calculado o CMV. Gravar valor do recalculado?")
                ENDIF
                USE IN cursor_4c_CustoIte

                *-- Busca itens finalizados da producao (somente se operacao informada)
                IF !EMPTY(loc_cOpeFinal)
                    loc_cSQL = "SELECT cpros, qtds, pesos FROM SigMvItn " + ;
                               "WHERE Dopes = " + EscaparSQL(loc_cOpeFinal) + ;
                               " AND DtAlts BETWEEN " + loc_cDtIniSQL + ;
                               " AND " + loc_cDtFinSQL
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Falha ao buscar itens produzidos (crItens)"
                        EXIT
                    ENDIF
                ENDIF

                *-- Cria cursor temporario de acumulacao de custo
                CREATE CURSOR cursor_4c_Custo (Saldos N(11,2))

                *-- Busca saldo do custo de producao (SigMvSlc + SigCdCli)
                loc_cSQL = "SELECT a.Emps, a.Grupos, a.Contas, a.Moedas, a.Saldos, " + ;
                           "b.RClis, b.Situas, b.Cpfs, b.ContaMats, ' ' AS Matriz " + ;
                           "FROM SigMvSlc a, SigCdCli b " + ;
                           "WHERE a.Grupos = " + EscaparSQL(loc_cGrupo) + ;
                           " AND a.Contas = " + EscaparSQL(loc_cConta) + ;
                           " AND a.Contas = b.IClis " + ;
                           "ORDER BY a.Contas, a.Moedas"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Saldo")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao buscar saldo de custo (crSaldo)"
                    EXIT
                ENDIF

                *-- Calcula saldo total convertendo moedas quando necessario
                loc_nSal = 0
                SELECT cursor_4c_Saldo
                SCAN
                    loc_cGCM    = ALLTRIM(cursor_4c_Saldo.Grupos) + ;
                                  ALLTRIM(cursor_4c_Saldo.Contas) + ;
                                  ALLTRIM(cursor_4c_Saldo.Moedas)
                    loc_cMoeOpe = ALLTRIM(cursor_4c_Saldo.Moedas)

                    loc_cSQL = "SELECT a.Saldos, a.Datas, a.Opers FROM SigMvCcr a " + ;
                               "WHERE a.GruConMoes = " + EscaparSQL(loc_cGCM) + ;
                               " AND a.Datas BETWEEN " + loc_cDtIniSQL + ;
                               " AND " + loc_cDtFinSQL
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMcc1")
                    IF loc_nResult > 0
                        SELECT cursor_4c_TmpMcc1
                        SCAN
                            loc_nValor = cursor_4c_TmpMcc1.Saldos
                            IF loc_cMoeOpe <> loc_cMoeda
                                loc_nCota = THIS.BuscarCotacao(loc_cMoeOpe, cursor_4c_TmpMcc1.Datas)
                                IF loc_nCotaOpera <> 0
                                    loc_nValor = loc_nValor * loc_nCota / loc_nCotaOpera
                                ENDIF
                            ENDIF
                            IF ALLTRIM(cursor_4c_TmpMcc1.Opers) = "D"
                                loc_nSal = loc_nSal + ABS(loc_nValor)
                            ELSE
                                loc_nSal = loc_nSal - ABS(loc_nValor)
                            ENDIF
                            SELECT cursor_4c_TmpMcc1
                        ENDSCAN
                        USE IN cursor_4c_TmpMcc1
                    ENDIF

                    SELECT cursor_4c_Saldo
                ENDSCAN
                USE IN cursor_4c_Saldo

                *-- Registra saldo acumulado no cursor de custo
                SELECT cursor_4c_Custo
                INSERT INTO cursor_4c_Custo (Saldos) VALUES (loc_nSal)

                *-- Soma peso e quantidade dos itens produzidos
                IF USED("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0
                    SELECT SUM(Pesos) AS TotPeso, SUM(Qtds) AS TotQtd ;
                        FROM cursor_4c_Itens ;
                        INTO CURSOR cursor_4c_TotItens READWRITE
                ELSE
                    CREATE CURSOR cursor_4c_TotItens (TotPeso N(11,2), TotQtd N(11,2))
                    INSERT INTO cursor_4c_TotItens (TotPeso, TotQtd) VALUES (0, 0)
                ENDIF

                *-- Soma saldo total do custo de producao
                SELECT cursor_4c_Custo
                GO TOP
                SUM Saldos TO loc_nTotCusto

                *-- Calcula preco por grama produzida
                SELECT cursor_4c_TotItens
                IF NVL(cursor_4c_TotItens.TotPeso, 0) = 0 OR loc_nTotCusto = 0
                    MsgAviso("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel calcular " + ;
                        "o Custo do Grama Produzido desse per" + CHR(237) + "odo pois n" + CHR(227) + ;
                        "o teve nenhum produto vendido ou custo de produ" + CHR(231) + CHR(227) + ;
                        "o lan" + CHR(231) + "ada.", "CMV")
                    loc_nCusGr = 0
                ELSE
                    loc_nCusGr = ABS(loc_nTotCusto) / ABS(cursor_4c_TotItens.TotPeso)
                ENDIF

                *-- Salva valores calculados nas propriedades do BO
                THIS.this_nCustoGrama = loc_nCusGr
                THIS.this_nTotalCusto = loc_nTotCusto
                THIS.this_nTotalPeso  = NVL(cursor_4c_TotItens.TotPeso, 0)
                THIS.this_nTotalQtd   = NVL(cursor_4c_TotItens.TotQtd, 0)

                *-- Cria cursor principal do relatorio (crVenda) com estrutura do SigMvItn
                loc_cSQL = "SELECT 0 AS ordem, dopes, cpros, qtds, pesos, " + ;
                           "dtalts AS Datas, 00000000.0000 AS ValCuss, " + ;
                           "00000000.0000 AS TotCuss, '  ' AS MoeCuss " + ;
                           "FROM SigMvItn WHERE 0=1"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao criar cursor de dados (crVenda)"
                    EXIT
                ENDIF

                *-- Linha 1: totais gerais da producao
                SELECT cursor_4c_TotItens
                INSERT INTO (THIS.this_cCursorDados) ;
                    (ordem, qtds, pesos, TotCuss, ValCuss, MoeCuss) ;
                    VALUES (1, NVL(cursor_4c_TotItens.TotQtd, 0), ;
                            NVL(cursor_4c_TotItens.TotPeso, 0), ;
                            ABS(loc_nTotCusto), loc_nCusGr, loc_cMoeda)

                *-- Calcula custo de cada item vendido por operacao CMV
                SELECT (THIS.this_cCursorOpe)
                SCAN
                    loc_cDopes = ALLTRIM(Dopes)

                    loc_cSQL = "SELECT 2 AS ordem, a.dopes, a.cpros, a.qtds, a.pesos, " + ;
                               "b.Datas, 00000000.0000 AS ValCuss, " + ;
                               "00000000.0000 AS TotCuss, '  ' AS MoeCuss " + ;
                               "FROM SigMvItn a " + ;
                               "INNER JOIN sigopetq b ON a.codbarras = b.cbars " + ;
                               "WHERE a.Dopes = " + EscaparSQL(loc_cDopes) + ;
                               " AND a.DtAlts BETWEEN " + loc_cDtIniSQL + ;
                               " AND " + loc_cDtFinSQL
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvItn")
                    IF loc_nResult > 0
                        *-- Calcula custo unitario de cada item
                        SELECT cursor_4c_SigMvItn
                        SCAN
                            loc_nCusto    = loc_nCusGr
                            loc_cMesAtual = PADL(THIS.this_cMes, 2, "0") + PADL(THIS.this_cAno, 4, "0")
                            loc_cMesItem  = PADL(MONTH(cursor_4c_SigMvItn.Datas), 2, "0") + ;
                                            PADL(YEAR(cursor_4c_SigMvItn.Datas), 4, "0")

                            *-- Item de periodo diferente: busca custo historico em SigCdCmv
                            IF loc_cMesAtual <> loc_cMesItem
                                loc_cChave = PADR(ALLTRIM(cursor_4c_SigMvItn.Cpros), 14) + loc_cMesItem
                                loc_cSQL = "SELECT valcuss, moedas, datas FROM SigCdCmv " + ;
                                           "WHERE pkchaves = " + EscaparSQL(loc_cChave)
                                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CustoIteH")
                                IF loc_nResult > 0
                                    SELECT cursor_4c_CustoIteH
                                    IF !EOF()
                                        loc_nCusto = cursor_4c_CustoIteH.valcuss
                                        IF ALLTRIM(cursor_4c_CustoIteH.moedas) <> loc_cMoeda
                                            loc_cMesCmvStr = ALLTRIM(cursor_4c_CustoIteH.datas)
                                            loc_nMesCmv    = VAL(SUBSTR(loc_cMesCmvStr, 1, 2))
                                            loc_nAnoCmv    = VAL(SUBSTR(loc_cMesCmvStr, 4, 4))
                                            IF loc_nMesCmv >= 12
                                                loc_dUltDiaMes = DATE(loc_nAnoCmv + 1, 1, 1) - 1
                                            ELSE
                                                loc_dUltDiaMes = DATE(loc_nAnoCmv, loc_nMesCmv + 1, 1) - 1
                                            ENDIF
                                            loc_nCota = THIS.BuscarCotacao(ALLTRIM(cursor_4c_CustoIteH.moedas), loc_dUltDiaMes)
                                            IF loc_nCotaOpera <> 0
                                                loc_nCusto = loc_nCusto * loc_nCota / loc_nCotaOpera
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                    USE IN cursor_4c_CustoIteH
                                ENDIF
                            ENDIF

                            SELECT cursor_4c_SigMvItn
                            REPLACE ValCuss WITH loc_nCusto, ;
                                    TotCuss WITH NVL(Pesos * loc_nCusto, 0), ;
                                    MoeCuss WITH loc_cMoeda
                            SELECT cursor_4c_SigMvItn
                        ENDSCAN

                        *-- Adiciona itens calculados ao cursor principal do relatorio
                        SELECT cursor_4c_SigMvItn
                        GO TOP
                        SELECT (THIS.this_cCursorDados)
                        APPEND FROM DBF("cursor_4c_SigMvItn")
                        USE IN cursor_4c_SigMvItn
                    ENDIF

                    SELECT (THIS.this_cCursorOpe)
                ENDSCAN

                *-- Grava em SigCdCmv se confirmado e houver itens
                IF loc_lGrava AND USED("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0
                    THIS.RegistrarCMV(loc_nCusGr)
                ENDIF

                *-- Cursor de cabecalho para o relatorio
                loc_cNmTitulo  = "CMV - Custo da Mercadoria Vendida"
                loc_cDtPeriodo = "Per" + CHR(237) + "odo: " + DTOC(loc_dDtIni) + ;
                                 " a " + DTOC(loc_dDtFin)
                CREATE CURSOR crCabec (titulos C(80), titulo2s C(80))
                INSERT INTO crCabec (titulos, titulo2s) VALUES (loc_cNmTitulo, loc_cDtPeriodo)

                *-- Posiciona no cursor de dados para o REPORT FORM
                SELECT (THIS.this_cCursorDados)

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega registro do cursor SigCdCmv nas propriedades
    * par_cAliasCursor: nome do alias/cursor com registro posicionado
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF !EOF() AND !BOF()
                    THIS.this_cPkChaves = ALLTRIM(NVL(pkchaves, ""))
                    THIS.this_cCpros    = ALLTRIM(NVL(cpros, ""))
                    THIS.this_cDatas    = ALLTRIM(NVL(datas, ""))
                    THIS.this_cMoedas   = ALLTRIM(NVL(moedas, ""))
                    THIS.this_nValCuss  = NVL(valcuss, 0)
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigCdCmv com as propriedades this_*
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                IF EMPTY(THIS.this_cPkChaves) OR EMPTY(THIS.this_cCpros) OR ;
                   EMPTY(THIS.this_cDatas) OR EMPTY(THIS.this_cMoedas)
                    THIS.this_cMensagemErro = "Campos obrigat" + CHR(243) + "rios n" + CHR(227) + "o preenchidos"
                    EXIT
                ENDIF

                loc_cSQL = "INSERT INTO SigCdCmv " + ;
                           "(pkchaves, cpros, datas, moedas, valcuss) VALUES (" + ;
                           EscaparSQL(THIS.this_cPkChaves) + ", " + ;
                           EscaparSQL(THIS.this_cCpros) + ", " + ;
                           EscaparSQL(THIS.this_cDatas) + ", " + ;
                           EscaparSQL(THIS.this_cMoedas) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nValCuss, 2) + ;
                           ")"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Falha ao inserir CMV em SigCdCmv"
                    EXIT
                ENDIF

                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigCdCmv com as propriedades this_*
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                IF EMPTY(THIS.this_cPkChaves)
                    THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria n" + CHR(227) + "o informada"
                    EXIT
                ENDIF

                loc_cSQL = "UPDATE SigCdCmv SET " + ;
                           "cpros = "   + EscaparSQL(THIS.this_cCpros) + ", " + ;
                           "datas = "   + EscaparSQL(THIS.this_cDatas) + ", " + ;
                           "moedas = "  + EscaparSQL(THIS.this_cMoedas) + ", " + ;
                           "valcuss = " + FormatarNumeroSQL(THIS.this_nValCuss, 2) + ;
                           " WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Falha ao atualizar CMV em SigCdCmv"
                    EXIT
                ENDIF

                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarCMV - Grava custo calculado em SigCdCmv (INSERT ou UPDATE)
    * par_nCusGr: custo por grama calculado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarCMV(par_nCusGr)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cPkChaves, loc_cDatas, loc_lExiste
        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                loc_cDatas = PADL(THIS.this_cMes, 2, "0") + "/" + PADL(THIS.this_cAno, 4, "0")

                *-- Para cada produto distinto nos itens produzidos
                SELECT DISTINCT cpros FROM cursor_4c_Itens INTO CURSOR cursor_4c_Gravar READWRITE

                SELECT cursor_4c_Gravar
                SCAN
                    loc_cPkChaves = PADR(ALLTRIM(cursor_4c_Gravar.cpros), 14) + ;
                                   PADL(THIS.this_cMes, 2, "0") + ;
                                   PADL(THIS.this_cAno, 4, "0")

                    *-- Verifica se registro ja existe
                    loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdCmv " + ;
                               "WHERE pkchaves = " + EscaparSQL(loc_cPkChaves)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ExisteCmv")
                    loc_lExiste = .F.
                    IF loc_nResult > 0
                        SELECT cursor_4c_ExisteCmv
                        IF !EOF()
                            loc_lExiste = NVL(nExiste, 0) > 0
                        ENDIF
                        USE IN cursor_4c_ExisteCmv
                    ENDIF

                    IF loc_lExiste
                        loc_cSQL = "UPDATE SigCdCmv SET " + ;
                                   "valcuss = " + FormatarNumeroSQL(par_nCusGr, 2) + ", " + ;
                                   "moedas = " + EscaparSQL(ALLTRIM(THIS.this_cCdMoeda)) + ", " + ;
                                   "datas = " + EscaparSQL(loc_cDatas) + ;
                                   " WHERE pkchaves = " + EscaparSQL(loc_cPkChaves)
                    ELSE
                        loc_cSQL = "INSERT INTO SigCdCmv " + ;
                                   "(pkchaves, cpros, valcuss, moedas, datas) VALUES (" + ;
                                   EscaparSQL(loc_cPkChaves) + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Gravar.cpros)) + ", " + ;
                                   FormatarNumeroSQL(par_nCusGr, 2) + ", " + ;
                                   EscaparSQL(ALLTRIM(THIS.this_cCdMoeda)) + ", " + ;
                                   EscaparSQL(loc_cDatas) + ;
                                   ")"
                    ENDIF

                    SQLEXEC(gnConnHandle, loc_cSQL)
                    SELECT cursor_4c_Gravar
                ENDSCAN
                USE IN cursor_4c_Gravar

                THIS.RegistrarAuditoria("GERACMV")
                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cCaminhoFRX) NOCONSOLE TO PRINTER
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirComDialogo - Prepara dados e abre dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirComDialogo()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cCaminhoFRX) NOCONSOLE TO PRINTER PROMPT
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cCaminhoFRX) NOCONSOLE PREVIEW
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna pkchaves do registro corrente
    * Prioridade: this_cPkChaves (setada por CarregarDoCursor/Inserir/Atualizar)
    * Fallback: monta a partir do cursor crVenda + mes/ano correntes
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave, loc_cCursor
        loc_cChave  = ""
        loc_cCursor = THIS.this_cCursorDados
        IF !EMPTY(THIS.this_cPkChaves)
            loc_cChave = ALLTRIM(THIS.this_cPkChaves)
        ELSE
            IF USED(loc_cCursor) AND !EOF(loc_cCursor)
                loc_cChave = PADR(ALLTRIM((loc_cCursor)->Cpros), 14) + ;
                             PADL(THIS.this_cMes, 2, "0") + ;
                             PADL(THIS.this_cAno, 4, "0")
            ENDIF
        ENDIF
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao no log de auditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cChave
        loc_lSucesso = .F.

        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            IF EMPTY(loc_cChave)
                loc_cChave = PADL(THIS.this_cMes, 2, "0") + "/" + PADL(THIS.this_cAno, 4, "0")
            ENDIF

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) VALUES (" + ;
                       EscaparSQL(THIS.this_cTabela) + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")) + ;
                       ", GETDATE())"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED(THIS.this_cCursorOpe)
            USE IN (THIS.this_cCursorOpe)
        ENDIF
        IF USED(THIS.this_cCursorPac)
            USE IN (THIS.this_cCursorPac)
        ENDIF
        IF USED("crCabec")
            USE IN crCabec
        ENDIF
        IF USED("cursor_4c_Itens")
            USE IN cursor_4c_Itens
        ENDIF
        IF USED("cursor_4c_TotItens")
            USE IN cursor_4c_TotItens
        ENDIF
        IF USED("cursor_4c_Custo")
            USE IN cursor_4c_Custo
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

