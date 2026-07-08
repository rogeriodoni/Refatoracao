*==============================================================================
* FORMSIGREIMC.PRG
* Impress" + CHR(227) + "o de Cartas (SIGREIMC)
* Tipo: REPORT - Herda de FormBase
* BO: sigreimcBO.prg
*
* Migrado de: sigreimc.SCX (frmrelatorio)
* Original: Width=800, Height=160, frmrelatorio framework.vcx
*
* Recebe parametros opcionais do formulario de origem:
*   par_cEmp     - empresa (cemps)
*   par_cSerie   - serie da NF (cseries)
*   par_dEmisDe  - data inicial de emissao
*   par_dEmisAte - data final de emissao
*   par_cEDNs    - EDN (empdopnums - filtro opcional)
*   par_cNotaIni - nota fiscal inicial (cnfis)
*   par_cNotaFim - nota fiscal final (cnfis)
*
* FASE 7/8 - Form - Eventos Principais (Completo)
*   * Form REPORT: BtnVisualizarClick/BtnImprimirClick/BtnSairClick ja implementados
*   * BtnIncluirClick/BtnAlterarClick/BtnExcluirClick: N/A (form tipo REPORT, nao CRUD)
*   * ConfigurarPaginaLista() corrigida: nao recria controles (evita "member already exists")
*   * ConfigurarPaginaDados() confirmada N/A para form REPORT de pagina unica
*==============================================================================

