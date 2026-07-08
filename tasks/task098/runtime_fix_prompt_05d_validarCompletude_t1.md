# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[Formsigrefcd.prg] Procedure vazia (sem codigo): AjustarBotoesPorModo
[Formsigrefcd.prg] Procedure vazia (sem codigo): BOParaForm

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrefcd.prg):
*==============================================================================
* FORMSIGREFCD.PRG
* Informativo de Vendas Diarias
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREFCD.SCX (frmrelatorio)
*
* Filtros:
*   - Empresa   (codigo + descricao - SigCdEmp.cemps / razas)
*   - Periodo   (data inicial / data final)
*
* Acoes: Visualizar (preview) / Imprimir (com dialogo) / Documento (direto)
*==============================================================================

DEFINE CLASS Formsigrefcd AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=300)
    Height      = 300
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
    * InicializarForm - Cria estrutura completa do formulario de relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Informativo de Vendas Di" + CHR(225) + "rias"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio (pula se em modo validacao de UI sem conexao SQL)
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.this_oRelatorio = CREATEOBJECT("sigrefcdBO")
                IF VARTYPE(THIS.this_oRelatorio) != "O"
                    MsgErro("Erro ao criar sigrefcdBO" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.ConfigurarPaginaFiltros()

                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocumentoClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                *-- Valores iniciais (pulado em modo de validacao de UI sem conexao SQL)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.LimparCampos()
                ENDIF

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
                .Caption   = "Informativo de Vendas Di" + CHR(225) + "rias"
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
                .Caption   = "Informativo de Vendas Di" + CHR(225) + "rias"
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
    * ConfigurarBotoes - CommandGroup btnReport (framework.vcx frmrelatorio)
    *   Original: btnReport.Left=526 -> padrao canonico Left=529
    *   Botoes: Visualizar(5), Imprimir(71), Documento(137), Encerrar(203)
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
                .Caption         = "Documento"
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
                .ToolTipText     = "Gerar Documento do Relat" + CHR(243) + "rio"
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
    * ConfigurarPageFrame - PageFrame unico com filtros (form FLAT convertido)
    *   Posicionado abaixo do cabecalho (85px).
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
    * ConfigurarPaginaFiltros - Filtros na Page1 (Empresa + Periodo)
    *   Posicoes convertidas: OriginalTop - PageFrame.Top(85)
    *   get_cd_empresa: Top=144 -> Page1.Top=59
    *   get_dt_inicial: Top=169 -> Page1.Top=84
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaFiltros()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Label "Empresa :" (original: lbl_empresa, Top=147, Left=224)
        loc_oPg.AddObject("lbl_4c_LblEmpresa", "Label")
        WITH loc_oPg.lbl_4c_LblEmpresa
            .Top       = 62
            .Left      = 224
            .Width     = 50
            .Height    = 15
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo da empresa (get_cd_empresa: Width=31, Left=279, MaxLength=3)
        loc_oPg.AddObject("txt_4c_CdEmpresa", "TextBox")
        WITH loc_oPg.txt_4c_CdEmpresa
            .Top           = 59
            .Left          = 279
            .Width         = 31
            .Height        = 23
            .Value         = ""
            .MaxLength     = 3
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Descricao da empresa (get_ds_empresa: Width=289, Left=312, MaxLength=40)
        *   ReadOnly quando codigo da empresa esta preenchido (When original)
        loc_oPg.AddObject("txt_4c_DsEmpresa", "TextBox")
        WITH loc_oPg.txt_4c_DsEmpresa
            .Top           = 59
            .Left          = 312
            .Width         = 289
            .Height        = 23
            .Value         = ""
            .MaxLength     = 40
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Label "Periodo :" (original: lbl_periodo, Top=172, Left=229)
        loc_oPg.AddObject("lbl_4c_LblPeriodo", "Label")
        WITH loc_oPg.lbl_4c_LblPeriodo
            .Top       = 87
            .Left      = 229
            .Width     = 45
            .Height    = 15
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Data inicial (get_dt_inicial: Width=80, Left=279, Top=169)
        loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPg.txt_4c_DtInicial
            .Top           = 84
            .Left          = 279
            .Width         = 80
            .Height        = 23
            .Value         = {}
            .Format        = "D"
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Separador entre datas (Say1: Caption="a" grave, Top=172, Left=363)
        loc_oPg.AddObject("lbl_4c_Sep", "Label")
        WITH loc_oPg.lbl_4c_Sep
            .Top       = 87
            .Left      = 363
            .Width     = 10
            .Height    = 15
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Data final (get_dt_final: Width=80, Left=376, Top=169)
        loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPg.txt_4c_DtFinal
            .Top           = 84
            .Left          = 376
            .Width         = 80
            .Height        = 23
            .Value         = {}
            .Format        = "D"
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Handlers de teclado para campos de filtro
        BINDEVENT(loc_oPg.txt_4c_CdEmpresa, "KeyPress", THIS, "TeclaCdEmpresa")
        BINDEVENT(loc_oPg.txt_4c_DsEmpresa, "KeyPress", THIS, "TeclaDsEmpresa")
        BINDEVENT(loc_oPg.txt_4c_DtInicial, "KeyPress", THIS, "TeclaDataInicial")
        BINDEVENT(loc_oPg.txt_4c_DtFinal,   "KeyPress", THIS, "TeclaDataFinal")

        *-- DblClick tambem abre lookup (equivalente ao F4)
        BINDEVENT(loc_oPg.txt_4c_CdEmpresa, "DblClick", THIS, "AbrirBuscaEmpresa")
        BINDEVENT(loc_oPg.txt_4c_DsEmpresa, "DblClick", THIS, "AbrirBuscaDsEmpresa")

        *-- Estado inicial do campo de descricao (ReadOnly quando codigo preenchido)
        THIS.AtualizarEstadoDsEmpresa()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura filtros para valores padrao.
    *   Empresa = empresa corrente do sistema; Datas = hoje.
    *   Equivalente ao Init() legado que preenchia _empr e carregava razao.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg, loc_cEmp, loc_nResult
        TRY
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            loc_cEmp = ""

            IF TYPE("go_4c_Sistema") = "O" AND !ISNULL(go_4c_Sistema)
                loc_cEmp = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            ENDIF

            loc_oPg.txt_4c_CdEmpresa.Value = loc_cEmp
            loc_oPg.txt_4c_DsEmpresa.Value = ""
            loc_oPg.txt_4c_DtInicial.Value = DATE()
            loc_oPg.txt_4c_DtFinal.Value   = DATE()

            *-- Carrega descricao da empresa corrente (equivalente ao Init legado)
            IF !EMPTY(loc_cEmp)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + ;
                    EscaparSQL(loc_cEmp), ;
                    "cursor_4c_EmpInit")
                IF loc_nResult > 0
                    SELECT cursor_4c_EmpInit
                    IF !EOF()
                        loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpInit.razas)
                    ENDIF
                ENDIF
                IF USED("cursor_4c_EmpInit")
                    USE IN cursor_4c_EmpInit
                ENDIF
            ENDIF

            THIS.AtualizarEstadoDsEmpresa()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos controles para propriedades do BO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_cCodEmpresa  = ALLTRIM(loc_oPg.txt_4c_CdEmpresa.Value)
            .this_cRazaEmpresa = ALLTRIM(loc_oPg.txt_4c_DsEmpresa.Value)
            .this_dDtInicial   = loc_oPg.txt_4c_DtInicial.Value
            .this_dDtFinal     = loc_oPg.txt_4c_DtFinal.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarPeriodo - Verifica data final >= data inicial.
    *   Replica validacao de get_dt_inicial.Valid e get_dt_final.Valid do legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarPeriodo()
        LOCAL loc_oPg, loc_dIni, loc_dFim
        loc_oPg  = THIS.pgf_4c_Paginas.Page1
        loc_dIni = loc_oPg.txt_4c_DtInicial.Value
        loc_dFim = loc_oPg.txt_4c_DtFinal.Value
        IF !EMPTY(loc_dIni) AND !EMPTY(loc_dFim) AND loc_dIni > loc_dFim
            MsgAviso("Data Final n" + CHR(227) + "o pode ser menor que a Data Inicial.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_DtFinal.SetFocus()
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Verifica preenchimento dos campos obrigatorios.
    *   Empresa e Periodo sao obrigatorios para gerar o relatorio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(ALLTRIM(loc_oPg.txt_4c_CdEmpresa.Value))
            MsgAviso("Informe o c" + CHR(243) + "digo da empresa.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_CdEmpresa.SetFocus()
            RETURN .F.
        ENDIF
        IF EMPTY(loc_oPg.txt_4c_DtInicial.Value)
            MsgAviso("Informe a data inicial do per" + CHR(237) + "odo.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_DtInicial.SetFocus()
            RETURN .F.
        ENDIF
        IF EMPTY(loc_oPg.txt_4c_DtFinal.Value)
            MsgAviso("Informe a data final do per" + CHR(237) + "odo.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_DtFinal.SetFocus()
            RETURN .F.
        ENDIF
        IF !THIS.ValidarPeriodo()
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza relatorio em preview na tela
    *   Equivalente ao PROCEDURE visualizacao do legado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cFrxPath
        TRY
            IF THIS.ValidarFiltros()
                THIS.FormParaRelatorio()
                IF THIS.this_oRelatorio.PrepararDados()
                    loc_cFrxPath = gc_4c_CaminhoReports + "SigReFcD.frx"
                    REPORT FORM (loc_cFrxPath) PREVIEW NOCONSOLE
                ELSE
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relatorio com dialogo de selecao de impressora
    *   Equivalente ao PROCEDURE impressao do legado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_cFrxPath
        TRY
            IF THIS.ValidarFiltros()
                THIS.FormParaRelatorio()
                IF THIS.this_oRelatorio.PrepararDados()
                    loc_cFrxPath = gc_4c_CaminhoReports + "SigReFcD.frx"
                    REPORT FORM (loc_cFrxPath) TO PRINTER PROMPT NOCONSOLE
                ELSE
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDocumentoClick - Envia relatorio direto para impressora sem dialogo
    *--------------------------------------------------------------------------
    PROCEDURE BtnDocumentoClick()
        LOCAL loc_cFrxPath
        TRY
            IF THIS.ValidarFiltros()
                THIS.FormParaRelatorio()
                IF THIS.this_oRelatorio.PrepararDados()
                    loc_cFrxPath = gc_4c_CaminhoReports + "SigReFcD.frx"
                    REPORT FORM (loc_cFrxPath) TO PRINTER NOCONSOLE
                ELSE
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                ENDIF
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
    * MAPEAMENTO CRUD -> REPORT (aliases de compatibilidade com pipeline)
    *==========================================================================

    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o dispon" + CHR(237) + "vel em relat" + CHR(243) + "rios.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.BtnSairClick()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        LOCAL loc_oPg
        TRY
            THIS.LimparCampos()
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c_CdEmpresa", 5)
                loc_oPg.txt_4c_CdEmpresa.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Compatibilidade com pipeline CRUD
    *   Forms REPORT (frmrelatorio) tem layout FLAT, sem pagina de Lista.
    *   A unica pagina existente (Filtros) ja eh configurada por
    *   ConfigurarPaginaFiltros(). Este metodo apenas redireciona para
    *   manter compatibilidade com o orquestrador da migracao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarPaginaFiltros()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Compatibilidade com pipeline CRUD
    *   Forms REPORT (frmrelatorio) tem layout FLAT: todos os campos de filtro
    *   ficam na unica Page1 (Filtros), configurada por ConfigurarPaginaFiltros().
    *   Nao existe Page2 de edicao de dados neste tipo de form. Mantido apenas
    *   para satisfazer contratos do pipeline de migracao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarPaginaFiltros()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Compatibilidade com pipeline CRUD
    *   Forms REPORT possuem somente uma pagina (Filtros). Nao ha alternancia
    *   entre Lista/Dados. Mantido apenas para satisfazer contratos do
    *   pipeline de migracao e qualquer chamada herdada que possa ocorrer.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            THIS.pgf_4c_Paginas.Visible = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLADO - BINDEVENT KeyPress
    * F4=115, ENTER=13, TAB=9
    *==========================================================================

    PROCEDURE TeclaCdEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDsEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDataInicial(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_oPg, loc_dIni, loc_dFim
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            loc_dIni = loc_oPg.txt_4c_DtInicial.Value
            loc_dFim = loc_oPg.txt_4c_DtFinal.Value
            IF !EMPTY(loc_dIni) AND !EMPTY(loc_dFim) AND loc_dIni > loc_dFim
                loc_oPg.txt_4c_DtFinal.Value = loc_dIni
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TeclaDataFinal(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_oPg, loc_dIni, loc_dFim
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            loc_dIni = loc_oPg.txt_4c_DtInicial.Value
            loc_dFim = loc_oPg.txt_4c_DtFinal.Value
            IF !EMPTY(loc_dFim) AND !EMPTY(loc_dIni) AND loc_dFim < loc_dIni
                MsgAviso("Data Final n" + CHR(227) + "o pode ser menor que a Data Inicial.", ;
                    "Aviso")
                loc_oPg.txt_4c_DtFinal.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoDsEmpresa - Simula get_ds_empresa.When do legado.
    *   get_ds_empresa.When: Return Empty(ThisForm.get_cd_empresa.Value)
    *   Campo de descricao so e editavel quando codigo da empresa esta vazio.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoDsEmpresa()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_DsEmpresa.ReadOnly = ;
                !EMPTY(ALLTRIM(loc_oPg.txt_4c_CdEmpresa.Value))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LOOKUP - EMPRESA pelo codigo (SigCdEmp.cemps)
    * Equivalente ao get_cd_empresa.Valid: fAcessoEmpresa(Usuar,'C'...)
    *==========================================================================

    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", ;
            "cursor_4c_BuscaEmp", ;
            "cemps", ;
            ALLTRIM(loc_oPg.txt_4c_CdEmpresa.Value), ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa")
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.cemps)
                loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.razas)
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
        THIS.AtualizarEstadoDsEmpresa()
    ENDPROC

    PROTECTED PROCEDURE ValidarCdEmpresa()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdEmpresa.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DsEmpresa.Value = ""
            THIS.AtualizarEstadoDsEmpresa()
            RETURN
        ENDIF
        loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
        IF loc_nResult > 0
            SELECT cursor_4c_EmpVal
            IF !EOF()
                loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.razas)
            ELSE
                loc_oPg.txt_4c_CdEmpresa.Value = ""
                loc_oPg.txt_4c_DsEmpresa.Value = ""
                THIS.AbrirBuscaEmpresa()
            ENDIF
        ELSE
            loc_oPg.txt_4c_CdEmpresa.Value = ""
            loc_oPg.txt_4c_DsEmpresa.Value = ""
            THIS.AbrirBuscaEmpresa()
        ENDIF
        IF USED("cursor_4c_EmpVal")
            USE IN cursor_4c_EmpVal
        ENDIF
        THIS.AtualizarEstadoDsEmpresa()
    ENDPROC

    *==========================================================================
    * LOOKUP - EMPRESA pela descricao (SigCdEmp.razas - busca reversa)
    * Equivalente ao get_ds_empresa.Valid: fAcessoEmpresa(Usuar,'D'...)
    *==========================================================================

    PROCEDURE AbrirBuscaDsEmpresa()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", ;
            "cursor_4c_BuscaEmpDs", ;
            "razas", ;
            ALLTRIM(loc_oPg.txt_4c_DsEmpresa.Value), ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa")
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpDs")
                loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpDs.cemps)
                loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpDs.razas)
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEmpDs")
            USE IN cursor_4c_BuscaEmpDs
        ENDIF
        THIS.AtualizarEstadoDsEmpresa()
    ENDPROC

    PROTECTED PROCEDURE ValidarDsEmpresa()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsEmpresa.Value)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF
        loc_cSQL = "SELECT TOP 1 cemps, razas FROM SigCdEmp WHERE razas LIKE " + ;
                   EscaparSQL("%" + loc_cValor + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpDsVal")
        IF loc_nResult > 0
            SELECT cursor_4c_EmpDsVal
            IF !EOF()
                loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpDsVal.cemps)
                loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpDsVal.razas)
            ELSE
                THIS.AbrirBuscaDsEmpresa()
            ENDIF
        ELSE
            THIS.AbrirBuscaDsEmpresa()
        ENDIF
        IF USED("cursor_4c_EmpDsVal")
            USE IN cursor_4c_EmpDsVal
        ENDIF
        THIS.AtualizarEstadoDsEmpresa()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita os campos de filtro.
    *   Forms REPORT nao tem modos INCLUIR/ALTERAR como CRUD, mas este metodo
    *   garante que todos os campos de filtro estejam sempre editaveis.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_CdEmpresa.Enabled = par_lHabilitar
            loc_oPg.txt_4c_DtInicial.Enabled  = par_lHabilitar
            loc_oPg.txt_4c_DtFinal.Enabled    = par_lHabilitar
            *-- Descricao da empresa: habilitada apenas quando codigo esta vazio
            IF par_lHabilitar
                THIS.AtualizarEstadoDsEmpresa()
            ELSE
                loc_oPg.txt_4c_DsEmpresa.Enabled = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Compatibilidade com pipeline CRUD.
    *   Forms REPORT nao tem grade de lista. Metodo retorna .T. sem acao.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Compatibilidade com pipeline CRUD.
    *   Forms REPORT nao tem modos de edicao. Botoes do CommandGroup permanecem
    *   sempre no mesmo estado (habilitados). Metodo sem acao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias de FormParaRelatorio() para compatibilidade com pipeline.
    *   Em forms REPORT o BO e o this_oRelatorio; os dados fluem via
    *   FormParaRelatorio() antes de PrepararDados().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Compatibilidade com pipeline CRUD.
    *   Em forms REPORT os dados fluem somente no sentido Form->BO->FRX.
    *   Nao ha retorno de dados do BO para os campos de filtro do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrefcdBO.prg):
