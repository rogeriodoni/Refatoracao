*==============================================================================
* FORMSIGREIMP.PRG
* Formulario de Relatorio - Comparativo de Impostos
*
* Herda de FormBase
* Form original: SIGREIMP.SCX (frmrelatorio)
* Tipo: RELATORIO (Layout: cabecalho + botoes + PageFrame com filtros)
* Layout original: 800x500  ->  novo: 1000x600
*
* FASE 3/8 - Form - Estrutura Base
*   * DEFINE CLASS Formsigreimp AS FormBase
*   * Propriedades (this_oRelatorio, DataSession)
*   * Init() retorna DODEFAULT()
*   * InicializarForm() cria BO e configura estrutura base
*   * ConfigurarCabecalho() - container cinza superior com titulo
*   * ConfigurarBotoes() - CommandGroup com 4 botoes (Visualizar/Imprimir/Excel/Sair)
*   * ConfigurarPageFrame() - PageFrame com Page1 (Filtros)
*   * Destroy() - libera BO
*
* FASE 4/8 - Form - Filtros e Grades na Page1
*   * ConfigurarPaginaLista() - orquestra configuracao de Page1 (filtros + grades)
*   * ConfigurarFiltrosData() - periodo, datas e checkbox SubTotDat
*   * ConfigurarFiltroEmpresa() - campos codigo e descricao empresa
*   * ConfigurarFiltroConta() - campos codigo e descricao conta
*   * ConfigurarOpcoes() - OptionGroup Detalhado/Resumido
*   * ConfigurarLabelsGrades() - labels acima das grades
*   * ConfigurarGradeEntradas() - grd_4c_OperacoesE com CheckBox
*   * ConfigurarGradeSaidas() - grd_4c_OperacoesS com CheckBox
*   * ConfigurarBotoesGradeEntradas() - cmg_4c_BtnGradeE (Marcar/Desmarcar)
*   * ConfigurarBotoesGradeSaidas() - cmg_4c_BtnGradeS (Marcar/Desmarcar)
*   * VincularEventos() - BINDEVENTs para botoes e campos
*   * FormParaRelatorio() - transfere valores do form para o BO
*   * LimparCampos() - inicializa campos com valores padrao
*   * InicializarEmpresa() - carrega empresa corrente do sistema
*   * AlternarPagina() - navega entre paginas do PageFrame
*   * Handlers: BtnVisualizarClick, BtnImprimirClick, BtnEncerrarClick
*   * Handlers: CmgGradeEClick, CmgGradeSClick
*   * Handlers: TeclaEmpresa, TeclaDEmpresa, TeclaConta, TeclaDConta
*   * Handlers: OptTiposChange, QuandoDEmpresa, QuandoDConta
*   * ValidarCodigoEmpresa, ValidarCodigoConta
*   * AbrirBuscaEmpresa, AbrirBuscaConta
*
* FASE 5/8 - Form - Campos Principais (Parte 1)
*   * ConfigurarPaginaDados() - orquestra configuracao adicional (eventos de grades
*     e visibilidade de controles)
*   * ConfigurarEventosCheckGradeE() - BINDEVENT em grd_4c_OperacoesE.Column1.Check1
*     (Click, KeyPress) para replicar Replace SelImp do original
*   * ConfigurarEventosCheckGradeS() - BINDEVENT em grd_4c_OperacoesS.Column1.Check1
*     (Click, KeyPress) para replicar Replace SelImp do original
*   * Handlers (PUBLIC) do checkbox da grade de Entradas:
*       CheckGradeEClick    - toggle SelImp via clique do mouse
*       CheckGradeEKeyPress - toggle SelImp via ENTER (13) ou ESPACO (32)
*   * Handlers (PUBLIC) do checkbox da grade de Saidas:
*       CheckGradeSClick    - toggle SelImp via clique do mouse
*       CheckGradeSKeyPress - toggle SelImp via ENTER (13) ou ESPACO (32)
*   * TornarControlesVisiveis() - helper recursivo que garante .Visible = .T. em
*     todos os controles aninhados (Pages e Controls). Compensa o default .F. de
*     AddObject e evita formulario "em branco" apos configuracao programatica.
*   * ConfigurarValoresIniciaisFiltros() - garante datas, opcoes e sinalizadores
*     com valores default consistentes (mesma logica do Init do original)
*   * AtualizarVisibilidadeFiltros() - sincroniza Enabled/Visible dos campos de
*     descricao (DEmpresa, DConta) com o estado do codigo correspondente
*
* FASE 6/8 - Form - Campos Restantes e Lookups (Complementacao)
*   * HeaderHeight=0, AllowHeaderSizing=.F., AllowRowSizing=.F. nos grids
*     (replica propriedades do original que ocultam cabecalhos das grades)
*   * Column1.Sparse=.F. - CheckBox visivel em TODAS as linhas do grid,
*     nao apenas na linha corrente (PILAR 1 - fidelidade visual ao original)
*   * BINDEVENT chk_4c_ChkSubTotDat.When -> QuandoSubTotDat
*     Replica: chkSubTotDat.When = Return (optTipos.Value = 1) do original
*   * QuandoSubTotDat() - permite foco no checkbox apenas no modo Detalhado
*   * BtnVisualizarClick / BtnImprimirClick com refresh de grade antes do
*     processamento - replica Go Bottom/Refresh/Go Top do btnReport.Click
*     original para garantir que ultimo estado de CheckBox seja commitado
*
* FASE 7/8 - Form - Eventos Principais (CONCLUIDA em fases anteriores)
*   Formulario tipo RELATORIO (frmrelatorio): os "eventos principais" sao os
*   handlers dos botoes do cmg_4c_Botoes, todos ja implementados na Fase 4:
*   * BtnVisualizarClick() - preview na tela (Buttons(1))
*     - Refresh de grade para commitar ultimo CheckBox
*     - FormParaRelatorio() + ValidarFiltros() + BO.Visualizar()
*   * BtnImprimirClick() - envio para impressora (Buttons(2))
*     - Mesma logica de refresh + FormParaRelatorio() + ValidarFiltros() + BO.Imprimir()
*   * BtnEncerrarClick() - fecha formulario (Buttons(4))
*     - THIS.Release()
*   Nota: para CRUD, "eventos principais" seriam BtnIncluirClick/BtnAlterarClick/
*   BtnExcluirClick (navegacao para Page2). REPORT nao tem Page2.
*
* FASE 8/8 - Eventos Auxiliares e Consolidacao Final (CONCLUIDA)
*   Por se tratar de form REPORT (frmrelatorio), os "eventos auxiliares" sao
*   os equivalentes nao-CRUD ja implementados nas fases anteriores:
*
*   - BtnVisualizarClick / BtnImprimirClick   -> equivalentes a BtnBuscarClick
*       (acao principal: gerar relatorio em preview / impressora)
*   - BtnEncerrarClick                        -> equivalente a BtnCancelarClick
*       (fecha o formulario via THIS.Release())
*   - FormParaRelatorio()                     -> equivalente a FormParaBO()
*       (TODOS os 8 filtros: DtInicial, DtFinal, Empresa, DEmpresa, Conta,
*        DConta, SubTotDat, OptTipos)
*   - LimparCampos()                          -> equivalente a LimparCampos CRUD
*       (datas=DATE(), strings="", check=0, opt=1 Detalhado)
*   - CarregarTiposOperacoes (no BO)          -> equivalente a CarregarLista
*       (popula cursores csOperacoesE/csOperacoesS a partir de SigCdTom)
*   - AtualizarVisibilidadeFiltros            -> equivalente a HabilitarCampos
*       (sincroniza Enabled dos campos de descricao via When original)
*
*   REPORT nao tem AjustarBotoesPorModo (botoes sempre habilitados),
*   nem BtnSalvarClick (nao persiste dados), nem CarregarLista (sem grid de
*   registros principal - so grades de selecao de operacoes).
*
*   INTEGRACAO:
*   - config.prg: ADIR() em start/config.prg ja carrega *BO.prg e Form*.prg
*     automaticamente (linhas 263 e 293). Nenhuma alteracao manual necessaria.
*   - menu.prg: BAR 154 (separador) + BAR 155 ("Comparativo de Impostos") no
*     popRelatorios apos BAR 153. ON SELECTION BAR 155 -> AbrirFormsigreimp.
*     PROCEDURE AbrirFormsigreimp() criada no fim do menu.prg seguindo o
*     padrao canonico (VARTYPE = "O", Show() sem parametro, sem .Release()
*     apos Show, MostrarErro para excecoes).
*==============================================================================