DEFINE CLASS Formsigreimc AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=160)
    Height      = 160
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

    *-- Parametros opcionais recebidos no Init (contexto da NF de origem)
    *   Equivalem as propriedades custom 'emp','serie','edns','notaini','notafim',
    *   'emisde','emisate' do form legado SIGREIMC
    this_cEmp     = ""
    this_cSerie   = ""
    this_dEmisDe  = {}
    this_dEmisAte = {}
    this_cEDNs    = ""
    this_cNotaIni = ""
    this_cNotaFim = ""

    *--------------------------------------------------------------------------
    * Init - Armazena parametros opcionais antes de delegar para FormBase.Init()
    * que chama THIS.InicializarForm().
    * Equivalente ao LPARAMETERS do Init() legado SIGREIMC.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cEmp, par_cSerie, par_dEmisDe, par_dEmisAte, ;
                   par_cEDNs, par_cNotaIni, par_cNotaFim)
        IF PCOUNT() >= 1 AND VARTYPE(par_cEmp) = "C"
            THIS.this_cEmp = ALLTRIM(par_cEmp)
        ENDIF
        IF PCOUNT() >= 2 AND VARTYPE(par_cSerie) = "C"
            THIS.this_cSerie = ALLTRIM(par_cSerie)
        ENDIF
        IF PCOUNT() >= 3 AND VARTYPE(par_dEmisDe) = "D"
            THIS.this_dEmisDe = par_dEmisDe
        ENDIF
        IF PCOUNT() >= 4 AND VARTYPE(par_dEmisAte) = "D"
            THIS.this_dEmisAte = par_dEmisAte
        ENDIF
        IF PCOUNT() >= 5 AND VARTYPE(par_cEDNs) = "C"
            THIS.this_cEDNs = ALLTRIM(par_cEDNs)
        ENDIF
        IF PCOUNT() >= 6 AND VARTYPE(par_cNotaIni) = "C"
            THIS.this_cNotaIni = ALLTRIM(par_cNotaIni)
        ENDIF
        IF PCOUNT() >= 7 AND VARTYPE(par_cNotaFim) = "C"
            THIS.this_cNotaFim = ALLTRIM(par_cNotaFim)
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura base do formulario de impressao de cartas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Impress" + CHR(227) + "o de Cartas"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("sigreimcBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigreimcBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar AND ;
               (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                THIS.this_oRelatorio.InicializarFiltros()
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarFiltros()
                THIS.AtualizarEstadoCampos()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
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
    * Equivalente ao cntSombra do frmrelatorio legado.
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
                .Caption   = "Impress" + CHR(227) + "o de Cartas"
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
                .Caption   = "Impress" + CHR(227) + "o de Cartas"
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
    * Geometria canonica: Left=529, Width=273, Height=80, Buttons 65x70
    * Buttons(3) Excel desabilitado (relatorio de cartas fisicas nao tem exportacao)
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
                .Themes          = .F.
                .Visible         = .T.
                .Enabled         = .F.
            ENDWITH

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
    * ConfigurarPageFrame - PageFrame com 1 pagina para campos de filtro
    * Top=80 (abaixo do cabecalho), Height=80 (160-80)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 1
        loc_oPgf.Top    = 80
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 80
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
    * ConfigurarFiltros - Cria controles de filtro na Page1 do PageFrame.
    * Equivalente aos controles Get_NotaIni, Get_NotaFim, GetCopias do legado.
    * Posicoes relativas a Page1 (page inicia em top=80 no form de height=160):
    *   Get_NotaIni: absoluto top=92 -> page top=12
    *   Get_NotaFim: absoluto top=92 -> page top=12
    *   GetCopias:   absoluto top=124 -> page top=44
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltros()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag.lbl_4c_Label1
            .Top       = 16
            .Left      = 323
            .Width     = 32
            .Height    = 17
            .Caption   = "Nota :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_NotaIni", "TextBox")
        WITH loc_oPag.txt_4c_NotaIni
            .Top         = 12
            .Left        = 357
            .Width       = 52
            .Height      = 23
            .Value       = ""
            .MaxLength   = 6
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPag.lbl_4c_Label2
            .Top       = 15
            .Left      = 414
            .Width     = 10
            .Height    = 17
            .Caption   = "a"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_NotaFim", "TextBox")
        WITH loc_oPag.txt_4c_NotaFim
            .Top         = 12
            .Left        = 424
            .Width       = 52
            .Height      = 23
            .Value       = ""
            .MaxLength   = 6
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPag.lbl_4c_Label3
            .Top       = 48
            .Left      = 349
            .Width     = 95
            .Height    = 17
            .Caption   = "N" + CHR(250) + "mero de c" + CHR(243) + "pias :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Copias", "TextBox")
        WITH loc_oPag.txt_4c_Copias
            .Top         = 44
            .Left        = 445
            .Width       = 31
            .Height      = 23
            .Value       = 1
            .InputMask   = "999"
            .MaxLength   = 3
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoCampos - Habilita/desabilita NotaIni e NotaFim conforme
    * os parametros recebidos no Init (equivalente ao evento When do legado).
    * Quando EDNs e fornecido e os valores de nota ja vem pre-definidos,
    * os campos ficam somente-leitura (usuario nao pode alterar a faixa).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarEstadoCampos()
        LOCAL loc_lBloqueado, loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_lBloqueado = (!EMPTY(THIS.this_cEDNs)) AND (!EMPTY(THIS.this_cNotaIni))
        loc_oPag.txt_4c_NotaIni.Enabled = !loc_lBloqueado

        loc_lBloqueado = (!EMPTY(THIS.this_cEDNs)) AND (!EMPTY(THIS.this_cNotaFim))
        loc_oPag.txt_4c_NotaFim.Enabled = !loc_lBloqueado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Propaga parametros recebidos no Init para o BO e campos UI.
    * Quando chamado sem parametros iniciais (abertura via menu), os valores
    * ficam vazios e o usuario preenche manualmente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPag
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_cEmp     = THIS.this_cEmp
            THIS.this_oRelatorio.this_cSerie   = THIS.this_cSerie
            THIS.this_oRelatorio.this_dEmisDe  = THIS.this_dEmisDe
            THIS.this_oRelatorio.this_dEmisAte = THIS.this_dEmisAte
            THIS.this_oRelatorio.this_cEDNs    = THIS.this_cEDNs
            THIS.this_oRelatorio.this_lEmpEdns = !EMPTY(THIS.this_cEDNs)
            THIS.this_oRelatorio.this_cNotaIni = THIS.this_cNotaIni
            THIS.this_oRelatorio.this_cNotaFim = THIS.this_cNotaFim
        ENDIF

        IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF PEMSTATUS(loc_oPag, "txt_4c_NotaIni", 5)
                loc_oPag.txt_4c_NotaIni.Value = THIS.this_cNotaIni
            ENDIF
            IF PEMSTATUS(loc_oPag, "txt_4c_NotaFim", 5)
                loc_oPag.txt_4c_NotaFim.Value = THIS.this_cNotaFim
            ENDIF
            IF PEMSTATUS(loc_oPag, "txt_4c_Copias", 5)
                loc_oPag.txt_4c_Copias.Value = IIF(VARTYPE(THIS.this_oRelatorio) = "O", ;
                    THIS.this_oRelatorio.this_nCopias, 1)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere filtros do form para o BO antes de imprimir.
    * Le NotaIni, NotaFim e Copias dos campos visuais quando disponiveis.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_cEmp     = THIS.this_cEmp
            .this_cSerie   = THIS.this_cSerie
            .this_dEmisDe  = THIS.this_dEmisDe
            .this_dEmisAte = THIS.this_dEmisAte
            .this_cEDNs    = THIS.this_cEDNs
            .this_lEmpEdns = !EMPTY(THIS.this_cEDNs)
            .this_cNotaIni = ALLTRIM(loc_oPag.txt_4c_NotaIni.Value)
            .this_cNotaFim = ALLTRIM(loc_oPag.txt_4c_NotaFim.Value)
            .this_nCopias  = loc_oPag.txt_4c_Copias.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Exibe relatorio em preview (video)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia relatorio para a impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Atualiza estado dos controles de filtro.
    * Controles ja foram criados em InicializarForm() -> ConfigurarFiltros().
    * NUNCA chamar ConfigurarFiltros() aqui: causaria "member already exists".
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - N/A para form REPORT de pagina unica.
    * Original SIGREIMC tem PageCount=1; nao ha Page2 de dados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre paginas do PageFrame.
    * Em forms tipo REPORT este form tem PageCount=1, mas o metodo eh fornecido
    * para integracao com a navegacao padrao e validacao de pagina.
    * Garante que a pagina solicitada esteja dentro do range valido e atualiza
    * o estado dos campos apos a troca (equivalente ao When do legado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_oPgf
        IF VARTYPE(par_nPagina) != "N"
            loc_nPagina = 1
        ELSE
            loc_nPagina = par_nPagina
        ENDIF

        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF

        loc_oPgf = THIS.pgf_4c_Paginas

        IF loc_nPagina < 1
            loc_nPagina = 1
        ENDIF
        IF loc_nPagina > loc_oPgf.PageCount
            loc_nPagina = loc_oPgf.PageCount
        ENDIF

        loc_oPgf.ActivePage = loc_nPagina
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Em form REPORT, "salvar" equivale a gerar/imprimir o
    * relatorio. Delega para BtnImprimirClick que envia para a impressora.
    * Permite que codigo externo (testes automatizados, atalho F10) invoque
    * a acao principal sem precisar conhecer o tipo do form.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Em form REPORT, "cancelar" equivale a fechar o
    * formulario sem gerar o relatorio. Delega para BtnSairClick.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Wrapper canonico que delega para FormParaRelatorio.
    * Em forms tipo REPORT, o "BO" eh o relatorio (sigreimcBO herda de
    * RelatorioBase). Mantem nomenclatura consistente com forms CRUD.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Le estado do BO/relatorio e propaga para os campos visuais.
    * Usado quando o BO recebeu valores externamente (ex: chamada de outro
    * form via parametros) e o form precisa refletir esses valores nos
    * TextBoxes da pagina de filtros.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPag
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF PEMSTATUS(loc_oPag, "txt_4c_NotaIni", 5)
            loc_oPag.txt_4c_NotaIni.Value = THIS.this_oRelatorio.this_cNotaIni
        ENDIF
        IF PEMSTATUS(loc_oPag, "txt_4c_NotaFim", 5)
            loc_oPag.txt_4c_NotaFim.Value = THIS.this_oRelatorio.this_cNotaFim
        ENDIF
        IF PEMSTATUS(loc_oPag, "txt_4c_Copias", 5)
            loc_oPag.txt_4c_Copias.Value = THIS.this_oRelatorio.this_nCopias
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Forms tipo REPORT nao possuem grid de registros para
    * listar; "carregar lista" aqui significa preparar os campos de filtro
    * com os valores correntes do BO via BOParaForm(). Retorna .T. para
    * indicar sucesso e satisfaz a interface esperada por FormBase.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        THIS.BOParaForm()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO (Custom nao tem Release, atribuir .NULL. e suficiente)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
