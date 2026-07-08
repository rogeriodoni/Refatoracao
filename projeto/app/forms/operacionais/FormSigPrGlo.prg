*==============================================================================
* FormSigPrGlo.prg - Processamento de O.P.
* Tipo: OPERACIONAL (layout flat, sem PageFrame)
* Herda de: FormBase
* Legado: SigPrGlo.SCX
*
* Fase 7/8: Eventos principais
*   Form OPERACIONAL nao tem BtnIncluirClick/Alterar/Visualizar/Excluir (CRUD).
*   Os "eventos principais" equivalentes sao gerenciamento de estado em
*   CmdProcessarClick: bloqueio da UI durante ProcessarOrdens() via
*   AlternarPagina("PROCESSANDO") e restauracao via AlternarPagina("ENTRADA")
*   apos conclusao ou erro. CmdCancelarClick completo tambem documentado aqui.
*==============================================================================

DEFINE CLASS FormSigPrGlo AS FormBase

    *-- Dimensoes e aparencia (legado: Width=680, Height=379)
    Width        = 680
    Height       = 379
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    BorderStyle  = 2
    DataSession  = 2
    ClipControls = .F.
    Caption      = "Processamento de O.P."
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Flags de modo de operacao (recebidos via Init)
    this_lReserva         = .F.
    this_lAutomatico      = .F.
    this_lPorDestino      = .F.
    this_lGerPorTp        = .F.
    this_lAlterEmp        = .T.
    *-- Controlado apos leitura de crSigCdPam em InicializarForm
    this_lMostrarChkPedra = .F.

    *--------------------------------------------------------------------------
    * Init - recebe flags de modo, seta propriedades e delega ao FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_lReserva, par_lAutom, par_lPorDestino, par_pTipo)
        THIS.this_lReserva    = IIF(VARTYPE(par_lReserva)    = "L", par_lReserva,    .F.)
        THIS.this_lAutomatico = IIF(VARTYPE(par_lAutom)      = "L", par_lAutom,      .F.)
        THIS.this_lPorDestino = IIF(VARTYPE(par_lPorDestino) = "L", par_lPorDestino, .F.)
        THIS.this_lGerPorTp   = IIF(VARTYPE(par_pTipo)       = "L", par_pTipo,       .F.)
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria BO, carrega parametros e monta estrutura visual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cCaption, loc_cEmp
        loc_lSucesso = .F.

        TRY
            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGloBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPrGloBO.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Repassar flags de modo ao BO
            WITH THIS.this_oBusinessObject
                .this_lReserva    = THIS.this_lReserva
                .this_lAutomatico = THIS.this_lAutomatico
                .this_lPorDestino = THIS.this_lPorDestino
                .this_lGerPorTp   = THIS.this_lGerPorTp
                .this_lAlterEmp   = THIS.this_lAlterEmp
            ENDWITH

            *-- Carregar parametros de configuracao:
            *-- TmpOper, crSigCdPam, crSigCdPac, TmpTpGop, CrTmpTpGop
            IF NOT THIS.this_oBusinessObject.CarregarParametros(THIS.this_lGerPorTp)
                loc_lSucesso = .F.
            ENDIF

            *-- Caption dinamico conforme modo de operacao
            loc_cCaption = "Processamento de O.P."
            IF THIS.this_lReserva
                loc_cCaption = "Processar Reserva Autom" + CHR(225) + "tica"
            ELSE
                IF THIS.this_lGerPorTp
                loc_cCaption = "Processar Ordem de Produ" + CHR(231) + CHR(227) + "o por Tipo"
                ENDIF
            ENDIF
            THIS.Caption = loc_cCaption

            *-- Imagem de fundo
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            *-- Determinar visibilidade futura do Chec_pedra (criado na Fase 4)
            *-- Condicao original: DopEmphs E DopReqcs E DopPedcs E TransfRes preenchidos
            IF USED("crSigCdPam") AND NOT EOF("crSigCdPam")
                SELECT crSigCdPam
                THIS.this_lMostrarChkPedra = ;
                    (NOT EMPTY(ALLTRIM(crSigCdPam.DopEmphs)) AND ;
                     NOT EMPTY(ALLTRIM(crSigCdPam.DopReqcs)) AND ;
                     NOT EMPTY(ALLTRIM(crSigCdPam.DopPedcs)) AND ;
                     NOT EMPTY(ALLTRIM(crSigCdPam.TransfRes)))
            ENDIF

            *-- Carregar empresa padrao e popular BO
            loc_cEmp = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            THIS.this_oBusinessObject.CarregarEmpresa(loc_cEmp)

            *-- Montar estrutura visual do form
            THIS.ConfigurarCabecalho()
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption  = THIS.Caption
            THIS.ConfigurarShape()
            THIS.ConfigurarPaginaLista()
            THIS.TornarControlesVisiveis()
            THIS.PopularCamposIniciais()
            THIS.ConfigurarEventos()

            *-- Estado inicial: aguardando entrada do usuario
            THIS.AlternarPagina("ENTRADA")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar formul" + CHR(225) + "rio: " + ;
                    loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - cabecalho cinza escuro com titulo (cntSombra legado)
    * Top=0, Left=0, Width=680, Height=80
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top        = 0
            .Left       = 0
            .Width      = THIS.Width
            .Height     = 80
            .BackStyle  = 1
            .BackColor  = RGB(100,100,100)
            .BorderWidth = 0
            .Visible    = .T.

            *-- Sombra do titulo (deslocada 1px, cor preta)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize    = .F.
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .FontUnderline = .F.
                .WordWrap    = .T.
                .Alignment   = 0
                .BackStyle   = 0
                .Height      = 40
                .Left        = 10
                .Top         = 18
                .Width       = THIS.Width
                .ForeColor   = RGB(0,0,0)
                .Caption     = THIS.Caption
                .Visible     = .T.
            ENDWITH

            *-- Titulo principal (branco sobre fundo escuro)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize    = .F.
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .FontUnderline = .F.
                .WordWrap    = .T.
                .Alignment   = 0
                .BackStyle   = 0
                .Height      = 46
                .Left        = 10
                .Top         = 17
                .Width       = THIS.Width
                .ForeColor   = RGB(255,255,255)
                .Caption     = THIS.Caption
                .Visible     = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarShape - shape decorativo por tras dos botoes (Shape3 legado)
    * Top=7, Left=486, Height=110, Width=173
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarShape()
        THIS.AddObject("shp_4c_Shape3", "Shape")
        WITH THIS.shp_4c_Shape3
            .Top         = 7
            .Left        = 486
            .Height      = 110
            .Width       = 173
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(90,90,90)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - botoes principais Processar e Cancelar (Encerrar)
    * Processar: Top=3, Left=528, 75x75
    * Cancelar : Top=3, Left=603, 75x75
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        *-- Botao Processar
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top             = 3
            .Left            = 528
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = "Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        *-- Botao Cancelar (Encerrar) - Cancel=.T. ativa ESC (form sem TitleBar)
        THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH THIS.cmd_4c_Cancelar
            .Top             = 3
            .Left            = 603
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainers - cria containers principais vazios (filhos nas Fases 4+)
    *
    * Mapeamento legado -> novo:
    *   Container1  -> cnt_4c_TipoOp    (Tipo de O.P.: Get_TpGOp)
    *   Opera??o    -> cnt_4c_Operacao  (Opera??o/faixa: Get_Opera*/i/f)
    *   Conta       -> cnt_4c_Conta     (Movimenta??o: Get_grupo/conta/dconta)
    *   Responsavel -> cnt_4c_Responsavel (Vendedor: Get_grupo/conta/dconta)
    *   Empresa     -> cnt_4c_Empresa   (get_cd/ds_empresa + Chec_pedra)
    *   Cnt_Previsao-> cnt_4c_Previsao  (GetPrevisao + GetGeracao)
    *   Cnt_Op      -> cnt_4c_Op        (GetNop - visivel apenas se GlobAutos=2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainers()
        LOCAL loc_lGlobAutos2
        loc_lGlobAutos2 = .F.
        IF USED("crSigCdPam") AND NOT EOF("crSigCdPam")
            SELECT crSigCdPam
            loc_lGlobAutos2 = (crSigCdPam.GlobAutos = 2 AND NOT THIS.this_lReserva)
        ENDIF

        *-- Container1 legado: Tipo de O.P. - habilitado so no modo GerPorTp
        THIS.AddObject("cnt_4c_TipoOp", "Container")
        WITH THIS.cnt_4c_TipoOp
            .Top         = 164
            .Left        = 139
            .Width       = 346
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Enabled     = THIS.this_lGerPorTp
            .Visible     = .T.
        ENDWITH

        *-- Opera??o legado: codigo/faixa inicial/final de OP
        THIS.AddObject("cnt_4c_Operacao", "Container")
        WITH THIS.cnt_4c_Operacao
            .Top         = 191
            .Left        = 139
            .Width       = 350
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Conta legado: grupo/conta/descricao para filtro de movimentacao
        THIS.AddObject("cnt_4c_Conta", "Container")
        WITH THIS.cnt_4c_Conta
            .Top         = 218
            .Left        = 139
            .Width       = 553
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Responsavel legado: grupo/conta/descricao do vendedor
        THIS.AddObject("cnt_4c_Responsavel", "Container")
        WITH THIS.cnt_4c_Responsavel
            .Top         = 245
            .Left        = 139
            .Width       = 553
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Empresa legado: cd_empresa + ds_empresa + Chec_pedra
        THIS.AddObject("cnt_4c_Empresa", "Container")
        WITH THIS.cnt_4c_Empresa
            .Top         = 272
            .Left        = 138
            .Width       = 553
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Cnt_Previsao legado: data previsao entrega + data geracao
        *-- Oculto no modo Reserva (original: ThisForm.Cnt_Previsao.Visible = .f.)
        THIS.AddObject("cnt_4c_Previsao", "Container")
        WITH THIS.cnt_4c_Previsao
            .Top         = 309
            .Left        = 7
            .Width       = 660
            .Height      = 33
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = NOT THIS.this_lReserva
            .Visible     = .T.
        ENDWITH

        *-- Cnt_Op legado: numero da OP manual
        *-- Visivel apenas quando GlobAutos=2 e nao e modo Reserva
        THIS.AddObject("cnt_4c_Op", "Container")
        WITH THIS.cnt_4c_Op
            .Top         = 313
            .Left        = 478
            .Width       = 130
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = loc_lGlobAutos2
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna controles do form visiveis apos AddObject
    * Preserva Visible original de containers gerenciados individualmente
    * (cnt_4c_Op, cnt_4c_Cabecalho, cnt_4c_Previsao - cada um define seu Visible
    * proprio em ConfigurarContainers/ConfigurarCabecalho), mas recursa seus filhos
    * antes do LOOP para que estejam prontos quando o container vier a ser exibido.
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis()
        LOCAL loc_i, loc_oCtrl, loc_lSkip
        FOR loc_i = 1 TO THIS.ControlCount
            loc_oCtrl = THIS.Controls(loc_i)
            IF VARTYPE(loc_oCtrl) != "O"
                LOOP
            ENDIF
            loc_lSkip = INLIST(UPPER(loc_oCtrl.Name), "CNT_4C_OP", "CNT_4C_CABECALHO", "CNT_4C_PREVISAO")
            IF loc_lSkip
                *-- Recursar filhos ANTES do LOOP (regra anti-ghost para containers hidden)
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarSubControlesVisiveis(loc_oCtrl)
                ENDIF
                LOOP
            ENDIF
            IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                loc_oCtrl.Visible = .T.
            ENDIF
            IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                THIS.TornarSubControlesVisiveis(loc_oCtrl)
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oCtrl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oCtrl) = "O"
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarSubControlesVisiveis(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - libera cursores temporarios e BO antes de fechar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("TmpOper")
            USE IN TmpOper
        ENDIF
        IF USED("TmpOper2")
            USE IN TmpOper2
        ENDIF
        IF USED("CrTmpTpGop")
            USE IN CrTmpTpGop
        ENDIF
        IF USED("TmpTpGop")
            USE IN TmpTpGop
        ENDIF
        IF USED("crSigCdPam")
            USE IN crSigCdPam
        ENDIF
        IF USED("crSigCdPac")
            USE IN crSigCdPac
        ENDIF
        IF USED("crSigCdOpd")
            USE IN crSigCdOpd
        ENDIF
        IF USED("DBParam")
            USE IN DBParam
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposForm - labels e textboxes de data diretamente no form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposForm()
        THIS.AddObject("lbl_4c_PeriodoEmissao", "Label")
        WITH THIS.lbl_4c_PeriodoEmissao
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "Per" + CHR(237) + "odo de Emiss" + CHR(227) + "o :"
            .Height    = 15
            .Left      = 32
            .Top       = 115
            .Width     = 101
        ENDWITH

        THIS.AddObject("txt_4c_Dataei", "TextBox")
        WITH THIS.txt_4c_Dataei
            .Alignment     = 3
            .Value         = {}
            .Format        = "K"
            .Height        = 23
            .Left          = 142
            .Top           = 111
            .Width         = 80
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        THIS.AddObject("lbl_4c_Ate1", "Label")
        WITH THIS.lbl_4c_Ate1
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "at" + CHR(233)
            .Height    = 15
            .Left      = 227
            .Top       = 115
            .Width     = 18
        ENDWITH

        THIS.AddObject("txt_4c_Dataef", "TextBox")
        WITH THIS.txt_4c_Dataef
            .Alignment     = 3
            .Value         = {}
            .Format        = "K"
            .Height        = 23
            .Left          = 255
            .Top           = 111
            .Width         = 80
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        THIS.AddObject("lbl_4c_PrevEntrega", "Label")
        WITH THIS.lbl_4c_PrevEntrega
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "Previs" + CHR(227) + "o de Entrega :"
            .Height    = 15
            .Left      = 27
            .Top       = 142
            .Width     = 106
        ENDWITH

        THIS.AddObject("txt_4c_Datapi", "TextBox")
        WITH THIS.txt_4c_Datapi
            .Alignment     = 3
            .Value         = {}
            .Format        = "K"
            .Height        = 23
            .Left          = 142
            .Top           = 138
            .Width         = 80
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        THIS.AddObject("lbl_4c_Ate2", "Label")
        WITH THIS.lbl_4c_Ate2
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "at" + CHR(233)
            .Height    = 15
            .Left      = 227
            .Top       = 142
            .Width     = 18
        ENDWITH

        THIS.AddObject("txt_4c_Datapf", "TextBox")
        WITH THIS.txt_4c_Datapf
            .Alignment     = 3
            .Value         = {}
            .Format        = "K"
            .Height        = 23
            .Left          = 254
            .Top           = 138
            .Width         = 80
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        THIS.AddObject("lbl_4c_TipoOp", "Label")
        WITH THIS.lbl_4c_TipoOp
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "Tipo de O.P.:"
            .Height    = 15
            .Left      = 67
            .Top       = 169
            .Width     = 66
        ENDWITH

        THIS.AddObject("lbl_4c_Movimentacao", "Label")
        WITH THIS.lbl_4c_Movimentacao
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
            .Height    = 15
            .Left      = 55
            .Top       = 196
            .Width     = 78
        ENDWITH

        THIS.AddObject("lbl_4c_LblConta", "Label")
        WITH THIS.lbl_4c_LblConta
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "Conta :"
            .Height    = 15
            .Left      = 139
            .Top       = 223
            .Width     = 38
        ENDWITH

        THIS.AddObject("lbl_4c_Vendedor", "Label")
        WITH THIS.lbl_4c_Vendedor
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "Vendedor :"
            .Height    = 15
            .Left      = 78
            .Top       = 250
            .Width     = 55
        ENDWITH

        THIS.AddObject("lbl_4c_LblEmpresa", "Label")
        WITH THIS.lbl_4c_LblEmpresa
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "Empresa :"
            .Height    = 15
            .Left      = 83
            .Top       = 277
            .Width     = 50
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerTipoOp - Get_TpGOp (Container1 legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerTipoOp()
        THIS.cnt_4c_TipoOp.AddObject("txt_4c_TpGOp", "TextBox")
        WITH THIS.cnt_4c_TipoOp.txt_4c_TpGOp
            .Left          = 3
            .Top           = 1
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .FontName      = "Courier New"
            .FontSize      = 9
            .Margin        = 2
            .SpecialEffect = 1
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerOperacao - Opera_ao legado: codigo + faixa i/f
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerOperacao()
        THIS.cnt_4c_Operacao.AddObject("txt_4c_Operacao", "TextBox")
        WITH THIS.cnt_4c_Operacao.txt_4c_Operacao
            .Left          = 3
            .Top           = 1
            .Width         = 151
            .Height        = 23
            .MaxLength     = 20
            .FontName      = "Courier New"
            .FontSize      = 9
            .Margin        = 2
            .SpecialEffect = 1
        ENDWITH

        THIS.cnt_4c_Operacao.AddObject("lbl_4c_De", "Label")
        WITH THIS.cnt_4c_Operacao.lbl_4c_De
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "de"
            .Height    = 15
            .Left      = 180
            .Top       = 5
            .Width     = 14
        ENDWITH

        THIS.cnt_4c_Operacao.AddObject("txt_4c_Operacaoi", "TextBox")
        WITH THIS.cnt_4c_Operacao.txt_4c_Operacaoi
            .Alignment     = 3
            .Value         = 0
            .Format        = "K"
            .Height        = 23
            .InputMask     = "999999"
            .Left          = 201
            .Top           = 1
            .Width         = 55
            .MaxLength     = 6
            .SpecialEffect = 1
            .FontName      = "Courier New"
            .FontSize      = 9
        ENDWITH

        THIS.cnt_4c_Operacao.AddObject("lbl_4c_AteOp", "Label")
        WITH THIS.cnt_4c_Operacao.lbl_4c_AteOp
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "at" + CHR(233)
            .Height    = 15
            .Left      = 262
            .Top       = 4
            .Width     = 18
        ENDWITH

        THIS.cnt_4c_Operacao.AddObject("txt_4c_Operacaof", "TextBox")
        WITH THIS.cnt_4c_Operacao.txt_4c_Operacaof
            .Alignment     = 3
            .Value         = 0
            .Format        = "K"
            .Height        = 23
            .InputMask     = "999999"
            .Left          = 286
            .Top           = 1
            .Width         = 55
            .MaxLength     = 6
            .SpecialEffect = 1
            .FontName      = "Courier New"
            .FontSize      = 9
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerConta - Movimentacao: grupo/conta/descricao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerConta()
        THIS.cnt_4c_Conta.AddObject("txt_4c_Grupo", "TextBox")
        WITH THIS.cnt_4c_Conta.txt_4c_Grupo
            .Left          = 3
            .Top           = 1
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        THIS.cnt_4c_Conta.AddObject("txt_4c_Conta", "TextBox")
        WITH THIS.cnt_4c_Conta.txt_4c_Conta
            .Left          = 86
            .Top           = 1
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        THIS.cnt_4c_Conta.AddObject("txt_4c_Dconta", "TextBox")
        WITH THIS.cnt_4c_Conta.txt_4c_Dconta
            .Left          = 170
            .Top           = 1
            .Width         = 360
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerResponsavel - Vendedor: grupo/conta/descricao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerResponsavel()
        THIS.cnt_4c_Responsavel.AddObject("txt_4c_GrupoResp", "TextBox")
        WITH THIS.cnt_4c_Responsavel.txt_4c_GrupoResp
            .Left          = 3
            .Top           = 1
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        THIS.cnt_4c_Responsavel.AddObject("txt_4c_ContaResp", "TextBox")
        WITH THIS.cnt_4c_Responsavel.txt_4c_ContaResp
            .Left          = 86
            .Top           = 1
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        THIS.cnt_4c_Responsavel.AddObject("txt_4c_DcontaResp", "TextBox")
        WITH THIS.cnt_4c_Responsavel.txt_4c_DcontaResp
            .Left          = 170
            .Top           = 1
            .Width         = 360
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerEmpresa - cd_empresa / ds_empresa / chk pedras
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerEmpresa()
        THIS.cnt_4c_Empresa.AddObject("txt_4c_CdEmpresa", "TextBox")
        WITH THIS.cnt_4c_Empresa.txt_4c_CdEmpresa
            .Left          = 4
            .Top           = 1
            .Width         = 31
            .Height        = 23
            .InputMask     = "XXX"
            .MaxLength     = 3
            .Format        = "k"
            .BackStyle     = 1
            .BorderStyle   = 1
            .ForeColor     = RGB(0,0,0)
            .FontName      = "Courier New"
            .FontSize      = 9
            .SpecialEffect = 1
        ENDWITH

        THIS.cnt_4c_Empresa.AddObject("txt_4c_DsEmpresa", "TextBox")
        WITH THIS.cnt_4c_Empresa.txt_4c_DsEmpresa
            .Left          = 38
            .Top           = 1
            .Width         = 282
            .Height        = 23
            .MaxLength     = 40
            .Format        = "K"
            .FontName      = "Courier New"
            .FontSize      = 9
            .SpecialEffect = 1
        ENDWITH

        THIS.cnt_4c_Empresa.AddObject("chk_4c_NaoEmpPedra", "CheckBox")
        WITH THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra
            .Left      = 330
            .Top       = 5
            .Height    = 15
            .Width     = 124
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "N" + CHR(227) + "o Empenhar Pedras"
            .Value     = 0
            .ForeColor = RGB(90,90,90)
            .Visible   = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerPrevisao - data previsao entrega + data geracao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerPrevisao()
        THIS.cnt_4c_Previsao.AddObject("lbl_4c_LblPrevisao", "Label")
        WITH THIS.cnt_4c_Previsao.lbl_4c_LblPrevisao
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "Previs" + CHR(227) + "o de Entrega :"
            .Height    = 15
            .Left      = 7
            .Top       = 9
            .Width     = 106
        ENDWITH

        THIS.cnt_4c_Previsao.AddObject("txt_4c_Previsao", "TextBox")
        WITH THIS.cnt_4c_Previsao.txt_4c_Previsao
            .Alignment     = 3
            .Value         = {}
            .Format        = "K"
            .Height        = 23
            .Left          = 134
            .Top           = 5
            .Width         = 80
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        THIS.cnt_4c_Previsao.AddObject("lbl_4c_LblGeracao", "Label")
        WITH THIS.cnt_4c_Previsao.lbl_4c_LblGeracao
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "Data de Gera" + CHR(231) + CHR(227) + "o :"
            .Height    = 15
            .Left      = 244
            .Top       = 9
            .Width     = 90
        ENDWITH

        THIS.cnt_4c_Previsao.AddObject("txt_4c_Geracao", "TextBox")
        WITH THIS.cnt_4c_Previsao.txt_4c_Geracao
            .Alignment     = 3
            .Value         = {}
            .Format        = "K"
            .Height        = 23
            .Left          = 353
            .Top           = 5
            .Width         = 80
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerOp - numero da OP manual (Cnt_Op legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerOp()
        THIS.cnt_4c_Op.AddObject("lbl_4c_LblNop", "Label")
        WITH THIS.cnt_4c_Op.lbl_4c_LblNop
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "N" + CHR(186) + " da O.P.:"
            .Height    = 15
            .Left      = 0
            .Top       = 5
            .Width     = 58
        ENDWITH

        THIS.cnt_4c_Op.AddObject("txt_4c_Nop", "TextBox")
        WITH THIS.cnt_4c_Op.txt_4c_Nop
            .Alignment     = 3
            .Value         = 0
            .Height        = 23
            .InputMask     = "999999"
            .Left          = 71
            .Top           = 1
            .Width         = 59
            .MaxLength     = 6
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * PopularCamposIniciais - preenche valores iniciais apos criacao dos controles
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PopularCamposIniciais()
        LOCAL loc_oErro
        TRY
            *-- Empresa: dados ja carregados pelo BO via CarregarEmpresa
            THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = THIS.this_oBusinessObject.this_cCdEmpresa
            THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = THIS.this_oBusinessObject.this_cDsEmpresa

            *-- Previsao de entrega: data atual + PrevProds dias (parametro SigCdPam)
            IF USED("crSigCdPam") AND NOT EOF("crSigCdPam")
                SELECT crSigCdPam
                THIS.cnt_4c_Previsao.txt_4c_Previsao.Value = DATE() + crSigCdPam.PrevProds
            ENDIF

            *-- Data de geracao: data atual (apenas se nao modo automatico)
            IF NOT THIS.this_lAutomatico
                THIS.cnt_4c_Previsao.txt_4c_Geracao.Value = DATE()
            ENDIF

            *-- Checkbox pedras: visibilidade calculada em InicializarForm
            THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Visible = THIS.this_lMostrarChkPedra

            *-- Tipo de OP: pre-selecionar se GerPorTp e apenas 1 tipo disponivel
            IF THIS.this_lGerPorTp AND NOT EMPTY(THIS.this_oBusinessObject.this_cTpGOp)
                THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = THIS.this_oBusinessObject.this_cTpGOp
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao popular campos: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventos - registra handlers via BINDEVENT (metodos PUBLIC)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventos()
        BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "CmdProcessarClick")
        BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "CmdCancelarClick")
        BINDEVENT(THIS.cnt_4c_TipoOp.txt_4c_TpGOp,          "KeyPress", THIS, "TxtTpGOpKeyPress")
        BINDEVENT(THIS.cnt_4c_Operacao.txt_4c_Operacao,      "KeyPress", THIS, "TxtOperacaoKeyPress")
        BINDEVENT(THIS.cnt_4c_Operacao.txt_4c_Operacaoi,     "KeyPress", THIS, "TxtOperacaoiKeyPress")
        BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Grupo,            "KeyPress", THIS, "TxtGrupoContaKeyPress")
        BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Conta,            "KeyPress", THIS, "TxtContaKeyPress")
        BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Dconta,           "KeyPress", THIS, "TxtDcontaKeyPress")
        BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_GrupoResp,  "KeyPress", THIS, "TxtGrupoRespKeyPress")
        BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_ContaResp,  "KeyPress", THIS, "TxtContaRespKeyPress")
        BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_DcontaResp, "KeyPress", THIS, "TxtDcontaRespKeyPress")
        BINDEVENT(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa,      "KeyPress", THIS, "TxtCdEmpresaKeyPress")
        BINDEVENT(THIS.cnt_4c_Empresa.txt_4c_DsEmpresa,      "KeyPress", THIS, "TxtDsEmpresaKeyPress")
        BINDEVENT(THIS.cnt_4c_Op.txt_4c_Nop,                 "KeyPress", THIS, "TxtNopKeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdProcessarClick - valida campos, copia ao BO e executa processamento
    *
    * Gerenciamento de estado (equivalente aos BtnIncluirClick/Alterar/etc. do CRUD):
    *   1. Validacoes (retorna se falha - UI permanece em ENTRADA)
    *   2. Copia campos do form para o BO
    *   3. AlternarPagina("PROCESSANDO") - bloqueia UI durante operacao
    *   4. BO.ProcessarOrdens() - logica de negocio
    *   5. AlternarPagina("ENTRADA") - restaura UI (sempre, inclusive em erro)
    *--------------------------------------------------------------------------
    PROCEDURE CmdProcessarClick()
        LOCAL loc_nGlobAutos, loc_oErro, loc_lProcessou
        loc_nGlobAutos  = 0
        loc_lProcessou  = .F.

        *-- Validar previsao e geracao (obrigatorias em modo normal)
        IF NOT THIS.this_lReserva
            IF EMPTY(THIS.cnt_4c_Previsao.txt_4c_Previsao.Value)
                MsgAviso("A Data de Previs" + CHR(227) + "o Deve Ser Preenchida!!!", "Aviso")
                THIS.cnt_4c_Previsao.txt_4c_Previsao.SetFocus
                RETURN
            ENDIF
            IF EMPTY(THIS.cnt_4c_Previsao.txt_4c_Geracao.Value)
                MsgAviso("A Data de Gera" + CHR(231) + CHR(227) + "o Deve Ser Preenchida!!!", "Aviso")
                THIS.cnt_4c_Previsao.txt_4c_Geracao.SetFocus
                RETURN
            ENDIF
        ENDIF

        *-- Validar numero OP manual (GlobAutos=2)
        IF USED("crSigCdPam") AND NOT EOF("crSigCdPam")
            SELECT crSigCdPam
            loc_nGlobAutos = crSigCdPam.GlobAutos
            IF loc_nGlobAutos = 2 AND NOT THIS.this_lReserva
                IF THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
                    MsgAviso("O N" + CHR(250) + "mero da OP " + CHR(233) + " Manual e Deve Ser Preenchido!!!", "Aviso")
                    THIS.cnt_4c_Op.txt_4c_Nop.SetFocus
                    RETURN
                ENDIF
            ENDIF
        ENDIF

        *-- Validar tipo de OP (obrigatorio no modo GerPorTp)
        IF THIS.this_lGerPorTp AND EMPTY(ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value))
            MsgAviso("O Tipo de Gera" + CHR(231) + CHR(227) + "o da OP " + CHR(233) + ;
                     " Obrigat" + CHR(243) + "rio ser Preenchido!!!", "Aviso")
            THIS.cnt_4c_TipoOp.txt_4c_TpGOp.SetFocus
            RETURN
        ENDIF

        *-- Copiar campos do form para o BO
        WITH THIS.this_oBusinessObject
            .this_dDataei      = THIS.txt_4c_Dataei.Value
            .this_dDataef      = THIS.txt_4c_Dataef.Value
            .this_dDatapi      = THIS.txt_4c_Datapi.Value
            .this_dDatapf      = THIS.txt_4c_Datapf.Value
            .this_cOperacao    = ALLTRIM(THIS.cnt_4c_Operacao.txt_4c_Operacao.Value)
            .this_nOperacaoi   = THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value
            .this_nOperacaof   = THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value
            .this_cGrupoConta  = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Grupo.Value)
            .this_cConta       = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value)
            .this_cDconta      = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Dconta.Value)
            .this_cGrupoResp   = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value)
            .this_cContaResp   = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value)
            .this_cCdEmpresa   = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value)
            .this_nNaoEmpPedra = THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Value
            .this_cTpGOp       = ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value)
            .this_dPrevisao    = THIS.cnt_4c_Previsao.txt_4c_Previsao.Value
            .this_dGeracao     = THIS.cnt_4c_Previsao.txt_4c_Geracao.Value
            .this_nNop         = THIS.cnt_4c_Op.txt_4c_Nop.Value
        ENDWITH

        *-- Bloquear UI durante processamento (equivale ao "estado PROCESSANDO")
        THIS.AlternarPagina("PROCESSANDO")

        TRY
            loc_lProcessou = THIS.this_oBusinessObject.ProcessarOrdens()
        CATCH TO loc_oErro
            MsgErro("Erro no processamento: " + loc_oErro.Message + ;
                    " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
            loc_lProcessou = .F.
        ENDTRY

        *-- Restaurar UI (sempre - inclusive em caso de erro)
        THIS.AlternarPagina("ENTRADA")

        IF loc_lProcessou
            MsgInfo("Processamento conclu" + CHR(237) + "do com sucesso.", "Conclu" + CHR(237) + "do")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdCancelarClick - fecha o formulario (Encerrar)
    *--------------------------------------------------------------------------
    PROCEDURE CmdCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtTpGOpKeyPress - lookup tipo de OP (CrTmpTpGop - cursor VFP local)
    *--------------------------------------------------------------------------
    PROCEDURE TxtTpGOpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oBusca
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF NOT THIS.cnt_4c_TipoOp.Enabled
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value)
        *-- Tentar SEEK direto antes de abrir picker
        IF NOT EMPTY(loc_cVal) AND USED("CrTmpTpGop")
            SELECT CrTmpTpGop
            IF SEEK(loc_cVal, "CrTmpTpGop", "Codigos")
                RETURN
            ENDIF
        ENDIF
        IF NOT USED("CrTmpTpGop")
            MsgAviso("Tipos de O.P. n" + CHR(227) + "o carregados.", "Aviso")
            RETURN
        ENDIF
        *-- Pre-popular cursor e abrir picker
        IF USED("cursor_4c_TpGOp")
            USE IN cursor_4c_TpGOp
        ENDIF
        SELECT Codigos, Descs FROM CrTmpTpGop INTO CURSOR cursor_4c_TpGOp READWRITE
        SELECT cursor_4c_TpGOp
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
        IF VARTYPE(loc_oBusca) = "O"
            WITH loc_oBusca
                .this_cCursorDestino = "cursor_4c_TpGOp"
                .this_cTitulo        = "Tipos de Gera" + CHR(231) + CHR(227) + "o de OP"
                .this_cCampoBusca    = "Codigos"
                .this_cValorBusca    = loc_cVal
                .mAddColuna("Codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                .mAddColuna("Descs",   "                              ", "Descri" + CHR(231) + CHR(227) + "o")
                .Show()
                IF .this_lSelecionou
                    SELECT cursor_4c_TpGOp
                    THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = ALLTRIM(cursor_4c_TpGOp.Codigos)
                ELSE
                    THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = ""
                ENDIF
            ENDWITH
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtOperacaoKeyPress - lookup operacao (TmpOper - cursor VFP local)
    *--------------------------------------------------------------------------
    PROCEDURE TxtOperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_cTpGOp, loc_oBusca
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(THIS.cnt_4c_Operacao.txt_4c_Operacao.Value)
        *-- Vazio: limpar faixa inicial/final
        IF EMPTY(loc_cVal)
            THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value = 0
            THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = 0
            RETURN
        ENDIF
        IF NOT USED("TmpOper")
            MsgAviso("Opera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o carregadas.", "Aviso")
            RETURN
        ENDIF
        *-- Montar cursor filtrado por TpGOp se necessario
        IF USED("cursor_4c_Oper")
            USE IN cursor_4c_Oper
        ENDIF
        IF THIS.this_lGerPorTp
            loc_cTpGOp = ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value)
            SELECT Dopes, NDopes FROM TmpOper WHERE CodTgOps = m.loc_cTpGOp INTO CURSOR cursor_4c_Oper READWRITE
        ELSE
            SELECT Dopes, NDopes FROM TmpOper INTO CURSOR cursor_4c_Oper READWRITE
        ENDIF
        SELECT cursor_4c_Oper
        INDEX ON Dopes TAG Dopes
        *-- Tentar SEEK direto
        IF SEEK(loc_cVal, "cursor_4c_Oper", "Dopes")
            RETURN
        ENDIF
        *-- Abrir picker
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
        IF VARTYPE(loc_oBusca) = "O"
            WITH loc_oBusca
                .this_cCursorDestino = "cursor_4c_Oper"
                .this_cTitulo        = "Cadastro de Opera" + CHR(231) + CHR(245) + "es"
                .this_cCampoBusca    = "Dopes"
                .this_cValorBusca    = loc_cVal
                .mAddColuna("Dopes",  "", "Opera" + CHR(231) + CHR(227) + "o")
                .mAddColuna("NDopes", "XXXXXX", "C" + CHR(243) + "digo")
                .Show()
                IF .this_lSelecionou
                    SELECT cursor_4c_Oper
                    THIS.cnt_4c_Operacao.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_Oper.Dopes)
                ELSE
                    THIS.cnt_4c_Operacao.txt_4c_Operacao.Value   = ""
                    THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value  = 0
                    THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value  = 0
                ENDIF
            ENDWITH
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtOperacaoiKeyPress - auto-popula faixa final quando faixa inicial preenchida
    *--------------------------------------------------------------------------
    PROCEDURE TxtOperacaoiKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value > 0 AND ;
           THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = 0
            THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtGrupoContaKeyPress - lookup grupo contabil (SigCdGcr) para Movimentacao
    *--------------------------------------------------------------------------
    PROCEDURE TxtGrupoContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oBusca
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Grupo.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
            "cursor_4c_GrpConta", "codigos", loc_cVal, ;
            "Grupos Cont" + CHR(225) + "beis", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            WITH loc_oBusca
                .mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                .mAddColuna("descrs",  "                              ", "Descri" + CHR(231) + CHR(227) + "o")
                .Show()
                IF .this_lSelecionou
                    SELECT cursor_4c_GrpConta
                    THIS.cnt_4c_Conta.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_GrpConta.codigos)
                ELSE
                    THIS.cnt_4c_Conta.txt_4c_Grupo.Value = ""
                ENDIF
            ENDWITH
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtContaKeyPress - lookup conta por codigo IClis (SigCdCli)
    *--------------------------------------------------------------------------
    PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oBusca
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
            "cursor_4c_CliConta", "IClis", loc_cVal, ;
            "Clientes - Movimenta" + CHR(231) + CHR(227) + "o", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            WITH loc_oBusca
                .mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                .mAddColuna("RClis", "                                        ", "Nome")
                .Show()
                IF .this_lSelecionou
                    SELECT cursor_4c_CliConta
                    THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliConta.IClis)
                    THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_CliConta.RClis)
                ELSE
                    THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ""
                    THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ""
                ENDIF
            ENDWITH
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtDcontaKeyPress - lookup conta por nome RClis (apenas quando Conta vazia)
    *--------------------------------------------------------------------------
    PROCEDURE TxtDcontaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oBusca
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF NOT EMPTY(ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value))
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Dconta.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
            "cursor_4c_CliDconta", "RClis", loc_cVal, ;
            "Clientes - Movimenta" + CHR(231) + CHR(227) + "o (Nome)", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            WITH loc_oBusca
                .mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                .mAddColuna("RClis", "                                        ", "Nome")
                .Show()
                IF .this_lSelecionou
                    SELECT cursor_4c_CliDconta
                    THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliDconta.IClis)
                    THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_CliDconta.RClis)
                ELSE
                    THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ""
                    THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ""
                ENDIF
            ENDWITH
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtGrupoRespKeyPress - lookup grupo contabil (SigCdGcr) para Vendedor
    *--------------------------------------------------------------------------
    PROCEDURE TxtGrupoRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oBusca
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
            "cursor_4c_GrpResp", "codigos", loc_cVal, ;
            "Grupos - Vendedor", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            WITH loc_oBusca
                .mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                .mAddColuna("descrs",  "                              ", "Descri" + CHR(231) + CHR(227) + "o")
                .Show()
                IF .this_lSelecionou
                    SELECT cursor_4c_GrpResp
                    THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value = ALLTRIM(cursor_4c_GrpResp.codigos)
                ELSE
                    THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value = ""
                ENDIF
            ENDWITH
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtContaRespKeyPress - lookup vendedor por codigo IClis (SigCdCli)
    *--------------------------------------------------------------------------
    PROCEDURE TxtContaRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oBusca
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
            "cursor_4c_CliResp", "IClis", loc_cVal, ;
            "Clientes - Vendedor", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            WITH loc_oBusca
                .mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                .mAddColuna("RClis", "                                        ", "Nome")
                .Show()
                IF .this_lSelecionou
                    SELECT cursor_4c_CliResp
                    THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ALLTRIM(cursor_4c_CliResp.IClis)
                    THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ALLTRIM(cursor_4c_CliResp.RClis)
                ELSE
                    THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ""
                    THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
                ENDIF
            ENDWITH
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtDcontaRespKeyPress - lookup vendedor por nome RClis (apenas quando ContaResp vazia)
    *--------------------------------------------------------------------------
    PROCEDURE TxtDcontaRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oBusca
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF NOT EMPTY(ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value))
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
            "cursor_4c_CliDcontaResp", "RClis", loc_cVal, ;
            "Clientes - Vendedor (Nome)", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            WITH loc_oBusca
                .mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                .mAddColuna("RClis", "                                        ", "Nome")
                .Show()
                IF .this_lSelecionou
                    SELECT cursor_4c_CliDcontaResp
                    THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ALLTRIM(cursor_4c_CliDcontaResp.IClis)
                    THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ALLTRIM(cursor_4c_CliDcontaResp.RClis)
                ELSE
                    THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ""
                    THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
                ENDIF
            ENDWITH
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCdEmpresaKeyPress - lookup empresa por codigo Cemps (SigCdEmp)
    *   Apenas se AlterEmp = .T.
    *--------------------------------------------------------------------------
    PROCEDURE TxtCdEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oBusca
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF NOT THIS.this_lAlterEmp
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdEmp", ;
            "cursor_4c_Emp", "Cemps", loc_cVal, ;
            "Empresas", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            WITH loc_oBusca
                .mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
                .mAddColuna("Razas", "                                        ", "Raz" + CHR(227) + "o Social")
                .Show()
                IF .this_lSelecionou
                    SELECT cursor_4c_Emp
                    THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_Emp.Cemps)
                    THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_Emp.Razas)
                ELSE
                    THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ""
                    THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ""
                ENDIF
            ENDWITH
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtDsEmpresaKeyPress - lookup empresa por razao social Razas (SigCdEmp)
    *   Apenas se AlterEmp = .T. e CdEmpresa vazio
    *--------------------------------------------------------------------------
    PROCEDURE TxtDsEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oBusca
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF NOT THIS.this_lAlterEmp
            RETURN
        ENDIF
        IF NOT EMPTY(ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value))
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdEmp", ;
            "cursor_4c_EmpDs", "Razas", loc_cVal, ;
            "Empresas (Raz" + CHR(227) + "o Social)", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            WITH loc_oBusca
                .mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
                .mAddColuna("Razas", "                                        ", "Raz" + CHR(227) + "o Social")
                .Show()
                IF .this_lSelecionou
                    SELECT cursor_4c_EmpDs
                    THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpDs.Cemps)
                    THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpDs.Razas)
                ELSE
                    THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ""
                    THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ""
                ENDIF
            ENDWITH
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtNopKeyPress - valida numero de OP: nao pode ja existir em SigOpPic
    *--------------------------------------------------------------------------
    PROCEDURE TxtNopKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
            RETURN
        ENDIF
        IF NOT THIS.this_oBusinessObject.ValidarNumeroOP(THIS.cnt_4c_Op.txt_4c_Nop.Value)
            MsgAviso("N" + CHR(250) + "mero de OP j" + CHR(225) + " existe. Favor Corrigir!!!", "Aviso")
            THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - monta a "pagina de entrada" (equivalente da Lista em CRUD)
    *
    * Form OPERACIONAL nao possui Grid/CRUD. A "pagina de entrada" agrupa:
    *   - botoes de acao (Processar / Encerrar)
    *   - containers de filtros/parametros (Tipo OP, Operacao, Conta, Responsavel,
    *     Empresa, Previsao, N. OP manual) e os campos avulsos de data (Emissao)
    *
    * Este metodo consolida a construcao visual da area principal, chamado uma
    * unica vez em InicializarForm apos ConfigurarCabecalho/ConfigurarShape.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        *-- Botoes de acao (Processar / Cancelar)
        THIS.ConfigurarBotoes()

        *-- Containers principais (esqueletos vazios)
        THIS.ConfigurarContainers()

        *-- Campos avulsos no form (labels + textboxes de data de emissao/previsao)
        THIS.ConfigurarCamposForm()

        *-- Populacao interna de cada container
        THIS.ConfigurarContainerTipoOp()
        THIS.ConfigurarContainerOperacao()
        THIS.ConfigurarContainerConta()
        THIS.ConfigurarContainerResponsavel()
        THIS.ConfigurarContainerEmpresa()
        THIS.ConfigurarContainerPrevisao()
        THIS.ConfigurarContainerOp()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - todos os containers de parametros (Fase 6)
    *
    * Form OPERACIONAL nao tem Page2 (Dados) como CRUD. Este metodo cobre
    * TODOS os 7 containers de parametros em padrao idempotente (checa
    * existencia antes de criar). Pode ser chamado de forma segura em
    * qualquer ordem em relacao ao ConfigurarPaginaLista().
    *
    * Containers cobertos:
    *   1. Cabecalho cinza (cnt_4c_Cabecalho)
    *   2. Shape decorativo (shp_4c_Shape3)
    *   3. Botoes principais (cmd_4c_Processar / cmd_4c_Cancelar)
    *   4. Labels e campos de data avulsos no form
    *   5. cnt_4c_TipoOp  - Tipo de O.P. (txt_4c_TpGOp)
    *   6. cnt_4c_Operacao - Operacao + faixa i/f
    *   7. cnt_4c_Conta    - Movimentacao: grupo/conta/dconta
    *   8. cnt_4c_Responsavel - Vendedor: grupo/conta/dconta
    *   9. cnt_4c_Empresa  - cd_empresa / ds_empresa / chk pedras
    *  10. cnt_4c_Previsao - data previsao entrega + data geracao
    *  11. cnt_4c_Op       - numero da OP manual (visivel em GlobAutos=2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_lGlobAutos2
        loc_lGlobAutos2 = .F.
        IF USED("crSigCdPam") AND NOT EOF("crSigCdPam")
            SELECT crSigCdPam
            loc_lGlobAutos2 = (crSigCdPam.GlobAutos = 2 AND NOT THIS.this_lReserva)
        ENDIF

        *-- 1. Cabecalho cinza (idempotente)
        IF NOT PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5)
            THIS.ConfigurarCabecalho()
        ENDIF

        *-- 2. Shape decorativo
        IF NOT PEMSTATUS(THIS, "shp_4c_Shape3", 5)
            THIS.ConfigurarShape()
        ENDIF

        *-- 3. Botoes principais (Processar / Encerrar)
        IF NOT PEMSTATUS(THIS, "cmd_4c_Processar", 5)
            THIS.ConfigurarBotoes()
        ENDIF

        *-- 4. Campos avulsos (labels + datas de emissao/previsao)
        IF NOT PEMSTATUS(THIS, "lbl_4c_PeriodoEmissao", 5)
            THIS.ConfigurarCamposForm()
        ENDIF

        *-- 5. Container Tipo de O.P.
        IF NOT PEMSTATUS(THIS, "cnt_4c_TipoOp", 5)
            THIS.AddObject("cnt_4c_TipoOp", "Container")
            WITH THIS.cnt_4c_TipoOp
                .Top         = 164
                .Left        = 139
                .Width       = 346
                .Height      = 25
                .BackStyle   = 0
                .BorderWidth = 0
                .Enabled     = THIS.this_lGerPorTp
                .Visible     = .T.
            ENDWITH
            THIS.ConfigurarContainerTipoOp()
        ENDIF

        *-- 6. Container Operacao
        IF NOT PEMSTATUS(THIS, "cnt_4c_Operacao", 5)
            THIS.AddObject("cnt_4c_Operacao", "Container")
            WITH THIS.cnt_4c_Operacao
                .Top         = 191
                .Left        = 139
                .Width       = 350
                .Height      = 25
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH
            THIS.ConfigurarContainerOperacao()
        ENDIF

        *-- 7. Container Movimentacao (Conta)
        IF NOT PEMSTATUS(THIS, "cnt_4c_Conta", 5)
            THIS.AddObject("cnt_4c_Conta", "Container")
            WITH THIS.cnt_4c_Conta
                .Top         = 218
                .Left        = 139
                .Width       = 553
                .Height      = 25
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH
            THIS.ConfigurarContainerConta()
        ENDIF

        *-- 8. Container Responsavel (Vendedor)
        IF NOT PEMSTATUS(THIS, "cnt_4c_Responsavel", 5)
            THIS.AddObject("cnt_4c_Responsavel", "Container")
            WITH THIS.cnt_4c_Responsavel
                .Top         = 245
                .Left        = 139
                .Width       = 553
                .Height      = 25
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH
            THIS.ConfigurarContainerResponsavel()
        ENDIF

        *-- 9. Container Empresa
        IF NOT PEMSTATUS(THIS, "cnt_4c_Empresa", 5)
            THIS.AddObject("cnt_4c_Empresa", "Container")
            WITH THIS.cnt_4c_Empresa
                .Top         = 272
                .Left        = 138
                .Width       = 553
                .Height      = 25
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH
            THIS.ConfigurarContainerEmpresa()
        ENDIF

        *-- 10. Container Previsao (oculto no modo Reserva)
        IF NOT PEMSTATUS(THIS, "cnt_4c_Previsao", 5)
            THIS.AddObject("cnt_4c_Previsao", "Container")
            WITH THIS.cnt_4c_Previsao
                .Top         = 309
                .Left        = 7
                .Width       = 660
                .Height      = 33
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = NOT THIS.this_lReserva
                .Visible     = .T.
            ENDWITH
            THIS.ConfigurarContainerPrevisao()
        ENDIF

        *-- 11. Container Op (visivel apenas em GlobAutos=2 e nao Reserva)
        IF NOT PEMSTATUS(THIS, "cnt_4c_Op", 5)
            THIS.AddObject("cnt_4c_Op", "Container")
            WITH THIS.cnt_4c_Op
                .Top         = 313
                .Left        = 478
                .Width       = 130
                .Height      = 25
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = loc_lGlobAutos2
                .Visible     = .T.
            ENDWITH
            THIS.ConfigurarContainerOp()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - alterna o estado visual do form entre "ENTRADA" e "PROCESSANDO"
    *
    * Form OPERACIONAL nao possui PageFrame. O equivalente de "alternar pagina"
    * eh alternar o estado dos controles:
    *   - "ENTRADA"     : usuario preenche filtros; Processar habilitado
    *   - "PROCESSANDO" : filtros bloqueados enquanto BO executa; evita re-entrada
    *
    * Chamado em InicializarForm (estado inicial) e pode ser chamado por
    * CmdProcessarClick antes/depois do ProcessarOrdens() do BO.
    *--------------------------------------------------------------------------
    *--------------------------------------------------------------------------
    * BtnIncluirClick - Dispara o processamento (equivalente ao Processar)
    * Form OPERACIONAL: nao ha CRUD - o evento principal eh gerar as OPs
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.CmdProcessarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Restaura o modo de entrada e da foco na 1a data editavel
    * Permite ao usuario ajustar parametros apos processamento ou cancelamento
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.AlternarPagina("ENTRADA")
        IF PEMSTATUS(THIS, "txt_4c_Dataei", 5) AND THIS.txt_4c_Dataei.Enabled
            THIS.txt_4c_Dataei.SetFocus
        ELSE
            IF PEMSTATUS(THIS, "cnt_4c_Previsao", 5) AND THIS.cnt_4c_Previsao.Enabled
                THIS.cnt_4c_Previsao.txt_4c_Previsao.SetFocus
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Recarrega os defaults iniciais (previsao/geracao/empresa)
    * Util para descartar edicoes locais e voltar aos valores calculados pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.AlternarPagina("ENTRADA")
        THIS.PopularCamposIniciais()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Encerra o formulario sem processar (equivalente Cancelar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.CmdCancelarClick()
    ENDPROC

    PROCEDURE AlternarPagina(par_cModo)
        LOCAL loc_cModo, loc_lEditar
        loc_cModo = IIF(VARTYPE(par_cModo) = "C", UPPER(ALLTRIM(par_cModo)), "ENTRADA")
        loc_lEditar = (loc_cModo = "ENTRADA")

        *-- Botao Processar segue o modo (bloqueia durante processamento)
        IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
            THIS.cmd_4c_Processar.Enabled = loc_lEditar
        ENDIF

        *-- Containers de filtro alternam Enabled conforme modo
        IF PEMSTATUS(THIS, "cnt_4c_TipoOp", 5)
            THIS.cnt_4c_TipoOp.Enabled = (loc_lEditar AND THIS.this_lGerPorTp)
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Operacao", 5)
            THIS.cnt_4c_Operacao.Enabled = loc_lEditar
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Conta", 5)
            THIS.cnt_4c_Conta.Enabled = loc_lEditar
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Responsavel", 5)
            THIS.cnt_4c_Responsavel.Enabled = loc_lEditar
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Empresa", 5)
            THIS.cnt_4c_Empresa.Enabled = (loc_lEditar AND THIS.this_lAlterEmp)
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Previsao", 5)
            THIS.cnt_4c_Previsao.Enabled = (loc_lEditar AND NOT THIS.this_lReserva)
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Op", 5)
            THIS.cnt_4c_Op.Enabled = loc_lEditar
        ENDIF

        *-- Datas de emissao/previsao avulsas no form
        IF PEMSTATUS(THIS, "txt_4c_Dataei", 5)
            THIS.txt_4c_Dataei.Enabled = loc_lEditar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Dataef", 5)
            THIS.txt_4c_Dataef.Enabled = loc_lEditar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Datapi", 5)
            THIS.txt_4c_Datapi.Enabled = loc_lEditar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Datapf", 5)
            THIS.txt_4c_Datapf.Enabled = loc_lEditar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - copia todos os campos do formulario para as propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        WITH THIS.this_oBusinessObject
            .this_dDataei      = THIS.txt_4c_Dataei.Value
            .this_dDataef      = THIS.txt_4c_Dataef.Value
            .this_dDatapi      = THIS.txt_4c_Datapi.Value
            .this_dDatapf      = THIS.txt_4c_Datapf.Value
            .this_cOperacao    = ALLTRIM(THIS.cnt_4c_Operacao.txt_4c_Operacao.Value)
            .this_nOperacaoi   = THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value
            .this_nOperacaof   = THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value
            .this_cGrupoConta  = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Grupo.Value)
            .this_cConta       = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value)
            .this_cDconta      = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Dconta.Value)
            .this_cGrupoResp   = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value)
            .this_cContaResp   = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value)
            .this_cDcontaResp  = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value)
            .this_cCdEmpresa   = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value)
            .this_cDsEmpresa   = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value)
            .this_nNaoEmpPedra = THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Value
            .this_cTpGOp       = ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value)
            .this_dPrevisao    = THIS.cnt_4c_Previsao.txt_4c_Previsao.Value
            .this_dGeracao     = THIS.cnt_4c_Previsao.txt_4c_Geracao.Value
            .this_nNop         = THIS.cnt_4c_Op.txt_4c_Nop.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - popula os campos do formulario a partir das propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oErro
        TRY
            WITH THIS.this_oBusinessObject
                THIS.txt_4c_Dataei.Value = .this_dDataei
                THIS.txt_4c_Dataef.Value = .this_dDataef
                THIS.txt_4c_Datapi.Value = .this_dDatapi
                THIS.txt_4c_Datapf.Value = .this_dDatapf
                THIS.cnt_4c_Operacao.txt_4c_Operacao.Value      = .this_cOperacao
                THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value     = .this_nOperacaoi
                THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value     = .this_nOperacaof
                THIS.cnt_4c_Conta.txt_4c_Grupo.Value            = .this_cGrupoConta
                THIS.cnt_4c_Conta.txt_4c_Conta.Value            = .this_cConta
                THIS.cnt_4c_Conta.txt_4c_Dconta.Value           = .this_cDconta
                THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value  = .this_cGrupoResp
                THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = .this_cContaResp
                THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = .this_cDcontaResp
                THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value      = .this_cCdEmpresa
                THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value      = .this_cDsEmpresa
                THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Value    = .this_nNaoEmpPedra
                THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value           = .this_cTpGOp
                THIS.cnt_4c_Previsao.txt_4c_Previsao.Value      = .this_dPrevisao
                THIS.cnt_4c_Previsao.txt_4c_Geracao.Value       = .this_dGeracao
                THIS.cnt_4c_Op.txt_4c_Nop.Value                 = .this_nNop
            ENDWITH
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar campos: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - habilita/desabilita todos os campos editaveis
    * par_lEditar = .T. para habilitar; .F. para somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lEditar)
        LOCAL loc_lEdit
        loc_lEdit = IIF(VARTYPE(par_lEditar) = "L", par_lEditar, .T.)

        IF PEMSTATUS(THIS, "txt_4c_Dataei", 5)
            THIS.txt_4c_Dataei.Enabled = loc_lEdit
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Dataef", 5)
            THIS.txt_4c_Dataef.Enabled = loc_lEdit
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Datapi", 5)
            THIS.txt_4c_Datapi.Enabled = loc_lEdit
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Datapf", 5)
            THIS.txt_4c_Datapf.Enabled = loc_lEdit
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_TipoOp", 5)
            THIS.cnt_4c_TipoOp.Enabled = (loc_lEdit AND THIS.this_lGerPorTp)
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Operacao", 5)
            THIS.cnt_4c_Operacao.Enabled = loc_lEdit
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Conta", 5)
            THIS.cnt_4c_Conta.Enabled = loc_lEdit
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Responsavel", 5)
            THIS.cnt_4c_Responsavel.Enabled = loc_lEdit
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Empresa", 5)
            THIS.cnt_4c_Empresa.Enabled = (loc_lEdit AND THIS.this_lAlterEmp)
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Previsao", 5)
            THIS.cnt_4c_Previsao.Enabled = (loc_lEdit AND NOT THIS.this_lReserva)
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Op", 5)
            THIS.cnt_4c_Op.Enabled = loc_lEdit
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - limpa todos os campos de filtro do formulario
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "txt_4c_Dataei", 5)
            THIS.txt_4c_Dataei.Value = {}
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Dataef", 5)
            THIS.txt_4c_Dataef.Value = {}
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Datapi", 5)
            THIS.txt_4c_Datapi.Value = {}
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Datapf", 5)
            THIS.txt_4c_Datapf.Value = {}
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_TipoOp", 5)
            THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Operacao", 5)
            THIS.cnt_4c_Operacao.txt_4c_Operacao.Value  = ""
            THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value = 0
            THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = 0
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Conta", 5)
            THIS.cnt_4c_Conta.txt_4c_Grupo.Value  = ""
            THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ""
            THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Responsavel", 5)
            THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value  = ""
            THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ""
            THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Previsao", 5)
            THIS.cnt_4c_Previsao.txt_4c_Previsao.Value = {}
            THIS.cnt_4c_Previsao.txt_4c_Geracao.Value  = {}
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Op", 5)
            THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - recarrega dados iniciais (form OPERACIONAL sem grid de lista)
    * Existe para compatibilidade com o ciclo de vida do FormBase
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.PopularCamposIniciais()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - ajusta estado dos botoes conforme modo do form
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        THIS.AlternarPagina("ENTRADA")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - limpa filtros e recarrega valores iniciais padrao
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.LimparCampos()
        THIS.PopularCamposIniciais()
        THIS.AlternarPagina("ENTRADA")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.CmdCancelarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - executa o processamento (equivalente ao Processar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.CmdProcessarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - cancela o estado atual e restaura o modo de entrada
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina("ENTRADA")
        THIS.LimparCampos()
        THIS.PopularCamposIniciais()
    ENDPROC

ENDDEFINE
