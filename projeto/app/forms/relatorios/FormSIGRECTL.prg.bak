*==============================================================================
* FORMSIGRECTL.PRG
* Relat" + CHR(243) + "rio Mensal de Acessos
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGRECTL.SCX (frmrelatorio)
*
* Filtros (Page1):
*   - M" + CHR(234) + "s  (1-12)
*   - Ano  (2000-2099)
*   - Imprimir Tempo de Utiliza" + CHR(231) + CHR(227) + "o (checkbox)
*
* Bot" + CHR(245) + "es:
*   - Visualizar: REPORT FORM SigReCtl PREVIEW NOCONSOLE
*   - Imprimir:   REPORT FORM SigReCtl TO PRINTER PROMPT NOCONSOLE
*   - Excel:      COPY TO SigReCtl TYPE XLS
*   - Encerrar:   THIS.Release()
*
* Modo autom" + CHR(225) + "tico (pAut=.T.):
*   - EnviarEmail() gera PDF via fGerPDFCreator e envia via CDO SMTP
*==============================================================================

DEFINE CLASS FormSIGRECTL AS FormBase

    *-- Referencia ao BO do relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *-- Propriedade para caminho do arquivo PDF de email (modo automatico)
    pcArqEmail = ""

    *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=143)
    Height      = 143
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    *--------------------------------------------------------------------------
    * Init - Inicializacao com suporte a modo automatico (email agendado)
    *   par_lAutomatico = .T.: form gera PDF, envia email e fecha (modo batch)
    *   par_cEmailExc   = destinatario alternativo do email
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_lAutomatico, par_cEmailExc)
        LOCAL loc_lSucesso, loc_lAuto, loc_cExc

        loc_lAuto = (PCOUNT() >= 1 AND TYPE("par_lAutomatico") = "L" AND par_lAutomatico)
        loc_cExc  = IIF(PCOUNT() >= 2 AND TYPE("par_cEmailExc") = "C", par_cEmailExc, "")

        loc_lSucesso = DODEFAULT()

        IF loc_lSucesso AND loc_lAuto
            *-- Modo automatico: chkImpTempo=1 (igual ao IIF(pAut,.T.)->1 do legado)
            THIS.pgf_4c_Paginas.Page1.chk_4c_ImpTempo.Value = 1
            THIS.EnviarEmail(loc_cExc)
            loc_lSucesso = .F.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria BO e monta estrutura visual do form
    *   1. Define Caption e Picture (fundo)
    *   2. Instancia SIGRECTLBO
    *   3. Cabecalho escuro + botoes do relatorio + PageFrame com filtros
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio Mensal de Acessos"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO do relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SIGRECTLBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGRECTLBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Cabecalho escuro (equivalente ao cntSombra do frmrelatorio)
                THIS.ConfigurarCabecalho()

                *-- CommandGroup com 4 botoes do relatorio (Visualizar/Imprimir/Excel/Encerrar)
                THIS.ConfigurarBotoes()

                *-- PageFrame com Page1 contendo os filtros (Mes, Ano, ImpTempo)
                THIS.ConfigurarPageFrame()

                *-- Atualizar titulos no cabecalho apos criacao
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Adicionar campos de filtro na Page1
                THIS.ConfigurarPaginaLista()

                *-- Vincular eventos dos botoes do relatorio
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                *-- Valores iniciais dos campos de filtro (mes/ano correntes)
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
                .Caption   = "Relat" + CHR(243) + "rio Mensal de Acessos"
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
                .Caption   = "Relat" + CHR(243) + "rio Mensal de Acessos"
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
    * ConfigurarBotoes - CommandGroup canonico do frmrelatorio
    *   Original: btnReport.Top=-2, Left=494, Height=85, Width=310
    *   Novo padrao: cmg_4c_Botoes.Top=0, Left=529, Width=273, Height=80
    *   Bot" + CHR(245) + "es: Visualizar / Imprimir / Excel / Encerrar
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

            *-- Imprimir (impressora com dialogo)
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

            *-- Excel (exportar dados do cursor para XLS)
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

            *-- Encerrar (fechar form)
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
    * ConfigurarPageFrame - PageFrame com 1 pagina ("Filtros")
    *   Posicionado logo abaixo do cabecalho (Top=85) ate o fim do form.
    *   SIGRECTL original era FLAT; no novo sistema usamos PageFrame de 1 pagina
    *   para consistencia com o restante do sistema.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        loc_oPgf.PageCount = 1

        *-- Posicionamento: abaixo do cabecalho (80px) com 5px de gap
        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

        *-- Configurar Page1 (FORA de qualquer WITH - usar referencia direta)
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
    * AlternarPagina - Ativa a p" + CHR(225) + "gina especificada do PageFrame de filtros
    *   par_nPagina: n" + CHR(250) + "mero da p" + CHR(225) + "gina a ativar (1 = Filtros - " + CHR(250) + "nica p" + CHR(225) + "gina)
    *   Form REPORT possui apenas 1 p" + CHR(225) + "gina; m" + CHR(233) + "todo mant" + CHR(233) + "m API consistente
    *   com forms CRUD e permite refresh program" + CHR(225) + "tico do PageFrame
    *   (por exemplo, ap" + CHR(243) + "s LimparCampos para reexibir os valores atualizados).
    *   Faz Refresh ap" + CHR(243) + "s ativar para garantir que controles fiquem vis" + CHR(237) + "veis.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_nMaxPag
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_nMaxPag = THIS.pgf_4c_Paginas.PageCount
        IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 ;
                AND par_nPagina <= loc_nMaxPag
            loc_nPagina = par_nPagina
        ELSE
            loc_nPagina = 1
        ENDIF
        THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
        THIS.pgf_4c_Paginas.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Delegacao para ConfigurarPaginaDados
    *   Form REPORT possui apenas Page1 (Filtros), que e simultaneamente a
    *   pagina de "lista" (parametros) e "dados" (campos de filtro do relatorio).
    *   Mantido para consistencia de API com forms CRUD; toda a configuracao
    *   real dos controles de filtro acontece em ConfigurarPaginaDados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Adiciona campos de filtro na Page1 do PageFrame
    *   Posicoes originais SIGRECTL (form 800x143) menos offset PageFrame (85px):
    *     getMes:      Top=90 -> Page: Top=5    | Left=126
    *     getAno:      Top=89 -> Page: Top=4    | Left=198
    *     lblEmpresa:  Top=94 -> Page: Top=9    | Left=96
    *     Say1:        Top=93 -> Page: Top=8    | Left=168
    *     chkImpTempo: Top=114-> Page: Top=29   | Left=96
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Label "Mes :"
        loc_oPg.AddObject("lbl_4c_LblEmpresa", "Label")
        WITH loc_oPg.lbl_4c_LblEmpresa
            .Caption   = "M" + CHR(234) + "s :"
            .Top       = 9
            .Left      = 96
            .Width     = 28
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Mes (InputMask="99", valor numerico de 1-12)
        loc_oPg.AddObject("txt_4c_Mes", "TextBox")
        WITH loc_oPg.txt_4c_Mes
            .Value         = 0
            .Top           = 5
            .Left          = 126
            .Width         = 24
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .F.
            .FontItalic    = .F.
            .FontUnderline = .F.
            .Alignment     = 0
            .BackStyle     = 1
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .BorderColor   = RGB(100, 100, 100)
            .Format        = "K"
            .InputMask     = "99"
            .MaxLength     = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .ToolTipText   = "M" + CHR(234) + "s (Formato = 99)"
            .Visible       = .T.
        ENDWITH

        *-- Label "Ano :"
        loc_oPg.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg.lbl_4c_Label1
            .Caption   = "Ano :"
            .Top       = 8
            .Left      = 168
            .Width     = 28
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Ano (InputMask="9999", valor numerico 2000-2099)
        loc_oPg.AddObject("txt_4c_Ano", "TextBox")
        WITH loc_oPg.txt_4c_Ano
            .Value         = 0
            .Top           = 4
            .Left          = 198
            .Width         = 38
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .F.
            .FontItalic    = .F.
            .FontUnderline = .F.
            .Alignment     = 0
            .BackStyle     = 1
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .BorderColor   = RGB(100, 100, 100)
            .Format        = "K"
            .InputMask     = "9999"
            .MaxLength     = 4
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .ToolTipText   = "Ano (Formato = 9999)"
            .Visible       = .T.
        ENDWITH

        *-- CheckBox Imprimir Tempo de Utilizacao
        loc_oPg.AddObject("chk_4c_ImpTempo", "CheckBox")
        WITH loc_oPg.chk_4c_ImpTempo
            .Caption   = "Imprimir Tempo de Utiliza" + CHR(231) + CHR(227) + "o"
            .Top       = 29
            .Left      = 96
            .Value     = 1
            .AutoSize  = .T.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Vincular validacao ao KeyPress (BINDEVENT Valid nao funciona em TextBox)
        BINDEVENT(loc_oPg.txt_4c_Mes, "KeyPress", THIS, "TxtMesKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Ano, "KeyPress", THIS, "TxtAnoKeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa campos com mes/ano correntes e ImpTempo marcado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_Mes.Value      = MONTH(DATE())
            loc_oPg.txt_4c_Ano.Value      = YEAR(DATE())
            *-- Padrao UNCHECKED para usuarios normais (IIF(pAut=.F.,1,0)=0 no legado)
            loc_oPg.chk_4c_ImpTempo.Value = 0
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos controles para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_nMes      = loc_oPg.txt_4c_Mes.Value
            .this_nAno      = loc_oPg.txt_4c_Ano.Value
            .this_lImpTempo = loc_oPg.chk_4c_ImpTempo.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida Mes (1-12) e Ano (2000-2099) antes de gerar
    *   Equivalente a validacao em btnReport.Click do form legado SIGRECTL.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        IF !BETWEEN(loc_oPg.txt_4c_Mes.Value, 1, 12)
            MsgAviso("M" + CHR(234) + "s Inv" + CHR(225) + "lido!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o!!!")
            loc_oPg.txt_4c_Mes.SetFocus()
            RETURN .F.
        ENDIF

        IF !BETWEEN(loc_oPg.txt_4c_Ano.Value, 2000, 2099)
            MsgAviso("Ano Inv" + CHR(225) + "lido!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o!!!")
            loc_oPg.txt_4c_Ano.SetFocus()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cFrxPath
        TRY
            IF !THIS.ValidarFiltros()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                RETURN
            ENDIF
            loc_cFrxPath = THIS.this_oRelatorio.this_cFRXPath
            REPORT FORM (loc_cFrxPath) PREVIEW NOCONSOLE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia relatorio para impressora com dialogo de selecao
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_cFrxPath
        TRY
            IF !THIS.ValidarFiltros()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                RETURN
            ENDIF
            loc_cFrxPath = THIS.this_oRelatorio.this_cFRXPath
            REPORT FORM (loc_cFrxPath) TO PRINTER PROMPT NOCONSOLE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados do cursor crDados para arquivo XLS
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cCursor, loc_cArquivo
        TRY
            IF !THIS.ValidarFiltros()
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
            loc_cArquivo = PUTFILE("Salvar como...", "SigReCtl", "XLS")
            IF !EMPTY(loc_cArquivo)
                SELECT (loc_cCursor)
                COPY TO (loc_cArquivo) TYPE XLS
                MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + ;
                    loc_cArquivo, "Excel")
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

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Em form REPORT equivale a "Nova Consulta": redefine
    *   os filtros para os valores padrao (mes/ano correntes, ImpTempo=0) e
    *   posiciona o foco no primeiro campo de filtro para nova entrada.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oPg
        TRY
            THIS.LimparCampos()
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg.txt_4c_Mes) = "O"
                loc_oPg.txt_4c_Mes.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Em form REPORT equivale a "Editar Filtros": ativa a
    *   pagina de filtros e posiciona o foco no campo Mes para edicao manual
    *   dos parametros do relatorio sem resetar os valores correntes.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oPg
        TRY
            THIS.AlternarPagina(1)
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg.txt_4c_Mes) = "O"
                loc_oPg.txt_4c_Mes.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Em form REPORT equivale a "Limpar Resultados": fecha
    *   cursores de dados gerados em PrepararDados (crDados, crCabecalho) e
    *   reseta filtros para valores padrao. Apos esta operacao o usuario pode
    *   refazer a consulta com filtros zerados (Mes/Ano correntes).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oPg, loc_cCursor
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_cCursor = THIS.this_oRelatorio.this_cCursorDados
                IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
                    USE IN (loc_cCursor)
                ENDIF
                IF USED("crCabecalho")
                    USE IN crCabecalho
                ENDIF
            ENDIF
            THIS.LimparCampos()
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg.txt_4c_Mes) = "O"
                loc_oPg.txt_4c_Mes.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtMesKeyPress - Valida campo Mes ao pressionar Enter ou Tab
    *   Equivalente ao Valid event em getMes do form legado SIGRECTL.
    *--------------------------------------------------------------------------
    PROCEDURE TxtMesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF !BETWEEN(loc_oPg.txt_4c_Mes.Value, 1, 12)
                MsgAviso("O M" + CHR(234) + "s Precisa Estar No Intervalo de 01 a 12!!!", ;
                         "M" + CHR(234) + "s Inv" + CHR(225) + "lido!!!")
                loc_oPg.txt_4c_Mes.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtAnoKeyPress - Valida campo Ano ao pressionar Enter ou Tab
    *   Equivalente ao Valid event em getAno do form legado SIGRECTL.
    *--------------------------------------------------------------------------
    PROCEDURE TxtAnoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF !BETWEEN(loc_oPg.txt_4c_Ano.Value, 2000, 2099)
                MsgAviso("O Ano Precisa Estar No Intervalo de 2000 a 2099!!!", ;
                         "Ano Inv" + CHR(225) + "lido!!!")
                loc_oPg.txt_4c_Ano.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * EnviarEmail - Gera PDF do relatorio e envia via CDO SMTP (modo batch)
    *   Equivalente ao metodo enviaremail do form legado SIGRECTL.
    *   Requer: fGerPDFCreator() disponivel (Framework legacy)
    *           Servidor SMTP mail.4control.com.br na porta 25
    *--------------------------------------------------------------------------
    PROCEDURE EnviarEmail(par_cEmailExc)
        LOCAL loc_lcTxt, loc_lcDir, loc_lcSch, loc_loCfg, loc_loMsg
        LOCAL loc_lPDF, loc_cTo, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lcDir = ADDBS(SYS(5) + SYS(2003))
            THIS.pcArqEmail = loc_lcDir + "SigReClt.pdf"
            loc_cTo = IIF(TYPE("par_cEmailExc") = "C" AND !EMPTY(par_cEmailExc), ;
                          par_cEmailExc, "acessos@4control.com.br")

            *-- Transferir filtros do form (ja inicializados com mes/ano correntes)
            THIS.FormParaRelatorio()

            *-- Preparar dados (preenche cursor crDados)
            IF THIS.this_oRelatorio.PrepararDados() AND ;
               USED("crDados") AND !EOF("crDados")
                *-- Montar texto do email a partir do cabecalho do relatorio
                loc_lcTxt = ""
                IF USED("crCabecalho") AND RECCOUNT("crCabecalho") > 0
                    GO TOP IN crCabecalho
                    loc_lcTxt = ALLTRIM(crCabecalho.Subtitulos) + CHR(13) + ;
                                ALLTRIM(crCabecalho.Empresa)
                ENDIF

                *-- Gerar PDF via PDFCreator (requer fGerPDFCreator do Framework legado)
                loc_lPDF = fGerPDFCreator(THIS)

                IF loc_lPDF AND FILE(THIS.pcArqEmail)
                    loc_lcSch = "http://schemas.microsoft.com/cdo/configuration/"
                    loc_loCfg = CREATEOBJECT("CDO.Configuration")

                    WITH loc_loCfg.Fields
                        .Item(loc_lcSch + "smtpserver")             = "mail.4control.com.br"
                        .Item(loc_lcSch + "smtpserverport")         = 25
                        .Item(loc_lcSch + "sendusing")              = 2
                        .Item(loc_lcSch + "smtpauthenticate")       = 1
                        .Item(loc_lcSch + "smtpusessl")             = .F.
                        .Item(loc_lcSch + "sendusername")           = "acessos@4control.com.br"
                        .Item(loc_lcSch + "sendpassword")           = "PswAce4c"
                        .Item(loc_lcSch + "smtpconnectiontimeout")  = 60
                        .Update
                    ENDWITH

                    loc_loMsg = CREATEOBJECT("CDO.Message")
                    WITH loc_loMsg
                        .Configuration = loc_loCfg
                        .From          = "acessos@4control.com.br"
                        .To            = loc_cTo
                        .Subject       = "Controle Mensal de Acessos - " + ;
                                         IIF(USED("crCabecalho"), ALLTRIM(crCabecalho.Empresa), "")
                        .TextBody      = loc_lcTxt
                        .AutoGenerateTextBody = .F.
                        .AddAttachment(THIS.pcArqEmail)
                        =INKEY(1, "MH")
                        .Send()
                    ENDWITH

                    DELETE FILE (THIS.pcArqEmail)
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "EnviarEmail")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro EnviarEmail")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Em form REPORT equivale a "Visualizar": valida filtros,
    *   prepara dados e exibe o relatorio em preview.
    *   Mapeado semanticamente ao botao Buttons(1) (Visualizar) do cmg_4c_Botoes.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario (equivalente a BtnSairClick).
    *   Chamado por ESC ou pelo botao Encerrar (Buttons(4) do cmg_4c_Botoes).
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Em form REPORT equivale a "Imprimir": envia o relatorio
    *   para impressora com dialogo de selecao de impressora.
    *   Semanticamente "salvar" o resultado = imprimir em papel.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Em form REPORT equivale a "Limpar Filtros": redefine
    *   os campos de filtro para os valores padrao (mes/ano correntes,
    *   ImpTempo=0) sem fechar o formulario, permitindo nova consulta.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.LimparCampos()
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                IF VARTYPE(THIS.pgf_4c_Paginas.Page1.txt_4c_Mes) = "O"
                    THIS.pgf_4c_Paginas.Page1.txt_4c_Mes.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro BtnCancelarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores dos controles para o BO do relatorio.
    *   Em forms REPORT, delega para FormParaRelatorio() que preenche o
    *   SIGRECTLBO com this_nMes, this_nAno e this_lImpTempo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere propriedades do BO de volta para os controles.
    *   Operacao inversa de FormParaRelatorio: le this_nMes, this_nAno e
    *   this_lImpTempo do SIGRECTLBO e preenche os TextBoxes/CheckBox.
    *   Util para restaurar filtros apos uma operacao de busca ou quando
    *   o BO for alimentado externamente (ex: modo automatico).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                IF VARTYPE(loc_oPg.txt_4c_Mes) = "O"
                    loc_oPg.txt_4c_Mes.Value = .this_nMes
                ENDIF
                IF VARTYPE(loc_oPg.txt_4c_Ano) = "O"
                    loc_oPg.txt_4c_Ano.Value = .this_nAno
                ENDIF
                IF VARTYPE(loc_oPg.chk_4c_ImpTempo) = "O"
                    loc_oPg.chk_4c_ImpTempo.Value = IIF(.this_lImpTempo = 1, 1, 0)
                ENDIF
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Define estado habilitado/desabilitado dos controles.
    *   par_lHabilitar = .T.: habilita todos os campos de filtro para edicao
    *   par_lHabilitar = .F.: desabilita todos os campos (modo somente leitura)
    *   Em forms REPORT os campos sao sempre habilitados; o parametro permite
    *   bloquear a UI durante o processamento de dados (PrepararDados).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lHab
        loc_lHab = .T.
        IF PCOUNT() >= 1 AND TYPE("par_lHabilitar") = "L"
            loc_lHab = par_lHabilitar
        ENDIF
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg.txt_4c_Mes) = "O"
                loc_oPg.txt_4c_Mes.Enabled = loc_lHab
            ENDIF
            IF VARTYPE(loc_oPg.txt_4c_Ano) = "O"
                loc_oPg.txt_4c_Ano.Enabled = loc_lHab
            ENDIF
            IF VARTYPE(loc_oPg.chk_4c_ImpTempo) = "O"
                loc_oPg.chk_4c_ImpTempo.Enabled = loc_lHab
            ENDIF
            IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
                THIS.cmg_4c_Botoes.Enabled = loc_lHab
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Em forms REPORT nao ha grid de lista para carregar.
    *   Retorna .T. para compatibilidade de API com forms CRUD que chamam
    *   CarregarLista() no fluxo de inicializacao e apos operacoes.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Botoes do cmg_4c_Botoes sempre Enabled em REPORT
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
            THIS.cmg_4c_Botoes.Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
