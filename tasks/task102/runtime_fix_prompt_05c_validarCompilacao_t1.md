# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05c_validarCompilacao
- Tentativa: 1/10
- Mensagem: C:\4c\projeto\app\classes\sigreffnBO.prg: ENDFUNCTION | Error in line 1132: Unrecognized command verb. | ENDFUNCTION | Error in line 1159: Unrecognized command verb. | ENDFUNCTION | Error in line 1181: Unrecognized command verb. | 

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreffn.prg):
*==============================================================================
* FORMSIGREFFN.PRG
* Relat" + CHR(243) + "rio de Fluxo Financeiro - Sint" + CHR(233) + "tico
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREFFN.SCX (frmrelatorio)
*
* Filtros:
*   - Per" + CHR(237) + "odo (data inicial / data final)
*   - Moeda de refer" + CHR(234) + "ncia (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - SigCdMoe)
*   - Cota" + CHR(231) + CHR(227) + "o (num" + CHR(233) + "rico - auto do BO via BuscarCotacaoAtual)
*   - Moeda de lan" + CHR(231) + "amento (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - SigCdMoe)
*   - Totaliza Contas (CheckBox)
*   - Conciliado (CheckBox)
*   - Op" + CHR(231) + CHR(227) + "o NF (Sim/N" + CHR(227) + "o/Ambos)
*   - Fluxo / Tipo Impress" + CHR(227) + "o (Di" + CHR(225) + "rio/Semanal/Quinzenal/Mensal)
*   - Listar Atrasos (Sim/N" + CHR(227) + "o)
*   - Considerar Atrasos (Sim/N" + CHR(227) + "o)
*   - Previsto (Sim/N" + CHR(227) + "o/Ambos)
*   - Situa" + CHR(231) + CHR(227) + "o (Baixados/Pendentes/Todos)
*   - Saldo (Anterior/Na Data)
*   - Empresas selecion" + CHR(225) + "veis (Grid cEmp com CheckBox)
*   - Disponibilidades selecion" + CHR(225) + "veis (Grid cDisp com CheckBox)
*   - Opera" + CHR(231) + CHR(245) + "es de t" + CHR(237) + "tulos selecion" + CHR(225) + "veis (Grid crSigOpOpe com CheckBox)
*==============================================================================

