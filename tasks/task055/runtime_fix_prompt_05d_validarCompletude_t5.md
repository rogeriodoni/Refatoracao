# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 5/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigReCmp.prg] Indicador de pendencia: * OptSituasChange: habilita chkPendente

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReCmp.prg):
*==============================================================================
* FormSigReCmp.prg
* Formulario de Listagem de Composicao Por Movimentacao/OP
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGRECMP.SCX (frmrelatorio)
* Relatorios: SigReCp2.frx (agrupamento=Composicao), SigReCp3.frx (agrupamento=OP)
*==============================================================================

DEFINE CLASS FormSigReCmp AS FormBase

    *-- Dimensoes exatas do original: Width=800, Height=500
    Height      = 500
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

    *-- BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""
    this_cModoAtual    = "FILTROS"

    *==========================================================================
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria estrutura visual e inicializa BO
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.Caption = "Listagem de Composi" + CHR(231) + CHR(227) + ;
                           "o Por Movimenta" + CHR(231) + CHR(227) + "o/OP"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF

            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("SigReCmpBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                THIS.this_cMensagemErro = "Falha ao instanciar SigReCmpBO"
                MsgErro(THIS.this_cMensagemErro + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
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

    *==========================================================================
    * ConfigurarCabecalho - Container cinza escuro com titulo e cmg_4c_Botoes
    *   4 botoes: Visualizar/Imprimir/Excel/Encerrar (frmrelatorio framework)
    *==========================================================================
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
                .Caption   = THIS.Caption
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
                .Caption   = THIS.Caption
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("cmg_4c_Botoes", "CommandGroup")
            WITH .cmg_4c_Botoes
                .Top           = 3
                .Left          = 526
                .Width         = THIS.Width
                .Height        = 76
                .ButtonCount   = 4
                .BackStyle     = 0
                .BorderColor   = RGB(136, 189, 188)
                .SpecialEffect = 1
                .Themes        = .F.
                .Visible       = .T.

                WITH .Buttons(1)
                    .Top             = 2
                    .Left            = 6
                    .Width           = THIS.Width
                    .Height          = 72
                    .Caption         = "Visualizar"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
                    .PicturePosition = 13
                    .Themes          = .F.
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Visible         = .T.
                ENDWITH

                WITH .Buttons(2)
                    .Top             = 2
                    .Left            = 72
                    .Width           = THIS.Width
                    .Height          = 72
                    .Caption         = "Imprimir"
                    .FontName        = "Comic Sans MS"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
                    .PicturePosition = 13
                    .Themes          = .F.
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Visible         = .T.
                ENDWITH

                WITH .Buttons(3)
                    .Top             = 2
                    .Left            = 138
                    .Width           = THIS.Width
                    .Height          = 72
                    .Caption         = "Excel"
                    .FontName        = "Comic Sans MS"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .Picture         = gc_4c_CaminhoIcones + "excel.jpg"
                    .PicturePosition = 13
                    .Themes          = .F.
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Visible         = .T.
                ENDWITH

                WITH .Buttons(4)
                    .Top             = 2
                    .Left            = 204
                    .Width           = THIS.Width
                    .Height          = 72
                    .Caption         = "Encerrar"
                    .Cancel          = .T.
                    .FontName        = "Comic Sans MS"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .Picture         = gc_4c_CaminhoIcones + "otao_encerrar.jpg"
                    .PicturePosition = 13
                    .Themes          = .F.
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Visible         = .T.
                ENDWITH
            ENDWITH
        ENDWITH

        loc_oCmg = loc_oCab.cmg_4c_Botoes
        BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(loc_oCmg.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(loc_oCmg.Buttons(4), "Click", THIS, "BtnSairClick")
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - PageFrame com 1 pagina (Filtros) sem tabs visiveis
    *   PageFrame: Top=85, Left=-1, Width=THIS.Width+2, Height=THIS.Height-85
    *==========================================================================
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

    *==========================================================================
    * ConfigurarPaginaLista - Adiciona TODOS os controles de filtro na Page1:
    *   - Periodo (datas + optData)
    *   - Movimentacao/OP
    *   - Observacao, Empresa
    *   - Grupo Estoque / Conta
    *   - Grande Grupo, Grupo Produto, Subgrupo
    *   - Situacao (optSituas), Agrupamento (optagrupa), checkboxes
    *   - Grid grd_4c_Dados (tipos de movimentacao com checkboxes)
    *   - Botoes SelTudo e Apaga
    * Posicoes: Top original - 85 (PageFrame.Top=85)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid, loc_oErro
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- Inicializar cursor de tipos de movimentacao antes de criar o grid
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.this_oRelatorio.InicializarDados()
                ELSE
                    *-- Modo validacao UI: criar cursor vazio para o grid funcionar
                    IF !USED("cursor_4c_TipoMov")
                        CREATE CURSOR cursor_4c_TipoMov ;
                            (Marca N(1), Descri C(40), Codigos N(2))
                    ENDIF
                ENDIF
            ENDIF

            *-- ===== ROW 1: PERIODO =====
            loc_oPagina.AddObject("lbl_4c_Lbl_periodo", "Label")
            WITH loc_oPagina.lbl_4c_Lbl_periodo
                .Top       = 38
                .Left      = 55
                .Width     = 45
                .Height    = 18
                .Caption   = "Per" + CHR(237) + "odo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__dt_inicial", "TextBox")
            WITH loc_oPagina.txt_4c__dt_inicial
                .Top           = 33
                .Left          = 104
                .Width         = 80
                .Height        = 25
                .Value         = DATE()
                .InputMask     = "99/99/9999"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            loc_oPagina.AddObject("lbl_4c_Lbl_periodo_a", "Label")
            WITH loc_oPagina.lbl_4c_Lbl_periodo_a
                .Top       = 38
                .Left      = 188
                .Width     = 18
                .Height    = 18
                .Caption   = "at" + CHR(233)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__dt_final", "TextBox")
            WITH loc_oPagina.txt_4c__dt_final
                .Top           = 33
                .Left          = 212
                .Width         = 80
                .Height        = 25
                .Value         = DATE()
                .InputMask     = "99/99/9999"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            loc_oPagina.AddObject("obj_4c_OptData", "OptionGroup")
            WITH loc_oPagina.obj_4c_OptData
                .Top         = 33
                .Left        = 292
                .Width       = 185
                .Height      = 25
                .ButtonCount = 2
                .BackStyle   = 0
                .BorderStyle = 0
                .Themes      = .F.
                .Value       = 1
                WITH .Buttons(1)
                    .Caption   = "Lan" + CHR(231) + "amento"
                    .Top       = 4
                    .Left      = 2
                    .Width     = 85
                    .Height    = 17
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "Prazo Entrega"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Top       = 4
                    .Left      = 90
                    .Width     = 90
                    .Height    = 17
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH
                .Visible = .T.
            ENDWITH

            *-- ===== ROW 2: MOVIMENTACAO / OP =====
            loc_oPagina.AddObject("lbl_4c_Lbl_operacao", "Label")
            WITH loc_oPagina.lbl_4c_Lbl_operacao
                .Top       = 66
                .Left      = 22
                .Width     = 78
                .Height    = 18
                .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__operacao", "TextBox")
            WITH loc_oPagina.txt_4c__operacao
                .Top           = 61
                .Left          = 104
                .Width         = 150
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Numes", "TextBox")
            WITH loc_oPagina.txt_4c_Numes
                .Top           = 61
                .Left          = 257
                .Width         = 54
                .Height        = 25
                .Value         = 0
                .InputMask     = "######"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            loc_oPagina.AddObject("lbl_4c_Lbl_op", "Label")
            WITH loc_oPagina.lbl_4c_Lbl_op
                .Top       = 66
                .Left      = 318
                .Width     = 23
                .Height    = 18
                .Caption   = "OP:"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("chk_4c_ChkImpOp", "CheckBox")
            WITH loc_oPagina.chk_4c_ChkImpOp
                .Top     = 66
                .Left    = 344
                .Width   = 15
                .Height  = 15
                .Caption = ""
                .Value   = 0
                .FontName = "Tahoma"
                .FontSize = 8
                .Themes  = .F.
                .Visible = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Opi", "TextBox")
            WITH loc_oPagina.txt_4c_Opi
                .Top           = 61
                .Left          = 363
                .Width         = 54
                .Height        = 25
                .Value         = 0
                .InputMask     = "######"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Enabled       = .F.
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            loc_oPagina.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oPagina.lbl_4c_Label3
                .Top       = 66
                .Left      = 422
                .Width     = 20
                .Height    = 18
                .Caption   = "at" + CHR(233)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Opf", "TextBox")
            WITH loc_oPagina.txt_4c_Opf
                .Top           = 61
                .Left          = 445
                .Width         = 54
                .Height        = 25
                .Value         = 0
                .InputMask     = "######"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Enabled       = .F.
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- ===== ROW 3: OBSERVACAO =====
            loc_oPagina.AddObject("lbl_4c_Label18", "Label")
            WITH loc_oPagina.lbl_4c_Label18
                .Top       = 94
                .Left      = 33
                .Width     = 67
                .Height    = 18
                .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_CodObs", "TextBox")
            WITH loc_oPagina.txt_4c_CodObs
                .Top           = 90
                .Left          = 104
                .Width         = 31
                .Height        = 23
                .Value         = 0
                .InputMask     = "###"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_DesObs", "TextBox")
            WITH loc_oPagina.txt_4c_DesObs
                .Top           = 90
                .Left          = 138
                .Width         = 361
                .Height        = 23
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Enabled       = .F.
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- ===== ROW 4: EMPRESA =====
            loc_oPagina.AddObject("lbl_4c_Lbl_empresa", "Label")
            WITH loc_oPagina.lbl_4c_Lbl_empresa
                .Top       = 122
                .Left      = 50
                .Width     = 50
                .Height    = 18
                .Caption   = "Empresa :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__empresa", "TextBox")
            WITH loc_oPagina.txt_4c__empresa
                .Top           = 117
                .Left          = 104
                .Width         = 31
                .Height        = 25
                .Value         = ""
                .InputMask     = "XXX"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__empresa_desc", "TextBox")
            WITH loc_oPagina.txt_4c__empresa_desc
                .Top           = 117
                .Left          = 138
                .Width         = 361
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Enabled       = .F.
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- ===== ROW 5 ESQUERDA: GRUPO ESTOQUE =====
            loc_oPagina.AddObject("lbl_4c_Label1_GrupoContab", "Label")
            WITH loc_oPagina.lbl_4c_Label1_GrupoContab
                .Top       = 150
                .Left      = 62
                .Width     = 38
                .Height    = 18
                .Caption   = "Grupo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__Cd_GrEstoque", "TextBox")
            WITH loc_oPagina.txt_4c__Cd_GrEstoque
                .Top           = 145
                .Left          = 104
                .Width         = 80
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__Ds_GrEstoque", "TextBox")
            WITH loc_oPagina.txt_4c__Ds_GrEstoque
                .Top           = 145
                .Left          = 187
                .Width         = 312
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Enabled       = .F.
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- ===== ROW 5 DIREITA: LABEL TIPO MOV =====
            loc_oPagina.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPagina.lbl_4c_Label1
                .Top       = 145
                .Left      = 511
                .Width     = 172
                .Height    = 17
                .Caption   = "Tipo de Movimenta" + CHR(231) + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- ===== ROW 6 ESQUERDA: CONTA ESTOQUE =====
            loc_oPagina.AddObject("lbl_4c_Lbl_estoque", "Label")
            WITH loc_oPagina.lbl_4c_Lbl_estoque
                .Top       = 178
                .Left      = 62
                .Width     = 38
                .Height    = 18
                .Caption   = "Conta :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__cd_estoque", "TextBox")
            WITH loc_oPagina.txt_4c__cd_estoque
                .Top           = 173
                .Left          = 104
                .Width         = 80
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Enabled       = .F.
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__ds_estoque", "TextBox")
            WITH loc_oPagina.txt_4c__ds_estoque
                .Top           = 173
                .Left          = 187
                .Width         = 312
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Enabled       = .F.
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- ===== GRID TIPOS DE MOVIMENTACAO (rows 5-8 direita) =====
            loc_oPagina.AddObject("grd_4c_Dados", "Grid")
            loc_oGrid = loc_oPagina.grd_4c_Dados
            WITH loc_oGrid
                .Top                = 158
                .Left               = 511
                .Width              = 251
                .Height             = 130
                .ColumnCount        = 2
                .RecordSource       = "cursor_4c_TipoMov"
                .RecordSourceType   = 1
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
                .Themes             = .F.

                *-- Column1: CheckBox para Marca (campo booleano de selecao)
                WITH .Column1
                    .Width = 25
                    .Header1.Caption = ""
                    .AddObject("Check1", "CheckBox")
                    .Check1.Caption = ""
                    .Check1.Value = 0
                    .CurrentControl = "Check1"
                    .ControlSource = "cursor_4c_TipoMov.Marca"
                    .Visible = .T.
                ENDWITH

                *-- Column2: Descricao do tipo de movimentacao
                WITH .Column2
                    .Width = 224
                    .ControlSource = "cursor_4c_TipoMov.Descri"
                    .ReadOnly = .T.
                    .Header1.Caption = "Tipo"
                    .Visible = .T.
                ENDWITH

                .Visible = .T.
            ENDWITH

            *-- Botoes SelTudo / Apaga (direita do grid)
            loc_oPagina.AddObject("cmd_4c_SelTudo", "CommandButton")
            WITH loc_oPagina.cmd_4c_SelTudo
                .Top          = 186
                .Left         = 763
                .Width        = 35
                .Height       = 34
                .Caption      = ""
                .Picture      = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .ToolTipText  = "Selecionar Todos"
                .FontName     = "Tahoma"
                .FontSize     = 8
                .ForeColor    = RGB(90, 90, 90)
                .BackColor    = RGB(255, 255, 255)
                .Themes       = .F.
                .SpecialEffect = 0
                .MousePointer = 15
                .Visible      = .T.
            ENDWITH

            loc_oPagina.AddObject("cmd_4c_Apaga", "CommandButton")
            WITH loc_oPagina.cmd_4c_Apaga
                .Top          = 221
                .Left         = 763
                .Width        = 35
                .Height       = 34
                .Caption      = ""
                .Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .ToolTipText  = "Desmarcar Todos"
                .FontName     = "Tahoma"
                .FontSize     = 8
                .ForeColor    = RGB(90, 90, 90)
                .BackColor    = RGB(255, 255, 255)
                .Themes       = .F.
                .SpecialEffect = 0
                .MousePointer = 15
                .Visible      = .T.
            ENDWITH

            *-- ===== ROW 7: GRANDE GRUPO =====
            loc_oPagina.AddObject("lbl_4c_Label5", "Label")
            WITH loc_oPagina.lbl_4c_Label5
                .Top       = 206
                .Left      = 24
                .Width     = 76
                .Height    = 18
                .Caption   = "Grande Grupo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__cd_ggrupo", "TextBox")
            WITH loc_oPagina.txt_4c__cd_ggrupo
                .Top           = 201
                .Left          = 104
                .Width         = 31
                .Height        = 25
                .Value         = ""
                .InputMask     = "##"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__ds_ggrupo", "TextBox")
            WITH loc_oPagina.txt_4c__ds_ggrupo
                .Top           = 201
                .Left          = 138
                .Width         = 361
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Enabled       = .F.
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- ===== ROW 8: GRUPO PRODUTO =====
            loc_oPagina.AddObject("lbl_4c_Lbl_grupo", "Label")
            WITH loc_oPagina.lbl_4c_Lbl_grupo
                .Top       = 235
                .Left      = 21
                .Width     = 79
                .Height    = 18
                .Caption   = "Grupo Produto :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__grupo", "TextBox")
            WITH loc_oPagina.txt_4c__grupo
                .Top           = 230
                .Left          = 104
                .Width         = 31
                .Height        = 25
                .Value         = ""
                .InputMask     = "XXX"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__grupo_desc", "TextBox")
            WITH loc_oPagina.txt_4c__grupo_desc
                .Top           = 230
                .Left          = 138
                .Width         = 361
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Enabled       = .F.
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- ===== ROW 9: SUBGRUPO =====
            loc_oPagina.AddObject("lbl_4c_Label16", "Label")
            WITH loc_oPagina.lbl_4c_Label16
                .Top       = 264
                .Left      = 45
                .Width     = 55
                .Height    = 15
                .Caption   = "Subgrupo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__cd_sgrupo", "TextBox")
            WITH loc_oPagina.txt_4c__cd_sgrupo
                .Top           = 259
                .Left          = 104
                .Width         = 52
                .Height        = 25
                .Value         = ""
                .InputMask     = "XXXXXXX"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__ds_sgrupo", "TextBox")
            WITH loc_oPagina.txt_4c__ds_sgrupo
                .Top           = 259
                .Left          = 158
                .Width         = 341
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Enabled       = .F.
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- ===== ROW 10: SITUACAO + CHECKBOXES =====
            loc_oPagina.AddObject("lbl_4c_Label7", "Label")
            WITH loc_oPagina.lbl_4c_Label7
                .Top       = 290
                .Left      = 50
                .Width     = 50
                .Height    = 18
                .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("obj_4c_OptSituas", "OptionGroup")
            WITH loc_oPagina.obj_4c_OptSituas
                .Top         = 284
                .Left        = 100
                .Width       = 311
                .Height      = 27
                .ButtonCount = 3
                .BackStyle   = 0
                .BorderStyle = 0
                .Themes      = .F.
                .Value       = 3
                WITH .Buttons(1)
                    .Caption   = "N.Ind."
                    .Top       = 4
                    .Left      = 2
                    .Width     = 60
                    .Height    = 17
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "Industrializada"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Top       = 4
                    .Left      = 65
                    .Width     = 100
                    .Height    = 17
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH
                WITH .Buttons(3)
                    .Caption   = "Todos"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Top       = 4
                    .Left      = 168
                    .Width     = 60
                    .Height    = 17
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH
                .Visible = .T.
            ENDWITH

            loc_oPagina.AddObject("chk_4c_ChkPendente", "CheckBox")
            WITH loc_oPagina.chk_4c_ChkPendente
                .Top      = 289
                .Left     = 421
                .Width    = 69
                .Height   = 15
                .Caption  = "Pendentes"
                .Value    = 0
                .FontName = "Tahoma"
                .FontSize = 8
                .Enabled  = .F.
                .Themes   = .F.
                .Visible  = .T.
            ENDWITH

            loc_oPagina.AddObject("chk_4c_ChkOrdem", "CheckBox")
            WITH loc_oPagina.chk_4c_ChkOrdem
                .Top      = 289
                .Left     = 516
                .Width    = 171
                .Height   = 15
                .Caption  = "Filtro por Ordem de Composi" + CHR(231) + CHR(227) + "o"
                .Value    = 0
                .FontName = "Tahoma"
                .FontSize = 8
                .Themes   = .F.
                .Visible  = .T.
            ENDWITH

            *-- ===== ROW 11: AGRUPAMENTO + SERVICO =====
            loc_oPagina.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPagina.lbl_4c_Label2
                .Top       = 311
                .Left      = 26
                .Width     = 74
                .Height    = 18
                .Caption   = "Agrupamento :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("obj_4c_Optagrupa", "OptionGroup")
            WITH loc_oPagina.obj_4c_Optagrupa
                .Top         = 306
                .Left        = 100
                .Width       = 198
                .Height      = 25
                .ButtonCount = 2
                .BackStyle   = 0
                .BorderStyle = 0
                .Themes      = .F.
                .Value       = 1
                WITH .Buttons(1)
                    .Caption   = "Composi" + CHR(231) + CHR(227) + "o"
                    .Top       = 4
                    .Left      = 2
                    .Width     = 90
                    .Height    = 17
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "OP"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Top       = 4
                    .Left      = 95
                    .Width     = 40
                    .Height    = 17
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH
                .Visible = .T.
            ENDWITH

            loc_oPagina.AddObject("chk_4c_Chkservico", "CheckBox")
            WITH loc_oPagina.chk_4c_Chkservico
                .Top      = 310
                .Left     = 368
                .Width    = 110
                .Height   = 15
                .Caption  = "Industrializa" + CHR(231) + CHR(227) + "o (S)"
                .Value    = 0
                .FontName = "Tahoma"
                .FontSize = 8
                .Enabled  = .F.
                .Themes   = .F.
                .Visible  = .T.
            ENDWITH

            *-- ===== BINDEVENTS =====
            BINDEVENT(loc_oPagina.chk_4c_ChkImpOp, "InteractiveChange", ;
                THIS, "ChkImpOpChange")
            BINDEVENT(loc_oPagina.obj_4c_OptSituas, "InteractiveChange", ;
                THIS, "OptSituasChange")
            BINDEVENT(loc_oPagina.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")
            BINDEVENT(loc_oPagina.cmd_4c_Apaga,   "Click", THIS, "BtnApagaClick")
            BINDEVENT(loc_oPagina.txt_4c__operacao, "KeyPress", ;
                THIS, "TxtOperacaoKeyPress")
            BINDEVENT(loc_oPagina.txt_4c_CodObs, "KeyPress", ;
                THIS, "TxtCodObsKeyPress")
            BINDEVENT(loc_oPagina.txt_4c_DesObs, "KeyPress", ;
                THIS, "TxtDesObsKeyPress")
            BINDEVENT(loc_oPagina.txt_4c__empresa, "KeyPress", ;
                THIS, "TxtEmpresaKeyPress")
            BINDEVENT(loc_oPagina.txt_4c__Cd_GrEstoque, "KeyPress", ;
                THIS, "TxtGrEstoqueKeyPress")
            BINDEVENT(loc_oPagina.txt_4c__cd_ggrupo, "KeyPress", ;
                THIS, "TxtGrdGrupoKeyPress")
            BINDEVENT(loc_oPagina.txt_4c__ds_ggrupo, "KeyPress", ;
                THIS, "TxtGrdGrupoDescKeyPress")
            BINDEVENT(loc_oPagina.txt_4c__grupo, "KeyPress", ;
                THIS, "TxtGrupoKeyPress")
            BINDEVENT(loc_oPagina.txt_4c__grupo_desc, "KeyPress", ;
                THIS, "TxtGrupoDescKeyPress")
            BINDEVENT(loc_oPagina.txt_4c__cd_sgrupo, "KeyPress", ;
                THIS, "TxtSubGrupoKeyPress")
            BINDEVENT(loc_oPagina.txt_4c__ds_sgrupo, "KeyPress", ;
                THIS, "TxtSubGrupoDescKeyPress")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Pos-configuracao da Page1:
    *   Visibilidade, estado inicial dos campos e botoes do relatorio.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oErro
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- Garantir visibilidade: AddObject cria controles com Visible=.F.
            THIS.TornarControlesVisiveis(loc_oPagina)

            *-- Ajustar estado inicial dos botoes do relatorio (todos habilitados)
            THIS.AjustarBotoesPorModo()

            *-- Estado inicial: campos de descricao desabilitados ate preenchimento do codigo pai
            *-- (Equivalente ao When=Empty(campo_pai) do legado)
            IF PEMSTATUS(loc_oPagina, "txt_4c__Ds_GrEstoque", 5)
                loc_oPagina.txt_4c__Ds_GrEstoque.Enabled = .F.
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c__cd_estoque", 5)
                loc_oPagina.txt_4c__cd_estoque.Enabled = .F.
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c__ds_estoque", 5)
                loc_oPagina.txt_4c__ds_estoque.Enabled = .F.
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c__ds_ggrupo", 5)
                loc_oPagina.txt_4c__ds_ggrupo.Enabled = .F.
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c__grupo_desc", 5)
                loc_oPagina.txt_4c__grupo_desc.Enabled = .F.
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c__ds_sgrupo", 5)
                loc_oPagina.txt_4c__ds_sgrupo.Enabled = .F.
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c_DesObs", 5)
                loc_oPagina.txt_4c_DesObs.Enabled = .F.
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c__empresa_desc", 5)
                loc_oPagina.txt_4c__empresa_desc.Enabled = .F.
            ENDIF

            *-- Campos OP desabilitados ate chkImpOp ser marcado
            IF PEMSTATUS(loc_oPagina, "txt_4c_Opi", 5)
                loc_oPagina.txt_4c_Opi.Enabled = .F.
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c_Opf", 5)
                loc_oPagina.txt_4c_Opf.Enabled = .F.
            ENDIF

            *-- Checkboxes contextuais desabilitados ate condicao de habilitacao ser satisfeita
            IF PEMSTATUS(loc_oPagina, "chk_4c_Chkservico", 5)
                loc_oPagina.chk_4c_Chkservico.Enabled = .F.
            ENDIF
            IF PEMSTATUS(loc_oPagina, "chk_4c_ChkPendente", 5)
                loc_oPagina.chk_4c_ChkPendente.Enabled = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em ConfigurarPaginaDados")
        ENDTRY
        RETURN .T.
    ENDPROC

    *==========================================================================
    * AlternarPagina - Ativa a pagina informada (form REPORT tem so Page1)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_oErro
        TRY
            loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
            IF loc_nPagina < 1 OR loc_nPagina > THIS.pgf_4c_Paginas.PageCount
                loc_nPagina = 1
            ENDIF
            THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Alternar P" + CHR(225) + "gina")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Inicializa BO e controles com valores padrao
    *==========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oPg
        loc_oPg = IIF(VARTYPE(THIS.pgf_4c_Paginas) = "O", ;
                      THIS.pgf_4c_Paginas.Page1, .NULL.)

        IF VARTYPE(THIS.this_oRelatorio) = "O"
            WITH THIS.this_oRelatorio
                .this_dDtInicial     = DATE()
                .this_dDtFinal       = DATE()
                .this_nOptData       = 1
                .this_cOperacao      = ""
                .this_nNumes         = 0
                .this_lChkImpOp      = .F.
                .this_nOpi           = 0
                .this_nOpf           = 0
                .this_cEmpresa       = ""
                .this_cEmpresaDesc   = ""
                .this_nCodObs        = 0
                .this_cDesObs        = ""
                .this_cGrEstoque     = ""
                .this_cGrEstoqueDesc = ""
                .this_cEstoque       = ""
                .this_cEstoqueDesc   = ""
                .this_cGrdGrupo      = ""
                .this_cGrdGrupoDesc  = ""
                .this_cGrupo         = ""
                .this_cGrupoDesc     = ""
                .this_cSubGrupo      = ""
                .this_cSubGrupoDesc  = ""
                .this_nOpcaoSituacao = 3
                .this_nAgrupamento   = 1
                .this_lServico       = .F.
                .this_lPendente      = .F.
                .this_lOrdem         = .F.
            ENDWITH
        ENDIF

        IF VARTYPE(loc_oPg) != "O"
            RETURN
        ENDIF

        IF PEMSTATUS(loc_oPg, "txt_4c__dt_inicial", 5)
            loc_oPg.txt_4c__dt_inicial.Value = DATE()
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__dt_final", 5)
            loc_oPg.txt_4c__dt_final.Value = DATE()
        ENDIF
        IF PEMSTATUS(loc_oPg, "obj_4c_OptData", 5)
            loc_oPg.obj_4c_OptData.Value = 1
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__operacao", 5)
            loc_oPg.txt_4c__operacao.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Numes", 5)
            loc_oPg.txt_4c_Numes.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "chk_4c_ChkImpOp", 5)
            loc_oPg.chk_4c_ChkImpOp.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Opi", 5)
            loc_oPg.txt_4c_Opi.Value = 0
            loc_oPg.txt_4c_Opi.Enabled = .F.
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Opf", 5)
            loc_oPg.txt_4c_Opf.Value = 0
            loc_oPg.txt_4c_Opf.Enabled = .F.
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_CodObs", 5)
            loc_oPg.txt_4c_CodObs.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_DesObs", 5)
            loc_oPg.txt_4c_DesObs.Value = ""
            loc_oPg.txt_4c_DesObs.Enabled = .F.
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__empresa", 5)
            loc_oPg.txt_4c__empresa.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__empresa_desc", 5)
            loc_oPg.txt_4c__empresa_desc.Value = ""
            loc_oPg.txt_4c__empresa_desc.Enabled = .F.
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__Cd_GrEstoque", 5)
            loc_oPg.txt_4c__Cd_GrEstoque.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__Ds_GrEstoque", 5)
            loc_oPg.txt_4c__Ds_GrEstoque.Value = ""
            loc_oPg.txt_4c__Ds_GrEstoque.Enabled = .F.
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__cd_estoque", 5)
            loc_oPg.txt_4c__cd_estoque.Value = ""
            loc_oPg.txt_4c__cd_estoque.Enabled = .F.
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__ds_estoque", 5)
            loc_oPg.txt_4c__ds_estoque.Value = ""
            loc_oPg.txt_4c__ds_estoque.Enabled = .F.
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__cd_ggrupo", 5)
            loc_oPg.txt_4c__cd_ggrupo.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__ds_ggrupo", 5)
            loc_oPg.txt_4c__ds_ggrupo.Value = ""
            loc_oPg.txt_4c__ds_ggrupo.Enabled = .F.
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__grupo", 5)
            loc_oPg.txt_4c__grupo.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__grupo_desc", 5)
            loc_oPg.txt_4c__grupo_desc.Value = ""
            loc_oPg.txt_4c__grupo_desc.Enabled = .F.
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__cd_sgrupo", 5)
            loc_oPg.txt_4c__cd_sgrupo.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__ds_sgrupo", 5)
            loc_oPg.txt_4c__ds_sgrupo.Value = ""
            loc_oPg.txt_4c__ds_sgrupo.Enabled = .F.
        ENDIF
        IF PEMSTATUS(loc_oPg, "obj_4c_OptSituas", 5)
            loc_oPg.obj_4c_OptSituas.Value = 3
        ENDIF
        IF PEMSTATUS(loc_oPg, "obj_4c_Optagrupa", 5)
            loc_oPg.obj_4c_Optagrupa.Value = 1
        ENDIF
        IF PEMSTATUS(loc_oPg, "chk_4c_Chkservico", 5)
            loc_oPg.chk_4c_Chkservico.Value = 0
            loc_oPg.chk_4c_Chkservico.Enabled = .F.
        ENDIF
        IF PEMSTATUS(loc_oPg, "chk_4c_ChkPendente", 5)
            loc_oPg.chk_4c_ChkPendente.Value = 0
            loc_oPg.chk_4c_ChkPendente.Enabled = .F.
        ENDIF
        IF PEMSTATUS(loc_oPg, "chk_4c_ChkOrdem", 5)
            loc_oPg.chk_4c_ChkOrdem.Value = 0
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaRelatorio - Transfere TODOS os filtros do form para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dDtInicial = IIF(PEMSTATUS(loc_oPg,"txt_4c__dt_inicial",5), ;
                loc_oPg.txt_4c__dt_inicial.Value, DATE())
            .this_dDtFinal = IIF(PEMSTATUS(loc_oPg,"txt_4c__dt_final",5), ;
                loc_oPg.txt_4c__dt_final.Value, DATE())
            .this_nOptData = IIF(PEMSTATUS(loc_oPg,"obj_4c_OptData",5), ;
                loc_oPg.obj_4c_OptData.Value, 1)
            .this_cOperacao = IIF(PEMSTATUS(loc_oPg,"txt_4c__operacao",5), ;
                ALLTRIM(loc_oPg.txt_4c__operacao.Value), "")
            .this_nNumes = IIF(PEMSTATUS(loc_oPg,"txt_4c_Numes",5), ;
                loc_oPg.txt_4c_Numes.Value, 0)
            .this_lChkImpOp = IIF(PEMSTATUS(loc_oPg,"chk_4c_ChkImpOp",5), ;
                loc_oPg.chk_4c_ChkImpOp.Value = 1, .F.)
            .this_nOpi = IIF(PEMSTATUS(loc_oPg,"txt_4c_Opi",5), ;
                loc_oPg.txt_4c_Opi.Value, 0)
            .this_nOpf = IIF(PEMSTATUS(loc_oPg,"txt_4c_Opf",5), ;
                loc_oPg.txt_4c_Opf.Value, 0)
            .this_cEmpresa = IIF(PEMSTATUS(loc_oPg,"txt_4c__empresa",5), ;
                ALLTRIM(loc_oPg.txt_4c__empresa.Value), "")
            .this_cEmpresaDesc = IIF(PEMSTATUS(loc_oPg,"txt_4c__empresa_desc",5), ;
                ALLTRIM(loc_oPg.txt_4c__empresa_desc.Value), "")
            .this_nCodObs = IIF(PEMSTATUS(loc_oPg,"txt_4c_CodObs",5), ;
                loc_oPg.txt_4c_CodObs.Value, 0)
            .this_cDesObs = IIF(PEMSTATUS(loc_oPg,"txt_4c_DesObs",5), ;
                ALLTRIM(loc_oPg.txt_4c_DesObs.Value), "")
            .this_cGrEstoque = IIF(PEMSTATUS(loc_oPg,"txt_4c__Cd_GrEstoque",5), ;
                ALLTRIM(loc_oPg.txt_4c__Cd_GrEstoque.Value), "")
            .this_cGrEstoqueDesc = IIF(PEMSTATUS(loc_oPg,"txt_4c__Ds_GrEstoque",5), ;
                ALLTRIM(loc_oPg.txt_4c__Ds_GrEstoque.Value), "")
            .this_cEstoque = IIF(PEMSTATUS(loc_oPg,"txt_4c__cd_estoque",5), ;
                ALLTRIM(loc_oPg.txt_4c__cd_estoque.Value), "")
            .this_cEstoqueDesc = IIF(PEMSTATUS(loc_oPg,"txt_4c__ds_estoque",5), ;
                ALLTRIM(loc_oPg.txt_4c__ds_estoque.Value), "")
            .this_cGrdGrupo = IIF(PEMSTATUS(loc_oPg,"txt_4c__cd_ggrupo",5), ;
                ALLTRIM(loc_oPg.txt_4c__cd_ggrupo.Value), "")
            .this_cGrdGrupoDesc = IIF(PEMSTATUS(loc_oPg,"txt_4c__ds_ggrupo",5), ;
                ALLTRIM(loc_oPg.txt_4c__ds_ggrupo.Value), "")
            .this_cGrupo = IIF(PEMSTATUS(loc_oPg,"txt_4c__grupo",5), ;
                ALLTRIM(loc_oPg.txt_4c__grupo.Value), "")
            .this_cGrupoDesc = IIF(PEMSTATUS(loc_oPg,"txt_4c__grupo_desc",5), ;
                ALLTRIM(loc_oPg.txt_4c__grupo_desc.Value), "")
            .this_cSubGrupo = IIF(PEMSTATUS(loc_oPg,"txt_4c__cd_sgrupo",5), ;
                ALLTRIM(loc_oPg.txt_4c__cd_sgrupo.Value), "")
            .this_cSubGrupoDesc = IIF(PEMSTATUS(loc_oPg,"txt_4c__ds_sgrupo",5), ;
                ALLTRIM(loc_oPg.txt_4c__ds_sgrupo.Value), "")
            .this_nOpcaoSituacao = IIF(PEMSTATUS(loc_oPg,"obj_4c_OptSituas",5), ;
                loc_oPg.obj_4c_OptSituas.Value, 3)
            .this_nAgrupamento = IIF(PEMSTATUS(loc_oPg,"obj_4c_Optagrupa",5), ;
                loc_oPg.obj_4c_Optagrupa.Value, 1)
            .this_lServico = IIF(PEMSTATUS(loc_oPg,"chk_4c_Chkservico",5), ;
                loc_oPg.chk_4c_Chkservico.Value = 1, .F.)
            .this_lPendente = IIF(PEMSTATUS(loc_oPg,"chk_4c_ChkPendente",5), ;
                loc_oPg.chk_4c_ChkPendente.Value = 1, .F.)
            .this_lOrdem = IIF(PEMSTATUS(loc_oPg,"chk_4c_ChkOrdem",5), ;
                loc_oPg.chk_4c_ChkOrdem.Value = 1, .F.)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ValidarFiltros - Valida campos obrigatorios antes de gerar relatorio
    *==========================================================================
    PROCEDURE ValidarFiltros()
        LOCAL loc_lValido, loc_oPg
        loc_lValido = .T.
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF PEMSTATUS(loc_oPg, "txt_4c__dt_inicial", 5)
            IF EMPTY(loc_oPg.txt_4c__dt_inicial.Value)
                MsgAviso("Informe a data inicial do per" + CHR(237) + "odo.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPg.txt_4c__dt_inicial.SetFocus()
                loc_lValido = .F.
            ENDIF
        ENDIF
        IF loc_lValido AND PEMSTATUS(loc_oPg, "txt_4c__dt_final", 5)
            IF EMPTY(loc_oPg.txt_4c__dt_final.Value)
                MsgAviso("Informe a data final do per" + CHR(237) + "odo.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPg.txt_4c__dt_final.SetFocus()
                loc_lValido = .F.
            ENDIF
        ENDIF
        IF loc_lValido AND PEMSTATUS(loc_oPg,"txt_4c__dt_inicial",5) ;
                       AND PEMSTATUS(loc_oPg,"txt_4c__dt_final",5)
            IF loc_oPg.txt_4c__dt_final.Value < loc_oPg.txt_4c__dt_inicial.Value
                MsgAviso("Data final n" + CHR(227) + "o pode ser menor que a data inicial.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPg.txt_4c__dt_final.SetFocus()
                loc_lValido = .F.
            ENDIF
        ENDIF
        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Preview do relatorio na tela
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cFrx, loc_oErro
        TRY
            IF THIS.ValidarFiltros()
                THIS.FormParaRelatorio()
                IF VARTYPE(THIS.this_oRelatorio) = "O"
                    IF THIS.this_oRelatorio.PrepararDados()
                        loc_cFrx = gc_4c_CaminhoReports + ;
                            THIS.this_oRelatorio.ObterNomeRelatorio() + ".frx"
                        IF FILE(loc_cFrx)
                            REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
                        ELSE
                            MsgErro("Arquivo de relat" + CHR(243) + "rio n" + ;
                                CHR(227) + "o encontrado:" + CHR(13) + loc_cFrx, "Erro")
                        ENDIF
                    ELSE
                        MsgErro("Erro ao processar relat" + CHR(243) + "rio:" + CHR(13) + ;
                            THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * BtnImprimirClick - Imprime relatorio com dialogo de impressora
    *==========================================================================
    PROCEDURE BtnImprimirClick()
        LOCAL loc_cFrx, loc_oErro
        TRY
            IF THIS.ValidarFiltros()
                THIS.FormParaRelatorio()
                IF VARTYPE(THIS.this_oRelatorio) = "O"
                    IF THIS.this_oRelatorio.PrepararDados()
                        loc_cFrx = gc_4c_CaminhoReports + ;
                            THIS.this_oRelatorio.ObterNomeRelatorio() + ".frx"
                        IF FILE(loc_cFrx)
                            REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
                        ELSE
                            MsgErro("Arquivo de relat" + CHR(243) + "rio n" + ;
                                CHR(227) + "o encontrado:" + CHR(13) + loc_cFrx, "Erro")
                        ENDIF
                    ELSE
                        MsgErro("Erro ao processar relat" + CHR(243) + "rio:" + CHR(13) + ;
                            THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * BtnExcelClick - Exporta dados do relatorio para planilha Excel
    *==========================================================================
    PROCEDURE BtnExcelClick()
        LOCAL loc_cArquivo, loc_oErro
        TRY
            IF THIS.ValidarFiltros()
                THIS.FormParaRelatorio()
                IF VARTYPE(THIS.this_oRelatorio) = "O"
                    IF THIS.this_oRelatorio.PrepararDados()
                        IF USED("TmpRelat") AND RECCOUNT("TmpRelat") > 0
                            loc_cArquivo = ADDBS(SYS(2023)) + "SigReCmp_" + ;
                                DTOS(DATE()) + "_" + STRTRAN(TIME(), ":", "") + ".xls"
                            SELECT TmpRelat
                            COPY TO (loc_cArquivo) TYPE XLS
                            IF FILE(loc_cArquivo)
                                DECLARE INTEGER ShellExecute IN shell32.dll ;
                                    INTEGER hndWin, STRING cAction, STRING cFileName, ;
                                    STRING cParams, STRING cDir, INTEGER nShowWin
                                ShellExecute(0, "open", loc_cArquivo, "", "", 1)
                                MsgInfo("Arquivo exportado para:" + CHR(13) + loc_cArquivo)
                            ELSE
                                MsgErro("Erro ao exportar para Excel.", "Erro")
                            ENDIF
                        ELSE
                            MsgAviso("Sem dados para exportar.", "Aviso")
                        ENDIF
                    ELSE
                        MsgErro("Erro ao processar relat" + CHR(243) + "rio:" + CHR(13) + ;
                            THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSairClick / BtnCancelarClick / BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Todos os botoes sempre habilitados em REPORT
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCmg, loc_nI, loc_oErro
        TRY
            IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O" AND ;
               PEMSTATUS(THIS.cnt_4c_Cabecalho, "cmg_4c_Botoes", 5)
                loc_oCmg = THIS.cnt_4c_Cabecalho.cmg_4c_Botoes
                FOR loc_nI = 1 TO loc_oCmg.ButtonCount
                    loc_oCmg.Buttons(loc_nI).Enabled = .T.
                ENDFOR
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Aliases CRUD para compatibilidade com pipeline multi-fase / FormBase
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab, loc_oPg, loc_oErro
        TRY
            loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_oPg = THIS.pgf_4c_Paginas.Page1
                IF VARTYPE(loc_oPg) = "O"
                    loc_oPg.Enabled = loc_lHab
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em HabilitarCampos")
        ENDTRY
    ENDPROC

    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    PROCEDURE AtualizarEstadoControles()
        RETURN
    ENDPROC

    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        RETURN
    ENDPROC

    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnConsultarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        THIS.LimparCampos()
    ENDPROC

    *==========================================================================
    * ChkImpOpChange - habilita/desabilita campos OP e seta situacao=Ind.
    *   Equivalente ao InteractiveChange do chkImpOp no legado
    *==========================================================================
    PROCEDURE ChkImpOpChange()
        LOCAL loc_oPg, loc_lChecked
        loc_oPg     = THIS.pgf_4c_Paginas.Page1
        loc_lChecked = PEMSTATUS(loc_oPg,"chk_4c_ChkImpOp",5) AND ;
                       loc_oPg.chk_4c_ChkImpOp.Value = 1
        IF PEMSTATUS(loc_oPg, "txt_4c_Opi", 5)
            loc_oPg.txt_4c_Opi.Enabled = loc_lChecked
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c_Opf", 5)
            loc_oPg.txt_4c_Opf.Enabled = loc_lChecked
        ENDIF
        IF loc_lChecked AND PEMSTATUS(loc_oPg, "obj_4c_OptSituas", 5)
            loc_oPg.obj_4c_OptSituas.Value = 2
            THIS.OptSituasChange()
        ENDIF
    ENDPROC

    *==========================================================================
    * OptSituasChange: habilita chkPendente quando situacao=Industrializada (2)
    *==========================================================================
    PROCEDURE OptSituasChange()
        LOCAL loc_oPg, loc_lSit2
        loc_oPg  = THIS.pgf_4c_Paginas.Page1
        loc_lSit2 = PEMSTATUS(loc_oPg,"obj_4c_OptSituas",5) AND ;
                    loc_oPg.obj_4c_OptSituas.Value = 2
        IF PEMSTATUS(loc_oPg, "chk_4c_ChkPendente", 5)
            loc_oPg.chk_4c_ChkPendente.Enabled = loc_lSit2
            IF !loc_lSit2
                loc_oPg.chk_4c_ChkPendente.Value = 0
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnSelTudoClick - Marca todos os tipos de movimentacao no grid
    *==========================================================================
    PROCEDURE BtnSelTudoClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.MarcarTodos()
        ENDIF
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
                THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnApagaClick - Desmarca todos os tipos de movimentacao no grid
    *==========================================================================
    PROCEDURE BtnApagaClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.DesmarcarTodos()
        ENDIF
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
                THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtOperacaoKeyPress - F4=115 abre busca; ENTER=13/TAB=9 valida
    *==========================================================================
    PROCEDURE TxtOperacaoKeyPress(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaOperacao()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarOperacao()
            ENDIF
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarOperacao()
        LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nResult
        loc_oPg  = THIS.pgf_4c_Paginas.Page1
        IF !PEMSTATUS(loc_oPg, "txt_4c__operacao", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c__operacao.Value)
        IF EMPTY(loc_cCod)
            IF PEMSTATUS(loc_oPg, "chk_4c_Chkservico", 5)
                loc_oPg.chk_4c_Chkservico.Enabled = .F.
            ENDIF
            RETURN
        ENDIF
        loc_cSQL = "SELECT Dopes, Descrs FROM SigCdOpe WHERE Dopes = " + ;
                   EscaparSQL(loc_cCod)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeVal")
        IF loc_nResult > 0
            SELECT cursor_4c_OpeVal
            IF !EOF()
                IF PEMSTATUS(loc_oPg, "chk_4c_Chkservico", 5)
                    loc_oPg.chk_4c_Chkservico.Enabled = .T.
                ENDIF
            ELSE
                IF USED("cursor_4c_OpeVal")
                    USE IN cursor_4c_OpeVal
                ENDIF
                THIS.AbrirBuscaOperacao()
                RETURN
            ENDIF
            IF USED("cursor_4c_OpeVal")
                USE IN cursor_4c_OpeVal
            ENDIF
        ELSE
            THIS.AbrirBuscaOperacao()
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaOperacao()
        LOCAL loc_oPg, loc_cValor, loc_oBusca, loc_oErro
        TRY
            loc_oPg   = THIS.pgf_4c_Paginas.Page1
            loc_cValor = IIF(PEMSTATUS(loc_oPg,"txt_4c__operacao",5), ;
                             ALLTRIM(loc_oPg.txt_4c__operacao.Value), "")
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdOpe", "cursor_4c_BuscaOpe", "Dopes", loc_cValor, ;
                "Movimenta" + CHR(231) + CHR(227) + "o")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF PEMSTATUS(loc_oPg, "txt_4c__operacao", 5) AND ;
                       USED("cursor_4c_BuscaOpe")
                        SELECT cursor_4c_BuscaOpe
                        loc_oPg.txt_4c__operacao.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
                        IF PEMSTATUS(loc_oPg, "chk_4c_Chkservico", 5)
                            loc_oPg.chk_4c_Chkservico.Enabled = .T.
                        ENDIF
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Dopes",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
                        SELECT cursor_4c_BuscaOpe
                        IF PEMSTATUS(loc_oPg, "txt_4c__operacao", 5)
                            loc_oPg.txt_4c__operacao.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
                            IF PEMSTATUS(loc_oPg, "chk_4c_Chkservico", 5)
                                loc_oPg.chk_4c_Chkservico.Enabled = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaOpe")
                USE IN cursor_4c_BuscaOpe
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro na busca de movimenta" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtCodObsKeyPress - F4=115 abre busca por codigo; ENTER/TAB valida
    *==========================================================================
    PROCEDURE TxtCodObsKeyPress(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCodObs()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCodObs()
            ENDIF
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarCodObs()
        LOCAL loc_oPg, loc_nCod, loc_cSQL, loc_nResult
        loc_oPg  = THIS.pgf_4c_Paginas.Page1
        IF !PEMSTATUS(loc_oPg, "txt_4c_CodObs", 5)
            RETURN
        ENDIF
        loc_nCod = loc_oPg.txt_4c_CodObs.Value
        IF loc_nCod = 0
            IF PEMSTATUS(loc_oPg, "txt_4c_DesObs", 5)
                loc_oPg.txt_4c_DesObs.Value = ""
                loc_oPg.txt_4c_DesObs.Enabled = .F.
            ENDIF
            RETURN
        ENDIF
        loc_cSQL = "SELECT Codigos, Descrs FROM SigCdObs WHERE Codigos = " + ;
                   ALLTRIM(STR(loc_nCod, 3))
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ObsVal")
        IF loc_nResult > 0
            SELECT cursor_4c_ObsVal
            IF !EOF()
                IF PEMSTATUS(loc_oPg, "txt_4c_DesObs", 5)
                    loc_oPg.txt_4c_DesObs.Value = ALLTRIM(cursor_4c_ObsVal.Descrs)
                    loc_oPg.txt_4c_DesObs.Enabled = .T.
                ENDIF
            ELSE
                IF USED("cursor_4c_ObsVal")
                    USE IN cursor_4c_ObsVal
                ENDIF
                THIS.AbrirBuscaCodObs()
                RETURN
            ENDIF
            IF USED("cursor_4c_ObsVal")
                USE IN cursor_4c_ObsVal
            ENDIF
        ELSE
            THIS.AbrirBuscaCodObs()
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaCodObs()
        LOCAL loc_oPg, loc_cValor, loc_oBusca, loc_oErro
        TRY
            loc_oPg   = THIS.pgf_4c_Paginas.Page1
            loc_cValor = IIF(PEMSTATUS(loc_oPg,"txt_4c_CodObs",5), ;
                             ALLTRIM(STR(loc_oPg.txt_4c_CodObs.Value, 3)), "")
            IF loc_cValor = "  0"
                loc_cValor = ""
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdObs", "cursor_4c_BuscaObs", "Codigos", loc_cValor, ;
                "Observa" + CHR(231) + CHR(227) + "o")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaObs")
                        SELECT cursor_4c_BuscaObs
                        IF PEMSTATUS(loc_oPg, "txt_4c_CodObs", 5)
                            loc_oPg.txt_4c_CodObs.Value = cursor_4c_BuscaObs.Codigos
                        ENDIF
                        IF PEMSTATUS(loc_oPg, "txt_4c_DesObs", 5)
                            loc_oPg.txt_4c_DesObs.Value = ALLTRIM(cursor_4c_BuscaObs.Descrs)
                            loc_oPg.txt_4c_DesObs.Enabled = .T.
                        ENDIF
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "XXX", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "",    "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaObs")
                        SELECT cursor_4c_BuscaObs
                        IF PEMSTATUS(loc_oPg, "txt_4c_CodObs", 5)
                            loc_oPg.txt_4c_CodObs.Value = cursor_4c_BuscaObs.Codigos
                        ENDIF
                        IF PEMSTATUS(loc_oPg, "txt_4c_DesObs", 5)
                            loc_oPg.txt_4c_DesObs.Value = ALLTRIM(cursor_4c_BuscaObs.Descrs)
                            loc_oPg.txt_4c_DesObs.Enabled = .T.
                        ENDIF
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaObs")
                USE IN cursor_4c_BuscaObs
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro na busca de observa" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtDesObsKeyPress - F4 abre busca por descricao; ENTER/TAB valida
    *==========================================================================
    PROCEDURE TxtDesObsKeyPress(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDesObs()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDesObs()
            ENDIF
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarDesObs()
        LOCAL loc_oPg, loc_cDesc, loc_cSQL, loc_nResult
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        IF !PEMSTATUS(loc_oPg, "txt_4c_DesObs", 5)
            RETURN
        ENDIF
        loc_cDesc = ALLTRIM(loc_oPg.txt_4c_DesObs.Value)
        IF EMPTY(loc_cDesc)
            IF PEMSTATUS(loc_oPg, "txt_4c_CodObs", 5)
                loc_oPg.txt_4c_CodObs.Value = 0
            ENDIF
            RETURN
        ENDIF
        THIS.AbrirBuscaDesObs()
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaDesObs()
        LOCAL loc_oPg, loc_cValor, loc_oBusca, loc_oErro
        TRY
            loc_oPg   = THIS.pgf_4c_Paginas.Page1
            loc_cValor = IIF(PEMSTATUS(loc_oPg,"txt_4c_DesObs",5), ;
                             ALLTRIM(loc_oPg.txt_4c_DesObs.Value), "")
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdObs", "cursor_4c_BuscaObsD", "Descrs", loc_cValor, ;
                "Observa" + CHR(231) + CHR(227) + "o")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaObsD")
                        SELECT cursor_4c_BuscaObsD
                        IF PEMSTATUS(loc_oPg, "txt_4c_CodObs", 5)
                            loc_oPg.txt_4c_CodObs.Value = cursor_4c_BuscaObsD.Codigos
                        ENDIF
                        IF PEMSTATUS(loc_oPg, "txt_4c_DesObs", 5)
                            loc_oPg.txt_4c_DesObs.Value = ALLTRIM(cursor_4c_BuscaObsD.Descrs)
                        ENDIF
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Codigos", "XXX", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaObsD")
                        SELECT cursor_4c_BuscaObsD
                        IF PEMSTATUS(loc_oPg, "txt_4c_CodObs", 5)
                            loc_oPg.txt_4c_CodObs.Value = cursor_4c_BuscaObsD.Codigos
                        ENDIF
                        IF PEMSTATUS(loc_oPg, "txt_4c_DesObs", 5)
                            loc_oPg.txt_4c_DesObs.Value = ALLTRIM(cursor_4c_BuscaObsD.Descrs)
                        ENDIF
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaObsD")
                USE IN cursor_4c_BuscaObsD
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro na busca de observa" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtEmpresaKeyPress - F4=115 abre busca; ENTER/TAB valida empresa
    *==========================================================================
    PROCEDURE TxtEmpresaKeyPress(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresa()
            ENDIF
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarEmpresa()
        LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nResult
        loc_oPg  = THIS.pgf_4c_Paginas.Page1
        IF !PEMSTATUS(loc_oPg, "txt_4c__empresa", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c__empresa.Value)
        IF EMPTY(loc_cCod)
            IF PEMSTATUS(loc_oPg, "txt_4c__empresa_desc", 5)
                loc_oPg.txt_4c__empresa_desc.Value = ""
                loc_oPg.txt_4c__empresa_desc.Enabled = .F.
            ENDIF
            RETURN
        ENDIF
        loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
                   EscaparSQL(loc_cCod)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
        IF loc_nResult > 0
            SELECT cursor_4c_EmpVal
            IF !EOF()
                IF PEMSTATUS(loc_oPg, "txt_4c__empresa_desc", 5)
                    loc_oPg.txt_4c__empresa_desc.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
                    loc_oPg.txt_4c__empresa_desc.Enabled = .T.
                ENDIF
            ELSE
                IF USED("cursor_4c_EmpVal")
                    USE IN cursor_4c_EmpVal
                ENDIF
                THIS.AbrirBuscaEmpresa()
                RETURN
            ENDIF
            IF USED("cursor_4c_EmpVal")
                USE IN cursor_4c_EmpVal
            ENDIF
        ELSE
            THIS.AbrirBuscaEmpresa()
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oPg, loc_cValor, loc_oBusca, loc_oErro
        TRY
            loc_oPg   = THIS.pgf_4c_Paginas.Page1
            loc_cValor = IIF(PEMSTATUS(loc_oPg,"txt_4c__empresa",5), ;
                             ALLTRIM(loc_oPg.txt_4c__empresa.Value), "")
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValor, "Empresa")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaEmp")
                        SELECT cursor_4c_BuscaEmp
                        IF PEMSTATUS(loc_oPg, "txt_4c__empresa", 5)
                            loc_oPg.txt_4c__empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                        ENDIF
                        IF PEMSTATUS(loc_oPg, "txt_4c__empresa_desc", 5)
                            loc_oPg.txt_4c__empresa_desc.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                            loc_oPg.txt_4c__empresa_desc.Enabled = .T.
                        ENDIF
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "",    "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        SELECT cursor_4c_BuscaEmp
                        IF PEMSTATUS(loc_oPg, "txt_4c__empresa", 5)
                            loc_oPg.txt_4c__empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                        ENDIF
                        IF PEMSTATUS(loc_oPg, "txt_4c__empresa_desc", 5)
                            loc_oPg.txt_4c__empresa_desc.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                            loc_oPg.txt_4c__empresa_desc.Enabled = .T.
                        ENDIF
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro na busca de empresa")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtGrEstoqueKeyPress - F4 abre selecao; ENTER/TAB habilita conta
    *   GrEstoque e Estoque sao codigos de grupo/conta contabil.
    *   fAcessoContab/fAcessoContas nao migrados: campos aceitam texto livre.
    *==========================================================================
    PROCEDURE TxtGrEstoqueKeyPress(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarGrEstoque()
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarGrEstoque()
        LOCAL loc_oPg, loc_cCod
        loc_oPg  = THIS.pgf_4c_Paginas.Page1
        IF !PEMSTATUS(loc_oPg, "txt_4c__Cd_GrEstoque", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c__Cd_GrEstoque.Value)
        IF PEMSTATUS(loc_oPg, "txt_4c__Ds_GrEstoque", 5)
            loc_oPg.txt_4c__Ds_GrEstoque.Enabled = !EMPTY(loc_cCod)
            IF EMPTY(loc_cCod)
                loc_oPg.txt_4c__Ds_GrEstoque.Value = ""
            ENDIF
        ENDIF
        IF PEMSTATUS(loc_oPg, "txt_4c__cd_estoque", 5)
            loc_oPg.txt_4c__cd_estoque.Enabled = !EMPTY(loc_cCod)
            IF EMPTY(loc_cCod)
                loc_oPg.txt_4c__cd_estoque.Value = ""
                IF PEMSTATUS(loc_oPg, "txt_4c__ds_estoque", 5)
                    loc_oPg.txt_4c__ds_estoque.Value = ""
                    loc_oPg.txt_4c__ds_estoque.Enabled = .F.
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtGrdGrupoKeyPress - F4=115 abre busca Grande Grupo (SigCdGpr)
    *==========================================================================
    PROCEDURE TxtGrdGrupoKeyPress(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrdGrupo()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarGrdGrupoCod()
            ENDIF
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarGrdGrupoCod()
        LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nResult
        loc_oPg  = THIS.pgf_4c_Paginas.Page1
        IF !PEMSTATUS(loc_oPg, "txt_4c__cd_ggrupo", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c__cd_ggrupo.Value)
        IF EMPTY(loc_cCod)
            IF PEMSTATUS(loc_oPg, "txt_4c__ds_ggrupo", 5)
                loc_oPg.txt_4c__ds_ggrupo.Value = ""
                loc_oPg.txt_4c__ds_ggrupo.Enabled = .F.
            ENDIF
            RETURN
        ENDIF
        loc_cSQL = "SELECT codigos, descs FROM SigCdGpr " + ;
                   "WHERE CAST(codigos AS VARCHAR(5)) = " + EscaparSQL(loc_cCod)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GGruVal")
        IF loc_nResult > 0
            SELECT cursor_4c_GGruVal
            IF !EOF()
                IF PEMSTATUS(loc_oPg, "txt_4c__cd_ggrupo", 5)
                    loc_oPg.txt_4c__cd_ggrupo.Value = ;
                        ALLTRIM(STR(cursor_4c_GGruVal.codigos, 2))
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c__ds_ggrupo", 5)
                    loc_oPg.txt_4c__ds_ggrupo.Value = ALLTRIM(cursor_4c_GGruVal.descs)
                    loc_oPg.txt_4c__ds_ggrupo.Enabled = .T.
                ENDIF
            ELSE
                IF USED("cursor_4c_GGruVal")
                    USE IN cursor_4c_GGruVal
                ENDIF
                THIS.AbrirBuscaGrdGrupo()
                RETURN
            ENDIF
            IF USED("cursor_4c_GGruVal")
                USE IN cursor_4c_GGruVal
            ENDIF
        ELSE
            THIS.AbrirBuscaGrdGrupo()
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaGrdGrupo()
        LOCAL loc_oPg, loc_cValor, loc_oBusca, loc_oErro
        TRY
            loc_oPg   = THIS.pgf_4c_Paginas.Page1
            loc_cValor = IIF(PEMSTATUS(loc_oPg,"txt_4c__cd_ggrupo",5), ;
                             ALLTRIM(loc_oPg.txt_4c__cd_ggrupo.Value), "")
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGpr", "cursor_4c_BuscaGGru", "codigos", loc_cValor, ;
                "Grande Grupo")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaGGru")
                        SELECT cursor_4c_BuscaGGru
                        IF PEMSTATUS(loc_oPg, "txt_4c__cd_ggrupo", 5)
                            loc_oPg.txt_4c__cd_ggrupo.Value = ;
                                ALLTRIM(STR(cursor_4c_BuscaGGru.codigos, 2))
                        ENDIF
                        IF PEMSTATUS(loc_oPg, "txt_4c__ds_ggrupo", 5)
                            loc_oPg.txt_4c__ds_ggrupo.Value = ALLTRIM(cursor_4c_BuscaGGru.descs)
                            loc_oPg.txt_4c__ds_ggrupo.Enabled = .T.
                        ENDIF
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "",  "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descs",   "",  "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGGru")
                        SELECT cursor_4c_BuscaGGru
                        IF PEMSTATUS(loc_oPg, "txt_4c__cd_ggrupo", 5)
                            loc_oPg.txt_4c__cd_ggrupo.Value = ;
                                ALLTRIM(STR(cursor_4c_BuscaGGru.codigos, 2))
                        ENDIF
                        IF PEMSTATUS(loc_oPg, "txt_4c__ds_ggrupo", 5)
                            loc_oPg.txt_4c__ds_ggrupo.Value = ALLTRIM(cursor_4c_BuscaGGru.descs)
                            loc_oPg.txt_4c__ds_ggrupo.Enabled = .T.
                        ENDIF
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaGGru")
                USE IN cursor_4c_BuscaGGru
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro na busca de grande grupo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtGrdGrupoDescKeyPress - F4 abre busca por descricao do grande grupo
    *==========================================================================
    PROCEDURE TxtGrdGrupoDescKeyPress(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.ValidarGrdGrupoDesc()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarGrdGrupoDesc()
            ENDIF
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarGrdGrupoDesc()
        LOCAL loc_oPg, loc_cDesc, loc_oBusca, loc_oErro, loc_lContinuar
        loc_lContinuar = .T.
        TRY
            loc_oPg   = THIS.pgf_4c_Paginas.Page1
            IF !PEMSTATUS(loc_oPg, "txt_4c__ds_ggrupo", 5)
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                loc_cDesc = ALLTRIM(loc_oPg.txt_4c__ds_ggrupo.Value)
                IF EMPTY(loc_cDesc)
                    IF PEMSTATUS(loc_oPg, "txt_4c__cd_ggrupo", 5)
                        loc_oPg.txt_4c__cd_ggrupo.Value = ""
                    ENDIF
                    loc_lContinuar = .F.
                ENDIF
            ENDIF
            IF loc_lContinuar
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGpr", "cursor_4c_BuscaGGruD", "descs", loc_cDesc, ;
                    "Grande Grupo")
                IF VARTYPE(loc_oBusca) = "O"
                    IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                        IF USED("cursor_4c_BuscaGGruD")
                            SELECT cursor_4c_BuscaGGruD
                            IF PEMSTATUS(loc_oPg, "txt_4c__cd_ggrupo", 5)
                                loc_oPg.txt_4c__cd_ggrupo.Value = ;
                                    ALLTRIM(STR(cursor_4c_BuscaGGruD.codigos, 2))
                            ENDIF
                            IF PEMSTATUS(loc_oPg, "txt_4c__ds_ggrupo", 5)
                                loc_oPg.txt_4c__ds_ggrupo.Value = ;
                                    ALLTRIM(cursor_4c_BuscaGGruD.descs)
                            ENDIF
                        ENDIF
                    ELSE
                        IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGGruD")
                            SELECT cursor_4c_BuscaGGruD
                            IF PEMSTATUS(loc_oPg, "txt_4c__cd_ggrupo", 5)
                                loc_oPg.txt_4c__cd_ggrupo.Value = ;
                                    ALLTRIM(STR(cursor_4c_BuscaGGruD.codigos, 2))
                            ENDIF
                            IF PEMSTATUS(loc_oPg, "txt_4c__ds_ggrupo", 5)
                                loc_oPg.txt_4c__ds_ggrupo.Value = ;
                                    ALLTRIM(cursor_4c_BuscaGGruD.descs)
                            ENDIF
                        ENDIF
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaGGruD")
                    USE IN cursor_4c_BuscaGGruD
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro na busca de grande grupo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtGrupoKeyPress - F4=115 abre busca Grupo Produto (SigCdGrp)
    *==========================================================================
    PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrupo()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarGrupoCod()
            ENDIF
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarGrupoCod()
        LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nResult
        loc_oPg  = THIS.pgf_4c_Paginas.Page1
        IF !PEMSTATUS(loc_oPg, "txt_4c__grupo", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c__grupo.Value)
        IF EMPTY(loc_cCod)
            IF PEMSTATUS(loc_oPg, "txt_4c__grupo_desc", 5)
                loc_oPg.txt_4c__grupo_desc.Value = ""
                loc_oPg.txt_4c__grupo_desc.Enabled = .F.
            ENDIF
            RETURN
        ENDIF
        loc_cSQL = "SELECT CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
                   EscaparSQL(loc_cCod)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruVal")
        IF loc_nResult > 0
            SELECT cursor_4c_GruVal
            IF !EOF()
                IF PEMSTATUS(loc_oPg, "txt_4c__grupo_desc", 5)
                    loc_oPg.txt_4c__grupo_desc.Value = ALLTRIM(cursor_4c_GruVal.DGrus)
                    loc_oPg.txt_4c__grupo_desc.Enabled = .T.
                ENDIF
            ELSE
                IF USED("cursor_4c_GruVal")
                    USE IN cursor_4c_GruVal
                ENDIF
                THIS.AbrirBuscaGrupo()
                RETURN
            ENDIF
            IF USED("cursor_4c_GruVal")
                USE IN cursor_4c_GruVal
            ENDIF
        ELSE
            THIS.AbrirBuscaGrupo()
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaGrupo()
        LOCAL loc_oPg, loc_cValor, loc_oBusca, loc_oErro
        TRY
            loc_oPg   = THIS.pgf_4c_Paginas.Page1
            loc_cValor = IIF(PEMSTATUS(loc_oPg,"txt_4c__grupo",5), ;
                             ALLTRIM(loc_oPg.txt_4c__grupo.Value), "")
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrp", "cursor_4c_BuscaGru", "CGrus", loc_cValor, ;
                "Grupo de Produtos")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaGru")
                        SELECT cursor_4c_BuscaGru
                        IF PEMSTATUS(loc_oPg, "txt_4c__grupo", 5)
                            loc_oPg.txt_4c__grupo.Value = ALLTRIM(cursor_4c_BuscaGru.CGrus)
                        ENDIF
                        IF PEMSTATUS(loc_oPg, "txt_4c__grupo_desc", 5)
                            loc_oPg.txt_4c__grupo_desc.Value = ALLTRIM(cursor_4c_BuscaGru.DGrus)
                            loc_oPg.txt_4c__grupo_desc.Enabled = .T.
                        ENDIF
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CGrus", "XXX", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DGrus", "",    "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGru")
                        SELECT cursor_4c_BuscaGru
                        IF PEMSTATUS(loc_oPg, "txt_4c__grupo", 5)
                            loc_oPg.txt_4c__grupo.Value = ALLTRIM(cursor_4c_BuscaGru.CGrus)
                        ENDIF
                        IF PEMSTATUS(loc_oPg, "txt_4c__grupo_desc", 5)
                            loc_oPg.txt_4c__grupo_desc.Value = ALLTRIM(cursor_4c_BuscaGru.DGrus)
                            loc_oPg.txt_4c__grupo_desc.Enabled = .T.
                        ENDIF
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaGru")
                USE IN cursor_4c_BuscaGru
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro na busca de grupo de produtos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtGrupoDescKeyPress - F4/ENTER/TAB valida descricao do grupo produto
    *==========================================================================
    PROCEDURE TxtGrupoDescKeyPress(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarGrupoDesc()
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarGrupoDesc()
        LOCAL loc_oPg, loc_cDesc, loc_oBusca, loc_oErro, loc_lContinuar
        loc_lContinuar = .T.
        TRY
            loc_oPg   = THIS.pgf_4c_Paginas.Page1
            IF !PEMSTATUS(loc_oPg, "txt_4c__grupo_desc", 5)
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                loc_cDesc = ALLTRIM(loc_oPg.txt_4c__grupo_desc.Value)
                IF EMPTY(loc_cDesc)
                    IF PEMSTATUS(loc_oPg, "txt_4c__grupo", 5)
                        loc_oPg.txt_4c__grupo.Value = ""
                    ENDIF
                    loc_lContinuar = .F.
                ENDIF
            ENDIF
            IF loc_lContinuar
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGrp", "cursor_4c_BuscaGruD", "DGrus", loc_cDesc, ;
                    "Grupo de Produtos")
                IF VARTYPE(loc_oBusca) = "O"
                    IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                        IF USED("cursor_4c_BuscaGruD")
                            SELECT cursor_4c_BuscaGruD
                            IF PEMSTATUS(loc_oPg, "txt_4c__grupo", 5)
                                loc_oPg.txt_4c__grupo.Value = ALLTRIM(cursor_4c_BuscaGruD.CGrus)
                            ENDIF
                            IF PEMSTATUS(loc_oPg, "txt_4c__grupo_desc", 5)
                                loc_oPg.txt_4c__grupo_desc.Value = ALLTRIM(cursor_4c_BuscaGruD.DGrus)
                            ENDIF
                        ENDIF
                    ELSE
                        IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.mAddColuna("CGrus", "XXX", "C" + CHR(243) + "digo")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGruD")
                            SELECT cursor_4c_BuscaGruD
                            IF PEMSTATUS(loc_oPg, "txt_4c__grupo", 5)
                                loc_oPg.txt_4c__grupo.Value = ALLTRIM(cursor_4c_BuscaGruD.CGrus)
                            ENDIF
                            IF PEMSTATUS(loc_oPg, "txt_4c__grupo_desc", 5)
                                loc_oPg.txt_4c__grupo_desc.Value = ALLTRIM(cursor_4c_BuscaGruD.DGrus)
                            ENDIF
                        ENDIF
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaGruD")
                    USE IN cursor_4c_BuscaGruD
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro na busca de grupo de produtos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtSubGrupoKeyPress - F4=115 abre busca Subgrupo (SigCdPsg)
    *==========================================================================
    PROCEDURE TxtSubGrupoKeyPress(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaSubGrupo()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarSubGrupoCod()
            ENDIF
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarSubGrupoCod()
        LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nResult
        loc_oPg  = THIS.pgf_4c_Paginas.Page1
        IF !PEMSTATUS(loc_oPg, "txt_4c__cd_sgrupo", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c__cd_sgrupo.Value)
        IF EMPTY(loc_cCod)
            IF PEMSTATUS(loc_oPg, "txt_4c__ds_sgrupo", 5)
                loc_oPg.txt_4c__ds_sgrupo.Value = ""
                loc_oPg.txt_4c__ds_sgrupo.Enabled = .F.
            ENDIF
            RETURN
        ENDIF
        loc_cSQL = "SELECT Codigos, Descricaos, CGrus FROM SigCdPsg " + ;
                   "WHERE Codigos = " + EscaparSQL(loc_cCod)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SGruVal")
        IF loc_nResult > 0
            SELECT cursor_4c_SGruVal
            IF !EOF()
                IF PEMSTATUS(loc_oPg, "txt_4c__cd_sgrupo", 5)
                    loc_oPg.txt_4c__cd_sgrupo.Value = ALLTRIM(cursor_4c_SGruVal.Codigos)
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c__ds_sgrupo", 5)
                    loc_oPg.txt_4c__ds_sgrupo.Value = ALLTRIM(cursor_4c_SGruVal.Descricaos)
                    loc_oPg.txt_4c__ds_sgrupo.Enabled = .T.
                ENDIF
            ELSE
                IF USED("cursor_4c_SGruVal")
                    USE IN cursor_4c_SGruVal
                ENDIF
                THIS.AbrirBuscaSubGrupo()
                RETURN
            ENDIF
            IF USED("cursor_4c_SGruVal")
                USE IN cursor_4c_SGruVal
            ENDIF
        ELSE
            THIS.AbrirBuscaSubGrupo()
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaSubGrupo()
        LOCAL loc_oPg, loc_cValor, loc_oBusca, loc_oErro
        TRY
            loc_oPg   = THIS.pgf_4c_Paginas.Page1
            loc_cValor = IIF(PEMSTATUS(loc_oPg,"txt_4c__cd_sgrupo",5), ;
                             ALLTRIM(loc_oPg.txt_4c__cd_sgrupo.Value), "")
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPsg", "cursor_4c_BuscaSGru", "Codigos", loc_cValor, ;
                "Sub-Grupos")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaSGru")
                        SELECT cursor_4c_BuscaSGru
                        IF PEMSTATUS(loc_oPg, "txt_4c__cd_sgrupo", 5)
                            loc_oPg.txt_4c__cd_sgrupo.Value = ;
                                ALLTRIM(cursor_4c_BuscaSGru.Codigos)
                        ENDIF
                        IF PEMSTATUS(loc_oPg, "txt_4c__ds_sgrupo", 5)
                            loc_oPg.txt_4c__ds_sgrupo.Value = ;
                                ALLTRIM(cursor_4c_BuscaSGru.Descricaos)
                            loc_oPg.txt_4c__ds_sgrupo.Enabled = .T.
                        ENDIF
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos",    "XXXXXXXXXX", "Sub-Grupo")
                    loc_oBusca.mAddColuna("Descricaos", "XXXXXXXXXXXXXXXXXXXX", ;
                        "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("CGrus", "XXXXXXXXXX", "Grupo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGru")
                        SELECT cursor_4c_BuscaSGru
                        IF PEMSTATUS(loc_oPg, "txt_4c__cd_sgrupo", 5)
                            loc_oPg.txt_4c__cd_sgrupo.Value = ;
                                ALLTRIM(cursor_4c_BuscaSGru.Codigos)
                        ENDIF
                        IF PEMSTATUS(loc_oPg, "txt_4c__ds_sgrupo", 5)
                            loc_oPg.txt_4c__ds_sgrupo.Value = ;
                                ALLTRIM(cursor_4c_BuscaSGru.Descricaos)
                            loc_oPg.txt_4c__ds_sgrupo.Enabled = .T.
                        ENDIF
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaSGru")
                USE IN cursor_4c_BuscaSGru
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro na busca de subgrupo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtSubGrupoDescKeyPress - F4/ENTER/TAB valida descricao do subgrupo
    *==========================================================================
    PROCEDURE TxtSubGrupoDescKeyPress(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarSubGrupoDesc()
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarSubGrupoDesc()
        LOCAL loc_oPg, loc_cDesc, loc_oBusca, loc_oErro, loc_lContinuar
        loc_lContinuar = .T.
        TRY
            loc_oPg   = THIS.pgf_4c_Paginas.Page1
            IF !PEMSTATUS(loc_oPg, "txt_4c__ds_sgrupo", 5)
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                loc_cDesc = ALLTRIM(loc_oPg.txt_4c__ds_sgrupo.Value)
                IF EMPTY(loc_cDesc)
                    IF PEMSTATUS(loc_oPg, "txt_4c__cd_sgrupo", 5)
                        loc_oPg.txt_4c__cd_sgrupo.Value = ""
                    ENDIF
                    loc_lContinuar = .F.
                ENDIF
            ENDIF
            IF loc_lContinuar
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdPsg", "cursor_4c_BuscaSGruD", "Descricaos", loc_cDesc, ;
                    "Sub-Grupos")
                IF VARTYPE(loc_oBusca) = "O"
                    IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                        IF USED("cursor_4c_BuscaSGruD")
                            SELECT cursor_4c_BuscaSGruD
                            IF PEMSTATUS(loc_oPg, "txt_4c__cd_sgrupo", 5)
                                loc_oPg.txt_4c__cd_sgrupo.Value = ;
                                    ALLTRIM(cursor_4c_BuscaSGruD.Codigos)
                            ENDIF
                            IF PEMSTATUS(loc_oPg, "txt_4c__ds_sgrupo", 5)
                                loc_oPg.txt_4c__ds_sgrupo.Value = ;
                                    ALLTRIM(cursor_4c_BuscaSGruD.Descricaos)
                            ENDIF
                        ENDIF
                    ELSE
                        IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Descricaos", "XXXXXXXXXXXXXXXXXXXX", ;
                            "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.mAddColuna("Codigos",    "XXXXXXXXXX", "Sub-Grupo")
                        loc_oBusca.mAddColuna("CGrus",      "XXXXXXXXXX", "Grupo")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGruD")
                            SELECT cursor_4c_BuscaSGruD
                            IF PEMSTATUS(loc_oPg, "txt_4c__cd_sgrupo", 5)
                                loc_oPg.txt_4c__cd_sgrupo.Value = ;
                                    ALLTRIM(cursor_4c_BuscaSGruD.Codigos)
                            ENDIF
                            IF PEMSTATUS(loc_oPg, "txt_4c__ds_sgrupo", 5)
                                loc_oPg.txt_4c__ds_sgrupo.Value = ;
                                    ALLTRIM(cursor_4c_BuscaSGruD.Descricaos)
                            ENDIF
                        ENDIF
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaSGruD")
                    USE IN cursor_4c_BuscaSGruD
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro na busca de subgrupo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles do container visiveis (recursivo)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObj, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF
        IF !PEMSTATUS(par_oContainer, "ControlCount", 5)
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObj = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oObj) = "O"
                IF PEMSTATUS(loc_oObj, "Visible", 5)
                    loc_oObj.Visible = .T.
                ENDIF
                IF UPPER(loc_oObj.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObj.PageCount
                        THIS.TornarControlesVisiveis(loc_oObj.Pages(loc_nP))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oObj, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObj)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Aplica formatacao visual padrao ao grid de tipos
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        IF VARTYPE(par_oGrid) = "O"
            par_oGrid.FontName = "Verdana"
            par_oGrid.FontSize = 8
            par_oGrid.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Libera referencia ao BO de relatorio
    *   RelatorioBase herda de Custom (sem Release()) - usar .NULL.
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigReCmpBO.prg):
*==============================================================================
* SigReCmpBO.prg
* Business Object: Listagem de Composicao Por Movimentacao/OP (SIGRECMP)
* Herda de: RelatorioBase
* Tipo: REPORT
* Form legado: SigReCmp.SCX (frmrelatorio)
* Relatorios: SigReCp2.frx (agrupamento=1), SigReCp3.frx (agrupamento=2)
*==============================================================================

DEFINE CLASS SigReCmpBO AS RelatorioBase

    *-- Identificacao (sem tabela direta - relatorio)
    this_cTabela          = ""
    this_cCampoChave      = ""
    this_cMensagemErro    = ""

    *--------------------------------------------------------------------------
    * Filtros de data e periodo
    *--------------------------------------------------------------------------
    this_dDtInicial       = {}    && Data inicial do periodo
    this_dDtFinal         = {}    && Data final do periodo
    this_nOptData         = 1     && 1=Lancamento, 2=Prazo Entrega

    *--------------------------------------------------------------------------
    * Filtro de movimentacao
    *--------------------------------------------------------------------------
    this_cOperacao        = ""    && Codigo da movimentacao (max 20 chars)
    this_nNumes           = 0     && Numero da movimentacao (0=todos)

    *--------------------------------------------------------------------------
    * Filtro de OP (Ordem de Producao)
    *--------------------------------------------------------------------------
    this_lChkImpOp        = .F.   && .T. = filtrar por intervalo de OP
    this_nOpi             = 0     && OP inicial (0=sem filtro)
    this_nOpf             = 0     && OP final (0=sem limite, tratado como 999999)

    *--------------------------------------------------------------------------
    * Filtro de empresa
    *--------------------------------------------------------------------------
    this_cEmpresa         = ""    && Codigo da empresa (3 chars)
    this_cEmpresaDesc     = ""    && Descricao da empresa

    *--------------------------------------------------------------------------
    * Filtro de observacao
    *--------------------------------------------------------------------------
    this_nCodObs          = 0     && Codigo de observacao (0=todos)
    this_cDesObs          = ""    && Descricao da observacao

    *--------------------------------------------------------------------------
    * Filtro de grupo estoque / conta
    *--------------------------------------------------------------------------
    this_cGrEstoque       = ""    && Codigo do grupo estoque (10 chars)
    this_cGrEstoqueDesc   = ""    && Descricao do grupo estoque
    this_cEstoque         = ""    && Codigo da conta/estoque (10 chars)
    this_cEstoqueDesc     = ""    && Descricao da conta/estoque

    *--------------------------------------------------------------------------
    * Filtro de grande grupo
    *--------------------------------------------------------------------------
    this_cGrdGrupo        = ""    && Codigo do grande grupo (3 chars)
    this_cGrdGrupoDesc    = ""    && Descricao do grande grupo

    *--------------------------------------------------------------------------
    * Filtro de grupo produto
    *--------------------------------------------------------------------------
    this_cGrupo           = ""    && Codigo do grupo produto (3 chars)
    this_cGrupoDesc       = ""    && Descricao do grupo produto

    *--------------------------------------------------------------------------
    * Filtro de subgrupo
    *--------------------------------------------------------------------------
    this_cSubGrupo        = ""    && Codigo do subgrupo (6 chars)
    this_cSubGrupoDesc    = ""    && Descricao do subgrupo

    *--------------------------------------------------------------------------
    * Opcoes gerais de filtro e agrupamento
    *--------------------------------------------------------------------------
    this_nOpcaoSituacao   = 3     && OptSituas: 1=N.Ind., 2=Industrializada, 3=Todos
    this_nAgrupamento     = 1     && optagrupa: 1=por Composicao, 2=pela OP
    this_lServico         = .F.   && .T. = incluir industrializacao de servico
    this_lPendente        = .F.   && .T. = filtrar apenas pendentes
    this_lOrdem           = .F.   && .T. = filtrar por ordem de composicao

    *==========================================================================
    * Init - Inicializa o BO de relatorio (sem tabela direta)
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Nao aplicavel para relatorio
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *==========================================================================
    * InicializarDados
    * Cria e popula cursor_4c_TipoMov com tipos de movimentacao de SigCdTom.
    * Equivalente ao Load (CREATE CURSOR cs_SigCdTom) + parte do Init legado.
    * Deve ser chamado pelo form antes de exibir o grid de tipos.
    *==========================================================================
    PROCEDURE InicializarDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_TipoMov")
                USE IN cursor_4c_TipoMov
            ENDIF
            CREATE CURSOR cursor_4c_TipoMov (Marca N(1), Descri C(40), Codigos N(2))
            INDEX ON Codigos TAG Codigos

            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdTom"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TipoMovTemp") > 0
                SELECT cursor_4c_TipoMovTemp
                SCAN
                    INSERT INTO cursor_4c_TipoMov (Marca, Codigos, Descri) ;
                        VALUES (0, cursor_4c_TipoMovTemp.Codigos, ;
                                ALLTRIM(STR(cursor_4c_TipoMovTemp.Codigos, 2)) + "-" + ;
                                ALLTRIM(cursor_4c_TipoMovTemp.Descrs))
                ENDSCAN
                IF USED("cursor_4c_TipoMovTemp")
                    USE IN cursor_4c_TipoMovTemp
                ENDIF
            ENDIF
            SELECT cursor_4c_TipoMov
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterNomeRelatorio
    * Retorna nome do FRX conforme agrupamento selecionado
    *==========================================================================
    PROCEDURE ObterNomeRelatorio()
        IF THIS.this_nAgrupamento = 1
            RETURN "SigReCp2"
        ELSE
            RETURN "SigReCp3"
        ENDIF
    ENDPROC

    *==========================================================================
    * ObterMensagemErro
    * Retorna ultima mensagem de erro registrada
    *==========================================================================
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *==========================================================================
    * DesmarcarTodos
    * Remove marca de todos os tipos de movimentacao (equivalente ao btn apaga)
    *==========================================================================
    PROCEDURE DesmarcarTodos()
        IF USED("cursor_4c_TipoMov")
            SELECT cursor_4c_TipoMov
            REPLACE ALL Marca WITH 0
            GO TOP
        ENDIF
    ENDPROC

    *==========================================================================
    * MarcarTodos
    * Marca todos os tipos de movimentacao (equivalente ao btn SelTudo)
    *==========================================================================
    PROCEDURE MarcarTodos()
        IF USED("cursor_4c_TipoMov")
            SELECT cursor_4c_TipoMov
            REPLACE ALL Marca WITH 1
            GO TOP
        ENDIF
    ENDPROC

    *==========================================================================
    * PrepararDados
    * Executa processamento principal: seleciona movimentacoes e composicoes.
    * Equivalente ao metodo "processamento" do form legado SIGRECMP.
    * Popula cursores TmpRelat e dbCabecalho para uso pelo REPORT FORM.
    *==========================================================================
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        LOCAL loc_cOperacao, loc_nNume, loc_cEmpresa, loc_cGrupop
        LOCAL loc_cGrdGru, loc_cSubGru, loc_cGrupo, loc_cConta
        LOCAL loc_nOpcao, loc_lChkOp, loc_nNopi, loc_nNopf
        LOCAL loc_lServico, loc_lPendente, loc_nObs, loc_lOrdem
        LOCAL loc_cDtI, loc_cDtF, loc_cDatos
        LOCAL loc_llTipoSel, loc_cFilTipo, loc_cWhere, loc_cSQL
        LOCAL loc_cEmpresaDesc, loc_cNomeEmpresa
        LOCAL loc_cTitulo, loc_cPeriodo, loc_cSubTit, loc_cTot
        LOCAL loc_lcChave, loc_cGrupoRel, loc_cContaRel
        LOCAL loc_lnQtde, loc_lnPeso, loc_cDgru, loc_cNop
        LOCAL loc_nLnOpi, loc_nLnOpf, loc_nRegs, loc_cEmpPro, loc_cSqlPen
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            *-- Extrair valores dos filtros das propriedades do BO
            loc_cOperacao = PADR(ALLTRIM(THIS.this_cOperacao), 20)
            loc_nNume     = THIS.this_nNumes
            loc_cEmpresa  = THIS.this_cEmpresa
            loc_cGrupop   = PADR(ALLTRIM(THIS.this_cGrupo), 3)
            loc_cGrdGru   = THIS.this_cGrdGrupo
            loc_cSubGru   = THIS.this_cSubGrupo
            loc_cGrupo    = PADR(ALLTRIM(THIS.this_cGrEstoque), 10)
            loc_cConta    = PADR(ALLTRIM(THIS.this_cEstoque), 10)
            loc_nOpcao    = THIS.this_nOpcaoSituacao
            loc_lChkOp    = THIS.this_lChkImpOp
            loc_nNopi     = THIS.this_nOpi
            loc_nNopf     = IIF(THIS.this_nOpf = 0, 999999, THIS.this_nOpf)
            loc_lServico  = THIS.this_lServico
            loc_lPendente = THIS.this_lPendente
            loc_nObs      = THIS.this_nCodObs
            loc_lOrdem    = THIS.this_lOrdem

            *-- Formatar datas para SQL Server (pDtI/pDtF do legado)
            loc_cDatos = DTOS(THIS.this_dDtFinal)
            loc_cDtI   = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDtF   = "'" + LEFT(loc_cDatos, 4) + "-" + ;
                         SUBSTR(loc_cDatos, 5, 2) + "-" + ;
                         RIGHT(loc_cDatos, 2) + " 23:59:59'"

            *-- Verificar se ha tipos selecionados no grid de tipos
            loc_llTipoSel = .F.
            loc_cFilTipo  = ""
            IF USED("cursor_4c_TipoMov")
                SELECT cursor_4c_TipoMov
                GO TOP
                LOCATE FOR Marca = 1
                IF !EOF()
                    loc_llTipoSel = .T.
                ENDIF
            ENDIF

            *-- Fechar cursores de resultado anteriores
            IF USED("TmpRelat")
                USE IN TmpRelat
            ENDIF
            IF USED("dbCabecalho")
                USE IN dbCabecalho
            ENDIF
            IF USED("CrSigMvCab")
                USE IN CrSigMvCab
            ENDIF
            IF USED("CrSigCdEmp")
                USE IN CrSigCdEmp
            ENDIF
            IF USED("CrSigMvItn")
                USE IN CrSigMvItn
            ENDIF
            IF USED("CrSigOpPic")
                USE IN CrSigOpPic
            ENDIF

            *-- Buscar empresas para cabecalho e processamento
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp" + ;
                       IIF(EMPTY(loc_cEmpresa), "", " WHERE Cemps = " + EscaparSQL(loc_cEmpresa))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdEmp") < 1
                THIS.this_cMensagemErro = "Erro ao carregar empresas"
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                SELECT CrSigCdEmp
                GO TOP
                loc_cEmpresaDesc = IIF(EOF(), "", ALLTRIM(CrSigCdEmp.Razas))

            *-- Buscar razao social da empresa logada no sistema
            loc_cNomeEmpresa = ""
            loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpSis") > 0
                SELECT cursor_4c_EmpSis
                IF !EOF()
                    loc_cNomeEmpresa = ALLTRIM(cursor_4c_EmpSis.Razas)
                ENDIF
                USE IN cursor_4c_EmpSis
            ENDIF

            *-- Montar textos do cabecalho do relatorio
            loc_cTitulo  = "Listagem de Composi" + CHR(231) + CHR(227) + ;
                           "o por Movimenta" + CHR(231) + CHR(227) + "o ( " + ;
                           ALLTRIM(loc_cOperacao) + ;
                           IIF(loc_nNume <> 0, ": " + ALLTRIM(STR(loc_nNume, 6)), "") + " )"
            loc_cPeriodo = "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDtInicial) + ;
                           " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal) + " - " + ;
                           IIF(EMPTY(loc_cEmpresa), "Geral", ;
                               "Empresa: " + loc_cEmpresa + " - " + ALLTRIM(loc_cEmpresaDesc))
            loc_cSubTit  = IIF(loc_nNopi <> 0, ;
                               "OP: " + ALLTRIM(STR(loc_nNopi, 6)) + ;
                               " " + CHR(224) + " " + ALLTRIM(STR(loc_nNopf, 6)), ;
                               "")

            *-- Criar cursor de cabecalho (dbCabecalho legado)
            CREATE CURSOR dbCabecalho ;
                (NomeEmpresa C(80), Titulo C(80), Periodo C(150), ;
                 SubTitulo C(80), lCompo L, Total M(4))
            INSERT INTO dbCabecalho (NomeEmpresa, Titulo, Periodo, SubTitulo) ;
                VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo, loc_cSubTit)

            *-- Criar cursor de resultado principal (TmpRelat legado)
            CREATE CURSOR TmpRelat ;
                (Emps C(3), Razas C(40), CGrus C(3), DGrus C(20), ;
                 Grupo C(10), Conta C(10), DConta C(40), Tps C(1), ;
                 CPros C(14), DPros C(40), cUnis C(3), Qtds N(12, 3), ;
                 QtPds N(10), Pesoms N(8, 4), Pesos N(12, 3), ;
                 Datas D(8), NDias N(8), Imps N(1), reffs C(40), ;
                 Mats C(14), DMats C(40), unicompos C(3), cunips C(3), ;
                 Nops C(10), ObsOfs C(50), RefMats C(20))
            INDEX ON Grupo + Conta + Emps + CPros TAG EmpCPro
            INDEX ON Grupo + Conta + Emps + Tps + CGrus + CPros TAG EmpCGruPro
            INDEX ON Grupo + Conta + Emps + Tps + CGrus + CPros TAG EGP
            INDEX ON Mats + Reffs + CPros TAG MatRef
            INDEX ON CPros + Nops + Mats + Reffs TAG CproMatRef

            *-- ==============================================================
            *-- MONTAR WHERE para consulta de movimentacoes (SigMvCab)
            *-- ==============================================================
            loc_cWhere = ""
            IF loc_lChkOp
                *-- Filtro por intervalo de OP (chkImpOp marcado)
                loc_cWhere = " a.Nops BETWEEN " + ALLTRIM(STR(loc_nNopi)) + ;
                             " AND " + ALLTRIM(STR(loc_nNopf)) + ;
                             " AND b.produc = 1"
                IF !EMPTY(loc_cEmpresa)
                    loc_cWhere = loc_cWhere + " AND a.Emps = " + EscaparSQL(loc_cEmpresa)
                ENDIF
            ELSE
                *-- Filtro por operacao e datas
                IF !EMPTY(ALLTRIM(loc_cOperacao))
                    loc_cWhere = " a.Dopes = " + EscaparSQL(ALLTRIM(loc_cOperacao))
                ENDIF
                IF EMPTY(ALLTRIM(loc_cOperacao)) AND !loc_llTipoSel
                    loc_cWhere = loc_cWhere + ;
                                 IIF(EMPTY(loc_cWhere), "", " AND ") + " b.produc = 1"
                ENDIF
                IF loc_nNume <> 0
                    loc_cWhere = loc_cWhere + ;
                                 IIF(EMPTY(loc_cWhere), "", " AND ") + ;
                                 " a.Numes = " + ALLTRIM(STR(loc_nNume, 6))
                ENDIF
                IF loc_nNume = 0
                    IF THIS.this_nOptData = 1
                        loc_cWhere = loc_cWhere + ;
                                     IIF(EMPTY(loc_cWhere), "", " AND ") + ;
                                     " a.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF
                    ELSE
                        loc_cWhere = loc_cWhere + ;
                                     IIF(EMPTY(loc_cWhere), "", " AND ") + ;
                                     " a.PrazoEnts BETWEEN " + loc_cDtI + " AND " + loc_cDtF
                    ENDIF
                ENDIF
                IF !EMPTY(loc_cEmpresa)
                    loc_cWhere = loc_cWhere + ;
                                 IIF(EMPTY(loc_cWhere), "", " AND ") + ;
                                 " a.Emps = " + EscaparSQL(loc_cEmpresa)
                ENDIF
                IF loc_nOpcao = 1
                    loc_cWhere = loc_cWhere + ;
                                 IIF(EMPTY(loc_cWhere), "", " AND ") + " a.Nops = 0"
                ENDIF
                IF loc_nOpcao = 2
                    loc_cWhere = loc_cWhere + ;
                                 IIF(EMPTY(loc_cWhere), "", " AND ") + " a.Nops <> 0"
                ENDIF
            ENDIF

            *-- Adicionar filtro pelos tipos de movimentacao selecionados no grid
            IF USED("cursor_4c_TipoMov") AND loc_llTipoSel
                SELECT cursor_4c_TipoMov
                GO TOP
                SCAN FOR Marca = 1
                    IF EMPTY(loc_cFilTipo)
                        loc_cFilTipo = ALLTRIM(STR(cursor_4c_TipoMov.Codigos))
                    ELSE
                        loc_cFilTipo = loc_cFilTipo + "," + ;
                                       ALLTRIM(STR(cursor_4c_TipoMov.Codigos))
                    ENDIF
                ENDSCAN
            ENDIF
            IF !EMPTY(loc_cFilTipo)
                loc_cWhere = loc_cWhere + ;
                             IIF(EMPTY(loc_cWhere), "", " AND ") + ;
                             " b.TipoOps IN (" + loc_cFilTipo + ")"
            ENDIF

            *-- ==============================================================
            *-- SELECIONAR MOVIMENTACOES (SigMvCab JOIN SigCdOpe)
            *-- ==============================================================
            WAIT WINDOW "Aguarde! Selecionando Movimenta" + ;
                        CHR(231) + CHR(245) + "es..." NOWAIT

            loc_cSQL = "SELECT a.Emps, a.Dopes, a.Numes, a.Datas, " + ;
                       "a.GrupoOs, a.ContaOs, a.GrupoDs, a.ContaDs, " + ;
                       "a.EmpDopNums, a.Nops, b.Globalizas, b.Servicos " + ;
                       "FROM SigMvCab a INNER JOIN SigCdOpe b ON a.Dopes = b.Dopes"
            IF !EMPTY(loc_cWhere)
                loc_cSQL = loc_cSQL + " WHERE " + loc_cWhere
            ENDIF
            IF loc_nObs <> 0
                loc_cSQL = loc_cSQL + ;
                           IIF(!EMPTY(loc_cWhere), " AND", " WHERE") + ;
                           " a.CodObs = " + ALLTRIM(STR(loc_nObs))
            ENDIF
            loc_cSQL = loc_cSQL + ;
                       " ORDER BY a.Emps, a.Dopes, a.Numes, a.Datas, " + ;
                       "a.GrupoOs, a.ContaOs, a.GrupoDs, a.ContaDs, a.EmpDopNums"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigMvCab") < 1
                THIS.this_cMensagemErro = "Erro ao carregar movimenta" + ;
                                          CHR(231) + CHR(245) + "es"
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
            SELECT CrSigMvCab
            INDEX ON EmpDopNums TAG EmpDopNums
            GO TOP
            WAIT CLEAR

            *-- ==============================================================
            *-- PROCESSAR POR EMPRESA
            *-- ==============================================================
            SELECT CrSigCdEmp
            GO TOP
            SCAN
                loc_cEmpPro = CrSigCdEmp.Cemps

                SELECT CrSigMvCab
                COUNT FOR Emps = loc_cEmpPro TO loc_nRegs
                GO TOP

                IF SEEK(loc_cEmpPro, "CrSigMvCab", "EmpDopNums")
                    WAIT WINDOW "Verificando Movimenta" + CHR(231) + ;
                                CHR(245) + "es..." NOWAIT

                    SCAN WHILE CrSigMvCab.Emps = loc_cEmpPro
                        loc_cGrupoRel = ""
                        loc_cContaRel = ""

                        *-- Pular industrializacoes de servico se nao marcado
                        IF !loc_lServico AND EMPTY(ALLTRIM(loc_cOperacao)) AND ;
                           INLIST(CrSigMvCab.Servicos, 1, 2)
                            LOOP
                        ENDIF

                        *-- Filtrar por grupo/conta estoque se informados
                        IF !EMPTY(ALLTRIM(loc_cGrupo)) OR !EMPTY(ALLTRIM(loc_cConta))
                            IF CrSigMvCab.Globalizas = 1 OR CrSigMvCab.Servicos = 1
                                IF !EMPTY(ALLTRIM(loc_cGrupo)) AND ;
                                   (loc_cGrupo <> CrSigMvCab.GrupoOs)
                                    SELECT CrSigMvCab
                                    LOOP
                                ENDIF
                                IF !EMPTY(ALLTRIM(loc_cConta)) AND ;
                                   (loc_cConta <> CrSigMvCab.ContaOs)
                                    SELECT CrSigMvCab
                                    LOOP
                                ENDIF
                                loc_cGrupoRel = CrSigMvCab.GrupoOs
                                loc_cContaRel = CrSigMvCab.ContaOs
                            ENDIF
                            IF CrSigMvCab.Globalizas = 2 OR CrSigMvCab.Servicos = 2
                                IF !EMPTY(ALLTRIM(loc_cGrupo)) AND ;
                                   (loc_cGrupo <> CrSigMvCab.GrupoDs)
                                    SELECT CrSigMvCab
                                    LOOP
                                ENDIF
                                IF !EMPTY(ALLTRIM(loc_cConta)) AND ;
                                   (loc_cConta <> CrSigMvCab.ContaDs)
                                    SELECT CrSigMvCab
                                    LOOP
                                ENDIF
                                loc_cGrupoRel = CrSigMvCab.GrupoDs
                                loc_cContaRel = CrSigMvCab.ContaDs
                            ENDIF
                        ELSE
                            loc_cGrupoRel = SPACE(10)
                            loc_cContaRel = SPACE(10)
                        ENDIF

                        loc_lcChave = CrSigMvCab.EmpDopNums

                        *-- Fechar cursor de itens da iteracao anterior
                        IF USED("CrSigMvItn")
                            USE IN CrSigMvItn
                        ENDIF

                        *-- ======================================================
                        *-- QUERY DE COMPONENTES DA MOVIMENTACAO (UNION ALL)
                        *-- Parte 1: Componentes diretos (SigSubMv + SigMvItn)
                        *-- ======================================================
                        loc_cSQL = "SELECT a.mats, a.CPros, a.Pesos, a.Qtds, a.QtBaixas, " + ;
                                   "b.Dpros AS Dmats, b.CGrus, b.CUnis, b.PesoMs, b.CustoFs, " + ;
                                   "b.Reffs AS RefMats, c.DGrus, d.FatDivs, b.Reffs, e.Dpros, " + ;
                                   "a.cunis AS unicompos, a.cunips, " + ;
                                   "CASE WHEN g.Qtds IS NULL THEN f.Qtds ELSE g.Qtds END AS QtdPed, " + ;
                                   "d.Fators, f.Citens, SPACE(50) AS ObsOFs, a.EmpDopNums, " + ;
                                   "CASE WHEN g.CodCors IS NULL THEN SPACE(4) " + ;
                                   "ELSE g.CodCors END AS CodCors, " + ;
                                   "CASE WHEN g.CodTams IS NULL THEN SPACE(4) " + ;
                                   "ELSE g.CodTams END AS CodTams " + ;
                                   "FROM SigSubMv a " + ;
                                   "INNER JOIN SigCdPro e ON e.Cpros = a.Cpros " + ;
                                   "INNER JOIN SigMvItn f ON f.empdopnums = a.empdopnums " + ;
                                   "AND f.citens = a.citem2 " + ;
                                   "INNER JOIN SigCdPro b ON b.CPros = a.mats " + ;
                                   "LEFT JOIN SigCdGrp c ON c.CGrus = b.CGrus " + ;
                                   "LEFT JOIN SigCdUni d ON d.CUnis = b.CUnis " + ;
                                   "LEFT JOIN SigMvIts g ON g.EmpDopNums = f.EmpDopNums " + ;
                                   "AND g.Citens = f.Citens " + ;
                                   "WHERE a.empdopnums = " + EscaparSQL(loc_lcChave)
                        IF !EMPTY(ALLTRIM(loc_cGrdGru))
                            loc_cSQL = loc_cSQL + ;
                                       " AND b.Mercs = " + EscaparSQL(ALLTRIM(loc_cGrdGru))
                        ENDIF
                        IF !EMPTY(ALLTRIM(loc_cGrupop))
                            loc_cSQL = loc_cSQL + ;
                                       " AND b.CGrus = " + EscaparSQL(ALLTRIM(loc_cGrupop))
                        ENDIF
                        IF !EMPTY(ALLTRIM(loc_cSubGru))
                            loc_cSQL = loc_cSQL + ;
                                       " AND b.SGrus = " + EscaparSQL(ALLTRIM(loc_cSubGru))
                        ENDIF

                        *-- Parte 2: Componentes do plano (SigPrCpo + SigMvItn)
                        loc_cSQL = loc_cSQL + ;
                                   " UNION ALL " + ;
                                   "SELECT a.mats, a.CPros, " + ;
                                   "CASE WHEN h.Pesos IS NULL THEN a.Pesos ELSE h.Pesos END AS Pesos, " + ;
                                   "CASE WHEN h.Qtds IS NULL THEN a.Qtds ELSE h.Qtds END AS Qtds, " + ;
                                   "0 AS QtBaixas, b.Dpros AS DMats, b.CGrus, b.CUnis, " + ;
                                   "b.PesoMs, b.CustoFs, b.Reffs AS RefMats, c.DGrus, " + ;
                                   "d.FatDivs, f.reffs, e.Dpros, a.unicompos, a.cunips, " + ;
                                   "CASE WHEN g.Qtds IS NULL THEN e.Qtds ELSE g.Qtds END AS QtdPed, " + ;
                                   "d.Fators, e.Citens, CAST(a.ObsOFs AS CHAR(50)) AS ObsOFs, " + ;
                                   "e.EmpDopNums, " + ;
                                   "CASE WHEN g.CodCors IS NULL THEN SPACE(4) " + ;
                                   "ELSE g.CodCors END AS CodCors, " + ;
                                   "CASE WHEN g.CodTams IS NULL THEN SPACE(4) " + ;
                                   "ELSE g.CodTams END AS CodTams " + ;
                                   "FROM SigMvItn e " + ;
                                   "LEFT JOIN SigMvIts g ON e.EmpDopNums = g.EmpDopNums " + ;
                                   "AND e.Citens = g.Citens " + ;
                                   "INNER JOIN SigPrCpo a ON e.cpros = a.cpros " + ;
                                   "LEFT JOIN SigSubCp h ON a.Cpros = h.Cpros " + ;
                                   "AND a.Mats = h.Mats AND h.CodTams = g.CodTams " + ;
                                   "INNER JOIN SigCdPro f ON e.Cpros = f.Cpros " + ;
                                   "INNER JOIN SigCdPro b ON b.CPros = a.mats " + ;
                                   "LEFT JOIN SigCdGrp c ON c.CGrus = b.CGrus " + ;
                                   "LEFT JOIN SigCdUni d ON d.CUnis = b.CUnis " + ;
                                   "WHERE e.empdopnums = " + EscaparSQL(loc_lcChave)
                        IF !EMPTY(ALLTRIM(loc_cGrdGru))
                            loc_cSQL = loc_cSQL + ;
                                       " AND b.Mercs = " + EscaparSQL(ALLTRIM(loc_cGrdGru))
                        ENDIF
                        IF !EMPTY(ALLTRIM(loc_cGrupop))
                            loc_cSQL = loc_cSQL + ;
                                       " AND b.CGrus = " + EscaparSQL(ALLTRIM(loc_cGrupop))
                        ENDIF
                        IF !EMPTY(ALLTRIM(loc_cSubGru))
                            loc_cSQL = loc_cSQL + ;
                                       " AND b.SGrus = " + EscaparSQL(ALLTRIM(loc_cSubGru))
                        ENDIF
                        IF loc_lOrdem
                            loc_cSQL = loc_cSQL + " AND a.OrdTs = 0"
                        ENDIF
                        loc_cSQL = loc_cSQL + ;
                                   " AND e.citens NOT IN (" + ;
                                   "SELECT e.citens FROM SigMvItn e, SigSubMv a " + ;
                                   "WHERE e.empdopnums = " + EscaparSQL(loc_lcChave) + ;
                                   " AND e.empdopnums = a.empdopnums " + ;
                                   "AND e.citens = a.citem2 GROUP BY e.citens)"

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigMvItn") < 1
                            SELECT CrSigMvCab
                            LOOP
                        ENDIF
                        SELECT CrSigMvItn
                        INDEX ON CPros + STR(Pesos, 12, 3) + STR(Qtds, 12, 3) TAG Ordem

                        *-- Buscar dados de OP se a movimentacao possuir Nops
                        IF !EMPTY(CrSigMvCab.Nops)
                            loc_nLnOpi = CrSigMvCab.Nops * 10000
                            loc_nLnOpf = (CrSigMvCab.Nops + 1) * 10000

                            IF USED("CrSigOpPic")
                                USE IN CrSigOpPic
                            ENDIF

                            loc_cSQL = "SELECT a.Nops, a.cpros, a.Emps, a.empdopnops, " + ;
                                       "a.EmpDopNums, SUM(a.qtds) AS Qtds, " + ;
                                       "a.codcors, a.CodTams, b.descs AS desccors, a.citens " + ;
                                       "FROM SigOpPic a " + ;
                                       "LEFT JOIN SigCdCor b ON a.codcors = b.cods " + ;
                                       "WHERE a.Nops BETWEEN " + ;
                                       ALLTRIM(STR(loc_nLnOpi, 10)) + ;
                                       " AND " + ALLTRIM(STR(loc_nLnOpf, 10)) + ;
                                       " AND a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                                       " GROUP BY a.Nops, a.cpros, a.emps, a.empdopnops, " + ;
                                       "a.EmpDopNums, a.codcors, a.CodTams, b.descs, a.citens"

                            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpPic") > 0
                                SELECT CrSigOpPic
                                INDEX ON STR(Citens, 4) + Cpros + STR(Nops, 10) TAG CproNop
                                INDEX ON STR(Citens, 4) + Cpros + CodCors + ;
                                         CodTams + EmpDopNums + STR(Nops, 10) TAG CproNop2
                            ENDIF
                        ENDIF

                        *-- ======================================================
                        *-- ITERAR SOBRE OS COMPONENTES E ACUMULAR EM TmpRelat
                        *-- ======================================================
                        SELECT CrSigMvItn
                        GO TOP
                        SCAN
                            loc_cNop = ""

                            IF !EMPTY(CrSigMvCab.Nops) AND USED("CrSigOpPic")
                                *-- Com OP: usar quantidades do SigOpPic
                                SELECT CrSigOpPic
                                =SEEK(STR(CrSigMvItn.Citens, 4) + CrSigMvItn.Cpros + ;
                                      CrSigMvItn.CodCors + CrSigMvItn.CodTams + ;
                                      CrSigMvItn.EmpDopNums, "CrSigOpPic", "CproNop2")

                                SCAN FOR CrSigOpPic.Cpros = CrSigMvItn.Cpros AND ;
                                         CrSigOpPic.Citens = CrSigMvItn.Citens AND ;
                                         CrSigOpPic.EmpDopNums = CrSigMvItn.EmpDopNums AND ;
                                         CrSigOpPic.CodCors = CrSigMvItn.CodCors AND ;
                                         CrSigOpPic.CodTams = CrSigMvItn.CodTams

                                                IF loc_lPendente
                                        loc_cSqlPen = "SELECT ChkSubn FROM SigCdNec " + ;
                                                      "WHERE EmpDnPs = " + ;
                                                      EscaparSQL(ALLTRIM(CrSigOpPic.EmpdopNops))
                                        IF SQLEXEC(gnConnHandle, loc_cSqlPen, "TmpNens") > 0
                                            SELECT TmpNens
                                            IF !EOF() AND TmpNens.ChkSubn
                                                IF USED("TmpNens")
                                                    USE IN TmpNens
                                                ENDIF
                                                SELECT CrSigOpPic
                                                LOOP
                                            ENDIF
                                            IF USED("TmpNens")
                                                USE IN TmpNens
                                            ENDIF
                                        ENDIF
                                    ENDIF

                                    loc_lnQtde = ROUND(CrSigOpPic.Qtds * CrSigMvItn.Qtds, 3)
                                    loc_lnPeso = ROUND(CrSigOpPic.Qtds * CrSigMvItn.Pesos, 3)
                                    loc_cDgru  = NVL(CrSigMvItn.DGrus, "")
                                    loc_cNop   = IIF(THIS.this_nAgrupamento = 2, ;
                                                     ALLTRIM(STR(CrSigOpPic.Nops)), "")

                                    SELECT TmpRelat
                                    SET ORDER TO CproMatRef
                                    IF !SEEK(CrSigMvItn.Cpros + PADR(loc_cNop, 10) + ;
                                             CrSigMvItn.Mats + CrSigMvItn.Reffs, ;
                                             "TmpRelat", "CproMatRef")
                                        INSERT INTO TmpRelat ;
                                            (Grupo, Conta, Emps, Razas, CGrus, DGrus, ;
                                             CPros, DPros, Cunis, Pesoms, reffs, Mats, ;
                                             Dmats, unicompos, cunips, Nops, ObsOfs, RefMats) ;
                                            VALUES (loc_cGrupoRel, loc_cContaRel, ;
                                                    CrSigMvCab.Emps, CrSigCdEmp.Razas, ;
                                                    CrSigMvItn.CGrus, loc_cDgru, ;
                                                    CrSigMvItn.CPros, CrSigMvItn.DPros, ;
                                                    CrSigMvItn.Cunis, loc_lnPeso, ;
                                                    CrSigMvItn.Reffs, CrSigMvItn.Mats, ;
                                                    CrSigMvItn.DMats, CrSigMvItn.unicompos, ;
                                                    CrSigMvItn.cunips, loc_cNop, ;
                                                    CrSigMvItn.ObsOfs, CrSigMvItn.RefMats)
                                    ENDIF
                                    REPLACE Qtds  WITH TmpRelat.Qtds + loc_lnQtde, ;
                                            Pesos WITH TmpRelat.Pesos + loc_lnPeso ;
                                            IN TmpRelat
                                    SELECT CrSigOpPic
                                ENDSCAN

                            ELSE
                                *-- Sem OP: usar quantidade do pedido (QtdPed do SigMvItn)
                                loc_lnQtde = ROUND(CrSigMvItn.QtdPed * CrSigMvItn.Qtds, 3)
                                loc_lnPeso = ROUND(CrSigMvItn.QtdPed * CrSigMvItn.Pesos, 3)
                                loc_cDgru  = NVL(CrSigMvItn.DGrus, "")

                                SELECT TmpRelat
                                SET ORDER TO EmpCPro

                                IF !SEEK(CrSigMvItn.Cpros + SPACE(10) + ;
                                         CrSigMvItn.Mats + CrSigMvItn.Reffs, ;
                                         "TmpRelat", "CproMatRef")
                                    INSERT INTO TmpRelat ;
                                        (Grupo, Conta, Emps, Razas, CGrus, DGrus, ;
                                         CPros, DPros, Cunis, Pesoms, reffs, Mats, ;
                                         Dmats, unicompos, cunips, Nops, ObsOfs, RefMats) ;
                                        VALUES (loc_cGrupoRel, loc_cContaRel, ;
                                                CrSigMvCab.Emps, CrSigCdEmp.Razas, ;
                                                CrSigMvItn.CGrus, loc_cDgru, ;
                                                CrSigMvItn.CPros, CrSigMvItn.DPros, ;
                                                CrSigMvItn.Cunis, loc_lnPeso, ;
                                                CrSigMvItn.Reffs, CrSigMvItn.Mats, ;
                                                CrSigMvItn.DMats, CrSigMvItn.unicompos, ;
                                                CrSigMvItn.cunips, loc_cNop, ;
                                                CrSigMvItn.ObsOfs, CrSigMvItn.RefMats)
                                ENDIF
                                REPLACE Qtds  WITH TmpRelat.Qtds + loc_lnQtde, ;
                                        Pesos WITH TmpRelat.Pesos + loc_lnPeso ;
                                        IN TmpRelat
                            ENDIF

                            SELECT CrSigMvItn
                        ENDSCAN

                        SELECT CrSigMvCab
                    ENDSCAN

                    WAIT CLEAR
                ENDIF

                SELECT CrSigCdEmp
            ENDSCAN

            *-- ==============================================================
            *-- POS-PROCESSAMENTO: limpeza, totais e ordenacao
            *-- ==============================================================

            *-- Remover registros sem movimentacao real
            DELETE FROM TmpRelat WHERE Qtds <= 0 AND Pesos <= 0
            LOCATE FOR .F.

            *-- Calcular totais por unidade de medida para cabecalho
            SELECT UniCompos, SUM(Qtds) AS Qtds, CUniPs, SUM(Pesos) AS Pesos ;
                FROM TmpRelat ;
                GROUP BY UniCompos, CUniPs ;
                INTO CURSOR crTotFims READWRITE

            loc_cTot = "  Qtd 1. Ped.  |Uni|  Qtd 2. Ped. |Uni|"
            IF USED("crTotFims")
                SELECT crTotFims
                GO TOP
                SCAN
                    loc_cTot = loc_cTot + CHR(13) + ;
                               TRANSFORM(crTotFims.Qtds, "999,999,999.999") + "|" + ;
                               ALLTRIM(crTotFims.UniCompos) + "|" + ;
                               TRANSFORM(crTotFims.Pesos, "99,999,999.999") + "|" + ;
                               ALLTRIM(crTotFims.CUniPs) + "|"
                ENDSCAN
                USE IN crTotFims
            ENDIF

            SELECT dbCabecalho
            GO TOP
            REPLACE Total WITH Total + loc_cTot IN dbCabecalho

            *-- Ordenar TmpRelat conforme agrupamento selecionado
            SELECT TmpRelat
            IF THIS.this_nAgrupamento = 1
                SET ORDER TO MatRef
            ELSE
                SET ORDER TO CproMatRef
            ENDIF
            GO TOP

            loc_lSucesso = .T.
            ENDIF && loc_lContinuar (CrSigMvCab)
            ENDIF && loc_lContinuar (CrSigCdEmp)

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            WAIT CLEAR
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Visualizar
    * Executa PrepararDados e exibe relatorio em modo Preview (visualizacao)
    * Equivalente ao metodo "visualizacao" do form legado
    *==========================================================================
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cFrx, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + THIS.ObterNomeRelatorio()
                REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Imprimir
    * Executa PrepararDados e imprime com dialogo de selecao de impressora
    * Equivalente ao metodo "impressao" do form legado
    *==========================================================================
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cFrx, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + THIS.ObterNomeRelatorio()
                REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GerarDocumento
    * Executa PrepararDados e envia direto para impressora (sem dialogo)
    * Equivalente ao metodo "documento" do form legado
    *==========================================================================
    PROCEDURE GerarDocumento()
        LOCAL loc_lSucesso, loc_cFrx, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + THIS.ObterNomeRelatorio()
                REPORT FORM (loc_cFrx) TO PRINTER NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RegistrarAuditoria
    * Registra operacao no log de auditoria (uso em Inserir/Atualizar)
    * Em BO de RELATORIO nao ha persistencia, portanto registra apenas leitura
    *==========================================================================
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, DataHora, Operacao, Tabela, ChavePrimaria) " + ;
                       "VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL("SigReCmp") + ", " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor
    * NAO APLICAVEL para BO de relatorio (sem tabela direta).
    * Mantido como stub para compatibilidade com pipeline de migracao.
    * Relatorios obtem dados via PrepararDados() agregando multiplas tabelas.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        THIS.this_cMensagemErro = "CarregarDoCursor n" + CHR(227) + ;
                                   "o aplic" + CHR(225) + "vel para relat" + ;
                                   CHR(243) + "rio"
        RETURN .F.
    ENDPROC

    *==========================================================================
    * Inserir
    * NAO APLICAVEL para BO de relatorio (apenas leitura).
    * Mantido como stub para compatibilidade com pipeline de migracao.
    * Auditoria de execucao do relatorio eh registrada em PrepararDados.
    *==========================================================================
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Inserir n" + CHR(227) + ;
                                   "o aplic" + CHR(225) + ;
                                   "vel para relat" + CHR(243) + "rio"
        RETURN .F.
    ENDPROC

    *==========================================================================
    * Atualizar
    * NAO APLICAVEL para BO de relatorio (apenas leitura).
    * Mantido como stub para compatibilidade com pipeline de migracao.
    *==========================================================================
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Atualizar n" + CHR(227) + ;
                                   "o aplic" + CHR(225) + ;
                                   "vel para relat" + CHR(243) + "rio"
        RETURN .F.
    ENDPROC

    *==========================================================================
    * Destroy - Fecha todos os cursores abertos pelo BO
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_TipoMov")
            USE IN cursor_4c_TipoMov
        ENDIF
        IF USED("CrSigMvCab")
            USE IN CrSigMvCab
        ENDIF
        IF USED("CrSigMvItn")
            USE IN CrSigMvItn
        ENDIF
        IF USED("CrSigCdEmp")
            USE IN CrSigCdEmp
        ENDIF
        IF USED("CrSigOpPic")
            USE IN CrSigOpPic
        ENDIF
        IF USED("TmpRelat")
            USE IN TmpRelat
        ENDIF
        IF USED("dbCabecalho")
            USE IN dbCabecalho
        ENDIF
        IF USED("crTotFims")
            USE IN crTotFims
        ENDIF
        IF USED("TmpNens")
            USE IN TmpNens
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

