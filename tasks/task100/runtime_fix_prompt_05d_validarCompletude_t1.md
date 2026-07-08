# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[Formsigrefec.prg] Procedure vazia (sem codigo): AjustarBotoesPorModo

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrefec.prg):
*==============================================================================
* FORMSIGREFEC.PRG
* Relat" + CHR(243) + "rio Fechamento de Caixa
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREFEC.SCX (frmrelatorio)
*
* Filtros: Empresa, Per" + CHR(237) + "odo, Usu" + CHR(225) + "rio, Forma de Pagto,
*          Op" + CHR(231) + CHR(245) + "es de impress" + CHR(227) + "o, Vendedor
* Bot" + CHR(245) + "es: Visualizar / Imprimir / Excel / Encerrar
*==============================================================================

DEFINE CLASS Formsigrefec AS FormBase

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

    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delegado ao FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria componentes estruturais do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.Caption = "Fechamento de Caixa"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.this_oRelatorio = CREATEOBJECT("sigrefecBO")
                IF VARTYPE(THIS.this_oRelatorio) != "O"
                    MsgErro("Erro ao criar sigrefecBO" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarCamposFiltro()
                THIS.ConfigurarEventos()
                THIS.LimparCampos()
                THIS.AlternarPagina(1)

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.Visible  = .T.
                loc_lSucesso  = .T.
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
    * ConfigurarCabecalho - Container escuro com t" + CHR(237) + "tulo do relat" + CHR(243) + "rio
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
                .Caption   = "Fechamento de Caixa"
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
                .Caption   = "Fechamento de Caixa"
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
    * ConfigurarBotoes - CommandGroup com 4 bot" + CHR(245) + "es: Visualizar/Imprimir/Excel/Encerrar
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
    * ConfigurarPageFrame - 1 p" + CHR(225) + "gina de filtros (layout flat de relat" + CHR(243) + "rio)
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
    * ConfigurarPaginaLista - Configura a p" + CHR(225) + "gina de filtros (Page1) do relat" + CHR(243) + "rio
    * Em forms REPORT, "Lista" = p" + CHR(225) + "gina " + CHR(250) + "nica de filtros/par" + CHR(226) + "metros
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Caption   = "Filtros"
        loc_oPagina.FontName  = "Tahoma"
        loc_oPagina.FontSize  = 8
        loc_oPagina.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPagina.BackColor = RGB(255, 255, 255)
        loc_oPagina.ForeColor = RGB(90, 90, 90)
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Ativa a p" + CHR(225) + "gina solicitada do PageFrame de filtros
    * par_nPagina: 1 = " + CHR(250) + "nica p" + CHR(225) + "gina de filtros (form REPORT n" + CHR(227) + "o tem outras)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPag
        loc_nPag = 1

        IF VARTYPE(par_nPagina) = "N" AND ;
           par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            loc_nPag = par_nPagina
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = loc_nPag
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO e delega ao FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Em forms REPORT a "Pagina de Dados" equivale a
    * pagina unica de filtros/parametros. Delega para ConfigurarCamposFiltro.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarCamposFiltro()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposFiltro - Adiciona todos os controles de filtro na Page1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposFiltro()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        * --- Empresa ---
        loc_oPg1.AddObject("lbl_4c_Lbl_empresa", "Label")
        WITH loc_oPg1.lbl_4c_Lbl_empresa
            .Top       = 23
            .Left      = 200
            .Width     = 52
            .Height    = 18
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_Emps", "TextBox")
        WITH loc_oPg1.txt_4c_Emps
            .Top         = 20
            .Left        = 254
            .Width       = 31
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ToolTipText = "C" + CHR(243) + "digo da Empresa (F4=Buscar)"
            .Visible     = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_DEmps", "TextBox")
        WITH loc_oPg1.txt_4c_DEmps
            .Top       = 20
            .Left      = 288
            .Width     = 289
            .Height    = 23
            .Value     = ""
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
            .Visible   = .T.
        ENDWITH

        * --- Periodo ---
        loc_oPg1.AddObject("lbl_4c_Lbl_periodo", "Label")
        WITH loc_oPg1.lbl_4c_Lbl_periodo
            .Top       = 48
            .Left      = 205
            .Width     = 52
            .Height    = 18
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_DtIni", "TextBox")
        WITH loc_oPg1.txt_4c_DtIni
            .Top         = 45
            .Left        = 254
            .Width       = 82
            .Height      = 23
            .Value       = {}
            .Format      = "@D"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ToolTipText = "Data Inicial do Per" + CHR(237) + "odo"
            .Visible     = .T.
        ENDWITH

        loc_oPg1.AddObject("lbl_4c_Lbl_periodo_a", "Label")
        WITH loc_oPg1.lbl_4c_Lbl_periodo_a
            .Top       = 48
            .Left      = 340
            .Width     = 10
            .Height    = 18
            .Caption   = "a"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_DtFim", "TextBox")
        WITH loc_oPg1.txt_4c_DtFim
            .Top         = 45
            .Left        = 352
            .Width       = 82
            .Height      = 23
            .Value       = {}
            .Format      = "@D"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ToolTipText = "Data Final do Per" + CHR(237) + "odo"
            .Visible     = .T.
        ENDWITH

        * --- Usuario ---
        loc_oPg1.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPg1.lbl_4c_Label9
            .Top       = 73
            .Left      = 205
            .Width     = 52
            .Height    = 18
            .Caption   = "Usu" + CHR(225) + "rio :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_Usuars", "TextBox")
        WITH loc_oPg1.txt_4c_Usuars
            .Top         = 70
            .Left        = 254
            .Width       = 82
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ToolTipText = "Usu" + CHR(225) + "rio (F4=Buscar)"
            .Visible     = .T.
        ENDWITH

        * --- Condicao de Pagamento ---
        loc_oPg1.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg1.lbl_4c_Label2
            .Top       = 98
            .Left      = 180
            .Width     = 75
            .Height    = 18
            .Caption   = "Cond. Pagto.:"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_FPags", "TextBox")
        WITH loc_oPg1.txt_4c_FPags
            .Top         = 95
            .Left        = 254
            .Width       = 94
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ToolTipText = "Forma de Pagamento (F4=Buscar)"
            .Visible     = .T.
        ENDWITH

        * --- Tipos de Impressao ---
        loc_oPg1.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg1.lbl_4c_Label1
            .Top       = 129
            .Left      = 176
            .Width     = 130
            .Height    = 18
            .Caption   = "Tipos de Impress" + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        * --- Linha separadora ---
        loc_oPg1.AddObject("lin_4c_Line1", "Line")
        WITH loc_oPg1.lin_4c_Line1
            .Top     = 144
            .Left    = 176
            .Width   = 435
            .Height  = 1
            .Visible = .T.
        ENDWITH

        * --- CheckBox: Detalhado Por Operacao ---
        loc_oPg1.AddObject("chk_4c_ChkDetOpe", "CheckBox")
        WITH loc_oPg1.chk_4c_ChkDetOpe
            .Top      = 151
            .Left     = 176
            .Width    = 136
            .Height   = 15
            .Caption  = "Detalhado Por Opera" + CHR(231) + CHR(227) + "o"
            .Value    = 0
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        * --- CheckBox: Imprime Vendedor (habilitado apenas com chkDetOpe) ---
        loc_oPg1.AddObject("chk_4c_ChkVends", "CheckBox")
        WITH loc_oPg1.chk_4c_ChkVends
            .Top      = 151
            .Left     = 400
            .Width    = 105
            .Height   = 15
            .Caption  = "Imprime Vendedor"
            .Value    = 0
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        * --- TextBox: Vendedor (habilitado apenas com chkDetOpe + chkVends) ---
        loc_oPg1.AddObject("txt_4c_Vends", "TextBox")
        WITH loc_oPg1.txt_4c_Vends
            .Top         = 148
            .Left        = 532
            .Width       = 80
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Enabled     = .F.
            .ToolTipText = "Vendedor (F4=Buscar)"
            .Visible     = .T.
        ENDWITH

        * --- CheckBox: Resumo Por Vendedor ---
        loc_oPg1.AddObject("chk_4c_ChkVendRes", "CheckBox")
        WITH loc_oPg1.chk_4c_ChkVendRes
            .Top      = 168
            .Left     = 176
            .Width    = 124
            .Height   = 15
            .Caption  = "Resumo Por Vendedor"
            .Value    = 0
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        * --- CheckBox: Resumo Por Formas de Pagamento (default ativo) ---
        loc_oPg1.AddObject("chk_4c_ChkResFpg", "CheckBox")
        WITH loc_oPg1.chk_4c_ChkResFpg
            .Top      = 186
            .Left     = 176
            .Width    = 185
            .Height   = 15
            .Caption  = "Resumo Por Formas de Pagamento"
            .Value    = 1
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        * --- CheckBox: Operacoes X Pagamentos (default ativo) ---
        loc_oPg1.AddObject("chk_4c_ChkOpePag", "CheckBox")
        WITH loc_oPg1.chk_4c_ChkOpePag
            .Top      = 204
            .Left     = 176
            .Width    = 141
            .Height   = 15
            .Caption  = "Opera" + CHR(231) + CHR(245) + "es X Pagamentos"
            .Value    = 1
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        * --- CheckBox: Analitico Por Pagamentos ---
        loc_oPg1.AddObject("chk_4c_ChkAnaPag", "CheckBox")
        WITH loc_oPg1.chk_4c_ChkAnaPag
            .Top      = 222
            .Left     = 176
            .Width    = 142
            .Height   = 15
            .Caption  = "Anal" + CHR(237) + "tico Por Pagamentos"
            .Value    = 0
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventos - BINDEVENTs para botoes do CommandGroup e campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventos()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")

        BINDEVENT(loc_oPg1.txt_4c_Emps,      "KeyPress", THIS, "TeclaEmps")
        BINDEVENT(loc_oPg1.txt_4c_DtIni,     "KeyPress", THIS, "TeclaDtIni")
        BINDEVENT(loc_oPg1.txt_4c_DtFim,     "KeyPress", THIS, "TeclaDtFim")
        BINDEVENT(loc_oPg1.txt_4c_Usuars,    "KeyPress", THIS, "TeclaUsuars")
        BINDEVENT(loc_oPg1.txt_4c_FPags,     "KeyPress", THIS, "TeclaFPags")
        BINDEVENT(loc_oPg1.txt_4c_Vends,     "KeyPress", THIS, "TeclaVends")
        BINDEVENT(loc_oPg1.chk_4c_ChkDetOpe, "Click",    THIS, "ChkDetOpeClick")
        BINDEVENT(loc_oPg1.chk_4c_ChkVends,  "Click",    THIS, "ChkVendsClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoCampos - Habilita/desabilita controles conforme selecoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarEstadoCampos()
        LOCAL loc_oPg1, loc_lDetOpe, loc_lVends, loc_lVendsEmpty
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        loc_lDetOpe     = (loc_oPg1.chk_4c_ChkDetOpe.Value = 1)
        loc_lVends      = (loc_oPg1.chk_4c_ChkVends.Value = 1)
        loc_lVendsEmpty = EMPTY(ALLTRIM(loc_oPg1.txt_4c_Vends.Value))

        loc_oPg1.chk_4c_ChkVends.Enabled  = loc_lDetOpe
        loc_oPg1.txt_4c_Vends.Enabled     = loc_lDetOpe AND loc_lVends

        IF !loc_lVendsEmpty
            loc_oPg1.chk_4c_ChkResFpg.Value = 0
            loc_oPg1.chk_4c_ChkOpePag.Value = 0
            loc_oPg1.chk_4c_ChkAnaPag.Value = 0
        ENDIF
        loc_oPg1.chk_4c_ChkOpePag.Enabled = loc_lVendsEmpty
        loc_oPg1.chk_4c_ChkResFpg.Enabled = loc_lVendsEmpty
        loc_oPg1.chk_4c_ChkAnaPag.Enabled = loc_lVendsEmpty
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia todos os filtros do form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        WITH THIS.this_oRelatorio
            .this_cEmps    = ALLTRIM(loc_oPg1.txt_4c_Emps.Value)
            .this_cDEmps   = ALLTRIM(loc_oPg1.txt_4c_DEmps.Value)
            .this_dDtIni   = loc_oPg1.txt_4c_DtIni.Value
            .this_dDtFim   = loc_oPg1.txt_4c_DtFim.Value
            .this_cUsuars  = ALLTRIM(loc_oPg1.txt_4c_Usuars.Value)
            .this_cFPags   = ALLTRIM(loc_oPg1.txt_4c_FPags.Value)
            .this_cVends   = ALLTRIM(loc_oPg1.txt_4c_Vends.Value)
            .this_lDetOpe  = (loc_oPg1.chk_4c_ChkDetOpe.Value = 1)
            .this_lVends   = (loc_oPg1.chk_4c_ChkVends.Value = 1)
            .this_lVendRes = (loc_oPg1.chk_4c_ChkVendRes.Value = 1)
            .this_lResFpg  = (loc_oPg1.chk_4c_ChkResFpg.Value = 1)
            .this_lOpePag  = (loc_oPg1.chk_4c_ChkOpePag.Value = 1)
            .this_lAnaPag  = (loc_oPg1.chk_4c_ChkAnaPag.Value = 1)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa campos com valores padrao (empresa logada + hoje)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg1, loc_cEmpresa, loc_cRazao, loc_nResult
        loc_oPg1     = THIS.pgf_4c_Paginas.Page1
        loc_cEmpresa = ""
        loc_cRazao   = ""

        IF TYPE("go_4c_Sistema") = "O" AND !ISNULL(go_4c_Sistema)
            loc_cEmpresa = go_4c_Sistema.cCodEmpresa
        ENDIF

        IF !EMPTY(loc_cEmpresa) AND (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
                EscaparSQL(ALLTRIM(loc_cEmpresa)), "cursor_4c_EmpInit")

            IF loc_nResult > 0
                SELECT cursor_4c_EmpInit
                GO TOP IN cursor_4c_EmpInit
                IF !EOF("cursor_4c_EmpInit")
                    loc_cRazao = ALLTRIM(cursor_4c_EmpInit.Razas)
                ENDIF
                USE IN cursor_4c_EmpInit
            ENDIF
        ENDIF

        loc_oPg1.txt_4c_Emps.Value        = loc_cEmpresa
        loc_oPg1.txt_4c_DEmps.Value       = loc_cRazao
        loc_oPg1.txt_4c_DtIni.Value       = DATE()
        loc_oPg1.txt_4c_DtFim.Value       = DATE()
        loc_oPg1.txt_4c_Usuars.Value      = ""
        loc_oPg1.txt_4c_FPags.Value       = ""
        loc_oPg1.txt_4c_Vends.Value       = ""
        loc_oPg1.chk_4c_ChkDetOpe.Value  = 0
        loc_oPg1.chk_4c_ChkVends.Value   = 0
        loc_oPg1.chk_4c_ChkVendRes.Value = 0
        loc_oPg1.chk_4c_ChkResFpg.Value  = 1
        loc_oPg1.chk_4c_ChkOpePag.Value  = 1
        loc_oPg1.chk_4c_ChkAnaPag.Value  = 0

        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Gera relatorio em preview (video)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.FormParaRelatorio()

            IF !THIS.this_oRelatorio.Visualizar()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro ao Visualizar")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.FormParaRelatorio()

            IF !THIS.this_oRelatorio.Imprimir()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro ao Imprimir")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados do relatorio para Excel
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cArquivo
        loc_cArquivo = ""

        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.FormParaRelatorio()

            IF THIS.this_oRelatorio.PrepararDados()
                loc_cArquivo = SYS(2023) + "\FechamentoCaixa.xls"

                IF USED("crImpressao")
                    SELECT crImpressao
                    COPY TO (loc_cArquivo) TYPE XLS

                    IF FILE(loc_cArquivo)
                        MsgInfo("Arquivo exportado para:" + CHR(13) + loc_cArquivo, ;
                            "Excel Exportado")
                    ELSE
                        MsgErro("Falha ao criar arquivo Excel.", "Erro")
                    ENDIF
                ELSE
                    MsgAviso("Nenhum dado para exportar.", "Excel")
                ENDIF
            ELSE
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Exportar")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaEmps - KeyPress em txt_4c_Emps: F4=buscar, ENTER/TAB=validar
    *--------------------------------------------------------------------------
    PROCEDURE TeclaEmps(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmps()
        ELSE
            IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarEmps()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDtIni - KeyPress em txt_4c_DtIni (campo data, sem lookup)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDtIni(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDtFim - KeyPress em txt_4c_DtFim (campo data, sem lookup)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDtFim(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaUsuars - KeyPress em txt_4c_Usuars: F4=buscar, ENTER/TAB=validar
    *--------------------------------------------------------------------------
    PROCEDURE TeclaUsuars(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaUsuars()
        ELSE
            IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarUsuars()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaFPags - KeyPress em txt_4c_FPags: F4=buscar, ENTER/TAB=validar
    *--------------------------------------------------------------------------
    PROCEDURE TeclaFPags(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaFPags()
        ELSE
            IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarFPags()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaVends - KeyPress em txt_4c_Vends: F4=buscar, ENTER/TAB=validar
    *--------------------------------------------------------------------------
    PROCEDURE TeclaVends(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaVends()
        ELSE
            IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarVends()
            THIS.AtualizarEstadoCampos()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkDetOpeClick - Click em chk_4c_ChkDetOpe
    *--------------------------------------------------------------------------
    PROCEDURE ChkDetOpeClick()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        IF loc_oPg1.chk_4c_ChkDetOpe.Value = 0
            loc_oPg1.chk_4c_ChkVends.Value = 0
            loc_oPg1.txt_4c_Vends.Value    = ""
        ENDIF

        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkVendsClick - Click em chk_4c_ChkVends
    *--------------------------------------------------------------------------
    PROCEDURE ChkVendsClick()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        IF loc_oPg1.chk_4c_ChkVends.Value = 0
            loc_oPg1.txt_4c_Vends.Value = ""
        ENDIF

        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmps - Valida empresa e preenche descricao a partir de SigCdEmp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarEmps()
        LOCAL loc_oPg1, loc_cValor, loc_cSQL, loc_nResult
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg1.txt_4c_Emps.Value)

        IF EMPTY(loc_cValor)
            loc_oPg1.txt_4c_DEmps.Value = ""
            RETURN
        ENDIF

        loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
                   EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")

        IF loc_nResult > 0
            SELECT cursor_4c_EmpVal
            GO TOP IN cursor_4c_EmpVal
            IF !EOF("cursor_4c_EmpVal")
                loc_oPg1.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
                USE IN cursor_4c_EmpVal
                RETURN
            ENDIF
            USE IN cursor_4c_EmpVal
        ENDIF

        THIS.AbrirBuscaEmps()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaEmps - Abre FormBuscaAuxiliar para selecionar empresa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaEmps()
        LOCAL loc_oPg1, loc_cValor, loc_oForm
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg1.txt_4c_Emps.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValor, "Empresa")

        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        IF !loc_oForm.this_lSelecionou
            loc_oForm.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
            loc_oForm.Show()
        ENDIF

        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
            loc_oPg1.txt_4c_Emps.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
            loc_oPg1.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
        ENDIF

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarUsuars - Valida usuario existente em SigCdUsu
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarUsuars()
        LOCAL loc_oPg1, loc_cValor, loc_cSQL, loc_nResult
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg1.txt_4c_Usuars.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_cSQL = "SELECT Usuarios FROM SigCdUsu WHERE Usuarios = " + ;
                   EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsrVal")

        IF loc_nResult > 0
            SELECT cursor_4c_UsrVal
            GO TOP IN cursor_4c_UsrVal
            IF !EOF("cursor_4c_UsrVal")
                loc_oPg1.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_UsrVal.Usuarios)
                USE IN cursor_4c_UsrVal
                RETURN
            ENDIF
            USE IN cursor_4c_UsrVal
        ENDIF

        THIS.AbrirBuscaUsuars()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaUsuars - Abre FormBuscaAuxiliar para selecionar usuario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaUsuars()
        LOCAL loc_oPg1, loc_cValor, loc_oForm
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg1.txt_4c_Usuars.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdUsu", "cursor_4c_BuscaUsr", "Usuarios", loc_cValor, ;
            "Usu" + CHR(225) + "rio")

        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        IF !loc_oForm.this_lSelecionou
            loc_oForm.mAddColuna("Usuarios", "", "Usu" + CHR(225) + "rio")
            loc_oForm.Show()
        ENDIF

        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaUsr")
            loc_oPg1.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_BuscaUsr.Usuarios)
        ENDIF

        IF USED("cursor_4c_BuscaUsr")
            USE IN cursor_4c_BuscaUsr
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFPags - Valida forma de pagamento em SigOpFp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFPags()
        LOCAL loc_oPg1, loc_cValor, loc_cSQL, loc_nResult
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg1.txt_4c_FPags.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_cSQL = "SELECT FPags, Descrs FROM SigOpFp WHERE FPags = " + ;
                   EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FPgVal")

        IF loc_nResult > 0
            SELECT cursor_4c_FPgVal
            GO TOP IN cursor_4c_FPgVal
            IF !EOF("cursor_4c_FPgVal")
                loc_oPg1.txt_4c_FPags.Value = ALLTRIM(cursor_4c_FPgVal.FPags)
                USE IN cursor_4c_FPgVal
                RETURN
            ENDIF
            USE IN cursor_4c_FPgVal
        ENDIF

        THIS.AbrirBuscaFPags()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaFPags - Abre FormBuscaAuxiliar para selecionar forma de pagamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaFPags()
        LOCAL loc_oPg1, loc_cValor, loc_oForm
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg1.txt_4c_FPags.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigOpFp", "cursor_4c_BuscaFPg", "FPags", loc_cValor, ;
            "Forma de Pagamento")

        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        IF !loc_oForm.this_lSelecionou
            loc_oForm.mAddColuna("FPags",  "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
        ENDIF

        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaFPg")
            loc_oPg1.txt_4c_FPags.Value = ALLTRIM(cursor_4c_BuscaFPg.FPags)
        ENDIF

        IF USED("cursor_4c_BuscaFPg")
            USE IN cursor_4c_BuscaFPg
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarVends - Valida vendedor (usuario ativo) em SigCdUsu
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarVends()
        LOCAL loc_oPg1, loc_cValor, loc_cSQL, loc_nResult
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg1.txt_4c_Vends.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_cSQL = "SELECT Usuarios, NComps FROM SigCdUsu " + ;
                   "WHERE Usuarios = " + EscaparSQL(loc_cValor) + ;
                   " AND NOT cAtivos = 'N'"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VndVal")

        IF loc_nResult > 0
            SELECT cursor_4c_VndVal
            GO TOP IN cursor_4c_VndVal
            IF !EOF("cursor_4c_VndVal")
                loc_oPg1.txt_4c_Vends.Value = ALLTRIM(cursor_4c_VndVal.Usuarios)
                USE IN cursor_4c_VndVal
                RETURN
            ENDIF
            USE IN cursor_4c_VndVal
        ENDIF

        THIS.AbrirBuscaVends()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaVends - Abre FormBuscaAuxiliar para selecionar vendedor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaVends()
        LOCAL loc_oPg1, loc_cValor, loc_oForm
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg1.txt_4c_Vends.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdUsu", "cursor_4c_BuscaVnd", "Usuarios", loc_cValor, ;
            "Vendedor")

        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        IF !loc_oForm.this_lSelecionou
            loc_oForm.mAddColuna("Usuarios", "", "Usu" + CHR(225) + "rio")
            loc_oForm.mAddColuna("NComps",   "", "Nome")
            loc_oForm.Show()
        ENDIF

        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaVnd")
            loc_oPg1.txt_4c_Vends.Value = ALLTRIM(cursor_4c_BuscaVnd.Usuarios)
        ENDIF

        IF USED("cursor_4c_BuscaVnd")
            USE IN cursor_4c_BuscaVnd
        ENDIF
        loc_oForm.Release()

        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    * MAPEAMENTO CRUD -> REPORT
    * Forms REPORT (frmrelatorio) nao possuem operacoes CRUD reais. Estes
    * metodos existem para compatibilidade com a interface CRUD esperada pelo
    * pipeline de validacao e delegam para acoes de relatorio equivalentes.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Em REPORT, "Incluir" equivale a gerar nova visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Em REPORT, "Alterar" equivale a regerar a visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Operacao inexistente em REPORT: informa o usuario
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + ;
            "vel em relat" + CHR(243) + "rios." + CHR(13) + ;
            "Use Visualizar ou Imprimir para gerar o relat" + CHR(243) + "rio.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Em REPORT, "Buscar" equivale a gerar visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Em REPORT, "Salvar" equivale a imprimir o relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Em REPORT, "Cancelar" encerra o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias de FormParaRelatorio (compatibilidade com pipeline CRUD)
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Carrega filtros do BO de volta para os controles do form
    * Compatibilidade com pipeline CRUD (em REPORT: sincroniza BO -> controles)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF

        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        WITH THIS.this_oRelatorio
            loc_oPg1.txt_4c_Emps.Value        = .this_cEmps
            loc_oPg1.txt_4c_DtIni.Value       = .this_dDtIni
            loc_oPg1.txt_4c_DtFim.Value       = .this_dDtFim
            loc_oPg1.txt_4c_Usuars.Value      = .this_cUsuars
            loc_oPg1.txt_4c_FPags.Value       = .this_cFPags
            loc_oPg1.txt_4c_Vends.Value       = .this_cVends
            loc_oPg1.chk_4c_ChkDetOpe.Value  = IIF(.this_lDetOpe,  1, 0)
            loc_oPg1.chk_4c_ChkVends.Value   = IIF(.this_lVends,   1, 0)
            loc_oPg1.chk_4c_ChkVendRes.Value = IIF(.this_lVendRes, 1, 0)
            loc_oPg1.chk_4c_ChkResFpg.Value  = IIF(.this_lResFpg,  1, 0)
            loc_oPg1.chk_4c_ChkOpePag.Value  = IIF(.this_lOpePag,  1, 0)
            loc_oPg1.chk_4c_ChkAnaPag.Value  = IIF(.this_lAnaPag,  1, 0)
        ENDWITH

        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita todos os controles de filtro
    * par_lHabilitar: .T. = habilita, .F. = desabilita
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        loc_oPg1.txt_4c_Emps.Enabled         = par_lHabilitar
        loc_oPg1.txt_4c_DtIni.Enabled        = par_lHabilitar
        loc_oPg1.txt_4c_DtFim.Enabled        = par_lHabilitar
        loc_oPg1.txt_4c_Usuars.Enabled       = par_lHabilitar
        loc_oPg1.txt_4c_FPags.Enabled        = par_lHabilitar
        loc_oPg1.chk_4c_ChkDetOpe.Enabled    = par_lHabilitar
        loc_oPg1.chk_4c_ChkVendRes.Enabled   = par_lHabilitar
        loc_oPg1.chk_4c_ChkResFpg.Enabled    = par_lHabilitar
        loc_oPg1.chk_4c_ChkOpePag.Enabled    = par_lHabilitar
        loc_oPg1.chk_4c_ChkAnaPag.Enabled    = par_lHabilitar

        IF par_lHabilitar
            THIS.AtualizarEstadoCampos()
        ELSE
            loc_oPg1.chk_4c_ChkVends.Enabled = .F.
            loc_oPg1.txt_4c_Vends.Enabled    = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em REPORT nao ha modos de edicao (no-op)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Em REPORT nao ha lista de registros (no-op, retorna .T.)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrefecBO.prg):
