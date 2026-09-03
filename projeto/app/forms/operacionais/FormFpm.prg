*==============================================================================
* FormFpm.prg - Valores Minimo/Maximo de Condicao de Pagamento (sub-form modal)
* Form OPERACIONAL - abre sobre o form pai (SigCdFpm / FormFpp)
* Chamada: CREATEOBJECT("FormFpm", oParentForm, cFpags)
* Herda de: FormBase
*
* Form OPERACIONAL (sub-form modal de edicao de grid inline). Botoes do SCX
* original: Inserir, Excluir, Encerrar. Edicao de parcelas (nparcs/valmins/
* valmaxs/emps) diretamente no grid. Salva no Encerrar via FpmBO.SalvarAlteracoes.
*
* Historico de fases:
*   Fase 1/2: FpmBO.prg (propriedades + CRUD + BuscarPorCondicao + SalvarAlteracoes)
*   Fase 3:   FormFpm.prg - estrutura base (heranca, Init, InicializarForm,
*             PageFrame, containers vazios, labels cabecalho, TornarControlesVisiveis,
*             CarregarDados stub, Destroy)
*   Fase 4:   FormFpm.prg - grid grd_4c_Dados (4 colunas) + botoes Inserir/Excluir/Encerrar
*             + BINDEVENTs + VincularGrid
*   Fase 5:   FormFpm.prg - BtnInserirClick, BtnExcluirClick, BtnEncerrarClick,
*             ValidarParcelas, GrdDadosAfterRowColChange, ValidarEmps, AlternarPagina
*   Fase 6:   FormFpm.prg - Botoes Confirmar/Cancelar em cnt_4c_BotoesAcao (Page2)
*             + BtnConfirmarClick + BtnCancelarClick
*   Fase 7:   FormFpm.prg - BtnAlterarClick, BtnVisualizarClick, BtnIncluirClick
*             (aliases CRUD + refresh/lock inline)
*   Fase 8:   FormFpm.prg - eventos auxiliares e consolidacao:
*             CarregarLista, FormParaBO, BOParaForm, HabilitarCampos,
*             LimparCampos, AjustarBotoesPorModo, BtnBuscarClick, BtnSalvarClick
*==============================================================================
DEFINE CLASS FormFpm AS FormBase

    *-- Propriedades do SCX original (RESERVED3: gravadados / parentform / peantvalue)
    GravaDados       = .F.      && .T. quando usuario alterou dados no grid
    peantvalue       = 0        && valor anterior capturado em Column.When
    this_oParentForm = .NULL.   && referencia ao form pai para reabilitar no Destroy
    this_cFpags      = ""       && codigo da condicao de pagamento (fpags char 12)

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Controle de modo
    this_cModoAtual = "LISTA"

    *-- Guard anti-recursao no AfterRowColChange / When-Valid inline
    this_lRedirigindo = .F.

    *-- Propriedades visuais (PILAR 1 - valores exatos do SCX original SIGCDFPM)
    Width        = 683
    Height       = 363
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    MaxButton    = .F.
    Movable      = .F.
    BorderStyle  = 2
    ClipControls = .F.
    DataSession  = 2
    Caption      = "Valor Minimo por Condicao de Pagamento "
    FontName     = "Tahoma"
    FontSize     = 8

    *--------------------------------------------------------------------------
    * Init - Recebe ref ao pai e codigo da condicao de pagamento
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm, par_cFpags)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_oParentForm = par_oParentForm
            THIS.this_cFpags      = IIF(VARTYPE(par_cFpags) = "C", ALLTRIM(par_cFpags), "")

            THIS.Caption = "Valor M" + CHR(237) + "nimo por Condi" + CHR(231) + CHR(227) + "o de Pagamento " + ;
                           ALLTRIM(THIS.this_cFpags)

            THIS.this_oBusinessObject = CREATEOBJECT("FpmBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar FpmBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormFpm.Init")
            ELSE
                IF VARTYPE(THIS.this_oParentForm) = "O"
                    THIS.this_oParentForm.Enabled = .F.
                ENDIF
                *-- DODEFAULT() dispara FormBase.Init() -> THIS.InicializarForm()
                *-- Tambem aciona SET DATE TO BRITISH + SET CENTURY ON (DataSession=2)
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta estrutura visual base do form
    * (chamado por FormBase.Init via DODEFAULT)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- 1. Fundo do form (SCX original: new_background.jpg)
            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            *-- 2. PageFrame com Page1 (Lista) e Page2 (Dados)
            THIS.ConfigurarPageFrame()

            *-- 3. Containers vazios em cada Page
            THIS.ConfigurarContainersBase()

            *-- 4. Popula Page1: labels cabecalho (Fase 3) + grid+botoes (Fase 4)
            THIS.ConfigurarPaginaLista()

            *-- 5. Popula Page2: cabecalho espelhado (Fase 3) + botoes acao (Fase 4)
            THIS.ConfigurarPaginaDados()

            *-- 6. Propaga Caption para cabecalhos de ambas as paginas
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- 7. Carrega dados via BO e vincula grid ao cursor
            THIS.CarregarDados()

            *-- 8. Ativa Page1 (Lista) como padrao
            THIS.pgf_4c_Paginas.Visible    = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.this_cModoAtual           = "LISTA"

            *-- 9. Torna toda a arvore visivel
            THIS.TornarControlesVisiveis(THIS)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Tabs ocultas (Top=-29, Tabs=.F.)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")
            WITH THIS.pgf_4c_Paginas
                .Top         = -29
                .Left        = 0
                .Width       = THIS.Width
                .Height      = THIS.Height + 29
                .PageCount   = 2
                .Tabs        = .F.
                .BorderWidth = 0

                .Page1.Caption = "Lista"
                .Page2.Caption = "Dados"
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainersBase - Cria containers vazios em cada Page
    * cnt_4c_Cabecalho + cnt_4c_Botoes em Page1
    * cnt_4c_Cabecalho + cnt_4c_BotoesAcao em Page2
    * Controles internos sao adicionados em ConfigurarPaginaLista/Dados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainersBase()
        LOCAL loc_oPag1, loc_oPag2, loc_oErro
        TRY
            loc_oPag1 = THIS.pgf_4c_Paginas.Page1
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2

            *-- Page1: cabecalho escuro (topo) - compensacao PageFrame.Top=-29
            loc_oPag1.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPag1.cnt_4c_Cabecalho
                .Top         = 0 + 29
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .Visible     = .T.
            ENDWITH

            *-- Page1: container de botoes
            *-- Alinhado com botoes originais: cmdInserir.Left=457, cmdSair.Right=682
            loc_oPag1.AddObject("cnt_4c_Botoes", "Container")
            WITH loc_oPag1.cnt_4c_Botoes
                .Top         = 0 + 29
                .Left        =  542
                .Width       = 226
                .Height      = 85
                .BorderWidth = 0
                .BackStyle   = 0
                .Visible     = .T.
            ENDWITH

            *-- Page2: cabecalho espelhado
            loc_oPag2.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPag2.cnt_4c_Cabecalho
                .Top         = 0 + 29
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .Visible     = .T.
            ENDWITH

            *-- Page2: container de acoes (Fase 4 populara com Confirmar/Cancelar)
            loc_oPag2.AddObject("cnt_4c_BotoesAcao", "Container")
            WITH loc_oPag2.cnt_4c_BotoesAcao
                .Top         = 4 + 29
                .Left        = 457
                .Width       = 226
                .Height      = 85
                .BorderWidth = 0
                .BackStyle   = 0
                .Visible     = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.ConfigurarContainersBase")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Popula Page1 com cabecalho, grid e botoes
    * Grid: grd_4c_Dados (GradeFPagto do original), 4 colunas inline
    * Botoes: Inserir, Excluir, Encerrar em cnt_4c_Botoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oCab, loc_oPag, loc_oCnt, loc_oErro
        TRY
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            loc_oCab = loc_oPag.cnt_4c_Cabecalho

            *-- Label sombra (preto sobre cinza escuro = efeito de sombra)
            loc_oCab.AddObject("lbl_4c_Sombra", "Label")
            WITH loc_oCab.lbl_4c_Sombra
                .AutoSize   = .F.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .BackStyle  = 0
                .Caption    = THIS.Caption
                .Height     = 40
                .Left       = 10
                .Top        = 18
                .Width      = THIS.Width - 20
                .ForeColor  = RGB(0, 0, 0)
            ENDWITH

            *-- Label titulo (branco sobre cinza = visivel)
            loc_oCab.AddObject("lbl_4c_Titulo", "Label")
            WITH loc_oCab.lbl_4c_Titulo
                .AutoSize   = .F.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .BackStyle  = 0
                .Caption    = THIS.Caption
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = THIS.Width - 20
                .ForeColor  = RGB(255, 255, 255)
            ENDWITH

            *-- Grid grd_4c_Dados (GradeFPagto do original)
            *-- Original: Top=92, Left=114, Width=334, Height=260
            *-- Com compensacao PageFrame.Top=-29: Top = 92+29 = 121
            loc_oPag.AddObject("grd_4c_Dados", "Grid")
            WITH loc_oPag.grd_4c_Dados
                .Top           = 92 + 29
                .Left          = 114
                .Width         = 334
                .Height        = 260
                .ColumnCount   = 4
                .FontName      = "Tahoma"
                .FontSize      = 8
                .DeleteMark    = .F.
                .RecordMark    = .F.
                .RowHeight     = 16
                .ScrollBars    = 2
                .GridLineColor = RGB(238, 238, 238)

                *-- Column1: Parcelas (nParcs), Width=60
                WITH .Column1
                    .Width     = 60
                    .Movable   = .F.
                    .Resizable = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Parcelas"
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .Margin      = 0
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                *-- Column2: Valor Minimo (ValMins), Width=100
                WITH .Column2
                    .Width     = 100
                    .Movable   = .F.
                    .Resizable = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .InputMask = "999,999,999.99"
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Valor M" + CHR(237) + "nimo"
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .InputMask   = "999,999,999.99"
                        .Margin      = 0
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                *-- Column3: Valor Maximo (ValMaxs), Width=100
                WITH .Column3
                    .Width     = 100
                    .Movable   = .F.
                    .Resizable = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .InputMask = "999,999,999.99"
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Valor M" + CHR(225) + "ximo"
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .InputMask   = "999,999,999.99"
                        .Margin      = 0
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                *-- Column4: Empresa (Emps), Width=40
                WITH .Column4
                    .Width     = 40
                    .Movable   = .F.
                    .Resizable = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Emp"
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .MaxLength   = 3
                        .Margin      = 0
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH
            ENDWITH

            *-- Botoes no cnt_4c_Botoes
            *-- Original: Inserir(Left=457), Excluir(Left=532), Sair(Left=607)
            *-- cnt_4c_Botoes.Left=457 => posicoes relativas: 0, 75, 150
            loc_oCnt = loc_oPag.cnt_4c_Botoes

            loc_oCnt.AddObject("cmd_4c_Inserir", "CommandButton")
            WITH loc_oCnt.cmd_4c_Inserir
                .Left            = 0
                .Top             = 3
                .Width           = 75
                .Height          = 75
                .Caption         = "Inserir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
            ENDWITH

            loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
            WITH loc_oCnt.cmd_4c_Excluir
                .Left = 230
                .Top             = 3
                .Width           = 75
                .Height          = 75
                .Caption         = "Excluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
            ENDWITH

            loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH loc_oCnt.cmd_4c_Encerrar
                .Left = 5
                .Top             = 3
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Cancel          = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
            ENDWITH

            *-- BINDEVENTs para botoes
            BINDEVENT(loc_oCnt.cmd_4c_Inserir,  "Click", THIS, "BtnInserirClick")
            BINDEVENT(loc_oCnt.cmd_4c_Excluir,  "Click", THIS, "BtnExcluirClick")
            BINDEVENT(loc_oCnt.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

            *-- BINDEVENT para grid: When/Valid via AfterRowColChange
            BINDEVENT(loc_oPag.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Popula Page2 com cabecalho espelhado e
    * botoes Confirmar/Cancelar em cnt_4c_BotoesAcao
    * (Fase 3: labels cabecalho; Fase 6: botoes de acao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oCab, loc_oCnt, loc_oPag2, loc_oErro
        TRY
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2
            loc_oCab  = loc_oPag2.cnt_4c_Cabecalho

            *-- Label sombra
            loc_oCab.AddObject("lbl_4c_Sombra", "Label")
            WITH loc_oCab.lbl_4c_Sombra
                .AutoSize   = .F.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .BackStyle  = 0
                .Caption    = THIS.Caption
                .Height     = 40
                .Left       = 10
                .Top        = 18
                .Width      = THIS.Width - 20
                .ForeColor  = RGB(0, 0, 0)
            ENDWITH

            *-- Label titulo
            loc_oCab.AddObject("lbl_4c_Titulo", "Label")
            WITH loc_oCab.lbl_4c_Titulo
                .AutoSize   = .F.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .BackStyle  = 0
                .Caption    = THIS.Caption
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = THIS.Width - 20
                .ForeColor  = RGB(255, 255, 255)
            ENDWITH

            *-- Botoes Confirmar / Cancelar em cnt_4c_BotoesAcao
            *-- Mesmo padrao visual dos botoes de Page1
            loc_oCnt = loc_oPag2.cnt_4c_BotoesAcao

            loc_oCnt.AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH loc_oCnt.cmd_4c_Confirmar
                .Left            = 0
                .Top             = 3
                .Width           = 75
                .Height          = 75
                .Caption         = "Confirmar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
            ENDWITH

            loc_oCnt.AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH loc_oCnt.cmd_4c_Cancelar
                .Left            = 75
                .Top             = 3
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Cancel          = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
            ENDWITH

            *-- BINDEVENTs para botoes de Page2
            BINDEVENT(loc_oCnt.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
            BINDEVENT(loc_oCnt.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Carrega parcelas via BO e vincula grid ao cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !EMPTY(THIS.this_cFpags)
                loc_lSucesso = THIS.this_oBusinessObject.BuscarPorCondicao(THIS.this_cFpags)
            ENDIF
            IF loc_lSucesso
                THIS.VincularGrid()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.CarregarDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * (percorre Pages de PageFrames alem de Controls de Containers)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_nP, loc_oControl, loc_oErro
        TRY
            FOR loc_i = 1 TO par_oContainer.ControlCount
                loc_oControl = par_oContainer.Controls(loc_i)
                IF VARTYPE(loc_oControl) = "O"
                    IF PEMSTATUS(loc_oControl, "Visible", 5)
                        loc_oControl.Visible = .T.
                    ENDIF
                    IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                        FOR loc_nP = 1 TO loc_oControl.PageCount
                            THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                        ENDFOR
                    ENDIF
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                       loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.TornarControlesVisiveis")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularGrid - Vincula grd_4c_Dados ao cursor_4c_FpagI
    * Define ControlSource de cada coluna apos CarregarDados
    *--------------------------------------------------------------------------
    PROCEDURE VincularGrid()
        LOCAL loc_oGrid, loc_oErro
        TRY
            IF !USED("cursor_4c_FpagI")
                RETURN
            ENDIF
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
            loc_oGrid.ColumnCount  = 4
            loc_oGrid.RecordSource = "cursor_4c_FpagI"
            WITH loc_oGrid
                .Column1.ControlSource = "cursor_4c_FpagI.nParcs"
                .Column2.ControlSource = "cursor_4c_FpagI.ValMins"
                .Column3.ControlSource = "cursor_4c_FpagI.ValMaxs"
                .Column4.ControlSource = "cursor_4c_FpagI.Emps"
            ENDWITH
            loc_oGrid.Column1.Header1.Caption = "Parcelas"
            loc_oGrid.Column2.Header1.Caption = "Valor M" + CHR(237) + "nimo"
            loc_oGrid.Column3.Header1.Caption = "Valor M" + CHR(225) + "ximo"
            loc_oGrid.Column4.Header1.Caption = "Emp"
            loc_oGrid.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.VincularGrid")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_oErro
        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
            DO CASE
                CASE par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                CASE par_nPagina = 2
                    THIS.this_cModoAtual = "DADOS"
                    *-- Carrega dados da linha selecionada no grid de Page1 (padrao legado)
                    IF USED("cursor_4c_FpagI") AND !EOF("cursor_4c_FpagI")
                        THIS.this_oBusinessObject.this_cFpags    = NVL(cursor_4c_FpagI.fpags, "")
                        THIS.this_oBusinessObject.this_nNparcs   = NVL(cursor_4c_FpagI.nParcs, 0)
                        THIS.this_oBusinessObject.this_nValmins  = NVL(cursor_4c_FpagI.ValMins, 0)
                        THIS.this_oBusinessObject.this_nValmaxs  = NVL(cursor_4c_FpagI.ValMaxs, 0)
                        THIS.this_oBusinessObject.this_cEmps     = NVL(cursor_4c_FpagI.Emps, "")
                    ENDIF
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.AlternarPagina")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInserirClick - Insere nova linha em branco com o fpags corrente
    * Original: Insert Into xFPagI (fPags) Values (crTSigfPag.fpags)
    *--------------------------------------------------------------------------
    PROCEDURE BtnInserirClick()
        LOCAL loc_oErro
        TRY
            IF !USED("cursor_4c_FpagI")
                RETURN
            ENDIF
            SELECT cursor_4c_FpagI
            INSERT INTO cursor_4c_FpagI (Fpags) VALUES (THIS.this_cFpags)
            THIS.GravaDados = .T.
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Column1.SetFocus
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.BtnInserirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Marca linha corrente como excluida
    * Original: Delete (marca exclusao no cursor local)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro
        TRY
            IF !USED("cursor_4c_FpagI") OR EOF("cursor_4c_FpagI")
                RETURN
            ENDIF
            SELECT cursor_4c_FpagI
            IF !EOF()
                DELETE
            ENDIF
            THIS.GravaDados = .T.
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Valida, salva alteracoes e fecha o form
    * Original: Valida duplicatas, atualiza crSigOpFpi, commit, Release
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_lPodeFechar, loc_lSucesso, loc_oErro
        loc_lPodeFechar = .T.
        TRY
            IF THIS.GravaDados
                loc_lPodeFechar = THIS.ValidarParcelas()
                IF loc_lPodeFechar
                    loc_lSucesso = THIS.this_oBusinessObject.SalvarAlteracoes(THIS.this_cFpags)
                    IF !loc_lSucesso
                        MsgAviso("Falha ao salvar as altera" + CHR(231) + CHR(245) + "es.", ;
                            "Encerrar")
                        loc_lPodeFechar = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.BtnEncerrarClick")
            loc_lPodeFechar = .F.
        ENDTRY
        IF loc_lPodeFechar
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarParcelas - Verifica se ha nParcs duplicados no cursor
    * Original: SELECT nParcs, sum(1) FROM xFPagi GROUP BY nparcs HAVING sum(1)>1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarParcelas()
        LOCAL loc_lValido, loc_oErro
        loc_lValido = .T.
        TRY
            IF USED("cursor_4c_ValidTT")
                USE IN cursor_4c_ValidTT
            ENDIF
            IF USED("cursor_4c_FpagI")
                SELECT nParcs, COUNT(*) AS nQtd ;
                    FROM cursor_4c_FpagI ;
                    WHERE !DELETED() AND (nParcs > 0 OR ValMaxs > 0) ;
                    GROUP BY nParcs ;
                    HAVING COUNT(*) > 1 ;
                    INTO CURSOR cursor_4c_ValidTT READWRITE
                SELECT cursor_4c_ValidTT
                IF RECCOUNT("cursor_4c_ValidTT") > 0
                    MsgAviso("Dados Inconsistentes!!!", "Validar")
                    loc_lValido = .F.
                ENDIF
                IF USED("cursor_4c_ValidTT")
                    USE IN cursor_4c_ValidTT
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.ValidarParcelas")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosAfterRowColChange - Handler AfterRowColChange do grd_4c_Dados
    * par_nColIndex: coluna que foi DEIXADA (coluna anterior)
    * Implementa:
    *   - Validacao de nParcs duplicado (ao sair da col1)
    *   - ReadOnly dinamico por coluna (equivalente ao When original)
    *   - Marcacao de GravaDados
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        IF THIS.this_lRedirigindo
            RETURN
        ENDIF
        IF !USED("cursor_4c_FpagI") OR EOF("cursor_4c_FpagI")
            RETURN
        ENDIF

        LOCAL loc_oGrid, loc_nParcs, loc_nValMaxs, loc_nCurRec, loc_lDuplicado, loc_oErro
        TRY
            SELECT cursor_4c_FpagI
            loc_nParcs   = NVL(cursor_4c_FpagI.nParcs, 0)
            loc_nValMaxs = NVL(cursor_4c_FpagI.ValMaxs, 0)
            loc_oGrid    = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados

            *-- Ao sair da coluna 1 (nParcs): validar duplicatas
            IF par_nColIndex = 1 AND loc_nParcs > 0
                loc_nCurRec  = RECNO("cursor_4c_FpagI")
                loc_lDuplicado = .F.
                SCAN FOR !DELETED() AND nParcs = loc_nParcs AND RECNO() != loc_nCurRec
                    loc_lDuplicado = .T.
                    EXIT
                ENDSCAN
                IF loc_lDuplicado
                    SELECT cursor_4c_FpagI
                    GOTO loc_nCurRec
                    MsgAviso("N" + CHR(250) + "mero de Parcelas j" + CHR(225) + ;
                        " Digitada para esta Condi" + CHR(231) + CHR(227) + ;
                        "o de Pagamento.", "Validar")
                    THIS.this_lRedirigindo = .T.
                    REPLACE nParcs WITH 0 IN cursor_4c_FpagI
                    THIS.this_lRedirigindo = .F.
                    loc_nParcs = 0
                    loc_oGrid.Refresh()
                ENDIF
            ENDIF

            *-- Atualizar ReadOnly por coluna (logica do When original):
            *-- Col1 (nParcs):  editavel quando ValMaxs = 0
            *-- Col2 (ValMins): editavel quando nParcs > 0
            *-- Col3 (ValMaxs): editavel quando nParcs = 0
            *-- Col4 (Emps):    editavel quando nParcs = 0
            THIS.this_lRedirigindo = .T.
            loc_oGrid.Column1.ReadOnly = (loc_nValMaxs <> 0)
            loc_oGrid.Column2.ReadOnly = (loc_nParcs = 0)
            loc_oGrid.Column3.ReadOnly = (loc_nParcs <> 0)
            loc_oGrid.Column4.ReadOnly = (loc_nParcs <> 0)
            THIS.this_lRedirigindo = .F.

            THIS.GravaDados = .T.

        CATCH TO loc_oErro
            THIS.this_lRedirigindo = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.GrdDadosAfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Valida, salva e fecha (equivalente ao Encerrar)
    * Usado quando o form esta em Page2 (modo DADOS)
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para Page1 (ou fecha sem salvar)
    * Se GravaDados=.F. (sem alteracoes), libera direto.
    * Se GravaDados=.T., confirma antes de descartar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_lFechar, loc_oErro
        loc_lFechar = .T.
        TRY
            IF THIS.GravaDados
                loc_lFechar = MsgConfirma("Existem altera" + CHR(231) + CHR(245) + ;
                    "es n" + CHR(227) + "o salvas." + CHR(13) + ;
                    "Deseja cancelar sem salvar?", "Cancelar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.BtnCancelarClick")
            loc_lFechar = .F.
        ENDTRY
        IF loc_lFechar
            THIS.GravaDados = .F.
            IF THIS.pgf_4c_Paginas.ActivePage = 2
                THIS.CarregarDados()
                THIS.AlternarPagina(1)
                THIS.AjustarBotoesPorModo()
            ELSE
                THIS.Release()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Alias CRUD para BtnInserirClick
    * Este eh um form OPERACIONAL de edicao inline (grid). Incluir = adicionar
    * nova linha em branco com o fpags corrente no cursor de parcelas.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.BtnInserirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Coloca o grid em modo de edicao inline
    * Este eh um form OPERACIONAL: o grid ja permite edicao direta a qualquer
    * momento. Este handler garante que Page1 esta ativa e coloca foco na
    * primeira coluna editavel da linha corrente. Segue a mesma politica de
    * ReadOnly por coluna aplicada em GrdDadosAfterRowColChange.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oGrid, loc_nParcs, loc_nValMaxs, loc_oErro
        TRY
            IF THIS.pgf_4c_Paginas.ActivePage != 1
                THIS.AlternarPagina(1)
            ENDIF
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
            IF !USED("cursor_4c_FpagI") OR EOF("cursor_4c_FpagI")
                loc_oGrid.SetFocus
                RETURN
            ENDIF
            SELECT cursor_4c_FpagI
            loc_nParcs   = NVL(cursor_4c_FpagI.nParcs, 0)
            loc_nValMaxs = NVL(cursor_4c_FpagI.ValMaxs, 0)
            THIS.this_lRedirigindo = .T.
            loc_oGrid.Column1.ReadOnly = (loc_nValMaxs <> 0)
            loc_oGrid.Column2.ReadOnly = (loc_nParcs = 0)
            loc_oGrid.Column3.ReadOnly = (loc_nParcs <> 0)
            loc_oGrid.Column4.ReadOnly = (loc_nParcs <> 0)
            THIS.this_lRedirigindo = .F.
            loc_oGrid.SetFocus
            IF !loc_oGrid.Column1.ReadOnly
                loc_oGrid.ActivateCell(RECNO("cursor_4c_FpagI"), 1)
            ELSE
                IF !loc_oGrid.Column2.ReadOnly
                    loc_oGrid.ActivateCell(RECNO("cursor_4c_FpagI"), 2)
                ELSE
                    IF !loc_oGrid.Column3.ReadOnly
                        loc_oGrid.ActivateCell(RECNO("cursor_4c_FpagI"), 3)
                    ENDIF
                ENDIF
            ENDIF
            loc_oGrid.Refresh()
        CATCH TO loc_oErro
            THIS.this_lRedirigindo = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Recarrega dados do BO e coloca grid em modo consulta
    * Este eh um form OPERACIONAL: "Visualizar" significa refazer o BuscarPor-
    * Condicao (descarta alteracoes em memoria nao salvas) e travar as colunas
    * como ReadOnly para inspecao dos valores atuais.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oGrid, loc_lRecarregar, loc_oErro
        loc_lRecarregar = .T.
        TRY
            IF THIS.GravaDados
                loc_lRecarregar = MsgConfirma("Existem altera" + CHR(231) + CHR(245) + ;
                    "es n" + CHR(227) + "o salvas." + CHR(13) + ;
                    "Recarregar os dados originais e descartar as altera" + ;
                    CHR(231) + CHR(245) + "es?", "Visualizar")
            ENDIF
            IF loc_lRecarregar
                IF THIS.pgf_4c_Paginas.ActivePage != 1
                    THIS.AlternarPagina(1)
                ENDIF
                IF USED("cursor_4c_FpagI")
                    TABLEREVERT(.T., "cursor_4c_FpagI")
                    USE IN cursor_4c_FpagI
                ENDIF
                THIS.CarregarDados()
                THIS.GravaDados = .F.
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                THIS.this_lRedirigindo = .T.
                loc_oGrid.Column1.ReadOnly = .T.
                loc_oGrid.Column2.ReadOnly = .T.
                loc_oGrid.Column3.ReadOnly = .T.
                loc_oGrid.Column4.ReadOnly = .T.
                THIS.this_lRedirigindo = .F.
                loc_oGrid.Refresh()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_lRedirigindo = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Alias canonico para CarregarDados
    * Este form OPERACIONAL usa um unico cursor (cursor_4c_FpagI) ligado ao
    * grid inline. CarregarLista recarrega o cursor a partir do BO usando o
    * fpags corrente e revincula o grid.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_FpagI")
                TABLEREVERT(.T., "cursor_4c_FpagI")
                USE IN cursor_4c_FpagI
            ENDIF
            loc_lSucesso = THIS.CarregarDados()
            IF loc_lSucesso
                THIS.GravaDados = .F.
                THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.CarregarLista")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Sincroniza estado do form para o BO
    * Neste form OPERACIONAL a edicao acontece INLINE no grd_4c_Dados sobre
    * cursor_4c_FpagI (o BO consulta o cursor diretamente em SalvarAlteracoes).
    * Aqui apenas garantimos que o fpags corrente esta propagado para o BO e
    * que alteracoes em andamento na linha do grid sejam commitadas no cursor.
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cFpagsAtual = THIS.this_cFpags
            ENDIF
            IF USED("cursor_4c_FpagI")
                SELECT cursor_4c_FpagI
                *-- Commit da linha corrente (TABLEUPDATE se ha alteracoes nao salvas)
                IF GETFLDSTATE(-1, "cursor_4c_FpagI") > 1
                    TABLEUPDATE(.F., .T., "cursor_4c_FpagI")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Sincroniza estado do BO para o form
    * Atualiza a Caption (que inclui o fpags corrente) e revincula o grid.
    * Chamado apos operacoes que trocam o fpags no BO (ex: reload de contexto).
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_cFpags, loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cFpags = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cFpagsAtual, ""))
                IF !EMPTY(loc_cFpags)
                    THIS.this_cFpags = loc_cFpags
                    THIS.Caption = "Valor M" + CHR(237) + "nimo/M" + CHR(225) + ;
                        "ximo Cond.Pagto " + loc_cFpags
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                ENDIF
            ENDIF
            IF USED("cursor_4c_FpagI")
                THIS.VincularGrid()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita colunas editaveis do grid conforme
    * o modo corrente (LISTA=edicao inline liberada, VISUALIZAR=ReadOnly total).
    * Neste form OPERACIONAL nao ha TextBoxes soltos: os "campos" sao as
    * colunas do grd_4c_Dados. A politica granular por linha (baseada em
    * nParcs/ValMaxs) continua sendo aplicada pelo GrdDadosAfterRowColChange.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab, loc_oGrid, loc_oCnt, loc_oErro
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
            THIS.this_lRedirigindo = .T.
            loc_oGrid.Column1.ReadOnly = !loc_lHab
            loc_oGrid.Column2.ReadOnly = !loc_lHab
            loc_oGrid.Column3.ReadOnly = !loc_lHab
            loc_oGrid.Column4.ReadOnly = !loc_lHab
            THIS.this_lRedirigindo = .F.

            *-- Botoes Inserir/Excluir seguem o modo (Encerrar sempre disponivel)
            loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
            loc_oCnt.cmd_4c_Inserir.Enabled = loc_lHab
            loc_oCnt.cmd_4c_Excluir.Enabled = loc_lHab

            *-- Se voltamos a habilitar edicao inline: reaplica politica por linha
            IF loc_lHab AND USED("cursor_4c_FpagI") AND !EOF("cursor_4c_FpagI")
                THIS.GrdDadosAfterRowColChange(0)
            ENDIF
            loc_oGrid.Refresh()
        CATCH TO loc_oErro
            THIS.this_lRedirigindo = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Descarta todas as linhas em memoria do cursor de parcelas
    * (usado por Cancelar/Buscar quando queremos zerar o grid antes de recarregar)
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_FpagI")
                SELECT cursor_4c_FpagI
                TABLEREVERT(.T., "cursor_4c_FpagI")
                DELETE ALL
                *-- Compacta remocoes marcadas (evita SET DELETED clutter no scan)
                SET DELETED ON
                PACK
                SET DELETED OFF
            ENDIF
            THIS.GravaDados = .F.
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta Enabled dos botoes conforme this_cModoAtual
    * LISTA:      Inserir=ON, Excluir=ON, Encerrar=ON, Confirmar/Cancelar=OFF
    * VISUALIZAR: Inserir=OFF, Excluir=OFF, Encerrar=ON, Confirmar/Cancelar=OFF
    * DADOS:      Confirmar=ON, Cancelar=ON, botoes Page1 inativos por contexto
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCntL, loc_oCntD, loc_cModo, loc_oErro
        loc_cModo = UPPER(ALLTRIM(THIS.this_cModoAtual))
        TRY
            loc_oCntL = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
            loc_oCntD = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
            DO CASE
                CASE loc_cModo == "VISUALIZAR"
                    loc_oCntL.cmd_4c_Inserir.Enabled  = .F.
                    loc_oCntL.cmd_4c_Excluir.Enabled  = .F.
                    loc_oCntL.cmd_4c_Encerrar.Enabled = .T.
                    loc_oCntD.cmd_4c_Confirmar.Enabled = .F.
                    loc_oCntD.cmd_4c_Cancelar.Enabled  = .T.
                CASE loc_cModo == "DADOS"
                    loc_oCntL.cmd_4c_Inserir.Enabled  = .F.
                    loc_oCntL.cmd_4c_Excluir.Enabled  = .F.
                    loc_oCntL.cmd_4c_Encerrar.Enabled = .T.
                    loc_oCntD.cmd_4c_Confirmar.Enabled = .T.
                    loc_oCntD.cmd_4c_Cancelar.Enabled  = .T.
                OTHERWISE   && LISTA (default)
                    loc_oCntL.cmd_4c_Inserir.Enabled  = .T.
                    loc_oCntL.cmd_4c_Excluir.Enabled  = .T.
                    loc_oCntL.cmd_4c_Encerrar.Enabled = .T.
                    loc_oCntD.cmd_4c_Confirmar.Enabled = .T.
                    loc_oCntD.cmd_4c_Cancelar.Enabled  = .T.
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega parcelas do BO (refresh do grid)
    * Se ha alteracoes nao salvas, confirma antes de descartar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_lRecarregar, loc_oErro
        loc_lRecarregar = .T.
        TRY
            IF THIS.GravaDados
                loc_lRecarregar = MsgConfirma("Existem altera" + CHR(231) + CHR(245) + ;
                    "es n" + CHR(227) + "o salvas." + CHR(13) + ;
                    "Recarregar descartando as altera" + CHR(231) + CHR(245) + "es?", ;
                    "Buscar")
            ENDIF
            IF loc_lRecarregar
                THIS.LimparCampos()
                THIS.CarregarLista()
                THIS.AlternarPagina(1)
                THIS.AjustarBotoesPorModo()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Persiste alteracoes sem fechar o form
    * Diferente do BtnEncerrarClick (que salva e fecha), este apenas commita
    * as edicoes correntes no banco (SigOpFpi) e mantem o form aberto.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lValido, loc_lSucesso, loc_oErro
        TRY
            IF !THIS.GravaDados
                RETURN
            ENDIF
            THIS.FormParaBO()
            loc_lValido = THIS.ValidarParcelas()
            IF loc_lValido
                loc_lSucesso = THIS.this_oBusinessObject.SalvarAlteracoes(THIS.this_cFpags)
                IF loc_lSucesso
                    THIS.GravaDados = .F.
                    MsgInfo("Altera" + CHR(231) + CHR(245) + "es salvas com sucesso.", "Salvar")
                ELSE
                    MsgAviso("Falha ao salvar as altera" + CHR(231) + CHR(245) + "es.", ;
                        "Salvar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores e reabilita o form pai
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_FpagI")
            TABLEREVERT(.T., "cursor_4c_FpagI")
            USE IN cursor_4c_FpagI
        ENDIF
        IF USED("cursor_4c_FpagITemp")
            USE IN cursor_4c_FpagITemp
        ENDIF
        IF USED("cursor_4c_ValidTT")
            USE IN cursor_4c_ValidTT
        ENDIF
        IF USED("cursor_4c_EmpValida")
            USE IN cursor_4c_EmpValida
        ENDIF
        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
