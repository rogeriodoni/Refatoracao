# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigReIfp.prg] Procedure vazia (sem codigo): BOParaForm
[FormSigReIfp.prg] Procedure vazia (sem codigo): AjustarBotoesPorModo
[FormSigReIfp.prg] Indicador de pendencia: * COMPATIBILIDADE CRUD (form REPORT nao implement

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReIfp.prg):
*==============================================================================
* FORMSIGREIFP.PRG
* Relatorio de Falhas / Perdas
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREIFP.SCX (frmrelatorio)
*
* Filtros:
*   - Periodo        (data inicial / data final)
*   - NivImprs       (tipo de relatorio 1-7 via Spinner)
*   - TpMat          (tipo de material - SigOpOpt WHERE Situas=3) [Nivel 7]
*   - Ifor/Dfor      (recuperadora codigo/descricao - SigCdCli)   [Nivel 7]
*   - CdGrupo/DsGrupo (setor codigo/descricao - SigCdGcr)        [Nivel 7]
*
* FRXs: SigReIfA (niv=1), SigReIfB (niv=2), SigReIfC (niv=3,4),
*        SigReIfD (niv=5), SigReIfE (niv=6), SigReIfF (niv=7)
*
* Objetos (mapeamento.json):
*   shp_4c_Shp_materia_prima, lbl_4c_Label1, lbl_4c_Lbl_periodo,
*   txt_4c_DsGrupo, txt_4c_CdGrupo, txt_4c__dt_inicial, lbl_4c_Lbl_periodo_a,
*   txt_4c__dt_final, lbl_4c_Label2, lbl_4c_Label3, txt_4c__ifor,
*   txt_4c__tpmat, txt_4c__dfor, obj_4c_NivImprs, lbl_4c_Label4
*==============================================================================