DEFINE CLASS Formsigreimp AS FormBase

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

    *-- Objeto de negocio do relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Apenas delega para FormBase.Init() (que chama InicializarForm)
    * NAO chamar THIS.InicializarForm() aqui (duplicaria AddObject)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura completa do formulario de relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            *-- Caption do formulario
            THIS.Caption = "Relat" + CHR(243) + "rio Comparativo de Impostos"

            *-- Garantir variavel global de icones
            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF

            *-- Fundo do form
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Criar BO do relatorio
            THIS.this_oRelatorio = CREATEOBJECT("sigreimpBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigreimpBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            *-- Carregar cursores de tipos de operacoes somente com conexao SQL
            IF loc_lContinuar AND ;
               (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                THIS.this_oRelatorio.CarregarTiposOperacoes()
            ENDIF

            IF loc_lContinuar
                *-- Estrutura visual base
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()

                *-- Propagar Caption para labels do cabecalho
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Fase 4: controles de filtro e grades na Page1
                THIS.ConfigurarPaginaLista()

                *-- Fase 5: eventos adicionais e ajustes de comportamento
                THIS.ConfigurarPaginaDados()

                *-- Vincular eventos dos botoes e campos
                THIS.VincularEventos()

                *-- Inicializar campos com valores padrao
                THIS.LimparCampos()
                THIS.ConfigurarValoresIniciaisFiltros()

                *-- Carregar empresa atual (requer conexao SQL)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.InicializarEmpresa()
                ENDIF

                *-- Garantir visibilidade de todos os controles aninhados
                THIS.TornarControlesVisiveis(THIS)

                THIS.AtualizarVisibilidadeFiltros()

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
                .Height    = 40
                .Caption   = "Relat" + CHR(243) + "rio Comparativo de Impostos"
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
                .Height    = 40
                .Caption   = "Relat" + CHR(243) + "rio Comparativo de Impostos"
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
    * ConfigurarBotoes - CommandGroup canonico com 4 botoes de relatorio
    * Padrao frmrelatorio: Visualizar / Imprimir / Excel / Encerrar
    * Geometria EXATA do framework.vcx:
    *   cmg_4c_Botoes: Top=0, Left=727, Width=273, Height=80, ButtonCount=4
    *   Lefts dos botoes: 5, 71, 137, 203 (incrementos de 66)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")

        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 727
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
                .ToolTipText     = "Arquivos Email"
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
    * Top=80 (abaixo do cabecalho), Height ocupa restante (Form.Height - 80)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 1
        loc_oPgf.Top       = 80
        loc_oPgf.Left      = -1
        loc_oPgf.Width     = THIS.Width + 2
        loc_oPgf.Height    = THIS.Height - 80
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
    * ConfigurarPaginaLista - Orquestra configuracao completa de Page1
    * Em form REPORT, "Lista" eh a pagina de filtros + grades de selecao
    * Chamado em InicializarForm apos ConfigurarPageFrame
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        THIS.ConfigurarFiltrosData(loc_oPagina)
        THIS.ConfigurarFiltroEmpresa(loc_oPagina)
        THIS.ConfigurarFiltroConta(loc_oPagina)
        THIS.ConfigurarOpcoes(loc_oPagina)
        THIS.ConfigurarLabelsGrades(loc_oPagina)
        THIS.ConfigurarGradeEntradas(loc_oPagina)
        THIS.ConfigurarGradeSaidas(loc_oPagina)
        THIS.ConfigurarBotoesGradeEntradas(loc_oPagina)
        THIS.ConfigurarBotoesGradeSaidas(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltrosData - Adiciona campos de periodo e checkbox SubTotDat
    * Linha superior do formulario: DtInicial a DtFinal [Totalizar Por Datas]
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltrosData(par_oPagina)
        par_oPagina.AddObject("lbl_4c_Periodo", "Label")
        WITH par_oPagina.lbl_4c_Periodo
            .Top       = 23
            .Left      = 30
            .Width     = 68
            .Height    = 18
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
        WITH par_oPagina.txt_4c_DtInicial
            .Top       = 18
            .Left      = 102
            .Width     = 90
            .Height    = 25
            .Format    = "D"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Value     = {}
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_A", "Label")
        WITH par_oPagina.lbl_4c_A
            .Top       = 23
            .Left      = 196
            .Width     = 16
            .Height    = 18
            .Caption   = "a"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
        WITH par_oPagina.txt_4c_DtFinal
            .Top       = 18
            .Left      = 216
            .Width     = 90
            .Height    = 25
            .Format    = "D"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Value     = {}
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("chk_4c_ChkSubTotDat", "CheckBox")
        WITH par_oPagina.chk_4c_ChkSubTotDat
            .Top       = 111
            .Left      = 320
            .Width     = 185
            .Height    = 25
            .Caption   = "Totalizar Por Datas"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltroEmpresa - Adiciona campos codigo e descricao de empresa
    * Original: getEmpresa (codigo) + getDEmpresa (descricao)
    * getDEmpresa.When = Return Empty(getEmpresa.Value) - gerenciado via BINDEVENT
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltroEmpresa(par_oPagina)
        par_oPagina.AddObject("lbl_4c_LblEmpresa", "Label")
        WITH par_oPagina.lbl_4c_LblEmpresa
            .Top       = 55
            .Left      = 30
            .Width     = 68
            .Height    = 18
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Empresa", "TextBox")
        WITH par_oPagina.txt_4c_Empresa
            .Top       = 50
            .Left      = 102
            .Width     = 42
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_DEmpresa", "TextBox")
        WITH par_oPagina.txt_4c_DEmpresa
            .Top       = 50
            .Left      = 148
            .Width     = 363
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltroConta - Adiciona campos codigo e descricao de conta
    * Original: getConta (codigo) + getDConta (descricao)
    * getDConta.When = Return Empty(getConta.Value) - gerenciado via BINDEVENT
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltroConta(par_oPagina)
        par_oPagina.AddObject("lbl_4c_LblConta", "Label")
        WITH par_oPagina.lbl_4c_LblConta
            .Top       = 87
            .Left      = 30
            .Width     = 68
            .Height    = 18
            .Caption   = "Conta :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Conta", "TextBox")
        WITH par_oPagina.txt_4c_Conta
            .Top       = 82
            .Left      = 102
            .Width     = 100
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_DConta", "TextBox")
        WITH par_oPagina.txt_4c_DConta
            .Top       = 82
            .Left      = 206
            .Width     = 363
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarOpcoes - Adiciona OptionGroup Detalhado/Resumido
    * Original: optTipos (fwoption) - Value=1 Detalhado, Value=2 Resumido
    * chkSubTotDat.When = Return (optTipos.Value = 1) - gerenciado via handler
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarOpcoes(par_oPagina)
        par_oPagina.AddObject("lbl_4c_LblTipo", "Label")
        WITH par_oPagina.lbl_4c_LblTipo
            .Top       = 120
            .Left      = 30
            .Width     = 68
            .Height    = 18
            .Caption   = "Tipo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("opt_4c_OptTipos", "OptionGroup")
        WITH par_oPagina.opt_4c_OptTipos
            .Top         = 188
            .Left        = 92
            .Width       = 200
            .Height      = 28
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Themes      = .F.
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Detalhado"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Top       = 3
                .Left      = 5
                .Width     = 90
                .Height    = 20
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Resumido"
                .Top       = 3
                .Left      = 100
                .Width     = 90
                .Height    = 20
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarLabelsGrades - Labels de titulo para as duas grades
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarLabelsGrades(par_oPagina)
        par_oPagina.AddObject("lbl_4c_LblEntradas", "Label")
        WITH par_oPagina.lbl_4c_LblEntradas
            .Top       = 152
            .Left      = 30
            .Width     = 460
            .Height    = 18
            .Caption   = "Tipos de Opera" + CHR(231) + CHR(245) + "es de Entradas"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_LblSaidas", "Label")
        WITH par_oPagina.lbl_4c_LblSaidas
            .Top       = 152
            .Left      = 510
            .Width     = 460
            .Height    = 18
            .Caption   = "Tipos de Opera" + CHR(231) + CHR(245) + "es de Sa" + CHR(237) + "das"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGradeEntradas - Grade de tipos de operacoes de Entradas
    * Column1: CheckBox para selecao (SelImp)
    * Column2: Codigo (Codigos, numerico, somente leitura)
    * Column3: Descricao (Descrs, char, somente leitura)
    * Regra: Column1.AddObject("Check1") ANTES de CurrentControl
    *        ControlSource APENAS no Column, NUNCA no Check1
    *        ControlSource definido DEPOIS de CurrentControl e RecordSource
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradeEntradas(par_oPagina)
        LOCAL loc_oCursor
        loc_oCursor = THIS.this_oRelatorio.this_cCursorOperacoesE

        par_oPagina.AddObject("grd_4c_OperacoesE", "Grid")

        WITH par_oPagina.grd_4c_OperacoesE
            .Top                = 173
            .Left               = 30
            .Width              = 460
            .Height             = 220
            .ColumnCount        = 3
            .FontName           = "Tahoma"
            .FontSize           = 8
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .HeaderHeight       = 0
            .AllowHeaderSizing  = .F.
            .AllowRowSizing     = .F.
            .Themes             = .F.
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .GridLineColor      = RGB(238, 238, 238)
            .BackColor          = RGB(255, 255, 255)
            .ScrollBars         = 2
            .RowHeight          = 18

            *-- Column 1: CheckBox para selecao
            *-- Sparse=.F. garante checkbox visivel em TODAS as linhas (nao apenas na corrente)
            .Column1.Width = 30
            .Column1.AddObject("Check1", "CheckBox")
            WITH .Column1.Check1
                .Caption = ""
                .Top     = 0
                .Left    = 2
                .Width   = 22
                .Height  = 17
                .Visible = .T.
            ENDWITH
            .Column1.Check1.Caption = ""
            .Column1.CurrentControl = "Check1"
            .Column1.Sparse         = .F.

            *-- Column 2: Codigo (somente leitura)
            .Column2.Width    = 55
            .Column2.ReadOnly = .T.

            *-- Column 3: Descricao (somente leitura)
            .Column3.Width    = 360
            .Column3.ReadOnly = .T.

            *-- RecordSource apos CurrentControl (pode resetar ControlSources)
            IF USED(loc_oCursor)
                .RecordSource = loc_oCursor
            ENDIF

            *-- ControlSources apos RecordSource e apos CurrentControl
            IF USED(loc_oCursor)
                .Column1.ControlSource = loc_oCursor + ".SelImp"
                .Column2.ControlSource = loc_oCursor + ".Codigos"
                .Column3.ControlSource = loc_oCursor + ".Descrs"
            ENDIF

            *-- Headers (ocultos por HeaderHeight=0, mantidos para referencia)
            .Column1.Header1.Caption = ""
            .Column2.Header1.Caption = ""
            .Column3.Header1.Caption = "C" + CHR(243) + "digos"

            .FontName = "Verdana"
            .FontSize = 8

            .Visible = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGradeSaidas - Grade de tipos de operacoes de Saidas
    * Estrutura identica a grd_4c_OperacoesE
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradeSaidas(par_oPagina)
        LOCAL loc_oCursor
        loc_oCursor = THIS.this_oRelatorio.this_cCursorOperacoesS

        par_oPagina.AddObject("grd_4c_OperacoesS", "Grid")

        WITH par_oPagina.grd_4c_OperacoesS
            .Top                = 173
            .Left               = 510
            .Width              = 460
            .Height             = 220
            .ColumnCount        = 3
            .FontName           = "Tahoma"
            .FontSize           = 8
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .HeaderHeight       = 0
            .AllowHeaderSizing  = .F.
            .AllowRowSizing     = .F.
            .Themes             = .F.
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .GridLineColor      = RGB(238, 238, 238)
            .BackColor          = RGB(255, 255, 255)
            .ScrollBars         = 2
            .RowHeight          = 18

            *-- Sparse=.F. garante checkbox visivel em TODAS as linhas
            .Column1.Width = 30
            .Column1.AddObject("Check1", "CheckBox")
            WITH .Column1.Check1
                .Caption = ""
                .Top     = 0
                .Left    = 2
                .Width   = 22
                .Height  = 17
                .Visible = .T.
            ENDWITH
            .Column1.Check1.Caption = ""
            .Column1.CurrentControl = "Check1"
            .Column1.Sparse         = .F.

            .Column2.Width    = 55
            .Column2.ReadOnly = .T.

            .Column3.Width    = 360
            .Column3.ReadOnly = .T.

            IF USED(loc_oCursor)
                .RecordSource = loc_oCursor
            ENDIF

            IF USED(loc_oCursor)
                .Column1.ControlSource = loc_oCursor + ".SelImp"
                .Column2.ControlSource = loc_oCursor + ".Codigos"
                .Column3.ControlSource = loc_oCursor + ".Descrs"
            ENDIF

            *-- Headers (ocultos por HeaderHeight=0, mantidos para referencia)
            .Column1.Header1.Caption = ""
            .Column2.Header1.Caption = ""
            .Column3.Header1.Caption = "C" + CHR(243) + "digos"

            .FontName = "Verdana"
            .FontSize = 8

            .Visible = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesGradeEntradas - CommandGroup Marcar/Desmarcar Todos
    * para a grade de Entradas (cmg_4c_BtnGradeE)
    * Posicionado centralizado abaixo de grd_4c_OperacoesE
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesGradeEntradas(par_oPagina)
        par_oPagina.AddObject("cmg_4c_BtnGradeE", "CommandGroup")

        WITH par_oPagina.cmg_4c_BtnGradeE
            .Top         = 400
            .Left        = 167
            .Width       = 185
            .Height      = 42
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.
            .Visible     = .T.

            WITH .Buttons(1)
                .Top        = 2
                .Left       = 2
                .Width      = 88
                .Height     = 34
                .Caption    = "Marcar Todos"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .BackColor  = RGB(255, 255, 255)
                .ForeColor  = RGB(90, 90, 90)
                .Themes     = .F.
                .Visible    = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top        = 2
                .Left       = 94
                .Width      = 88
                .Height     = 34
                .Caption    = "Desmarcar Todos"
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .BackColor  = RGB(255, 255, 255)
                .ForeColor  = RGB(90, 90, 90)
                .Themes     = .F.
                .Visible    = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesGradeSaidas - CommandGroup Marcar/Desmarcar Todos
    * para a grade de Saidas (cmg_4c_BtnGradeS)
    * Posicionado centralizado abaixo de grd_4c_OperacoesS
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesGradeSaidas(par_oPagina)
        par_oPagina.AddObject("cmg_4c_BtnGradeS", "CommandGroup")

        WITH par_oPagina.cmg_4c_BtnGradeS
            .Top         = 400
            .Left        = 647
            .Width       = 185
            .Height      = 42
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.
            .Visible     = .T.

            WITH .Buttons(1)
                .Top        = 2
                .Left       = 2
                .Width      = 88
                .Height     = 34
                .Caption    = "Marcar Todos"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .BackColor  = RGB(255, 255, 255)
                .ForeColor  = RGB(90, 90, 90)
                .Themes     = .F.
                .Visible    = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top        = 2
                .Left       = 94
                .Width      = 88
                .Height     = 34
                .Caption    = "Desmarcar Todos"
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .BackColor  = RGB(255, 255, 255)
                .ForeColor  = RGB(90, 90, 90)
                .Themes     = .F.
                .Visible    = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularEventos - BINDEVENT para todos os botoes e campos interativos
    * TODOS os handlers devem ser PUBLIC (sem PROTECTED) para BINDEVENT funcionar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularEventos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Botoes do cabecalho (CommandGroup cmg_4c_Botoes)
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")

        *-- Botoes das grades de operacoes
        BINDEVENT(loc_oPagina.cmg_4c_BtnGradeE, "Click", THIS, "CmgGradeEClick")
        BINDEVENT(loc_oPagina.cmg_4c_BtnGradeS, "Click", THIS, "CmgGradeSClick")

        *-- Campos de empresa: KeyPress para F4/ENTER lookup e When para acesso
        BINDEVENT(loc_oPagina.txt_4c_Empresa,  "KeyPress", THIS, "TeclaEmpresa")
        BINDEVENT(loc_oPagina.txt_4c_DEmpresa, "KeyPress", THIS, "TeclaDEmpresa")
        BINDEVENT(loc_oPagina.txt_4c_DEmpresa, "When",     THIS, "QuandoDEmpresa")

        *-- Campos de conta: KeyPress para F4/ENTER lookup e When para acesso
        BINDEVENT(loc_oPagina.txt_4c_Conta,  "KeyPress", THIS, "TeclaConta")
        BINDEVENT(loc_oPagina.txt_4c_DConta, "KeyPress", THIS, "TeclaDConta")
        BINDEVENT(loc_oPagina.txt_4c_DConta, "When",     THIS, "QuandoDConta")

        *-- OptionGroup: mudanca de tipo Detalhado/Resumido
        BINDEVENT(loc_oPagina.opt_4c_OptTipos, "InteractiveChange", THIS, "OptTiposChange")

        *-- Checkbox SubTotDat: When -> permite foco apenas em modo Detalhado
        *-- Replica: chkSubTotDat.When = Return (optTipos.Value = 1) do original
        BINDEVENT(loc_oPagina.chk_4c_ChkSubTotDat, "When", THIS, "QuandoSubTotDat")
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos campos do form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        WITH THIS.this_oRelatorio
            .this_dDtInicial  = loc_oPagina.txt_4c_DtInicial.Value
            .this_dDtFinal    = loc_oPagina.txt_4c_DtFinal.Value
            .this_cEmpresa    = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
            .this_cDEmpresa   = ALLTRIM(loc_oPagina.txt_4c_DEmpresa.Value)
            .this_cConta      = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
            .this_cDConta     = ALLTRIM(loc_oPagina.txt_4c_DConta.Value)
            .this_lSubTotDat  = (loc_oPagina.chk_4c_ChkSubTotDat.Value = 1)
            .this_nTipos      = loc_oPagina.opt_4c_OptTipos.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa campos com valores padrao
    * Data = hoje, demais campos em branco, opcao Detalhado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        WITH loc_oPagina
            .txt_4c_DtInicial.Value      = DATE()
            .txt_4c_DtFinal.Value        = DATE()
            .txt_4c_Empresa.Value        = ""
            .txt_4c_DEmpresa.Value       = ""
            .txt_4c_Conta.Value          = ""
            .txt_4c_DConta.Value         = ""
            .chk_4c_ChkSubTotDat.Value   = 0
            .chk_4c_ChkSubTotDat.Enabled = .T.
            .opt_4c_OptTipos.Value       = 1
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarEmpresa - Preenche empresa atual do sistema nos campos
    * Usa go_4c_Sistema.cCodEmpresa (substitui _Empr do legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarEmpresa()
        LOCAL loc_cCodEmpresa, loc_cSQL, loc_nResult, loc_oErro
        loc_cCodEmpresa = ""

        TRY
            IF TYPE("go_4c_Sistema") = "O" AND VARTYPE(go_4c_Sistema) = "O"
                loc_cCodEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            ENDIF

            IF !EMPTY(loc_cCodEmpresa)
                THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = loc_cCodEmpresa

                loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
                    EscaparSQL(loc_cCodEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpIni")

                IF loc_nResult > 0
                    SELECT cursor_4c_EmpIni
                    IF !EOF()
                        THIS.pgf_4c_Paginas.Page1.txt_4c_DEmpresa.Value = ;
                            ALLTRIM(cursor_4c_EmpIni.Razas)
                    ENDIF
                    IF USED("cursor_4c_EmpIni")
                        USE IN cursor_4c_EmpIni
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega para pagina especificada no PageFrame
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Gera relatorio em preview na tela
    * Handler do Buttons(1) do cmg_4c_Botoes (BINDEVENT - deve ser PUBLIC)
    * Fase 6: Refresh de grade antes do processamento replica o
    * Go Bottom/Refresh/Go Top do btnReport.Click do original, garantindo
    * que o ultimo estado do CheckBox seja commitado no cursor antes de filtrar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oPagina, loc_cCursorE, loc_cCursorS
        loc_oPagina  = THIS.pgf_4c_Paginas.Page1
        loc_cCursorE = THIS.this_oRelatorio.this_cCursorOperacoesE
        loc_cCursorS = THIS.this_oRelatorio.this_cCursorOperacoesS

        *-- Refresh grids para garantir ultimo estado do CheckBox no cursor
        IF USED(loc_cCursorE) AND VARTYPE(loc_oPagina.grd_4c_OperacoesE) = "O"
            SELECT (loc_cCursorE)
            GO BOTTOM
            loc_oPagina.grd_4c_OperacoesE.Refresh()
            GO TOP
        ENDIF
        IF USED(loc_cCursorS) AND VARTYPE(loc_oPagina.grd_4c_OperacoesS) = "O"
            SELECT (loc_cCursorS)
            GO BOTTOM
            loc_oPagina.grd_4c_OperacoesS.Refresh()
            GO TOP
        ENDIF

        THIS.FormParaRelatorio()
        IF THIS.this_oRelatorio.ValidarFiltros()
            IF !THIS.this_oRelatorio.Visualizar()
                MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Relat" + CHR(243) + "rio")
            ENDIF
        ELSE
            MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
                "Filtros Inv" + CHR(225) + "lidos")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia relatorio para impressora com dialogo
    * Handler do Buttons(2) do cmg_4c_Botoes (BINDEVENT - deve ser PUBLIC)
    * Fase 6: Mesmo refresh de grade do BtnVisualizarClick.
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oPagina, loc_cCursorE, loc_cCursorS
        loc_oPagina  = THIS.pgf_4c_Paginas.Page1
        loc_cCursorE = THIS.this_oRelatorio.this_cCursorOperacoesE
        loc_cCursorS = THIS.this_oRelatorio.this_cCursorOperacoesS

        *-- Refresh grids para garantir ultimo estado do CheckBox no cursor
        IF USED(loc_cCursorE) AND VARTYPE(loc_oPagina.grd_4c_OperacoesE) = "O"
            SELECT (loc_cCursorE)
            GO BOTTOM
            loc_oPagina.grd_4c_OperacoesE.Refresh()
            GO TOP
        ENDIF
        IF USED(loc_cCursorS) AND VARTYPE(loc_oPagina.grd_4c_OperacoesS) = "O"
            SELECT (loc_cCursorS)
            GO BOTTOM
            loc_oPagina.grd_4c_OperacoesS.Refresh()
            GO TOP
        ENDIF

        THIS.FormParaRelatorio()
        IF THIS.this_oRelatorio.ValidarFiltros()
            IF !THIS.this_oRelatorio.Imprimir()
                MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Relat" + CHR(243) + "rio")
            ENDIF
        ELSE
            MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
                "Filtros Inv" + CHR(225) + "lidos")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    * Handler do Buttons(4) do cmg_4c_Botoes (BINDEVENT - deve ser PUBLIC)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * CmgGradeEClick - Marcar ou desmarcar todos os tipos de Entradas
    * Buttons(1) = Marcar Todos (Value=1 -> SelImp=.T.)
    * Buttons(2) = Desmarcar Todos (Value=2 -> SelImp=.F.)
    * Handler BINDEVENT do cmg_4c_BtnGradeE - deve ser PUBLIC
    *--------------------------------------------------------------------------
    PROCEDURE CmgGradeEClick()
        LOCAL loc_oPagina, loc_cCursor, loc_lMarcar
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cCursor = THIS.this_oRelatorio.this_cCursorOperacoesE
        loc_lMarcar = (loc_oPagina.cmg_4c_BtnGradeE.Value = 1)

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            REPLACE ALL SelImp WITH loc_lMarcar
            GO TOP
            loc_oPagina.grd_4c_OperacoesE.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmgGradeSClick - Marcar ou desmarcar todos os tipos de Saidas
    * Handler BINDEVENT do cmg_4c_BtnGradeS - deve ser PUBLIC
    *--------------------------------------------------------------------------
    PROCEDURE CmgGradeSClick()
        LOCAL loc_oPagina, loc_cCursor, loc_lMarcar
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cCursor = THIS.this_oRelatorio.this_cCursorOperacoesS
        loc_lMarcar = (loc_oPagina.cmg_4c_BtnGradeS.Value = 1)

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            REPLACE ALL SelImp WITH loc_lMarcar
            GO TOP
            loc_oPagina.grd_4c_OperacoesS.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaEmpresa - KeyPress no campo codigo empresa
    * F4(115): abre lookup  |  ENTER(13)/TAB(9): valida codigo digitado
    * Handler BINDEVENT - deve ser PUBLIC
    *--------------------------------------------------------------------------
    PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCodigoEmpresa()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDEmpresa - KeyPress no campo descricao empresa
    * Ativo somente quando codigo empresa esta vazio (When controlado via BINDEVENT)
    * F4(115) ou ENTER/TAB: abre lookup de empresa para busca por nome
    * Handler BINDEVENT - deve ser PUBLIC
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDEmpresa(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaConta - KeyPress no campo codigo conta
    * F4(115): abre lookup  |  ENTER(13)/TAB(9): valida codigo digitado
    * Handler BINDEVENT - deve ser PUBLIC
    *--------------------------------------------------------------------------
    PROCEDURE TeclaConta(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaConta()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCodigoConta()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDConta - KeyPress no campo descricao conta
    * Ativo somente quando codigo conta esta vazio (When controlado via BINDEVENT)
    * F4(115) ou ENTER/TAB: abre lookup de conta para busca por nome
    * Handler BINDEVENT - deve ser PUBLIC
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDConta(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OptTiposChange - Reage a mudanca do tipo de relatorio
    * Quando Resumido (Value=2): desabilita chkSubTotDat e desmarca
    * Quando Detalhado (Value=1): reabilita chkSubTotDat
    * Handler BINDEVENT - deve ser PUBLIC
    *--------------------------------------------------------------------------
    PROCEDURE OptTiposChange()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        IF loc_oPagina.opt_4c_OptTipos.Value = 2
            loc_oPagina.chk_4c_ChkSubTotDat.Value   = 0
            loc_oPagina.chk_4c_ChkSubTotDat.Enabled = .F.
        ELSE
            loc_oPagina.chk_4c_ChkSubTotDat.Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * QuandoDEmpresa - When handler para txt_4c_DEmpresa
    * Retorna .T. (permite foco) somente quando codigo empresa esta vazio
    * Replica comportamento getDEmpresa.When do original
    * Handler BINDEVENT - deve ser PUBLIC
    *--------------------------------------------------------------------------
    PROCEDURE QuandoDEmpresa()
        RETURN EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value))
    ENDPROC

    *--------------------------------------------------------------------------
    * QuandoDConta - When handler para txt_4c_DConta
    * Retorna .T. (permite foco) somente quando codigo conta esta vazio
    * Replica comportamento getDConta.When do original
    * Handler BINDEVENT - deve ser PUBLIC
    *--------------------------------------------------------------------------
    PROCEDURE QuandoDConta()
        RETURN EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value))
    ENDPROC

    *--------------------------------------------------------------------------
    * QuandoSubTotDat - When handler para chk_4c_ChkSubTotDat
    * Retorna .T. (permite foco) somente quando Detalhado esta selecionado
    * Replica comportamento chkSubTotDat.When = Return (optTipos.Value = 1)
    * Handler BINDEVENT - deve ser PUBLIC
    *--------------------------------------------------------------------------
    PROCEDURE QuandoSubTotDat()
        RETURN (THIS.pgf_4c_Paginas.Page1.opt_4c_OptTipos.Value = 1)
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaEmpresa - Abre FormBuscaAuxiliar para selecionar empresa
    * Preenche txt_4c_Empresa e txt_4c_DEmpresa com o resultado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oLookup, loc_oPagina, loc_cValorInicial, loc_oErro
        loc_oPagina     = THIS.pgf_4c_Paginas.Page1
        loc_cValorInicial = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)

        TRY
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                "SigCdEmp", ;
                "Cemps", ;
                "Razas", ;
                loc_cValorInicial)

            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou
                    loc_oPagina.txt_4c_Empresa.Value  = ALLTRIM(loc_oLookup.this_cCodigo)
                    loc_oPagina.txt_4c_DEmpresa.Value = ALLTRIM(loc_oLookup.this_cDescricao)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaConta - Abre FormBuscaAuxiliar para selecionar conta (cliente)
    * Busca em SigCdCli (IClis = codigo, Razaos = descricao)
    * Preenche txt_4c_Conta e txt_4c_DConta com o resultado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaConta()
        LOCAL loc_oLookup, loc_oPagina, loc_cValorInicial, loc_oErro
        loc_oPagina     = THIS.pgf_4c_Paginas.Page1
        loc_cValorInicial = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)

        TRY
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                "SigCdCli", ;
                "IClis", ;
                "Razaos", ;
                loc_cValorInicial)

            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou
                    loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(loc_oLookup.this_cCodigo)
                    loc_oPagina.txt_4c_DConta.Value = ALLTRIM(loc_oLookup.this_cDescricao)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodigoEmpresa - Valida codigo digitado em txt_4c_Empresa
    * Se encontrado: preenche descricao. Se nao encontrado: abre lookup.
    * Replica logica de getEmpresa.Valid do original
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCodigoEmpresa()
        LOCAL loc_oPagina, loc_cCodigo, loc_cSQL, loc_nResult, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)

        IF EMPTY(loc_cCodigo)
            loc_oPagina.txt_4c_Empresa.Value  = ""
            loc_oPagina.txt_4c_DEmpresa.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp " + ;
                "WHERE Cemps = " + EscaparSQL(loc_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")

            IF loc_nResult > 0
                SELECT cursor_4c_EmpVal
                IF !EOF()
                    loc_oPagina.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_EmpVal.Cemps)
                    loc_oPagina.txt_4c_DEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
                ELSE
                    *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
                    THIS.AbrirBuscaEmpresa()
                ENDIF
                IF USED("cursor_4c_EmpVal")
                    USE IN cursor_4c_EmpVal
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodigoConta - Valida codigo digitado em txt_4c_Conta
    * Busca em SigCdCli (IClis = codigo conta/cliente)
    * Se encontrado: preenche descricao. Se nao encontrado: abre lookup.
    * Replica logica de getConta.Valid do original
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCodigoConta()
        LOCAL loc_oPagina, loc_cCodigo, loc_cSQL, loc_nResult, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)

        IF EMPTY(loc_cCodigo)
            loc_oPagina.txt_4c_Conta.Value  = ""
            loc_oPagina.txt_4c_DConta.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 IClis, Razaos FROM SigCdCli " + ;
                "WHERE IClis = " + EscaparSQL(loc_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CntVal")

            IF loc_nResult > 0
                SELECT cursor_4c_CntVal
                IF !EOF()
                    loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CntVal.IClis)
                    loc_oPagina.txt_4c_DConta.Value = ALLTRIM(cursor_4c_CntVal.Razaos)
                ELSE
                    *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
                    THIS.AbrirBuscaConta()
                ENDIF
                IF USED("cursor_4c_CntVal")
                    USE IN cursor_4c_CntVal
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Orquestrador da Fase 5
    * Em forms REPORT (frmrelatorio), a "Page Dados" eh interpretada como o
    * conjunto de configuracoes adicionais sobre os filtros e grades de selecao:
    *   - Eventos de interacao dos checkboxes dentro das grades de operacoes
    *   - Enabled dos campos de descricao conforme presenca do codigo
    * Replica os comportamentos das procedures de grdOperacoesE.Column1.Check1 e
    * grdOperacoesS.Column1.Check1 do form original (Click, MouseDown, KeyPress).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarEventosCheckGradeE()
        THIS.ConfigurarEventosCheckGradeS()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventosCheckGradeE - Vincula eventos no CheckBox da Column1
    * da grade de Entradas para replicar o comportamento do original
    * (SIGREIMP.grdOperacoesE.Column1.Check1).
    *
    * No SCX original:
    *   Click   -> NoDefault
    *   MouseDown -> Replace SelImp With Not SelImp In csOperacoesE + Refresh
    *   KeyPress -> If InList(nKeyCode, 13, 32): Replace SelImp + Refresh
    *
    * BINDEVENT requer handlers PUBLIC (sem PROTECTED).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventosCheckGradeE()
        LOCAL loc_oGrid, loc_oCheck
        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_OperacoesE

        IF VARTYPE(loc_oGrid) != "O"
            RETURN
        ENDIF

        IF PEMSTATUS(loc_oGrid.Column1, "Check1", 5)
            loc_oCheck = loc_oGrid.Column1.Check1
            BINDEVENT(loc_oCheck, "Click",    THIS, "CheckGradeEClick")
            BINDEVENT(loc_oCheck, "KeyPress", THIS, "CheckGradeEKeyPress")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventosCheckGradeS - Vincula eventos no CheckBox da Column1
    * da grade de Saidas. Espelha ConfigurarEventosCheckGradeE.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventosCheckGradeS()
        LOCAL loc_oGrid, loc_oCheck
        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_OperacoesS

        IF VARTYPE(loc_oGrid) != "O"
            RETURN
        ENDIF

        IF PEMSTATUS(loc_oGrid.Column1, "Check1", 5)
            loc_oCheck = loc_oGrid.Column1.Check1
            BINDEVENT(loc_oCheck, "Click",    THIS, "CheckGradeSClick")
            BINDEVENT(loc_oCheck, "KeyPress", THIS, "CheckGradeSKeyPress")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CheckGradeEClick - Toggle SelImp no registro corrente da grade Entradas
    * Replica MouseDown do original (Click marcava NoDefault).
    * Handler BINDEVENT - deve ser PUBLIC.
    *--------------------------------------------------------------------------
    PROCEDURE CheckGradeEClick()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oRelatorio.this_cCursorOperacoesE

        IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
            SELECT (loc_cCursor)
            IF !EOF() AND !BOF()
                REPLACE SelImp WITH !SelImp IN (loc_cCursor)
                THIS.pgf_4c_Paginas.Page1.grd_4c_OperacoesE.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CheckGradeEKeyPress - Toggle SelImp via ENTER (13) ou ESPACO (32)
    * Replica KeyPress do original (grdOperacoesE.Column1.Check1).
    * Handler BINDEVENT - deve ser PUBLIC.
    *--------------------------------------------------------------------------
    PROCEDURE CheckGradeEKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCursor
        IF par_nKeyCode = 13 OR par_nKeyCode = 32
            loc_cCursor = THIS.this_oRelatorio.this_cCursorOperacoesE
            IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
                SELECT (loc_cCursor)
                IF !EOF() AND !BOF()
                    REPLACE SelImp WITH !SelImp IN (loc_cCursor)
                    THIS.pgf_4c_Paginas.Page1.grd_4c_OperacoesE.Refresh()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CheckGradeSClick - Toggle SelImp no registro corrente da grade Saidas
    * Handler BINDEVENT - deve ser PUBLIC.
    *--------------------------------------------------------------------------
    PROCEDURE CheckGradeSClick()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oRelatorio.this_cCursorOperacoesS

        IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
            SELECT (loc_cCursor)
            IF !EOF() AND !BOF()
                REPLACE SelImp WITH !SelImp IN (loc_cCursor)
                THIS.pgf_4c_Paginas.Page1.grd_4c_OperacoesS.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CheckGradeSKeyPress - Toggle SelImp via ENTER (13) ou ESPACO (32)
    * Handler BINDEVENT - deve ser PUBLIC.
    *--------------------------------------------------------------------------
    PROCEDURE CheckGradeSKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCursor
        IF par_nKeyCode = 13 OR par_nKeyCode = 32
            loc_cCursor = THIS.this_oRelatorio.this_cCursorOperacoesS
            IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
                SELECT (loc_cCursor)
                IF !EOF() AND !BOF()
                    REPLACE SelImp WITH !SelImp IN (loc_cCursor)
                    THIS.pgf_4c_Paginas.Page1.grd_4c_OperacoesS.Refresh()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarValoresIniciaisFiltros - Garante defaults consistentes para
    * todos os filtros, espelhando o bloco do Init do form original:
    *   getDtInicial.Value = Date()
    *   getDtFinal.Value   = Date()
    *   getEmpresa.Value   = _Empr (resolvido por InicializarEmpresa)
    *   getDEmpresa.Value  = []  (resolvido por InicializarEmpresa)
    *   getConta.Value     = []
    *   getDConta.Value    = []
    *   optTipos.Value     = 1   (Detalhado)
    *   chkSubTotDat.Value = .F.
    * Tambem reseta o flag SelImp dos cursores de operacoes para .F.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarValoresIniciaisFiltros()
        LOCAL loc_oPagina, loc_cCursorE, loc_cCursorS
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Datas: aplica DATE() somente se ainda nao foi setado por LimparCampos
        IF EMPTY(loc_oPagina.txt_4c_DtInicial.Value)
            loc_oPagina.txt_4c_DtInicial.Value = DATE()
        ENDIF
        IF EMPTY(loc_oPagina.txt_4c_DtFinal.Value)
            loc_oPagina.txt_4c_DtFinal.Value = DATE()
        ENDIF

        *-- Opcoes (Detalhado por default + chkSubTotDat desmarcado)
        IF loc_oPagina.opt_4c_OptTipos.Value <> 1 AND loc_oPagina.opt_4c_OptTipos.Value <> 2
            loc_oPagina.opt_4c_OptTipos.Value = 1
        ENDIF
        loc_oPagina.chk_4c_ChkSubTotDat.Value   = 0
        loc_oPagina.chk_4c_ChkSubTotDat.Enabled = (loc_oPagina.opt_4c_OptTipos.Value = 1)

        *-- Reset SelImp dos cursores de operacoes
        loc_cCursorE = THIS.this_oRelatorio.this_cCursorOperacoesE
        loc_cCursorS = THIS.this_oRelatorio.this_cCursorOperacoesS

        IF !EMPTY(loc_cCursorE) AND USED(loc_cCursorE)
            SELECT (loc_cCursorE)
            REPLACE ALL SelImp WITH .F.
            GO TOP
        ENDIF

        IF !EMPTY(loc_cCursorS) AND USED(loc_cCursorS)
            SELECT (loc_cCursorS)
            REPLACE ALL SelImp WITH .F.
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarVisibilidadeFiltros - Sincroniza Enabled dos campos de descricao
    * com a presenca de codigo correspondente. Replica os eventos When do
    * original (getDEmpresa.When e getDConta.When):
    *   - txt_4c_DEmpresa.Enabled = EMPTY(txt_4c_Empresa.Value)
    *   - txt_4c_DConta.Enabled   = EMPTY(txt_4c_Conta.Value)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarVisibilidadeFiltros()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.txt_4c_DEmpresa.Enabled = ;
            EMPTY(ALLTRIM(loc_oPagina.txt_4c_Empresa.Value))

        loc_oPagina.txt_4c_DConta.Enabled = ;
            EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Helper recursivo que garante .Visible = .T. em
    * todos os controles aninhados do container informado.
    *
    * Necessario porque AddObject() cria controles com Visible = .F. por default.
    * Sem este passo, o formulario pode abrir parcialmente em branco apos a
    * configuracao programatica.
    *
    * Itera Pages de PageFrames E Controls de containers recursivamente
    * (padrao definido em FORMCOR_LICOES_APRENDIDAS, Problema 6).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        IF !PEMSTATUS(par_oContainer, "ControlCount", 5)
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                *-- Tornar o controle visivel quando ele tem a propriedade
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                *-- PageFrame: descer em cada Page recursivamente
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                *-- Container generico: descer nos filhos
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) ;
                   AND UPPER(loc_oObjeto.BaseClass) <> "PAGEFRAME"
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos do BO
    * NUNCA usar .Release() em Custom/BO - apenas zerar referencia
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