*==============================================================================
* SIGREFCDBO.PRG
* Business Object para Relatorio de Informativo de Vendas Diarias (SIGREFCD)
*
* Herda de RelatorioBase
* Referencia legado: sigrefcd.SCX (frmrelatorio)
* Caption original: "Informativo de Vendas Diarias"
*==============================================================================

DEFINE CLASS sigrefcdBO AS RelatorioBase

    *-- Filtros do relatorio (mapeados dos campos get_* do legado)
    this_cCodEmpresa      = ""   && get_cd_empresa  - codigo da empresa (max 3 chars)
    this_cRazaEmpresa     = ""   && get_ds_empresa  - razao social da empresa (max 40 chars)
    this_dDtInicial       = {}   && get_dt_inicial  - data inicial do periodo
    this_dDtFinal         = {}   && get_dt_final    - data final do periodo

    *-- Variaveis de resultado mapeadas das PUBLIC vars do legado
    *-- (m.reslanca, m.resforma, m.rescheque, m.rescartao, m.resvende,
    *--  m.resconta, m.reslanfor, m.resqtdes, m.ResvDets)
    this_lResLanca        = .F.
    this_lResForma        = .F.
    this_lResCheque       = .F.
    this_lResCartao       = .F.
    this_lResVende        = .F.
    this_lResConta        = .F.
    this_lResLanFor       = .F.
    this_lResQtdes        = .F.
    this_lResvDets        = .F.

    *-- Configuracao do relatorio
    this_cTituloRelatorio = ""
    this_cArquivoFRX      = ""
    this_cMensagemErro    = ""

    *--------------------------------------------------------------------------
    * Init - Configura titulo, FRX e carrega cursores auxiliares do legado
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
            IF loc_lSucesso
                THIS.this_cTituloRelatorio = "Informativo de Vendas Di" + CHR(225) + "rias"
                THIS.this_cArquivoFRX      = "SigReFcD"

                *-- Cursor auxiliar de tomadores (usado pelo FRX)
                CREATE CURSOR csSigCdTom (Marca n(1), Descri c(40), Codigos n(2))
                INDEX ON Codigos TAG Codigos

                *-- Cursor de movimento (reutilizado a cada PrepararDados)
                CREATE CURSOR crMovimento (Datas t, Valor N(13,2))
                INDEX ON Datas TAG Datas

                *-- Carrega parametros de operacoes de fechamento (SigCdPam)
                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdPam", "CrSigCdPam")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdPam"
                    loc_lSucesso = .F.
                ELSE
                    *-- Carrega formas de pagamento (SigOpFp)
                    loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigOpFp", "CrSigOpFp")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Falha ao carregar SigOpFp"
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa todas as queries e monta cursores para o relatorio
    * Replica logica do PROCEDURE processamento do legado sigrefcd.SCX
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult
        LOCAL loc_lcEmp, loc_lcOperacao, loc_lcConserto
        LOCAL loc_lcCbEmp, loc_lcTitulo, loc_lcPeriodo
        LOCAL loc_lcEnd1, loc_lcEnd2, loc_lcEnd3
        LOCAL loc_lcQuery
        LOCAL loc_lnValor, loc_lnValPr
        LOCAL pDtI, pDtF, pDtH

        loc_lSucesso = .F.

        TRY
            loc_lcEmp = ALLTRIM(THIS.this_cCodEmpresa)

            *-- Busca dados cadastrais da empresa selecionada
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cemps, razas, endes, numeros, bairs, ceps, cidas, estas, cgcs " + ;
                "FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_lcEmp), ;
                "crSigCdEmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao buscar dados da empresa"
                loc_lSucesso = .F.
            ENDIF

            *-- Monta strings do cabecalho do relatorio
            SELECT crSigCdEmp
            loc_lcCbEmp   = loc_lcEmp + "-" + ALLTRIM(crSigCdEmp.razas)
            loc_lcTitulo  = "Fechamento de Venda Di" + CHR(225) + "ria"
            loc_lcPeriodo = "Per" + CHR(237) + "odo : " + ;
                            DTOC(THIS.this_dDtInicial) + " a " + DTOC(THIS.this_dDtFinal)
            loc_lcEnd1    = ALLTRIM(crSigCdEmp.endes) + " " + ;
                            ALLTRIM(crSigCdEmp.numeros) + " - " + ;
                            ALLTRIM(crSigCdEmp.bairs)
            loc_lcEnd2    = ALLTRIM(crSigCdEmp.ceps) + " " + ;
                            ALLTRIM(crSigCdEmp.cidas) + " " + ;
                            ALLTRIM(crSigCdEmp.estas)
            loc_lcEnd3    = ALLTRIM(crSigCdEmp.cgcs)

            *-- Cursor de cabecalho para o FRX
            IF USED("csCabecalho")
                USE IN csCabecalho
            ENDIF
            CREATE CURSOR csCabecalho ;
                (empresa c(240), titulo c(240), End1 c(240), ;
                 End2 c(240), End3 c(240), PERIODO c(80))
            INSERT INTO csCabecalho ;
                (empresa, titulo, End1, End2, End3, Periodo) ;
                VALUES (loc_lcCbEmp, loc_lcTitulo, loc_lcEnd1, ;
                        loc_lcEnd2, loc_lcEnd3, loc_lcPeriodo)

            *-- Variaveis de data parametrizadas para SQLEXEC com ?pDtI/?pDtF
            pDtI = DATETIME(YEAR(THIS.this_dDtInicial), ;
                            MONTH(THIS.this_dDtInicial), ;
                            DAY(THIS.this_dDtInicial), 0, 0, 0)
            pDtF = DATETIME(YEAR(THIS.this_dDtFinal), ;
                            MONTH(THIS.this_dDtFinal), ;
                            DAY(THIS.this_dDtFinal), 23, 59, 59)
            pDtH = DATETIME(YEAR(DATE()), MONTH(DATE()), DAY(DATE()), 23, 59, 59)

            *-- Obtem operacao de fechamento configurada em SigCdPam
            SELECT CrSigCdPam
            GO TOP
            IF !EOF()
                loc_lcOperacao = ALLTRIM(CrSigCdPam.dopes)
                loc_lcConserto = ALLTRIM(CrSigCdPam.opconsers)
            ELSE
                loc_lcOperacao = ""
                loc_lcConserto = ""
            ENDIF

            IF EMPTY(loc_lcOperacao)
                MsgAviso("N" + CHR(227) + "o existe movimenta" + CHR(231) + ;
                         CHR(227) + "o de fechamento configurada!!!", "Aviso")
            ENDIF

            WAIT WINDOW "Aguarde..." NOWAIT NOCLEAR

            *-- Query 1: dados de vendas gerais (csDadosV)
            *-- Inclui movimentos excluindo fpags especificos (garantia, cortesia, etc.)
            loc_lcQuery = ;
                "SELECT case when g.tipoops = 5 then 'M' else d.Infos end as Infos, " + ;
                "c.datas, c.Emps, c.Dopes, c.Numes, c.empdopnums, " + ;
                "c.cidchaves as chaPar, c.fpags, d.fparcs, c.moefpgs, " + ;
                "case when g.tipoops = 5 then (c.valos*c.cotfpgs) * -1 " + ;
                "     else (c.valos*c.cotfpgs) end as valos, " + ;
                "case when g.tipoops = 5 then c.valos * -1 else c.valos end as valosM, " + ;
                "case when d.infos = 'T' then d.formas else e.descrs end as info, " + ;
                "d.formas, d.valpends, d.trocos, d.bandeira, c.adquirente " + ;
                "FROM sigmvPar c, sigopfp d, sigprinf e, sigcdope g, sigcdtom h " + ;
                "WHERE c.datas BETWEEN ?pDtI AND ?pDtF AND " + ;
                IIF(EMPTY(loc_lcEmp), " ", "c.Emps = '" + loc_lcEmp + "' AND ") + ;
                "g.tipoops = h.codigos AND " + ;
                "h.gergdmis = 1 AND " + ;
                "c.fpags = d.fpags AND " + ;
                "d.infos = e.infos AND " + ;
                "g.relfechas = 1 AND " + ;
                "c.dopes = g.dopes AND " + ;
                "c.fpags NOT IN ('garantia','cortesia','pag efetuado'," + ;
                "'aberto r','credito loja','dev loja') " + ;
                "ORDER BY c.cidchaves"
            loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "csDadosV")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na consulta de vendas (csDadosV)"
                WAIT CLEAR
                loc_lSucesso = .F.
            ENDIF

            *-- Query 2: vendas com pagamento efetuado/aberto r (csDadosP)
            loc_lcQuery = ;
                "SELECT d.Infos, c.datas, c.Emps, c.Dopes, c.Numes, " + ;
                "c.empdopnums, c.cidchaves as chaPar, c.fpags, " + ;
                "(c.valos*c.cotfpgs) as valos, d.fparcs, " + ;
                "case when d.infos = 'T' then d.formas else e.descrs end as info, " + ;
                "d.formas, d.valpends, d.trocos, d.bandeira, c.adquirente " + ;
                "FROM sigmvPar c, sigopfp d, sigprinf e, sigcdope g, sigcdtom h " + ;
                "WHERE c.datas BETWEEN ?pDtI AND ?pDtF AND " + ;
                IIF(EMPTY(loc_lcEmp), " ", "c.Emps = '" + loc_lcEmp + "' AND ") + ;
                "g.tipoops = h.codigos AND " + ;
                "h.gergdmis = 1 AND " + ;
                "g.tipoops <> 5 AND " + ;
                "c.fpags = d.fpags AND " + ;
                "d.infos = e.infos AND " + ;
                "g.opers <> 1 AND " + ;
                "g.relfechas = 1 AND " + ;
                "c.dopes = g.dopes AND " + ;
                "c.fpags IN ('pag efetuado','aberto r') " + ;
                "ORDER BY c.cidchaves"
            loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "csDadosP")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na consulta de pagamentos (csDadosP)"
                WAIT CLEAR
                loc_lSucesso = .F.
            ENDIF

            *-- Query 3: recebimentos (csDadosR)
            loc_lcQuery = ;
                "SELECT DISTINCT d.infos, c.datas, c.Emps, c.Dopes, c.Numes, " + ;
                "c.empdopnums, c.cidchaves as chaPar, c.fpags, " + ;
                "(c.valos*c.cotfpgs) as valos, d.fparcs, " + ;
                "c.valos as valosM, c.moefpgs, " + ;
                "case when d.infos = 'T' then d.formas else e.descrs end as info, " + ;
                "d.formas, d.valpends, d.trocos, d.bandeira, c.adquirente " + ;
                "FROM SigMvccr a, sigmvPar c, sigcdope g, sigcdtom h, " + ;
                "sigopfp d, sigprinf e " + ;
                "WHERE c.datas BETWEEN ?pDtI AND ?pDtF AND " + ;
                IIF(EMPTY(loc_lcEmp), " ", "c.Emps = '" + loc_lcEmp + "' AND ") + ;
                "c.dopes = g.dopes AND " + ;
                "c.dopes = 'RECEBIMENTO' AND " + ;
                "c.nopers = a.nopers AND " + ;
                "g.tipoops = h.codigos AND " + ;
                "g.relfechas = 1 AND " + ;
                "c.fpags = d.fpags AND " + ;
                "d.infos = e.infos " + ;
                "ORDER BY c.cidchaves"
            loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "csDadosR")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na consulta de recebimentos (csDadosR)"
                WAIT CLEAR
                loc_lSucesso = .F.
            ENDIF

            *-- Agrupa csDadosV por datas/chapar -> Curv
            SELECT chapar, Datas, ;
                MAX(Emps) AS Emps, MAX(valos) AS valos, MAX(fparcs) AS fparcs, ;
                MAX(Info) AS Info, MAX(formas) AS formas, MAX(valpends) AS valpends, ;
                MAX(bandeira) AS bandeira, MAX(adquirente) AS adquirente, ;
                MAX(valosM) AS valosM, MAX(moefpgs) AS moefpgs, MAX(Infos) AS Infos ;
                FROM csDadosV GROUP BY Datas, chapar INTO CURSOR Curv

            *-- Cursor vazio Curr com mesma estrutura de csDadosR
            SELECT chapar, Datas, ;
                MAX(Emps) AS Emps, MAX(valos) AS valos, MAX(fparcs) AS fparcs, ;
                MAX(Info) AS Info, MAX(formas) AS formas, MAX(valpends) AS valpends, ;
                MAX(bandeira) AS bandeira, MAX(adquirente) AS adquirente, ;
                MAX(valosM) AS valosM, MAX(moefpgs) AS moefpgs, MAX(Infos) AS Infos ;
                FROM csDadosR WHERE 0=1 GROUP BY Datas, chapar INTO CURSOR Curr

            *-- UNION: categoriza valores em valAv (a vista), valFin (financiado), valRec (recebimento)
            SELECT Infos, Datas, chapar, Emps, Info, formas, bandeira, adquirente, ;
                valos AS valAv, ;
                CAST(0.00 AS numeric(11,2)) AS valFin, ;
                CAST(0.00 AS numeric(11,2)) AS valRec ;
                FROM Curv WHERE fparcs = 1 ;
                UNION ;
                SELECT Infos, Datas, chapar, Emps, Info, formas, bandeira, adquirente, ;
                CAST(0.00 AS numeric(11,2)) AS valAv, ;
                valos AS valFin, ;
                CAST(0.00 AS numeric(11,2)) AS valRec ;
                FROM Curv WHERE !(fparcs = 1) ;
                UNION ;
                SELECT Infos, Datas, chapar, Emps, Info, formas, bandeira, adquirente, ;
                CAST(0.00 AS numeric(11,2)) AS valAv, ;
                CAST(0.00 AS numeric(11,2)) AS valFin, ;
                valos AS valRec ;
                FROM Curr ;
                INTO CURSOR Curt

            *-- Consolida por Infos/Datas/Emps
            SELECT Infos, Datas, Emps, ;
                SUM(valAv) AS valAv, SUM(valFin) AS valFin, SUM(valRec) AS valRec ;
                FROM Curt GROUP BY Datas, Infos, Emps INTO CURSOR curPag

            *-- Adiciona colunas de totalizacao
            SELECT *, valAv + valFin AS valVenda, valAv + valFin + valRec AS valTot ;
                FROM curPag INTO CURSOR curPag

            *-- Totais gerais
            SELECT SUM(valAv) AS valAv, SUM(valFin) AS valFin, ;
                SUM(valRec) AS valRec, SUM(valVenda) AS valVenda, ;
                SUM(valTot) AS valTot ;
                FROM curPag INTO CURSOR curPagT

            *-- Garante crMovimento disponivel e vazio
            IF !USED("crMovimento")
                CREATE CURSOR crMovimento (Datas t, Valor N(13,2))
                INDEX ON Datas TAG Datas
            ENDIF
            ZAP IN crMovimento

            *-- Processa cada linha de curPag aplicando percentuais de SigEmInf
            SELECT curPag
            GO TOP
            SCAN
                *-- Busca percentual por empresa/tipo de informacao
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT PercEmps FROM SigEmInf " + ;
                    "WHERE Emps = '" + ALLTRIM(curPag.Emps) + "'" + ;
                    " AND Infos = '" + ALLTRIM(curPag.Infos) + "'", ;
                    "crInfos")

                loc_lnValor = curPag.valTot

                *-- Aplica percentual se existir configuracao em SigEmInf
                IF loc_nResult > 0
                    SELECT crInfos
                    IF RECCOUNT("crInfos") > 0
                        loc_lnValPr = 0
                        SELECT crInfos
                        SCAN
                            loc_lnValPr = loc_lnValPr + ;
                                          ((loc_lnValor / 100) * crInfos.PercEmps)
                        ENDSCAN
                        loc_lnValor = loc_lnValPr
                    ENDIF
                ENDIF
                IF USED("crInfos")
                    USE IN crInfos
                ENDIF

                *-- Acumula no cursor de movimento
                SELECT crMovimento
                APPEND BLANK
                REPLACE Datas WITH curPag.Datas, ;
                        Valor WITH loc_lnValor IN crMovimento

                SELECT curPag
            ENDSCAN

            *-- Agrega movimento por data (consolida multiplas empresas/tipos)
            SELECT crMovimento
            SELECT datas, SUM(valor) AS Valor ;
                FROM crMovimento GROUP BY datas INTO CURSOR csMovimento READWRITE

            *-- Reconstroi crMovimento com dados consolidados
            ZAP IN crMovimento

            SELECT csMovimento
            GO TOP
            SCAN
                SELECT crMovimento
                APPEND BLANK
                REPLACE Datas WITH csMovimento.Datas, ;
                        Valor WITH csMovimento.Valor IN crMovimento
                SELECT csMovimento
            ENDSCAN

            IF USED("csMovimento")
                USE IN csMovimento
            ENDIF

            *-- Posiciona em crMovimento para o FRX
            SELECT crMovimento
            GO TOP

            WAIT CLEAR

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message, "Erro em PrepararDados")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime o relatorio (com dialogo de impressora)
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM SigReFcD TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM SigReFcD PREVIEW
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem do ultimo erro ocorrido
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Operacoes CRUD - NAO APLICAVEIS a este BO
    * Este BO herda de RelatorioBase (formulario frmrelatorio).
    * Relatorios apenas leem dados para imprimir/visualizar via PrepararDados().
    * Os metodos abaixo existem apenas para satisfazer contratos genericos e
    * sinalizar explicitamente que a operacao nao se aplica a relatorios.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + ;
                                  CHR(227) + "o aplic" + CHR(225) + "vel: " + ;
                                  "relat" + CHR(243) + "rio n" + CHR(227) + ;
                                  "o carrega registro para edi" + CHR(231) + ;
                                  CHR(227) + "o."
        RETURN .F.
    ENDPROC

    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o Inserir " + ;
                                  "n" + CHR(227) + "o se aplica a relat" + ;
                                  CHR(243) + "rios."
        RETURN .F.
    ENDPROC

    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o Atualizar " + ;
                                  "n" + CHR(227) + "o se aplica a relat" + ;
                                  CHR(243) + "rios."
        RETURN .F.
    ENDPROC

ENDDEFINE

