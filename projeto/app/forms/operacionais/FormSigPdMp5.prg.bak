*==============================================================================
* FormSigPdMp5.prg - Formulario OPERACIONAL de Movimentacao
* Sub-dialog aberto pelo form pai de movimentacao de producao.
* Compartilha DataSession com o form pai para acesso direto aos cursores
* xMFas, xPesa, crSigCdOpd e TmpNens (sem SQLEXEC - dados em memoria).
*
* Parametros de Init:
*   par_oFormPai : referencia ao form que abriu este sub-dialog
*   par_nDtS     : DataSession ID do form pai (compatibilidade com legado)
*==============================================================================

DEFINE CLASS FormSigPdMp5 AS FormBase

    *-- Propriedades visuais (exatas do original SIGPDMP5)
    Width        = 1000
    Height       = 600
    Caption      = ""
    DataSession  = 2
    ShowWindow   = 1
    WindowType   = 1
    BorderStyle  = 2
    TitleBar     = 0
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    Themes       = .F.
    AutoCenter   = .T.

    *-- Estado do form
    this_oBusinessObject = .NULL.
    this_oFormPai        = .NULL.
    this_cEscolha        = ""

    *-- Container cabecalho cinza (cntSombra no legado)
    ADD OBJECT cnt_4c_Sombra AS Container WITH ;
        Top = 0, Left = 0, Width = 1100, Height = 80, ;
        BorderWidth = 0, BackColor = RGB(100,100,100)

    *-- Shape borda area imagem produto (Shape4 no legado)
    ADD OBJECT shp_4c_Shape4 AS Shape WITH ;
        Top = 120, Left = 503, Height = 240, Width = 445, ;
        BackStyle = 0, BorderColor = RGB(90,90,90)

    *-- Shape decorativo area botao Sair (Shape1 no legado)
    ADD OBJECT shp_4c_Shape1 AS Shape WITH ;
        Top = 7, Left = 902, Height = 110, Width = 90, ;
        BackStyle = 0, BorderStyle = 0, BorderColor = RGB(136,189,188)

    *-- Imagem do produto - inicia invisivel; exibida em AfterRowColChange
    ADD OBJECT img_4c_FigJpg AS Image WITH ;
        Stretch = 1, Height = 238, Left = 504, Top = 121, Width = 443, ;
        Visible = .F.

    *-- Container secao Movimentacao (Container1 no legado)
    ADD OBJECT cnt_4c_Container1 AS Container WITH ;
        Top = 108, Left = 13, Width = 482, Height = 68, ;
        SpecialEffect = 0, BackColor = RGB(255,255,255)

    *-- Container dados operacao corrente (Operacao no legado)
    ADD OBJECT cnt_4c_Operacao AS Container WITH ;
        Top = 142, Left = 21, Width = 282, Height = 26, ;
        BackStyle = 0, BorderWidth = 0, BackColor = RGB(255,255,255)

    *-- Container Origem - visibilidade controlada por crSigCdOpd.Origems
    ADD OBJECT cnt_4c_Origem AS Container WITH ;
        Top = 185, Left = 12, Width = 482, Height = 68, ;
        SpecialEffect = 0, BackColor = RGB(255,255,255), Visible = .F.

    *-- Container Destino - visibilidade controlada por crSigCdOpd.Destinos
    ADD OBJECT cnt_4c_Destino AS Container WITH ;
        Top = 261, Left = 12, Width = 482, Height = 68, ;
        SpecialEffect = 0, BackColor = RGB(255,255,255), Visible = .F.

    *==========================================================================
    * Init - Compartilha datasession com o form pai e inicializa
    *==========================================================================
    PROCEDURE Init(par_oFormPai, par_nDtS)
        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
            IF TYPE("par_oFormPai.pcEscolha") = "C"
                THIS.this_cEscolha = ALLTRIM(par_oFormPai.pcEscolha)
            ENDIF
            *-- Compartilha datasession do form pai: acesso a xMFas, xPesa, crSigCdOpd, TmpNens
            THIS.DataSessionId = par_oFormPai.DataSessionId
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria BO e configura interface visual
    * Chamado automaticamente por FormBase.Init() via DODEFAULT()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        THIS.this_oBusinessObject = CREATEOBJECT("SigPdMp5BO")
        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            MsgErro("Erro ao criar SigPdMp5BO.", "FormSigPdMp5.InicializarForm")
            RETURN loc_lSucesso
        ENDIF

        TRY
            THIS.LockScreen = .T.

            THIS.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"

            IF TYPE("gc_4c_CaminhoIcones") = "C"
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            *-- Layout (form OPERACIONAL: plano, sem PageFrame interno)
            THIS.ConfigurarPageFrame()

            THIS.ConfigurarCabecalho()
            THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
            THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
            THIS.ConfigurarContainer1()
            THIS.ConfigurarContainerOperacao()
            THIS.ConfigurarContainerOrigem()
            THIS.ConfigurarContainerDestino()
            THIS.ConfigurarBotaoSair()

            *-- Compatibilidade com pipeline CRUD (idempotente em OPERACIONAL)
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

            THIS.TornarControlesVisiveis(THIS)
            THIS.CarregarGrade()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar: " + loc_oErro.Message, "FormSigPdMp5.InicializarForm")
            loc_lSucesso = .F.
        ENDTRY

        THIS.LockScreen = .F.

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Adiciona labels de titulo no cnt_4c_Sombra
    * Equivale a lblSombra + lblTitulo dentro de cntSombra no legado
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cCaption
        loc_cCaption = THIS.Caption

        WITH THIS.cnt_4c_Sombra
            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = loc_cCaption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = 769
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .Caption    = loc_cCaption
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = 769
                .ForeColor  = RGB(255, 255, 255)
                .Visible    = .T.
            ENDWITH
        ENDWITH

        THIS.cnt_4c_Sombra.Visible = .T.
    ENDPROC

    *==========================================================================
    * ConfigurarContainer1 - Titulo "Movimentacao" + linha separadora
    * Equivale ao Container1 do legado
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainer1()
        WITH THIS.cnt_4c_Container1
            .AddObject("lbl_4c_TituloMov", "Label")
            WITH .lbl_4c_TituloMov
                .FontBold  = .T.
                .FontSize  = 8
                .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                .Left      = 9
                .Top       = 3
                .AutoSize  = .T.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lin_4c_LineContainer1", "Line")
            WITH .lin_4c_LineContainer1
                .BorderWidth = 2
                .Height      = 0
                .Left        = 9
                .Top         = 19
                .Width       = 316
                .BorderColor = RGB(90, 90, 90)
                .Visible     = .T.
            ENDWITH
        ENDWITH

        THIS.cnt_4c_Container1.Visible = .T.
    ENDPROC

    *==========================================================================
    * ConfigurarContainerOperacao - Container dados da operacao corrente
    * Exibe empresa, descricao da operacao e numero do pedido (read-only)
    * Todos com ControlSource em TmpNens (datasession compartilhada com form pai)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerOperacao()
        WITH THIS.cnt_4c_Operacao
            *-- GetEmpresa: codigo da empresa (Left=2, Width=36)
            .AddObject("txt_4c_Empresa", "TextBox")
            WITH .txt_4c_Empresa
                .ReadOnly          = .T.
                .Left              = 2
                .Top               = 2
                .Width             = 36
                .Height            = 23
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor       = RGB(100, 100, 100)
                IF USED("tmpnens")
                    .ControlSource = "tmpnens.emps"
                ENDIF
                .Visible           = .T.
            ENDWITH

            *-- GetOperacao: descricao da operacao (Left=40, Width=156)
            .AddObject("txt_4c_Operacao", "TextBox")
            WITH .txt_4c_Operacao
                .ReadOnly          = .T.
                .Left              = 40
                .Top               = 2
                .Width             = 156
                .Height            = 23
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor       = RGB(100, 100, 100)
                IF USED("tmpnens")
                    .ControlSource = "tmpnens.dopps"
                ENDIF
                .Visible           = .T.
            ENDWITH

            *-- GetCodigo: numero do pedido/producao (Left=198, Width=81)
            .AddObject("txt_4c_Codigo", "TextBox")
            WITH .txt_4c_Codigo
                .ReadOnly          = .T.
                .Left              = 198
                .Top               = 2
                .Width             = 81
                .Height            = 23
                .InputMask         = "9999999999"
                .Format            = "L"
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor       = RGB(100, 100, 100)
                IF USED("tmpnens")
                    .ControlSource = "tmpnens.numps"
                ENDIF
                .Visible           = .T.
            ENDWITH
        ENDWITH

        THIS.cnt_4c_Operacao.Visible = .T.
    ENDPROC

    *==========================================================================
    * ConfigurarContainerOrigem - Labels do container Origem
    * TextBoxes Get_grupo, Get_conta, Get_dconta adicionados nas Fases 5-6.
    * Visibilidade (Visible=.T./.F.) definida em CarregarDados conforme
    * crSigCdOpd.Origems. Permanece oculto ate o dado ser carregado.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerOrigem()
        WITH THIS.cnt_4c_Origem
            .AddObject("lbl_4c_TituloOrigem", "Label")
            WITH .lbl_4c_TituloOrigem
                .FontBold  = .T.
                .FontSize  = 8
                .Caption   = "Origem"
                .Left      = 9
                .Top       = 3
                .AutoSize  = .T.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lin_4c_LineOrigem", "Line")
            WITH .lin_4c_LineOrigem
                .BorderWidth = 2
                .Height      = 0
                .Left        = 9
                .Top         = 19
                .Width       = 316
                .BorderColor = RGB(90, 90, 90)
                .Visible     = .T.
            ENDWITH

            .AddObject("lbl_4c_LblGrupoO", "Label")
            WITH .lbl_4c_LblGrupoO
                .FontSize  = 8
                .Caption   = "Grupo"
                .Left      = 9
                .Top       = 22
                .AutoSize  = .T.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LblContaO", "Label")
            WITH .lbl_4c_LblContaO
                .FontSize  = 8
                .Caption   = "Conta"
                .Left      = 92
                .Top       = 22
                .AutoSize  = .T.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LblNomeO", "Label")
            WITH .lbl_4c_LblNomeO
                .FontSize  = 8
                .Caption   = "Nome"
                .Left      = 175
                .Top       = 22
                .AutoSize  = .T.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_GrupoO: grupo de origem (ControlSource = tmpnens.grupoos)
            .AddObject("txt_4c_GrupoO", "TextBox")
            WITH .txt_4c_GrupoO
                .ReadOnly          = .T.
                .Left              = 9
                .Top               = 36
                .Width             = 80
                .Height            = 20
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor       = RGB(100, 100, 100)
                IF USED("tmpnens")
                    .ControlSource = "tmpnens.grupoos"
                ENDIF
                .Visible           = .T.
            ENDWITH

            *-- txt_4c_ContaO: conta de origem (ControlSource = tmpnens.contaos)
            .AddObject("txt_4c_ContaO", "TextBox")
            WITH .txt_4c_ContaO
                .ReadOnly          = .T.
                .Left              = 92
                .Top               = 36
                .Width             = 80
                .Height            = 20
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor       = RGB(100, 100, 100)
                IF USED("tmpnens")
                    .ControlSource = "tmpnens.contaos"
                ENDIF
                .Visible           = .T.
            ENDWITH

            *-- txt_4c_Dconta: nome/razao da conta de origem (preenchido via SQL em CarregarGrade)
            .AddObject("txt_4c_Dconta", "TextBox")
            WITH .txt_4c_Dconta
                .ReadOnly          = .T.
                .Left              = 175
                .Top               = 36
                .Width             = 302
                .Height            = 23
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor       = RGB(100, 100, 100)
                .Value             = ""
                .Visible           = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerDestino - Labels do container Destino
    * TextBoxes Get_grupo, Get_conta, Get_dconta adicionados nas Fases 5-6.
    * Visibilidade definida em CarregarDados conforme crSigCdOpd.Destinos.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerDestino()
        WITH THIS.cnt_4c_Destino
            .AddObject("lbl_4c_TituloDestino", "Label")
            WITH .lbl_4c_TituloDestino
                .FontBold  = .T.
                .FontSize  = 8
                .Caption   = "Destino"
                .Left      = 9
                .Top       = 3
                .AutoSize  = .T.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lin_4c_LineDestino", "Line")
            WITH .lin_4c_LineDestino
                .BorderWidth = 2
                .Height      = 0
                .Left        = 9
                .Top         = 19
                .Width       = 318
                .BorderColor = RGB(90, 90, 90)
                .Visible     = .T.
            ENDWITH

            .AddObject("lbl_4c_LblGrupoD", "Label")
            WITH .lbl_4c_LblGrupoD
                .FontSize  = 8
                .Caption   = "Grupo"
                .Left      = 9
                .Top       = 22
                .AutoSize  = .T.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LblContaD", "Label")
            WITH .lbl_4c_LblContaD
                .FontSize  = 8
                .Caption   = "Conta"
                .Left      = 92
                .Top       = 22
                .AutoSize  = .T.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LblNomeD", "Label")
            WITH .lbl_4c_LblNomeD
                .FontSize  = 8
                .Caption   = "Nome"
                .Left      = 175
                .Top       = 22
                .AutoSize  = .T.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_GrupoD: grupo de destino (ControlSource = tmpnens.grupods)
            .AddObject("txt_4c_GrupoD", "TextBox")
            WITH .txt_4c_GrupoD
                .ReadOnly          = .T.
                .Left              = 9
                .Top               = 36
                .Width             = 80
                .Height            = 20
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor       = RGB(100, 100, 100)
                IF USED("tmpnens")
                    .ControlSource = "tmpnens.grupods"
                ENDIF
                .Visible           = .T.
            ENDWITH

            *-- txt_4c_ContaD: conta de destino (ControlSource = tmpnens.contads)
            .AddObject("txt_4c_ContaD", "TextBox")
            WITH .txt_4c_ContaD
                .ReadOnly          = .T.
                .Left              = 92
                .Top               = 36
                .Width             = 80
                .Height            = 20
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor       = RGB(100, 100, 100)
                IF USED("tmpnens")
                    .ControlSource = "tmpnens.contads"
                ENDIF
                .Visible           = .T.
            ENDWITH

            *-- txt_4c_Dconta: nome/razao da conta de destino (preenchido via SQL em CarregarGrade)
            .AddObject("txt_4c_Dconta", "TextBox")
            WITH .txt_4c_Dconta
                .ReadOnly          = .T.
                .Left              = 175
                .Top               = 36
                .Width             = 302
                .Height            = 23
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor       = RGB(100, 100, 100)
                .Value             = ""
                .Visible           = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoSair - Botao Sair/Cancel (ok no legado)
    * Posicao: Top=3, Left=925 (area do shp_4c_Shape1)
    * Click event adicionado nas Fases 7-8
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoSair()
        THIS.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cmd_4c_Ok
            .Top             = 3
            .Left            = 925
            .Width           = 75
            .Height          = 75
            .Caption         = "Sair"
            .Cancel          = .T.
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            IF TYPE("gc_4c_CaminhoIcones") = "C"
                .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            ENDIF
            .Visible = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "CmdOkClick")
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles do container visiveis
    * IMPORTANTE: cnt_4c_Origem e cnt_4c_Destino sao containers flutuantes
    * cuja visibilidade e definida por CarregarDados conforme crSigCdOpd
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl
        IF VARTYPE(par_oContainer) <> "O"
            RETURN
        ENDIF
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF UPPER(loc_oControl.Name) = "CNT_4C_ORIGEM" OR ;
               UPPER(loc_oControl.Name) = "CNT_4C_DESTINO"
                LOOP
            ENDIF
            loc_oControl.Visible = .T.
            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Form OPERACIONAL: layout plano, sem PageFrame.
    * SIGPDMP5 original herda de `form` generico (NAO frmcadastro) e usa
    * Width=1000, Height=600, TitleBar=0 com Grade, containers Origem/Destino
    * e Operacao ancorados diretamente no form. Mantemos este metodo para
    * conformidade com a pipeline de migracao e como ponto de extensao.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Form operacional plano: containers/grade ja declarados via
        *-- ADD OBJECT no DEFINE CLASS; este metodo apenas ajusta visual global.
        THIS.AutoCenter = .T.
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Adiciona Grade e controles planos do form
    * Grade (5 colunas): Industrializacao, Pedido, Produto, Quantidade, Tempo/min
    * Controles planos: labels, txt_4c_Descr, edit_4c_MmObs, txt_4c_TotQt
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oGrid

        *-- Grade (Grade no legado): Top=338, Left=12, Width=482, Height=198
        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados

        WITH loc_oGrid
            .Top               = 338
            .Left              = 12
            .Height            = 198
            .Width             = 482
            .ColumnCount       = 5
            .AllowHeaderSizing = .F.
            .HeaderHeight      = 16
            .GridLineColor     = RGB(238,238,238)
            .RecordMark        = .F.
            .DeleteMark        = .F.

            *-- Column1: Industrializacao - somente leitura (When original sempre .F.)
            WITH .Column1
                .Width     = 94
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .FontName  = "Arial"
                .InputMask = "9999999999"
                WITH .Header1
                    .Caption   = "Industrializa" + CHR(231) + CHR(227) + "o"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                ENDWITH
                WITH .Text1
                    .FontName    = "Arial"
                    .BorderStyle = 0
                    .Margin      = 0
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Column2: Pedido - somente leitura (header atualizado em CarregarGrade)
            WITH .Column2
                .Alignment  = 4
                .Width      = 85
                .Movable    = .F.
                .Resizable  = .F.
                .ReadOnly   = .T.
                .Format     = "KLZ"
                .InputMask  = "9999999999"
                WITH .Header1
                    .Caption   = "Pedido"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                ENDWITH
                WITH .Text1
                    .Alignment   = 0
                    .BorderStyle = 0
                    .Format      = "KLZ"
                    .InputMask   = "9999999999"
                    .Margin      = 0
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Column3: Quantidade - somente leitura (When original: InList AND .F. = sempre .F.)
            WITH .Column3
                .ColumnOrder = 4
                .Width       = 88
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                .InputMask   = "999,999.999"
                WITH .Header1
                    .Caption   = "Quantidade"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Column4: Produto - somente leitura (ColumnOrder=3 = terceira coluna visivel)
            WITH .Column4
                .ColumnOrder = 3
                .Width       = 108
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .Caption   = "Produto"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Column5: Tempo/min - editavel conforme crSigCdOpd.apontas (setado em CarregarGrade)
            WITH .Column5
                .ColumnOrder = 5
                .FontSize    = 8
                .Width       = 72
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                .InputMask   = "99999"
                WITH .Header1
                    .Caption   = "Tempo/min"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            .Visible = .T.
        ENDWITH

        *-- BINDEVENT: AfterRowColChange para exibir descricao e imagem do produto
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
        *-- BINDEVENT: Column5.Text1 KeyPress - Tab apos edicao de Tempo/min foca o botao Ok
        *-- (unica coluna editavel: INSERIR/ALTERAR + TipoSubNivel=ENV + crSigCdOpd.apontas=1)
        BINDEVENT(THIS.grd_4c_Dados.Column5.Text1, "KeyPress", THIS, "GrdColumn5KeyPress")

        *-- Label "Descricao :" (Say2 no legado - Top=368, Left=503)
        THIS.AddObject("lbl_4c_LblDescricao", "Label")
        WITH THIS.lbl_4c_LblDescricao
            .FontSize  = 8
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Left      = 503
            .Top       = 368
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0,0,0)
            .Visible   = .T.
        ENDWITH

        *-- Label "Observacao :" (Say3 no legado - Top=414, Left=503)
        THIS.AddObject("lbl_4c_LblObservacao", "Label")
        WITH THIS.lbl_4c_LblObservacao
            .FontSize  = 8
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
            .Left      = 503
            .Top       = 414
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0,0,0)
            .Visible   = .T.
        ENDWITH

        *-- TextBox descricao do produto - read-only, preenchido em GrdDadosAfterRowColChange
        THIS.AddObject("txt_4c_Descr", "TextBox")
        WITH THIS.txt_4c_Descr
            .FontSize    = 8
            .Height      = 23
            .Left        = 503
            .Top         = 384
            .Width       = 484
            .ForeColor   = RGB(0,0,0)
            .ReadOnly    = .T.
            .Value       = ""
            .BackColor   = RGB(255,255,255)
            .Visible     = .T.
        ENDWITH

        *-- EditBox observacao (ControlSource = xmfas.obsps via datasession compartilhada)
        THIS.AddObject("edit_4c_MmObs", "EditBox")
        WITH THIS.edit_4c_MmObs
            .FontSize      = 8
            .Height        = 106
            .Left          = 503
            .Top           = 430
            .Width         = 484
            .ForeColor     = RGB(0,0,0)
            .ReadOnly      = .T.
            IF USED("xMFas")
                .ControlSource = "xmfas.obsps"
            ENDIF
            .Visible       = .T.
        ENDWITH

        *-- TextBox total de quantidade (read-only, preenchido em CarregarGrade)
        THIS.AddObject("txt_4c_TotQt", "TextBox")
        WITH THIS.txt_4c_TotQt
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Height            = 21
            .InputMask         = "999,999.999"
            .Left              = 312
            .MaxLength         = 11
            .ReadOnly          = .T.
            .Top               = 538
            .Width             = 90
            .Value             = 0
            .ForeColor         = RGB(0,0,0)
            .DisabledBackColor = RGB(255,255,255)
            .DisabledForeColor = RGB(0,0,128)
            .Visible           = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Form OPERACIONAL nao tem Page2/Dados separada.
    * Os campos "equivalentes a Page2" sao Get_descr, Mm_obs, TotQt e os
    * sub-containers Origem/Destino/Operacao, ancorados direto no form.
    * Adicionados nas fases 5-6 via AddObject em ConfigurarCampos.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Idempotente: containers Origem/Destino criados via ADD OBJECT.
        *-- Visibilidade real (Visible=.T./.F.) sera definida em CarregarDados
        *-- conforme crSigCdOpd.Origems/Destinos nas fases seguintes.
        IF PEMSTATUS(THIS, "cnt_4c_Operacao", 5)
            THIS.cnt_4c_Operacao.Visible = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * AlternarPagina - Form OPERACIONAL nao tem PageFrame interno.
    * SIGPDMP5 eh um sub-dialog modal sem alternancia Lista/Dados.
    * Mantido por compatibilidade com a pipeline CRUD que pode invoca-lo.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *==========================================================================
    * CarregarGrade - Configura RecordSource e dados iniciais da grade
    * Executado apos ConfigurarPaginaLista() ter criado o grid
    *==========================================================================
    PROCEDURE CarregarGrade()
        LOCAL loc_oGrid, loc_nTotQt, loc_lEditCol5, loc_cSQL, loc_oErro

        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5) OR !USED("xMFas")
            RETURN
        ENDIF

        loc_oGrid  = THIS.grd_4c_Dados
        loc_nTotQt = 0

        TRY
            THIS.LockScreen = .T.

            SELECT xMFas
            GO TOP

            *-- RecordSource e ControlSources (recria headers apos RecordSource - VFP os reseta)
            *-- IMPORTANTE: ColumnCount e RecordSource FORA do WITH para evitar 'Unknown member COLUMN1'
            loc_oGrid.ColumnCount  = 5
            loc_oGrid.RecordSource = "xMFas"
            WITH loc_oGrid
                .Column1.ControlSource = "xMFas.Nops"
                .Column2.ControlSource = "xMFas.Nenvs"
                .Column3.ControlSource = "xMFas.Qtds"
                .Column4.ControlSource = "xMFas.CodPds"
                .Column5.ControlSource = "xMFas.TmpMins"
            ENDWITH

            *-- Header Column2: titulo do form pai (ex: "Pedido", "NF", etc.)
            IF VARTYPE(THIS.this_oFormPai) = "O" AND ;
               TYPE("THIS.this_oFormPai.Titulo") = "C"
                loc_oGrid.Column2.Header1.Caption = THIS.this_oFormPai.Titulo
            ENDIF

            *-- Redefine headers apos RecordSource (obrigatorio - VFP reseta)
            loc_oGrid.Column1.Header1.Caption = "Industrializa" + CHR(231) + CHR(227) + "o"
            loc_oGrid.Column3.Header1.Caption = "Quantidade"
            loc_oGrid.Column4.Header1.Caption = "Produto"
            loc_oGrid.Column5.Header1.Caption = "Tempo/min"

            *-- Total de quantidade (Sum de todos os registros de xMFas)
            SELECT xMFas
            GO TOP
            SUM Qtds TO loc_nTotQt
            IF PEMSTATUS(THIS, "txt_4c_TotQt", 5)
                THIS.txt_4c_TotQt.Value = NVL(loc_nTotQt, 0)
                THIS.txt_4c_TotQt.Refresh()
            ENDIF
            GO TOP

            *-- Visibilidade de Origem/Destino conforme operacao corrente
            IF USED("crSigCdOpd") AND !EOF("crSigCdOpd")
                THIS.cnt_4c_Origem.Visible  = crSigCdOpd.Origems
                THIS.cnt_4c_Destino.Visible = crSigCdOpd.Destinos

                *-- Column5 editavel: INSERIR/ALTERAR + TipoSubNivel=ENV + apontas=1
                loc_lEditCol5 = INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")
                IF loc_lEditCol5
                    IF VARTYPE(THIS.this_oFormPai) = "O" AND ;
                       PEMSTATUS(THIS.this_oFormPai, "TipoSubNivel", 5)
                        loc_lEditCol5 = ALLTRIM(THIS.this_oFormPai.TipoSubNivel) = "ENV"
                    ELSE
                        loc_lEditCol5 = .F.
                    ENDIF
                ENDIF
                IF loc_lEditCol5
                    loc_lEditCol5 = crSigCdOpd.apontas
                ENDIF
                loc_oGrid.Column5.ReadOnly = !loc_lEditCol5
            ENDIF

            *-- Preenche nome de Origem (SigCdCli por IClis = TmpNens.Contaos)
            IF USED("TmpNens") AND !EOF("TmpNens") AND THIS.cnt_4c_Origem.Visible
                IF PEMSTATUS(THIS.cnt_4c_Origem, "txt_4c_Dconta", 5)
                    IF USED("cursor_4c_CliO")
                        USE IN cursor_4c_CliO
                    ENDIF
                    loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                               FormatarNumeroSQL(TmpNens.Contaos)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliO") > 0 AND ;
                       USED("cursor_4c_CliO") AND !EOF("cursor_4c_CliO")
                        THIS.cnt_4c_Origem.txt_4c_Dconta.Value = ALLTRIM(NVL(cursor_4c_CliO.RClis, ""))
                    ENDIF
                    IF USED("cursor_4c_CliO")
                        USE IN cursor_4c_CliO
                    ENDIF
                ENDIF
            ENDIF

            *-- Preenche nome de Destino (SigCdCli por IClis = TmpNens.Contads)
            IF USED("TmpNens") AND !EOF("TmpNens") AND THIS.cnt_4c_Destino.Visible
                IF PEMSTATUS(THIS.cnt_4c_Destino, "txt_4c_Dconta", 5)
                    IF USED("cursor_4c_CliD")
                        USE IN cursor_4c_CliD
                    ENDIF
                    loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                               FormatarNumeroSQL(TmpNens.Contads)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliD") > 0 AND ;
                       USED("cursor_4c_CliD") AND !EOF("cursor_4c_CliD")
                        THIS.cnt_4c_Destino.txt_4c_Dconta.Value = ALLTRIM(NVL(cursor_4c_CliD.RClis, ""))
                    ENDIF
                    IF USED("cursor_4c_CliD")
                        USE IN cursor_4c_CliD
                    ENDIF
                ENDIF
            ENDIF

            THIS.FormatarGridDados(loc_oGrid)

            IF PEMSTATUS(THIS, "txt_4c_Descr", 5)
                THIS.txt_4c_Descr.Value = ""
            ENDIF

            SELECT xMFas
            loc_oGrid.SetFocus()
            *-- Foca Column5 (unica editavel) para replicar comportamento original:
            *-- "ThisForm.grade.column5.text1.SetFocus" no Init do legado
            TRY
                loc_oGrid.Column5.Text1.SetFocus()
            CATCH
                *-- Coluna pode estar read-only no modo atual; foco no grid e suficiente
            ENDTRY

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar grade: " + loc_oErro.Message, ;
                    "FormSigPdMp5.CarregarGrade")
        ENDTRY

        THIS.LockScreen = .F.
    ENDPROC

    *==========================================================================
    * GrdDadosAfterRowColChange - Exibe descricao e imagem do produto ao navegar
    * PUBLIC: obrigatorio para BINDEVENT
    *==========================================================================
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        LOCAL loc_cSQL, loc_cArquivo, loc_cFoto, loc_oErro

        IF !USED("xMFas") OR EOF("xMFas")
            RETURN
        ENDIF

        TRY
            *-- Busca DPros e FigJpgs do produto corrente
            IF USED("cursor_4c_PrGrade")
                USE IN cursor_4c_PrGrade
            ENDIF
            loc_cSQL = "SELECT TOP 1 DPros, FigJpgs FROM SigCdPro " + ;
                       "WHERE CPros = " + EscaparSQL(ALLTRIM(xMFas.CodPds))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrGrade") > 0 AND ;
               USED("cursor_4c_PrGrade") AND !EOF("cursor_4c_PrGrade")

                THIS.txt_4c_Descr.Value = ALLTRIM(NVL(cursor_4c_PrGrade.DPros, ""))

                *-- Exibe imagem somente se operacao permite (crSigCdOpd.Imagems=.T.)
                IF USED("crSigCdOpd") AND !EOF("crSigCdOpd") AND crSigCdOpd.Imagems
                    CLEAR RESOURCES
                    THIS.img_4c_FigJpg.Picture = ""
                    THIS.img_4c_FigJpg.Visible = .F.
                    THIS.shp_4c_Shape4.Visible = .F.

                    IF !EMPTY(cursor_4c_PrGrade.FigJpgs) AND !ISNULL(cursor_4c_PrGrade.FigJpgs)
                        loc_cArquivo = SYS(2023) + "\SigPdMp5.Jpg"
                        loc_cFoto    = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                                           cursor_4c_PrGrade.FigJpgs, ;
                                           "data:image/png;base64,", ""), ;
                                           "data:image/jpeg;base64,", ""), ;
                                           "data:image/jpg;base64,", ""), 14)
                        IF STRTOFILE(loc_cFoto, loc_cArquivo) > 0
                            THIS.img_4c_FigJpg.Picture = loc_cArquivo
                            THIS.img_4c_FigJpg.Visible = .T.
                            THIS.shp_4c_Shape4.Visible = .T.
                        ENDIF
                    ENDIF
                ENDIF

                USE IN cursor_4c_PrGrade
            ELSE
                THIS.txt_4c_Descr.Value = ""
                IF USED("cursor_4c_PrGrade")
                    USE IN cursor_4c_PrGrade
                ENDIF
            ENDIF

            SELECT xMFas
            THIS.Refresh()
            IF PEMSTATUS(THIS, "edit_4c_MmObs", 5)
                THIS.edit_4c_MmObs.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao exibir produto: " + loc_oErro.Message, ;
                    "FormSigPdMp5.GrdDadosAfterRowColChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdOkClick - Fecha sub-dialog e reativa o form pai
    * PUBLIC: obrigatorio para BINDEVENT (Cancel=.T. -> ESC tambem dispara)
    *==========================================================================
    PROCEDURE CmdOkClick()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
            TRY
                THIS.this_oFormPai.pgf_4c_Paginas.Page2.txt_4c_Operacao.SetFocus()
            CATCH
                *-- Form pai pode ter nomenclatura diferente; habilitar eh suficiente
            ENDTRY
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * GrdColumn5KeyPress - Column5 (Tempo/min) KeyPress: Tab -> foca botao Ok
    * PUBLIC: obrigatorio para BINDEVENT
    * Replicar comportamento de Column2.Text1.KeyPress do legado que focava Ok
    * no Tab. Aplicado aqui na coluna editavel (Column5) que o usuario realmente
    * visita ao pressionar Tab apos editar Tempo/min.
    *==========================================================================
    PROCEDURE GrdColumn5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 9 AND PEMSTATUS(THIS, "cmd_4c_Ok", 5)
            THIS.cmd_4c_Ok.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * FormatarGridDados - Formata visual da grade
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridDados(par_oGrid)
        WITH par_oGrid
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Configura sub-dialog para modo INSERIR
    * Recarrega grade habilitando Column5 (Tempo/min) se condicoes forem atendidas
    * (TipoSubNivel=ENV + crSigCdOpd.apontas=1)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_cEscolha = "INSERIR"
        THIS.CarregarGrade()
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Configura sub-dialog para modo ALTERAR
    * Recarrega grade habilitando Column5 (Tempo/min) se condicoes forem atendidas
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        THIS.this_cEscolha = "ALTERAR"
        THIS.CarregarGrade()
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Configura sub-dialog para modo VISUALIZAR
    * Recarrega grade em modo somente leitura (Column5.ReadOnly = .T.)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        THIS.this_cEscolha = "VISUALIZAR"
        THIS.CarregarGrade()
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Configura sub-dialog para modo EXCLUIR
    * Exibe itens em modo somente leitura (sem edicao de quantidade/tempo)
    * O form pai e responsavel pela exclusao real dos registros de xMFas/xPesa
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        THIS.this_cEscolha = "EXCLUIR"
        THIS.CarregarGrade()
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarLista - Wrapper para CarregarGrade (compatibilidade pipeline)
    * Recarrega o grid xMFas com dados atuais do cursor compartilhado
    *==========================================================================
    PROCEDURE CarregarLista()
        THIS.CarregarGrade()
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Sub-dialog tem apenas botao Sair (sem CRUD)
    * Ajusta estado do botao Sair e da Column5 conforme modo corrente
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lSomenteLeitura

        *-- cmd_4c_Ok (Sair) permanece sempre habilitado
        IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
            THIS.cmd_4c_Ok.Enabled = .T.
        ENDIF

        *-- Column5 (Tempo/min): editavel somente em INSERIR/ALTERAR + ENV + apontas=1
        loc_lSomenteLeitura = .T.
        IF INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")
            IF VARTYPE(THIS.this_oFormPai) = "O" AND ;
               PEMSTATUS(THIS.this_oFormPai, "TipoSubNivel", 5)
                IF ALLTRIM(THIS.this_oFormPai.TipoSubNivel) = "ENV"
                    IF USED("crSigCdOpd") AND !EOF("crSigCdOpd")
                        loc_lSomenteLeitura = !crSigCdOpd.apontas
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Column5.ReadOnly = loc_lSomenteLeitura
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Controla editabilidade dos campos conforme modo
    * Todos os TextBoxes do form sao read-only; apenas Column5 varia
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        *-- Campos de exibicao: sempre read-only (dados vem dos cursores do pai)
        IF PEMSTATUS(THIS, "txt_4c_Descr", 5)
            THIS.txt_4c_Descr.ReadOnly = .T.
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_TotQt", 5)
            THIS.txt_4c_TotQt.ReadOnly = .T.
        ENDIF
        IF PEMSTATUS(THIS, "edit_4c_MmObs", 5)
            THIS.edit_4c_MmObs.ReadOnly = .T.
        ENDIF

        *-- Containers Origem/Destino: campos internos sempre read-only
        IF PEMSTATUS(THIS, "cnt_4c_Origem", 5)
            WITH THIS.cnt_4c_Origem
                IF PEMSTATUS(THIS.cnt_4c_Origem, "txt_4c_GrupoO", 5)
                    THIS.cnt_4c_Origem.txt_4c_GrupoO.ReadOnly = .T.
                ENDIF
                IF PEMSTATUS(THIS.cnt_4c_Origem, "txt_4c_ContaO", 5)
                    THIS.cnt_4c_Origem.txt_4c_ContaO.ReadOnly = .T.
                ENDIF
                IF PEMSTATUS(THIS.cnt_4c_Origem, "txt_4c_Dconta", 5)
                    THIS.cnt_4c_Origem.txt_4c_Dconta.ReadOnly = .T.
                ENDIF
                .Visible     = .T.
            ENDWITH
        ENDIF

        IF PEMSTATUS(THIS, "cnt_4c_Destino", 5)
            IF PEMSTATUS(THIS.cnt_4c_Destino, "txt_4c_GrupoD", 5)
                THIS.cnt_4c_Destino.txt_4c_GrupoD.ReadOnly = .T.
            ENDIF
            IF PEMSTATUS(THIS.cnt_4c_Destino, "txt_4c_ContaD", 5)
                THIS.cnt_4c_Destino.txt_4c_ContaD.ReadOnly = .T.
            ENDIF
            IF PEMSTATUS(THIS.cnt_4c_Destino, "txt_4c_Dconta", 5)
                THIS.cnt_4c_Destino.txt_4c_Dconta.ReadOnly = .T.
            ENDIF
        ENDIF

        *-- Column5 depende do modo (delegado para AjustarBotoesPorModo)
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa campos de exibicao (nao afeta cursores do form pai)
    * Os cursores xMFas/xPesa/TmpNens/crSigCdOpd sao gerenciados pelo form pai
    *==========================================================================
    PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "txt_4c_Descr", 5)
            THIS.txt_4c_Descr.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_TotQt", 5)
            THIS.txt_4c_TotQt.Value = 0
        ENDIF
        IF PEMSTATUS(THIS, "img_4c_FigJpg", 5)
            THIS.img_4c_FigJpg.Picture = ""
            THIS.img_4c_FigJpg.Visible = .F.
        ENDIF
        IF PEMSTATUS(THIS, "shp_4c_Shape4", 5)
            THIS.shp_4c_Shape4.Visible = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Le valores do form para as propriedades do BO
    * Leitura da linha corrente de xMFas + TmpNens + crSigCdOpd
    *==========================================================================
    PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            RETURN
        ENDIF

        *-- Linha corrente de xMFas (grid)
        IF USED("xMFas") AND !EOF("xMFas")
            THIS.this_oBusinessObject.CarregarDoCursor("xMFas")
        ENDIF

        *-- Operacao e contas de xMFas/TmpNens
        IF USED("TmpNens") AND !EOF("TmpNens")
            THIS.this_oBusinessObject.CarregarOperacao("TmpNens")
        ENDIF

        *-- Flags de crSigCdOpd
        IF USED("crSigCdOpd") AND !EOF("crSigCdOpd")
            THIS.this_oBusinessObject.CarregarFlagsOperacao("crSigCdOpd")
        ENDIF

        *-- Contexto do form pai
        THIS.this_oBusinessObject.this_cPcEscolha = THIS.this_cEscolha
        IF VARTYPE(THIS.this_oFormPai) = "O" AND ;
           PEMSTATUS(THIS.this_oFormPai, "TipoSubNivel", 5)
            THIS.this_oBusinessObject.this_cTipoSubNivel = ;
                ALLTRIM(NVL(THIS.this_oFormPai.TipoSubNivel, ""))
        ENDIF

        *-- Valores de display: descricao do produto (lido de txt_4c_Descr)
        IF PEMSTATUS(THIS, "txt_4c_Descr", 5)
            THIS.this_oBusinessObject.this_cDpros = ALLTRIM(NVL(THIS.txt_4c_Descr.Value, ""))
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Carrega propriedades do BO de volta nos controles do form
    * Atualiza campos de exibicao com dados calculados pelo BO
    *==========================================================================
    PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            RETURN
        ENDIF

        *-- Descricao do produto
        IF PEMSTATUS(THIS, "txt_4c_Descr", 5)
            THIS.txt_4c_Descr.Value = THIS.this_oBusinessObject.this_cDpros
        ENDIF

        *-- Total de quantidade
        IF PEMSTATUS(THIS, "txt_4c_TotQt", 5)
            THIS.txt_4c_TotQt.Value = THIS.this_oBusinessObject.this_nTotQt
            THIS.txt_4c_TotQt.Refresh()
        ENDIF

        *-- Nome da conta de origem
        IF PEMSTATUS(THIS, "cnt_4c_Origem", 5) AND ;
           PEMSTATUS(THIS.cnt_4c_Origem, "txt_4c_Dconta", 5)
            THIS.cnt_4c_Origem.txt_4c_Dconta.Value = ;
                THIS.this_oBusinessObject.this_cDcontaOs
        ENDIF

        *-- Nome da conta de destino
        IF PEMSTATUS(THIS, "cnt_4c_Destino", 5) AND ;
           PEMSTATUS(THIS.cnt_4c_Destino, "txt_4c_Dconta", 5)
            THIS.cnt_4c_Destino.txt_4c_Dconta.Value = ;
                THIS.this_oBusinessObject.this_cDcontaDs
        ENDIF

        *-- Visibilidade de Origem/Destino conforme flags do BO
        IF PEMSTATUS(THIS, "cnt_4c_Origem", 5)
            THIS.cnt_4c_Origem.Visible = (THIS.this_oBusinessObject.this_nOrigems = 1)
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Destino", 5)
            THIS.cnt_4c_Destino.Visible = (THIS.this_oBusinessObject.this_nDestinos = 1)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega o grid com dados atuais do cursor xMFas
    * Equivalente a pressionar F5 em forms CRUD; aqui: refresh da grade
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.CalcularTotalQtds("xMFas")
        ENDIF
        THIS.CarregarGrade()
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o sub-dialog (alias para CmdOkClick)
    * Reativa o form pai e libera o sub-dialog
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.CmdOkClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Aplica alteracoes de Qtds/TmpMins ao cursor xPesa
    * Percorre xMFas e sincroniza xPesa.Qtds para cada Nops (replica
    * logica do Column3.Text1.Valid do legado de forma explicita/batch)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso, loc_nNopsOrig, loc_oErro

        IF !USED("xMFas") OR !USED("xPesa")
            MsgAviso("Cursor de movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Salvar")
            RETURN
        ENDIF

        TRY
            loc_lSucesso = .T.

            *-- Guarda posicao atual
            SELECT xMFas
            loc_nNopsOrig = IIF(!EOF("xMFas"), xMFas.Nops, 0)

            *-- Sincroniza Qtds de todas as linhas de xMFas para xPesa
            GO TOP
            DO WHILE !EOF("xMFas")
                IF SEEK(xMFas.Nops, "xPesa", "Nops")
                    REPLACE xPesa.Qtds WITH xMFas.Qtds IN xPesa
                ENDIF
                SELECT xMFas
                SKIP
            ENDDO

            *-- Restaura posicao original
            IF loc_nNopsOrig > 0
                SELECT xMFas
                SEEK loc_nNopsOrig ORDER TAG Nops
            ENDIF
            IF EOF("xMFas")
                GO TOP
            ENDIF

        CATCH TO loc_oErro
            loc_lSucesso = .F.
            MsgErro("Erro ao salvar quantidades:" + CHR(13) + loc_oErro.Message, ;
                    "FormSigPdMp5.BtnSalvarClick")
        ENDTRY

        IF loc_lSucesso
            THIS.CarregarGrade()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicoes e fecha o sub-dialog
    * Nao reverte cursores em memoria (responsabilidade do form pai)
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.CmdOkClick()
    ENDPROC

    *==========================================================================
    * Destroy
    *==========================================================================
    PROCEDURE Destroy()
        THIS.this_oBusinessObject = .NULL.
        THIS.this_oFormPai        = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