DEFINE CLASS Formsigreffn AS FormBase

    Height      = 580
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

    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura do formul" + CHR(225) + "rio de relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Fluxo Financeiro - Sint" + CHR(233) + "tico"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.this_oRelatorio = CREATEOBJECT("sigreffnBO")
                IF VARTYPE(THIS.this_oRelatorio) != "O"
                    MsgErro("Erro ao criar sigreffnBO" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                    loc_lContinuar = .F.
                ENDIF

                IF loc_lContinuar
                    IF !THIS.this_oRelatorio.InicializarCursoresAuxiliares()
                        MsgAviso(THIS.this_oRelatorio.ObterMensagemErro() + CHR(13) + ;
                            "Alguns grids poder" + CHR(227) + "o aparecer vazios.", "Aviso")
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.ConfigurarPaginaLista()
                THIS.AlternarPagina(1)

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
    * ConfigurarCabecalho - Container escuro superior com t" + CHR(237) + "tulo
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
                .Caption   = "Relat" + CHR(243) + "rio de Fluxo Financeiro - Sint" + CHR(233) + "tico"
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
                .Caption   = "Relat" + CHR(243) + "rio de Fluxo Financeiro - Sint" + CHR(233) + "tico"
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
    * ConfigurarBotoes - CommandGroup com 4 bot" + CHR(245) + "es do relat" + CHR(243) + "rio
    *   Original: btnReport.Left=530, Top=0
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
    * ConfigurarPageFrame - PageFrame com 1 p" + CHR(225) + "gina (Filtros)
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
    * ConfigurarPaginaLista - Grids selecion" + CHR(225) + "veis e bot" + CHR(245) + "es Marcar/Desmarcar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag, loc_oErro
        TRY
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            loc_oPag.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            THIS.ConfigurarGridEmpresas(loc_oPag)
            THIS.ConfigurarGridDisponibilidades(loc_oPag)
            THIS.ConfigurarGridOperacoes(loc_oPag)
            THIS.ConfigurarPaginaDados(loc_oPag)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Ativa a p" + CHR(225) + "gina indicada do PageFrame
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_oErro
        TRY
            IF VARTYPE(par_nPagina) != "N"
                loc_nPagina = 1
            ELSE
                loc_nPagina = par_nPagina
            ENDIF
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                IF loc_nPagina < 1
                    loc_nPagina = 1
                ENDIF
                IF loc_nPagina > THIS.pgf_4c_Paginas.PageCount
                    loc_nPagina = THIS.pgf_4c_Paginas.PageCount
                ENDIF
                THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AlternarPagina")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridEmpresas - Grid de sele" + CHR(231) + CHR(227) + "o de empresas (Grid1 no legado)
    *   Original: top=186, left=307, width=357, height=185
    *   Page1: top=101 (186-85), left=307
    *   Cursor: cEmp (ImpEmps LOGICAL, Cemps, Razas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridEmpresas(par_oPag)
        LOCAL loc_oGrd, loc_oErro
        TRY
            *-- Label " Empresas " (original top=168, left=309)
            par_oPag.AddObject("lbl_4c_LblEmpresas", "Label")
            WITH par_oPag.lbl_4c_LblEmpresas
                .Top        = 83
                .Left       = 309
                .Width      = 63
                .Height     = 15
                .Caption    = " Empresas "
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackStyle  = 0
                .Visible    = .T.
            ENDWITH

            *-- Grid de empresas (original: top=186, left=307, width=357, height=185)
            par_oPag.AddObject("grd_4c_Empresas", "Grid")
            loc_oGrd = par_oPag.grd_4c_Empresas
            loc_oGrd.ColumnCount = 3
            IF USED("cEmp")
                loc_oGrd.RecordSource = "cEmp"
            ENDIF
            WITH loc_oGrd
                .Top                = 101
                .Left               = 307
                .Width              = 357
                .Height             = 185
                .FontName           = "Tahoma"
                .FontSize           = 8
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .GridLineColor      = RGB(238, 238, 238)
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle     = 2
                .AllowHeaderSizing  = .F.
                .AllowRowSizing     = .F.
                .DeleteMark         = .F.
                .RecordMark         = .F.
                .HeaderHeight       = 0
                .ScrollBars         = 2
                .RowHeight          = 16

                .Column1.Width = 15
                .Column2.Width = 30
                .Column3.Width = 289

                .Column1.AddObject("Check1", "CheckBox")
                .Column1.Check1.Caption   = ""
                .Column1.Check1.Value     = 0
                .Column1.Check1.Visible   = .T.
                .Column1.CurrentControl   = "Check1"
                .Column1.Resizable        = .F.
                .Column1.Sparse           = .F.
                .Column2.ReadOnly         = .T.
                .Column2.Movable          = .F.
                .Column2.Resizable        = .F.
                .Column3.ReadOnly         = .T.
                .Column3.Movable          = .F.
                .Column3.Resizable        = .F.

                .Column1.ControlSource = "cEmp.ImpEmps"
                .Column2.ControlSource = "cEmp.Cemps"
                .Column3.ControlSource = "cEmp.Razas"

                .Column1.Header1.Caption = ""
                .Column2.Header1.Caption = ""
                .Column3.Header1.Caption = ""

                .Visible = .T.
            ENDWITH

            *-- Botao Marcar Empresas (original: top=239, left=669)
            par_oPag.AddObject("cmd_4c_MarcarEmp", "CommandButton")
            WITH par_oPag.cmd_4c_MarcarEmp
                .Top           = 154
                .Left          = 669
                .Width         = 40
                .Height        = 40
                .Caption       = "Sel"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(90, 90, 90)
                .SpecialEffect = 0
                .Themes        = .F.
                .ToolTipText   = "Marcar Todas as Empresas"
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPag.cmd_4c_MarcarEmp, "Click", THIS, "BtnMarcarEmpClick")

            *-- Botao Desmarcar Empresas (original: top=279, left=669)
            par_oPag.AddObject("cmd_4c_DesmarcarEmp", "CommandButton")
            WITH par_oPag.cmd_4c_DesmarcarEmp
                .Top           = 194
                .Left          = 669
                .Width         = 40
                .Height        = 40
                .Caption       = "Des"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(90, 90, 90)
                .SpecialEffect = 0
                .Themes        = .F.
                .ToolTipText   = "Desmarcar Todas as Empresas"
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPag.cmd_4c_DesmarcarEmp, "Click", THIS, "BtnDesmarcarEmpClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ConfigurarGridEmpresas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridDisponibilidades - Grid de sele" + CHR(231) + CHR(227) + "o de disponibilidades
    *   Original: top=428, left=74, width=196, height=111
    *   Page1: top=343 (428-85), left=74
    *   Cursor: cDisp (ImpDisps LOGICAL, Grupos, Contas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridDisponibilidades(par_oPag)
        LOCAL loc_oGrd, loc_oErro
        TRY
            *-- Label " Disponibilidades " (original top=412, left=76)
            par_oPag.AddObject("lbl_4c_LblDisps", "Label")
            WITH par_oPag.lbl_4c_LblDisps
                .Top        = 327
                .Left       = 76
                .Width      = 99
                .Height     = 15
                .Caption    = " Disponibilidades "
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackStyle  = 0
                .Visible    = .T.
            ENDWITH

            *-- Grid de disponibilidades (original: top=428, left=74, width=196, height=111)
            par_oPag.AddObject("grd_4c_Disps", "Grid")
            loc_oGrd = par_oPag.grd_4c_Disps
            loc_oGrd.ColumnCount = 3
            IF USED("cDisp")
                loc_oGrd.RecordSource = "cDisp"
            ENDIF
            WITH loc_oGrd
                .Top                = 343
                .Left               = 74
                .Width              = 196
                .Height             = 111
                .FontName           = "Tahoma"
                .FontSize           = 8
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .GridLineColor      = RGB(238, 238, 238)
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle     = 2
                .AllowHeaderSizing  = .F.
                .AllowRowSizing     = .F.
                .DeleteMark         = .F.
                .RecordMark         = .F.
                .HeaderHeight       = 0
                .ScrollBars         = 2
                .RowHeight          = 16

                .Column1.Width = 15
                .Column2.Width = 79
                .Column3.Width = 79

                .Column1.AddObject("Check1", "CheckBox")
                .Column1.Check1.Caption   = ""
                .Column1.Check1.Value     = 0
                .Column1.Check1.Visible   = .T.
                .Column1.CurrentControl   = "Check1"
                .Column1.Resizable        = .F.
                .Column1.Sparse           = .F.
                .Column2.ReadOnly         = .T.
                .Column2.Movable          = .F.
                .Column2.Resizable        = .F.
                .Column3.ReadOnly         = .T.
                .Column3.Movable          = .F.
                .Column3.Resizable        = .F.

                .Column1.ControlSource = "cDisp.ImpDisps"
                .Column2.ControlSource = "cDisp.Grupos"
                .Column3.ControlSource = "cDisp.Contas"

                .Column1.Header1.Caption = ""
                .Column2.Header1.Caption = ""
                .Column3.Header1.Caption = ""

                .Visible = .T.
            ENDWITH

            *-- Botao Marcar Disponibilidades (original: top=448, left=275)
            par_oPag.AddObject("cmd_4c_MarcarDisp", "CommandButton")
            WITH par_oPag.cmd_4c_MarcarDisp
                .Top           = 363
                .Left          = 275
                .Width         = 40
                .Height        = 40
                .Caption       = "Sel"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(90, 90, 90)
                .SpecialEffect = 0
                .Themes        = .F.
                .ToolTipText   = "Marcar Todas as Disponibilidades"
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPag.cmd_4c_MarcarDisp, "Click", THIS, "BtnMarcarDispClick")

            *-- Botao Desmarcar Disponibilidades (original: top=489, left=275)
            par_oPag.AddObject("cmd_4c_DesmarcarDisp", "CommandButton")
            WITH par_oPag.cmd_4c_DesmarcarDisp
                .Top           = 404
                .Left          = 275
                .Width         = 40
                .Height        = 40
                .Caption       = "Des"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(90, 90, 90)
                .SpecialEffect = 0
                .Themes        = .F.
                .ToolTipText   = "Desmarcar Todas as Disponibilidades"
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPag.cmd_4c_DesmarcarDisp, "Click", THIS, "BtnDesmarcarDispClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ConfigurarGridDisponibilidades")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridOperacoes - Grid de sele" + CHR(231) + CHR(227) + "o de opera" + CHR(231) + CHR(245) + "es de t" + CHR(237) + "tulos
    *   Original: top=428, left=380, width=257, height=111 (2 colunas)
    *   Page1: top=343 (428-85), left=380
    *   Cursor: crSigOpOpe (SeleOp LOGICAL, Dopes)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridOperacoes(par_oPag)
        LOCAL loc_oGrd, loc_oErro
        TRY
            *-- Label " Opera" + CHR(231) + CHR(245) + "es de T" + CHR(237) + "tulos " (original top=410, left=381)
            par_oPag.AddObject("lbl_4c_LblOper", "Label")
            WITH par_oPag.lbl_4c_LblOper
                .Top        = 325
                .Left       = 381
                .Width      = 126
                .Height     = 15
                .Caption    = " Opera" + CHR(231) + CHR(245) + "es de T" + CHR(237) + "tulos "
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackStyle  = 0
                .Visible    = .T.
            ENDWITH

            *-- Grid de operacoes (original: top=428, left=380, width=257, height=111 - 2 colunas)
            par_oPag.AddObject("grd_4c_Oper", "Grid")
            loc_oGrd = par_oPag.grd_4c_Oper
            loc_oGrd.ColumnCount = 2
            IF USED("crSigOpOpe")
                loc_oGrd.RecordSource = "crSigOpOpe"
            ENDIF
            WITH loc_oGrd
                .Top                = 343
                .Left               = 380
                .Width              = 257
                .Height             = 111
                .FontName           = "Tahoma"
                .FontSize           = 8
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .GridLineColor      = RGB(238, 238, 238)
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle     = 2
                .AllowHeaderSizing  = .F.
                .AllowRowSizing     = .F.
                .DeleteMark         = .F.
                .RecordMark         = .F.
                .HeaderHeight       = 0
                .ScrollBars         = 2
                .RowHeight          = 16

                .Column1.Width = 15
                .Column2.Width = 220

                .Column1.AddObject("Check1", "CheckBox")
                .Column1.Check1.Caption   = ""
                .Column1.Check1.Value     = 0
                .Column1.Check1.Visible   = .T.
                .Column1.CurrentControl   = "Check1"
                .Column1.Resizable        = .F.
                .Column1.Sparse           = .F.
                .Column2.ReadOnly         = .T.
                .Column2.Movable          = .F.
                .Column2.Resizable        = .F.
                .Column2.BackColor        = RGB(255, 255, 255)

                .Column1.ControlSource = "crSigOpOpe.SeleOp"
                .Column2.ControlSource = "crSigOpOpe.Dopes"

                .Column1.Header1.Caption = ""
                .Column2.Header1.Caption = ""

                .Visible = .T.
            ENDWITH

            *-- Botao Marcar Operacoes (original: top=446, left=642)
            par_oPag.AddObject("cmd_4c_MarcarOpe", "CommandButton")
            WITH par_oPag.cmd_4c_MarcarOpe
                .Top           = 361
                .Left          = 642
                .Width         = 40
                .Height        = 40
                .Caption       = "Sel"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(90, 90, 90)
                .SpecialEffect = 0
                .Themes        = .F.
                .ToolTipText   = "Marcar Todas as Opera" + CHR(231) + CHR(245) + "es"
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPag.cmd_4c_MarcarOpe, "Click", THIS, "BtnMarcarOpeClick")

            *-- Botao Desmarcar Operacoes (original: top=487, left=642)
            par_oPag.AddObject("cmd_4c_DesmarcarOpe", "CommandButton")
            WITH par_oPag.cmd_4c_DesmarcarOpe
                .Top           = 402
                .Left          = 642
                .Width         = 40
                .Height        = 40
                .Caption       = "Des"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(90, 90, 90)
                .SpecialEffect = 0
                .Themes        = .F.
                .ToolTipText   = "Desmarcar Todas as Opera" + CHR(231) + CHR(245) + "es"
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPag.cmd_4c_DesmarcarOpe, "Click", THIS, "BtnDesmarcarOpeClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ConfigurarGridOperacoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Controles de filtro do SIGREFFN
    *   Posicoes: SCX Top - PageFrame.Top(85) = top na Page1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados(par_oPag)
        LOCAL loc_oErro
        TRY
            *== SECAO PERIODO (original: lbl top=178, get_dt top=175) =========

            par_oPag.AddObject("lbl_4c_Periodo", "Label")
            WITH par_oPag.lbl_4c_Periodo
                .Top       = 93
                .Left      = 64
                .Width     = 45
                .Height    = 15
                .Caption   = "Per" + CHR(237) + "odo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("txt_4c__dt_inicial", "TextBox")
            WITH par_oPag.txt_4c__dt_inicial
                .Top      = 90
                .Left     = 112
                .Width    = 80
                .Height   = 23
                .Value    = {}
                .Format   = "K"
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            par_oPag.AddObject("lbl_4c_PeriodoA", "Label")
            WITH par_oPag.lbl_4c_PeriodoA
                .Top       = 94
                .Left      = 195
                .Width     = 8
                .Height    = 15
                .Caption   = CHR(224)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("txt_4c__dt_final", "TextBox")
            WITH par_oPag.txt_4c__dt_final
                .Top      = 90
                .Left     = 206
                .Width    = 80
                .Height   = 23
                .Value    = {}
                .Format   = "K"
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *== SECAO MOEDA DE REFERENCIA (original: lbl top=202, get_cd top=199) =

            par_oPag.AddObject("lbl_4c_Moeda", "Label")
            WITH par_oPag.lbl_4c_Moeda
                .Top       = 117
                .Left      = 68
                .Width     = 41
                .Height    = 15
                .Caption   = "Moeda :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("txt_4c__cd_moeda", "TextBox")
            WITH par_oPag.txt_4c__cd_moeda
                .Top           = 114
                .Left          = 112
                .Width         = 31
                .Height        = 23
                .Value         = ""
                .MaxLength     = 3
                .Format        = "K"
                .FontName      = "Courier New"
                .FontSize      = 9
                .ForeColor     = RGB(0, 0, 0)
                .BackStyle     = 1
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Alignment     = 0
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPag.txt_4c__cd_moeda, "KeyPress", THIS, "TeclaCdMoeda")
            BINDEVENT(par_oPag.txt_4c__cd_moeda, "DblClick", THIS, "TeclaCdMoedaDblClick")

            par_oPag.AddObject("txt_4c__ds_moeda", "TextBox")
            WITH par_oPag.txt_4c__ds_moeda
                .Top       = 114
                .Left      = 145
                .Width     = 115
                .Height    = 23
                .Value     = ""
                .MaxLength = 15
                .Format    = "K"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH
            BINDEVENT(par_oPag.txt_4c__ds_moeda, "KeyPress", THIS, "TeclaDsMoeda")
            BINDEVENT(par_oPag.txt_4c__ds_moeda, "DblClick", THIS, "TeclaDsMoedaDblClick")

            *== SECAO COTACAO (original: lbl top=226, get top=223) =============

            par_oPag.AddObject("lbl_4c_Cotacao", "Label")
            WITH par_oPag.lbl_4c_Cotacao
                .Top       = 141
                .Left      = 60
                .Width     = 49
                .Height    = 15
                .Caption   = "Cota" + CHR(231) + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("txt_4c_cotacao", "TextBox")
            WITH par_oPag.txt_4c_cotacao
                .Top           = 138
                .Left          = 112
                .Width         = 80
                .Height        = 23
                .Value         = 0
                .InputMask     = "999,999.99"
                .Alignment     = 1
                .Format        = "K"
                .FontName      = "Tahoma"
                .FontSize      = 9
                .ForeColor     = RGB(0, 0, 0)
                .BackStyle     = 1
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *== SECAO MOEDA DE LANCAMENTO (original: lbl top=250, get top=247) =

            par_oPag.AddObject("lbl_4c_MoeLanc", "Label")
            WITH par_oPag.lbl_4c_MoeLanc
                .Top       = 165
                .Left      = 62
                .Width     = 47
                .Height    = 15
                .Caption   = "Moe Lan" + CHR(231)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("txt_4c_cd_moedl", "TextBox")
            WITH par_oPag.txt_4c_cd_moedl
                .Top           = 162
                .Left          = 112
                .Width         = 31
                .Height        = 23
                .Value         = ""
                .MaxLength     = 3
                .Format        = "K"
                .FontName      = "Courier New"
                .FontSize      = 9
                .ForeColor     = RGB(0, 0, 0)
                .BackStyle     = 1
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Alignment     = 0
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPag.txt_4c_cd_moedl, "KeyPress", THIS, "TeclaCdMoedl")
            BINDEVENT(par_oPag.txt_4c_cd_moedl, "DblClick", THIS, "TeclaCdMoedlDblClick")

            par_oPag.AddObject("txt_4c_ds_moedl", "TextBox")
            WITH par_oPag.txt_4c_ds_moedl
                .Top       = 162
                .Left      = 145
                .Width     = 115
                .Height    = 23
                .Value     = ""
                .MaxLength = 15
                .Format    = "K"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH
            BINDEVENT(par_oPag.txt_4c_ds_moedl, "KeyPress", THIS, "TeclaDsMoedl")
            BINDEVENT(par_oPag.txt_4c_ds_moedl, "DblClick", THIS, "TeclaDsMoedlDblClick")

            *== CHECKBOXES (original: Check1 top=271, Conc top=271) ===========

            par_oPag.AddObject("chk_4c_TotalizaContas", "CheckBox")
            WITH par_oPag.chk_4c_TotalizaContas
                .Top       = 186
                .Left      = 64
                .Width     = 92
                .Height    = 15
                .Caption   = "Totaliza Contas"
                .Value     = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("chk_4c_Conciliado", "CheckBox")
            WITH par_oPag.chk_4c_Conciliado
                .Top       = 186
                .Left      = 183
                .Width     = 66
                .Height    = 15
                .Caption   = "Conciliado"
                .Value     = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *== SECAO OPCAO NF (original: Say1 top=290, Opt_Opcao top=285) ====

            par_oPag.AddObject("lbl_4c_Opcao", "Label")
            WITH par_oPag.lbl_4c_Opcao
                .Top       = 205
                .Left      = 64
                .Width     = 40
                .Height    = 15
                .Caption   = "Op" + CHR(231) + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("obj_4c_Opt_opcao", "OptionGroup")
            WITH par_oPag.obj_4c_Opt_opcao
                .Top           = 200
                .Left          = 105
                .Width         = 177
                .Height        = 25
                .ButtonCount   = 3
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 0
                .Visible       = .T.
                .Value         = 3
            ENDWITH
            WITH par_oPag.obj_4c_Opt_opcao.Buttons(1)
                .Caption   = "Sim"
                .Top       = 5
                .Left      = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH
            WITH par_oPag.obj_4c_Opt_opcao.Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Top       = 5
                .Left      = 62
                .Width     = 37
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH
            WITH par_oPag.obj_4c_Opt_opcao.Buttons(3)
                .Caption   = "Ambos"
                .Top       = 5
                .Left      = 117
                .Width     = 50
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH

            *== SECAO FLUXO / TIPO IMPRESSAO (original: Say4 top=308, opt_tipo top=307) =

            par_oPag.AddObject("lbl_4c_Fluxo", "Label")
            WITH par_oPag.lbl_4c_Fluxo
                .Top       = 223
                .Left      = 70
                .Width     = 35
                .Height    = 15
                .Caption   = "Fluxo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("obj_4c_Opt_tipo", "OptionGroup")
            WITH par_oPag.obj_4c_Opt_tipo
                .Top           = 222
                .Left          = 105
                .Width         = 166
                .Height        = 35
                .ButtonCount   = 4
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 0
                .Visible       = .T.
                .Value         = 1
            ENDWITH
            WITH par_oPag.obj_4c_Opt_tipo.Buttons(1)
                .Caption   = "Di" + CHR(225) + "rio"
                .Top       = 1
                .Left      = 5
                .Width     = 45
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH
            WITH par_oPag.obj_4c_Opt_tipo.Buttons(2)
                .Caption   = "Semanal"
                .Top       = 1
                .Left      = 88
                .Width     = 58
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH
            WITH par_oPag.obj_4c_Opt_tipo.Buttons(3)
                .Caption   = "Quinzenal"
                .Top       = 17
                .Left      = 5
                .Width     = 75
                .Height    = 17
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH par_oPag.obj_4c_Opt_tipo.Buttons(4)
                .Caption   = "Mensal"
                .Top       = 18
                .Left      = 88
                .Width     = 61
                .Height    = 17
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *== SECAO LISTAR ATRASOS (original: Say7 top=342, opt_Lista_Atra top=337) =

            par_oPag.AddObject("lbl_4c_ListaAtra", "Label")
            WITH par_oPag.lbl_4c_ListaAtra
                .Top       = 257
                .Left      = 85
                .Width     = 75
                .Height    = 15
                .Caption   = "Listar Atrasos :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("obj_4c_Opt_lista_atra", "OptionGroup")
            WITH par_oPag.obj_4c_Opt_lista_atra
                .Top           = 252
                .Left          = 174
                .Width         = 109
                .Height        = 25
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 0
                .Visible       = .T.
                .Value         = 1
            ENDWITH
            WITH par_oPag.obj_4c_Opt_lista_atra.Buttons(1)
                .Caption   = "Sim"
                .Top       = 5
                .Left      = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH
            WITH par_oPag.obj_4c_Opt_lista_atra.Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Top       = 5
                .Left      = 62
                .Width     = 37
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH
            BINDEVENT(par_oPag.obj_4c_Opt_lista_atra, "InteractiveChange", THIS, "OptListaAtraChange")

            *== SECAO CONSIDERAR ATRASOS (original: Say5 top=362, Opt_Consid top=357) =

            par_oPag.AddObject("lbl_4c_ConsidAtra", "Label")
            WITH par_oPag.lbl_4c_ConsidAtra
                .Top       = 277
                .Left      = 54
                .Width     = 101
                .Height    = 15
                .Caption   = "Considerar Atrasos :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("obj_4c_Opt_consid_atra", "OptionGroup")
            WITH par_oPag.obj_4c_Opt_consid_atra
                .Top           = 272
                .Left          = 174
                .Width         = 109
                .Height        = 25
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 0
                .Visible       = .T.
                .Value         = 2
            ENDWITH
            WITH par_oPag.obj_4c_Opt_consid_atra.Buttons(1)
                .Caption   = "Sim"
                .Top       = 5
                .Left      = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH
            WITH par_oPag.obj_4c_Opt_consid_atra.Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Top       = 5
                .Left      = 62
                .Width     = 37
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH

            *== SECAO PREVISTO (original: Say8 top=380, OptPrev top=376) =======

            par_oPag.AddObject("lbl_4c_Previsto", "Label")
            WITH par_oPag.lbl_4c_Previsto
                .Top       = 295
                .Left      = 60
                .Width     = 48
                .Height    = 15
                .Caption   = "Previsto :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("obj_4c_Opt_prev", "OptionGroup")
            WITH par_oPag.obj_4c_Opt_prev
                .Top           = 291
                .Left          = 112
                .Width         = 172
                .Height        = 27
                .ButtonCount   = 3
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 0
                .Visible       = .T.
                .Value         = 3
            ENDWITH
            WITH par_oPag.obj_4c_Opt_prev.Buttons(1)
                .Caption   = "Sim"
                .Top       = 5
                .Left      = 5
                .Width     = 57
                .Height    = 17
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH par_oPag.obj_4c_Opt_prev.Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Top       = 5
                .Left      = 56
                .Width     = 49
                .Height    = 17
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH par_oPag.obj_4c_Opt_prev.Buttons(3)
                .Caption   = "Ambos"
                .Top       = 5
                .Left      = 107
                .Width     = 55
                .Height    = 17
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *== SECAO SITUACAO (RIGHT - original: Say6 top=379, left=309, opt_situa top=374) =

            par_oPag.AddObject("lbl_4c_Situa", "Label")
            WITH par_oPag.lbl_4c_Situa
                .Top       = 294
                .Left      = 309
                .Width     = 50
                .Height    = 15
                .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("obj_4c_Opt_situa", "OptionGroup")
            WITH par_oPag.obj_4c_Opt_situa
                .Top           = 289
                .Left          = 361
                .Width         = 225
                .Height        = 27
                .ButtonCount   = 3
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 0
                .Visible       = .T.
                .Value         = 2
            ENDWITH
            WITH par_oPag.obj_4c_Opt_situa.Buttons(1)
                .Caption   = "Baixados"
                .Top       = 5
                .Left      = 5
                .Width     = 61
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH
            WITH par_oPag.obj_4c_Opt_situa.Buttons(2)
                .Caption   = "Pendentes"
                .Top       = 5
                .Left      = 78
                .Width     = 67
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH
            WITH par_oPag.obj_4c_Opt_situa.Buttons(3)
                .Caption   = "Todos"
                .Top       = 5
                .Left      = 162
                .Width     = 53
                .Height    = 17
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *== SECAO SALDO (original: Say3 top=539, OptSaldo top=534) =========

            par_oPag.AddObject("lbl_4c_Saldo", "Label")
            WITH par_oPag.lbl_4c_Saldo
                .Top       = 454
                .Left      = 81
                .Width     = 35
                .Height    = 15
                .Caption   = "Saldo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oPag.AddObject("obj_4c_Opt_saldo", "OptionGroup")
            WITH par_oPag.obj_4c_Opt_saldo
                .Top           = 449
                .Left          = 122
                .Width         = 142
                .Height        = 25
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 0
                .Visible       = .T.
                .Value         = 1
            ENDWITH
            WITH par_oPag.obj_4c_Opt_saldo.Buttons(1)
                .Caption   = "Anterior"
                .Top       = 5
                .Left      = 5
                .Width     = 57
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH
            WITH par_oPag.obj_4c_Opt_saldo.Buttons(2)
                .Caption   = "Na Data"
                .Top       = 5
                .Left      = 75
                .Width     = 57
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa campos de filtro com valores padr" + CHR(227) + "o
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPag, loc_oErro
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPag = THIS.pgf_4c_Paginas.Page1

            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_oPag.txt_4c__dt_inicial.Value  = THIS.this_oRelatorio.this_dDtInicial
                loc_oPag.txt_4c__dt_final.Value    = THIS.this_oRelatorio.this_dDtFinal
                loc_oPag.txt_4c__cd_moeda.Value    = THIS.this_oRelatorio.this_cCdMoeda
                loc_oPag.txt_4c__ds_moeda.Value    = THIS.this_oRelatorio.this_cDsMoeda
                loc_oPag.txt_4c_cotacao.Value      = THIS.this_oRelatorio.this_nVlCotacao
            ELSE
                loc_oPag.txt_4c__dt_inicial.Value  = DATE()
                loc_oPag.txt_4c__dt_final.Value    = DATE()
                loc_oPag.txt_4c__cd_moeda.Value    = ""
                loc_oPag.txt_4c__ds_moeda.Value    = ""
                loc_oPag.txt_4c_cotacao.Value      = 0
            ENDIF

            loc_oPag.txt_4c__ds_moeda.ReadOnly          = .F.
            loc_oPag.txt_4c_cd_moedl.Value              = ""
            loc_oPag.txt_4c_ds_moedl.Value              = ""
            loc_oPag.txt_4c_ds_moedl.ReadOnly           = .F.
            loc_oPag.chk_4c_TotalizaContas.Value        = 0
            loc_oPag.chk_4c_Conciliado.Value            = 0
            loc_oPag.obj_4c_Opt_opcao.Value             = 3
            loc_oPag.obj_4c_Opt_tipo.Value              = 1
            loc_oPag.obj_4c_Opt_lista_atra.Value        = 1
            loc_oPag.obj_4c_Opt_consid_atra.Value       = 2
            loc_oPag.obj_4c_Opt_consid_atra.Enabled     = .T.
            loc_oPag.obj_4c_Opt_prev.Value              = 3
            loc_oPag.obj_4c_Opt_situa.Value             = 2
            loc_oPag.obj_4c_Opt_saldo.Value             = 1

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos filtros para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPag, loc_oErro
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPag = THIS.pgf_4c_Paginas.Page1

            WITH THIS.this_oRelatorio
                .this_dDtInicial      = loc_oPag.txt_4c__dt_inicial.Value
                .this_dDtFinal        = loc_oPag.txt_4c__dt_final.Value
                .this_cCdMoeda        = ALLTRIM(loc_oPag.txt_4c__cd_moeda.Value)
                .this_cDsMoeda        = ALLTRIM(loc_oPag.txt_4c__ds_moeda.Value)
                .this_nVlCotacao      = loc_oPag.txt_4c_cotacao.Value
                .this_cCdMoedl        = ALLTRIM(loc_oPag.txt_4c_cd_moedl.Value)
                .this_cDsMoedl        = ALLTRIM(loc_oPag.txt_4c_ds_moedl.Value)
                .this_nTotalizaContas = loc_oPag.chk_4c_TotalizaContas.Value
                .this_nConciliado     = loc_oPag.chk_4c_Conciliado.Value
                .this_nOpcao          = loc_oPag.obj_4c_Opt_opcao.Value
                .this_nTipoImp        = loc_oPag.obj_4c_Opt_tipo.Value
                .this_nListaAtra      = loc_oPag.obj_4c_Opt_lista_atra.Value
                .this_nConsidAtra     = loc_oPag.obj_4c_Opt_consid_atra.Value
                .this_nPrev           = loc_oPag.obj_4c_Opt_prev.Value
                .this_nSitua          = loc_oPag.obj_4c_Opt_situa.Value
                .this_nSaldo          = loc_oPag.obj_4c_Opt_saldo.Value
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormParaRelatorio")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza relat" + CHR(243) + "rio em tela
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            MsgErro("BO de relat" + CHR(243) + "rio n" + CHR(227) + "o inicializado.", "Erro")
            RETURN
        ENDIF
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Visualizar()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Visualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            MsgErro("BO de relat" + CHR(243) + "rio n" + CHR(227) + "o inicializado.", "Erro")
            RETURN
        ENDIF
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Imprimir()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Imprimir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnImprimirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados para Excel
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            MsgErro("BO de relat" + CHR(243) + "rio n" + CHR(227) + "o inicializado.", "Erro")
            RETURN
        ENDIF
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.GerarDocumentoExcel()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Gerar Excel")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnExcelClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - N" + CHR(227) + "o aplic" + CHR(225) + "vel em formul" + CHR(225) + "rio de relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        MsgInfo("Este " + CHR(233) + " um formul" + CHR(225) + "rio de relat" + CHR(243) + "rio." + CHR(13) + ;
                "Configure os filtros e use Visualizar ou Imprimir.", ;
                "Relat" + CHR(243) + "rio Fluxo Financeiro")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - N" + CHR(227) + "o aplic" + CHR(225) + "vel em formul" + CHR(225) + "rio de relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        MsgInfo("Este " + CHR(233) + " um formul" + CHR(225) + "rio de relat" + CHR(243) + "rio." + CHR(13) + ;
                "Os par" + CHR(226) + "metros podem ser editados diretamente nos campos.", ;
                "Relat" + CHR(243) + "rio Fluxo Financeiro")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Limpa filtros
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF MsgConfirma("Limpar todos os filtros e restaurar valores padr" + CHR(227) + "o?", ;
                       "Limpar Filtros")
            THIS.LimparCampos()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formul" + CHR(225) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnMarcarEmpClick - Marca todas as empresas para impress" + CHR(227) + "o
    *--------------------------------------------------------------------------
    PROCEDURE BtnMarcarEmpClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.MarcarEmpresas()
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Empresas.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDesmarcarEmpClick - Desmarca todas as empresas
    *--------------------------------------------------------------------------
    PROCEDURE BtnDesmarcarEmpClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.DesmarcarEmpresas()
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Empresas.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnMarcarDispClick - Marca todas as disponibilidades
    *--------------------------------------------------------------------------
    PROCEDURE BtnMarcarDispClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.MarcarDisponibilidades()
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Disps.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDesmarcarDispClick - Desmarca todas as disponibilidades
    *--------------------------------------------------------------------------
    PROCEDURE BtnDesmarcarDispClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.DesmarcarDisponibilidades()
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Disps.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnMarcarOpeClick - Marca todas as opera" + CHR(231) + CHR(245) + "es de t" + CHR(237) + "tulos
    *--------------------------------------------------------------------------
    PROCEDURE BtnMarcarOpeClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.MarcarOperacoes()
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Oper.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDesmarcarOpeClick - Desmarca todas as opera" + CHR(231) + CHR(245) + "es de t" + CHR(237) + "tulos
    *--------------------------------------------------------------------------
    PROCEDURE BtnDesmarcarOpeClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.DesmarcarOperacoes()
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Oper.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdMoeda - KeyPress: F4/Enter/Tab valida codigo de moeda referencia
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 13, 9)
            THIS.ValidarCdMoeda(THIS.pgf_4c_Paginas.Page1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsMoeda - KeyPress: F4/Enter/Tab lookup reverso por descri" + CHR(231) + CHR(227) + "o moeda ref
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 13, 9)
            THIS.ValidarDsMoeda(THIS.pgf_4c_Paginas.Page1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdMoedl - KeyPress: F4/Enter/Tab valida codigo de moeda lan" + CHR(231) + "amento
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdMoedl(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 13, 9)
            THIS.ValidarCdMoedl(THIS.pgf_4c_Paginas.Page1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsMoedl - KeyPress: F4/Enter/Tab lookup reverso por descri" + CHR(231) + CHR(227) + "o moe lanc
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsMoedl(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 13, 9)
            THIS.ValidarDsMoedl(THIS.pgf_4c_Paginas.Page1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdMoedaDblClick - DblClick em txt_4c__cd_moeda
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdMoedaDblClick()
        THIS.ValidarCdMoeda(THIS.pgf_4c_Paginas.Page1)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsMoedaDblClick - DblClick em txt_4c__ds_moeda
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsMoedaDblClick()
        THIS.ValidarDsMoeda(THIS.pgf_4c_Paginas.Page1)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdMoedlDblClick - DblClick em txt_4c_cd_moedl
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdMoedlDblClick()
        THIS.ValidarCdMoedl(THIS.pgf_4c_Paginas.Page1)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsMoedlDblClick - DblClick em txt_4c_ds_moedl
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsMoedlDblClick()
        THIS.ValidarDsMoedl(THIS.pgf_4c_Paginas.Page1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdMoeda - Valida codigo de moeda referencia (SigCdMoe)
    *   Preenche descri" + CHR(231) + CHR(227) + "o e atualiza cota" + CHR(231) + CHR(227) + "o quando codigo encontrado
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdMoeda(par_oPag)
        LOCAL loc_cCodigo, loc_oForm, loc_oErro
        TRY
            loc_cCodigo = ALLTRIM(par_oPag.txt_4c__cd_moeda.Value)
            IF EMPTY(loc_cCodigo)
                par_oPag.txt_4c__cd_moeda.Value    = ""
                par_oPag.txt_4c__ds_moeda.Value    = ""
                par_oPag.txt_4c__ds_moeda.ReadOnly = .F.
                par_oPag.txt_4c_cotacao.Value      = 0
                RETURN
            ENDIF
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                RETURN
            ENDIF
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cCodigo, ;
                "Sele" + CHR(231) + CHR(227) + "o de Moeda")
            IF VARTYPE(loc_oForm) != "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lAchouRegistro
                loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaMoe")
                    SELECT cursor_4c_BuscaMoe
                    GO TOP
                    IF !EOF()
                        par_oPag.txt_4c__cd_moeda.Value    = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                        par_oPag.txt_4c__ds_moeda.Value    = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
                        par_oPag.txt_4c__ds_moeda.ReadOnly = .T.
                        *-- Atualiza cotacao automaticamente
                        IF VARTYPE(THIS.this_oRelatorio) = "O"
                            par_oPag.txt_4c_cotacao.Value = ;
                                THIS.this_oRelatorio.BuscarCotacaoAtual( ;
                                    ALLTRIM(cursor_4c_BuscaMoe.CMoes))
                        ENDIF
                    ENDIF
                ENDIF
            ELSE
                par_oPag.txt_4c__cd_moeda.Value    = ""
                par_oPag.txt_4c__ds_moeda.Value    = ""
                par_oPag.txt_4c__ds_moeda.ReadOnly = .F.
                par_oPag.txt_4c_cotacao.Value      = 0
            ENDIF
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarCdMoeda")
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsMoeda - Lookup reverso por descri" + CHR(231) + CHR(227) + "o de moeda referencia
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsMoeda(par_oPag)
        LOCAL loc_cDesc, loc_oForm, loc_oErro
        TRY
            loc_cDesc = ALLTRIM(par_oPag.txt_4c__ds_moeda.Value)
            IF EMPTY(loc_cDesc)
                par_oPag.txt_4c__cd_moeda.Value = ""
                par_oPag.txt_4c__ds_moeda.Value = ""
                par_oPag.txt_4c_cotacao.Value   = 0
                RETURN
            ENDIF
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                RETURN
            ENDIF
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoeD", "DMoes", loc_cDesc, ;
                "Sele" + CHR(231) + CHR(227) + "o de Moeda")
            IF VARTYPE(loc_oForm) != "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lAchouRegistro
                loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaMoeD")
                    SELECT cursor_4c_BuscaMoeD
                    GO TOP
                    IF !EOF()
                        par_oPag.txt_4c__cd_moeda.Value    = ALLTRIM(cursor_4c_BuscaMoeD.CMoes)
                        par_oPag.txt_4c__ds_moeda.Value    = ALLTRIM(cursor_4c_BuscaMoeD.DMoes)
                        par_oPag.txt_4c__ds_moeda.ReadOnly = .T.
                        IF VARTYPE(THIS.this_oRelatorio) = "O"
                            par_oPag.txt_4c_cotacao.Value = ;
                                THIS.this_oRelatorio.BuscarCotacaoAtual( ;
                                    ALLTRIM(cursor_4c_BuscaMoeD.CMoes))
                        ENDIF
                    ENDIF
                ENDIF
            ELSE
                par_oPag.txt_4c__cd_moeda.Value = ""
                par_oPag.txt_4c__ds_moeda.Value = ""
                par_oPag.txt_4c_cotacao.Value   = 0
            ENDIF
            IF USED("cursor_4c_BuscaMoeD")
                USE IN cursor_4c_BuscaMoeD
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarDsMoeda")
            IF USED("cursor_4c_BuscaMoeD")
                USE IN cursor_4c_BuscaMoeD
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdMoedl - Valida codigo de moeda de lan" + CHR(231) + "amento (SigCdMoe)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdMoedl(par_oPag)
        LOCAL loc_cCodigo, loc_oForm, loc_oErro
        TRY
            loc_cCodigo = ALLTRIM(par_oPag.txt_4c_cd_moedl.Value)
            IF EMPTY(loc_cCodigo)
                par_oPag.txt_4c_cd_moedl.Value    = ""
                par_oPag.txt_4c_ds_moedl.Value    = ""
                par_oPag.txt_4c_ds_moedl.ReadOnly = .F.
                RETURN
            ENDIF
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                RETURN
            ENDIF
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoeL", "CMoes", loc_cCodigo, ;
                "Sele" + CHR(231) + CHR(227) + "o de Moeda Lan" + CHR(231) + "amento")
            IF VARTYPE(loc_oForm) != "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lAchouRegistro
                loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaMoeL")
                    SELECT cursor_4c_BuscaMoeL
                    GO TOP
                    IF !EOF()
                        par_oPag.txt_4c_cd_moedl.Value    = ALLTRIM(cursor_4c_BuscaMoeL.CMoes)
                        par_oPag.txt_4c_ds_moedl.Value    = ALLTRIM(cursor_4c_BuscaMoeL.DMoes)
                        par_oPag.txt_4c_ds_moedl.ReadOnly = .T.
                    ENDIF
                ENDIF
            ELSE
                par_oPag.txt_4c_cd_moedl.Value    = ""
                par_oPag.txt_4c_ds_moedl.Value    = ""
                par_oPag.txt_4c_ds_moedl.ReadOnly = .F.
            ENDIF
            IF USED("cursor_4c_BuscaMoeL")
                USE IN cursor_4c_BuscaMoeL
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarCdMoedl")
            IF USED("cursor_4c_BuscaMoeL")
                USE IN cursor_4c_BuscaMoeL
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsMoedl - Lookup reverso por descri" + CHR(231) + CHR(227) + "o de moeda lan" + CHR(231) + "amento
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsMoedl(par_oPag)
        LOCAL loc_cDesc, loc_oForm, loc_oErro
        TRY
            loc_cDesc = ALLTRIM(par_oPag.txt_4c_ds_moedl.Value)
            IF EMPTY(loc_cDesc)
                par_oPag.txt_4c_cd_moedl.Value = ""
                par_oPag.txt_4c_ds_moedl.Value = ""
                RETURN
            ENDIF
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                RETURN
            ENDIF
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoeLD", "DMoes", loc_cDesc, ;
                "Sele" + CHR(231) + CHR(227) + "o de Moeda Lan" + CHR(231) + "amento")
            IF VARTYPE(loc_oForm) != "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lAchouRegistro
                loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaMoeLD")
                    SELECT cursor_4c_BuscaMoeLD
                    GO TOP
                    IF !EOF()
                        par_oPag.txt_4c_cd_moedl.Value    = ALLTRIM(cursor_4c_BuscaMoeLD.CMoes)
                        par_oPag.txt_4c_ds_moedl.Value    = ALLTRIM(cursor_4c_BuscaMoeLD.DMoes)
                        par_oPag.txt_4c_ds_moedl.ReadOnly = .T.
                    ENDIF
                ENDIF
            ELSE
                par_oPag.txt_4c_cd_moedl.Value = ""
                par_oPag.txt_4c_ds_moedl.Value = ""
            ENDIF
            IF USED("cursor_4c_BuscaMoeLD")
                USE IN cursor_4c_BuscaMoeLD
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarDsMoedl")
            IF USED("cursor_4c_BuscaMoeLD")
                USE IN cursor_4c_BuscaMoeLD
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * OptListaAtraChange - Habilita/desabilita ConsidAtra conforme ListaAtra
    *   Quando "Listar Atrasos = N" + CHR(227) + "o" (Value=2): desabilita ConsidAtra
    *--------------------------------------------------------------------------
    PROCEDURE OptListaAtraChange()
        LOCAL loc_oPag, loc_oErro
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF loc_oPag.obj_4c_Opt_lista_atra.Value = 2
                loc_oPag.obj_4c_Opt_consid_atra.Value   = 2
                loc_oPag.obj_4c_Opt_consid_atra.Enabled = .F.
            ELSE
                loc_oPag.obj_4c_Opt_consid_atra.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "OptListaAtraChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Alias: visualiza relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formul" + CHR(225) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Imprime relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Limpa filtros
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        IF MsgConfirma("Limpar todos os filtros e restaurar valores padr" + CHR(227) + "o?", ;
                       "Limpar Filtros")
            THIS.LimparCampos()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias de FormParaRelatorio para conformidade com API
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO de volta para os campos do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPag, loc_oErro
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                loc_oPag.txt_4c__dt_inicial.Value        = .this_dDtInicial
                loc_oPag.txt_4c__dt_final.Value          = .this_dDtFinal
                loc_oPag.txt_4c__cd_moeda.Value          = .this_cCdMoeda
                loc_oPag.txt_4c__ds_moeda.Value          = .this_cDsMoeda
                loc_oPag.txt_4c_cotacao.Value            = .this_nVlCotacao
                loc_oPag.txt_4c_cd_moedl.Value           = .this_cCdMoedl
                loc_oPag.txt_4c_ds_moedl.Value           = .this_cDsMoedl
                loc_oPag.chk_4c_TotalizaContas.Value     = .this_nTotalizaContas
                loc_oPag.chk_4c_Conciliado.Value         = .this_nConciliado
                loc_oPag.obj_4c_Opt_opcao.Value          = .this_nOpcao
                loc_oPag.obj_4c_Opt_tipo.Value           = .this_nTipoImp
                loc_oPag.obj_4c_Opt_lista_atra.Value     = .this_nListaAtra
                loc_oPag.obj_4c_Opt_consid_atra.Value    = .this_nConsidAtra
                loc_oPag.obj_4c_Opt_prev.Value           = .this_nPrev
                loc_oPag.obj_4c_Opt_situa.Value          = .this_nSitua
                loc_oPag.obj_4c_Opt_saldo.Value          = .this_nSaldo
            ENDWITH
            loc_oPag.txt_4c__ds_moeda.ReadOnly      = !EMPTY(ALLTRIM(loc_oPag.txt_4c__cd_moeda.Value))
            loc_oPag.txt_4c_ds_moedl.ReadOnly       = !EMPTY(ALLTRIM(loc_oPag.txt_4c_cd_moedl.Value))
            loc_oPag.obj_4c_Opt_consid_atra.Enabled = (loc_oPag.obj_4c_Opt_lista_atra.Value = 1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita todos os campos de filtro para edicao
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos()
        LOCAL loc_oPag, loc_oErro
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            loc_oPag.txt_4c__dt_inicial.ReadOnly     = .F.
            loc_oPag.txt_4c__dt_final.ReadOnly       = .F.
            loc_oPag.txt_4c__cd_moeda.ReadOnly       = .F.
            loc_oPag.txt_4c_cotacao.ReadOnly         = .F.
            loc_oPag.txt_4c_cd_moedl.ReadOnly        = .F.
            loc_oPag.chk_4c_TotalizaContas.Enabled   = .T.
            loc_oPag.chk_4c_Conciliado.Enabled       = .T.
            loc_oPag.obj_4c_Opt_opcao.Enabled        = .T.
            loc_oPag.obj_4c_Opt_tipo.Enabled         = .T.
            loc_oPag.obj_4c_Opt_lista_atra.Enabled   = .T.
            loc_oPag.obj_4c_Opt_consid_atra.Enabled  = (loc_oPag.obj_4c_Opt_lista_atra.Value = 1)
            loc_oPag.obj_4c_Opt_prev.Enabled         = .T.
            loc_oPag.obj_4c_Opt_situa.Enabled        = .T.
            loc_oPag.obj_4c_Opt_saldo.Enabled        = .T.
            loc_oPag.txt_4c__ds_moeda.ReadOnly = !EMPTY(ALLTRIM(loc_oPag.txt_4c__cd_moeda.Value))
            loc_oPag.txt_4c_ds_moedl.ReadOnly  = !EMPTY(ALLTRIM(loc_oPag.txt_4c_cd_moedl.Value))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Atualiza grids de sele" + CHR(231) + CHR(227) + "o (Empresas/Disps/Opera" + CHR(231) + CHR(245) + "es)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_oPag, loc_oErro, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_oPag = THIS.pgf_4c_Paginas.Page1
                IF VARTYPE(loc_oPag.grd_4c_Empresas) = "O" AND USED("cEmp")
                    loc_oPag.grd_4c_Empresas.RecordSource = "cEmp"
                    loc_oPag.grd_4c_Empresas.Refresh()
                ENDIF
                IF VARTYPE(loc_oPag.grd_4c_Disps) = "O" AND USED("cDisp")
                    loc_oPag.grd_4c_Disps.RecordSource = "cDisp"
                    loc_oPag.grd_4c_Disps.Refresh()
                ENDIF
                IF VARTYPE(loc_oPag.grd_4c_Oper) = "O" AND USED("crSigOpOpe")
                    loc_oPag.grd_4c_Oper.RecordSource = "crSigOpOpe"
                    loc_oPag.grd_4c_Oper.Refresh()
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarLista")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita bot" + CHR(245) + "es do relat" + CHR(243) + "rio (sem modos CRUD)
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
                THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o formul" + CHR(225) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigreffnBO.prg):
*==============================================================================
* SIGREFFNBO.PRG
* Business Object para Relatorio de Fluxo Financeiro - Sintetico (SIGREFFN)
*
* Herda de RelatorioBase
*
* Formulario de origem: sigreffn.SCX (frmrelatorio)
* Reports FRX: SigReFf1.frx (Diario/Mensal - sem totalizacao de contas)
*              SigReFf2.frx (Semanal/Quinzenal - sem totalizacao de contas)
*              SigReFf3.frx (com totalizacao de contas - Check1 marcado)
*
* Filtros:
*   - Periodo (data inicial / data final)
*   - Moeda de referencia (codigo + descricao + cotacao)
*   - Moeda de lancamento (codigo + descricao)
*   - Totaliza Contas (CheckBox)
*   - Conciliado (CheckBox)
*   - Opcao NF (1=Sim / 2=Nao / 3=Ambos)
*   - Tipo Impressao (1=Diario / 2=Semanal / 3=Quinzenal / 4=Mensal)
*   - Saldo (1=Anterior / 2=Na Data)
*   - Situacao (1=Baixados / 2=Pendentes / 3=Todos)
*   - Listar Atrasos (1=Sim / 2=Nao)
*   - Considerar Atrasos (1=Sim / 2=Nao)
*   - Previsto (1=Sim / 2=Nao / 3=Ambos)
*   - Empresas selecionadas (cursor cEmp com campo ImpEmps)
*   - Disponibilidades selecionadas (cursor cDisp com campo ImpDisps)
*   - Operacoes de Titulos selecionadas (cursor crSigOpOpe com campo SeleOp)
*==============================================================================

DEFINE CLASS sigreffnBO AS RelatorioBase

    *-- Filtros de periodo
    this_dDtInicial         = {}
    this_dDtFinal           = {}

    *-- Filtros de moeda de referencia (conversao de valores)
    this_cCdMoeda           = ""
    this_cDsMoeda           = ""
    this_nVlCotacao         = 0

    *-- Filtros de moeda de lancamento (filtro nos titulos)
    this_cCdMoedl           = ""
    this_cDsMoedl           = ""

    *-- CheckBoxes
    this_nTotalizaContas    = 0  && 0=Desmarcado 1=Marcado
    this_nConciliado        = 0  && 0=Desmarcado 1=Marcado

    *-- Opcoes de filtro - OptionGroups (espelham .Value do form legado)
    this_nOpcao             = 3  && Opt_Opcao:       1=Sim(com NF) 2=Nao(sem NF) 3=Ambos
    this_nTipoImp           = 1  && opt_tipo:        1=Diario 2=Semanal 3=Quinzenal 4=Mensal
    this_nSaldo             = 1  && OptSaldo:        1=Anterior 2=Na Data
    this_nSitua             = 2  && opt_situa:       1=Baixados 2=Pendentes 3=Todos
    this_nListaAtra         = 1  && opt_Lista_Atra:  1=Sim 2=Nao
    this_nConsidAtra        = 2  && Opt_Consid_Atra: 1=Sim 2=Nao
    this_nPrev              = 3  && OptPrev:         1=Sim(previsto) 2=Nao 3=Ambos

    *-- Chave unica de processamento para SigTempR
    *   Populada em PrepararDados() via fUniqueIds()
    this_cChaveQuery        = ""

    *-- Nome do cursor de dados gerado por PrepararDados()
    this_cCursorDados       = "cursor_4c_Dados"

    *-- Mensagem de erro
    this_cMensagemErro      = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO do relatorio de Fluxo Financeiro
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a mensagem de erro mais recente
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursoresAuxiliares - Carrega cursores de referencia para os grids do form
    * Equivalente ao Init() do legado: crSigOpOpe, cEmp, cDisp, crSigCdPag, crSigCdRec, etc.
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursoresAuxiliares()
        LOCAL loc_lSucesso, loc_lnResult
        loc_lSucesso = .F.
        TRY
            *-- Opera??es de T?tulo (SigOpOpe -> crSigOpOpe)
            loc_lnResult = SQLEXEC(gnConnHandle, ;
                "SELECT Dopes, Opers, RealPrevs, OpeCancs FROM SigOpOpe", ;
                "cursor_4c_TmpSigOpOpe")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar opera" + CHR(231) + CHR(245) + "es de t" + CHR(237) + "tulo"
                loc_lSucesso = .F.
            ENDIF
            SELECT .F. AS SeleOp, Dopes, RealPrevs, Opers ;
              FROM cursor_4c_TmpSigOpOpe ;
             WHERE OpeCancs <> 1 ;
             ORDER BY Dopes ;
              INTO CURSOR crSigOpOpe READWRITE
            IF USED("cursor_4c_TmpSigOpOpe")
                USE IN cursor_4c_TmpSigOpOpe
            ENDIF
            SELECT crSigOpOpe
            INDEX ON Dopes TAG Dopes
            INDEX ON TRANSFORM(SeleOp, "@!") + Dopes TAG SeleOp
            SET ORDER TO Dopes
            GO TOP

            *-- Empresas (SigCdEmp -> cEmp)
            loc_lnResult = SQLEXEC(gnConnHandle, ;
                "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Razas", ;
                "cursor_4c_TmpSigCdEmp")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar empresas"
                loc_lSucesso = .F.
            ENDIF
            SELECT .F. AS ImpEmps, Cemps, Razas ;
              FROM cursor_4c_TmpSigCdEmp ;
              INTO CURSOR cEmp READWRITE
            IF USED("cursor_4c_TmpSigCdEmp")
                USE IN cursor_4c_TmpSigCdEmp
            ENDIF
            SELECT cEmp
            INDEX ON Cemps TAG Cemps
            INDEX ON TRANSFORM(ImpEmps, "@!") + Cemps TAG ImpEmps
            SET ORDER TO Cemps
            *-- Marca empresa corrente automaticamente
            IF SEEK(ALLTRIM(go_4c_Sistema.cCodEmpresa), "cEmp", "Cemps")
                LOCAL loc_ImpEmps
                loc_ImpEmps = .T.
                GATHER MEMVAR FIELDS ImpEmps
            ENDIF

            *-- Disponibilidades (SigCdDis -> cDisp) - todas marcadas por default
            loc_lnResult = SQLEXEC(gnConnHandle, ;
                "SELECT Grupos, Contas, Tipos FROM SigCdDis WHERE Tipos IN (0,1) ORDER BY Grupos", ;
                "cursor_4c_TmpSigCdDis")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar disponibilidades"
                loc_lSucesso = .F.
            ENDIF
            SELECT .T. AS ImpDisps, Grupos, Contas ;
              FROM cursor_4c_TmpSigCdDis ;
              INTO CURSOR cDisp READWRITE
            IF USED("cursor_4c_TmpSigCdDis")
                USE IN cursor_4c_TmpSigCdDis
            ENDIF
            SELECT cDisp
            INDEX ON Grupos + Contas TAG Grupos
            INDEX ON TRANSFORM(ImpDisps, "@!") + Grupos + Contas TAG ImpDisps
            SET ORDER TO Grupos

            *-- Grupos de Pagamento (SigCdPag -> crSigCdPag)
            loc_lnResult = SQLEXEC(gnConnHandle, "SELECT Grupos, RelPrevs FROM SigCdPag", "crSigCdPag")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar grupos de pagamento"
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdPag
            INDEX ON Grupos TAG Grupos

            *-- Grupos de Recebimento (SigCdRec -> crSigCdRec)
            loc_lnResult = SQLEXEC(gnConnHandle, "SELECT Grupos FROM SigCdRec", "crSigCdRec")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar grupos de recebimento"
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdRec
            INDEX ON Grupos TAG Grupos

            *-- Moedas (SigCdMoe -> crSigCdMoe)
            loc_lnResult = SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes, Cotas FROM SigCdMoe", "crSigCdMoe")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar moedas"
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdMoe
            INDEX ON CMoes TAG CMoes

            *-- Cota??es de Moeda (SigCdCot -> crSigCdCot)
            loc_lnResult = SQLEXEC(gnConnHandle, ;
                "SELECT CMoes, Datas, Valos FROM SigCdCot", "crSigCdCot")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar cota" + CHR(231) + CHR(245) + "es"
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdCot
            INDEX ON CMoes + DTOS(Datas) TAG CMoeData

            *-- Moeda padr?o (SigCdPam) - define valores default do form
            loc_lnResult = SQLEXEC(gnConnHandle, "SELECT TOP 1 MoedaPs FROM SigCdPam", "crSigCdPam")
            IF loc_lnResult > 0 AND !EOF("crSigCdPam")
                THIS.this_cCdMoeda   = ALLTRIM(crSigCdPam.MoedaPs)
                THIS.this_dDtInicial = DATE()
                THIS.this_dDtFinal   = DATE()
                *-- Descri??o da moeda padr?o
                IF USED("crSigCdMoe") AND SEEK(ALLTRIM(crSigCdPam.MoedaPs), "crSigCdMoe", "CMoes")
                    THIS.this_cDsMoeda = ALLTRIM(crSigCdMoe.DMoes)
                ENDIF
                *-- Cota??o atual da moeda padr?o
                THIS.this_nVlCotacao = THIS.BuscarCotacaoAtual(ALLTRIM(crSigCdPam.MoedaPs))
            ENDIF
            IF USED("crSigCdPam")
                USE IN crSigCdPam
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em InicializarCursoresAuxiliares")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa todo o processamento do fluxo financeiro
    * Equivalente ao m?todo Procedure (729 linhas) do legado SIGREFFN
    * Cria cursors: csRelatorio, csCabecalho, crRel (semanal/quinzenal)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        LOCAL loc_ldDtInicial, loc_ldDtFinal, loc_lcCdMoeda, loc_lcDsMoeda
        LOCAL loc_lnVlCotacao, loc_lnSaldos, loc_llImprime, loc_llConc
        LOCAL loc_lnOpcao, loc_lcMoeLanc, loc_lnTipoImp, loc_lnConsAtra
        LOCAL loc_lnNrSitua, loc_lnListaAtra, loc_lnNrPrev
        LOCAL loc_lcNmEmpresa, loc_lcNmTitulo, loc_lcNmPeriodo
        LOCAL loc_lcCbEmpresa, loc_lcCbMoeda, loc_lcCbMoeRef
        LOCAL loc_lcQuery, loc_ldDtAux, loc_lnResult
        LOCAL loc_lnSaldo, loc_lnVlSaldoTotal, loc_lnTotAtrasos
        LOCAL loc_pKey, loc_llPrevs
        LOCAL loc_lnCtReferencia, loc_lnVlConvertido
        LOCAL loc_ldVencimento, loc_lnPagamentos, loc_lnRecebimentos
        LOCAL loc_lnDoDia, loc_lnAcumulado, loc_lnPrevPag, loc_lnPrevRec
        LOCAL loc_i, loc_lcCursor, loc_lnIdx
        LOCAL loc_dSaldoData, loc_pGcm, loc_pDat, loc_pDtI, loc_pDtF
        LOCAL loc_pDop, loc_pRea, loc_pIds

        loc_lSucesso = .F.
        TRY
            *-- Mapear propriedades para vari?veis locais
            loc_ldDtInicial  = THIS.this_dDtInicial
            loc_ldDtFinal    = THIS.this_dDtFinal
            loc_lcCdMoeda    = THIS.this_cCdMoeda
            loc_lcDsMoeda    = THIS.this_cDsMoeda
            loc_lnVlCotacao  = THIS.this_nVlCotacao
            loc_lnSaldos     = THIS.this_nSaldo
            loc_llImprime    = (THIS.this_nTotalizaContas = 1)
            loc_llConc       = (THIS.this_nConciliado = 1)
            loc_lnOpcao      = THIS.this_nOpcao
            loc_lcMoeLanc    = THIS.this_cCdMoedl
            loc_lnTipoImp    = THIS.this_nTipoImp
            loc_lnConsAtra   = THIS.this_nConsidAtra
            loc_lnNrSitua    = THIS.this_nSitua
            loc_lnListaAtra  = THIS.this_nListaAtra
            loc_lnNrPrev     = THIS.this_nPrev

            IF EMPTY(loc_ldDtFinal)
                THIS.this_cMensagemErro = "Data final " + CHR(233) + " obrigat" + CHR(243) + "ria"
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(loc_lcCdMoeda)
                THIS.this_cMensagemErro = "Moeda de refer" + CHR(234) + "ncia " + CHR(233) + " obrigat" + CHR(243) + "ria"
                loc_lSucesso = .F.
            ENDIF
            IF loc_lnVlCotacao = 0
                loc_lnVlCotacao = 1
            ENDIF

            *-- Nome da empresa corrente
            loc_lnResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Razas FROM SigCdEmp WHERE Cemps = '" + ;
                ALLTRIM(go_4c_Sistema.cCodEmpresa) + "'", "cursor_4c_NmEmp")
            loc_lcNmEmpresa = ""
            IF loc_lnResult > 0 AND !EOF("cursor_4c_NmEmp")
                loc_lcNmEmpresa = ALLTRIM(cursor_4c_NmEmp.Razas)
            ENDIF
            IF USED("cursor_4c_NmEmp")
                USE IN cursor_4c_NmEmp
            ENDIF

            *-- Strings do cabe?alho
            loc_lcNmTitulo  = "Fluxo Financeiro" + IIF(loc_llConc, " - (Conciliado)", "")
            loc_lcNmPeriodo = "Per" + CHR(237) + "odo: " + DTOC(loc_ldDtInicial) + ;
                              " " + CHR(224) + " " + DTOC(loc_ldDtFinal)
            loc_lcCbEmpresa = ""
            loc_lcCbMoeda   = "Moeda: " + ALLTRIM(loc_lcCdMoeda) + " - " + ;
                              PROPER(ALLTRIM(loc_lcDsMoeda)) + " / " + ;
                              "Cota" + CHR(231) + CHR(227) + "o: " + ;
                              ALLTRIM(TRANSFORM(loc_lnVlCotacao, "999,999.99"))
            loc_lcCbMoeRef  = loc_lcCdMoeda
            IF loc_lnNrSitua <> 3
                loc_lcCbEmpresa = loc_lcCbEmpresa + "   Situa" + CHR(231) + CHR(227) + "o: " + ;
                                  IIF(loc_lnNrSitua = 1, "Baixados", "Pendentes")
            ENDIF

            *-- Cursor de per?odos (semanal/quinzenal)
            CREATE CURSOR crPeriodos (dFinal d(8))
            IF loc_lnTipoImp = 2 OR loc_lnTipoImp = 3
                loc_ldDtAux = loc_ldDtInicial
                IF loc_lnTipoImp = 2
                    DO WHILE loc_ldDtAux <= loc_ldDtFinal
                        INSERT INTO crPeriodos VALUES (THIS.GoDayOfWeek(loc_ldDtAux, 7))
                        loc_ldDtAux = loc_ldDtAux + 7
                    ENDDO
                ELSE
                    loc_ldDtAux = IIF(DAY(loc_ldDtInicial) > 15, ;
                        GOMONTH(loc_ldDtInicial, 1) - DAY(loc_ldDtInicial), ;
                        CTOD("15" + RIGHT(DTOC(loc_ldDtInicial), 8)))
                    DO WHILE loc_ldDtAux <= loc_ldDtFinal
                        INSERT INTO crPeriodos VALUES (loc_ldDtAux)
                        loc_ldDtAux = loc_ldDtAux + IIF(DAY(loc_ldDtAux) = 1, 16, 1)
                        loc_ldDtAux = IIF(DAY(loc_ldDtAux) > 15, ;
                            GOMONTH(loc_ldDtAux, 1) - DAY(loc_ldDtAux), ;
                            CTOD("15" + RIGHT(DTOC(loc_ldDtAux), 8)))
                    ENDDO
                ENDIF
                IF crPeriodos.dFinal < loc_ldDtFinal
                    INSERT INTO crPeriodos VALUES (loc_ldDtFinal)
                ENDIF
                IF crPeriodos.dFinal > loc_ldDtFinal
                    REPLACE dFinal WITH loc_ldDtFinal IN crPeriodos
                ENDIF
            ENDIF

            *-- Cursor de resultado
            CREATE CURSOR csRelatorio (Grupos c(10), Contas c(10), Saldos n(12,2), ;
                Moedas c(3), vl_Convertido n(12,2), vl_Cotacao n(9,2), Vencs c(10), ;
                Pags n(12,2), Recs n(12,2), do_Dia n(12,2), Acumulado n(12,2), ;
                Saldo n(12,2), Fase n(1,0), DsContas c(50), PrevPags n(12,2), PrevRecs n(12,2))
            IF loc_llImprime
                INDEX ON STR(Fase, 1) + Contas TAG Fase
            ELSE
                INDEX ON STR(Fase, 1) + Grupos + Contas TAG Fase
            ENDIF

            *-- Cursor de cabe?alho para o relat?rio
            CREATE CURSOR csCabecalho (nm_empresa c(80), nm_titulo c(80), nm_periodo c(80), ;
                cb_empresa c(80), cb_moeda c(80), cb_moe_ref c(3), ConsidAtra n(1))
            INSERT INTO csCabecalho (nm_empresa, nm_titulo, nm_periodo, cb_empresa, ;
                cb_moeda, cb_moe_ref, ConsidAtra) ;
                VALUES (loc_lcNmEmpresa, loc_lcNmTitulo, loc_lcNmPeriodo, ;
                    loc_lcCbEmpresa, loc_lcCbMoeda, loc_lcCbMoeRef, loc_lnConsAtra)

            *-- Chave ?nica para namespacing em SigTempR
            loc_pKey      = SYS(2015)
            THIS.this_cChaveQuery = loc_pKey
            loc_llPrevs   = .F.

            *-- Inserir opera??es selecionadas em SigTempR (SQL Server)
            WAIT WINDOW "Atualizando Arquivo Tempor" + CHR(225) + "rio..." NOWAIT
            SELECT crSigOpOpe
            GO TOP
            SCAN
                IF crSigOpOpe.SeleOp
                    loc_pDop = ALLTRIM(crSigOpOpe.Dopes)
                    loc_pRea = crSigOpOpe.RealPrevs
                    loc_pIds = SYS(2015)
                    IF crSigOpOpe.RealPrevs = 2
                        loc_llPrevs = .T.
                    ENDIF
                    loc_lcQuery = "INSERT INTO SigTempR (Dopes, ValPres, cIdQuerys, cIdChaves) " + ;
                                  "VALUES ('" + loc_pDop + "'," + ;
                                  TRANSFORM(loc_pRea) + ",'" + ALLTRIM(loc_pKey) + ;
                                  "','" + ALLTRIM(loc_pIds) + "')"
                    loc_lnResult = SQLEXEC(gnConnHandle, loc_lcQuery)
                    IF loc_lnResult < 1
                        THIS.this_cMensagemErro = "Falha ao inserir em SigTempR - " + loc_pDop
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF
            ENDSCAN

            *-- Par?metros de data para as queries
            loc_pDtI = "'" + STR(YEAR(loc_ldDtInicial), 4) + "-" + ;
                       PADL(STR(MONTH(loc_ldDtInicial), 2), 2, "0") + "-" + ;
                       PADL(STR(DAY(loc_ldDtInicial), 2), 2, "0") + "'"
            loc_pDtF = "'" + STR(YEAR(loc_ldDtFinal), 4) + "-" + ;
                       PADL(STR(MONTH(loc_ldDtFinal), 2), 2, "0") + "-" + ;
                       PADL(STR(DAY(loc_ldDtFinal), 2), 2, "0") + " 23:59:59'"

            *-- Buscar contas com movimentos (SigMvSlc) cruzando com disponibilidades
            IF !EMPTY(loc_lcMoeLanc)
                loc_lcQuery = "SELECT a.Grupos, a.Contas, a.Moedas, b.cContabs " + ;
                              "FROM SigMvSlc a INNER JOIN SigCdCli b ON b.iClis = a.Contas " + ;
                              "WHERE a.Moedas = '" + ALLTRIM(loc_lcMoeLanc) + "' " + ;
                              "ORDER BY a.Grupos, a.Contas, a.Moedas"
            ELSE
                loc_lcQuery = "SELECT a.Grupos, a.Contas, a.Moedas, b.cContabs " + ;
                              "FROM SigMvSlc a INNER JOIN SigCdCli b ON b.iClis = a.Contas " + ;
                              "ORDER BY a.Grupos, a.Contas, a.Moedas"
            ENDIF
            loc_lnResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigMvSlc")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Erro ao consultar SigMvSlc"
                loc_lSucesso = .F.
            ENDIF

            *-- Cursor tempor?rio: contas filtradas pelas disponibilidades selecionadas
            SELECT a.Grupos, a.Contas, 0.00 AS Saldos, a.Moedas, 1 AS Fase, cContabs, ;
                   a.Grupos + a.Contas + a.Moedas AS GruConMoes ;
              FROM crSigMvSlc a, cDisp b ;
             WHERE b.Grupos + b.Contas = a.Grupos + a.Contas ;
               AND b.ImpDisps ;
             ORDER BY a.Grupos, a.Contas ;
              INTO CURSOR csTemporario READWRITE
            IF USED("crSigMvSlc")
                USE IN crSigMvSlc
            ENDIF

            *-- Calcular saldo inicial de cada conta
            SELECT csTemporario
            GO TOP
            SCAN
                loc_lnSaldo  = 0
                loc_pGcm     = csTemporario.GruConMoes
                loc_dSaldoData = loc_ldDtInicial - IIF(loc_lnSaldos = 1, 1, 0)
                loc_pDat = "'" + STR(YEAR(loc_dSaldoData), 4) + "-" + ;
                           PADL(STR(MONTH(loc_dSaldoData), 2), 2, "0") + "-" + ;
                           PADL(STR(DAY(loc_dSaldoData), 2), 2, "0") + " 23:59:59'"
                IF !EMPTY(loc_lcMoeLanc)
                    loc_lcQuery = "SELECT TOP 1 Nfs, SaldoCs, Saldos, cIdChaves " + ;
                                  "FROM SigMvCcr " + ;
                                  "WHERE GruConMoes = '" + ALLTRIM(loc_pGcm) + "'" + ;
                                  " AND Moedas = '" + ALLTRIM(loc_lcMoeLanc) + "'" + ;
                                  " AND Datas <= " + loc_pDat + ;
                                  " ORDER BY GruConMoes ASC, cIdChaves DESC"
                ELSE
                    loc_lcQuery = "SELECT TOP 1 Nfs, SaldoCs, Saldos, cIdChaves " + ;
                                  "FROM SigMvCcr " + ;
                                  "WHERE GruConMoes = '" + ALLTRIM(loc_pGcm) + "'" + ;
                                  " AND Datas <= " + loc_pDat + ;
                                  " ORDER BY GruConMoes ASC, cIdChaves DESC"
                ENDIF
                loc_lnResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigMvCcr")
                IF loc_lnResult < 1
                    THIS.this_cMensagemErro = "Erro ao consultar SigMvCcr (saldo inicial)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT crSigMvCcr
                GO TOP
                IF !EOF("crSigMvCcr") AND ;
                   IIF(loc_lnOpcao <> 3, ;
                       IIF(loc_lnOpcao = 1, !EMPTY(csTemporario.cContabs), ;
                           EMPTY(csTemporario.cContabs)), .T.)
                    loc_lnSaldo = IIF(loc_llConc, crSigMvCcr.Saldocs, crSigMvCcr.Saldos)
                    REPLACE Saldos WITH loc_lnSaldo IN csTemporario
                ENDIF
                IF USED("crSigMvCcr")
                    USE IN crSigMvCcr
                ENDIF
            ENDSCAN

            SELECT csTemporario
            DELETE FROM csTemporario WHERE Saldos = 0
            GO TOP

            *-- Acumular saldo total e popular csRelatorio com saldos iniciais
            loc_lnVlSaldoTotal = 0
            SELECT csTemporario
            GO TOP
            SCAN
                SCATTER MEMVAR
                INSERT INTO csRelatorio FROM MEMVAR
                loc_lnCtReferencia = THIS.BuscarCambio(csRelatorio.Moedas)
                loc_lnCtReferencia = IIF(loc_lnCtReferencia = 0, 1, loc_lnCtReferencia)
                loc_lnVlConvertido = (csRelatorio.Saldos * loc_lnCtReferencia / loc_lnVlCotacao)
                REPLACE vl_Convertido WITH loc_lnVlConvertido, ;
                        vl_Cotacao    WITH loc_lnVlCotacao IN csRelatorio
                loc_lnVlSaldoTotal = loc_lnVlSaldoTotal + loc_lnVlConvertido
            ENDSCAN
            IF USED("csTemporario")
                USE IN csTemporario
            ENDIF

            *-- Processamento de atrasos (t?tulos vencidos antes do per?odo)
            loc_lnTotAtrasos = 0
            IF loc_lnListaAtra = 1
                WAIT WINDOW "Processando Atrasos (1)..." NOWAIT
                *-- Atrasos de SigMvCcr (com opera??es de t?tulo vinculadas)
                loc_lcQuery = "SELECT a.Grupos, a.Emps, a.DopCs, a.Opers, " + ;
                              "a.Moedas, a.Valors, a.ValPags, a.Nfs " + ;
                              "FROM SigMvCcr a, SigTempR b " + ;
                              "WHERE a.Vencs < " + loc_pDtI + ;
                              IIF(!EMPTY(loc_lcMoeLanc), " AND a.Moedas = '" + ALLTRIM(loc_lcMoeLanc) + "'", "") + ;
                              " AND a.TitCancs <> 1" + ;
                              IIF(loc_lnNrPrev = 1, " AND b.ValPres = 2", ;
                                  IIF(loc_lnNrPrev = 2, " AND b.ValPres <> 2", "")) + ;
                              " AND (a.Valors - a.ValPags) > 0" + ;
                              " AND a.DopCs = b.Dopes AND b.CIdQuerys = '" + ALLTRIM(loc_pKey) + "'" + ;
                              " ORDER BY a.Emps, a.Grupos, a.Contas, a.Moedas, a.cIdChaves, a.Vencs, a.Dopcs"
                loc_lnResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigMvCcr")
                IF loc_lnResult < 1
                    THIS.this_cMensagemErro = "Erro ao consultar atrasos de SigMvCcr"
                    loc_lSucesso = .F.
                ENDIF
                SELECT csRelatorio
                APPEND BLANK
                SELECT crSigMvCcr
                SCAN
                    IF (SEEK(Emps, "cEmp", "CEmps") AND cEmp.ImpEmps) AND ;
                       (DopCs = SPACE(20) OR (SEEK(DopCs, "crSigOpOpe", "Dopes") AND crSigOpOpe.SeleOp)) AND ;
                       ((loc_lnOpcao = 1 AND !EMPTY(crSigMvCcr.Nfs)) OR ;
                        (loc_lnOpcao = 2 AND EMPTY(crSigMvCcr.Nfs)) OR ;
                        (loc_lnOpcao = 3))
                        IF !EMPTY(crSigMvCcr.Grupos) AND ;
                           SEEK(crSigMvCcr.Grupos, "crSigCdPag", "Grupos") AND ;
                           (crSigMvCcr.Opers = "C")
                            REPLACE Pags WITH Pags + (crSigMvCcr.Valors - crSigMvCcr.ValPags), ;
                                    Fase WITH 2 IN csRelatorio
                            loc_lnTotAtrasos = loc_lnTotAtrasos - (crSigMvCcr.Valors - crSigMvCcr.ValPags)
                        ENDIF
                        IF !EMPTY(crSigMvCcr.Grupos) AND ;
                           SEEK(crSigMvCcr.Grupos, "crSigCdRec", "Grupos") AND ;
                           (crSigMvCcr.Opers = "D")
                            REPLACE Recs WITH Recs + (crSigMvCcr.Valors - crSigMvCcr.ValPags), ;
                                    Fase WITH 2 IN csRelatorio
                            loc_lnTotAtrasos = loc_lnTotAtrasos + (crSigMvCcr.Valors - crSigMvCcr.ValPags)
                        ENDIF
                    ENDIF
                ENDSCAN
                IF USED("crSigMvCcr")
                    USE IN crSigMvCcr
                ENDIF

                *-- Atrasos de SigMvCab (opera??es previstas vencidas)
                WAIT WINDOW "Processando Atrasos (2)..." NOWAIT
                loc_lcQuery = "SELECT b.cMoes, c.MoedaPs, b.Opers, b.DigItens, " + ;
                              "a.Emps, a.Dopes, a.Numes, a.Valos, d.Valos AS VlParc, " + ;
                              "d.vpags, a.TpFats, a.ChkPagos, a.ValInis, a.Vars, e.nFlxCaixa " + ;
                              "FROM SigMvCab a " + ;
                              "INNER JOIN SigCdOpe b ON b.Dopes = a.Dopes " + ;
                              "INNER JOIN SigCdPam c ON 1 = 1 " + ;
                              "INNER JOIN SigMvPar d ON d.EmpDopNums = a.EmpDopNums " + ;
                              "INNER JOIN SigCdTom e ON e.Codigos = b.TipoOps " + ;
                              "LEFT JOIN SigOpFpo o ON o.Dopes = d.Dopes AND o.fPags = d.fPags " + ;
                              "WHERE d.Vencs < " + loc_pDtI + ;
                              " AND (o.Contabs <> 1 OR o.Contabs IS NULL)" + ;
                              " AND (e.nFlxCaixa <> 3 AND e.nFlxCaixa <> 0) AND a.ChkSubN = 0 " + ;
                              "ORDER BY a.Emps"
                loc_lnResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigMvCab")
                IF loc_lnResult < 1
                    THIS.this_cMensagemErro = "Erro ao consultar SigMvCab (atrasos)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT crSigMvCab
                SCAN
                    IF (crSigMvCab.nFlxCaixa = 2) AND !crSigMvCab.ChkPagos
                        LOOP
                    ENDIF
                    LOCAL loc_sMoedas, loc_sOpers, loc_sValors, loc_sEmps
                    loc_sMoedas = IIF(!EMPTY(ALLTRIM(NVL(crSigMvCab.cMoes, ""))), ;
                        ALLTRIM(crSigMvCab.cMoes), ALLTRIM(crSigMvCab.MoedaPs))
                    IF !EMPTY(loc_lcMoeLanc) AND (loc_lcMoeLanc <> loc_sMoedas)
                        LOOP
                    ENDIF
                    loc_sOpers = IIF(crSigMvCab.Opers = 1, "C", "D")
                    IF crSigMvCab.DigItens <> 2
                        loc_sValors = ROUND((crSigMvCab.VlParc - crSigMvCab.VPags) * crSigMvCab.Vars, 2)
                    ELSE
                        loc_sValors = ROUND((crSigMvCab.VlParc - crSigMvCab.VPags), 2)
                    ENDIF
                    loc_sEmps = crSigMvCab.Emps
                    *-- Aplicar fator NF se necess?rio
                    loc_lnResult = SQLEXEC(gnConnHandle, ;
                        "SELECT TOP 1 pValors FROM SigCdTif WHERE Codigos = '" + ;
                        ALLTRIM(crSigMvCab.TpFats) + "'", "cursor_4c_Tif")
                    IF loc_lnResult > 0 AND !EOF("cursor_4c_Tif") AND (loc_lnOpcao <> 3)
                        IF loc_lnOpcao = 2
                            loc_sValors = ROUND(loc_sValors * (cursor_4c_Tif.pValors / 100), 2)
                        ELSE
                            loc_sValors = loc_sValors - ROUND(loc_sValors * (cursor_4c_Tif.pValors / 100), 2)
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_Tif")
                        USE IN cursor_4c_Tif
                    ENDIF
                    IF SEEK(loc_sEmps, "cEmp", "CEmps") AND cEmp.ImpEmps
                        REPLACE Pags WITH Pags + IIF(loc_sOpers = "C", loc_sValors, 0), ;
                                Recs WITH Recs + IIF(loc_sOpers = "D", loc_sValors, 0), ;
                                Fase WITH 2 IN csRelatorio
                        IF loc_sOpers = "C"
                            loc_lnTotAtrasos = loc_lnTotAtrasos - loc_sValors
                        ELSE
                            loc_lnTotAtrasos = loc_lnTotAtrasos + loc_sValors
                        ENDIF
                    ENDIF
                ENDSCAN
                IF USED("crSigMvCab")
                    USE IN crSigMvCab
                ENDIF
            ENDIF

            *-- Cursor para movimentos do per?odo
            CREATE CURSOR csTemporariox (Vencs d, Grupos c(10), Contas c(10), ;
                Opers c(1), Moedas c(3), Valors n(12,2), Tipo c(1))

            *-- Query 1: movimentos com opera??o de t?tulo vinculada
            WAIT WINDOW "Processando Hist" + CHR(243) + "rico - (Realizado)..." NOWAIT
            IF EMPTY(loc_ldDtInicial)
                loc_lcQuery = "SELECT a.Vencs, a.Emps, a.Dopcs, a.Grupos, a.Contas, " + ;
                              "a.Opers, a.Moedas, a.Valors, a.ValPags, a.Nfs, a.cIdChaves " + ;
                              "FROM SigMvCcr a, SigTempR b " + ;
                              "WHERE (a.Vencs <= " + loc_pDtF + " OR a.Vencs IS NULL)" + ;
                              IIF(!EMPTY(loc_lcMoeLanc), " AND a.Moedas = '" + ALLTRIM(loc_lcMoeLanc) + "'", "") + ;
                              " AND a.TitCancs <> 1" + ;
                              IIF(loc_lnNrPrev = 1, " AND b.ValPres = 2", ;
                                  IIF(loc_lnNrPrev = 2, " AND b.ValPres <> 2", "")) + ;
                              " AND a.DopCs = b.Dopes AND b.CIdQuerys = '" + ALLTRIM(loc_pKey) + "'" + ;
                              " ORDER BY a.Emps, a.Grupos, a.Contas, a.Moedas, a.cIdChaves, " + ;
                              "a.Vencs, a.Dopcs, a.Opers, a.Valors, a.ValPags, a.Nfs"
            ELSE
                loc_lcQuery = "SELECT a.Vencs, a.Emps, a.Dopcs, a.Grupos, a.Contas, " + ;
                              "a.Opers, a.Moedas, a.Valors, a.ValPags, a.Nfs, a.cIdChaves " + ;
                              "FROM SigMvCcr a, SigTempR b " + ;
                              "WHERE a.Vencs BETWEEN " + loc_pDtI + " AND " + loc_pDtF + ;
                              IIF(!EMPTY(loc_lcMoeLanc), " AND a.Moedas = '" + ALLTRIM(loc_lcMoeLanc) + "'", "") + ;
                              " AND a.TitCancs <> 1" + ;
                              IIF(loc_lnNrPrev = 1, " AND b.ValPres = 2", ;
                                  IIF(loc_lnNrPrev = 2, " AND b.ValPres <> 2", "")) + ;
                              " AND a.DopCs = b.Dopes AND b.CIdQuerys = '" + ALLTRIM(loc_pKey) + "'" + ;
                              " ORDER BY a.Emps, a.Grupos, a.Contas, a.Moedas, a.cIdChaves, " + ;
                              "a.Vencs, a.Dopcs, a.Opers, a.Valors, a.ValPags, a.Nfs"
            ENDIF
            loc_lnResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crDados1")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Erro ao consultar SigMvCcr (realizado - com ope)"
                loc_lSucesso = .F.
            ENDIF

            *-- Query 2: movimentos sem opera??o de t?tulo (DopCs = espacos)
            IF EMPTY(loc_ldDtInicial)
                loc_lcQuery = "SELECT a.Vencs, a.Emps, a.Dopcs, a.Grupos, a.Contas, " + ;
                              "a.Opers, a.Moedas, a.Valors, a.ValPags, a.Nfs, a.cIdChaves " + ;
                              "FROM SigMvCcr a " + ;
                              "WHERE (a.Vencs <= " + loc_pDtF + " OR a.Vencs IS NULL)" + ;
                              IIF(!EMPTY(loc_lcMoeLanc), " AND a.Moedas = '" + ALLTRIM(loc_lcMoeLanc) + "'", "") + ;
                              " AND a.TitCancs <> 1 AND a.DopCs = '" + SPACE(20) + "'" + ;
                              " ORDER BY a.Emps, a.Grupos, a.Contas, a.Moedas, a.cIdChaves, " + ;
                              "a.Vencs, a.Dopcs, a.Opers, a.Valors, a.ValPags, a.Nfs"
            ELSE
                loc_lcQuery = "SELECT a.Vencs, a.Emps, a.Dopcs, a.Grupos, a.Contas, " + ;
                              "a.Opers, a.Moedas, a.Valors, a.ValPags, a.Nfs, a.cIdChaves " + ;
                              "FROM SigMvCcr a " + ;
                              "WHERE a.Vencs BETWEEN " + loc_pDtI + " AND " + loc_pDtF + ;
                              IIF(!EMPTY(loc_lcMoeLanc), " AND a.Moedas = '" + ALLTRIM(loc_lcMoeLanc) + "'", "") + ;
                              " AND a.TitCancs <> 1 AND a.DopCs = '" + SPACE(20) + "'" + ;
                              " ORDER BY a.Emps, a.Grupos, a.Contas, a.Moedas, a.cIdChaves, " + ;
                              "a.Vencs, a.Dopcs, a.Opers, a.Valors, a.ValPags, a.Nfs"
            ENDIF
            loc_lnResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crDados2")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Erro ao consultar SigMvCcr (realizado - sem ope)"
                loc_lSucesso = .F.
            ENDIF

            SELECT * FROM crDados1 ;
            UNION ALL ;
            SELECT * FROM crDados2 ;
            INTO CURSOR crSigMvCcr
            IF USED("crDados1")
                USE IN crDados1
            ENDIF
            IF USED("crDados2")
                USE IN crDados2
            ENDIF

            *-- Processar hist?rico realizado
            SELECT crSigMvCcr
            SCAN
                IF (SEEK(Emps, "cEmp", "CEmps") AND cEmp.ImpEmps) AND ;
                   (DopCs = SPACE(20) OR (SEEK(DopCs, "crSigOpOpe", "Dopes") AND crSigOpOpe.SeleOp)) AND ;
                   ((loc_lnOpcao = 1 AND !EMPTY(crSigMvCcr.Nfs)) OR ;
                    (loc_lnOpcao = 2 AND EMPTY(crSigMvCcr.Nfs)) OR ;
                    (loc_lnOpcao = 3))
                    LOCAL loc_lnValorR, loc_lcTipoR
                    loc_lnValorR = crSigMvCcr.Valors
                    IF loc_lnNrSitua <> 3
                        loc_lnValorR = IIF(loc_lnNrSitua = 1, crSigMvCcr.ValPags, ;
                            (crSigMvCcr.Valors - crSigMvCcr.ValPags))
                    ENDIF
                    loc_lcTipoR = IIF(DopCs = SPACE(20) OR crSigOpOpe.RealPrevs <> 2, "", "T")
                    INSERT INTO csTemporariox (Vencs, Grupos, Contas, Opers, Moedas, Valors, Tipo) ;
                        VALUES (crSigMvCcr.Vencs, crSigMvCcr.Grupos, crSigMvCcr.Contas, ;
                                crSigMvCcr.Opers, crSigMvCcr.Moedas, loc_lnValorR, loc_lcTipoR)
                ENDIF
            ENDSCAN
            IF USED("crSigMvCcr")
                USE IN crSigMvCcr
            ENDIF

            *-- Processar previs?es de SigMvCab (opera??es previstas no per?odo)
            WAIT WINDOW "Processando Hist" + CHR(243) + "rico - (Previsto)..." NOWAIT
            IF EMPTY(loc_ldDtInicial)
                loc_lcQuery = "SELECT b.cMoes, c.MoedaPs, d.Vencs, b.Opers, b.DigItens, " + ;
                              "a.grupoos, a.contaos, a.grupods, a.contads, a.Dopes, " + ;
                              "a.Valos, d.Valos AS VlParc, d.vpags, a.Emps, " + ;
                              "a.TpFats, a.ChkPagos, a.ValInis, a.Vars, e.nFlxCaixa " + ;
                              "FROM SigMvCab a INNER JOIN SigCdOpe b ON b.Dopes = a.Dopes " + ;
                              "INNER JOIN SigCdPam c ON 1 = 1 " + ;
                              "INNER JOIN SigMvPar d ON d.EmpDopNums = a.EmpDopNums " + ;
                              "INNER JOIN SigCdTom e ON e.Codigos = b.TipoOps " + ;
                              "LEFT JOIN SigOpFpo o ON o.Dopes = d.Dopes AND o.fPags = d.fPags " + ;
                              "WHERE (d.Vencs <= " + loc_pDtF + " OR d.Vencs IS NULL)" + ;
                              " AND (o.Contabs <> 1 OR o.Contabs IS NULL)" + ;
                              " AND (e.nFlxCaixa <> 3 AND e.nFlxCaixa <> 0) AND a.ChkSubN = 0 " + ;
                              "ORDER BY a.Emps"
            ELSE
                loc_lcQuery = "SELECT b.cMoes, c.MoedaPs, d.Vencs, b.Opers, b.DigItens, " + ;
                              "a.grupoos, a.contaos, a.grupods, a.contads, a.Dopes, " + ;
                              "a.Valos, d.Valos AS VlParc, d.vpags, a.Emps, " + ;
                              "a.TpFats, a.ChkPagos, a.ValInis, a.Vars, e.nFlxCaixa " + ;
                              "FROM SigMvCab a INNER JOIN SigCdOpe b ON b.Dopes = a.Dopes " + ;
                              "INNER JOIN SigCdPam c ON 1 = 1 " + ;
                              "INNER JOIN SigMvPar d ON d.EmpDopNums = a.EmpDopNums " + ;
                              "INNER JOIN SigCdTom e ON e.Codigos = b.TipoOps " + ;
                              "LEFT JOIN SigOpFpo o ON o.Dopes = d.Dopes AND o.fPags = d.fPags " + ;
                              "WHERE d.Vencs BETWEEN " + loc_pDtI + " AND " + loc_pDtF + ;
                              " AND (o.Contabs <> 1 OR o.Contabs IS NULL)" + ;
                              " AND (e.nFlxCaixa <> 3 AND e.nFlxCaixa <> 0) AND a.ChkSubN = 0 " + ;
                              "ORDER BY a.Emps"
            ENDIF
            loc_lnResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigMvCab")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Erro ao consultar SigMvCab (previsto)"
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigMvCab
            SCAN
                IF (crSigMvCab.nFlxCaixa = 2) AND !crSigMvCab.ChkPagos
                    LOOP
                ENDIF
                LOCAL loc_pMoedas, loc_pVencs, loc_pOpers, loc_pGrupos, loc_pContas
                LOCAL loc_pValors, loc_pEmps
                loc_pMoedas = IIF(!EMPTY(ALLTRIM(NVL(crSigMvCab.cMoes, ""))), ;
                    ALLTRIM(crSigMvCab.cMoes), ALLTRIM(crSigMvCab.MoedaPs))
                IF !EMPTY(loc_lcMoeLanc) AND (loc_lcMoeLanc <> loc_pMoedas)
                    LOOP
                ENDIF
                loc_pVencs  = crSigMvCab.Vencs
                loc_pOpers  = IIF(crSigMvCab.Opers = 1, "C", "D")
                loc_pGrupos = IIF(crSigMvCab.Opers = 1, crSigMvCab.Grupoos, crSigMvCab.Grupods)
                loc_pContas = IIF(crSigMvCab.Opers = 1, crSigMvCab.Contaos, crSigMvCab.Contads)
                IF crSigMvCab.DigItens <> 2
                    loc_pValors = crSigMvCab.VlParc
                    IF loc_lnNrSitua <> 3
                        loc_pValors = IIF(loc_lnNrSitua = 1, ;
                            ROUND(crSigMvCab.VPags * crSigMvCab.Vars, 2), ;
                            ROUND((crSigMvCab.VlParc - crSigMvCab.VPags) * crSigMvCab.Vars, 2))
                    ENDIF
                ELSE
                    loc_pValors = crSigMvCab.VlParc
                    IF loc_lnNrSitua <> 3
                        loc_pValors = IIF(loc_lnNrSitua = 1, crSigMvCab.VPags, ;
                            ROUND((crSigMvCab.VlParc - crSigMvCab.VPags), 2))
                    ENDIF
                ENDIF
                loc_pEmps = crSigMvCab.Emps
                *-- Fator NF
                loc_lnResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 pValors FROM SigCdTif WHERE Codigos = '" + ;
                    ALLTRIM(crSigMvCab.TpFats) + "'", "cursor_4c_Tif2")
                IF loc_lnResult > 0 AND !EOF("cursor_4c_Tif2") AND (loc_lnOpcao <> 3)
                    IF loc_lnOpcao = 2
                        loc_pValors = ROUND(loc_pValors * (cursor_4c_Tif2.pValors / 100), 2)
                    ELSE
                        loc_pValors = loc_pValors - ROUND(loc_pValors * (cursor_4c_Tif2.pValors / 100), 2)
                    ENDIF
                ENDIF
                IF USED("cursor_4c_Tif2")
                    USE IN cursor_4c_Tif2
                ENDIF
                IF SEEK(loc_pEmps, "cEmp", "CEmps") AND cEmp.ImpEmps AND (loc_pValors > 0)
                    INSERT INTO csTemporariox (Vencs, Grupos, Contas, Opers, Moedas, Valors, Tipo) ;
                        VALUES (loc_pVencs, loc_pGrupos, loc_pContas, loc_pOpers, ;
                                loc_pMoedas, loc_pValors, "P")
                ENDIF
            ENDSCAN
            IF USED("crSigMvCab")
                USE IN crSigMvCab
            ENDIF

            *-- Processar previs?es de SigMvCpv (se houver opera??es com RealPrevs=2)
            IF loc_llPrevs
                WAIT WINDOW "Processando Hist" + CHR(243) + "rico - (Previsto CPV)..." NOWAIT
                IF EMPTY(loc_ldDtInicial)
                    loc_lcQuery = "SELECT a.Vencs, a.Emps, a.Dopcs, a.Grupos, a.Contas, " + ;
                                  "a.Opers, a.Moedas, a.Valors, a.ValPags, a.Nfs, a.cIdChaves " + ;
                                  "FROM SigMvCpv a, SigTempR b " + ;
                                  "WHERE (a.Vencs <= " + loc_pDtF + " OR a.Vencs IS NULL)" + ;
                                  IIF(!EMPTY(loc_lcMoeLanc), " AND a.Moedas = '" + ALLTRIM(loc_lcMoeLanc) + "'", "") + ;
                                  " AND a.DopCs = b.Dopes AND b.ValPres = 2" + ;
                                  " AND b.CIdQuerys = '" + ALLTRIM(loc_pKey) + "'" + ;
                                  " ORDER BY a.Emps, a.Grupos, a.Contas, a.Moedas, a.cIdChaves, " + ;
                                  "a.Dopcs, a.Opers, a.Valors, a.ValPags, a.Nfs"
                ELSE
                    loc_lcQuery = "SELECT a.Vencs, a.Emps, a.Dopcs, a.Grupos, a.Contas, " + ;
                                  "a.Opers, a.Moedas, a.Valors, a.ValPags, a.Nfs, a.cIdChaves " + ;
                                  "FROM SigMvCpv a, SigTempR b " + ;
                                  "WHERE a.Vencs BETWEEN " + loc_pDtI + " AND " + loc_pDtF + ;
                                  IIF(!EMPTY(loc_lcMoeLanc), " AND a.Moedas = '" + ALLTRIM(loc_lcMoeLanc) + "'", "") + ;
                                  " AND a.DopCs = b.Dopes AND b.ValPres = 2" + ;
                                  " AND b.CIdQuerys = '" + ALLTRIM(loc_pKey) + "'" + ;
                                  " ORDER BY a.Emps, a.Grupos, a.Contas, a.Moedas, a.cIdChaves, " + ;
                                  "a.Dopcs, a.Opers, a.Valors, a.ValPags, a.Nfs"
                ENDIF
                loc_lnResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crDados1")
                IF loc_lnResult < 1
                    THIS.this_cMensagemErro = "Erro ao consultar SigMvCpv (1)"
                    loc_lSucesso = .F.
                ENDIF
                IF EMPTY(loc_ldDtInicial)
                    loc_lcQuery = "SELECT a.Vencs, a.Emps, a.Dopcs, a.Grupos, a.Contas, " + ;
                                  "a.Opers, a.Moedas, a.Valors, a.ValPags, a.Nfs, a.cIdChaves " + ;
                                  "FROM SigMvCpv a " + ;
                                  "WHERE (a.Vencs <= " + loc_pDtF + " OR a.Vencs IS NULL)" + ;
                                  IIF(!EMPTY(loc_lcMoeLanc), " AND a.Moedas = '" + ALLTRIM(loc_lcMoeLanc) + "'", "") + ;
                                  " AND a.DopCs = '" + SPACE(20) + "'" + ;
                                  " ORDER BY a.Emps, a.Grupos, a.Contas, a.Moedas, a.cIdChaves, " + ;
                                  "a.Dopcs, a.Opers, a.Valors, a.ValPags, a.Nfs"
                ELSE
                    loc_lcQuery = "SELECT a.Vencs, a.Emps, a.Dopcs, a.Grupos, a.Contas, " + ;
                                  "a.Opers, a.Moedas, a.Valors, a.ValPags, a.Nfs, a.cIdChaves " + ;
                                  "FROM SigMvCpv a " + ;
                                  "WHERE a.Vencs BETWEEN " + loc_pDtI + " AND " + loc_pDtF + ;
                                  IIF(!EMPTY(loc_lcMoeLanc), " AND a.Moedas = '" + ALLTRIM(loc_lcMoeLanc) + "'", "") + ;
                                  " AND a.DopCs = '" + SPACE(20) + "'" + ;
                                  " ORDER BY a.Emps, a.Grupos, a.Contas, a.Moedas, a.cIdChaves, " + ;
                                  "a.Dopcs, a.Opers, a.Valors, a.ValPags, a.Nfs"
                ENDIF
                loc_lnResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crDados2")
                IF loc_lnResult < 1
                    THIS.this_cMensagemErro = "Erro ao consultar SigMvCpv (2)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT * FROM crDados1 ;
                UNION ALL ;
                SELECT * FROM crDados2 ;
                INTO CURSOR crSigMvCpv
                IF USED("crDados1")
                    USE IN crDados1
                ENDIF
                IF USED("crDados2")
                    USE IN crDados2
                ENDIF
                SELECT crSigMvCpv
                SCAN
                    IF (SEEK(Emps, "cEmp", "CEmps") AND cEmp.ImpEmps) AND ;
                       (DopCs = SPACE(20) OR (SEEK(DopCs, "crSigOpOpe", "Dopes") AND crSigOpOpe.SeleOp)) AND ;
                       ((loc_lnOpcao = 1 AND !EMPTY(crSigMvCpv.Nfs)) OR ;
                        (loc_lnOpcao = 2 AND EMPTY(crSigMvCpv.Nfs)) OR ;
                        (loc_lnOpcao = 3))
                        LOCAL loc_lnValorPV, loc_lcTipoPV
                        loc_lnValorPV = crSigMvCpv.Valors
                        IF loc_lnNrSitua <> 3
                            loc_lnValorPV = IIF(loc_lnNrSitua = 1, crSigMvCpv.ValPags, ;
                                (crSigMvCpv.Valors - crSigMvCpv.ValPags))
                        ENDIF
                        loc_lcTipoPV = IIF(DopCs = SPACE(20) OR crSigOpOpe.RealPrevs <> 2, "", "T")
                        INSERT INTO csTemporariox (Vencs, Grupos, Contas, Opers, Moedas, Valors, Tipo) ;
                            VALUES (crSigMvCpv.Vencs, crSigMvCpv.Grupos, crSigMvCpv.Contas, ;
                                    crSigMvCpv.Opers, crSigMvCpv.Moedas, ;
                                    crSigMvCpv.Valors - crSigMvCpv.ValPags, loc_lcTipoPV)
                    ENDIF
                ENDSCAN
                IF USED("crSigMvCpv")
                    USE IN crSigMvCpv
                ENDIF
            ENDIF

            *-- Acumular hist?rico por per?odo
            WAIT WINDOW "Acumulando Hist" + CHR(243) + "rico..." NOWAIT

            IF !loc_llImprime
                *-- Modo: Di?rio / Semanal / Quinzenal / Mensal
                SELECT Vencs, Grupos, Opers, Moedas, Tipo, SUM(Valors) AS Valors ;
                  FROM csTemporariox ;
                 GROUP BY Vencs, Grupos, Opers, Moedas, Tipo ;
                  INTO CURSOR csTemporario
                SELECT csTemporario
                GO TOP
                GO TOP IN crPeriodos
                loc_ldVencimento   = IIF(loc_lnTipoImp = 1, DTOC(csTemporario.Vencs), ;
                                         SUBSTR(DTOC(csTemporario.Vencs), 4, 7))
                IF loc_lnTipoImp = 2 OR loc_lnTipoImp = 3
                    loc_ldVencimento = DTOC(crPeriodos.dFinal)
                ENDIF
                loc_lnPagamentos   = 0
                loc_lnRecebimentos = 0
                loc_lnDoDia        = 0
                loc_lnAcumulado    = IIF(loc_lnConsAtra = 1, loc_lnTotAtrasos, 0)
                loc_lnSaldo        = loc_lnVlSaldoTotal + IIF(loc_lnConsAtra = 1, loc_lnTotAtrasos, 0)
                loc_lnPrevPag      = 0
                loc_lnPrevRec      = 0
                SCAN
                    IF IIF(loc_lnTipoImp <> 2 AND loc_lnTipoImp <> 3, ;
                        (loc_ldVencimento <> IIF(loc_lnTipoImp = 1, DTOC(csTemporario.Vencs), ;
                            SUBSTR(DTOC(csTemporario.Vencs), 4, 7))), ;
                        csTemporario.Vencs > crPeriodos.dFinal)
                        loc_lnDoDia     = (loc_lnRecebimentos - loc_lnPagamentos) + (loc_lnPrevRec - loc_lnPrevPag)
                        loc_lnAcumulado = loc_lnAcumulado + loc_lnDoDia
                        loc_lnSaldo     = loc_lnSaldo + loc_lnDoDia
                        INSERT INTO csRelatorio (Vencs, Pags, Recs, do_Dia, Acumulado, Saldo, Fase, PrevPags, PrevRecs) ;
                            VALUES (loc_ldVencimento, loc_lnPagamentos, loc_lnRecebimentos, ;
                                    loc_lnDoDia, loc_lnAcumulado, loc_lnSaldo, 2, loc_lnPrevPag, loc_lnPrevRec)
                        loc_ldVencimento = IIF(loc_lnTipoImp = 1, DTOC(csTemporario.Vencs), ;
                            SUBSTR(DTOC(csTemporario.Vencs), 4, 7))
                        IF !EOF("crPeriodos")
                            SKIP +1 IN crPeriodos
                        ENDIF
                        IF loc_lnTipoImp = 2 OR loc_lnTipoImp = 3
                            loc_ldVencimento = DTOC(crPeriodos.dFinal)
                        ENDIF
                        loc_lnPagamentos   = 0
                        loc_lnRecebimentos = 0
                        loc_lnPrevPag      = 0
                        loc_lnPrevRec      = 0
                    ENDIF
                    loc_lnCtReferencia = THIS.BuscarCambio(csTemporario.Moedas)
                    loc_lnCtReferencia = IIF(loc_lnCtReferencia = 0, 1, loc_lnCtReferencia)
                    loc_lnVlConvertido = (csTemporario.Valors * loc_lnCtReferencia / loc_lnVlCotacao)
                    IF !INLIST(csTemporario.Tipo, "P", "T")
                        IF !EMPTY(csTemporario.Grupos) AND ;
                           SEEK(csTemporario.Grupos, "crSigCdPag", "Grupos") AND ;
                           (csTemporario.Opers = "C") AND (crSigCdPag.RelPrevs <> 2)
                            loc_lnPagamentos = loc_lnPagamentos + loc_lnVlConvertido
                        ENDIF
                        IF !EMPTY(csTemporario.Grupos) AND ;
                           SEEK(csTemporario.Grupos, "crSigCdRec", "Grupos") AND ;
                           (csTemporario.Opers = "D")
                            loc_lnRecebimentos = loc_lnRecebimentos + loc_lnVlConvertido
                        ENDIF
                    ELSE
                        IF (csTemporario.Opers = "C") AND ;
                           !EMPTY(csTemporario.Grupos) AND ;
                           SEEK(csTemporario.Grupos, "crSigCdPag", "Grupos")
                            loc_lnPrevPag = loc_lnPrevPag + loc_lnVlConvertido
                        ELSE
                            IF !EMPTY(csTemporario.Grupos) AND ;
                               SEEK(csTemporario.Grupos, "crSigCdRec", "Grupos") AND ;
                               (csTemporario.Opers = "D")
                                loc_lnPrevRec = loc_lnPrevRec + loc_lnVlConvertido
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN
                *-- ?ltimo per?odo
                loc_lnDoDia     = (loc_lnRecebimentos - loc_lnPagamentos) + (loc_lnPrevRec - loc_lnPrevPag)
                loc_lnAcumulado = loc_lnAcumulado + loc_lnDoDia
                loc_lnSaldo     = loc_lnSaldo + loc_lnDoDia
                IF (!EMPTY(loc_lnAcumulado) OR !EMPTY(loc_lnSaldo))
                    INSERT INTO csRelatorio (Vencs, Pags, Recs, do_Dia, Acumulado, Saldo, Fase, PrevPags, PrevRecs) ;
                        VALUES (loc_ldVencimento, loc_lnPagamentos, loc_lnRecebimentos, ;
                                loc_lnDoDia, loc_lnAcumulado, loc_lnSaldo, 2, loc_lnPrevPag, loc_lnPrevRec)
                ENDIF
                IF USED("csTemporario")
                    USE IN csTemporario
                ENDIF

                *-- Construir tabela pivot semanal/quinzenal (crRel)
                IF loc_lnTipoImp = 2 OR loc_lnTipoImp = 3
                    loc_lcCursor = [CREATE CURSOR crRel( Tipo c(10), ]
                    FOR loc_i = 1 TO 8
                        loc_lcCursor = loc_lcCursor + ;
                            [dData] + ALLTRIM(STR(loc_i)) + [ c(10),] + ;
                            [nSaldoIni] + ALLTRIM(STR(loc_i)) + [ n(12,2),] + ;
                            [nRecEst] + ALLTRIM(STR(loc_i)) + [ n(12,2),] + ;
                            [nRecConf] + ALLTRIM(STR(loc_i)) + [ n(12,2),] + ;
                            [nPagEst] + ALLTRIM(STR(loc_i)) + [ n(12,2),] + ;
                            [nPagConf] + ALLTRIM(STR(loc_i)) + [ n(12,2),] + ;
                            [nSaldoFin] + ALLTRIM(STR(loc_i)) + [ n(12,2)] + ;
                            IIF(loc_i <> 8, [,], [)])
                    NEXT loc_i
                    &loc_lcCursor
                    loc_lnIdx = 1
                    SELECT * FROM csRelatorio WHERE Fase = 2 AND !EMPTY(Vencs) INTO CURSOR crAux
                    SELECT crAux
                    APPEND BLANK IN crRel
                    REPLACE Tipo WITH IIF(loc_lnTipoImp = 2, "Semana", "Quinzena") IN crRel
                    GO TOP IN crAux
                    SCAN
                        LOCAL loc_lcFld
                        loc_lcFld = ALLTRIM(STR(loc_lnIdx))
                        REPLACE ("dData"     + loc_lcFld) WITH crAux.Vencs, ;
                                ("nSaldoIni" + loc_lcFld) WITH (crAux.Saldo - crAux.do_Dia), ;
                                ("nRecEst"   + loc_lcFld) WITH crAux.PrevRecs, ;
                                ("nRecConf"  + loc_lcFld) WITH crAux.Recs, ;
                                ("nPagEst"   + loc_lcFld) WITH crAux.PrevPags, ;
                                ("nPagConf"  + loc_lcFld) WITH crAux.Pags, ;
                                ("nSaldoFin" + loc_lcFld) WITH crAux.Saldo IN crRel
                        loc_lnIdx = loc_lnIdx + 1
                    ENDSCAN
                    IF USED("crAux")
                        USE IN crAux
                    ENDIF
                ENDIF
            ELSE
                *-- Modo: Totaliza Contas (llImprime = .T.)
                SELECT Vencs, MAX(Grupos) AS Grupos, Contas, Opers, Moedas, SUM(Valors) AS Valors ;
                  FROM csTemporariox ;
                 GROUP BY 1, 3, 4, 5 ;
                  INTO CURSOR csTemporario
                SELECT MAX(Vencs) AS Vencs, Grupos, Contas, Opers, MAX(Moedas) AS Moedas, SUM(Valors) AS Valors ;
                  FROM csTemporario ;
                 GROUP BY 2, 3, 4 ;
                 ORDER BY 3 ;
                  INTO CURSOR csTemporarioAcc
                IF USED("csTemporario")
                    USE IN csTemporario
                ENDIF
                loc_lnSaldo = loc_lnVlSaldoTotal
                SELECT csTemporarioAcc
                SCAN
                    loc_lnPagamentos   = 0
                    loc_lnRecebimentos = 0
                    loc_lnCtReferencia = THIS.BuscarCambio(csTemporarioAcc.Moedas)
                    loc_lnCtReferencia = IIF(loc_lnCtReferencia = 0, 1, loc_lnCtReferencia)
                    loc_lnVlConvertido = (csTemporarioAcc.Valors * loc_lnCtReferencia / loc_lnVlCotacao)
                    *-- Buscar descri??o do cliente
                    LOCAL loc_lcRClis
                    loc_lcRClis = ""
                    loc_lnResult = SQLEXEC(gnConnHandle, ;
                        "SELECT TOP 1 RClis FROM SigCdCli WHERE iClis = " + ;
                        TRANSFORM(csTemporarioAcc.Contas), "cursor_4c_CliQ")
                    IF loc_lnResult > 0 AND !EOF("cursor_4c_CliQ")
                        loc_lcRClis = ALLTRIM(cursor_4c_CliQ.RClis)
                    ENDIF
                    IF USED("cursor_4c_CliQ")
                        USE IN cursor_4c_CliQ
                    ENDIF
                    IF !EMPTY(csTemporarioAcc.Grupos) AND ;
                       SEEK(csTemporarioAcc.Grupos, "crSigCdPag", "Grupos") AND ;
                       (csTemporarioAcc.Opers = "C") AND (crSigCdPag.RelPrevs <> 2)
                        loc_lnPagamentos = loc_lnVlConvertido
                    ENDIF
                    IF !EMPTY(csTemporarioAcc.Grupos) AND ;
                       SEEK(csTemporarioAcc.Grupos, "crSigCdRec", "Grupos") AND ;
                       (csTemporarioAcc.Opers = "D")
                        loc_lnRecebimentos = loc_lnVlConvertido
                    ENDIF
                    loc_lnSaldo = loc_lnSaldo + (loc_lnRecebimentos - loc_lnPagamentos)
                    INSERT INTO csRelatorio (Contas, Pags, Recs, Saldo, Fase, DsContas) ;
                        VALUES (csTemporarioAcc.Contas, loc_lnPagamentos, loc_lnRecebimentos, ;
                                loc_lnSaldo, 2, loc_lcRClis)
                ENDSCAN
                IF USED("csTemporarioAcc")
                    USE IN csTemporarioAcc
                ENDIF
            ENDIF

            IF USED("csTemporariox")
                USE IN csTemporariox
            ENDIF

            *-- Posicionar cursor de resultado para o relat?rio
            IF loc_lnTipoImp = 2 OR loc_lnTipoImp = 3
                SELECT crRel
            ELSE
                SELECT csRelatorio
                SET ORDER TO Fase
            ENDIF
            GO TOP

            *-- Limpeza em SigTempR
            THIS.LimparSigTempR(loc_pKey)
            WAIT CLEAR

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em PrepararDados")
            *-- Tentar limpar SigTempR mesmo com erro
            IF !EMPTY(THIS.this_cChaveQuery)
                THIS.LimparSigTempR(THIS.this_cChaveQuery)
            ENDIF
            WAIT CLEAR
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCambio - Retorna taxa de cambio de uma moeda na data atual
    * Substitui fBuscarCambio() do legado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION BuscarCambio(par_cMoeda)
        LOCAL loc_nCotacao, loc_lnResult
        loc_nCotacao = 1
        IF EMPTY(ALLTRIM(par_cMoeda))
            RETURN loc_nCotacao
        ENDIF
        TRY
            *-- Tenta buscar no cursor crSigCdCot (carregado pelo InicializarCursoresAuxiliares)
            IF USED("crSigCdCot") AND ;
               SEEK(ALLTRIM(par_cMoeda) + DTOS(DATE()), "crSigCdCot", "CMoeData")
                IF crSigCdCot.Valos > 0
                    loc_nCotacao = crSigCdCot.Valos
                    loc_lSucesso = loc_nCotacao
                ENDIF
            ENDIF
            *-- Fallback: busca mais recente no SQL Server
            loc_lnResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Valos FROM SigCdCot WHERE CMoes = '" + ;
                ALLTRIM(par_cMoeda) + "' ORDER BY Datas DESC", "cursor_4c_BusCam")
            IF loc_lnResult > 0 AND !EOF("cursor_4c_BusCam") AND cursor_4c_BusCam.Valos > 0
                loc_nCotacao = cursor_4c_BusCam.Valos
            ELSE
                *-- Fallback2: cota??o padr?o em SigCdMoe
                IF USED("crSigCdMoe") AND SEEK(ALLTRIM(par_cMoeda), "crSigCdMoe", "CMoes")
                    IF crSigCdMoe.Cotas > 0
                        loc_nCotacao = crSigCdMoe.Cotas
                    ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BusCam")
                USE IN cursor_4c_BusCam
            ENDIF
        CATCH TO loc_oErro
            *-- Ignorar: retorna 1 (neutro)
        ENDTRY
        RETURN loc_nCotacao
    ENDFUNCTION

    *--------------------------------------------------------------------------
    * BuscarCotacaoAtual - Retorna cota??o atual de uma moeda (para inicializa??o do form)
    * Substitui fBuscarCotacao() do legado
    *--------------------------------------------------------------------------
    FUNCTION BuscarCotacaoAtual(par_cMoeda)
        LOCAL loc_nCotacao, loc_lnResult
        loc_nCotacao = 1
        IF EMPTY(ALLTRIM(par_cMoeda))
            RETURN loc_nCotacao
        ENDIF
        TRY
            loc_lnResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Valos FROM SigCdCot " + ;
                "WHERE CMoes = '" + ALLTRIM(par_cMoeda) + "' " + ;
                "ORDER BY Datas DESC", "cursor_4c_CotAtual")
            IF loc_lnResult > 0 AND !EOF("cursor_4c_CotAtual") AND cursor_4c_CotAtual.Valos > 0
                loc_nCotacao = cursor_4c_CotAtual.Valos
            ENDIF
            IF USED("cursor_4c_CotAtual")
                USE IN cursor_4c_CotAtual
            ENDIF
        CATCH TO loc_oErro
            *-- Ignorar: retorna 1
        ENDTRY
        RETURN loc_nCotacao
    ENDFUNCTION

    *--------------------------------------------------------------------------
    * GoDayOfWeek - Retorna data ajustada para o dia-da-semana especificado
    * Equivalente a GoDayOfWeek() do legado (metodo do form original)
    * par_nDia: 1=Dom 2=Seg 3=Ter 4=Qua 5=Qui 6=Sex 7=Sab
    *--------------------------------------------------------------------------
    FUNCTION GoDayOfWeek(par_dData, par_nDia)
        LOCAL loc_dRet
        loc_dRet = par_dData
        IF DOW(loc_dRet) <> par_nDia
            IF DOW(par_dData) < par_nDia
                DO WHILE DOW(loc_dRet) < par_nDia
                    loc_dRet = loc_dRet + 1
                ENDDO
            ELSE
                DO WHILE DOW(loc_dRet) > par_nDia
                    loc_dRet = loc_dRet - 1
                ENDDO
            ENDIF
        ENDIF
        RETURN loc_dRet
    ENDFUNCTION

    *--------------------------------------------------------------------------
    * LimparSigTempR - Remove registros de query da tabela SigTempR
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparSigTempR(par_cChave)
        LOCAL loc_lnResult
        TRY
            IF !EMPTY(ALLTRIM(par_cChave))
                loc_lnResult = SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigTempR WHERE cIdQuerys = '" + ALLTRIM(par_cChave) + "'")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao limpar SigTempR")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterCaminhoFRX - Retorna caminho do FRX conforme op??es do relat?rio
    *--------------------------------------------------------------------------
    PROCEDURE ObterCaminhoFRX()
        LOCAL loc_cPath
        IF THIS.this_nTotalizaContas = 1
            loc_cPath = gc_4c_CaminhoReports + "SigReFf3.frx"
        ELSE
            IF THIS.this_nTipoImp = 2 OR THIS.this_nTipoImp = 3
                loc_cPath = gc_4c_CaminhoReports + "SigReFf1.frx"
            ELSE
                loc_cPath = gc_4c_CaminhoReports + "SigReFf2.frx"
            ENDIF
        ENDIF
        RETURN loc_cPath
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nTotalizaContas = 1
                    IF USED("csRelatorio")
                        SELECT csRelatorio
                        GO TOP
                    ENDIF
                ELSE
                    IF (THIS.this_nTipoImp = 2 OR THIS.this_nTipoImp = 3) AND USED("crRel")
                        SELECT crRel
                        GO TOP
                    ELSE
                        IF USED("csRelatorio")
                        SELECT csRelatorio
                        GO TOP
                        ENDIF
                    ENDIF
                ENDIF
                REPORT FORM (THIS.ObterCaminhoFRX()) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffnBO.Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia para impressora com dialogo
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nTotalizaContas = 1
                    IF USED("csRelatorio")
                        SELECT csRelatorio
                        GO TOP
                    ENDIF
                ELSE
                    IF (THIS.this_nTipoImp = 2 OR THIS.this_nTipoImp = 3) AND USED("crRel")
                        SELECT crRel
                        GO TOP
                    ELSE
                        IF USED("csRelatorio")
                        SELECT csRelatorio
                        GO TOP
                        ENDIF
                    ENDIF
                ENDIF
                REPORT FORM (THIS.ObterCaminhoFRX()) TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffnBO.Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarDocumentoExcel - Exporta dados para XLS
    * Semanal/Quinzenal: usa pivot crRel; demais: exporta csRelatorio
    *--------------------------------------------------------------------------
    PROCEDURE GerarDocumentoExcel()
        LOCAL loc_lSucesso, loc_cArquivo
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cArquivo = gc_4c_CaminhoBase + "FluxoFinanceiroSintetico.xls"
                IF (THIS.this_nTipoImp = 2 OR THIS.this_nTipoImp = 3) AND USED("crRel")
                    SELECT ' ' AS Titulo, dData1 AS Coluna1, dData2 AS Coluna2, ;
                           dData3 AS Coluna3, dData4 AS Coluna4, dData5 AS Coluna5, ;
                           dData6 AS Coluna6, dData7 AS Coluna7, dData8 AS Coluna8 ;
                      FROM crRel ;
                    UNION ALL ;
                    SELECT 'Saldo no in' + CHR(237) + 'cio da ' + Tipo AS Titulo, ;
                           STR(nSaldoIni1,12,2), STR(nSaldoIni2,12,2), STR(nSaldoIni3,12,2), ;
                           STR(nSaldoIni4,12,2), STR(nSaldoIni5,12,2), STR(nSaldoIni6,12,2), ;
                           STR(nSaldoIni7,12,2), STR(nSaldoIni8,12,2) FROM crRel ;
                    UNION ALL ;
                    SELECT 'Recebimentos estimados' AS Titulo, ;
                           STR(nRecEst1,12,2), STR(nRecEst2,12,2), STR(nRecEst3,12,2), ;
                           STR(nRecEst4,12,2), STR(nRecEst5,12,2), STR(nRecEst6,12,2), ;
                           STR(nRecEst7,12,2), STR(nRecEst8,12,2) FROM crRel ;
                    UNION ALL ;
                    SELECT 'Recebimentos confirmados' AS Titulo, ;
                           STR(nRecConf1,12,2), STR(nRecConf2,12,2), STR(nRecConf3,12,2), ;
                           STR(nRecConf4,12,2), STR(nRecConf5,12,2), STR(nRecConf6,12,2), ;
                           STR(nRecConf7,12,2), STR(nRecConf8,12,2) FROM crRel ;
                    UNION ALL ;
                    SELECT 'Pagamentos estimados' AS Titulo, ;
                           STR(nPagEst1,12,2), STR(nPagEst2,12,2), STR(nPagEst3,12,2), ;
                           STR(nPagEst4,12,2), STR(nPagEst5,12,2), STR(nPagEst6,12,2), ;
                           STR(nPagEst7,12,2), STR(nPagEst8,12,2) FROM crRel ;
                    UNION ALL ;
                    SELECT 'Pagamentos confirmados' AS Titulo, ;
                           STR(nPagConf1,12,2), STR(nPagConf2,12,2), STR(nPagConf3,12,2), ;
                           STR(nPagConf4,12,2), STR(nPagConf5,12,2), STR(nPagConf6,12,2), ;
                           STR(nPagConf7,12,2), STR(nPagConf8,12,2) FROM crRel ;
                    UNION ALL ;
                    SELECT 'Saldo no final da ' + Tipo AS Titulo, ;
                           STR(nSaldoFin1,12,2), STR(nSaldoFin2,12,2), STR(nSaldoFin3,12,2), ;
                           STR(nSaldoFin4,12,2), STR(nSaldoFin5,12,2), STR(nSaldoFin6,12,2), ;
                           STR(nSaldoFin7,12,2), STR(nSaldoFin8,12,2) FROM crRel ;
                      INTO CURSOR cursor_4c_ExcelExp
                    SELECT cursor_4c_ExcelExp
                    COPY TO (loc_cArquivo) TYPE XLS
                    IF USED("cursor_4c_ExcelExp")
                        USE IN cursor_4c_ExcelExp
                    ENDIF
                ELSE
                    IF USED("csRelatorio")
                        SELECT csRelatorio
                        COPY TO (loc_cArquivo) TYPE XLS
                    ENDIF
                ENDIF
                MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + loc_cArquivo, "Excel")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffnBO.GerarDocumentoExcel")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarEmpresas - Marca todas as empresas para impressao
    *--------------------------------------------------------------------------
    PROCEDURE MarcarEmpresas()
        LOCAL loc_oErro
        TRY
            IF USED("cEmp")
                SELECT cEmp
                SCAN
                    REPLACE ImpEmps WITH .T.
                ENDSCAN
                GO TOP IN cEmp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffnBO.MarcarEmpresas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarEmpresas - Desmarca todas as empresas
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarEmpresas()
        LOCAL loc_oErro
        TRY
            IF USED("cEmp")
                SELECT cEmp
                SCAN
                    REPLACE ImpEmps WITH .F.
                ENDSCAN
                GO TOP IN cEmp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffnBO.DesmarcarEmpresas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarDisponibilidades - Marca todas as disponibilidades para impressao
    *--------------------------------------------------------------------------
    PROCEDURE MarcarDisponibilidades()
        LOCAL loc_oErro
        TRY
            IF USED("cDisp")
                SELECT cDisp
                SCAN
                    REPLACE ImpDisps WITH .T.
                ENDSCAN
                GO TOP IN cDisp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffnBO.MarcarDisponibilidades")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarDisponibilidades - Desmarca todas as disponibilidades
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarDisponibilidades()
        LOCAL loc_oErro
        TRY
            IF USED("cDisp")
                SELECT cDisp
                SCAN
                    REPLACE ImpDisps WITH .F.
                ENDSCAN
                GO TOP IN cDisp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffnBO.DesmarcarDisponibilidades")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarOperacoes - Marca todas as operacoes de titulos para impressao
    *--------------------------------------------------------------------------
    PROCEDURE MarcarOperacoes()
        LOCAL loc_oErro
        TRY
            IF USED("crSigOpOpe")
                SELECT crSigOpOpe
                SCAN
                    REPLACE SeleOp WITH .T.
                ENDSCAN
                GO TOP IN crSigOpOpe
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffnBO.MarcarOperacoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarOperacoes - Desmarca todas as operacoes de titulos
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarOperacoes()
        LOCAL loc_oErro
        TRY
            IF USED("crSigOpOpe")
                SELECT crSigOpOpe
                SCAN
                    REPLACE SeleOp WITH .F.
                ENDSCAN
                GO TOP IN crSigOpOpe
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreffnBO.DesmarcarOperacoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        *-- Limpeza dos cursores carregados pelo InicializarCursoresAuxiliares
        IF USED("crSigOpOpe")
            USE IN crSigOpOpe
        ENDIF
        IF USED("cEmp")
            USE IN cEmp
        ENDIF
        IF USED("cDisp")
            USE IN cDisp
        ENDIF
        IF USED("crSigCdPag")
            USE IN crSigCdPag
        ENDIF
        IF USED("crSigCdRec")
            USE IN crSigCdRec
        ENDIF
        IF USED("crSigCdMoe")
            USE IN crSigCdMoe
        ENDIF
        IF USED("crSigCdCot")
            USE IN crSigCdCot
        ENDIF
        *-- Limpeza em SigTempR se ainda tiver chave pendente
        IF !EMPTY(THIS.this_cChaveQuery)
            THIS.LimparSigTempR(THIS.this_cChaveQuery)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

