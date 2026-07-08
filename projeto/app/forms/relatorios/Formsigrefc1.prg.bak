*==============================================================================
* FORMSIGREFC1.PRG
* Relat" + CHR(243) + "rio Fechamento de Caixa
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREFC1.SCX (frmrelatorio)
*
* Filtros:
*   - Empresa  (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - SigCdEmp)
*   - Per" + CHR(237) + "odo  (data inicial / data final)
*   - Tipo     (Vis" + CHR(227) + "o detalhada / Mapa de Fechamento)
*
* Bot" + CHR(245) + "es: Visualizar / Imprimir / Excel / Encerrar
*
* Fase 8/8 - Consolidacao Final (concluido)
*==============================================================================

DEFINE CLASS Formsigrefc1 AS FormBase

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
    * InicializarForm - Cria estrutura base do formulario de relatorio
    *   1. Define Caption / Picture (fundo)
    *   2. Cria sigrefc1BO e carrega filtros iniciais (pula em modo UI)
    *   3. Monta cabecalho escuro + botoes + PageFrame com filtros
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

            *-- Instanciar BO (pula se estiver validando UI sem conexao SQL)
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.this_oRelatorio = CREATEOBJECT("sigrefc1BO")
                IF VARTYPE(THIS.this_oRelatorio) != "O"
                    MsgErro("Erro ao criar sigrefc1BO" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Cabecalho escuro com titulo (equivalente ao cntSombra legado)
                THIS.ConfigurarCabecalho()

                *-- CommandGroup dos botoes do relatorio
                THIS.ConfigurarBotoes()

                *-- PageFrame com 1 pagina de filtros
                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Campos de filtro na Page1 + OptionGroup + BINDEVENTs
                THIS.ConfigurarPaginaLista()

                *-- Vincular Click dos botoes do relatorio
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                *-- Valores iniciais dos campos de filtro
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
    *   Largura = Width do form (cobre toda a faixa superior).
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

            *-- Sombra (deslocada 2px para efeito 3D do texto branco)
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

            *-- Titulo em branco (sobre a sombra)
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
    * ConfigurarBotoes - CommandGroup de botoes do relatorio (btnReport area)
    *   Original: btnReport.Left=534, Top=0
    *   Botoes: Visualiza(5), Imprime(71), DocExcel(137), Sair(203) - W=65 cada
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

            *-- Visualizar (preview em tela)
            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .Caption         = "Visualizar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
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

            *-- Imprimir (impressora)
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

            *-- Excel (exportar dados)
            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "\<Arquivos Email"
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Arquivos Email"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Encerrar (fechar form - ESC)
            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Encerrar"
                .WordWrap        = .T.
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
    *   Abaixo do cabecalho (top=85) ate o fim do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        loc_oPgf.PageCount = 1

        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

        *-- Configurar Page1 (FORA de WITH - referencia direta)
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
    * ConfigurarPaginaLista - Adiciona campos de filtro na Page1
    *   Posicoes originais (form flat 800x300) menos offset PageFrame (top=85):
    *     Empresa:  top=120 -> 35  | Periodo: top=145 -> 60
    *     TpRel:    top=174 -> 89
    *   Chama ConfigurarPaginaDados() ao final para OptionGroup + BINDEVENTs.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Label "Empresa :"
        loc_oPg.AddObject("lbl_4c_LblEmpresa", "Label")
        WITH loc_oPg.lbl_4c_LblEmpresa
            .Top       = 38
            .Left      = 214
            .Width     = 48
            .Height    = 15
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Codigo da empresa (MaxLength=3, uppercase - original Format="K!")
        loc_oPg.AddObject("txt_4c_CdEmpresa", "TextBox")
        WITH loc_oPg.txt_4c_CdEmpresa
            .Top           = 35
            .Left          = 267
            .Width         = 31
            .Height        = 23
            .Value         = ""
            .MaxLength     = 3
            .InputMask     = "!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Descricao da empresa (readonly, preenchida pelo lookup)
        loc_oPg.AddObject("txt_4c_DsEmpresa", "TextBox")
        WITH loc_oPg.txt_4c_DsEmpresa
            .Top           = 35
            .Left          = 300
            .Width         = 289
            .Height        = 23
            .Value         = ""
            .MaxLength     = 40
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Label "Periodo :"
        loc_oPg.AddObject("lbl_4c_LblPeriodo", "Label")
        WITH loc_oPg.lbl_4c_LblPeriodo
            .Top       = 63
            .Left      = 219
            .Width     = 48
            .Height    = 15
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Data inicial (original: get_dt_inicial, Left=267, Top=145)
        loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPg.txt_4c_DtInicial
            .Top           = 60
            .Left          = 267
            .Width         = 80
            .Height        = 23
            .Value         = {}
            .Format        = "D"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Separador "a" entre datas (original: Say1, Left=351, Caption="a")
        loc_oPg.AddObject("lbl_4c_SepDatas", "Label")
        WITH loc_oPg.lbl_4c_SepDatas
            .Top       = 63
            .Left      = 351
            .Width     = 10
            .Height    = 15
            .Caption   = "a"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Data final (original: get_dt_final, Left=364, Top=145)
        loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPg.txt_4c_DtFinal
            .Top           = 60
            .Left          = 364
            .Width         = 80
            .Height        = 23
            .Value         = {}
            .Format        = "D"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Label "Tipo :" (original: Say3, Left=235, Top=179)
        loc_oPg.AddObject("lbl_4c_LblTipo", "Label")
        WITH loc_oPg.lbl_4c_LblTipo
            .Top       = 94
            .Left      = 235
            .Width     = 30
            .Height    = 15
            .Caption   = "Tipo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup e BINDEVENTs adicionados em ConfigurarPaginaDados
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Adiciona OptionGroup TpRel e vincula BINDEVENTs
    *   Em forms CRUD popularia a Page2 (campos de dados para edicao).
    *   Neste form de RELATORIO, completa a Page1 com o OptionGroup de tipo
    *   e vincula handlers de teclado/clique nos campos de filtro.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- OptionGroup TpRel (original: ButtonCount=2, Top=174, Left=256)
        loc_oPg.AddObject("opt_4c_TpRel", "OptionGroup")
        loc_oPg.opt_4c_TpRel.ButtonCount = 2
        WITH loc_oPg.opt_4c_TpRel
            .Top         = 89
            .Left        = 256
            .Width       = 155
            .Height      = 47
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.opt_4c_TpRel.Buttons(1)
            .Caption   = "Vis" + CHR(227) + "o detalhada"
            .Left      = 7
            .Top       = 5
            .Width     = 94
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_TpRel.Buttons(2)
            .Caption   = "Mapa de Fechamento"
            .Left      = 7
            .Top       = 26
            .Width     = 121
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        loc_oPg.opt_4c_TpRel.Value = 1

        *-- Vincular handlers de teclado (F4=115, ENTER=13, TAB=9)
        BINDEVENT(loc_oPg.txt_4c_CdEmpresa, "KeyPress", THIS, "TeclaCdEmpresa")
        BINDEVENT(loc_oPg.txt_4c_DsEmpresa, "KeyPress", THIS, "TeclaDsEmpresa")
        BINDEVENT(loc_oPg.txt_4c_DtInicial, "KeyPress", THIS, "TeclaDataInicial")
        BINDEVENT(loc_oPg.txt_4c_DtFinal,   "KeyPress", THIS, "TeclaDataFinal")

        *-- DblClick tambem abre lookup de empresa
        BINDEVENT(loc_oPg.txt_4c_CdEmpresa, "DblClick", THIS, "AbrirBuscaCdEmpresa")
        BINDEVENT(loc_oPg.txt_4c_DsEmpresa, "DblClick", THIS, "AbrirBuscaDsEmpresa")
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura filtros para valores padrao.
    *   Empresa = empresa logada (go_4c_Sistema), datas = hoje, tipo = 1.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg, loc_cEmpresa, loc_cSQL, loc_nRes
        TRY
            loc_oPg      = THIS.pgf_4c_Paginas.Page1
            loc_cEmpresa = ""
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_cEmpresa = ALLTRIM(THIS.this_oRelatorio.this_cCodEmpresa)
            ENDIF
            loc_oPg.txt_4c_CdEmpresa.Value = loc_cEmpresa
            loc_oPg.txt_4c_DsEmpresa.Value = ""
            IF !EMPTY(loc_cEmpresa)
                loc_cSQL = "SELECT TOP 1 Razas FROM SigCdEmp WHERE Cemps = " + ;
                    EscaparSQL(loc_cEmpresa)
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpInit")
                IF loc_nRes > 0
                    SELECT cursor_4c_EmpInit
                    IF !EOF()
                        loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpInit.Razas)
                    ENDIF
                ENDIF
                IF USED("cursor_4c_EmpInit")
                    USE IN cursor_4c_EmpInit
                ENDIF
            ENDIF
            loc_oPg.txt_4c_DtInicial.Value = DATE()
            loc_oPg.txt_4c_DtFinal.Value   = DATE()
            loc_oPg.opt_4c_TpRel.Value     = 1
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Ativa pagina no PageFrame (1 pagina neste relatorio).
    *   Reposiciona foco no campo Empresa apos retornar ao filtro.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_oPgf, loc_oPg
        TRY
            loc_oPgf = THIS.pgf_4c_Paginas
            IF VARTYPE(loc_oPgf) = "O"
                loc_oPgf.ActivePage = 1
                loc_oPg = loc_oPgf.Pages(1)
                IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c_CdEmpresa", 5)
                    loc_oPg.txt_4c_CdEmpresa.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AlternarPagina")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos controles para propriedades do BO.
    *   Equivalente ao bloco de coleta de filtros do form legado SIGREFC1.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_cCodEmpresa = ALLTRIM(loc_oPg.txt_4c_CdEmpresa.Value)
            .this_cDesEmpresa = ALLTRIM(loc_oPg.txt_4c_DsEmpresa.Value)
            .this_dDtInicial  = loc_oPg.txt_4c_DtInicial.Value
            .this_dDtFinal    = loc_oPg.txt_4c_DtFinal.Value
            .this_nTpRel      = loc_oPg.opt_4c_TpRel.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarPeriodo - Verifica data final >= data inicial.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarPeriodo()
        LOCAL loc_oPg, loc_dIni, loc_dFim
        loc_oPg  = THIS.pgf_4c_Paginas.Page1
        loc_dIni = loc_oPg.txt_4c_DtInicial.Value
        loc_dFim = loc_oPg.txt_4c_DtFinal.Value
        IF !EMPTY(loc_dIni) AND !EMPTY(loc_dFim) AND loc_dIni > loc_dFim
            MsgAviso("Data Final Menor Que a Inicial!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_DtFinal.SetFocus()
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza relatorio em preview na tela
    *   Chama Visualizar() PUBLIC do BO (que internamente chama PrepararDados
    *   PROTECTED + REPORT FORM PREVIEW). NAO chamar PrepararDados diretamente.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF !THIS.ValidarPeriodo()
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Visualizar()
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
    *   Chama Imprimir() PUBLIC do BO (que internamente chama PrepararDados
    *   PROTECTED + REPORT FORM TO PRINTER). NAO chamar PrepararDados diretamente.
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF !THIS.ValidarPeriodo()
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Imprimir()
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
    * BtnExcelClick - Exporta relatorio para arquivo XLS
    *   Chama GerarExcel() PUBLIC do BO (que internamente chama PrepararDados
    *   PROTECTED + REPORT FORM TO FILE). NAO chamar PrepararDados diretamente.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF !THIS.ValidarPeriodo()
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.GerarExcel()
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
    * MAPEAMENTO CRUD -> REPORT
    * Forms de RELATORIO nao tem operacoes CRUD. Os metodos abaixo traduzem
    * o conceito CRUD para a semantica de relatorio.
    *==========================================================================

    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + ;
            "vel em relat" + CHR(243) + "rios." + CHR(13) + ;
            "Use Visualizar ou Imprimir para gerar o relat" + CHR(243) + "rio.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    *==========================================================================
    * METODOS DE CONSOLIDACAO - FASE 8
    *==========================================================================

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita os campos de filtro.
    *   Chamado antes de gerar relatorio (par_lHabilitar=.F.) e apos
    *   conclusao (par_lHabilitar=.T.) para evitar cliques duplos.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lEnable
        TRY
            loc_lEnable = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH loc_oPg
                IF PEMSTATUS(.txt_4c_CdEmpresa, "Enabled", 5)
                    .txt_4c_CdEmpresa.Enabled = loc_lEnable
                ENDIF
                IF PEMSTATUS(.txt_4c_DsEmpresa, "Enabled", 5)
                    .txt_4c_DsEmpresa.Enabled = loc_lEnable
                ENDIF
                IF PEMSTATUS(.txt_4c_DtInicial, "Enabled", 5)
                    .txt_4c_DtInicial.Enabled = loc_lEnable
                ENDIF
                IF PEMSTATUS(.txt_4c_DtFinal, "Enabled", 5)
                    .txt_4c_DtFinal.Enabled = loc_lEnable
                ENDIF
                IF PEMSTATUS(.opt_4c_TpRel, "Enabled", 5)
                    .opt_4c_TpRel.Enabled = loc_lEnable
                ENDIF
            ENDWITH
            IF PEMSTATUS(THIS.cmg_4c_Botoes, "Enabled", 5)
                THIS.cmg_4c_Botoes.Enabled = loc_lEnable
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Carrega propriedades do BO nos controles do formulario.
    *   Inverso de FormParaRelatorio. Util para repopular tela apos erro
    *   ou ao reabrir com parametros salvos.
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oPg
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(.this_cCodEmpresa)
                loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(.this_cDesEmpresa)
                loc_oPg.txt_4c_DtInicial.Value = .this_dDtInicial
                loc_oPg.txt_4c_DtFinal.Value   = .this_dDtFinal
                loc_oPg.opt_4c_TpRel.Value     = IIF(.this_nTpRel >= 1 AND .this_nTpRel <= 2, ;
                    .this_nTpRel, 1)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias semantico de FormParaRelatorio (contratos CRUD).
    *   Forms CRUD chamam FormParaBO; este form de relatorio delega para
    *   FormParaRelatorio que ja implementa a coleta dos filtros.
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Recarrega dados iniciais do formulario.
    *   Para forms REPORT: equivale a reinicializar os filtros com defaults.
    *   Chamado pela FormBase apos operacoes que resetam o estado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        THIS.LimparCampos()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Garante estado correto dos botoes do relatorio.
    *   Para forms REPORT nao ha modos CRUD; todos os botoes ficam habilitados.
    *   Chamado apos geracoes que possam ter desabilitado a interface.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        THIS.HabilitarCampos(.T.)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario (alias canonico de BtnSairClick).
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Semantica CRUD mapeada para Imprimir (contrato formbase).
    *   Em forms REPORT, "salvar" equivale a imprimir/gerar o relatorio.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Limpa os filtros e retorna ao estado inicial.
    *   Em forms REPORT, "cancelar" equivale a resetar os filtros.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            THIS.pgf_4c_Paginas.Page1.txt_4c_CdEmpresa.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLADO - BINDEVENT KeyPress
    * F4=115, ENTER=13, TAB=9
    *==========================================================================

    *--------------------------------------------------------------------------
    * TeclaCdEmpresa - KeyPress em txt_4c_CdEmpresa
    *   F4: abre lookup por codigo | ENTER/TAB: valida codigo digitado
    *   Equivalente ao get_cd_empresa.Valid -> fAcessoEmpresa('C',...) legado.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsEmpresa - KeyPress em txt_4c_DsEmpresa
    *   F4: abre lookup por descricao | ENTER/TAB: valida descricao digitada
    *   Equivalente ao get_ds_empresa.Valid -> fAcessoEmpresa('D',...) legado.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDsEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDataInicial - KeyPress em txt_4c_DtInicial
    *   Quando data inicial muda e fica maior que data final, iguala data final.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDataInicial(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_dIni, loc_dFim
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            loc_dIni = loc_oPg.txt_4c_DtInicial.Value
            loc_dFim = loc_oPg.txt_4c_DtFinal.Value
            IF !EMPTY(loc_dIni) AND !EMPTY(loc_dFim) AND loc_dIni > loc_dFim
                loc_oPg.txt_4c_DtFinal.Value = loc_dIni
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDataFinal - KeyPress em txt_4c_DtFinal
    *   Valida que data final nao fica menor que a inicial ao confirmar.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDataFinal(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_dIni, loc_dFim
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            loc_dIni = loc_oPg.txt_4c_DtInicial.Value
            loc_dFim = loc_oPg.txt_4c_DtFinal.Value
            IF !EMPTY(loc_dIni) AND !EMPTY(loc_dFim) AND loc_dFim < loc_dIni
                MsgAviso("Data Final Menor Que a Inicial!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPg.txt_4c_DtFinal.Value = loc_dIni
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUP - EMPRESA (SigCdEmp: Cemps / Razas)
    * Equivalente ao fAcessoEmpresa do sistema legado.
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirBuscaCdEmpresa - Lookup de empresa pelo codigo (Cemps)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCdEmpresa()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdEmpresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Empresa")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                        loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDsEmpresa - Lookup de empresa pela descricao (Razas)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDsEmpresa()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsEmpresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "Razas", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Razas", "", "Empresa")
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                        loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdEmpresa - Valida codigo de empresa digitado manualmente
    *   Busca Razas em SigCdEmp pelo Cemps digitado.
    *   Se nao encontrar, abre lookup automaticamente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCdEmpresa()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdEmpresa.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DsEmpresa.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
            EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
        IF loc_nResult > 0
            SELECT cursor_4c_EmpVal
            IF !EOF()
                loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
            ELSE
                loc_oPg.txt_4c_DsEmpresa.Value = ""
                THIS.AbrirBuscaCdEmpresa()
            ENDIF
        ELSE
            loc_oPg.txt_4c_DsEmpresa.Value = ""
            THIS.AbrirBuscaCdEmpresa()
        ENDIF
        IF USED("cursor_4c_EmpVal")
            USE IN cursor_4c_EmpVal
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsEmpresa - Valida descricao de empresa digitada manualmente
    *   Busca Cemps em SigCdEmp pela Razas digitada (LIKE).
    *   Se nao encontrar, abre lookup automaticamente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDsEmpresa()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsEmpresa.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_CdEmpresa.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Razas LIKE " + ;
            EscaparSQL(loc_cValor + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal2")
        IF loc_nResult > 0
            SELECT cursor_4c_EmpVal2
            IF !EOF()
                loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpVal2.Cemps)
                loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpVal2.Razas)
            ELSE
                THIS.AbrirBuscaDsEmpresa()
            ENDIF
        ELSE
            THIS.AbrirBuscaDsEmpresa()
        ENDIF
        IF USED("cursor_4c_EmpVal2")
            USE IN cursor_4c_EmpVal2
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