*==============================================================================
* SIGREFECBO.PRG
* Business Object para Relatorio de Fechamento de Caixa
* Herda de RelatorioBase
*
* Formulario original: SIGREFEC (sigrefec.SCX)
* Caption: "Fechamento de Caixa"
*==============================================================================

DEFINE CLASS sigrefecBO AS RelatorioBase

    *-- Filtro: Empresa
    this_cEmps       = ""    && Codigo da empresa (3)
    this_cDEmps      = ""    && Razao social da empresa (40)

    *-- Filtro: Periodo
    this_dDtIni      = {}    && Data inicial
    this_dDtFim      = {}    && Data final

    *-- Filtro: Usuario / Vendedor / Forma de Pagamento
    this_cUsuars     = ""    && Codigo do usuario (10)
    this_cVends      = ""    && Codigo do vendedor (10)
    this_cFPags      = ""    && Condicao de pagamento / forma (10)

    *-- Opcoes de impressao (checkboxes)
    this_lDetOpe     = .F.   && Detalhado Por Operacao
    this_lVends      = .F.   && Imprime Vendedor
    this_lOpePag     = .T.   && Operacoes X Pagamentos
    this_lResFpg     = .T.   && Resumo Por Formas de Pagamento
    this_lAnaPag     = .F.   && Analitico Por Pagamentos
    this_lVendRes    = .F.   && Resumo Por Vendedor

    *--------------------------------------------------------------------------
    * Init - Inicializa BO com valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !DODEFAULT()
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cEmps  = go_4c_Sistema.cCodEmpresa
            THIS.this_dDtIni = DATE()
            THIS.this_dDtFim = DATE()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrefecBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Wrapper com TRY/CATCH para PrepararDadosInterno
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.PrepararDadosInterno()
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrefecBO.PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDadosInterno - Logica completa de preparacao (retorno direto OK)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDadosInterno()
        LOCAL loc_cSQL, loc_nResult, loc_cEdn, loc_cFPags
        LOCAL loc_cVista1EmpDopNums, loc_lnPri
        PRIVATE pDtI, pDtF

        pDtI    = THIS.this_dDtIni
        pDtF    = THIS.this_dDtFim + 1  && limite superior exclusivo (inicio do proximo dia)
        loc_cFPags = ALLTRIM(THIS.this_cFPags)

        *-- Query principal: todas as operacoes de fechamento de caixa do periodo
        loc_cSQL = "SELECT o.RelFechas, o.CalcFecs, e.EmpDopNums, e.Datas, " + ;
                   "e.ContaDs, c.RClis, e.Notas, e.Usuars, e.Valos, e.Vends, " + ;
                   "o.COpers, (o.NDopes * 1000000) + e.Numes AS Codigos, e.ChkSubn " + ;
                   "FROM SigCdOpe o, SigMvCab e, SigCdCli c " + ;
                   "WHERE (o.RelFechas = 1 OR o.RelFechas = 4 " + ;
                   "OR (o.RelFechas = 3 AND e.chkPagos = 1)) " + ;
                   "AND o.CalcFecs = 2 AND o.Dopes = e.Dopes " + ;
                   "AND e.Datas >= ?pDtI AND e.Datas < ?pDtF " + ;
                   "AND e.ContaDs = c.IClis AND e.lcancelas = 0"

        IF !EMPTY(ALLTRIM(THIS.this_cUsuars))
            loc_cSQL = loc_cSQL + " AND e.Usuars = " + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cUsuars), 10))
        ENDIF

        loc_cSQL = loc_cSQL + ;
                   " AND NOT e.EmpDopNums IN (" + ;
                   "SELECT a1.EmpDopNums FROM SigMvPec a1 " + ;
                   "WHERE a1.Codigos IN (" + ;
                   "SELECT (o1.NDopes * 1000000) + e1.Numes AS Codigos " + ;
                   "FROM SigCdOpe o1, SigMvCab e1 " + ;
                   "WHERE o1.RelFechas = 3 AND o1.CalcFecs = 2 " + ;
                   "AND o1.Dopes = e1.Dopes " + ;
                   "AND e1.Datas >= ?pDtI AND e1.Datas < ?pDtF))" + ;
                   " ORDER BY e.EmpDopNums"

        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crDados")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crDados)"
            MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
            RETURN .F.
        ENDIF

        *-- Remove vendas NF parceladas canceladas
        DELETE FROM crDados WHERE RelFechas = 1 AND ChkSubn = .T.

        *-- Substitui vendedor vazio pelo codigo do cliente
        UPDATE crDados SET Vends = ContaDs WHERE EMPTY(Vends)

        *-- Cria cursor de pagamentos consolidados
        CREATE CURSOR crPagamentos ;
            (EmpDopNums C(29), Parcs N(3), FPags C(12), Bancos C(3), ;
             Agencias C(4), Contas C(10), Numeros C(6), Valos N(12,2), ;
             MoeFpgs C(3), Vencs D(8), Outros C(20), DetFecCxs N(1))

        *-- Para cada operacao, busca formas de pagamento
        SELECT crDados
        SCAN
            loc_cEdn = crDados.EmpDopNums

            *-- Tenta buscar pagamentos diretos em SigMvPar
            loc_cSQL = "SELECT a.EmpDopNums, a.Parcs, a.FPags, b.Formas, b.Infos, " + ;
                       "a.Bancos, a.Agencias, a.Contas, a.Numeros, " + ;
                       "CASE WHEN b.trocos=1 THEN -a.valos ELSE a.valos END AS valos, " + ;
                       "a.MoeFpgs, a.Vencs, a.Outros, b.DetFecCxs " + ;
                       "FROM SigMvPar a, SigOpFp b " + ;
                       "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEdn) + ;
                       " AND a.FPags = b.FPags ORDER BY a.Parcs"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crPags1")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crPags1)"
                MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
                RETURN .F.
            ENDIF

            SELECT crPags1
            GO TOP IN crPags1
            IF !EOF("crPags1")
                *-- Filtra por forma de pagamento especificada (se houver)
                SELECT * FROM crPags1 ;
                    WHERE IIF(EMPTY(loc_cFPags), .T., FPags = PADR(loc_cFPags, 12)) ;
                    INTO CURSOR crPags READWRITE
            ELSE
                *-- Operacao vinculada: busca via SigMvPec
                loc_cSQL = "SELECT b.EmpDopNums, b.Parcs, b.FPags, c.Formas, c.Infos, " + ;
                           "b.Bancos, b.Agencias, b.Contas, b.Numeros, " + ;
                           "CASE WHEN c.trocos=1 THEN -b.valos ELSE b.valos END AS valos, " + ;
                           "b.MoeFpgs, b.Vencs, b.Outros, c.DetFecCxs " + ;
                           "FROM SigMvPec a, SigMvPar b, SigOpFp c " + ;
                           "WHERE a.Codigos = " + LTRIM(STR(crDados.Codigos, 10)) + ;
                           " AND a.EmpDopNums = b.EmpDopNums AND b.FPags = c.FPags"

                IF !EMPTY(loc_cFPags)
                    loc_cSQL = loc_cSQL + " AND b.FPags = " + EscaparSQL(PADR(loc_cFPags, 12))
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY b.Parcs"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crPags")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crPags)"
                    MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
                    RETURN .F.
                ENDIF
            ENDIF

            SELECT crPags
            GO TOP IN crPags
            IF EOF("crPags") AND !EMPTY(loc_cFPags)
                DELETE IN crDados
            ELSE
                SCAN
                    SCATTER MEMVAR MEMO
                    m.EmpDopNums = loc_cEdn
                    m.FPags = IIF(m.Infos = "B" AND !EMPTY(m.Formas), m.Formas, m.FPags)
                    INSERT INTO crPagamentos FROM MEMVAR
                ENDSCAN
            ENDIF
        ENDSCAN

        *-- Monta crDetalhe: JOIN entre crDados e crPagamentos
        SELECT LEFT(a.EmpDopNums, 3) AS Emps, ;
               SUBSTR(a.EmpDopNums, 4, 20) AS Dopes, ;
               RIGHT(a.EmpDopNums, 6) AS Numes, ;
               a.Datas, a.ContaDs AS IClis, a.RClis, a.Notas, ;
               a.Valos * IIF(a.COpers = 2, -1, 1) AS Valos, ;
               a.Vends, SPACE(30) AS NVends, a.Codigos, a.Usuars, ;
               b.Parcs, b.FPags, b.Bancos, b.Agencias, b.Contas, ;
               b.Numeros, b.Valos * IIF(a.COpers = 2, -1, 1) AS ValPagos, ;
               b.MoeFpgs, b.Vencs, b.DetFecCxs, b.Outros, ;
               a.RelFechas, a.CalcFecs, ;
               SPACE(32) AS RPags, SPACE(32) AS RChqs ;
            FROM crDados a RIGHT JOIN crPagamentos b ;
            ON a.EmpDopNums = b.EmpDopNums ;
            ORDER BY a.Datas, a.EmpDopNums, b.Parcs ;
            INTO CURSOR crDetalhe READWRITE

        *-- Preenche NVends e campos de vista (RPags/RChqs) em crDetalhe
        SELECT crDetalhe
        SCAN
            IF crDetalhe.RelFechas = 3 AND crDetalhe.CalcFecs = 2
                *-- Reconstroi EmpDopNums a partir dos campos fixos (sem ALLTRIM - fixed-width)
                loc_cEdn = crDetalhe.Emps + crDetalhe.Dopes + crDetalhe.Numes

                loc_cSQL = "SELECT e.Numes + (o.NDopes * 1000000) AS Codigos, " + ;
                           "p.EmpDopNums " + ;
                           "FROM SigMvCab e, SigCdOpe o, SigMvPec p " + ;
                           "WHERE e.EmpDopNums = " + EscaparSQL(loc_cEdn) + ;
                           " AND o.Dopes = e.Dopes " + ;
                           " AND p.Codigos = e.Numes + (o.NDopes * 1000000) " + ;
                           " ORDER BY p.EmpDopNums"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crVista1")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crVista1)"
                    MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
                    RETURN .F.
                ENDIF

                SELECT crVista1
                GO TOP IN crVista1
                IF !EOF("crVista1")
                    loc_cVista1EmpDopNums = crVista1.EmpDopNums

                    loc_cSQL = "SELECT r.Parcs, r.FPags, r.Valos, r.Vencs, " + ;
                               "r.Contas, r.Numeros " + ;
                               "FROM SigMvPar r " + ;
                               "WHERE r.EmpDopNums = " + EscaparSQL(loc_cVista1EmpDopNums) + ;
                               " AND r.Parcs = " + LTRIM(STR(crDetalhe.Parcs, 2)) + ;
                               " ORDER BY r.Parcs"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crVista")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crVista)"
                        MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
                        RETURN .F.
                    ENDIF

                    loc_lnPri = 1
                    SELECT crVista
                    SCAN
                        IF !ISNULL(crVista.FPags)
                            IF loc_lnPri > 1
                                loc_cSQL = "SELECT NComps FROM SigCdUsu " + ;
                                           "WHERE Usuarios = " + EscaparSQL(crDetalhe.Vends)

                                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crNVends")
                                IF loc_nResult < 1
                                    THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crNVends)"
                                    MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
                                    RETURN .F.
                                ENDIF

                                SELECT crNVends
                                GO TOP IN crNVends
                                IF !EOF("crNVends")
                                    REPLACE NVends WITH crNVends.NComps IN crDetalhe
                                ENDIF

                                SKIP IN crDetalhe
                            ENDIF

                            REPLACE RPags WITH LTRIM(STR(loc_lnPri, 2)) + " " + crVista.FPags + ;
                                    " " + SPACE(6) + ;
                                    TRANSFORM(crVista.Valos, "999,999.99") IN crDetalhe

                            IF !EMPTY(crVista.Numeros)
                                REPLACE RChqs WITH crVista.Contas + " / " + crVista.Numeros + ;
                                        "  " + DTOC(crVista.Vencs) IN crDetalhe
                            ENDIF

                            loc_lnPri = loc_lnPri + 1
                        ENDIF
                    ENDSCAN
                ENDIF
            ENDIF

            *-- Preenche nome do vendedor para todas as linhas
            loc_cSQL = "SELECT NComps FROM SigCdUsu WHERE Usuarios = " + ;
                       EscaparSQL(crDetalhe.Vends)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crNVends")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crNVends)"
                MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
                RETURN .F.
            ENDIF

            SELECT crNVends
            GO TOP IN crNVends
            IF !EOF("crNVends")
                REPLACE NVends WITH crNVends.NComps IN crDetalhe
            ENDIF
        ENDSCAN

        *-- Monta impressao linha a linha em crImpressao
        CREATE CURSOR crImpressao (Detalhe C(40))

        SET POINT TO ","
        SET SEPARATOR TO "."

        THIS.Cabecalho()

        IF THIS.this_lDetOpe
            THIS.Detalhado()
        ENDIF

        IF THIS.this_lVendRes
            THIS.ResVends()
        ENDIF

        IF THIS.this_lResFpg
            THIS.ResumoPagto()
        ENDIF

        IF THIS.this_lOpePag
            THIS.PagtoXFpags()
        ENDIF

        IF THIS.this_lAnaPag
            THIS.AnaFPags()
        ENDIF

        SET POINT TO "."
        SET SEPARATOR TO ","

        SELECT crImpressao
        GO TOP IN crImpressao

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Cabecalho - Insere cabecalho do relatorio em crImpressao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Cabecalho()
        LOCAL loc_cDEmps, loc_dDtIni, loc_dDtFim, loc_cUsuars

        loc_cDEmps  = ALLTRIM(THIS.this_cDEmps)
        loc_dDtIni  = THIS.this_dDtIni
        loc_dDtFim  = THIS.this_dDtFim
        loc_cUsuars = ALLTRIM(THIS.this_cUsuars)

        INSERT INTO crImpressao (Detalhe) VALUES ("========================================")
        INSERT INTO crImpressao (Detalhe) VALUES (PADC(loc_cDEmps, 40))
        INSERT INTO crImpressao (Detalhe) VALUES ("   Caixas de: " + DTOC(loc_dDtIni) + ;
            " " + CHR(224) + " " + DTOC(loc_dDtFim))
        INSERT INTO crImpressao (Detalhe) VALUES ("   Usuario  : " + ;
            IIF(EMPTY(loc_cUsuars), "GERAL", loc_cUsuars))
        INSERT INTO crImpressao (Detalhe) VALUES ("   Fechamento em " + DTOC(DATE()) + ;
            " " + CHR(224) + "s " + SUBSTR(TTOC(DATETIME()), 12, 5) + "h")
        INSERT INTO crImpressao (Detalhe) VALUES ("========================================")
        INSERT INTO crImpressao (Detalhe) VALUES ("")
    ENDPROC

    *--------------------------------------------------------------------------
    * Detalhado - Secao detalhada por operacao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Detalhado()
        LOCAL loc_cVen, loc_cVal, loc_lnTot, loc_cCli, loc_cVdd

        loc_cVen   = ALLTRIM(THIS.this_cVends)
        loc_lnTot  = 0

        IF EMPTY(loc_cVen)
            IF THIS.this_lVends
                SELECT Vends, Dopes, SUM(IIF(RelFechas=4, 0.00, ValPagos)) AS Valos ;
                    FROM crDetalhe ;
                    GROUP BY Vends, Dopes ;
                    ORDER BY Dopes, Vends ;
                    INTO CURSOR TmpOperacoes
            ELSE
                SELECT SPACE(10) AS Vends, Dopes, ;
                       SUM(IIF(RelFechas=4, 0.00, ValPagos)) AS Valos ;
                    FROM crDetalhe ;
                    GROUP BY Dopes ;
                    ORDER BY Dopes ;
                    INTO CURSOR TmpOperacoes
            ENDIF
        ELSE
            SELECT Vends, Dopes, SUM(IIF(RelFechas=4, 0.00, ValPagos)) AS Valos ;
                FROM crDetalhe ;
                WHERE Vends = loc_cVen ;
                GROUP BY Vends, Dopes ;
                ORDER BY Dopes, Vends ;
                INTO CURSOR TmpOperacoes
        ENDIF

        INSERT INTO crImpressao (Detalhe) VALUES ("======== DETALHADO POR OPERACAO ========")

        SELECT TmpOperacoes
        SCAN
            loc_lnTot = loc_lnTot + TmpOperacoes.Valos

            loc_cVal = TRANSFORM(TmpOperacoes.Valos, "999,999,999.99")
            INSERT INTO crImpressao (Detalhe) VALUES ("= " + TmpOperacoes.Dopes + ":   " + loc_cVal)

            IF EMPTY(loc_cVen)
                IF THIS.this_lVends
                    SELECT DISTINCT Vends, Dopes, Numes ;
                        FROM crDetalhe ;
                        WHERE Dopes = TmpOperacoes.Dopes AND Vends = TmpOperacoes.Vends ;
                        ORDER BY Dopes, Vends, Numes ;
                        INTO CURSOR TmpOpeIndivs
                ELSE
                    SELECT DISTINCT Dopes, Numes ;
                        FROM crDetalhe ;
                        WHERE Dopes = TmpOperacoes.Dopes ;
                        ORDER BY Dopes, Numes ;
                        INTO CURSOR TmpOpeIndivs
                ENDIF
            ELSE
                SELECT DISTINCT Dopes, Numes ;
                    FROM crDetalhe ;
                    WHERE Dopes = TmpOperacoes.Dopes AND Vends = loc_cVen ;
                    ORDER BY Dopes, Numes ;
                    INTO CURSOR TmpOpeIndivs
            ENDIF

            SELECT TmpOpeIndivs
            SCAN
                SELECT IClis, RClis, Notas, Vends, NVends, Parcs, FPags, ValPagos, ;
                       Vencs, Bancos, Agencias, Contas, Numeros, RelFechas ;
                    FROM crDetalhe ;
                    WHERE Dopes = TmpOpeIndivs.Dopes AND Numes = TmpOpeIndivs.Numes ;
                    ORDER BY Parcs ;
                    INTO CURSOR TmpOpePags

                SELECT TmpOpePags
                SCAN
                    loc_cVal = TRANSFORM(TmpOpePags.ValPagos, "999,999,999.99")

                    IF TmpOpePags.Parcs = 1
                        INSERT INTO crImpressao (Detalhe) VALUES ("> " + ;
                            PADL(ALLTRIM(TmpOpeIndivs.Numes), 6, "0") + ;
                            " (" + PADL(TmpOpePags.Parcs, 2, "0") + ") " + ;
                            TmpOpePags.FPags + loc_cVal)
                    ELSE
                        INSERT INTO crImpressao (Detalhe) VALUES ("        " + ;
                            " (" + PADL(TmpOpePags.Parcs, 2, "0") + ") " + ;
                            TmpOpePags.FPags + loc_cVal)
                    ENDIF

                    IF !EMPTY(TmpOpePags.Numeros)
                        INSERT INTO crImpressao (Detalhe) VALUES ("         " + ;
                            TmpOpePags.Contas + " / " + TmpOpePags.Numeros + ;
                            "  " + DTOC(TmpOpePags.Vencs))
                    ENDIF
                ENDSCAN

                SELECT TmpOpePags
                GO TOP IN TmpOpePags
                IF !EOF("TmpOpePags")
                    loc_cCli = PADR(ALLTRIM(TmpOpePags.IClis) + " - " + ;
                                    ALLTRIM(TmpOpePags.RClis), 31)
                    INSERT INTO crImpressao (Detalhe) VALUES ("  " + loc_cCli + " " + TmpOpePags.Notas)
                ENDIF

                IF THIS.this_lVends
                    SELECT TmpOpePags
                    GO TOP IN TmpOpePags
                    IF !EOF("TmpOpePags")
                        IF EMPTY(TmpOpePags.Vends)
                            loc_cVdd = ALLTRIM(TmpOpePags.IClis) + " - " + ALLTRIM(TmpOpePags.RClis)
                        ELSE
                            loc_cVdd = ALLTRIM(TmpOpePags.Vends) + " - " + ALLTRIM(TmpOpePags.NVends)
                        ENDIF
                        INSERT INTO crImpressao (Detalhe) VALUES ("  " + loc_cVdd)
                    ENDIF
                ENDIF
            ENDSCAN

            INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        ENDSCAN

        loc_cVal = TRANSFORM(loc_lnTot, "999,999,999.99")
        INSERT INTO crImpressao (Detalhe) VALUES ("=           TOTAL GERAL : " + loc_cVal)
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("")
    ENDPROC

    *--------------------------------------------------------------------------
    * PagtoXFpags - Secao Operacoes X Formas de Pagamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PagtoXFpags()
        LOCAL loc_cVal, loc_lnTot, loc_lnGer

        SELECT Dopes, SUM(ValPagos) AS Valos ;
            FROM crDetalhe ;
            GROUP BY Dopes ;
            ORDER BY Dopes ;
            INTO CURSOR TmpOperacoes

        INSERT INTO crImpressao (Detalhe) VALUES ("==== RESUMO: OPERACOES X PAGAMENTOS ====")
        INSERT INTO crImpressao (Detalhe) VALUES ("")

        loc_lnGer = 0
        SELECT TmpOperacoes
        SCAN
            INSERT INTO crImpressao (Detalhe) VALUES ("= " + TmpOperacoes.Dopes)

            SELECT DetFecCxs, RelFechas, FPags, SUM(ValPagos) AS Valos ;
                FROM crDetalhe ;
                WHERE Dopes = TmpOperacoes.Dopes ;
                GROUP BY DetFecCxs, RelFechas, FPags ;
                ORDER BY FPags ;
                INTO CURSOR TmpFPags

            loc_lnTot = 0
            SELECT TmpFPags
            SCAN
                loc_lnGer = loc_lnGer + IIF(RelFechas=4, 0, TmpFPags.Valos)
                loc_lnTot = loc_lnTot + IIF(RelFechas=4, 0, TmpFPags.Valos)

                loc_cVal = TRANSFORM(TmpFPags.Valos, "999,999,999.99")
                INSERT INTO crImpressao (Detalhe) VALUES ("  " + TmpFPags.FPags + " : " + loc_cVal)

                IF TmpFPags.DetFecCxs = 1 AND TmpFPags.RelFechas = 3
                    SELECT Notas, FPags, SUM(ValPagos) AS ValPagos, ;
                           Vencs, Bancos, Agencias, Contas, Numeros, Outros ;
                        FROM crDetalhe ;
                        WHERE Dopes = TmpOperacoes.Dopes AND FPags = TmpFPags.FPags ;
                        GROUP BY Notas, FPags, Vencs, Bancos, Agencias, Contas, Numeros, Outros ;
                        ORDER BY Notas ;
                        INTO CURSOR TmpOpeChqs

                    SELECT TmpOpeChqs
                    SCAN
                        IF !EMPTY(TmpOpeChqs.Outros)
                            loc_cVal = TRANSFORM(TmpOpeChqs.ValPagos, "999,999.99")
                            INSERT INTO crImpressao (Detalhe) VALUES ("  " + TmpOpeChqs.Notas + ;
                                " " + TmpOpeChqs.Outros + " " + loc_cVal)
                        ENDIF

                        IF !EMPTY(TmpOpeChqs.Numeros)
                            loc_cVal = TRANSFORM(TmpOpeChqs.ValPagos, "99,999,999.99")
                            INSERT INTO crImpressao (Detalhe) VALUES ("  " + TmpOpeChqs.Notas + ;
                                " " + DTOC(TmpOpeChqs.Vencs) + " " + ;
                                TmpOpeChqs.Numeros + " " + loc_cVal)
                        ENDIF
                    ENDSCAN
                ENDIF
            ENDSCAN

            loc_cVal = TRANSFORM(loc_lnTot, "999,999,999.99")
            INSERT INTO crImpressao (Detalhe) VALUES ("                 --------------")
            INSERT INTO crImpressao (Detalhe) VALUES ("      SUBTOTAL : " + loc_cVal)
            INSERT INTO crImpressao (Detalhe) VALUES ("")
        ENDSCAN

        loc_cVal = TRANSFORM(loc_lnGer, "999,999,999.99")
        INSERT INTO crImpressao (Detalhe) VALUES ("                 --------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("  TOTAL GERAL  : " + loc_cVal)
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("")
    ENDPROC

    *--------------------------------------------------------------------------
    * ResumoPagto - Secao Resumo Por Formas de Pagamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ResumoPagto()
        LOCAL loc_cVal, loc_lnTot

        SELECT IIF(RelFechas=4, PADR("VALE", 12), FPags) AS FPags, ;
               RelFechas, SUM(ValPagos) AS Valos ;
            FROM crDetalhe ;
            GROUP BY 1, 2 ;
            ORDER BY 1 ;
            INTO CURSOR TmpFPags

        INSERT INTO crImpressao (Detalhe) VALUES ("==== RESUMO POR FORMAS DE PAGAMENTO ====")
        INSERT INTO crImpressao (Detalhe) VALUES ("")

        loc_lnTot = 0
        SELECT TmpFPags
        SCAN
            loc_lnTot = loc_lnTot + TmpFPags.Valos
            loc_cVal = TRANSFORM(TmpFPags.Valos, "999,999,999.99")
            INSERT INTO crImpressao (Detalhe) VALUES ("= " + TmpFPags.FPags + " : " + loc_cVal)
        ENDSCAN

        loc_cVal = TRANSFORM(loc_lnTot, "999,999,999.99")
        INSERT INTO crImpressao (Detalhe) VALUES ("                 --------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("= TOTAL GERAL  : " + loc_cVal)
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")

        *-- Subtotal especifico VALE + DINHEIRO + TROCO
        SELECT IIF(RelFechas=4, PADR("VALE", 12), FPags) AS FPags, ;
               RelFechas, SUM(ValPagos) AS Valos ;
            FROM crDetalhe ;
            WHERE RelFechas = 4 OR INLIST(FPags, "DINHEIRO    ", "TROCO       ") ;
            GROUP BY 1, 2 ;
            ORDER BY 1 ;
            INTO CURSOR TmpFPags

        INSERT INTO crImpressao (Detalhe) VALUES ("")

        loc_lnTot = 0
        SELECT TmpFPags
        SCAN
            loc_lnTot = loc_lnTot + TmpFPags.Valos
            loc_cVal = TRANSFORM(TmpFPags.Valos, "999,999,999.99")
            INSERT INTO crImpressao (Detalhe) VALUES ("= " + TmpFPags.FPags + " : " + loc_cVal)
        ENDSCAN

        loc_cVal = TRANSFORM(loc_lnTot, "999,999,999.99")
        INSERT INTO crImpressao (Detalhe) VALUES ("                 --------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("= TOTAL ESPECIE: " + loc_cVal)
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("")
    ENDPROC

    *--------------------------------------------------------------------------
    * ResVends - Secao Resumo Por Vendedor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ResVends()
        LOCAL loc_cVal, loc_lnTot

        SELECT Vends, SUM(ValPagos) AS Valos ;
            FROM crDetalhe ;
            GROUP BY Vends ;
            ORDER BY Vends ;
            INTO CURSOR TmpOperacoes

        INSERT INTO crImpressao (Detalhe) VALUES ("========= RESUMO POR VENDEDOR ==========")

        loc_lnTot = 0
        SELECT TmpOperacoes
        SCAN
            loc_lnTot = loc_lnTot + TmpOperacoes.Valos

            loc_cVal = TRANSFORM(TmpOperacoes.Valos, "999,999,999.99")
            INSERT INTO crImpressao (Detalhe) VALUES ("= " + TmpOperacoes.Vends + ;
                "            : " + loc_cVal)

            SELECT Dopes, SUM(ValPagos) AS Valos ;
                FROM crDetalhe ;
                WHERE Vends = TmpOperacoes.Vends ;
                GROUP BY Dopes ;
                ORDER BY Dopes ;
                INTO CURSOR TmpDopes

            SELECT TmpDopes
            SCAN
                loc_cVal = TRANSFORM(TmpDopes.Valos, "999,999,999.99")
                INSERT INTO crImpressao (Detalhe) VALUES ("   " + TmpDopes.Dopes + " : " + loc_cVal)
            ENDSCAN

            INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        ENDSCAN

        loc_cVal = TRANSFORM(loc_lnTot, "999,999,999.99")
        INSERT INTO crImpressao (Detalhe) VALUES ("= TOTAL GERAL:            " + loc_cVal)
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("")
    ENDPROC

    *--------------------------------------------------------------------------
    * AnaFPags - Secao Analitico Por Pagamentos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AnaFPags()
        LOCAL loc_cVal, loc_lnTot, loc_lnSub

        INSERT INTO crImpressao (Detalhe) VALUES ("======= ANALITICO POR PAGAMENTOS =======")

        SELECT DISTINCT FPags ;
            FROM crDetalhe ;
            ORDER BY FPags ;
            INTO CURSOR TmpFPags

        loc_lnTot = 0

        SELECT TmpFPags
        SCAN
            SELECT IIF(RelFechas=4, PADR("VALE", 12), FPags) AS FPags, ;
                   RPags, RChqs, RelFechas, Vends, Notas, Parcs, ;
                   ValPagos, Contas, Numeros, Vencs ;
                FROM crDetalhe ;
                WHERE FPags = TmpFPags.FPags ;
                ORDER BY FPags, Vends, Notas, Parcs ;
                INTO CURSOR TmpOpePags

            loc_lnSub = 0

            SELECT TmpOpePags
            SCAN
                loc_lnTot = loc_lnTot + TmpOpePags.ValPagos
                loc_lnSub = loc_lnSub + TmpOpePags.ValPagos

                loc_cVal = TRANSFORM(TmpOpePags.ValPagos, "999,999.99")

                IF TmpOpePags.Parcs = 1
                    INSERT INTO crImpressao (Detalhe) VALUES (PADR(TmpOpePags.FPags, 10) + " " + ;
                        PADR(TmpOpePags.Vends, 9) + TmpOpePags.Notas + ;
                        "/" + PADL(TmpOpePags.Parcs, 2, "0") + " " + loc_cVal)
                ELSE
                    INSERT INTO crImpressao (Detalhe) VALUES ("                    " + ;
                        TmpOpePags.Notas + "/" + PADL(TmpOpePags.Parcs, 2, "0") + " " + loc_cVal)
                ENDIF

                IF !EMPTY(TmpOpePags.Numeros)
                    INSERT INTO crImpressao (Detalhe) VALUES ("         " + ;
                        TmpOpePags.Contas + " / " + TmpOpePags.Numeros + ;
                        "  " + DTOC(TmpOpePags.Vencs))
                ENDIF

                IF !EMPTY(TmpOpePags.RPags)
                    INSERT INTO crImpressao (Detalhe) VALUES ("        " + TmpOpePags.RPags)

                    IF !EMPTY(TmpOpePags.RChqs)
                        INSERT INTO crImpressao (Detalhe) VALUES ("         " + TmpOpePags.RChqs)
                    ENDIF
                ENDIF
            ENDSCAN

            loc_cVal = TRANSFORM(loc_lnSub, "999,999,999.99")
            INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
            INSERT INTO crImpressao (Detalhe) VALUES ("=              SUBTOTAL : " + loc_cVal)
            INSERT INTO crImpressao (Detalhe) VALUES ("")
        ENDSCAN

        loc_cVal = TRANSFORM(loc_lnTot, "999,999,999.99")
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("=           TOTAL GERAL : " + loc_cVal)
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("")
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + "RelSigReFec") TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrefecBO.Imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + "RelSigReFec") PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrefecBO.Visualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultimo erro registrado
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao possui chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

ENDDEFINE

