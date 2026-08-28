*==============================================================================
* FORMSIGREFC2.PRG
* Form: Fechamento de Caixa
* Tipo: RELATORIO (frmrelatorio)
* BO: sigrefc2BO.prg
* Herda de: FormBase
* Original: SIGREFC1 (sigrefc2.SCX)
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS Formsigrefc2 AS FormBase

    *-- BO do relatorio
    this_oRelatorio = .NULL.

    *-- Propriedades visuais (PILAR 1 - exatas do original SIGREFC1)
    Caption     = "Fechamento de Caixa"
    Width       = 800
    Height      = 300
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    BorderStyle = 2
    DataSession = 2

    *--------------------------------------------------------------------------
    * Init - FormBase.Init chama InicializarForm via DODEFAULT
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Constroi a UI do formulario de relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            *-- Nao cria BO se estiver em modo de validacao de UI (sem conexao SQL)
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.this_oRelatorio = CREATEOBJECT("sigrefc2BO")
                IF VARTYPE(THIS.this_oRelatorio) # "O"
                    MsgErro("Erro ao criar BO do relat" + CHR(243) + "rio de Fechamento de Caixa." + ;
                        CHR(13) + "Verifique a conex" + CHR(227) + "o com o banco de dados.", "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.Width  = 800
                THIS.Height = 300

                IF TYPE("gc_4c_CaminhoIcones") = "U"
                    gc_4c_CaminhoIcones = ""
                ENDIF
                THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoesRelatorio()
                THIS.ConfigurarPageFrame()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                THIS.LimparCampos()

                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar Formsigrefc2:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                loc_oErro.Message, "InicializarForm")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro com titulo do relatorio
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
                .Top       = 15
                .Left      = 11
                .Width     = THIS.Width
                .Height    = 40
                .Caption   = "Fechamento de Caixa"
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .Caption   = "Fechamento de Caixa"
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesRelatorio - CommandGroup padrao frmrelatorio (4 botoes)
    * Geometria EXATA do framework: Left=529 Width=273 Height=80
    * Buttons: Visualizar Buttons(1), Imprimir Buttons(2), Excel Buttons(3),
    *          Sair Buttons(4) [Cancel=.T. - fecha com ESC]
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesRelatorio()
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
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
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
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .Visible         = .T.
            ENDWITH

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
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Sair"
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .Cancel          = .T.
                .Visible         = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 2 paginas (Filtros / Dados)
    *   O form legado SIGREFC1 e FLAT (sem PageFrame), mas no novo padrao
    *   os campos de filtro sao agrupados em um PageFrame para consistencia
    *   com o restante do sistema (mesmo padrao de FormSIGREADS/FormSIGREAEG).
    *
    *   Page1 (Filtros): hospeda Empresa, Periodo, TpRel e Labels (Fase 5).
    *   Page2 (Dados):   reservada para grid/dados auxiliares (sem uso aqui).
    *
    *   Posicionamento: abaixo do cabecalho (85px) ate o fim do form.
    *   PageFrame e usado SEM abas (Tabs=.F.) - apenas como container.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 2

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

        loc_oPgf.Page2.Caption   = "Dados"
        loc_oPgf.Page2.FontName  = "Tahoma"
        loc_oPgf.Page2.FontSize  = 8
        loc_oPgf.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Cria campos de filtro em Page1 do relatorio
    *   (em forms REPORT a "lista" eh a pagina de filtros - layout adaptado
    *    do padrao frmcadastro para coerencia com o restante do sistema)
    * Posicoes calculadas subtraindo o top do PageFrame (85) dos tops originais:
    *   empresa top=120 -> 35 | periodo top=145 -> 60 | tipo top=174 -> 89
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oOpt
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Label "Empresa :"
        loc_oPg1.AddObject("lbl_4c_LblEmpresa", "Label")
        WITH loc_oPg1.lbl_4c_LblEmpresa
            .Top       = 38
            .Left      = 214
            .AutoSize  = .T.
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo Empresa
        loc_oPg1.AddObject("txt_4c_CdEmpresa", "TextBox")
        WITH loc_oPg1.txt_4c_CdEmpresa
            .Top      = 35
            .Left     = 267
            .Width    = 31
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- TextBox Razao Social Empresa (editavel - busca por nome, como original get_ds_empresa)
        loc_oPg1.AddObject("txt_4c_NomEmpresa", "TextBox")
        WITH loc_oPg1.txt_4c_NomEmpresa
            .Top       = 35
            .Left      = 300
            .Width     = 289
            .Height    = 23
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 40
            .Visible   = .T.
        ENDWITH

        *-- Label "Periodo :"
        loc_oPg1.AddObject("lbl_4c_LblPeriodo", "Label")
        WITH loc_oPg1.lbl_4c_LblPeriodo
            .Top       = 63
            .Left      = 219
            .AutoSize  = .T.
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Data Inicial
        loc_oPg1.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPg1.txt_4c_DtInicial
            .Top      = 60
            .Left     = 267
            .Width    = 80
            .Height   = 23
            .Value    = {}
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Label separador "a" entre datas
        loc_oPg1.AddObject("lbl_4c_LblSep", "Label")
        WITH loc_oPg1.lbl_4c_LblSep
            .Top       = 63
            .Left      = 351
            .AutoSize  = .T.
            .Caption   = "a"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Data Final
        loc_oPg1.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPg1.txt_4c_DtFinal
            .Top      = 60
            .Left     = 364
            .Width    = 80
            .Height   = 23
            .Value    = {}
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Label "Tipo :"
        loc_oPg1.AddObject("lbl_4c_LblTipo", "Label")
        WITH loc_oPg1.lbl_4c_LblTipo
            .Top       = 94
            .Left      = 235
            .AutoSize  = .T.
            .Caption   = "Tipo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Tipo de Relatorio
        loc_oPg1.AddObject("opt_4c_TpRel", "OptionGroup")
        loc_oOpt = loc_oPg1.opt_4c_TpRel
        WITH loc_oOpt
            .Top         = 89
            .Left        = 256
            .Width       = 155
            .Height      = 47
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Vis" + CHR(227) + "o Detalhada"
                .Left      = 0
                .Top       = 0
                .Width     = 150
                .Height    = 21
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Mapa de Fechamento"
                .Left      = 0
                .Top       = 23
                .Width     = 150
                .Height    = 21
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Vincula eventos de teclado para empresa: codigo (F4/ENTER/TAB) e razao social (F4/ENTER/TAB)
        BINDEVENT(loc_oPg1.txt_4c_CdEmpresa,  "KeyPress", THIS, "TeclaCdEmpresa")
        BINDEVENT(loc_oPg1.txt_4c_NomEmpresa, "KeyPress", THIS, "TeclaNomEmpresa")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 do PageFrame (Dados auxiliares)
    *   Para este relatorio, a Page2 exibe resumo de configuracao carregada
    *   do SigCdPam (operacao de fechamento e conserto) para confirmacao
    *   visual do usuario antes de processar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oErro
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            *-- Label titulo da secao de configuracao
            loc_oPg2.AddObject("lbl_4c_TituloConfig", "Label")
            WITH loc_oPg2.lbl_4c_TituloConfig
                .Top       = 15
                .Left      = 214
                .Width     = 350
                .Height    = 18
                .Caption   = "Configura" + CHR(231) + CHR(227) + "o de Fechamento (SigCdPam)"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Label "Opera" + CHR(231) + CHR(227) + "o :"
            loc_oPg2.AddObject("lbl_4c_LblOperacao", "Label")
            WITH loc_oPg2.lbl_4c_LblOperacao
                .Top       = 45
                .Left      = 214
                .Width     = 80
                .Height    = 18
                .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- TextBox Descricao da Operacao (preenchida via LimparCampos)
            loc_oPg2.AddObject("txt_4c_DesOperacao", "TextBox")
            WITH loc_oPg2.txt_4c_DesOperacao
                .Top       = 42
                .Left      = 300
                .Width     = 250
                .Height    = 23
                .Value     = ""
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ReadOnly  = .T.
                .BackColor = RGB(240, 240, 240)
                .Visible   = .T.
            ENDWITH

            *-- Label "Conserto :"
            loc_oPg2.AddObject("lbl_4c_LblConserto", "Label")
            WITH loc_oPg2.lbl_4c_LblConserto
                .Top       = 75
                .Left      = 214
                .Width     = 80
                .Height    = 18
                .Caption   = "Conserto :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- TextBox Descricao do Conserto (preenchida via LimparCampos)
            loc_oPg2.AddObject("txt_4c_DesConserto", "TextBox")
            WITH loc_oPg2.txt_4c_DesConserto
                .Top       = 72
                .Left      = 300
                .Width     = 250
                .Height    = 23
                .Value     = ""
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ReadOnly  = .T.
                .BackColor = RGB(240, 240, 240)
                .Visible   = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro("Erro em ConfigurarPaginaDados:" + CHR(13) + loc_oErro.Message, "ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Prepara filtros e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Prepara filtros e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Prepara filtros e exporta relatorio para arquivo Excel
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.GerarExcel()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "GerarExcel")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Em forms RELATORIO o equivalente do "Incluir" CRUD
    * eh gerar uma nova visualizacao do relatorio com os filtros atuais.
    * Mantido com nome canonico CRUD por compatibilidade com a base de codigo
    * unificada (validacoes e handlers de menu chamam pelo nome padrao).
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Em forms RELATORIO o equivalente do "Alterar" CRUD
    * eh alterar o destino de saida do relatorio (preview -> impressora).
    * Delega para BtnImprimirClick para enviar a saida ao dispositivo fisico.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Em forms RELATORIO o equivalente do "Excluir" CRUD
    * eh encerrar/descartar a sessao do relatorio (fechar o formulario).
    * Delega para BtnSairClick para liberar recursos e fechar a janela.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.BtnSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Mapeia controles do form para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dDtInicial     = loc_oPg1.txt_4c_DtInicial.Value
            .this_dDtFinal       = loc_oPg1.txt_4c_DtFinal.Value
            .this_cCodEmpresa    = ALLTRIM(loc_oPg1.txt_4c_CdEmpresa.Value)
            .this_cNomEmpresa    = ALLTRIM(loc_oPg1.txt_4c_NomEmpresa.Value)
            .this_nTipoRelatorio = loc_oPg1.opt_4c_TpRel.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa campos com valores padrao do BO
    * Se empresa tem codigo mas sem nome, busca a razao social no banco.
    * Carrega operacao e conserto do SigCdPam para exibir na Page2.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg1, loc_oPg2, loc_oBO, loc_cCod, loc_cSQL, loc_nRes, loc_oErro
        TRY
            loc_oPg1 = THIS.pgf_4c_Paginas.Page1
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_oBO  = THIS.this_oRelatorio

            *-- Em modo de validacao de UI o BO nao eh criado - usa defaults
            IF VARTYPE(loc_oBO) # "O"
                loc_oPg1.txt_4c_CdEmpresa.Value  = ""
                loc_oPg1.txt_4c_NomEmpresa.Value = ""
                loc_oPg1.txt_4c_DtInicial.Value  = DATE()
                loc_oPg1.txt_4c_DtFinal.Value    = DATE()
                loc_oPg1.opt_4c_TpRel.Value      = 1
                RETURN
            ENDIF

            loc_oPg1.txt_4c_CdEmpresa.Value  = loc_oBO.this_cCodEmpresa
            loc_oPg1.txt_4c_NomEmpresa.Value = loc_oBO.this_cNomEmpresa
            loc_oPg1.txt_4c_DtInicial.Value  = loc_oBO.this_dDtInicial
            loc_oPg1.txt_4c_DtFinal.Value    = loc_oBO.this_dDtFinal
            loc_oPg1.opt_4c_TpRel.Value      = loc_oBO.this_nTipoRelatorio

            *-- Busca nome da empresa se codigo preenchido mas nome vazio
            loc_cCod = ALLTRIM(loc_oPg1.txt_4c_CdEmpresa.Value)
            IF gnConnHandle > 0 AND !EMPTY(loc_cCod) AND ;
               EMPTY(ALLTRIM(loc_oPg1.txt_4c_NomEmpresa.Value))
                loc_cSQL = "SELECT TOP 1 Razas FROM SigCdEmp " + ;
                           "WHERE Cemps = " + EscaparSQL(loc_cCod)
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Refc2EmpLc")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_Refc2EmpLc") > 0
                    SELECT cursor_4c_Refc2EmpLc
                    IF !EOF()
                        loc_oPg1.txt_4c_NomEmpresa.Value = ALLTRIM(Razas)
                    ENDIF
                ENDIF
                IF USED("cursor_4c_Refc2EmpLc")
                    USE IN cursor_4c_Refc2EmpLc
                ENDIF
            ENDIF

            *-- Carrega operacao e conserto do SigCdPam para Page2 (configuracao)
            IF gnConnHandle > 0
                loc_cSQL = "SELECT TOP 1 Dopes, OpcOnsers FROM SigCdPam"
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Refc2PamLc")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_Refc2PamLc") > 0
                    SELECT cursor_4c_Refc2PamLc
                    IF !EOF()
                        loc_oPg2.txt_4c_DesOperacao.Value = ALLTRIM(Dopes)
                        loc_oPg2.txt_4c_DesConserto.Value = ALLTRIM(OpcOnsers)
                    ENDIF
                ENDIF
                IF USED("cursor_4c_Refc2PamLc")
                    USE IN cursor_4c_Refc2PamLc
                ENDIF
            ENDIF

            loc_oPg1.txt_4c_CdEmpresa.SetFocus()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdEmpresa - KeyPress handler para campo codigo empresa
    * F4(115): abre lookup direto | ENTER(13)/TAB(9): valida codigo digitado
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaEmpresa - Abre FormBuscaAuxiliar para selecionar empresa
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oPg1, loc_cValor, loc_oBusca
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg1.txt_4c_CdEmpresa.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValor, ;
            "Busca de Empresa")

        IF VARTYPE(loc_oBusca) # "O"
            RETURN
        ENDIF

        IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
            loc_oPg1.txt_4c_CdEmpresa.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
            loc_oPg1.txt_4c_NomEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
        ELSE
            IF !loc_oBusca.this_lAchouRegistro
            loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                loc_oPg1.txt_4c_CdEmpresa.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                loc_oPg1.txt_4c_NomEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
            ENDIF
            ENDIF
        ENDIF

        loc_oBusca.Release()
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdEmpresa - Valida codigo empresa e preenche razao social
    * Chamado ao pressionar ENTER/TAB no campo codigo empresa
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdEmpresa()
        LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nRes, loc_oErro
        TRY
            loc_oPg1 = THIS.pgf_4c_Paginas.Page1
            loc_cCod = ALLTRIM(loc_oPg1.txt_4c_CdEmpresa.Value)

            IF EMPTY(loc_cCod)
                loc_oPg1.txt_4c_NomEmpresa.Value = ""
                RETURN
            ENDIF

            loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp " + ;
                       "WHERE Cemps = " + EscaparSQL(loc_cCod)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Refc2EmpV")

            IF loc_nRes > 0 AND RECCOUNT("cursor_4c_Refc2EmpV") > 0
                SELECT cursor_4c_Refc2EmpV
                IF !EOF()
                    loc_oPg1.txt_4c_CdEmpresa.Value  = ALLTRIM(Cemps)
                    loc_oPg1.txt_4c_NomEmpresa.Value = ALLTRIM(Razas)
                ENDIF
            ELSE
                *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
                THIS.AbrirBuscaEmpresa()
            ENDIF

            IF USED("cursor_4c_Refc2EmpV")
                USE IN cursor_4c_Refc2EmpV
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarCdEmpresa")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaNomEmpresa - KeyPress handler para campo razao social empresa
    * F4(115): abre lookup direto | ENTER(13)/TAB(9): valida nome digitado
    * Replica comportamento do get_ds_empresa.Valid do legado (fAcessoEmpresa modo 'D')
    *--------------------------------------------------------------------------
    PROCEDURE TeclaNomEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarNomEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarNomEmpresa - Valida razao social digitada e preenche codigo
    * Chamado ao pressionar ENTER/TAB no campo razao social da empresa.
    * Busca parcial: se unica ? preenche; se multipla ? abre lookup; se nenhuma ? avisa e abre lookup.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarNomEmpresa()
        LOCAL loc_oPg1, loc_cNom, loc_cSQL, loc_nRes, loc_oErro
        TRY
            loc_oPg1 = THIS.pgf_4c_Paginas.Page1
            loc_cNom = ALLTRIM(loc_oPg1.txt_4c_NomEmpresa.Value)

            IF EMPTY(loc_cNom)
                loc_oPg1.txt_4c_CdEmpresa.Value  = ""
                loc_oPg1.txt_4c_NomEmpresa.Value = ""
                RETURN
            ENDIF

            *-- Busca empresa pela razao social (correspondencia parcial - TOP 2 para detectar duplicidade)
            loc_cSQL = "SELECT TOP 2 Cemps, Razas FROM SigCdEmp " + ;
                       "WHERE Razas LIKE " + EscaparSQL("%" + loc_cNom + "%") + ;
                       " ORDER BY Cemps"
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Refc2NomV")

            IF loc_nRes > 0 AND RECCOUNT("cursor_4c_Refc2NomV") = 1
                *-- Encontrou exatamente uma - preenche automaticamente
                SELECT cursor_4c_Refc2NomV
                IF !EOF()
                    loc_oPg1.txt_4c_CdEmpresa.Value  = ALLTRIM(Cemps)
                    loc_oPg1.txt_4c_NomEmpresa.Value = ALLTRIM(Razas)
                ENDIF
                IF USED("cursor_4c_Refc2NomV")
                    USE IN cursor_4c_Refc2NomV
                ENDIF
            ELSE
                IF USED("cursor_4c_Refc2NomV")
                    USE IN cursor_4c_Refc2NomV
                ENDIF
                IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_Refc2NomV") = 0
                    MsgAviso("Empresa n" + CHR(227) + "o encontrada.", "Aviso")
                    loc_oPg1.txt_4c_CdEmpresa.Value  = ""
                    loc_oPg1.txt_4c_NomEmpresa.Value = ""
                ENDIF
                *-- Multiplas ou nenhuma - abre lookup para selecao manual
                THIS.AbrirBuscaEmpresa()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarNomEmpresa")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre paginas do PageFrame de filtros
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.pgf_4c_Paginas.ActivePage = par_nPagina
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO e chama cleanup da classe base
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
