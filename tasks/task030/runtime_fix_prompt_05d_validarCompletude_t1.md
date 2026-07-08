# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[Formsigreani.prg] Procedure vazia (sem codigo): ConfigurarPaginaDados

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreani.prg):
*==============================================================================
* FORMSIGREANI.PRG
* Relatorio de Aniversariantes - Formulario de Filtros
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREANI.SCX (frmrelatorio)
*
* Filtros:
*   - Periodo: txt_4c_DtInicial (get_dt_inicial) e txt_4c_DtFinal (get_dt_final)
*     Somente dia/mes sao considerados - ano e ignorado no processamento do BO
*
* Posicoes originais (relativas ao form Width=800, Height=300):
*   lbl_periodo   : Top=172, Left=333, Caption="Periodo :"
*   get_dt_inicial: Top=168, Left=384, Width=45, InputMask="99/99"
*   lbl_a (a-grave): Top=172, Left=433
*   get_dt_final  : Top=168, Left=444, Width=45, InputMask="99/99"
*
* PageFrame.Top=85 -> posicoes em Page1 = posicao_original - 85
*==============================================================================

DEFINE CLASS Formsigreani AS FormBase

    *-- Dimensoes exatas do original: Width=800, Height=300
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
    * InicializarForm - Cria estrutura visual do formulario de relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Aniversariantes"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("sigreaniBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigreaniBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                THIS.LimparCampos()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
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
    *   Width = THIS.Width para cobrir toda a faixa superior (sem faixa clara).
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
                .Caption   = "Relat" + CHR(243) + "rio de Aniversariantes"
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
                .Caption   = "Relat" + CHR(243) + "rio de Aniversariantes"
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
    * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
    *   Geometria EXATA do framework frmrelatorio (regras criticas):
    *     Top=0, Left=529, Width=273, Height=80, ButtonCount=4
    *     Lefts dos botoes: 5 / 71 / 137 / 203 (incrementos de 66)
    *   btnReport.Left=526 no original -> arredondado para 529.
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
    *   Form: Width=800, Height=300
    *   Cabecalho: Height=80
    *   PageFrame: Top=85, Height=300-85=215
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
    * ConfigurarPaginaLista - Filtros de periodo (unica pagina do relatorio)
    *   Posicoes em Page1 = posicao_original - PageFrame.Top(85):
    *   lbl_periodo   (Top=172) -> Page1.Top = 87, Left=333
    *   txt_4c_DtInicial (Top=168) -> Page1.Top = 83, Left=384, Width=45
    *   lbl_4c_LblA   (Top=172) -> Page1.Top = 87, Left=433
    *   txt_4c_DtFinal   (Top=168) -> Page1.Top = 83, Left=444, Width=45
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Label "Periodo :" (lbl_periodo: Left=333, Top=172)
        loc_oPg.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPg.lbl_4c_Periodo
            .Top       = 87
            .Left      = 333
            .AutoSize  = .T.
            .Caption   = "Periodo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Data Inicial (get_dt_inicial: Left=384, Top=168, Width=45, InputMask="99/99")
        *   Value=DATE() (inicializado em LimparCampos) - somente DD/MM e usado
        loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPg.txt_4c_DtInicial
            .Top           = 83
            .Left          = 384
            .Width         = 45
            .Height        = 23
            .Value         = {}
            .Format        = "K9"
            .InputMask     = "99/99"
            .MaxLength     = 5
            .Alignment     = 0
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 9
            .FontBold      = .F.
            .FontItalic    = .F.
            .FontUnderline = .F.
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label separador "a grave" (lbl_a: Left=433, Top=172) - preposicao "a"
        loc_oPg.AddObject("lbl_4c_LblA", "Label")
        WITH loc_oPg.lbl_4c_LblA
            .Top       = 87
            .Left      = 433
            .AutoSize  = .T.
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Data Final (get_dt_final: Left=444, Top=168, Width=45, InputMask="99/99")
        loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPg.txt_4c_DtFinal
            .Top           = 83
            .Left          = 444
            .Width         = 45
            .Height        = 23
            .Value         = {}
            .Format        = "K9"
            .InputMask     = "99/99"
            .MaxLength     = 5
            .Alignment     = 0
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 9
            .FontBold      = .F.
            .FontItalic    = .F.
            .FontUnderline = .F.
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- KeyPress: ESC(27) restaura data inicial/final para hoje
        BINDEVENT(loc_oPg.txt_4c_DtInicial, "KeyPress", THIS, "TeclaDataInicial")
        BINDEVENT(loc_oPg.txt_4c_DtFinal,   "KeyPress", THIS, "TeclaDataFinal")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Nao utilizado em form REPORT de periodo simples
    *   Mantido para compatibilidade com o pipeline multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Form REPORT com filtro de periodo unico: todos os campos estao em ConfigurarPaginaLista
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura filtros de data para a data de hoje
    *   Original: thisform.get_dt_inicial.value = date() / thisform.get_dt_final.value = date()
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        TRY
            THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value = DATE()
            THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value   = DATE()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia datas dos controles para propriedades do BO
    *   BO usa DAY() e MONTH() para extrair dia/mes - ano e irrelevante
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dDtInicial = loc_oPg.txt_4c_DtInicial.Value
            .this_dDtFinal   = loc_oPg.txt_4c_DtFinal.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Verifica se ambas as datas do periodo foram preenchidas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_oPg, loc_lValido
        loc_lValido = .F.
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF EMPTY(loc_oPg.txt_4c_DtInicial.Value)
                MsgInfo("Informe a data inicial do per" + CHR(237) + "odo.", ;
                    "Filtro Obrigat" + CHR(243) + "rio")
            ELSE
                IF EMPTY(loc_oPg.txt_4c_DtFinal.Value)
                    MsgInfo("Informe a data final do per" + CHR(237) + "odo.", ;
                        "Filtro Obrigat" + CHR(243) + "rio")
                ELSE
                    loc_lValido = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLADO (PUBLIC - contrato BINDEVENT)
    * ESC(27) restaura data para hoje; demais teclas passam pelo VFP normalmente
    *==========================================================================

    PROCEDURE TeclaDataInicial(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value = DATE()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDataFinal(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value = DATE()
        ENDIF
    ENDPROC

    *==========================================================================
    * ACOES DOS BOTOES DO RELATORIO
    *==========================================================================

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lValido
        loc_lValido = .F.
        TRY
            loc_lValido = THIS.ValidarFiltros()
            IF loc_lValido
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Visualizar()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
                ELSE
                    THIS.this_oRelatorio.RegistrarAuditoria("VISUALIZAR")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnImprimirClick()
        LOCAL loc_lValido
        loc_lValido = .F.
        TRY
            loc_lValido = THIS.ValidarFiltros()
            IF loc_lValido
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Imprimir()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
                ELSE
                    THIS.this_oRelatorio.RegistrarAuditoria("IMPRIMIR")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnExcelClick()
        LOCAL loc_lValido
        loc_lValido = .F.
        TRY
            loc_lValido = THIS.ValidarFiltros()
            IF loc_lValido
                THIS.FormParaRelatorio()
                IF PEMSTATUS(THIS.this_oRelatorio, "ExportarExcel", 5)
                    IF !THIS.this_oRelatorio.ExportarExcel()
                        MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Excel")
                    ELSE
                        THIS.this_oRelatorio.RegistrarAuditoria("EXCEL")
                    ENDIF
                ELSE
                    MsgInfo("Exporta" + CHR(231) + CHR(227) + "o para Excel n" + CHR(227) + ;
                        "o implementada para este relat" + CHR(243) + "rio.", ;
                        "Recurso n" + CHR(227) + "o dispon" + CHR(237) + "vel")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * MAPEAMENTO CRUD -> REPORT (aliases para compatibilidade com pipeline)
    *==========================================================================

    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        MsgInfo("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + ;
            CHR(237) + "vel em relat" + CHR(243) + "rios." + CHR(13) + ;
            "Use Visualizar ou Imprimir para gerar o relat" + CHR(243) + "rio.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
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

    PROCEDURE BtnCancelarClick()
        TRY
            THIS.LimparCampos()
            IF VARTYPE(THIS.pgf_4c_Paginas.Page1) = "O"
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_DtInicial", 5)
                    THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                IF !EMPTY(.this_dDtInicial)
                    loc_oPg.txt_4c_DtInicial.Value = .this_dDtInicial
                ENDIF
                IF !EMPTY(.this_dDtFinal)
                    loc_oPg.txt_4c_DtFinal.Value = .this_dDtFinal
                ENDIF
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lHab
        TRY
            loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O"
                IF PEMSTATUS(loc_oPg, "txt_4c_DtInicial", 5)
                    loc_oPg.txt_4c_DtInicial.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DtFinal", 5)
                    loc_oPg.txt_4c_DtFinal.ReadOnly = !loc_lHab
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    PROCEDURE AjustarBotoesPorModo()
        TRY
            IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
                THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        TRY
            loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
            IF loc_nPagina < 1 OR loc_nPagina > THIS.pgf_4c_Paginas.PageCount
                loc_nPagina = 1
            ENDIF
            THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_DtInicial", 5)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO
    *   RelatorioBase herda de Custom (sem Release()) - usar .NULL. para liberar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigreaniBO.prg):
*==============================================================================
* SIGREANIBO.PRG  (sigreaniBO.prg)
* Business Object para Relatorio de Aniversariantes
* Herda de RelatorioBase
*
* Tabelas: SigCdCli (clientes - aniversarios/casamentos/conjuges)
*          SigCdCe  (empresas  - socios e conjuges de socios)
*          SigCdEmp (cabecalho - razao social da empresa)
* Filtros: DtInicial e DtFinal (somente dia/mes importam)
*
* Logica de PrepararDados:
*   1. Extrai dia/mes e converte para MMDD para comparar com dmnascs/dmcasas/dmconjs
*   2. Busca SigCdCli com aniversario/casamento/conjuge no intervalo MMDD
*   3. Cria cursor_4c_Dados com estrutura identica ao CsRelatorio original
*   4. Para cada cliente: inclui linha de aniversario e linha de conjuge (se aplicavel)
*   5. Busca SigCdCe e inclui socios (DtNasc1s-3s) e conjuges (DtnConj1-3)
*   6. Ordena por MMDD+Iclis via INDEX TAG Impressao
*==============================================================================

DEFINE CLASS sigreaniBO AS RelatorioBase

    *-- Filtros do relatorio (somente dia/mes importam, ano e ignorado)
    this_dDtInicial         = {}
    this_dDtFinal           = {}

    *-- Cursores utilizados pelo relatorio
    this_cCursorDados       = "cursor_4c_Dados"
    this_cCursorCabecalho   = "cursor_4c_Cabecalho"

    *-- Configuracao do relatorio
    this_cFRXPath           = ""
    this_cTituloRel         = ""
    this_cSubTitulo         = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF DODEFAULT()
                IF TYPE("gc_4c_CaminhoReports") = "U"
                    gc_4c_CaminhoReports = ""
                ENDIF
                THIS.this_cFRXPath   = gc_4c_CaminhoReports + "RelSigReAni.frx"
                THIS.this_cTituloRel = "Relat" + CHR(243) + "rio de Aniversariantes"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreaniBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor_4c_Dados e cursor_4c_Cabecalho para o relatorio
    * Replica a logica do PROCEDURE processamento do SCX original:
    *   - Converte datas para MMDD e filtra por dmnascs/dmcasas/dmconjs
    *   - Processa clientes (aniversario + conjuge)
    *   - Processa socios e conjuges de socios via SigCdCe
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL
        LOCAL loc_lnDIni, loc_lnMIni, loc_lnDFin, loc_lnMFin
        LOCAL loc_cMmddIni, loc_cMmddFin
        LOCAL loc_lcCbEmpresa, loc_lcCbPeriodo
        LOCAL loc_nX, loc_cNome, loc_cDNasc

        loc_lSucesso = .F.

        TRY
            *-- Validar filtros obrigatorios
            IF EMPTY(THIS.this_dDtInicial) OR EMPTY(THIS.this_dDtFinal)
                THIS.this_cMensagemErro = "Informe o per" + CHR(237) + "odo inicial e final"
                loc_lSucesso = .F.
            ENDIF

            *-- Extrair dia e mes das datas filtro
            loc_lnDIni = DAY(THIS.this_dDtInicial)
            loc_lnMIni = MONTH(THIS.this_dDtInicial)
            loc_lnDFin = DAY(THIS.this_dDtFinal)
            loc_lnMFin = MONTH(THIS.this_dDtFinal)

            *-- Converter para formato MMDD (mesmo formato de dmnascs/dmcasas/dmconjs)
            loc_cMmddIni = PADL(TRANSFORM(loc_lnMIni), 2, "0") + PADL(TRANSFORM(loc_lnDIni), 2, "0")
            loc_cMmddFin = PADL(TRANSFORM(loc_lnMFin), 2, "0") + PADL(TRANSFORM(loc_lnDFin), 2, "0")

            *-- Limpar cursores de execucao anterior
            THIS.LimparCursores()

            *-- Buscar razao social da empresa para o cabecalho
            loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Empresa")
            IF loc_nResult > 0
                SELECT cursor_4c_Empresa
                IF !EOF()
                    loc_lcCbEmpresa = ALLTRIM(Razas)
                ELSE
                    loc_lcCbEmpresa = ""
                ENDIF
                USE IN cursor_4c_Empresa
            ELSE
                loc_lcCbEmpresa = ""
            ENDIF

            *-- Montar descricao do periodo para cabecalho
            loc_lcCbPeriodo = "Per" + CHR(237) + "odo: " + ;
                              PADL(TRANSFORM(loc_lnDIni), 2, "0") + "/" + ;
                              PADL(TRANSFORM(loc_lnMIni), 2, "0") + ;
                              " " + CHR(224) + " " + ;
                              PADL(TRANSFORM(loc_lnDFin), 2, "0") + "/" + ;
                              PADL(TRANSFORM(loc_lnMFin), 2, "0")

            *-- Criar cursor de cabecalho do relatorio
            CREATE CURSOR cursor_4c_Cabecalho (cb_empresa C(80), cb_titulo C(80), cb_periodo C(80))
            INSERT INTO cursor_4c_Cabecalho (cb_empresa, cb_titulo, cb_periodo) ;
                   VALUES (loc_lcCbEmpresa, ;
                           "Rela" + CHR(231) + CHR(227) + "o de Aniversariantes", ;
                           loc_lcCbPeriodo)

            *-- Buscar clientes com aniversario/casamento/conjuge no intervalo MMDD
            loc_cSQL = "SELECT * FROM SigCdCli WHERE " + ;
                       "(dmnascs >= " + EscaparSQL(loc_cMmddIni) + ;
                       " AND dmnascs <= " + EscaparSQL(loc_cMmddFin) + ")" + ;
                       " OR (dmcasas >= " + EscaparSQL(loc_cMmddIni) + ;
                       " AND dmcasas <= " + EscaparSQL(loc_cMmddFin) + ")" + ;
                       " OR (dmconjs >= " + EscaparSQL(loc_cMmddIni) + ;
                       " AND dmconjs <= " + EscaparSQL(loc_cMmddFin) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliSource")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar clientes aniversariantes"
                loc_lSucesso = .F.
            ENDIF

            *-- Criar cursor de resultado com mesma estrutura do CsRelatorio original
            CREATE CURSOR cursor_4c_Dados (Emps C(3), mes N(2), dia N(2), Iclis C(10), ;
                                           Rclis C(40), Endes C(60), Bairs C(40), ;
                                           Ceps C(9), Cidas C(30), Estas C(2), ;
                                           Tel1s C(20), Faxs C(20), Nascs D, ;
                                           emails C(50), ContaVens C(10))
            INDEX ON PADL(TRANSFORM(mes),2,"0") + PADL(TRANSFORM(dia),2,"0") + Iclis TAG Impressao

            *-- Processar clientes: aniversario proprio e aniversario do conjuge
            SELECT cursor_4c_CliSource
            SCAN
                SCATTER MEMVAR

                *-- Aniversario do cliente
                IF BETWEEN(DAY(m.Nascs), loc_lnDIni, loc_lnDFin) AND ;
                   BETWEEN(MONTH(m.Nascs), loc_lnMIni, loc_lnMFin)
                    m.mes = MONTH(m.Nascs)
                    m.dia = DAY(m.Nascs)
                    SELECT cursor_4c_Dados
                    APPEND BLANK
                    GATHER MEMVAR
                ENDIF

                *-- Aniversario do conjuge do cliente
                IF BETWEEN(DAY(m.dtncons), loc_lnDIni, loc_lnDFin) AND ;
                   BETWEEN(MONTH(m.dtncons), loc_lnMIni, loc_lnMFin) AND ;
                   !EMPTY(m.conjuges)
                    m.mes   = MONTH(m.dtncons)
                    m.dia   = DAY(m.dtncons)
                    m.Rclis = m.conjuges
                    m.Nascs = m.dtncons
                    SELECT cursor_4c_Dados
                    APPEND BLANK
                    GATHER MEMVAR
                ENDIF

                SELECT cursor_4c_CliSource
            ENDSCAN

            IF USED("cursor_4c_CliSource")
                USE IN cursor_4c_CliSource
            ENDIF

            *-- Buscar socios/empresas para processar aniversarios de socios e seus conjuges
            loc_cSQL = "SELECT * FROM SigCdCe"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CeSource")
            IF loc_nResult > 0
                SELECT cursor_4c_CeSource
                INDEX ON Iclis TAG Iclis

                SELECT cursor_4c_CeSource
                SCAN
                    SCATTER MEMVAR

                    *-- Verificar aniversarios dos 3 socios (Socio1s/DtNasc1s ate Socio3s/DtNasc3s)
                    FOR loc_nX = 1 TO 3
                        loc_cNome  = "m.Socio"  + TRANSFORM(loc_nX) + "s"
                        loc_cDNasc = "m.DtNasc" + TRANSFORM(loc_nX) + "s"

                        IF BETWEEN(DAY(&loc_cDNasc.), loc_lnDIni, loc_lnDFin) AND ;
                           BETWEEN(MONTH(&loc_cDNasc.), loc_lnMIni, loc_lnMFin) AND ;
                           !EMPTY(&loc_cNome.)

                            IF !USED("cursor_4c_TmpCli")
                                loc_cSQL = "SELECT * FROM SigCdCli WHERE Iclis = " + ;
                                           EscaparSQL(ALLTRIM(cursor_4c_CeSource.Iclis))
                                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli")
                            ENDIF

                            IF USED("cursor_4c_TmpCli")
                                SELECT cursor_4c_TmpCli
                                SCATTER MEMVAR
                                m.mes   = MONTH(&loc_cDNasc.)
                                m.dia   = DAY(&loc_cDNasc.)
                                m.Rclis = &loc_cNome.
                                m.Nascs = &loc_cDNasc.
                                SELECT cursor_4c_Dados
                                APPEND BLANK
                                GATHER MEMVAR
                            ENDIF
                        ENDIF
                    NEXT

                    *-- Verificar aniversarios dos conjuges dos socios (Conj1s/DtnConj1 ate Conj3s/DtnConj3)
                    FOR loc_nX = 1 TO 3
                        loc_cNome  = "m.Conj"   + TRANSFORM(loc_nX) + "s"
                        loc_cDNasc = "m.DtnConj" + TRANSFORM(loc_nX)

                        IF BETWEEN(DAY(&loc_cDNasc.), loc_lnDIni, loc_lnDFin) AND ;
                           BETWEEN(MONTH(&loc_cDNasc.), loc_lnMIni, loc_lnMFin) AND ;
                           !EMPTY(&loc_cNome.)

                            IF !USED("cursor_4c_TmpCli")
                                loc_cSQL = "SELECT * FROM SigCdCli WHERE Iclis = " + ;
                                           EscaparSQL(ALLTRIM(cursor_4c_CeSource.Iclis))
                                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli")
                            ENDIF

                            IF USED("cursor_4c_TmpCli")
                                SELECT cursor_4c_TmpCli
                                SCATTER MEMVAR
                                m.mes   = MONTH(&loc_cDNasc.)
                                m.dia   = DAY(&loc_cDNasc.)
                                m.Rclis = &loc_cNome.
                                m.Nascs = &loc_cDNasc.
                                SELECT cursor_4c_Dados
                                APPEND BLANK
                                GATHER MEMVAR
                            ENDIF
                        ENDIF
                    NEXT

                    IF USED("cursor_4c_TmpCli")
                        USE IN cursor_4c_TmpCli
                    ENDIF

                    SELECT cursor_4c_CeSource
                ENDSCAN

                IF USED("cursor_4c_CeSource")
                    USE IN cursor_4c_CeSource
                ENDIF
            ENDIF

            *-- Posicionar no inicio do cursor de resultado para o REPORT FORM
            SELECT cursor_4c_Dados
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "PrepararDados")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF !FILE(THIS.this_cFRXPath)
                    THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + "rio n" + ;
                                              CHR(227) + "o encontrado: " + THIS.this_cFRXPath
                    loc_lSucesso = .F.
                ENDIF
                REPORT FORM (THIS.this_cFRXPath) TO PRINTER NOCONSOLE
                THIS.LimparCursores()
                THIS.this_cMensagemErro = ""
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Imprimir")
            THIS.this_cMensagemErro = loc_oErro.Message
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
                IF !FILE(THIS.this_cFRXPath)
                    THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + "rio n" + ;
                                              CHR(227) + "o encontrado: " + THIS.this_cFRXPath
                    loc_lSucesso = .F.
                ENDIF
                REPORT FORM (THIS.this_cFRXPath) PREVIEW NOCONSOLE
                THIS.LimparCursores()
                THIS.this_cMensagemErro = ""
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Visualizar")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha cursores do relatorio se estiverem abertos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCursores()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED(THIS.this_cCursorCabecalho)
            USE IN (THIS.this_cCursorCabecalho)
        ENDIF
        IF USED("cursor_4c_CliSource")
            USE IN cursor_4c_CliSource
        ENDIF
        IF USED("cursor_4c_CeSource")
            USE IN cursor_4c_CeSource
        ENDIF
        IF USED("cursor_4c_TmpCli")
            USE IN cursor_4c_TmpCli
        ENDIF
        IF USED("cursor_4c_Empresa")
            USE IN cursor_4c_Empresa
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    * Stub para compatibilidade com RelatorioBase.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * BOs de Relatorio populam dados via PrepararDados() -> cursor_4c_Dados,
    * nao precisam carregar registro individual do cursor.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * Relatorios sao somente-leitura: nao inserem registros no banco.
    * Operacao real e executada por Visualizar()/Imprimir().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * Relatorios sao somente-leitura: nao atualizam registros no banco.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * Relatorios sao somente-leitura: nao excluem registros no banco.
    *--------------------------------------------------------------------------
    PROCEDURE ExecutarExclusao()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Relatorios nao geram registros de auditoria
    * Override do RelatorioBase para deixar explicito.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursores abertos pelo relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        DODEFAULT()
    ENDPROC

ENDDEFINE