DEFINE CLASS FormSigReIfp AS FormBase

    *-- Dimensoes exatas do original (Width=647, Height=254)
    Height      = 254
    Width       = 647
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

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura do formulario de relatorio
    *   1. Define Caption / Picture (fundo)
    *   2. Cria SigReIfpBO (pula em modo UI sem conexao SQL)
    *   3. Monta cabecalho escuro + botoes + PageFrame com filtros
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Falhas / Perdas"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Em modo de validacao UI, nao criar BO (SigReIfpBO.Init() faz SQLEXEC)
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.this_oRelatorio = CREATEOBJECT("SigReIfpBO")
                IF VARTYPE(THIS.this_oRelatorio) != "O"
                    MsgErro("Erro ao criar SigReIfpBO" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

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
                .Caption   = "Relat" + CHR(243) + "rio de Falhas / Perdas"
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
                .Caption   = "Relat" + CHR(243) + "rio de Falhas / Perdas"
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
    * ConfigurarBotoes - CommandGroup de 4 botoes do relatorio
    *   Original: btnReport.Left=340, Width=310, 4 botoes (V/I/D/S)
    *   Novo: cmg_4c_Botoes.Left=340, Width=273, botoes Width=65
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 340
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
    * ConfigurarPageFrame - PageFrame com 1 pagina ("Filtros")
    *   Form original eh flat; no novo padrao os filtros ficam em Page1
    *   do PageFrame para consistencia com os demais forms de relatorio.
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
    * ConfigurarPaginaLista - Configura Page1 com os controles de filtro
    *   Em forms REPORT (frmrelatorio) a unica pagina exibida ao usuario eh
    *   a pagina de filtros - mantemos o nome "Lista" por compatibilidade
    *   com o pipeline multi-fase, mas a semantica para relatorios eh
    *   "pagina principal de parametros". Delegamos para ConfigurarPaginaFiltros
    *   que contem a implementacao real (Shape decorativo + 15 controles).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarPaginaFiltros()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Posiciona o PageFrame na pagina solicitada
    *   Em forms REPORT existe apenas Page1 (filtros). Qualquer valor diferente
    *   de 1 eh normalizado para 1, garantindo que callers genericos do pipeline
    *   (que assumem CRUD com Page1/Page2) nao quebrem o relatorio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        TRY
            loc_nPagina = IIF(VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 ;
                AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount, ;
                par_nPagina, 1)
            THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
            THIS.pgf_4c_Paginas.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaFiltros - Adiciona todos os controles de filtro em Page1
    *   Posicoes: originais do SCX (relativas ao form) menos PageFrame.Top=85
    *   Campos de nivel 7 (TpMat, Ifor/Dfor, CdGrupo/DsGrupo) ficam dentro da
    *   borda decorativa shp_4c_Shp_materia_prima (top=11, h=139).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaFiltros()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Borda decorativa ao redor dos campos de nivel 7
        *   Original: top=96, left=86, w=461, h=139 -> page: top=11
        loc_oPg.AddObject("shp_4c_Shp_materia_prima", "Shape")
        WITH loc_oPg.shp_4c_Shp_materia_prima
            .Top         = 11
            .Left        = 86
            .Width       = 461
            .Height      = 139
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- Label "Periodo :" (original: top=104, left=147 -> page: top=19)
        loc_oPg.AddObject("lbl_4c_Lbl_periodo", "Label")
        WITH loc_oPg.lbl_4c_Lbl_periodo
            .AutoSize  = .T.
            .Top       = 19
            .Left      = 147
            .Width     = 45
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Data inicial (original: top=101, left=199 -> page: top=16)
        loc_oPg.AddObject("txt_4c__dt_inicial", "TextBox")
        WITH loc_oPg.txt_4c__dt_inicial
            .Top         = 16
            .Left        = 199
            .Width       = 80
            .Height      = 25
            .Value       = {}
            .Format      = "D"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Separador "a" entre datas (original: top=104, left=284 -> page: top=19)
        loc_oPg.AddObject("lbl_4c_Lbl_periodo_a", "Label")
        WITH loc_oPg.lbl_4c_Lbl_periodo_a
            .AutoSize  = .T.
            .Top       = 19
            .Left      = 284
            .Width     = 8
            .Caption   = "a"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Data final (original: top=101, left=295 -> page: top=16)
        loc_oPg.AddObject("txt_4c__dt_final", "TextBox")
        WITH loc_oPg.txt_4c__dt_final
            .Top         = 16
            .Left        = 295
            .Width       = 80
            .Height      = 25
            .Value       = {}
            .Format      = "D"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Label "Tipo de Relatorio:" (original: top=132, left=105 -> page: top=47)
        loc_oPg.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg.lbl_4c_Label4
            .Top       = 47
            .Left      = 105
            .Caption   = "Tipo de Relat" + CHR(243) + "rio:"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Spinner NivImprs (original: top=127, left=199 -> page: top=42)
        *   Range 0-7 conforme original (KeyboardLowValue=0, KeyboardHighValue=7)
        loc_oPg.AddObject("obj_4c_NivImprs", "Spinner")
        WITH loc_oPg.obj_4c_NivImprs
            .Top                = 42
            .Left               = 199
            .Width              = 33
            .Height             = 25
            .Value              = 1
            .SpinnerHighValue   = 7.00
            .SpinnerLowValue    = 0.00
            .KeyboardHighValue  = 7
            .KeyboardLowValue   = 0
            .InputMask          = "9"
            .Format             = "K"
            .FontName           = "Courier New"
            .BackColor          = RGB(255, 255, 255)
            .ForeColor          = RGB(90, 90, 90)
            .Visible            = .T.
        ENDWITH

        *-- Label "Tipo de Material :" (original: top=157, left=107 -> page: top=72)
        loc_oPg.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg.lbl_4c_Label3
            .AutoSize  = .T.
            .Top       = 72
            .Left      = 107
            .Width     = 85
            .Height    = 15
            .Caption   = "Tipo de Material :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Tipo de material (original: top=154, left=199 -> page: top=69) [Nivel 7]
        loc_oPg.AddObject("txt_4c__tpmat", "TextBox")
        WITH loc_oPg.txt_4c__tpmat
            .Top         = 69
            .Left        = 199
            .Width       = 115
            .Height      = 23
            .Value       = ""
            .MaxLength   = 15
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH

        *-- Label "Recuperadora :" (original: top=181, left=115 -> page: top=96)
        loc_oPg.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg.lbl_4c_Label2
            .AutoSize  = .F.
            .Top       = 96
            .Left      = 115
            .Width     = 87
            .Height    = 17
            .Caption   = "Recuperadora :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Codigo recuperadora (original: top=179, left=199 -> page: top=94) [Nivel 7]
        loc_oPg.AddObject("txt_4c__ifor", "TextBox")
        WITH loc_oPg.txt_4c__ifor
            .Top         = 94
            .Left        = 199
            .Width       = 80
            .Height      = 23
            .Value       = ""
            .MaxLength   = 10
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH

        *-- Descricao recuperadora (original: top=179, left=281 -> page: top=94) [Nivel 7]
        *   Editavel apenas quando nivel=7 E ifor esta vazio (busca por nome)
        loc_oPg.AddObject("txt_4c__dfor", "TextBox")
        WITH loc_oPg.txt_4c__dfor
            .Top         = 94
            .Left        = 281
            .Width       = 233
            .Height      = 23
            .Value       = ""
            .MaxLength   = 40
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH

        *-- Label "Grupo :" (original: top=208, left=154 -> page: top=123)
        loc_oPg.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg.lbl_4c_Label1
            .AutoSize  = .T.
            .Top       = 123
            .Left      = 154
            .Width     = 38
            .Caption   = "Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Codigo do setor (original: top=204, left=199 -> page: top=119) [Nivel 7]
        loc_oPg.AddObject("txt_4c_CdGrupo", "TextBox")
        WITH loc_oPg.txt_4c_CdGrupo
            .Top         = 119
            .Left        = 199
            .Width       = 80
            .Height      = 25
            .Value       = ""
            .MaxLength   = 10
            .Format      = "K"
            .FontName    = "Courier New"
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH

        *-- Descricao do setor (original: top=204, left=281 -> page: top=119) [sempre ReadOnly]
        loc_oPg.AddObject("txt_4c_DsGrupo", "TextBox")
        WITH loc_oPg.txt_4c_DsGrupo
            .Top         = 119
            .Left        = 281
            .Width       = 233
            .Height      = 25
            .Value       = ""
            .MaxLength   = 20
            .Format      = "K"
            .FontName    = "Courier New"
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH

        *-- Vincular eventos
        BINDEVENT(loc_oPg.txt_4c__dt_inicial, "KeyPress", THIS, "TeclaDtInicial")
        BINDEVENT(loc_oPg.obj_4c_NivImprs,   "InteractiveChange", THIS, "NivImprsChange")
        BINDEVENT(loc_oPg.txt_4c__tpmat,      "KeyPress", THIS, "TeclaTpMat")
        BINDEVENT(loc_oPg.txt_4c__tpmat,      "DblClick", THIS, "AbrirBuscaTpMat")
        BINDEVENT(loc_oPg.txt_4c__ifor,       "KeyPress", THIS, "TeclaIfor")
        BINDEVENT(loc_oPg.txt_4c__ifor,       "DblClick", THIS, "AbrirBuscaCdIfor")
        BINDEVENT(loc_oPg.txt_4c__dfor,       "KeyPress", THIS, "TeclaDfor")
        BINDEVENT(loc_oPg.txt_4c__dfor,       "DblClick", THIS, "AbrirBuscaDfor")
        BINDEVENT(loc_oPg.txt_4c_CdGrupo,     "KeyPress", THIS, "TeclaCdGrupo")
        BINDEVENT(loc_oPg.txt_4c_CdGrupo,     "DblClick", THIS, "AbrirBuscaCdGrupo")
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarCamposNivel - Habilita/desabilita campos conforme NivImprs
    *   Original: When events de getCdGrupo/get_tpmat/get_ifor = (NivImprs=7)
    *             When de getDsGrupo = Return .F. (sempre ReadOnly)
    *             When de get_dfor = Empty(get_ifor) And (NivImprs=7)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarCamposNivel()
        LOCAL loc_oPg, loc_nNiv, loc_lNivel7
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_nNiv   = loc_oPg.obj_4c_NivImprs.Value
            loc_lNivel7 = (loc_nNiv = 7)

            loc_oPg.txt_4c__tpmat.ReadOnly  = !loc_lNivel7
            loc_oPg.txt_4c__ifor.ReadOnly   = !loc_lNivel7
            loc_oPg.txt_4c_CdGrupo.ReadOnly = !loc_lNivel7
            loc_oPg.txt_4c_DsGrupo.ReadOnly = .T.

            *-- Dfor: editavel apenas quando nivel=7 E ifor vazio (busca por nome)
            loc_oPg.txt_4c__dfor.ReadOnly = !(loc_lNivel7 AND EMPTY(ALLTRIM(loc_oPg.txt_4c__ifor.Value)))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura filtros para valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c__dt_inicial.Value = DATE()
            loc_oPg.txt_4c__dt_final.Value   = DATE()
            loc_oPg.obj_4c_NivImprs.Value    = 1
            loc_oPg.txt_4c__tpmat.Value      = ""
            loc_oPg.txt_4c__ifor.Value       = ""
            loc_oPg.txt_4c__dfor.Value       = ""
            loc_oPg.txt_4c_CdGrupo.Value     = ""
            loc_oPg.txt_4c_DsGrupo.Value     = ""
            THIS.AtualizarCamposNivel()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos controles para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dDtInicial = loc_oPg.txt_4c__dt_inicial.Value
            .this_dDtFinal   = loc_oPg.txt_4c__dt_final.Value
            .this_nNivImprs  = loc_oPg.obj_4c_NivImprs.Value
            .this_cTpMat     = ALLTRIM(loc_oPg.txt_4c__tpmat.Value)
            .this_cIfor      = ALLTRIM(loc_oPg.txt_4c__ifor.Value)
            .this_cDfor      = ALLTRIM(loc_oPg.txt_4c__dfor.Value)
            .this_cCdGrupo   = ALLTRIM(loc_oPg.txt_4c_CdGrupo.Value)
            .this_cDsGrupo   = ALLTRIM(loc_oPg.txt_4c_DsGrupo.Value)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarPeriodo - Verifica datas validas antes de gerar relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarPeriodo()
        LOCAL loc_oPg, loc_dIni, loc_dFim
        loc_oPg  = THIS.pgf_4c_Paginas.Page1
        loc_dIni = loc_oPg.txt_4c__dt_inicial.Value
        loc_dFim = loc_oPg.txt_4c__dt_final.Value
        IF EMPTY(loc_dIni) OR EMPTY(loc_dFim)
            MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF loc_dIni > loc_dFim
            MsgAviso("Data Final menor que a Inicial!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c__dt_final.SetFocus()
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOTOES DE RELATORIO
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("BO n" + CHR(227) + "o inicializado.", "Erro")
                RETURN
            ENDIF
            IF !THIS.ValidarPeriodo()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Visualizar()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relatorio na impressora com dialogo de selecao
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("BO n" + CHR(227) + "o inicializado.", "Erro")
                RETURN
            ENDIF
            IF !THIS.ValidarPeriodo()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Imprimir()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta cursor TmpRelat para arquivo XLS
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cCursor, loc_cArquivo
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("BO n" + CHR(227) + "o inicializado.", "Erro")
                RETURN
            ENDIF
            IF !THIS.ValidarPeriodo()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                RETURN
            ENDIF
            loc_cCursor = THIS.this_oRelatorio.this_cCursorDados
            IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
                MsgAviso("Nenhum dado encontrado para exportar.", "Excel")
                RETURN
            ENDIF
            loc_cArquivo = PUTFILE("Salvar como...", "SigReIfp", "XLS")
            IF !EMPTY(loc_cArquivo)
                SELECT (loc_cCursor)
                COPY TO (loc_cArquivo) TYPE XLS
                MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + loc_cArquivo, "Excel")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * COMPATIBILIDADE CRUD (form REPORT nao implementa Inserir/Alterar/Excluir)
    *   Mapeamento semantico para a barra de botoes do relatorio:
    *     - BtnIncluirClick  -> Visualizar (acao primaria do relatorio)
    *     - BtnAlterarClick  -> LimparCampos (reset dos filtros para edicao)
    *     - BtnExcluirClick  -> LimparCampos (limpa filtros = "remove" selecao)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Em REPORT delega para Visualizar (gerar relatorio)
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Em REPORT delega para LimparCampos (alterar filtros)
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.LimparCampos()
        TRY
            THIS.pgf_4c_Paginas.Page1.txt_4c__dt_inicial.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Em REPORT delega para LimparCampos (excluir/limpar filtros)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.LimparCampos()
    ENDPROC

    *==========================================================================
    * METODOS DE COMPATIBILIDADE CRUD (FASE 8)
    *   Forms REPORT nao tem CRUD, mas o pipeline pode chamar estes metodos.
    *   Mapeamento semantico: Buscar=Visualizar, Encerrar=Sair, Salvar=Imprimir,
    *   Cancelar=LimparCampos, FormParaBO=FormParaRelatorio, os demais sao no-op.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Em REPORT equivale a Visualizar (gerar relatorio)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario (alias de BtnSairClick)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Em REPORT equivale a Imprimir (salvar = imprimir)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Em REPORT equivale a LimparCampos (cancelar = reset)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        TRY
            THIS.pgf_4c_Paginas.Page1.txt_4c__dt_inicial.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Em REPORT delega para FormParaRelatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Em REPORT nao ha dados do BO para preencher o form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Em REPORT atualiza habilitacao conforme nivel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        THIS.AtualizarCamposNivel()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Em REPORT nao ha lista/grid; retorna .T. sem operacao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em REPORT nao ha modos CRUD; metodo no-op
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLADO (BINDEVENT KeyPress)
    * F4=115, ENTER=13, TAB=9
    *==========================================================================

    *-- Data inicial: ao sair (ENTER/TAB), ajusta data final se menor que inicial
    PROCEDURE TeclaDtInicial(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_oPg, loc_dIni, loc_dFim
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            loc_dIni = loc_oPg.txt_4c__dt_inicial.Value
            loc_dFim = loc_oPg.txt_4c__dt_final.Value
            IF !EMPTY(loc_dIni) AND !EMPTY(loc_dFim) AND loc_dIni > loc_dFim
                loc_oPg.txt_4c__dt_final.Value = loc_dIni
            ENDIF
        ENDIF
    ENDPROC

    *-- Spinner NivImprs: InteractiveChange atualiza habilitacao dos campos
    PROCEDURE NivImprsChange()
        THIS.AtualizarCamposNivel()
    ENDPROC

    *-- Tipo de material: F4=lookup, ENTER/TAB=validar
    PROCEDURE TeclaTpMat(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaTpMat()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarTpMat()
        ENDIF
    ENDPROC

    *-- Codigo da recuperadora: F4=lookup, ENTER/TAB=validar
    PROCEDURE TeclaIfor(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdIfor()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdIfor()
        ENDIF
    ENDPROC

    *-- Descricao da recuperadora: F4=lookup por nome, ENTER/TAB=validar
    PROCEDURE TeclaDfor(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDfor()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDfor()
        ENDIF
    ENDPROC

    *-- Codigo do setor: F4=lookup, ENTER/TAB=validar
    PROCEDURE TeclaCdGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdGrupo()
        ENDIF
    ENDPROC

    *==========================================================================
    * VALIDACOES DE CAMPOS
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarTpMat - Valida tipo de material contra SigOpOpt WHERE Situas=3
    *   Original: get_tpmat.Valid faz SQLEXEC no SigOpOpt e usa fwBuscaSel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarTpMat()
        LOCAL loc_cValor, loc_cSQL, loc_nRes, loc_oPg
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__tpmat.Value)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF
        loc_cSQL = "SELECT Cods, Descs FROM SigOpOpt " + ;
                   "WHERE Situas = 3 AND Cods = " + EscaparSQL(loc_cValor)
        loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TpMatVal")
        IF loc_nRes > 0
            SELECT cursor_4c_TpMatVal
            IF !EOF()
                loc_oPg.txt_4c__tpmat.Value = ALLTRIM(cursor_4c_TpMatVal.Cods)
            ELSE
                THIS.AbrirBuscaTpMat()
            ENDIF
            USE IN cursor_4c_TpMatVal
        ELSE
            IF USED("cursor_4c_TpMatVal")
                USE IN cursor_4c_TpMatVal
            ENDIF
            THIS.AbrirBuscaTpMat()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdIfor - Valida codigo da recuperadora contra SigCdCli
    *   Original: get_ifor.Valid chama fAcessoContas('C', ...)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCdIfor()
        LOCAL loc_cValor, loc_cSQL, loc_nRes, loc_oPg
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__ifor.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c__dfor.Value = ""
            THIS.AtualizarCamposNivel()
            RETURN
        ENDIF
        loc_cSQL = "SELECT Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cValor)
        loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_IforVal")
        IF loc_nRes > 0
            SELECT cursor_4c_IforVal
            IF !EOF()
                loc_oPg.txt_4c__ifor.Value = ALLTRIM(cursor_4c_IforVal.Iclis)
                loc_oPg.txt_4c__dfor.Value = ALLTRIM(cursor_4c_IforVal.Rclis)
            ELSE
                THIS.AbrirBuscaCdIfor()
            ENDIF
            USE IN cursor_4c_IforVal
        ELSE
            IF USED("cursor_4c_IforVal")
                USE IN cursor_4c_IforVal
            ENDIF
            THIS.AbrirBuscaCdIfor()
        ENDIF
        THIS.AtualizarCamposNivel()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDfor - Valida descricao da recuperadora contra SigCdCli
    *   Original: get_dfor.Valid chama fAcessoContas('D', ...)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDfor()
        LOCAL loc_cValor, loc_cSQL, loc_nRes, loc_oPg
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__dfor.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c__ifor.Value = ""
            THIS.AtualizarCamposNivel()
            RETURN
        ENDIF
        loc_cSQL = "SELECT Iclis, Rclis FROM SigCdCli " + ;
                   "WHERE Rclis LIKE " + EscaparSQL(loc_cValor + "%")
        loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DforVal")
        IF loc_nRes > 0
            SELECT cursor_4c_DforVal
            IF !EOF() AND RECCOUNT("cursor_4c_DforVal") = 1
                loc_oPg.txt_4c__dfor.Value = ALLTRIM(cursor_4c_DforVal.Rclis)
                loc_oPg.txt_4c__ifor.Value = ALLTRIM(cursor_4c_DforVal.Iclis)
            ELSE
                IF USED("cursor_4c_DforVal")
                    USE IN cursor_4c_DforVal
                ENDIF
                THIS.AbrirBuscaDfor()
            ENDIF
            IF USED("cursor_4c_DforVal")
                USE IN cursor_4c_DforVal
            ENDIF
        ELSE
            IF USED("cursor_4c_DforVal")
                USE IN cursor_4c_DforVal
            ENDIF
            THIS.AbrirBuscaDfor()
        ENDIF
        THIS.AtualizarCamposNivel()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdGrupo - Valida codigo do setor contra TmpGccr (cursor em memoria)
    *   Original: getCdGrupo.Valid usa SEEK no TmpGccr e fwBuscaSel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCdGrupo()
        LOCAL loc_cValor, loc_oPg
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdGrupo.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DsGrupo.Value = ""
            RETURN
        ENDIF
        IF USED("TmpGccr")
            SELECT TmpGccr
            SET ORDER TO Grupos
            IF SEEK(loc_cValor)
                loc_oPg.txt_4c_CdGrupo.Value = ALLTRIM(TmpGccr.Codigos)
                loc_oPg.txt_4c_DsGrupo.Value = ALLTRIM(TmpGccr.Descrs)
                RETURN
            ENDIF
        ENDIF
        THIS.AbrirBuscaCdGrupo()
    ENDPROC

    *==========================================================================
    * LOOKUPS (FormBuscaAuxiliar)
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirBuscaTpMat - Lookup de tipo de material em SigOpOpt WHERE Situas=3
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaTpMat()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__tpmat.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigOpOpt", "cursor_4c_BuscaTpMat", "Cods", loc_cValor, ;
            "Tipo de Material", .F., .F., "Situas = 3")
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpMat")
                loc_oPg.txt_4c__tpmat.Value = ALLTRIM(cursor_4c_BuscaTpMat.Cods)
            ENDIF
            IF USED("cursor_4c_BuscaTpMat")
                USE IN cursor_4c_BuscaTpMat
            ENDIF
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCdIfor - Lookup de recuperadora pelo codigo (Iclis) em SigCdCli
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCdIfor()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__ifor.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaFor", "Iclis", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Recuperadora")
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Rclis", "", "Nome")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFor")
                loc_oPg.txt_4c__ifor.Value = ALLTRIM(cursor_4c_BuscaFor.Iclis)
                loc_oPg.txt_4c__dfor.Value = ALLTRIM(cursor_4c_BuscaFor.Rclis)
            ENDIF
            IF USED("cursor_4c_BuscaFor")
                USE IN cursor_4c_BuscaFor
            ENDIF
            loc_oBusca.Release()
        ENDIF
        THIS.AtualizarCamposNivel()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDfor - Lookup de recuperadora pelo nome (Rclis) em SigCdCli
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDfor()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__dfor.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaDfor", "Rclis", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Recuperadora (Nome)")
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("Rclis", "", "Nome")
            loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDfor")
                loc_oPg.txt_4c__dfor.Value = ALLTRIM(cursor_4c_BuscaDfor.Rclis)
                loc_oPg.txt_4c__ifor.Value = ALLTRIM(cursor_4c_BuscaDfor.Iclis)
            ENDIF
            IF USED("cursor_4c_BuscaDfor")
                USE IN cursor_4c_BuscaDfor
            ENDIF
            loc_oBusca.Release()
        ENDIF
        THIS.AtualizarCamposNivel()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCdGrupo - Lookup de setor em SigCdGcr WHERE BalFalPers=1
    *   Original: getCdGrupo.Valid usa TmpGccr (cursor ja carregado pelo BO)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCdGrupo()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdGrupo.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Setor", .F., .F., "BalFalPers = 1")
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
                loc_oPg.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
                loc_oPg.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
            ENDIF
            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Complementa configuracao dos controles de filtro:
    *   1. BINDEVENT txt_4c__dt_final.KeyPress (ausente em ConfigurarPaginaFiltros)
    *   2. DblClick na descricao do grupo (campo ReadOnly -> abre lookup)
    *   3. ToolTipText em todos os controles de filtro
    *
    *   Para forms REPORT, "PaginaDados" corresponde a complementacao da pagina
    *   unica de filtros - nao existe Page2 (sem CRUD).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1

            *-- BINDEVENT ausente em ConfigurarPaginaFiltros: valida dt_final ao sair
            BINDEVENT(loc_oPg.txt_4c__dt_final, "KeyPress", THIS, "TeclaDtFinal")

            *-- DblClick na descricao do setor (ReadOnly) tambem abre lookup
            BINDEVENT(loc_oPg.txt_4c_DsGrupo, "DblClick", THIS, "AbrirBuscaCdGrupo")

            *-- ToolTipText para orientacao do usuario em todos os filtros
            loc_oPg.txt_4c__dt_inicial.ToolTipText = "Data inicial do per" + CHR(237) + "odo"
            loc_oPg.txt_4c__dt_final.ToolTipText   = "Data final do per" + CHR(237) + "odo"
            loc_oPg.obj_4c_NivImprs.ToolTipText    = "Tipo de relat" + CHR(243) + ;
                "rio (1 a 7): 1=Resumo, 2=Detalhe, 3-4=Consolidado, " + ;
                "5=Grupo, 6=Acumulado, 7=Individual"
            loc_oPg.txt_4c__tpmat.ToolTipText      = "[F4] Selecionar tipo de material - " + ;
                "apenas N" + CHR(237) + "vel 7"
            loc_oPg.txt_4c__ifor.ToolTipText       = "[F4] C" + CHR(243) + "digo da recuperadora - " + ;
                "apenas N" + CHR(237) + "vel 7"
            loc_oPg.txt_4c__dfor.ToolTipText       = "[F4] Nome da recuperadora - " + ;
                "apenas N" + CHR(237) + "vel 7 (preenchido ao informar o c" + CHR(243) + "digo)"
            loc_oPg.txt_4c_CdGrupo.ToolTipText     = "[F4] C" + CHR(243) + "digo do setor - " + ;
                "apenas N" + CHR(237) + "vel 7"
            loc_oPg.txt_4c_DsGrupo.ToolTipText     = "[DblClick] Selecionar setor - " + ;
                "preenchido automaticamente ao informar o c" + CHR(243) + "digo"
            loc_oPg.lbl_4c_Label4.ToolTipText      = "Selecione o n" + CHR(237) + "vel de detalhe do relat" + CHR(243) + "rio"
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *-- Data final: ao sair (ENTER/TAB), valida que nao e menor que a inicial
    PROCEDURE TeclaDtFinal(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_oPg, loc_dIni, loc_dFim
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            loc_dIni = loc_oPg.txt_4c__dt_inicial.Value
            loc_dFim = loc_oPg.txt_4c__dt_final.Value
            IF !EMPTY(loc_dFim) AND !EMPTY(loc_dIni) AND loc_dFim < loc_dIni
                MsgAviso("Data Final n" + CHR(227) + "o pode ser menor que a Data Inicial!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPg.txt_4c__dt_final.Value = loc_dIni
                loc_oPg.txt_4c__dt_final.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera o BO (Custom nao tem Release - usar .NULL.)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigReIfpBO.prg):
*==============================================================================
* SIGREIFPBO.PRG
* Business Object para Relatorio de Falhas / Perdas
*
* Herda de RelatorioBase
* Form: FormSigReIfp
* Relatorios FRX: SigReIfA..SigReIfF (conforme NivImprs 1-7)
* Tabela principal de dados: SigCdFea
* Tabelas auxiliares: SigCdGcr, SigCdCli, SigOpOpt
*==============================================================================

DEFINE CLASS SigReIfpBO AS RelatorioBase

    *-- Filtros do relatorio
    this_dDtInicial     = {}
    this_dDtFinal       = {}
    this_nNivImprs      = 1
    this_cTpMat         = ""
    this_cIfor          = ""
    this_cDfor          = ""
    this_cCdGrupo       = ""
    this_cDsGrupo       = ""

    *-- Cursor de dados produzido por PrepararDados (mantido como TmpRelat para compatibilidade com FRX)
    this_cCursorDados   = "TmpRelat"

    *--------------------------------------------------------------------------
    * Init - Inicializa BO e carrega cursores auxiliares de setores e clientes
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""
            IF DODEFAULT()
                loc_lSucesso = THIS.CarregarCursoresAuxiliares()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCursoresAuxiliares - Carrega TmpGccr (setores) e TmpCli (clientes)
    * Chamado uma vez no Init; cursores persistem durante a vida do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarCursoresAuxiliares()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRes
        loc_lSucesso = .F.
        TRY
            IF USED("TmpGccr")
                USE IN TmpGccr
            ENDIF
            IF USED("TmpCli")
                USE IN TmpCli
            ENDIF

            *-- Setores com BalFalPers = 1
            loc_cSQL = "SELECT * FROM SigCdGcr WHERE BalFalPers = 1"
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "TmpGccr")
            IF loc_nRes < 0
                THIS.this_cMensagemErro = "Erro ao carregar setores (TmpGccr)"
                MsgErro("Erro ao carregar setores. Verifique a conex" + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF
            SELECT TmpGccr
            INDEX ON Codigos TAG Grupos

            *-- Clientes vinculados a setores com BalFalPers = 1
            loc_cSQL = "SELECT a.* FROM SigCdCli a, SigCdGcr b " + ;
                       "WHERE a.Grupos = b.Codigos AND b.BalFalPers = 1"
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "TmpCli")
            IF loc_nRes < 0
                THIS.this_cMensagemErro = "Erro ao carregar clientes (TmpCli)"
                MsgErro("Erro ao carregar clientes. Verifique a conex" + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF
            SELECT TmpCli
            INDEX ON Iclis          TAG Iclis
            INDEX ON Grupos + Iclis TAG Grupos

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta TmpRelat e dbCabecalho para os FRX de relatorio
    * Replica a logica do PROCEDURE processamento do form legado SIGREIFP
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRes
        LOCAL loc_ldDti, loc_ldDtf, loc_lnNiv, loc_lcNiv
        LOCAL loc_lcTpM, loc_lcFor, loc_lcGrp
        LOCAL loc_nTotGccr, loc_nTotCli, loc_nTotClig
        LOCAL loc_lnTrab, loc_lnFalha, loc_lnPeso, loc_lnPerda, loc_lnTPerda
        LOCAL loc_lnRecupera, loc_lnPesob, loc_lnReccb, loc_lnRecsb
        LOCAL loc_cCab, loc_cSub, loc_cEmp, loc_cTit
        LOCAL loc_cDtI, loc_cDtF
        LOCAL loc_cGrSeek, loc_cIfors7

        loc_lSucesso = .F.
        TRY
            *-- Obter filtros do BO
            loc_ldDti  = THIS.this_dDtInicial
            loc_ldDtf  = THIS.this_dDtFinal
            loc_lnNiv  = THIS.this_nNivImprs
            loc_lcNiv  = STR(loc_lnNiv, 1)
            loc_lcTpM  = ALLTRIM(THIS.this_cTpMat)
            loc_lcFor  = ALLTRIM(THIS.this_cIfor)
            loc_lcGrp  = ALLTRIM(THIS.this_cCdGrupo)

            *-- Validar periodo
            IF EMPTY(loc_ldDti) OR EMPTY(loc_ldDtf)
                THIS.this_cMensagemErro = "Informe o per" + CHR(237) + "odo inicial e final"
                MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Verificar cursores auxiliares
            IF !USED("TmpGccr") OR !USED("TmpCli")
                IF !THIS.CarregarCursoresAuxiliares()
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            *-- Fechar cursores de execucoes anteriores
            IF USED("TmpRelat")
                USE IN TmpRelat
            ENDIF
            IF USED("csSelecao")
                USE IN csSelecao
            ENDIF
            IF USED("dbCabecalho")
                USE IN dbCabecalho
            ENDIF
            IF USED("crSigCdCli")
                USE IN crSigCdCli
            ENDIF
            IF USED("crSigCdEmp")
                USE IN crSigCdEmp
            ENDIF

            *-- Criar cursor de resultado (mesmo esquema que o original)
            CREATE CURSOR TmpRelat (Operacs c(30), Totas n(12,2), Grupos c(10), Dgrupos c(30), ;
                Contas c(10), Rclis c(30), ;
                falhags n(12,2), Recupgs n(12,2), Perdags n(12,2), Falhaps n(7,2), Recupps n(7,2), ;
                Perdaps n(7,2), Trabs n(12,2), fatrabs n(7,2), recfals n(7,2), Perdidos n(7,2), ;
                pertrabs n(7,2), TpOps c(15), Pesbs n(12,2), recCcobs n(12,2), RecScobs n(12,2), ;
                recpesos n(7,2), Nivels c(1), Datas d)
            INDEX ON Operacs                             TAG Operacao
            INDEX ON Nivels + Grupos                     TAG Grupos
            INDEX ON Contas                              TAG Contas
            INDEX ON Grupos + Contas                     TAG GruCon
            INDEX ON Grupos + TpOps                      TAG GruTp
            INDEX ON TpOps + Grupos + Contas + DTOS(Datas) TAG TpGruCond

            *-- Buscar registros de falhas/perdas no periodo (YYYYMMDD + tempo para DATETIME)
            loc_cDtI = DTOC(loc_ldDti, 1)
            loc_cDtF = DTOC(loc_ldDtf, 1)
            loc_cSQL = "SELECT * FROM SigCdFea " + ;
                       "WHERE Datas BETWEEN '" + loc_cDtI + "' AND '" + loc_cDtF + " 23:59:59'" + ;
                       " AND (Tipos = 'F' OR (Tipos = 'P' AND Baixas = 1))"
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "csSelecao")
            IF loc_nRes < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de falhas/perdas"
                MsgErro("Erro ao buscar dados. Verifique a conex" + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Contar totais dos cursores auxiliares
            SELECT TmpGccr
            COUNT TO loc_nTotGccr

            SELECT TmpCli
            COUNT TO loc_nTotCli

            *=========================================
            * NIVEL 1 - Resumo global (totais)
            *=========================================
            IF (loc_lnNiv = 1)
                SELECT TmpRelat
                SET ORDER TO
                SELECT csSelecao
                SUM Produzidos, Falhas, Pesoccbs TO loc_lnTrab, loc_lnFalha, loc_lnPeso
                loc_lnPerda = loc_lnFalha - loc_lnPeso
                SELECT TmpRelat
                APPEND BLANK
                REPLACE Operacs WITH "Produzido (g)", ;
                        Totas   WITH loc_lnTrab
                APPEND BLANK
                REPLACE Operacs WITH "Falha (g)", ;
                        Totas   WITH loc_lnFalha
                APPEND BLANK
                REPLACE Operacs WITH "Recupera" + CHR(231) + CHR(227) + "o c/Cobr (g)", ;
                        Totas   WITH loc_lnPeso
                APPEND BLANK
                REPLACE Operacs WITH "Perda (g)", ;
                        Totas   WITH loc_lnPerda
                APPEND BLANK
                REPLACE Operacs WITH "Falha/Produzido (%)", ;
                        Totas   WITH IIF(loc_lnTrab <> 0, (loc_lnFalha / loc_lnTrab * 100), 0)
                APPEND BLANK
                REPLACE Operacs WITH "Recupera" + CHR(231) + CHR(227) + "o/Falha (%)", ;
                        Totas   WITH IIF(loc_lnFalha <> 0, (loc_lnPeso / loc_lnFalha * 100), 0)
                APPEND BLANK
                REPLACE Operacs WITH "Perda/Produzido (%)", ;
                        Totas   WITH IIF(loc_lnTrab <> 0, (loc_lnPerda / loc_lnTrab * 100), 0)
            ENDIF

            *=========================================
            * NIVEL 2 - Por setor (Grupos)
            *=========================================
            IF (loc_lnNiv = 2)
                SELECT TmpRelat
                SET ORDER TO Grupos
                SELECT csSelecao
                SCAN
                    IF EMPTY(csSelecao.Grupos) AND EMPTY(csSelecao.Contas) AND ;
                       !EMPTY(csSelecao.Produzidos)
                        LOOP
                    ENDIF

                    IF EMPTY(csSelecao.Grupos)
                        loc_lnRecupera = IIF(loc_nTotGccr > 0, csSelecao.Pesoccbs / loc_nTotGccr, 0)
                        SELECT TmpGccr
                        SCAN
                            SELECT TmpRelat
                            SET ORDER TO Grupos
                            SEEK loc_lcNiv + TmpGccr.Codigos
                            IF EOF()
                                APPEND BLANK
                                REPLACE Grupos  WITH TmpGccr.Codigos, ;
                                        Dgrupos WITH TmpGccr.Descrs, ;
                                        Nivels  WITH loc_lcNiv
                            ENDIF
                            REPLACE Recupgs WITH Recupgs + loc_lnRecupera
                        ENDSCAN
                    ELSE
                        SELECT TmpGccr
                        SET ORDER TO Grupos
                        SEEK csSelecao.Grupos
                        loc_lnRecupera = csSelecao.Pesoccbs
                        SELECT TmpRelat
                        SEEK loc_lcNiv + csSelecao.Grupos
                        IF EOF()
                            APPEND BLANK
                            REPLACE Grupos  WITH csSelecao.Grupos, ;
                                    Dgrupos WITH TmpGccr.Descrs, ;
                                    Nivels  WITH loc_lcNiv
                        ENDIF
                        REPLACE Recupgs WITH Recupgs + loc_lnRecupera
                        REPLACE falhags WITH falhags + csSelecao.Falhas
                        REPLACE Trabs   WITH Trabs   + csSelecao.Trabs
                    ENDIF
                ENDSCAN

                SELECT TmpRelat
                SUM falhags, Recupgs TO loc_lnFalha, loc_lnPeso
                loc_lnTPerda = loc_lnFalha - loc_lnPeso
                SCAN
                    REPLACE Perdags WITH falhags - Recupgs, ;
                            Falhaps WITH IIF(loc_lnFalha  <> 0, (falhags  / loc_lnFalha  * 100), 0), ;
                            Recupps WITH IIF(loc_lnPeso   <> 0, (Recupgs  / loc_lnPeso   * 100), 0), ;
                            Perdaps WITH IIF(loc_lnTPerda <> 0, (Perdags  / loc_lnTPerda * 100), 0)
                ENDSCAN
            ENDIF

            *=========================================
            * NIVEL 3 - Por cliente (falhas)
            *=========================================
            IF (loc_lnNiv = 3)
                SELECT TmpRelat
                SET ORDER TO Contas
                SELECT csSelecao
                SUM Falhas TO loc_lnFalha
                SCAN
                    IF EMPTY(csSelecao.Grupos) AND EMPTY(csSelecao.Contas) AND ;
                       !EMPTY(csSelecao.Produzidos)
                        LOOP
                    ENDIF
                    IF csSelecao.Tipos = "F"
                        =SEEK(csSelecao.Contas, "TmpCli", "Iclis")
                        SELECT TmpRelat
                        SEEK csSelecao.Contas
                        IF EOF()
                            APPEND BLANK
                            REPLACE Contas WITH csSelecao.Contas, ;
                                    Rclis  WITH TmpCli.Rclis, ;
                                    Nivels WITH loc_lcNiv
                        ENDIF
                        REPLACE falhags WITH falhags + csSelecao.Falhas
                    ENDIF
                ENDSCAN
                SELECT TmpRelat
                SCAN
                    REPLACE Falhaps WITH IIF(loc_lnFalha <> 0, (falhags / loc_lnFalha * 100), 0)
                ENDSCAN
            ENDIF

            *=========================================
            * NIVEL 4 - Por cliente (recuperacoes)
            *=========================================
            IF (loc_lnNiv = 4)
                SELECT TmpRelat
                SET ORDER TO Contas
                SELECT csSelecao
                SCAN
                    IF EMPTY(csSelecao.Grupos) AND EMPTY(csSelecao.Contas) AND ;
                       !EMPTY(csSelecao.Produzidos)
                        LOOP
                    ENDIF

                    IF EMPTY(csSelecao.Grupos)
                        loc_lnRecupera = IIF(loc_nTotCli > 0, csSelecao.Pesoccbs / loc_nTotCli, 0)
                        SELECT TmpCli
                        SCAN
                            SELECT TmpRelat
                            SET ORDER TO Contas
                            SEEK TmpCli.Iclis
                            IF EOF()
                                APPEND BLANK
                                REPLACE Contas WITH TmpCli.Iclis, ;
                                        Rclis  WITH TmpCli.Rclis, ;
                                        Nivels WITH loc_lcNiv
                            ENDIF
                            REPLACE Recupgs WITH Recupgs + loc_lnRecupera
                        ENDSCAN
                    ELSE
                        IF EMPTY(csSelecao.Contas)
                            loc_cGrSeek = csSelecao.Grupos
                            SELECT TmpCli
                            SET ORDER TO Grupos
                            SEEK loc_cGrSeek
                            COUNT TO loc_nTotClig WHILE Grupos = loc_cGrSeek
                            loc_lnRecupera = IIF(loc_nTotClig > 0, ;
                                csSelecao.Pesoccbs / loc_nTotClig, 0)
                            SEEK loc_cGrSeek
                            SCAN WHILE Grupos = loc_cGrSeek
                                SELECT TmpRelat
                                SEEK TmpCli.Iclis
                                IF EOF()
                                    APPEND BLANK
                                    REPLACE Contas WITH TmpCli.Iclis, ;
                                            Rclis  WITH TmpCli.Rclis, ;
                                            Nivels WITH loc_lcNiv
                                ENDIF
                                REPLACE Recupgs WITH Recupgs + loc_lnRecupera
                            ENDSCAN
                        ELSE
                            loc_lnRecupera = csSelecao.Pesoccbs
                            =SEEK(csSelecao.Contas, "TmpCli", "Iclis")
                            SELECT TmpRelat
                            SEEK csSelecao.Contas
                            IF EOF()
                                APPEND BLANK
                                REPLACE Contas WITH TmpCli.Iclis, ;
                                        Rclis  WITH TmpCli.Rclis, ;
                                        Nivels WITH loc_lcNiv
                            ENDIF
                            REPLACE falhags WITH falhags + csSelecao.Falhas
                            REPLACE Recupgs WITH Recupgs + loc_lnRecupera
                        ENDIF
                    ENDIF
                ENDSCAN

                SELECT TmpRelat
                SUM falhags - Recupgs TO loc_lnTPerda
                SCAN
                    REPLACE Perdags WITH falhags - Recupgs
                    REPLACE Perdaps WITH IIF(loc_lnTPerda <> 0, (Perdags / loc_lnTPerda * 100), 0)
                ENDSCAN
            ENDIF

            *=========================================
            * NIVEL 5 - Por setor e cliente
            *=========================================
            IF (loc_lnNiv = 5)
                SELECT TmpRelat
                SET ORDER TO GruCon
                SELECT csSelecao
                SCAN
                    IF EMPTY(csSelecao.Grupos) AND EMPTY(csSelecao.Contas) AND ;
                       !EMPTY(csSelecao.Produzidos)
                        LOOP
                    ENDIF

                    IF csSelecao.Tipos = "F"
                        SELECT TmpRelat
                        SEEK csSelecao.Grupos + csSelecao.Contas
                        IF EOF()
                            APPEND BLANK
                            REPLACE Grupos WITH csSelecao.Grupos, ;
                                    Contas WITH csSelecao.Contas
                        ENDIF
                        REPLACE Trabs   WITH Trabs   + csSelecao.Trabs
                        REPLACE falhags WITH falhags + csSelecao.Falhas
                    ELSE
                        IF EMPTY(csSelecao.Grupos)
                            loc_lnRecupera = IIF(loc_nTotCli > 0, csSelecao.Pesoccbs / loc_nTotCli, 0)
                            SELECT TmpCli
                            SCAN
                                SELECT TmpRelat
                                SEEK TmpCli.Grupos + TmpCli.Iclis
                                IF EOF()
                                    APPEND BLANK
                                    REPLACE Grupos WITH TmpCli.Grupos, ;
                                            Contas WITH TmpCli.Iclis
                                ENDIF
                                REPLACE Recupgs WITH Recupgs + loc_lnRecupera
                            ENDSCAN
                        ELSE
                            IF EMPTY(csSelecao.Contas)
                                loc_cGrSeek = csSelecao.Grupos
                                SELECT TmpCli
                                SET ORDER TO Grupos
                                SEEK loc_cGrSeek
                                COUNT TO loc_nTotClig WHILE Grupos = loc_cGrSeek
                                loc_lnRecupera = IIF(loc_nTotClig > 0, ;
                                    csSelecao.Pesoccbs / loc_nTotClig, 0)
                                SEEK loc_cGrSeek
                                SCAN WHILE Grupos = loc_cGrSeek
                                    SELECT TmpRelat
                                    SEEK TmpCli.Grupos + TmpCli.Iclis
                                    IF EOF()
                                        APPEND BLANK
                                        REPLACE Contas WITH TmpCli.Iclis, ;
                                                Grupos WITH TmpCli.Grupos
                                    ENDIF
                                    REPLACE Recupgs WITH Recupgs + loc_lnRecupera
                                ENDSCAN
                            ELSE
                                loc_lnRecupera = csSelecao.Pesoccbs
                                =SEEK(csSelecao.Contas, "TmpCli", "Iclis")
                                SELECT TmpRelat
                                SEEK csSelecao.Grupos + csSelecao.Contas
                                IF EOF()
                                    APPEND BLANK
                                    REPLACE Contas WITH TmpCli.Iclis, ;
                                            Grupos WITH TmpCli.Grupos
                                ENDIF
                                REPLACE falhags WITH falhags + csSelecao.Falhas
                                REPLACE Recupgs WITH Recupgs + loc_lnRecupera
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN

                SELECT TmpRelat
                SCAN
                    REPLACE Perdags  WITH falhags - Recupgs, ;
                            fatrabs  WITH IIF(Trabs   <> 0, (falhags  / Trabs   * 100), 0), ;
                            recfals  WITH IIF(falhags <> 0, (Recupgs  / falhags * 100), 0), ;
                            Pertrabs WITH IIF(Trabs   <> 0, (Perdags  / Trabs   * 100), 0), ;
                            Perdidos WITH IIF(falhags <> 0, (Perdags  / falhags * 100), 0)
                ENDSCAN
            ENDIF

            *=========================================
            * NIVEL 6 - Por setor e tipo de material
            *=========================================
            IF (loc_lnNiv = 6)
                SELECT TmpRelat
                SET ORDER TO GruTp
                SELECT csSelecao
                SCAN
                    IF (csSelecao.Tipos = "F") OR ;
                       (EMPTY(csSelecao.Grupos) AND EMPTY(csSelecao.Contas) AND ;
                        !EMPTY(csSelecao.Produzidos))
                        LOOP
                    ENDIF

                    IF EMPTY(csSelecao.Grupos)
                        loc_lnPesob = IIF(loc_nTotGccr > 0, csSelecao.Brutos   / loc_nTotGccr, 0)
                        loc_lnReccb = IIF(loc_nTotGccr > 0, csSelecao.Pesoccbs / loc_nTotGccr, 0)
                        loc_lnRecsb = IIF(loc_nTotGccr > 0, csSelecao.Pesoscbs / loc_nTotGccr, 0)
                        SELECT TmpGccr
                        SCAN
                            SELECT TmpRelat
                            SET ORDER TO GruTp
                            SEEK TmpGccr.Codigos + csSelecao.TpMats
                            IF EOF()
                                APPEND BLANK
                                REPLACE Grupos WITH TmpGccr.Codigos, ;
                                        TpOps  WITH csSelecao.TpMats
                            ENDIF
                            REPLACE Pesbs    WITH Pesbs    + loc_lnPesob, ;
                                    recCcobs WITH recCcobs + loc_lnReccb, ;
                                    RecScobs WITH RecScobs + loc_lnRecsb
                        ENDSCAN
                    ELSE
                        loc_lnPesob = csSelecao.Brutos
                        loc_lnReccb = csSelecao.Pesoccbs
                        loc_lnRecsb = csSelecao.Pesoscbs
                        SELECT TmpRelat
                        SET ORDER TO GruTp
                        SEEK csSelecao.Grupos + csSelecao.TpMats
                        IF EOF()
                            APPEND BLANK
                            REPLACE Grupos WITH csSelecao.Grupos, ;
                                    TpOps  WITH csSelecao.TpMats
                        ENDIF
                        REPLACE Pesbs    WITH Pesbs    + loc_lnPesob, ;
                                recCcobs WITH recCcobs + loc_lnReccb, ;
                                RecScobs WITH RecScobs + loc_lnRecsb
                    ENDIF
                ENDSCAN

                SELECT TmpRelat
                SCAN
                    REPLACE recpesos WITH IIF(Pesbs <> 0, (RecScobs / Pesbs * 100), 0)
                ENDSCAN
            ENDIF

            *=========================================
            * NIVEL 7 - Detalhado (tipo+setor+cliente+data)
            *=========================================
            IF (loc_lnNiv = 7)
                SELECT TmpRelat
                SET ORDER TO TpGruCond
                SELECT csSelecao
                SCAN
                    IF csSelecao.Tipos = "F" OR ;
                       (EMPTY(csSelecao.Grupos) AND EMPTY(csSelecao.Contas) AND ;
                        !EMPTY(csSelecao.Produzidos))
                        LOOP
                    ENDIF
                    IF !EMPTY(loc_lcTpM) AND loc_lcTpM <> ALLTRIM(csSelecao.TpMats)
                        LOOP
                    ENDIF
                    IF !EMPTY(loc_lcFor) AND loc_lcFor <> ALLTRIM(csSelecao.Ifors)
                        LOOP
                    ENDIF
                    IF !EMPTY(loc_lcGrp) AND loc_lcGrp <> ALLTRIM(csSelecao.Grupos)
                        LOOP
                    ENDIF

                    *-- Buscar descricao da recuperadora pelo codigo Ifors
                    loc_cIfors7 = ALLTRIM(csSelecao.Ifors)
                    IF USED("crSigCdCli")
                        USE IN crSigCdCli
                    ENDIF
                    SQLEXEC(gnConnHandle, ;
                            "SELECT Iclis, Rclis FROM SigCdCli WHERE Iclis = " + ;
                            EscaparSQL(loc_cIfors7), "crSigCdCli")

                    loc_lnPesob = csSelecao.Brutos
                    loc_lnRecsb = csSelecao.Pesoscbs
                    SELECT TmpRelat
                    APPEND BLANK
                    REPLACE Contas   WITH csSelecao.Grupos, ;
                            TpOps    WITH csSelecao.TpMats, ;
                            Datas    WITH csSelecao.Datas, ;
                            Grupos   WITH csSelecao.Ifors, ;
                            Dgrupos  WITH IIF(USED("crSigCdCli") .AND. !EOF("crSigCdCli"), ;
                                             ALLTRIM(crSigCdCli.Rclis), ""), ;
                            Pesbs    WITH Pesbs    + csSelecao.Brutos, ;
                            RecScobs WITH RecScobs + csSelecao.Pesoscbs, ;
                            recpesos WITH IIF(Pesbs <> 0, (RecScobs / Pesbs * 100), 0)
                ENDSCAN
            ENDIF

            *-- Montar cabecalho para os FRX
            loc_cCab = "Rela" + CHR(231) + CHR(227) + "o de Falhas / Perdas"
            loc_cSub = "Per" + CHR(237) + "odo: " + DTOC(loc_ldDti) + " a " + DTOC(loc_ldDtf)

            *-- Buscar razao social da empresa
            IF USED("crSigCdEmp")
                USE IN crSigCdEmp
            ENDIF
            loc_nRes = SQLEXEC(gnConnHandle, ;
                       "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)), "crSigCdEmp")
            loc_cEmp = go_4c_Sistema.cCodEmpresa + " - " + ;
                       IIF(loc_nRes > 0 .AND. !EOF("crSigCdEmp"), ALLTRIM(crSigCdEmp.Razas), "")

            *-- Linha de filtros ativos
            loc_cTit = IIF(!EMPTY(loc_lcTpM), loc_lcTpM, "") + ;
                       IIF(!EMPTY(loc_lcFor), " / " + loc_lcFor, "") + ;
                       IIF(!EMPTY(loc_lcGrp), " / " + loc_lcGrp, "")
            loc_cTit = IIF(!EMPTY(loc_cTit), "Filtros: " + loc_cTit, "")

            *-- Cursor de cabecalho usado pelos FRX
            IF USED("dbCabecalho")
                USE IN dbCabecalho
            ENDIF
            CREATE CURSOR dbCabecalho (Titulo c(100), SubTitulo c(100), NomeEmpresa c(100), Periodos c(100))
            INSERT INTO dbCabecalho (Titulo, Periodos, NomeEmpresa, SubTitulo) ;
                VALUES (loc_cCab, loc_cTit, loc_cEmp, loc_cSub)

            *-- Posicionar TmpRelat no inicio para o FRX
            SELECT TmpRelat
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cFrx
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            loc_cFrx = THIS.ObterRelatorioFrx()
            IF EMPTY(loc_cFrx)
                THIS.this_cMensagemErro = "N" + CHR(237) + "vel de relat" + CHR(243) + ;
                    "rio inv" + CHR(225) + "lido"
                MsgAviso("N" + CHR(237) + "vel de relat" + CHR(243) + "rio inv" + CHR(225) + ;
                         "lido (0 ou > 7).", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (loc_cFrx) TO PRINT PROMPT NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe o relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cFrx
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            loc_cFrx = THIS.ObterRelatorioFrx()
            IF EMPTY(loc_cFrx)
                THIS.this_cMensagemErro = "N" + CHR(237) + "vel de relat" + CHR(243) + ;
                    "rio inv" + CHR(225) + "lido"
                MsgAviso("N" + CHR(237) + "vel de relat" + CHR(243) + "rio inv" + CHR(225) + ;
                         "lido (0 ou > 7).", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterRelatorioFrx - Retorna caminho do FRX conforme NivImprs
    *--------------------------------------------------------------------------
    FUNCTION ObterRelatorioFrx()
        LOCAL loc_cFrx
        loc_cFrx = ""
        DO CASE
            CASE THIS.this_nNivImprs = 1
                loc_cFrx = gc_4c_CaminhoReports + "SigReIfA.frx"
            CASE THIS.this_nNivImprs = 2
                loc_cFrx = gc_4c_CaminhoReports + "SigReIfB.frx"
            CASE THIS.this_nNivImprs = 3 OR THIS.this_nNivImprs = 4
                loc_cFrx = gc_4c_CaminhoReports + "SigReIfC.frx"
            CASE THIS.this_nNivImprs = 5
                loc_cFrx = gc_4c_CaminhoReports + "SigReIfD.frx"
            CASE THIS.this_nNivImprs = 6
                loc_cFrx = gc_4c_CaminhoReports + "SigReIfE.frx"
            CASE THIS.this_nNivImprs = 7
                loc_cFrx = gc_4c_CaminhoReports + "SigReIfF.frx"
        ENDCASE
        RETURN loc_cFrx
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy - Libera todos os cursores do ciclo de vida do BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("TmpGccr")
            USE IN TmpGccr
        ENDIF
        IF USED("TmpCli")
            USE IN TmpCli
        ENDIF
        IF USED("TmpRelat")
            USE IN TmpRelat
        ENDIF
        IF USED("csSelecao")
            USE IN csSelecao
        ENDIF
        IF USED("dbCabecalho")
            USE IN dbCabecalho
        ENDIF
        IF USED("crSigCdCli")
            USE IN crSigCdCli
        ENDIF
        IF USED("crSigCdEmp")
            USE IN crSigCdEmp
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

