*==============================================================================
* FormSigPrChr.prg - Processamento de Cheques (SIGPRCHR)
* Form OPERACIONAL - Herda de FormBase
* Legado: SIGPRCHR.SCX
*
* Pilares:
*   UX   -> layout pixel-perfect escalado (800px -> 1000px, fator 1.25)
*   BD   -> SigCqChi / SigCdmp / SigOpFp / SigCdCli / SigCdPit
*   CODE -> arquitetura em camadas (FormBase / SigPrChrBO)
*
* FASE 3/8: Estrutura base - DEFINE CLASS, Init, InicializarForm,
*           ConfigurarPageFrame, ConfigurarCabecalho, TornarControlesVisiveis,
*           Destroy. Tambem: ConfigurarGrupoBotoes (obj_4c_CmdGok 9 botoes),
*           ConfigurarGrid (grd_4c_Dados 10 colunas, cmd_4c_Tudo1/Apaga1).
* FASE 4/8: ConfigurarFiltros (Shape2/Shape1, Grupo/Conta/Periodo lookups,
*           Processar, TxtFavorecido), AlternarPagina.
* FASE 5/8: Propriedades de estado do form. ConfigurarPaginaDados(),
*           ConfigurarContainerJustificativa (cnt_4c_Justificativa),
*           ConfigurarContainerProcurar (cnt_4c_Procurar).
* Fases 6+: cnt_4c_Impchmat, BINDEVENTs e handlers de eventos.
*==============================================================================
DEFINE CLASS FormSigPrChr AS FormBase

    *-- Dimensoes (escala 1.25x do original 800x600)
    Width        = 1000
    Height       = 600

    *-- Form sem barra de titulo (identico ao legado TitleBar=0)
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.

    *-- Aparencia
    AutoCenter   = .T.
    DataSession  = 2
    ShowTips     = .T.
    ClipControls = .F.
    BorderStyle  = 2
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Propriedades de estado do form (antecessores de campos e flags de operacao)
    this_lLeCheque         = .F.
    this_cChqLido          = ""
    this_lLeitor           = .F.
    this_lInicio           = .F.
    this_lChMatIni         = .F.
    this_dAntDtIni         = {}
    this_dAntDtFin         = {}
    this_cAntCdGrupo       = ""
    this_cAntDsGrupo       = ""
    this_cAntCdConta       = ""
    this_cAntDsConta       = ""
    this_lExcluirDocumento = .T.
    this_lExcluirCheque    = .T.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *  DODEFAULT() chama FormBase.Init() -> THIS.InicializarForm()
    *--------------------------------------------------------------------------
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
    *  Cria toda a estrutura visual do form OPERACIONAL.
    *  Fases 4+ adicionarao controles via Read+Edit.
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                *-- Modo validacao UI: configura estrutura visual sem SQL
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarGrupoBotoes()
                THIS.ConfigurarGrid()
                THIS.ConfigurarFiltros()
                THIS.ConfigurarContainerJustificativa()
                THIS.ConfigurarContainerProcurar()
                THIS.ConfigurarContainerImpchmat()
                THIS.TornarControlesVisiveis(THIS)
                THIS.RegistrarBINDEVENTs()
                loc_lSucesso = .T.
            ELSE
                *-- Verificar conexao principal
                IF gnConnHandle <= 0
                    MsgErro("Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + ;
                            "o estabelecida.", "Erro de Conex" + CHR(227) + "o")
                ELSE
                    *-- Criar Business Object
                    THIS.this_oBusinessObject = CREATEOBJECT("SigPrChrBO")
                    IF VARTYPE(THIS.this_oBusinessObject) != "O"
                        MsgErro("Falha ao criar objeto de neg" + CHR(243) + "cios.", "Erro")
                    ELSE
                        *-- Carregar cursores iniciais (CrSigCdmp, CrContas, CsSigCqChi vazio)
                        IF THIS.this_oBusinessObject.CarregarCursoresIniciais()
                            *-- Configurar layout base (Picture, Caption, dimensoes)
                            THIS.ConfigurarPageFrame()

                            *-- Cabecalho cinza escuro com titulo
                            THIS.ConfigurarCabecalho()
                            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                            *-- Grupo de botoes, grid e filtros
                            THIS.ConfigurarGrupoBotoes()
                            THIS.ConfigurarGrid()
                            THIS.ConfigurarFiltros()
                            THIS.ConfigurarContainerJustificativa()
                            THIS.ConfigurarContainerProcurar()
                            THIS.ConfigurarContainerImpchmat()

                            *-- Tornar controles visiveis (containers flutuantes permanecem ocultos)
                            THIS.TornarControlesVisiveis(THIS)

                            *-- Registrar BINDEVENTs apos controles criados
                            THIS.RegistrarBINDEVENTs()

                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *  Configuracao base do form OPERACIONAL (layout flat, sem PageFrame).
    *  O nome e mantido por convencao do pipeline de migracao.
    *--------------------------------------------------------------------------
        LOCAL loc_cImgFundo

        *-- Titulo (TitleBar=0, nao exibido, mas util para rastreamento)
        THIS.Caption = "Processamento de Cheques"

        *-- Imagem de fundo do framework (identica ao legado new_background.jpg)
        loc_cImgFundo = gc_4c_CaminhoIcones + "new_background.jpg"
        IF FILE(loc_cImgFundo)
            THIS.Picture = loc_cImgFundo
        ENDIF

        *-- Reforca dimensoes canonicas (1.25x do original 800x600)
        THIS.Width      = 1000
        THIS.Height     = 600
        THIS.AutoCenter = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *  Container cinza escuro com labels de sombra e titulo (cntSombra no legado).
    *  Original: Top=0, Left=0, Width=800, Height=80 -> novo: Width=1000.
    *--------------------------------------------------------------------------
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = 1000
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            *-- Label sombra (efeito de profundidade - ForeColor preto, ligeiramente deslocada)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 25
                .Left      = 10
                .Width     = 1000
                .Height    = 40
                .AutoSize  = .F.
                .BackStyle = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .ForeColor = RGB(0, 0, 0)
                .Caption   = "Processamento de Cheques"
                .Visible   = .T.
            ENDWITH

            *-- Label titulo (ForeColor branco sobre fundo cinza escuro)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 24
                .Left      = 10
                .Width     = 1000
                .Height    = 46
                .AutoSize  = .F.
                .BackStyle = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .ForeColor = RGB(255, 255, 255)
                .Caption   = "Processamento de Cheques"
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrupoBotoes()
    *  CommandGroup obj_4c_CmdGok com 9 botoes. Escala 1.25x (original Top=-3, Left=11, Width=789).
    *--------------------------------------------------------------------------
        THIS.AddObject("obj_4c_CmdGok", "CommandGroup")
        WITH THIS.obj_4c_CmdGok
            .Top           = -3
            .Left          = 14
            .Width         = 986
            .Height        = 160
            .ButtonCount   = 9
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Value         = 1
            .AutoSize      = .F.
            .Themes        = .F.
            .BorderColor   = RGB(136, 189, 188)
            .Visible       = .T.

            *-- Buttons(1): Documento (original Left=473 -> 591)
            WITH .Buttons(1)
                .Top             = 121
                .Left            = 591
                .Height          = 37
                .Width           = 120
                .Caption         = "\<Documento"
                .FontBold        = .T.
                .FontItalic      = .T.
                .PicturePosition = 1
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
            ENDWITH

            *-- Buttons(2): Encerrar (original Left=713 -> 891)
            WITH .Buttons(2)
                .Top             = 6
                .Left            = 891
                .Height          = 75
                .Width           = 75
                .Caption         = "Encerrar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .Cancel          = .T.
                .ToolTipText     = "[Esc] Encerrar"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            ENDWITH

            *-- Buttons(3): Imprimir (original Left=353 -> 441)
            WITH .Buttons(3)
                .Top             = 84
                .Left            = 441
                .Height          = 37
                .Width           = 120
                .Caption         = "\<Imprimir"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .PicturePosition = 1
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
            ENDWITH

            *-- Buttons(4): Procurar (original Left=593 -> 741)
            WITH .Buttons(4)
                .Top             = 84
                .Left            = 741
                .Height          = 37
                .Width           = 120
                .Caption         = "\<Procurar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .PicturePosition = 1
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            ENDWITH

            *-- Buttons(5): Recibo (original Left=593 -> 741)
            WITH .Buttons(5)
                .Top             = 121
                .Left            = 741
                .Height          = 37
                .Width           = 120
                .Caption         = "\<Recibo"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .PicturePosition = 1
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .Picture         = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
            ENDWITH

            *-- Buttons(6): Exclui Docto (original Left=473 -> 591)
            WITH .Buttons(6)
                .Top             = 84
                .Left            = 591
                .Height          = 37
                .Width           = 120
                .Caption         = "E\<xclui Docto."
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .PicturePosition = 1
                .ToolTipText     = "Exclui Documento"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            ENDWITH

            *-- Buttons(7): Cheque (impressora jacto) (original Left=353 -> 441)
            WITH .Buttons(7)
                .Top             = 121
                .Left            = 441
                .Height          = 37
                .Width           = 120
                .Caption         = "Che\<que"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .PicturePosition = 1
                .ToolTipText     = "Impressora de cheque"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .Picture         = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
            ENDWITH

            *-- Buttons(8): Chq. Matric. (original Left=233 -> 291)
            WITH .Buttons(8)
                .Top             = 84
                .Left            = 291
                .Height          = 37
                .Width           = 120
                .Caption         = "Chq. \<Matric."
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .PicturePosition = 1
                .ToolTipText     = "Impressora matricial"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .Picture         = gc_4c_CaminhoIcones + "cheque.png"
            ENDWITH

            *-- Buttons(9): Excluir Chq. (original Left=233 -> 291)
            WITH .Buttons(9)
                .Top             = 121
                .Left            = 291
                .Height          = 37
                .Width           = 120
                .Caption         = "Excluir Chq."
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .PicturePosition = 1
                .ToolTipText     = "Exclui Cheque"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
    *  Grid grd_4c_Dados (10 colunas) + cmd_4c_Tudo1 + cmd_4c_Apaga1.
    *  Original: Top=233, Left=24, Width=710, Height=291 -> escala 1.25x.
    *--------------------------------------------------------------------------
        THIS.AddObject("grd_4c_Dados", "Grid")
        THIS.grd_4c_Dados.ColumnCount = 10
        WITH THIS.grd_4c_Dados
            .Top               = 233
            .Left              = 30
            .Width             = 888
            .Height            = 291
            .FontName          = "Tahoma"
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .ReadOnly          = .F.
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .Visible           = .T.

            *-- Column1 (clnDatas): ColumnOrder=10, aparece como 10a coluna
            WITH .Column1
                .ColumnOrder       = 10
                .Width             = 99
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontName          = "Tahoma"
                .Header1.Caption   = "Data"
                .Header1.FontName  = "Tahoma"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
                .Text1.BorderStyle = 0
                .Text1.Format      = "K"
                .Text1.Margin      = 0
                .Text1.MaxLength   = 10
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.FontName    = "Tahoma"
            ENDWITH

            *-- Column2 (clnContas): Conta do favorecido
            WITH .Column2
                .Width             = 99
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontName          = "Tahoma"
                .Header1.Caption   = "Conta"
                .Header1.FontName  = "Tahoma"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
                .Text1.BorderStyle = 0
                .Text1.Format      = "K"
                .Text1.Margin      = 0
                .Text1.MaxLength   = 10
                .Text1.ReadOnly    = .T.
                .Text1.FontName    = "Tahoma"
            ENDWITH

            *-- Column3 (clnNcopias): Numero da copia
            WITH .Column3
                .Width             = 64
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontName          = "Tahoma"
                .Header1.Caption   = "C" + CHR(243) + "pia"
                .Header1.FontName  = "Tahoma"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
                .Text1.BorderStyle = 0
                .Text1.Format      = "K"
                .Text1.InputMask   = "999999"
                .Text1.Margin      = 0
                .Text1.MaxLength   = 6
                .Text1.ReadOnly    = .T.
                .Text1.FontName    = "Tahoma"
            ENDWITH

            *-- Column4 (clnBancos): Banco
            WITH .Column4
                .Width             = 38
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontName          = "Tahoma"
                .Header1.Caption   = "Bco"
                .Header1.FontName  = "Tahoma"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
                .Text1.BorderStyle = 0
                .Text1.Format      = "K"
                .Text1.Margin      = 0
                .Text1.MaxLength   = 3
                .Text1.ReadOnly    = .T.
                .Text1.FontName    = "Tahoma"
            ENDWITH

            *-- Column5 (clnAgencias): Agencia
            WITH .Column5
                .Width             = 46
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontName          = "Tahoma"
                .Header1.Caption   = "Ag."
                .Header1.FontName  = "Tahoma"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
                .Text1.BorderStyle = 0
                .Text1.Format      = "K"
                .Text1.Margin      = 0
                .Text1.MaxLength   = 4
                .Text1.ReadOnly    = .T.
                .Text1.FontName    = "Tahoma"
            ENDWITH

            *-- Column6 (clnNcontas): Conta corrente
            WITH .Column6
                .Width             = 99
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontName          = "Tahoma"
                .Header1.Caption   = "C.Corrente"
                .Header1.FontName  = "Tahoma"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
                .Text1.BorderStyle = 0
                .Text1.Format      = "K"
                .Text1.Margin      = 0
                .Text1.MaxLength   = 10
                .Text1.ReadOnly    = .T.
                .Text1.FontName    = "Tahoma"
            ENDWITH

            *-- Column7 (clnNcheques): Numero do cheque
            WITH .Column7
                .Width             = 64
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontName          = "Tahoma"
                .Header1.Caption   = "Cheque"
                .Header1.FontName  = "Tahoma"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
                .Text1.BorderStyle = 0
                .Text1.Format      = "K"
                .Text1.Margin      = 0
                .Text1.MaxLength   = 6
                .Text1.ReadOnly    = .T.
                .Text1.FontName    = "Tahoma"
            ENDWITH

            *-- Column8 (clnSituacaos): Situacao derivada de NCancelas/NEmitidos
            WITH .Column8
                .Width             = 99
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontName          = "Tahoma"
                .Header1.Caption   = "Situa" + CHR(231) + CHR(227) + "o"
                .Header1.FontName  = "Tahoma"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
                .Text1.BorderStyle = 0
                .Text1.Format      = "K"
                .Text1.Margin      = 0
                .Text1.MaxLength   = 11
                .Text1.ReadOnly    = .T.
                .Text1.FontName    = "Tahoma"
            ENDWITH

            *-- Column9 (clnValors): Valor do cheque
            WITH .Column9
                .Width             = 138
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontName          = "Tahoma"
                .Header1.Caption   = "Valor"
                .Header1.FontName  = "Tahoma"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
                .Text1.BorderStyle = 0
                .Text1.Format      = "K"
                .Text1.InputMask   = "999,999,999.99"
                .Text1.Margin      = 0
                .Text1.MaxLength   = 14
                .Text1.ReadOnly    = .T.
                .Text1.FontName    = "Tahoma"
            ENDWITH

            *-- Column10 (clnImprime): ColumnOrder=1 (1a coluna), CheckBox para NMarca1s
            WITH .Column10
                .ColumnOrder       = 1
                .Width             = 69
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .F.
                .Sparse            = .F.
                .FontName          = "Tahoma"
                .Header1.Caption   = "Imprime"
                .Header1.FontName  = "Tahoma"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
                .AddObject("chk_4c_Imprime", "CheckBox")
                WITH .chk_4c_Imprime
                    .Caption   = ""
                    .ReadOnly  = .F.
                    .Alignment = 0
                    .FontName  = "Tahoma"
                    .Visible   = .T.
                ENDWITH
                .CurrentControl = "chk_4c_Imprime"
            ENDWITH
        ENDWITH

        *-- RecordSource e ControlSources FORA do WITH (evita auto-bind sobrescrever ControlSources)
        IF USED("CsSigCqChi")
            THIS.grd_4c_Dados.RecordSource                              = "CsSigCqChi"
            THIS.grd_4c_Dados.Column1.ControlSource                    = "CsSigCqChi.datas"
            THIS.grd_4c_Dados.Column2.ControlSource                    = "CsSigCqChi.contas"
            THIS.grd_4c_Dados.Column3.ControlSource                    = "CsSigCqChi.ncopias"
            THIS.grd_4c_Dados.Column4.ControlSource                    = "CsSigCqChi.bancos"
            THIS.grd_4c_Dados.Column5.ControlSource                    = "CsSigCqChi.agencias"
            THIS.grd_4c_Dados.Column6.ControlSource                    = "CsSigCqChi.ncontas"
            THIS.grd_4c_Dados.Column7.ControlSource                    = "CsSigCqChi.ncheques"
            THIS.grd_4c_Dados.Column8.ControlSource                    = "IIF(CsSigCqChi.NCancelas=1,'Cancelado',IIF(CsSigCqChi.NEmitidos>0,'Emitido','N'+CHR(227)+'o Emitido'))"
            THIS.grd_4c_Dados.Column9.ControlSource                    = "CsSigCqChi.valors"
            THIS.grd_4c_Dados.Column10.ControlSource                   = "CsSigCqChi.NMarca1s"
            THIS.grd_4c_Dados.Column10.chk_4c_Imprime.ControlSource   = "CsSigCqChi.NMarca1s"
        ENDIF

        *-- Botao Marcar Todos (original Top=334, Left=742 -> 928)
        THIS.AddObject("cmd_4c_Tudo1", "CommandButton")
        WITH THIS.cmd_4c_Tudo1
            .Top         = 334
            .Left        = 928
            .Height      = 40
            .Width       = 40
            .FontName    = "Verdana"
            .FontSize    = 8
            .Caption     = ""
            .TabStop     = .F.
            .ToolTipText = "Marca tudo"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes           = .T.
            .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .Visible     = .T.
        ENDWITH

        *-- Botao Desmarcar Todos (original Top=375, Left=742 -> 928)
        THIS.AddObject("cmd_4c_Apaga1", "CommandButton")
        WITH THIS.cmd_4c_Apaga1
            .Top         = 375
            .Left        = 928
            .Height      = 40
            .Width       = 40
            .FontName    = "Verdana"
            .FontSize    = 8
            .Caption     = ""
            .TabStop     = .F.
            .ToolTipText = "Desmarca tudo"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes           = .T.
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
    *  Torna todos os controles visiveis recursivamente.
    *  Containers flutuantes (cnt_4c_Justificativa, cnt_4c_Impchmat,
    *  cnt_4c_Procurar) permanecem ocultos ao abrir, mas seus filhos sao
    *  tornados visiveis para exibicao correta quando o container for ativado.
    *--------------------------------------------------------------------------
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                *-- Containers flutuantes (Visible=.F.): tornar filhos visiveis sem revelar o container
                IF INLIST(UPPER(loc_oControl.Name), ;
                          "CNT_4C_JUSTIFICATIVA", ;
                          "CNT_4C_IMPCHMAT", ;
                          "CNT_4C_PROCURAR")
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                       loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *  Form OPERACIONAL: layout FLAT (sem Page1/Page2 do padrao CRUD).
    *  Este metodo agrega a configuracao equivalente a "Page1 (Lista)":
    *    - obj_4c_CmdGok (CommandGroup com 9 botoes operacionais)
    *    - grd_4c_Dados (Grid principal de cheques, 10 colunas)
    *    - cmd_4c_Tudo1 / cmd_4c_Apaga1 (Marcar/Desmarcar Todos)
    *    - Filtros (Grupo, Conta, Periodo, Processar, Favorecido)
    *  Chamado por InicializarForm (compatibilidade com pipeline de migracao).
    *--------------------------------------------------------------------------
        THIS.ConfigurarGrupoBotoes()
        THIS.ConfigurarGrid()
        THIS.ConfigurarFiltros()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltros()
    *  Cria a area de filtros entre o cabecalho e o grid.
    *  Linha 1 (Top~163): Grupo (lookup) | Periodo (datas)
    *  Linha 2 (Top~190): Conta (lookup) | Processar
    *  Rodape (Top=530): TxtFavorecido
    *  Shapes decorativas ao redor das duas areas (filtros e grade).
    *  Posicoes: escala 1.25x horizontal do original 800px.
    *--------------------------------------------------------------------------

        *-- Shape2: borda ao redor da area de filtros (original Top=156, Width=774)
        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top         = 156
            .Left        = 23
            .Width       = 968
            .Height      = 66
            .BackStyle   = 0
            .BorderStyle = 1
            .BorderWidth = 1
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH
        THIS.shp_4c_Shape2.ZOrder(1)

        *-- Shape1: borda ao redor da grade de cheques (original Top=227, Width=774)
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 227
            .Left        = 23
            .Width       = 968
            .Height      = 301
            .BackStyle   = 0
            .BorderStyle = 1
            .BorderWidth = 1
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH
        THIS.shp_4c_Shape1.ZOrder(1)

        *-- Label "Grupo :" (original Label3: Top=167, Left=34)
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 167
            .Left      = 43
            .Width     = 48
            .Height    = 15
            .Caption   = "Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- TextBox codigo grupo (original GetCdGrupos: Top=163, Left=75, Width=100)
        THIS.AddObject("txt_4c_CdGrupos", "TextBox")
        WITH THIS.txt_4c_CdGrupos
            .Top         = 163
            .Left        = 94
            .Width       = 125
            .Height      = 25
            .Value       = ""
            .MaxLength   = 10
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- TextBox descricao grupo (original GetDsGrupos: Top=163, Left=177, Width=360) - somente leitura
        THIS.AddObject("txt_4c_DsGrupos", "TextBox")
        WITH THIS.txt_4c_DsGrupos
            .Top         = 163
            .Left        = 221
            .Width       = 450
            .Height      = 25
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH

        *-- Label "Per[i]odo :" (original Label2: Top=167, Left=550, Width=45)
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 167
            .Left      = 688
            .Width     = 56
            .Height    = 15
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- TextBox data inicial (original Dt_inicial: Top=163, Left=598, class fweditdata)
        THIS.AddObject("txt_4c_Dt_inicial", "TextBox")
        WITH THIS.txt_4c_Dt_inicial
            .Top         = 163
            .Left        = 748
            .Width       = 86
            .Height      = 25
            .Value       = DATE()
            .Format      = "D"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Label "a" (original Say2: Top=167, Left=686)
        THIS.AddObject("lbl_4c_Say2", "Label")
        WITH THIS.lbl_4c_Say2
            .Top       = 167
            .Left      = 858
            .Width     = 15
            .Height    = 15
            .Caption   = "a"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- TextBox data final (original Dt_final: Top=163, Left=701, class fweditdata)
        THIS.AddObject("txt_4c_Dt_final", "TextBox")
        WITH THIS.txt_4c_Dt_final
            .Top         = 163
            .Left        = 876
            .Width       = 86
            .Height      = 25
            .Value       = DATE()
            .Format      = "D"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Botao Processar (original Command2: Top=191, Left=598, Width=88, Height=24)
        THIS.AddObject("cmd_4c_Command2", "CommandButton")
        WITH THIS.cmd_4c_Command2
            .Top         = 191
            .Left        = 748
            .Width       = 110
            .Height      = 24
            .Caption     = "Processar"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .FontBold    = .F.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(236, 233, 216)
            .Themes      = .T.
            .Visible     = .T.
        ENDWITH

        *-- Label "Conta :" (original Label1: Top=194, Left=34, Width=38)
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 194
            .Left      = 43
            .Width     = 48
            .Height    = 15
            .Caption   = "Conta :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- TextBox codigo conta (original getCdContas: Top=190, Left=75, Width=100)
        THIS.AddObject("txt_4c_CdContas", "TextBox")
        WITH THIS.txt_4c_CdContas
            .Top         = 190
            .Left        = 94
            .Width       = 125
            .Height      = 25
            .Value       = ""
            .MaxLength   = 10
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- TextBox descricao conta (original getDsContas: Top=190, Left=177, Width=360) - somente leitura
        THIS.AddObject("txt_4c_DsContas", "TextBox")
        WITH THIS.txt_4c_DsContas
            .Top         = 190
            .Left        = 221
            .Width       = 450
            .Height      = 25
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH

        *-- Label "Favorecido :" (original Label5: Top=534, Left=24, Width=62)
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .Top       = 534
            .Left      = 30
            .Width     = 78
            .Height    = 15
            .Caption   = "Favorecido :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- TextBox favorecido (original txtFavorecido: Top=530, Left=99, Width=286, Height=25)
        *-- When retorna .F. no legado: nao editavel pelo usuario
        THIS.AddObject("txt_4c_TxtFavorecido", "TextBox")
        WITH THIS.txt_4c_TxtFavorecido
            .Top         = 530
            .Left        = 124
            .Width       = 358
            .Height      = 25
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *  Form OPERACIONAL: nao ha PageFrame. Este metodo agrega a configuracao
    *  dos containers flutuantes:
    *    Fase 5: cnt_4c_Justificativa + cnt_4c_Procurar
    *    Fase 6: cnt_4c_Impchmat (adicionado em Edit seguinte)
    *--------------------------------------------------------------------------
        THIS.ConfigurarContainerJustificativa()
        THIS.ConfigurarContainerProcurar()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerJustificativa()
    *  Container flutuante para digitacao da justificativa de cancelamento.
    *  Original: cntjustificativa - Top=532, Left=395, Width=350, Height=69.
    *  Escala 1.25x horizontal -> Left=494, Width=438.
    *  Exibido por BtnExcluirChqClick (Fase 6); oculto por CmdGconfCancelarClick.
    *--------------------------------------------------------------------------
        THIS.AddObject("cnt_4c_Justificativa", "Container")
        WITH THIS.cnt_4c_Justificativa
            .Top         = 532
            .Left        = 494
            .Width       = 438
            .Height      = 69
            .BackStyle   = 1
            .BackColor   = RGB(236, 233, 216)
            .BorderWidth = 1
            .Visible     = .F.

            *-- Label descricao (original: Label5, top=5, left=6, width=143)
            .AddObject("lbl_4c_Label5", "Label")
            WITH .lbl_4c_Label5
                .Top       = 5
                .Left      = 6
                .Width     = 179
                .Height    = 15
                .Caption   = "Justificativa do cancelamento"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            *-- EditBox para digitar a justificativa (original: get_justificativa, fwmemo)
            *  Top=21, Left=3, Width=238, Height=44 -> Width=298 (escala 1.25x)
            .AddObject("obj_4c_Get_justificativa", "EditBox")
            WITH .obj_4c_Get_justificativa
                .Top         = 21
                .Left        = 3
                .Width       = 298
                .Height      = 44
                .Value       = ""
                .MaxLength   = 200
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Visible     = .T.
            ENDWITH

            *-- CommandGroup confirmar/cancelar (original: cmdGconf, top=18, left=243, width=107, height=47)
            *  Escala 1.25x -> Left=304, Width=134
            .AddObject("obj_4c_CmdGconf", "CommandGroup")
            WITH .obj_4c_CmdGconf
                .Top           = 18
                .Left          = 304
                .Width         = 134
                .Height        = 47
                .ButtonCount   = 2
                .BackStyle     = 0
                .SpecialEffect = 1
                .Themes        = .F.
                .Visible       = .T.

                *-- Buttons(1): Confirmar cancelamento (original: cmConfirmar)
                WITH .Buttons(1)
                    .Top             = 2
                    .Left            = 2
                    .Width           = 60
                    .Height          = 40
                    .Caption         = "Confirmar"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .PicturePosition = 13
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                    .Visible         = .T.
                ENDWITH

                *-- Buttons(2): Cancelar (fecha container sem confirmar)
                WITH .Buttons(2)
                    .Top             = 2
                    .Left            = 70
                    .Width           = 60
                    .Height          = 40
                    .Caption         = "Cancelar"
                    .FontName        = "Tahoma"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .PicturePosition = 13
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                    .Visible         = .T.
                ENDWITH
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerProcurar()
    *  Container flutuante para pesquisa de cheque por banco/agencia/conta/numero.
    *  Original: cntProcurar - Top=284, Left=240, Width=314, Height=218.
    *  Escala 1.25x horizontal -> Left=300, Width=393.
    *  Exibido por BtnProcurarClick (Buttons(4) - Fase 6); oculto por Voltar.
    *  Tambem integra leitura de CMC-7 (leitor de codigo de barras).
    *--------------------------------------------------------------------------
        THIS.AddObject("cnt_4c_Procurar", "Container")
        WITH THIS.cnt_4c_Procurar
            .Top         = 284
            .Left        = 300
            .Width       = 393
            .Height      = 218
            .BackStyle   = 1
            .BackColor   = RGB(236, 233, 216)
            .BorderWidth = 1
            .Visible     = .F.

            *-- Label titulo (original: Label1, top=8, left=12, width=54, caption="Procurar")
            .AddObject("lbl_4c_Label1", "Label")
            WITH .lbl_4c_Label1
                .Top       = 8
                .Left      = 12
                .Width     = 68
                .Height    = 16
                .Caption   = "Procurar"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            *-- Label "Banco :" (original: lblBanco, top=139, left=36)
            .AddObject("lbl_4c_LblBanco", "Label")
            WITH .lbl_4c_LblBanco
                .Top       = 139
                .Left      = 45
                .Width     = 48
                .Height    = 15
                .Caption   = "Banco :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            *-- Label "Agencia :" (original: lblAgencia, top=163, left=27)
            .AddObject("lbl_4c_LblAgencia", "Label")
            WITH .lbl_4c_LblAgencia
                .Top       = 163
                .Left      = 34
                .Width     = 59
                .Height    = 15
                .Caption   = "Ag" + CHR(234) + "ncia :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            *-- Label "Conta :" (original: lblConta, top=187, left=36)
            .AddObject("lbl_4c_LblConta", "Label")
            WITH .lbl_4c_LblConta
                .Top       = 187
                .Left      = 45
                .Width     = 48
                .Height    = 15
                .Caption   = "Conta :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            *-- Label "Cheque :" (original: lblCheque, top=139, left=164)
            .AddObject("lbl_4c_LblCheque", "Label")
            WITH .lbl_4c_LblCheque
                .Top       = 139
                .Left      = 205
                .Width     = 58
                .Height    = 15
                .Caption   = "Cheque :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            *-- Label "Emissao :" (original: lblEmissao, top=163, left=163)
            .AddObject("lbl_4c_LblEmissao", "Label")
            WITH .lbl_4c_LblEmissao
                .Top       = 163
                .Left      = 204
                .Width     = 59
                .Height    = 15
                .Caption   = "Emiss" + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            *-- Label "Valor :" (original: lblValor, top=187, left=177)
            .AddObject("lbl_4c_LblValor", "Label")
            WITH .lbl_4c_LblValor
                .Top       = 187
                .Left      = 221
                .Width     = 41
                .Height    = 15
                .Caption   = "Valor :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            *-- TextBox Banco (original: getBanco, top=135, left=77, width=31)
            *  Tambem recebe input do leitor CMC-7 via KeyPress (Fase 6)
            .AddObject("txt_4c_Banco", "TextBox")
            WITH .txt_4c_Banco
                .Top         = 135
                .Left        = 96
                .Width       = 39
                .Height      = 22
                .Value       = ""
                .MaxLength   = 3
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Visible     = .T.
            ENDWITH

            *-- TextBox Agencia (original: getAgencia, top=158, left=77, width=40)
            .AddObject("txt_4c_Agencia", "TextBox")
            WITH .txt_4c_Agencia
                .Top         = 158
                .Left        = 96
                .Width       = 50
                .Height      = 22
                .Value       = ""
                .MaxLength   = 4
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Visible     = .T.
            ENDWITH

            *-- TextBox Conta corrente (original: getConta, top=181, left=77, width=81, height=23)
            .AddObject("txt_4c_Conta", "TextBox")
            WITH .txt_4c_Conta
                .Top         = 181
                .Left        = 96
                .Width       = 101
                .Height      = 23
                .Value       = ""
                .MaxLength   = 10
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Visible     = .T.
            ENDWITH

            *-- TextBox Numero do cheque (original: getCheque, top=135, left=213, width=52, height=23)
            .AddObject("txt_4c_Cheque", "TextBox")
            WITH .txt_4c_Cheque
                .Top         = 135
                .Left        = 266
                .Width       = 65
                .Height      = 23
                .Value       = ""
                .MaxLength   = 6
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Visible     = .T.
            ENDWITH

            *-- TextBox Data de emissao (original: getEmissao, top=158, left=213, width=81, height=23)
            *  Mutualmente exclusivo com txt_4c_Valor (When = Empty(Valor))
            .AddObject("txt_4c_Emissao", "TextBox")
            WITH .txt_4c_Emissao
                .Top         = 158
                .Left        = 266
                .Width       = 101
                .Height      = 23
                .Value       = {}
                .Format      = "D"
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Visible     = .T.
            ENDWITH

            *-- TextBox Valor do cheque (original: getValor, top=181, left=213, width=81, height=23)
            *  Mutualmente exclusivo com txt_4c_Emissao (When = Empty(Emissao))
            .AddObject("txt_4c_Valor", "TextBox")
            WITH .txt_4c_Valor
                .Top         = 181
                .Left        = 266
                .Width       = 101
                .Height      = 23
                .Value       = 0
                .InputMask   = "999,999,999.99"
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Visible     = .T.
            ENDWITH

            *-- CommandGroup pesquisar/voltar (original: cmdgprocurar, top=7, left=135, width=173, height=110)
            *  Escala 1.25x -> Left=169, Width=216
            .AddObject("obj_4c_Cmdgprocurar", "CommandGroup")
            WITH .obj_4c_Cmdgprocurar
                .Top           = 7
                .Left          = 169
                .Width         = 216
                .Height        = 110
                .ButtonCount   = 2
                .BackStyle     = 0
                .SpecialEffect = 1
                .Themes        = .F.
                .Visible       = .T.

                *-- Buttons(1): Pesquisar cheque pelos criterios informados
                WITH .Buttons(1)
                    .Top             = 5
                    .Left            = 2
                    .Width           = 100
                    .Height          = 100
                    .Caption         = "Pesquisar"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .PicturePosition = 13
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                    .Visible         = .T.
                ENDWITH

                *-- Buttons(2): Voltar para visao principal
                WITH .Buttons(2)
                    .Top             = 5
                    .Left            = 110
                    .Width           = 100
                    .Height          = 100
                    .Caption         = "Voltar"
                    .FontName        = "Tahoma"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .PicturePosition = 13
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                    .Visible         = .T.
                ENDWITH
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nVisao)
    *  Gerencia visibilidade dos containers flutuantes.
    *  par_nVisao: 0=Grade principal, 1=Procurar, 2=Impressao Matricial
    *  Containers (cnt_4c_Procurar, cnt_4c_Impchmat) criados nas Fases 5+.
    *--------------------------------------------------------------------------
        DO CASE
        CASE par_nVisao = 0
            *-- Retorna para a visao principal
            IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5)
                THIS.cnt_4c_Procurar.Enabled = .F.
                THIS.cnt_4c_Procurar.Visible = .F.
            ENDIF
            IF PEMSTATUS(THIS, "cnt_4c_Impchmat", 5)
                THIS.cnt_4c_Impchmat.Enabled = .F.
                THIS.cnt_4c_Impchmat.Visible = .F.
            ENDIF
            THIS.grd_4c_Dados.Enabled         = .T.
            THIS.txt_4c_CdContas.Enabled      = .T.
            THIS.txt_4c_DsContas.Enabled      = .T.
            THIS.txt_4c_TxtFavorecido.Enabled = .T.
            THIS.obj_4c_CmdGok.Enabled        = .T.
            THIS.cmd_4c_Tudo1.Visible         = .T.
            THIS.cmd_4c_Apaga1.Visible        = .T.
        CASE par_nVisao = 1
            *-- Exibe painel Procurar, desabilita grade
            THIS.grd_4c_Dados.Enabled         = .F.
            THIS.txt_4c_CdContas.Enabled      = .F.
            THIS.txt_4c_DsContas.Enabled      = .F.
            THIS.txt_4c_TxtFavorecido.Enabled = .F.
            THIS.obj_4c_CmdGok.Enabled        = .F.
            THIS.cmd_4c_Tudo1.Visible         = .F.
            THIS.cmd_4c_Apaga1.Visible        = .F.
            IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5)
                THIS.cnt_4c_Procurar.Enabled = .T.
                THIS.cnt_4c_Procurar.Visible = .T.
            ENDIF
        CASE par_nVisao = 2
            *-- Exibe painel Impressao Matricial, desabilita grade
            THIS.grd_4c_Dados.Enabled         = .F.
            THIS.txt_4c_CdContas.Enabled      = .F.
            THIS.txt_4c_DsContas.Enabled      = .F.
            THIS.txt_4c_TxtFavorecido.Enabled = .F.
            THIS.obj_4c_CmdGok.Enabled        = .F.
            THIS.cmd_4c_Tudo1.Visible         = .F.
            THIS.cmd_4c_Apaga1.Visible        = .F.
            IF PEMSTATUS(THIS, "cnt_4c_Impchmat", 5)
                THIS.cnt_4c_Impchmat.Enabled = .T.
                THIS.cnt_4c_Impchmat.Visible = .T.
            ENDIF
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
    *--------------------------------------------------------------------------
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.LiberarCursores()
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao encerrar")
        ENDTRY
        DODEFAULT()
    ENDPROC

    *==========================================================================
    *  FASE 6/8 - cnt_4c_Impchmat + RegistrarBINDEVENTs + event handlers
    *==========================================================================

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerImpchmat()
    *  Container flutuante para impressao matricial por faixa de numeros.
    *  Original: impchmat - Top=284, Left=240, Width=314, Height=218.
    *  Escala 1.25x horizontal -> Left=300, Width=393.
    *--------------------------------------------------------------------------
        THIS.AddObject("cnt_4c_Impchmat", "Container")
        WITH THIS.cnt_4c_Impchmat
            .Top         = 284
            .Left        = 300
            .Width       = 393
            .Height      = 218
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 1
            .Visible     = .F.

            .AddObject("lbl_4c_Label1", "Label")
            WITH .lbl_4c_Label1
                .Top       = 8
                .Left      = 12
                .Width     = 81
                .Height    = 16
                .Caption   = "Impress" + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LblBanco", "Label")
            WITH .lbl_4c_LblBanco
                .Top       = 157
                .Left      = 83
                .Width     = 48
                .Height    = 15
                .Caption   = "Banco :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- "Cheque Inicial :" (legado: lblAgencia)
            .AddObject("lbl_4c_LblAgencia", "Label")
            WITH .lbl_4c_LblAgencia
                .Top       = 185
                .Left      = 35
                .Width     = 95
                .Height    = 15
                .Caption   = "Cheque Inicial :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- "Cheque Final :" (legado: lblCheque)
            .AddObject("lbl_4c_LblCheque", "Label")
            WITH .lbl_4c_LblCheque
                .Top       = 184
                .Left      = 215
                .Width     = 89
                .Height    = 15
                .Caption   = "Cheque Final :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- TextBox Banco (original: getBanco, top=153, left=107, width=31, mask=999)
            .AddObject("txt_4c_Banco", "TextBox")
            WITH .txt_4c_Banco
                .Top         = 153
                .Left        = 134
                .Width       = 39
                .Height      = 22
                .Value       = ""
                .InputMask   = "999"
                .MaxLength   = 3
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(0, 0, 0)
                .Visible     = .T.
            ENDWITH

            *-- TextBox Cheque Inicial (original: Getchini, top=179, left=107, mask=999999)
            .AddObject("txt_4c_Chini", "TextBox")
            WITH .txt_4c_Chini
                .Top         = 179
                .Left        = 134
                .Width       = 65
                .Height      = 23
                .Value       = ""
                .InputMask   = "999999"
                .MaxLength   = 6
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(0, 0, 0)
                .Visible     = .T.
            ENDWITH

            *-- TextBox Cheque Final (original: getChfin, top=180, left=245, mask=999999)
            .AddObject("txt_4c_Chfin", "TextBox")
            WITH .txt_4c_Chfin
                .Top         = 180
                .Left        = 306
                .Width       = 65
                .Height      = 23
                .Value       = ""
                .InputMask   = "999999"
                .MaxLength   = 6
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(0, 0, 0)
                .Visible     = .T.
            ENDWITH

            *-- CommandGroup Imprimir/Encerrar (original: cmdGprocurar, top=7, left=134, width=173, height=110)
            .AddObject("obj_4c_CmdGprocurar", "CommandGroup")
            WITH .obj_4c_CmdGprocurar
                .Top           = 7
                .Left          = 167
                .Width         = 216
                .Height        = 110
                .ButtonCount   = 2
                .BackStyle     = 0
                .SpecialEffect = 1
                .Themes        = .F.
                .BorderColor   = RGB(136, 189, 188)
                .Visible       = .T.

                WITH .Buttons(1)
                    .Top             = 1
                    .Left            = 13
                    .Width           = 75
                    .Height          = 75
                    .Caption         = "\<Imprimir"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .PicturePosition = 13
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
                    .Visible         = .T.
                ENDWITH

                WITH .Buttons(2)
                    .Top             = 1
                    .Left            = 119
                    .Width           = 75
                    .Height          = 75
                    .Caption         = "Encerrar"
                    .Cancel          = .T.
                    .FontName        = "Tahoma"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .PicturePosition = 13
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .Visible         = .T.
                ENDWITH
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarBINDEVENTs()
    *  Registra todos os eventos dos controles nos handlers PUBLIC do form.
    *--------------------------------------------------------------------------
        *-- CommandGroup principal (9 botoes)
        BINDEVENT(THIS.obj_4c_CmdGok, "Click", THIS, "CmdGokClick")

        *-- Grid: navegacao de linha e scroll
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange",  THIS, "GrdAfterRowColChange")
        BINDEVENT(THIS.grd_4c_Dados, "BeforeRowColChange", THIS, "GrdBeforeRowColChange")
        BINDEVENT(THIS.grd_4c_Dados, "Scrolled",           THIS, "GrdScrolled")
        BINDEVENT(THIS.grd_4c_Dados, "DoScroll",           THIS, "GrdDoScroll")

        *-- Grid: Header da coluna NCopias
        BINDEVENT(THIS.grd_4c_Dados.Column3.Header1, "Click", THIS, "HeaderNcopiasClick")

        *-- Grid: CheckBox coluna Imprime
        BINDEVENT(THIS.grd_4c_Dados.Column10.chk_4c_Imprime, "KeyPress", THIS, "ChkImprimeKeyPress")
        BINDEVENT(THIS.grd_4c_Dados.Column10.chk_4c_Imprime, "MouseUp",  THIS, "ChkImprimeMouseUp")

        *-- Botoes marcar/desmarcar
        BINDEVENT(THIS.cmd_4c_Apaga1,   "Click", THIS, "CmdApaga1Click")
        BINDEVENT(THIS.cmd_4c_Tudo1,    "Click", THIS, "CmdTudo1Click")
        BINDEVENT(THIS.cmd_4c_Command2, "Click", THIS, "Command2Click")

        *-- Campos de filtro: GotFocus salva valor anterior; KeyPress valida ao sair
        BINDEVENT(THIS.txt_4c_CdGrupos,  "GotFocus", THIS, "CdGruposGotFocus")
        BINDEVENT(THIS.txt_4c_CdGrupos,  "KeyPress", THIS, "CdGruposKeyPress")
        BINDEVENT(THIS.txt_4c_DsGrupos,  "GotFocus", THIS, "DsGruposGotFocus")
        BINDEVENT(THIS.txt_4c_DsGrupos,  "KeyPress", THIS, "DsGruposKeyPress")
        BINDEVENT(THIS.txt_4c_CdContas,  "GotFocus", THIS, "CdContasGotFocus")
        BINDEVENT(THIS.txt_4c_CdContas,  "KeyPress", THIS, "CdContasKeyPress")
        BINDEVENT(THIS.txt_4c_DsContas,  "GotFocus", THIS, "DsContasGotFocus")
        BINDEVENT(THIS.txt_4c_DsContas,  "KeyPress", THIS, "DsContasKeyPress")
        BINDEVENT(THIS.txt_4c_Dt_inicial,"GotFocus", THIS, "DtInicialGotFocus")
        BINDEVENT(THIS.txt_4c_Dt_inicial,"KeyPress", THIS, "DtInicialKeyPress")
        BINDEVENT(THIS.txt_4c_Dt_final,  "GotFocus", THIS, "DtFinalGotFocus")
        BINDEVENT(THIS.txt_4c_Dt_final,  "KeyPress", THIS, "DtFinalKeyPress")

        *-- Container Justificativa: CommandGroup confirmar/cancelar
        BINDEVENT(THIS.cnt_4c_Justificativa.obj_4c_CmdGconf, "Click", THIS, "CmdGconfClick")

        *-- Container ImpChMat: CommandGroup imprimir/encerrar + campos
        BINDEVENT(THIS.cnt_4c_Impchmat.obj_4c_CmdGprocurar, "Click",    THIS, "ImpchmatCmdGprocurarClick")
        BINDEVENT(THIS.cnt_4c_Impchmat.txt_4c_Banco,         "KeyPress", THIS, "ImpchmatBancoKeyPress")
        BINDEVENT(THIS.cnt_4c_Impchmat.txt_4c_Chini,         "KeyPress", THIS, "ImpchmatChiniKeyPress")
        BINDEVENT(THIS.cnt_4c_Impchmat.txt_4c_Chfin,         "KeyPress", THIS, "ImpchmatChfinKeyPress")

        *-- Container Procurar: CommandGroup pesquisar/cancelar + campos
        BINDEVENT(THIS.cnt_4c_Procurar.obj_4c_Cmdgprocurar, "Click",    THIS, "ProcurarCmdgprocurarClick")
        BINDEVENT(THIS.cnt_4c_Procurar.txt_4c_Banco,         "KeyPress", THIS, "ProcurarBancoKeyPress")
        BINDEVENT(THIS.cnt_4c_Procurar.txt_4c_Emissao,       "GotFocus", THIS, "ProcurarEmissaoGotFocus")
        BINDEVENT(THIS.cnt_4c_Procurar.txt_4c_Valor,         "GotFocus", THIS, "ProcurarValorGotFocus")
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE MExibeCheques(par_lSeek)
    *  Atualiza a grade de cheques aplicando filtro de conta e marcacoes zeradas.
    *  par_lSeek = .T.: posiciona no fim do cursor (apos incluir/alterar).
    *--------------------------------------------------------------------------
        LOCAL loc_lSeek

        IF TYPE("par_lSeek") = "L"
            loc_lSeek = par_lSeek
        ELSE
            loc_lSeek = .F.
        ENDIF

        THIS.LockScreen = .T.

        TRY
            IF USED("CsSigCqChi")
                UPDATE CsSigCqChi SET nMarca1s = 0 WHERE nMarca1s = 1
            ENDIF

            IF EMPTY(ALLTRIM(THIS.txt_4c_CdContas.Value))
                SELECT CsSigCqChi
                SET ORDER TO NCopias
                IF loc_lSeek
                    SEEK CHR(255) IN CsSigCqChi ORDER NCopias ASCENDING
                ENDIF
            ELSE
                SELECT CsSigCqChi
                SET ORDER TO Contas
                SET KEY TO ALLTRIM(THIS.txt_4c_CdContas.Value)
                IF loc_lSeek
                    SEEK ALLTRIM(THIS.txt_4c_CdContas.Value) + CHR(255) IN CsSigCqChi ORDER Contas ASCENDING
                ENDIF
            ENDIF

            THIS.obj_4c_CmdGok.Buttons(4).Enabled = .T.
            THIS.obj_4c_CmdGok.Refresh
            THIS.grd_4c_Dados.Refresh

            IF USED("CsSigCqChi") AND !EOF("CsSigCqChi")
                THIS.txt_4c_TxtFavorecido.Value = ALLTRIM(CsSigCqChi.favos)
            ENDIF
            THIS.txt_4c_TxtFavorecido.Refresh
            THIS.grd_4c_Dados.Column2.SetFocus
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em MExibeCheques")
        ENDTRY

        THIS.LockScreen = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE MontaChq(par_lPosiciona)
    *  Carrega o cursor CsSigCqChi via SQL conforme os filtros da tela.
    *  par_lPosiciona = .T.: reposiciona no cheque atual apos recarregar.
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_lPosiciona, loc_cBusca
        LOCAL loc_cCdGrupo, loc_cCdConta, loc_cQuery, loc_nQueryOk
        PRIVATE pDtInicial, pDtFinal

        loc_lResultado = .F.

        TRY
            loc_lPosiciona = (TYPE("par_lPosiciona") = "L" AND par_lPosiciona)

            IF loc_lPosiciona AND USED("CsSigCqChi") AND !EOF("CsSigCqChi")
                loc_cBusca = CsSigCqChi.bancos + CsSigCqChi.agencias + ;
                             CsSigCqChi.ncontas  + CsSigCqChi.ncheques
            ELSE
                loc_cBusca = ""
            ENDIF

            pDtInicial   = THIS.txt_4c_Dt_inicial.Value
            pDtFinal     = THIS.txt_4c_Dt_final.Value
            loc_cCdGrupo = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
            loc_cCdConta = ALLTRIM(THIS.txt_4c_CdContas.Value)

            THIS.LockScreen = .T.
            WAIT WINDOW "Aguarde! Selecionando Cheques..." NOWAIT

            IF USED("CsSigCqChi")
                THIS.grd_4c_Dados.RecordSource = ""
                USE IN CsSigCqChi
            ENDIF

            IF EMPTY(loc_cCdConta)
                loc_cQuery = "SELECT a.emps, a.dopes, a.numes, a.datas, a.bancos, a.agencias," + ;
                             " a.ncontas, a.ncheques, a.contas," + ;
                             " a.valors, a.favos, a.ncopias, a.emitidos, a.nemissoes, a.cancelas," + ;
                             " a.cidchaves, a.JustCanc, 0 as NEmitidos, 0 as NCancelas, 0 as NMarca1s" + ;
                             " FROM SigCqChi a" + ;
                             " WHERE a.datas BETWEEN ?pDtInicial AND ?pDtFinal"
                loc_cQuery = loc_cQuery + ;
                             " AND a.Contas IN (SELECT DISTINCT ContaDs FROM SigOpFp WHERE EmiChqs = 1)" + ;
                             " ORDER BY a.emps, a.dopes, a.numes, a.datas, a.bancos, a.agencias," + ;
                             " a.ncontas, a.ncheques, a.contas, a.valors, a.favos," + ;
                             " a.ncopias, a.emitidos, a.nemissoes, a.cancelas, a.cidchaves"
            ELSE
                loc_cQuery = "SELECT emps, dopes, numes, datas, bancos, agencias," + ;
                             " ncontas, ncheques, contas," + ;
                             " valors, favos, ncopias, emitidos, nemissoes, cancelas, cidchaves, JustCanc," + ;
                             " 0 as NEmitidos, 0 as NCancelas, 0 as NMarca1s" + ;
                             " FROM SigCqChi" + ;
                             " WHERE datas BETWEEN ?pDtInicial AND ?pDtFinal"
                loc_cQuery = loc_cQuery + ;
                             " AND Contas = " + EscaparSQL(loc_cCdConta) + ;
                             " ORDER BY emps, dopes, numes, datas, bancos, agencias," + ;
                             " ncontas, ncheques, contas, valors, favos," + ;
                             " ncopias, emitidos, nemissoes, cancelas, cidchaves"
            ENDIF

            IF USED("cursor_4c_TmpChi")
                USE IN cursor_4c_TmpChi
            ENDIF
            loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_TmpChi")
            IF loc_nQueryOk < 1
                WAIT CLEAR
                MsgErro("Falha ao carregar cheques.", "Erro de Conex" + CHR(227) + "o")
                THIS.LockScreen = .F.
                loc_lResultado = .F.
            ENDIF

            SELECT emps, dopes, numes, datas, bancos, agencias, ncontas, ncheques, contas, ;
                   valors, favos, ncopias, NEmitidos, cidchaves, NCancelas, NMarca1s, JustCanc ;
              FROM cursor_4c_TmpChi ;
             ORDER BY bancos, agencias, ncontas, ncheques ;
              INTO CURSOR CsSigCqChi READWRITE

            USE IN cursor_4c_TmpChi

            SELECT CsSigCqChi
            INDEX ON ncopias                                                   TAG NCopias
            INDEX ON NEmitidos                                                 TAG NEmitidos
            INDEX ON NCancelas                                                 TAG NCancelas
            INDEX ON NMarca1s                                                  TAG NMarca1s
            INDEX ON ncheques                                                  TAG NCheques
            INDEX ON datas                                                     TAG Datas
            INDEX ON ncontas + ncheques                                        TAG Conta
            INDEX ON contas + STR(ncopias)                                     TAG Contas
            INDEX ON DTOS(datas) + bancos + agencias + ncontas + ncheques      TAG Emissao
            INDEX ON STR(valors,12,2) + bancos + agencias + ncontas + ncheques TAG Valor
            INDEX ON bancos + agencias + ncontas + ncheques                    TAG Cheque
            INDEX ON agencias + ncontas + ncheques                             TAG Agencia

            SET ORDER TO NCopias
            IF loc_lPosiciona AND !EMPTY(loc_cBusca)
                IF !SEEK(loc_cBusca)
                    GO TOP
                ENDIF
            ELSE
                GO TOP
            ENDIF

            THIS.LockScreen = .F.
            WAIT CLEAR

            THIS.grd_4c_Dados.RecordSource = "CsSigCqChi"
            WITH THIS.grd_4c_Dados
                .Column10.ControlSource                 = "CsSigCqChi.NMarca1s"
                .Column10.chk_4c_Imprime.ControlSource = "CsSigCqChi.NMarca1s"
                .Column1.ControlSource                  = "CsSigCqChi.datas"
                .Column2.ControlSource                  = "CsSigCqChi.contas"
                .Column3.ControlSource                  = "CsSigCqChi.ncopias"
                .Column4.ControlSource                  = "CsSigCqChi.bancos"
                .Column5.ControlSource                  = "CsSigCqChi.agencias"
                .Column6.ControlSource                  = "CsSigCqChi.ncontas"
                .Column7.ControlSource                  = "CsSigCqChi.ncheques"
                .Column9.ControlSource                  = "CsSigCqChi.valors"
                .Column8.ControlSource = "IIF(CsSigCqChi.NCancelas=1,'Cancelado'," + ;
                    "IIF(CsSigCqChi.NEmitidos=1," + ;
                    "IIF(CsSigCqChi.ncopias>1,'Reemitido','Emitido')," + ;
                    "'N" + CHR(227) + "o Emitido'))"
                .SetAll("DynamicForeColor", ;
                    "IIF(CsSigCqChi.NCancelas=1,RGB(255,0,0)," + ;
                    "IIF(CsSigCqChi.NEmitidos=0,RGB(0,0,255),RGB(0,0,0)))", ;
                    "Column")
                .Refresh
            ENDWITH

            THIS.cnt_4c_Justificativa.obj_4c_Get_justificativa.ControlSource = "CsSigCqChi.JustCanc"

            IF loc_lPosiciona
                THIS.MExibeCheques(.F.)
            ELSE
                THIS.MExibeCheques(.T.)
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            WAIT CLEAR
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message, "Erro em MontaChq")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregaConta()
    *  Carrega TmpConta com dados de pagamento do cheque selecionado em CsSigCqChi.
    *  Chamado por BtnImprimirClick e BtnReciboClick antes de abrir subform.
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cChave, loc_cSQL, loc_nQueryOk

        loc_lResultado = .F.

        TRY
            IF !USED("CsSigCqChi") OR EOF("CsSigCqChi")
                loc_lResultado = .F.
            ENDIF

            loc_cChave = CsSigCqChi.emps + CsSigCqChi.dopes + STR(CsSigCqChi.numes, 6)

            IF USED("TmpPrIt")
                USE IN TmpPrIt
            ENDIF

            loc_cSQL = "SELECT emps, dopes, numes, empos, grupos, contas, tipos, nopers, opers," + ;
                       " acertos, cotacaos, valos, moedas, hists, vencs, datas" + ;
                       " FROM SigCdPit" + ;
                       " WHERE empdopnums = " + EscaparSQL(loc_cChave) + ;
                       " ORDER BY emps, dopes, numes, grupos, contas, nopers"

            loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "TmpPrIt")
            IF loc_nQueryOk < 1
                MsgErro("Falha ao carregar pagamentos.", "Erro")
                loc_lResultado = .F.
            ENDIF

            IF USED("TmpConta")
                USE IN TmpConta
            ENDIF

            SET NULL ON
            CREATE CURSOR TmpConta (grupos C(10) NULL, contas C(10) NULL, flag L NULL, ;
                valos N(12,2) NULL, acerto N(12,2) NULL, moedas C(3) NULL, ;
                datas D NULL, vencs D NULL, hists C(50) NULL, nomes C(50) NULL, ;
                emps C(3) NULL, nopers N(9,0) NULL, dopes C(20) NULL, numes N(6,0) NULL, ;
                tipos C(1) NULL, fpags C(12) NULL, opers C(1) NULL, baixa N(12,2) NULL, ;
                baixaaut N(12,2) NULL, cotacaos N(12,4) NULL, grupocs C(10) NULL, ;
                contacs C(10) NULL, cotorigs N(12,4) NULL, moedacs C(3) NULL, ;
                cotacaocs N(12,4) NULL, valocs N(12,2) NULL, empos C(3) NULL, ;
                OrdCopChs N(3,0) NULL)
            SET NULL OFF

            SELECT TmpPrIt
            GO TOP

            SCAN
                SCATTER MEMVAR
                m.flag  = .F.
                m.nomes = ""

                IF USED("CrContas") AND SEEK(m.contas, "CrContas", "IClis")
                    m.nomes = ALLTRIM(CrContas.RClis)
                ENDIF

                DO CASE
                CASE TmpPrIt.tipos = "M"
                    IF m.acertos <> 0
                        m.flag = .T.
                    ENDIF

                CASE TmpPrIt.tipos = "C"
                    m.flag = .T.
                    IF USED("TmpMccr")
                        USE IN TmpMccr
                    ENDIF
                    loc_cSQL = "SELECT emps, nopers, grupos, contas, valors, valpags" + ;
                               " FROM SigMvCcr" + ;
                               " WHERE emps = " + EscaparSQL(m.empos) + ;
                               " AND nopers = " + FormatarNumeroSQL(m.nopers)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpMccr") >= 1
                        SELECT TmpMccr
                        GO TOP
                        IF m.grupos <> TmpMccr.grupos OR m.contas <> TmpMccr.contas
                            SKIP
                        ENDIF
                        IF !EOF("TmpMccr")
                            m.valos = TmpMccr.valors - TmpMccr.valpags + m.acertos
                        ENDIF
                    ENDIF

                CASE TmpPrIt.tipos = "P"
                    m.flag = .T.
                    IF USED("TmpPar")
                        USE IN TmpPar
                    ENDIF
                    loc_cSQL = "SELECT emps, nopers, moefpgs, fpags, vpags" + ;
                               " FROM SigMvPar" + ;
                               " WHERE emps = " + EscaparSQL(m.empos) + ;
                               " AND nopers = " + FormatarNumeroSQL(m.nopers)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpPar") >= 1
                        SELECT TmpPar
                        GO TOP
                        IF !EOF("TmpPar")
                            m.valos  = m.valos - TmpPar.vpags + m.acertos
                            m.moedas = ALLTRIM(TmpPar.moefpgs)
                            m.hists  = ALLTRIM(TmpPar.fpags) + " " + m.emps + ;
                                       ALLTRIM(m.dopes) + " " + ALLTRIM(TRANSFORM(m.numes))
                        ENDIF
                    ENDIF
                ENDCASE

                m.acerto = m.acertos
                SELECT TmpConta
                INSERT INTO TmpConta FROM MEMVAR
                SELECT TmpPrIt
            ENDSCAN

            IF USED("TmpPrIt")
                USE IN TmpPrIt
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em CarregaConta")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    *  Helper: atualiza estado dos botoes e justificativa conforme linha do grid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarEstadoGrid()
        LOCAL loc_lCancelas

        IF !USED("CsSigCqChi") OR EOF("CsSigCqChi")
            RETURN
        ENDIF

        loc_lCancelas = (CsSigCqChi.NCancelas <> 0)

        THIS.txt_4c_TxtFavorecido.Value = ALLTRIM(CsSigCqChi.favos)

        THIS.obj_4c_CmdGok.Buttons(1).Enabled = !loc_lCancelas                              && Documento
        THIS.obj_4c_CmdGok.Buttons(6).Enabled = (!loc_lCancelas AND THIS.this_lExcluirDocumento) && ExcluiDoc
        THIS.obj_4c_CmdGok.Buttons(3).Enabled = !loc_lCancelas                              && Imprimir
        THIS.obj_4c_CmdGok.Buttons(5).Enabled = !loc_lCancelas                              && Recibo
        THIS.obj_4c_CmdGok.Buttons(9).Enabled = (loc_lCancelas AND THIS.this_lExcluirCheque) && ExcluirChq

        IF loc_lCancelas
            WITH THIS.cnt_4c_Justificativa
                .Visible = .T.
                .obj_4c_Get_justificativa.Width    = 346
                .obj_4c_Get_justificativa.ReadOnly = .T.
                .obj_4c_Get_justificativa.Refresh
                .obj_4c_CmdGconf.Enabled = .F.
                .obj_4c_CmdGconf.Visible = .F.
            ENDWITH
        ELSE
            WITH THIS.cnt_4c_Justificativa
                .Visible = .F.
                .obj_4c_Get_justificativa.ReadOnly = .F.
                .obj_4c_CmdGconf.Enabled = .F.
                .obj_4c_CmdGconf.Visible = .F.
            ENDWITH
        ENDIF

        THIS.txt_4c_TxtFavorecido.Refresh
        THIS.obj_4c_CmdGok.Refresh
    ENDPROC

    *-- Grid: AfterRowColChange
    PROCEDURE GrdAfterRowColChange(par_nColIndex)
        THIS.AtualizarEstadoGrid()
    ENDPROC

    *-- Grid: BeforeRowColChange
    PROCEDURE GrdBeforeRowColChange(par_nColIndex)
        THIS.AtualizarEstadoGrid()
    ENDPROC

    *-- Grid: Scrolled
    PROCEDURE GrdScrolled(par_nDirection)
        THIS.AtualizarEstadoGrid()
    ENDPROC

    *-- Grid: DoScroll
    PROCEDURE GrdDoScroll(par_nDirection)
        THIS.AtualizarEstadoGrid()
    ENDPROC

    *-- Grid: Header da coluna NCopias
    PROCEDURE HeaderNcopiasClick()
        IF EMPTY(ALLTRIM(THIS.txt_4c_CdContas.Value)) AND ;
           UPPER(ORDER("CsSigCqChi")) <> "NCOPIAS"
            THIS.MExibeCheques(.F.)
        ENDIF
    ENDPROC

    *-- Grid: CheckBox Imprime - KeyPress (ENTER/SPACE toggle marca)
    PROCEDURE ChkImprimeKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_nRecno, loc_cChave

        IF INLIST(par_nKeyCode, 13, 32)
            IF USED("CsSigCqChi") AND !EOF("CsSigCqChi")
                loc_nRecno = RECNO("CsSigCqChi")
                loc_cChave = CsSigCqChi.bancos + CsSigCqChi.agencias + ;
                             CsSigCqChi.ncontas + CsSigCqChi.ncheques
                UPDATE CsSigCqChi SET NMarca1s = IIF(NMarca1s = 1, 0, 1) ;
                  WHERE bancos + agencias + ncontas + ncheques = loc_cChave ;
                    AND NEmitidos = 0 AND NCancelas = 0
                THIS.grd_4c_Dados.Refresh
                IF BETWEEN(loc_nRecno, 1, RECCOUNT("CsSigCqChi"))
                    GOTO loc_nRecno IN CsSigCqChi
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *-- Grid: CheckBox Imprime - MouseUp (simula KeyPress com SPACE)
    PROCEDURE ChkImprimeMouseUp(par_nButton, par_nShift, par_nX, par_nY)
        THIS.ChkImprimeKeyPress(32, 0)
    ENDPROC

    *==========================================================================
    *  Handlers do CommandGroup principal (obj_4c_CmdGok)
    *==========================================================================
    PROCEDURE CmdGokClick()
        DO CASE
        CASE THIS.obj_4c_CmdGok.Value = 1  && Documento
            THIS.BtnDocumentoClick()
        CASE THIS.obj_4c_CmdGok.Value = 2  && Encerrar
            THIS.BtnEncerrarClick()
        CASE THIS.obj_4c_CmdGok.Value = 3  && Imprimir
            THIS.BtnImprimirClick()
        CASE THIS.obj_4c_CmdGok.Value = 4  && Procurar
            THIS.BtnProcurarClick()
        CASE THIS.obj_4c_CmdGok.Value = 5  && Recibo
            THIS.BtnReciboClick()
        CASE THIS.obj_4c_CmdGok.Value = 6  && Exclui Doc.
            THIS.BtnExcluiDocClick()
        CASE THIS.obj_4c_CmdGok.Value = 7  && Cheque (jato de tinta)
            THIS.BtnImpchqClick()
        CASE THIS.obj_4c_CmdGok.Value = 8  && Chq. Matric.
            THIS.BtnCmdchmatClick()
        CASE THIS.obj_4c_CmdGok.Value = 9  && Excluir Chq.
            THIS.BtnExcluirChqClick()
        ENDCASE
    ENDPROC

    *-- Botao 1: Documento (abre SigCdPgr)
    PROCEDURE BtnDocumentoClick()
        LOCAL loc_nRecno, loc_cEDNs

        THIS.LockScreen = .T.

        TRY
            IF USED("CsSigCqChi") AND !EOF("CsSigCqChi")
                loc_nRecno = RECNO("CsSigCqChi")
                loc_cEDNs  = CsSigCqChi.emps + CsSigCqChi.dopes + STR(CsSigCqChi.numes, 6)

                DO FORM SigCdPgr WITH LEFT(CsSigCqChi.dopes, 1), .T., ;
                    CsSigCqChi.emps, CsSigCqChi.dopes, CsSigCqChi.numes
                SigCdPgr.AlwaysOnTop = .T.

                IF BETWEEN(loc_nRecno, 1, RECCOUNT("CsSigCqChi"))
                    GOTO loc_nRecno IN CsSigCqChi
                ENDIF
                THIS.MExibeCheques(.F.)
            ELSE
                THIS.MExibeCheques(.T.)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir Documento")
        ENDTRY

        THIS.LockScreen = .F.
    ENDPROC

    *-- Botao 2: Encerrar
    PROCEDURE BtnEncerrarClick()
        IF USED("TmpConta")
            USE IN TmpConta
        ENDIF
        IF USED("CrContas")
            USE IN CrContas
        ENDIF
        THIS.Release()
    ENDPROC

    *-- Botao 3: Imprimir (abre SigReEch)
    PROCEDURE BtnImprimirClick()
        LOCAL loc_lCarrega

        TRY
            loc_lCarrega = THIS.CarregaConta()
            IF loc_lCarrega AND USED("CsSigCqChi") AND !EOF("CsSigCqChi")
                DO FORM SigReEch WITH CsSigCqChi.emps, CsSigCqChi.dopes, ;
                    CsSigCqChi.numes, "CONSULTAR", CsSigCqChi.ncheques
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir Imprimir")
        ENDTRY
    ENDPROC

    *-- Botao 4: Procurar (exibe container cnt_4c_Procurar)
    PROCEDURE BtnProcurarClick()
        THIS.this_lInicio = .T.

        THIS.LockScreen = .T.
        THIS.this_lInicio = .F.

        THIS.txt_4c_CdContas.Enabled      = .F.
        THIS.txt_4c_DsContas.Enabled      = .F.
        THIS.grd_4c_Dados.Enabled         = .F.
        THIS.txt_4c_TxtFavorecido.Enabled = .F.
        THIS.obj_4c_CmdGok.Enabled        = .F.

        IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5)
            THIS.cnt_4c_Procurar.Enabled = .T.
            THIS.cnt_4c_Procurar.Visible = .T.
            THIS.cnt_4c_Procurar.txt_4c_Banco.SetFocus
        ENDIF

        THIS.Refresh
        THIS.LockScreen = .F.
    ENDPROC

    *-- Botao 5: Recibo (abre SigRerec)
    PROCEDURE BtnReciboClick()
        LOCAL loc_lCarrega

        TRY
            loc_lCarrega = THIS.CarregaConta()
            IF loc_lCarrega
                DO FORM SigRerec WITH THIS, "RECIBO"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir Recibo")
        ENDTRY
    ENDPROC

    *-- Botao 6: Exclui Doc. (mostra container justificativa para exclusao)
    PROCEDURE BtnExcluiDocClick()
        WITH THIS.cnt_4c_Justificativa
            .Visible = .T.
            .obj_4c_Get_justificativa.Value    = ""
            .obj_4c_Get_justificativa.Width    = 298
            .obj_4c_Get_justificativa.ReadOnly = .F.
            .obj_4c_Get_justificativa.SetFocus
            .obj_4c_CmdGconf.Enabled           = .T.
            .obj_4c_CmdGconf.Visible           = .T.
            .obj_4c_CmdGconf.Buttons(1).Enabled = .T.
        ENDWITH
    ENDPROC

    *-- Botao 7: Cheque (impressora jato de tinta)
    PROCEDURE BtnImpchqClick()
        LOCAL loc_nRecno, loc_cSQL, loc_nQueryOk
        LOCAL Array loc_aPrinters(1)
        LOCAL loc_nPrinters, loc_cNomeImp, loc_cNomeImpPath, loc_lEncontrou
        LOCAL loc_cPrnIni, loc_nMaxCol, loc_nLivl, loc_nClvl
        LOCAL loc_nLivExt1, loc_nClvExt1, loc_nLivExt2, loc_nClvExt2
        LOCAL loc_nLiNom, loc_nClNom, loc_nLiCid, loc_nClCid
        LOCAL loc_nLiDia, loc_nClDia, loc_nLiMes, loc_nClMes, loc_nLiAno, loc_nClAno
        LOCAL loc_cPgChq, loc_cStrgMes
        LOCAL loc_cPoint, loc_cSeparator

        TRY
            IF !USED("CsSigCqChi") OR !SEEK(1, "CsSigCqChi", "NMarca1s")
                MsgAviso("Nenhum cheque selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            loc_cPoint     = SET("Point")
            loc_cSeparator = SET("Separator")
            loc_cStrgMes   = "Janeiro  FevereiroMar" + CHR(231) + CHR(227) + "o    Abril    " + ;
                             "Maio     Junho    Julho    Agosto   Setembro Outubro  Novembro Dezembro "

            *-- Buscar impressoras configuradas para cheque (CrSigCdmp.nchqfs=1)
            IF USED("CrImp1")
                USE IN CrImp1
            ENDIF

            SELECT DISTINCT Impres as cNomeImp1s, SPACE(100) as cNomeImp2s, 0 as nMarca1s ;
              FROM CrSigCdmp ;
             WHERE nchqfs = 1 ;
             ORDER BY Impres ;
              INTO CURSOR CrImp1 READWRITE

            IF EOF("CrImp1")
                MsgAviso("Nenhuma impressora de cheque configurada!", "Aten" + CHR(231) + CHR(227) + "o")
                USE IN CrImp1
                RETURN
            ENDIF

            *-- Identificar impressoras instaladas no sistema
            loc_nPrinters = APRINTERS(loc_aPrinters)
            SELECT CrImp1
            GO TOP
            SCAN
                loc_cNomeImp = LOWER(ALLTRIM(CrImp1.cNomeImp1s))
                loc_lEncontrou = .F.
                LOCAL loc_n
                FOR loc_n = 1 TO loc_nPrinters
                    IF LOWER(ALLTRIM(JUSTFNAME(loc_aPrinters(loc_n, 1)))) == loc_cNomeImp
                        loc_cNomeImpPath = ALLTRIM(loc_aPrinters(loc_n, 1))
                        SCATTER MEMVAR
                        m.cNomeImp2s = loc_cNomeImpPath
                        m.nMarca1s   = 1
                        GATHER MEMVAR FIELDS cNomeImp2s, nMarca1s
                        loc_lEncontrou = .T.
                        EXIT
                    ENDIF
                ENDFOR
            ENDSCAN

            IF USED("CrImp2")
                USE IN CrImp2
            ENDIF
            SELECT DISTINCT cNomeImp1s, cNomeImp2s ;
              FROM CrImp1 ;
             WHERE nMarca1s = 1 ;
             ORDER BY cNomeImp1s ;
              INTO CURSOR CrImp2 READWRITE

            USE IN CrImp1

            SELECT CrImp2
            INDEX ON cNomeImp2s TAG cNomeImp2s
            GO TOP

            IF EOF("CrImp2")
                MsgAviso("Nenhuma impressora de cheque instalada!", "Aten" + CHR(231) + CHR(227) + "o")
                USE IN CrImp2
                RETURN
            ENDIF

            *-- Selecionar impressora (se mais de uma disponivel)
            IF RECCOUNT("CrImp2") > 1
                loc_cNomeImpPath = GETPRINTER()
                IF EMPTY(loc_cNomeImpPath)
                    USE IN CrImp2
                    RETURN
                ENDIF
                SEEK loc_cNomeImpPath IN CrImp2 ORDER cNomeImp2s
                IF EOF("CrImp2")
                    GO TOP
                ENDIF
            ENDIF

            IF LASTKEY() = 27
                USE IN CrImp2
                RETURN
            ENDIF

            loc_cNomeImp     = ALLTRIM(CrImp2.cNomeImp1s)
            loc_cNomeImpPath = ALLTRIM(CrImp2.cNomeImp2s)
            USE IN CrImp2

            *-- Obter configuracoes da impressora
            IF !SEEK(loc_cNomeImp, "CrSigCdmp", "impres")
                MsgErro("Configuracao da impressora nao encontrada.", "Erro")
                RETURN
            ENDIF

            loc_cPrnIni   = ALLTRIM(CrSigCdmp.fontes)
            loc_nMaxCol   = CrSigCdmp.maxcols
            loc_nLivl     = CrSigCdmp.nlivl1s
            loc_nClvl     = CrSigCdmp.nclvl1s
            loc_nLivExt1  = CrSigCdmp.nlivext1s
            loc_nClvExt1  = CrSigCdmp.nclvext1s
            loc_nLivExt2  = CrSigCdmp.nlivext2s
            loc_nClvExt2  = CrSigCdmp.nclvext2s
            loc_nLiNom    = CrSigCdmp.nlinom1s
            loc_nClNom    = CrSigCdmp.nclnom1s
            loc_nLiCid    = CrSigCdmp.nlicid1s
            loc_nClCid    = CrSigCdmp.nclcid1s
            loc_nLiDia    = CrSigCdmp.nlidia1s
            loc_nClDia    = CrSigCdmp.ncldia1s
            loc_nLiMes    = CrSigCdmp.nlimes1s
            loc_nClMes    = CrSigCdmp.nclmes1s
            loc_nLiAno    = CrSigCdmp.nliano1s
            loc_nClAno    = CrSigCdmp.nclano1s
            loc_cPgChq    = CrSigCdmp.cpgchq1s

            SET POINT TO ","
            SET SEPARATOR TO "."
            SET PRINTER TO NAME (loc_cNomeImpPath)
            SET DEVICE TO PRINTER

            IF !EMPTY(loc_cPrnIni)
                @ 0, 0 SAY EVALUATE(loc_cPrnIni)
            ENDIF

            SELECT * FROM CsSigCqChi WHERE NMarca1s = 1 INTO CURSOR TmpChImp

            WAIT WINDOW "Imprimindo Cheque(s) Selecionado(s)..." NOWAIT

            SELECT TmpChImp
            GO TOP
            SCAN
                PRIVATE pBancos, pAgencias, pNContas, pNCheques
                pBancos   = TmpChImp.bancos
                pAgencias = TmpChImp.agencias
                pNContas  = TmpChImp.ncontas
                pNCheques = TmpChImp.ncheques

                IF USED("TmpPar")
                    USE IN TmpPar
                ENDIF
                loc_cSQL = "SELECT valos, vencs FROM SigMvPar" + ;
                           " WHERE bancos = ?pBancos AND agencias = ?pAgencias" + ;
                           " AND contas = ?pNContas AND numeros = ?pNCheques"
                loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "TmpPar")
                IF loc_nQueryOk < 1
                    WAIT CLEAR
                    SET PRINTER TO DEFAULT
                    SET DEVICE TO SCREEN
                    MsgErro("Falha ao carregar dados do cheque.", "Erro")
                    RETURN
                ENDIF

                SELECT TmpPar
                GO TOP
                IF !EOF() AND (EMPTY(ALLTRIM(THIS.txt_4c_CdContas.Value)) OR ;
                               TmpChImp.contas = ALLTRIM(THIS.txt_4c_CdContas.Value))
                    LOCAL loc_cStr1, loc_cStr2
                    loc_cStr1 = "#" + ALLTRIM(TRANSFORM(TmpPar.valos, "999,999,999.99")) + "#"
                    @ loc_nLivl,    loc_nClvl    SAY loc_cStr1 FONT "Courier New", 10 STYLE "N"

                    loc_cStr1 = ALLTRIM(STR(TmpPar.valos))
                    loc_cStr2 = loc_cStr1
                    IF LEN(loc_cStr2) > (loc_nMaxCol - loc_nClvExt1)
                        loc_cStr2 = LEFT(loc_cStr2, (loc_nMaxCol - loc_nClvExt1))
                        IF !EMPTY(SUBSTR(loc_cStr1, LEN(loc_cStr2) + 1))
                            loc_cStr2 = SUBSTR(loc_cStr2, 1, RAT(" ", loc_cStr2))
                        ENDIF
                    ENDIF
                    @ loc_nLivExt1, loc_nClvExt1 SAY loc_cStr2 FONT "Courier New", 10 STYLE "N"
                    loc_cStr2 = SUBSTR(loc_cStr1, LEN(loc_cStr2) + 1)
                    loc_cStr2 = PADR(loc_cStr2, MIN(LEN(loc_cStr2), (loc_nMaxCol - loc_nClvExt2)))
                    @ loc_nLivExt2, loc_nClvExt2 SAY loc_cStr2 FONT "Courier New", 10 STYLE "N"

                    loc_cStr1 = PADR(ALLTRIM(TmpChImp.favos), MIN(80, (loc_nMaxCol - loc_nClNom)))
                    @ loc_nLiNom, loc_nClNom SAY loc_cStr1 FONT "Courier New", 10 STYLE "N"

                    loc_cStr1 = TRANSFORM(DAY(TmpPar.vencs), "@L 99")
                    @ loc_nLiDia, loc_nClDia SAY loc_cStr1 FONT "Courier New", 10 STYLE "N"
                    loc_cStr1 = ALLTRIM(SUBSTR(loc_cStrgMes, (MONTH(TmpPar.vencs) * 9 - 8), 9))
                    @ loc_nLiMes, loc_nClMes SAY loc_cStr1 FONT "Courier New", 10 STYLE "N"
                    loc_cStr1 = TRANSFORM(YEAR(TmpPar.vencs), "@L 9999")
                    @ loc_nLiAno, loc_nClAno SAY loc_cStr1 FONT "Courier New", 10 STYLE "N"

                    PRIVATE pCidChave
                    pCidChave = TmpChImp.cidchaves
                    loc_cSQL  = "UPDATE SigCqChi SET emitidos = 1 WHERE cidchaves = ?pCidChave"
                    loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nQueryOk < 1
                        WAIT CLEAR
                        SET PRINTER TO DEFAULT
                        SET DEVICE TO SCREEN
                        MsgErro("Falha ao atualizar emissao do cheque.", "Erro")
                        RETURN
                    ENDIF
                ENDIF

                WAIT WINDOW "Imprimindo Cheque(s) Selecionado(s)..." NOWAIT
                SELECT TmpChImp
            ENDSCAN

            WAIT CLEAR
            SET PRINTER TO DEFAULT
            SET DEVICE TO SCREEN
            SET CONSOLE ON

            IF USED("TmpPar")
                USE IN TmpPar
            ENDIF
            IF USED("TmpChImp")
                USE IN TmpChImp
            ENDIF

            SET POINT TO (loc_cPoint)
            SET SEPARATOR TO (loc_cSeparator)
            THIS.MExibeCheques(.T.)

        CATCH TO loc_oErro
            SET PRINTER TO DEFAULT
            SET DEVICE TO SCREEN
            MsgErro(loc_oErro.Message, "Erro ao imprimir cheque")
        ENDTRY
    ENDPROC

    *-- Botao 8: Chq. Matric. (impressora matricial por faixa ou selecionados)
    PROCEDURE BtnCmdchmatClick()
        LOCAL loc_nRecno, loc_cSQL, loc_nQueryOk

        TRY
            IF !USED("CsSigCqChi")
                RETURN
            ENDIF

            SELECT CsSigCqChi
            loc_nRecno = RECNO()

            IF USED("TmpChi")
                USE IN TmpChi
            ENDIF

            SELECT DISTINCT bancos ;
              FROM CsSigCqChi ;
             WHERE NMarca1s = 1 ;
              INTO CURSOR TmpChi

            SELECT TmpChi
            GO TOP

            IF !EOF()
                IF RECCOUNT("TmpChi") > 1
                    MsgAviso("Todos os cheques selecionados devem ser do mesmo banco.", "Aten" + CHR(231) + CHR(227) + "o")
                    SELECT CsSigCqChi
                    GOTO loc_nRecno
                    THIS.grd_4c_Dados.SetFocus
                    RETURN
                ENDIF

                SELECT bancos, valors, ncheques, datas, NEmitidos, NCancelas, favos ;
                  FROM CsSigCqChi ;
                 WHERE NMarca1s = 1 ;
                 ORDER BY bancos, ncheques ;
                  INTO CURSOR CrCheque

                SELECT CrCheque
                LOCATE FOR NEmitidos = 1
                IF FOUND()
                    IF MsgConfirma("Os cheques selecionados j" + CHR(225) + " foram emitidos. " + ;
                                   "Confirma impress" + CHR(227) + "o?", ;
                                   "Aten" + CHR(231) + CHR(227) + "o")
                        MsgAviso("Verifique se a impressora est" + CHR(225) + ;
                                 " pronta para impress" + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        IF USED("CrCheque")
                            USE IN CrCheque
                        ENDIF
                        RETURN
                    ENDIF
                ELSE
                    MsgAviso("Verifique se a impressora est" + CHR(225) + ;
                             " pronta para impress" + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF

                GO TOP

                DO SigIpChq.prg WITH THIS

                PUBLIC xImpOk
                IF TYPE("xImpOk") = "L" AND xImpOk
                    SELECT CrCheque
                    GO TOP
                    SCAN
                        PRIVATE pBancos2, pNCheques2
                        pBancos2   = CrCheque.bancos
                        pNCheques2 = CrCheque.ncheques
                        loc_cSQL   = "UPDATE SigCqChi SET emitidos = 1" + ;
                                     " WHERE bancos = ?pBancos2 AND ncheques = ?pNCheques2"
                        loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nQueryOk < 1
                            MsgErro("Falha ao atualizar emissao.", "Erro")
                            RETURN
                        ENDIF
                        UPDATE CsSigCqChi SET NEmitidos = 1 ;
                          WHERE bancos = CrCheque.bancos AND ncheques = CrCheque.ncheques
                        SELECT CrCheque
                    ENDSCAN
                    THIS.this_oBusinessObject.Commit()
                ENDIF

                IF USED("CrCheque")
                    USE IN CrCheque
                ENDIF
                SELECT CsSigCqChi
                GOTO loc_nRecno
                THIS.grd_4c_Dados.Refresh
            ELSE
                *-- Nenhum cheque marcado: abrir painel de faixa matricial
                THIS.this_lChMatIni = .T.
                THIS.AtivarImpChmat()
            ENDIF

            IF USED("TmpChi")
                USE IN TmpChi
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em Chq. Matric.")
        ENDTRY
    ENDPROC

    *-- Ativa painel cnt_4c_Impchmat (equivalente ao impchmat.Init do legado)
    PROCEDURE AtivarImpChmat()
        IF !THIS.this_lChMatIni
            RETURN
        ENDIF

        THIS.LockScreen = .T.
        THIS.this_lChMatIni = .F.

        THIS.cnt_4c_Impchmat.txt_4c_Banco.Value = ""
        THIS.cnt_4c_Impchmat.txt_4c_Chini.Value = ""
        THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value = ""

        THIS.obj_4c_CmdGok.Enabled        = .F.
        THIS.cnt_4c_Impchmat.Enabled       = .T.
        THIS.cnt_4c_Impchmat.Visible       = .T.
        THIS.cnt_4c_Impchmat.txt_4c_Banco.SetFocus
        THIS.Refresh
        THIS.LockScreen = .F.
    ENDPROC

    *-- Botao 9: Excluir Chq. (exclui cheque cancelado)
    PROCEDURE BtnExcluirChqClick()
        LOCAL loc_cSQL, loc_nQueryOk, loc_cMensa

        IF USED("CsSigCqChi") AND !EOF("CsSigCqChi") AND ;
           CsSigCqChi.NCancelas = 1 AND THIS.this_lExcluirCheque
            IF MsgConfirma("Deseja realmente excluir o cheque :" + CHR(13) + ;
                           CsSigCqChi.bancos + " / " + CsSigCqChi.agencias + ;
                           " / " + CsSigCqChi.ncontas + " / " + CsSigCqChi.ncheques + " ?", ;
                           "Exclus" + CHR(227) + "o de cheque cancelado")

                PRIVATE pCidChaveDel
                pCidChaveDel = CsSigCqChi.cidchaves
                loc_cSQL     = "DELETE FROM SigCqChi WHERE cidchaves = ?pCidChaveDel"
                loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nQueryOk >= 1
                    THIS.this_oBusinessObject.Commit()
                    SELECT CsSigCqChi
                    DELETE
                    THIS.grd_4c_Dados.Refresh
                ELSE
                    MsgErro("Falha ao excluir cheque.", "Erro")
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    *  Handlers dos campos de filtro
    *==========================================================================

    *-- CdGrupos: salva valor ao entrar
    PROCEDURE CdGruposGotFocus()
        THIS.this_cAntCdGrupo = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
    ENDPROC

    *-- CdGrupos: valida ao sair (ENTER/TAB)
    PROCEDURE CdGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_nQueryOk

        IF par_nKeyCode <> 13 AND par_nKeyCode <> 9 AND par_nKeyCode <> 115
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.txt_4c_CdGrupos.Value)

        IF !EMPTY(loc_cValor)
            PRIVATE pGrupoVal
            pGrupoVal = loc_cValor
            IF USED("cursor_4c_GrupoValida")
                USE IN cursor_4c_GrupoValida
            ENDIF
            loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = ?pGrupoVal", ;
                "cursor_4c_GrupoValida")
            IF loc_nQueryOk >= 1 AND !EOF("cursor_4c_GrupoValida")
                THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_GrupoValida.Descrs)
                USE IN cursor_4c_GrupoValida
            ELSE
                IF USED("cursor_4c_GrupoValida")
                    USE IN cursor_4c_GrupoValida
                ENDIF
                MsgAviso("Grupo n" + CHR(227) + "o encontrado!", "")
                THIS.txt_4c_CdGrupos.Value = ""
                THIS.txt_4c_DsGrupos.Value = ""
            ENDIF
        ELSE
            THIS.txt_4c_DsGrupos.Value = ""
        ENDIF

        IF ALLTRIM(THIS.txt_4c_CdGrupos.Value) <> THIS.this_cAntCdGrupo
            IF USED("CsSigCqChi")
                ZAP IN CsSigCqChi
                THIS.grd_4c_Dados.Refresh
            ENDIF
        ENDIF
    ENDPROC

    *-- DsGrupos: salva valor ao entrar; somente editavel quando CdGrupos estiver vazio
    PROCEDURE DsGruposGotFocus()
        THIS.this_cAntDsGrupo = ALLTRIM(THIS.txt_4c_DsGrupos.Value)
        IF !EMPTY(ALLTRIM(THIS.txt_4c_CdGrupos.Value))
            THIS.txt_4c_CdGrupos.SetFocus
        ENDIF
    ENDPROC

    *-- DsGrupos: valida ao sair por descricao
    PROCEDURE DsGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_nQueryOk

        IF par_nKeyCode <> 13 AND par_nKeyCode <> 9 AND par_nKeyCode <> 115
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.txt_4c_DsGrupos.Value)

        IF !EMPTY(loc_cValor)
            PRIVATE pGrupoDesc
            pGrupoDesc = loc_cValor + "%"
            IF USED("cursor_4c_GrupoValida")
                USE IN cursor_4c_GrupoValida
            ENDIF
            loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos, Descrs FROM SigCdGcr WHERE Descrs LIKE ?pGrupoDesc", ;
                "cursor_4c_GrupoValida")
            IF loc_nQueryOk >= 1 AND !EOF("cursor_4c_GrupoValida")
                THIS.txt_4c_CdGrupos.Value = ALLTRIM(cursor_4c_GrupoValida.Codigos)
                THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_GrupoValida.Descrs)
                USE IN cursor_4c_GrupoValida
            ELSE
                IF USED("cursor_4c_GrupoValida")
                    USE IN cursor_4c_GrupoValida
                ENDIF
                MsgAviso("Grupo n" + CHR(227) + "o encontrado!", "")
                THIS.txt_4c_CdGrupos.Value = ""
                THIS.txt_4c_DsGrupos.Value = ""
            ENDIF
        ELSE
            THIS.txt_4c_CdGrupos.Value = ""
        ENDIF

        IF ALLTRIM(THIS.txt_4c_DsGrupos.Value) <> THIS.this_cAntDsGrupo
            IF USED("CsSigCqChi")
                ZAP IN CsSigCqChi
                THIS.grd_4c_Dados.Refresh
            ENDIF
        ENDIF
    ENDPROC

    *-- CdContas: salva valor ao entrar
    PROCEDURE CdContasGotFocus()
        THIS.this_cAntCdConta = ALLTRIM(THIS.txt_4c_CdContas.Value)
    ENDPROC

    *-- CdContas: valida ao sair
    PROCEDURE CdContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor

        IF par_nKeyCode <> 13 AND par_nKeyCode <> 9 AND par_nKeyCode <> 115
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.txt_4c_CdContas.Value)

        IF !EMPTY(loc_cValor)
            IF USED("CrContas") AND SEEK(loc_cValor, "CrContas", "IClis")
                THIS.txt_4c_DsContas.Value = ALLTRIM(CrContas.RClis)
            ELSE
                MsgAviso("Conta n" + CHR(227) + "o encontrada!", "")
                THIS.txt_4c_CdContas.Value = ""
                THIS.txt_4c_DsContas.Value = ""
            ENDIF
        ELSE
            THIS.txt_4c_DsContas.Value = ""
        ENDIF

        IF ALLTRIM(THIS.txt_4c_CdContas.Value) <> THIS.this_cAntCdConta
            IF USED("CsSigCqChi")
                ZAP IN CsSigCqChi
                THIS.grd_4c_Dados.Refresh
            ENDIF
        ENDIF
    ENDPROC

    *-- DsContas: salva valor ao entrar; somente editavel quando CdContas vazio
    PROCEDURE DsContasGotFocus()
        THIS.this_cAntDsConta = ALLTRIM(THIS.txt_4c_DsContas.Value)
        IF !EMPTY(ALLTRIM(THIS.txt_4c_CdContas.Value))
            THIS.txt_4c_CdContas.SetFocus
        ENDIF
    ENDPROC

    *-- DsContas: valida ao sair por nome da conta
    PROCEDURE DsContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor

        IF par_nKeyCode <> 13 AND par_nKeyCode <> 9 AND par_nKeyCode <> 115
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.txt_4c_DsContas.Value)

        IF !EMPTY(loc_cValor)
            IF USED("CrContas") AND SEEK(loc_cValor, "CrContas", "RClis")
                THIS.txt_4c_CdContas.Value = ALLTRIM(CrContas.IClis)
                THIS.txt_4c_DsContas.Value = ALLTRIM(CrContas.RClis)
            ELSE
                MsgAviso("Conta n" + CHR(227) + "o encontrada!", "")
                THIS.txt_4c_CdContas.Value = ""
                THIS.txt_4c_DsContas.Value = ""
            ENDIF
        ELSE
            THIS.txt_4c_CdContas.Value = ""
        ENDIF

        IF ALLTRIM(THIS.txt_4c_DsContas.Value) <> THIS.this_cAntDsConta
            IF USED("CsSigCqChi")
                ZAP IN CsSigCqChi
                THIS.grd_4c_Dados.Refresh
            ENDIF
        ENDIF
    ENDPROC

    *-- DtInicial: salva data ao entrar
    PROCEDURE DtInicialGotFocus()
        THIS.this_dAntDtIni = THIS.txt_4c_Dt_inicial.Value
    ENDPROC

    *-- DtInicial: valida ao sair
    PROCEDURE DtInicialKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
            RETURN
        ENDIF
        IF THIS.txt_4c_Dt_inicial.Value > THIS.txt_4c_Dt_final.Value
            THIS.txt_4c_Dt_final.Value = THIS.txt_4c_Dt_inicial.Value
        ENDIF
        IF THIS.txt_4c_Dt_inicial.Value <> THIS.this_dAntDtIni
            IF USED("CsSigCqChi")
                ZAP IN CsSigCqChi
                THIS.grd_4c_Dados.Refresh
            ENDIF
        ENDIF
    ENDPROC

    *-- DtFinal: salva data ao entrar
    PROCEDURE DtFinalGotFocus()
        THIS.this_dAntDtFin = THIS.txt_4c_Dt_final.Value
    ENDPROC

    *-- DtFinal: valida ao sair
    PROCEDURE DtFinalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
            RETURN
        ENDIF
        IF THIS.txt_4c_Dt_final.Value < THIS.txt_4c_Dt_inicial.Value
            THIS.txt_4c_Dt_inicial.Value = THIS.txt_4c_Dt_final.Value
        ENDIF
        IF THIS.txt_4c_Dt_final.Value <> THIS.this_dAntDtFin
            IF USED("CsSigCqChi")
                ZAP IN CsSigCqChi
                THIS.grd_4c_Dados.Refresh
            ENDIF
        ENDIF
    ENDPROC

    *-- Botao Desmarcar Todos
    PROCEDURE CmdApaga1Click()
        LOCAL loc_nRecno

        IF !USED("CsSigCqChi")
            RETURN
        ENDIF
        loc_nRecno = RECNO("CsSigCqChi")
        UPDATE CsSigCqChi SET NMarca1s = 0 WHERE NMarca1s = 1
        IF BETWEEN(loc_nRecno, 1, RECCOUNT("CsSigCqChi"))
            GOTO loc_nRecno IN CsSigCqChi
        ENDIF
        THIS.grd_4c_Dados.Refresh
    ENDPROC

    *-- Botao Marcar Todos
    PROCEDURE CmdTudo1Click()
        LOCAL loc_nRecno

        IF !USED("CsSigCqChi")
            RETURN
        ENDIF
        loc_nRecno = RECNO("CsSigCqChi")
        UPDATE CsSigCqChi SET NMarca1s = 1 WHERE NMarca1s = 0 AND NEmitidos = 0 AND NCancelas = 0
        IF BETWEEN(loc_nRecno, 1, RECCOUNT("CsSigCqChi"))
            GOTO loc_nRecno IN CsSigCqChi
        ENDIF
        THIS.grd_4c_Dados.Refresh
    ENDPROC

    *-- Botao Processar
    PROCEDURE Command2Click()
        IF THIS.txt_4c_Dt_inicial.Value > THIS.txt_4c_Dt_final.Value
            MsgAviso("Data Final menor que Data Inicial !!!", "Per" + CHR(237) + "odo Inv" + CHR(225) + "lido")
            THIS.txt_4c_Dt_inicial.SetFocus
            RETURN
        ENDIF

        IF THIS.this_dAntDtIni <> THIS.txt_4c_Dt_inicial.Value OR ;
           THIS.this_dAntDtFin <> THIS.txt_4c_Dt_final.Value OR ;
           THIS.this_cAntCdGrupo <> ALLTRIM(THIS.txt_4c_CdGrupos.Value) OR ;
           THIS.this_cAntCdConta <> ALLTRIM(THIS.txt_4c_CdContas.Value)

            IF !THIS.MontaChq(.F.)
                MsgErro("Falha ao processar cheques.", "Erro")
                RETURN
            ENDIF

            THIS.this_dAntDtIni    = THIS.txt_4c_Dt_inicial.Value
            THIS.this_dAntDtFin    = THIS.txt_4c_Dt_final.Value
            THIS.this_cAntCdGrupo  = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
            THIS.this_cAntCdConta  = ALLTRIM(THIS.txt_4c_CdContas.Value)
        ENDIF

        THIS.grd_4c_Dados.Column2.SetFocus
    ENDPROC

    *==========================================================================
    *  Handlers do container cnt_4c_Justificativa
    *==========================================================================
    PROCEDURE CmdGconfClick()
        LOCAL loc_nRecno

        DO CASE
        CASE THIS.cnt_4c_Justificativa.obj_4c_CmdGconf.Value = 1  && Confirmar

            IF EMPTY(ALLTRIM(THIS.cnt_4c_Justificativa.obj_4c_Get_justificativa.Value))
                MsgAviso("Justificativa em branco!", "Aten" + CHR(231) + CHR(227) + "o")
                THIS.cnt_4c_Justificativa.obj_4c_Get_justificativa.SetFocus
                RETURN
            ENDIF

            THIS.LockScreen = .T.

            TRY
                IF USED("CsSigCqChi") AND !EOF("CsSigCqChi")
                    loc_nRecno = RECNO("CsSigCqChi")
                    THIS.Enabled = .F.
                    DO FORM SigCdPgr WITH LEFT(CsSigCqChi.dopes, 1), .F., ;
                        CsSigCqChi.emps, CsSigCqChi.dopes, CsSigCqChi.numes, .T., THIS, ;
                        ALLTRIM(THIS.cnt_4c_Justificativa.obj_4c_Get_justificativa.Value)
                    SigCdPgr.AlwaysOnTop = .T.
                ELSE
                    THIS.MExibeCheques(.T.)
                ENDIF
            CATCH TO loc_oErro
                THIS.Enabled = .T.
                MsgErro(loc_oErro.Message, "Erro ao confirmar cancelamento")
            ENDTRY

            THIS.LockScreen = .F.

        CASE THIS.cnt_4c_Justificativa.obj_4c_CmdGconf.Value = 2  && Cancelar
            THIS.cnt_4c_Justificativa.obj_4c_CmdGconf.Enabled = .F.
            THIS.cnt_4c_Justificativa.Visible = .F.
        ENDCASE
    ENDPROC

    *==========================================================================
    *  Handlers do container cnt_4c_Impchmat (impressao matricial por faixa)
    *==========================================================================
    PROCEDURE ImpchmatBancoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        *-- Leitor CMC-7: inicia captura em < (60) e finaliza em : (58)
        IF par_nKeyCode = 60
            IF !THIS.this_lLeCheque
                THIS.this_cChqLido = ""
            ENDIF
            THIS.this_lLeCheque = .T.
        ENDIF
        IF THIS.this_lLeCheque
            THIS.this_cChqLido = THIS.this_cChqLido + CHR(par_nKeyCode)
        ENDIF
        IF par_nKeyCode = 58
            THIS.this_lLeCheque = .F.
        ENDIF
    ENDPROC

    PROCEDURE ImpchmatChiniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.cnt_4c_Impchmat.txt_4c_Chini.Value = ;
                PADL(ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chini.Value), 6, "0")
        ENDIF
    ENDPROC

    PROCEDURE ImpchmatChfinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value = ;
                PADL(ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value), 6, "0")
        ENDIF
    ENDPROC

    PROCEDURE ImpchmatCmdGprocurarClick()
        DO CASE
        CASE THIS.cnt_4c_Impchmat.obj_4c_CmdGprocurar.Value = 1  && Imprimir
            THIS.ImpchmatImprimirClick()
        CASE THIS.cnt_4c_Impchmat.obj_4c_CmdGprocurar.Value = 2  && Encerrar
            THIS.ImpchmatEncerrarClick()
        ENDCASE
    ENDPROC

    PROCEDURE ImpchmatImprimirClick()
        LOCAL loc_cBanco, loc_cChIni, loc_cChFin

        loc_cBanco = ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Banco.Value)
        loc_cChIni = ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chini.Value)
        loc_cChFin = ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value)

        IF EMPTY(loc_cBanco)
            MsgAviso("Banco n" + CHR(227) + "o preenchido !!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Impchmat.txt_4c_Banco.SetFocus
            RETURN
        ENDIF
        IF EMPTY(loc_cChIni)
            MsgAviso("N" + CHR(250) + "mero do cheque inicial n" + CHR(227) + "o preenchido !!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Impchmat.txt_4c_Chini.SetFocus
            RETURN
        ENDIF
        IF EMPTY(loc_cChFin)
            MsgAviso("N" + CHR(250) + "mero do cheque final n" + CHR(227) + "o preenchido !!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Impchmat.txt_4c_Chfin.SetFocus
            RETURN
        ENDIF
        IF loc_cChFin < loc_cChIni
            MsgAviso("N" + CHR(250) + "mero do cheque final menor que o inicial !!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Impchmat.txt_4c_Chini.SetFocus
            RETURN
        ENDIF

        TRY
            IF USED("CrCheque")
                USE IN CrCheque
            ENDIF

            PRIVATE pBancoFil, pChIniFil, pChFinFil
            pBancoFil = loc_cBanco
            pChIniFil = loc_cChIni
            pChFinFil = loc_cChFin

            SELECT bancos, valors, ncheques, datas, favos, NEmitidos ;
              FROM CsSigCqChi ;
             WHERE bancos = ?pBancoFil ;
               AND ncheques BETWEEN ?pChIniFil AND ?pChFinFil ;
               AND NCancelas = 0 ;
             ORDER BY bancos, ncheques ;
              INTO CURSOR CrCheque

            SELECT CrCheque
            LOCATE FOR NEmitidos = 1
            IF FOUND()
                IF !MsgConfirma("Os cheques selecionados j" + CHR(225) + " foram emitidos. " + ;
                                "Confirma impress" + CHR(227) + "o?", ;
                                "Aten" + CHR(231) + CHR(227) + "o")
                    USE IN CrCheque
                    RETURN
                ENDIF
            ENDIF

            GO TOP
            MsgAviso("Verificar se a impressora est" + CHR(225) + ;
                     " pronta para impress" + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")

            DO SigIpChq.prg

            PUBLIC xImpOk
            IF TYPE("xImpOk") = "L" AND xImpOk
                LOCAL loc_cSQL, loc_nQueryOk
                SELECT CrCheque
                SCAN
                    PRIVATE pBancoUpd, pNChequeUpd
                    pBancoUpd   = CrCheque.bancos
                    pNChequeUpd = CrCheque.ncheques
                    loc_cSQL = "UPDATE SigCqChi SET emitidos = 1" + ;
                               " WHERE bancos = ?pBancoUpd AND ncheques = ?pNChequeUpd"
                    loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nQueryOk < 1
                        MsgErro("Falha ao atualizar emissao.", "Erro")
                        EXIT
                    ENDIF
                    SELECT CrCheque
                ENDSCAN
            ENDIF

            IF USED("CrCheque")
                USE IN CrCheque
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro na impressao matricial")
        ENDTRY
    ENDPROC

    PROCEDURE ImpchmatEncerrarClick()
        THIS.LockScreen = .T.
        THIS.obj_4c_CmdGok.Enabled   = .T.
        THIS.cnt_4c_Impchmat.Enabled  = .F.
        THIS.cnt_4c_Impchmat.Visible  = .F.
        THIS.MExibeCheques(.F.)
        THIS.LockScreen = .F.
    ENDPROC

    *==========================================================================
    *  Handlers do container cnt_4c_Procurar (busca por criterios)
    *==========================================================================
    PROCEDURE ProcurarBancoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        *-- Leitor CMC-7: inicia em < (60), encerra em : (58)
        IF par_nKeyCode = 60
            IF !THIS.this_lLeCheque
                THIS.this_cChqLido = ""
            ENDIF
            THIS.this_lLeCheque = .T.
        ENDIF
        IF THIS.this_lLeCheque
            THIS.this_cChqLido = THIS.this_cChqLido + CHR(par_nKeyCode)
        ENDIF
        IF par_nKeyCode = 58
            THIS.this_lLeCheque = .F.
            *-- Processar leitura CMC-7 se codigo completo (>= 33 chars)
            IF LEN(THIS.this_cChqLido) >= 33
                THIS.cnt_4c_Procurar.txt_4c_Banco.Value   = SUBSTR(THIS.this_cChqLido, 2, 3)
                THIS.cnt_4c_Procurar.txt_4c_Agencia.Value = SUBSTR(THIS.this_cChqLido, 5, 4)
                THIS.cnt_4c_Procurar.txt_4c_Conta.Value   = SUBSTR(THIS.this_cChqLido, 23, 10)
                THIS.cnt_4c_Procurar.txt_4c_Cheque.Value  = SUBSTR(THIS.this_cChqLido, 14, 6)
                THIS.Refresh
                THIS.ProcurarPesquisarClick()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ProcurarEmissaoGotFocus()
        *-- Mutualmente exclusivo com Valor: somente editavel se Valor vazio
        IF !EMPTY(TRANSFORM(THIS.cnt_4c_Procurar.txt_4c_Valor.Value))
            THIS.cnt_4c_Procurar.txt_4c_Valor.SetFocus
        ENDIF
    ENDPROC

    PROCEDURE ProcurarValorGotFocus()
        *-- Mutualmente exclusivo com Emissao: somente editavel se Emissao vazia
        IF !EMPTY(THIS.cnt_4c_Procurar.txt_4c_Emissao.Value)
            THIS.cnt_4c_Procurar.txt_4c_Emissao.SetFocus
        ENDIF
    ENDPROC

    PROCEDURE ProcurarCmdgprocurarClick()
        DO CASE
        CASE THIS.cnt_4c_Procurar.obj_4c_Cmdgprocurar.Value = 1  && Pesquisar
            THIS.ProcurarPesquisarClick()
        CASE THIS.cnt_4c_Procurar.obj_4c_Cmdgprocurar.Value = 2  && Cancelar/Encerrar
            THIS.ProcurarCancelarClick()
        ENDCASE
    ENDPROC

    PROCEDURE ProcurarPesquisarClick()
        LOCAL loc_cBanco, loc_cAgencia, loc_cConta, loc_cCheque
        LOCAL loc_dEmissao, loc_nValor

        loc_cBanco   = PADR(ALLTRIM(THIS.cnt_4c_Procurar.txt_4c_Banco.Value), 3)
        loc_cAgencia = ALLTRIM(THIS.cnt_4c_Procurar.txt_4c_Agencia.Value)
        loc_cConta   = ALLTRIM(THIS.cnt_4c_Procurar.txt_4c_Conta.Value)
        loc_cCheque  = ALLTRIM(THIS.cnt_4c_Procurar.txt_4c_Cheque.Value)
        loc_dEmissao = THIS.cnt_4c_Procurar.txt_4c_Emissao.Value
        loc_nValor   = THIS.cnt_4c_Procurar.txt_4c_Valor.Value

        SET NEAR ON
        SELECT CsSigCqChi

        DO CASE
        CASE !EMPTY(loc_dEmissao) AND VARTYPE(loc_dEmissao) = "D"
            SET ORDER TO Emissao
            SEEK DTOS(loc_dEmissao) + loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
        CASE loc_nValor <> 0
            SET ORDER TO Valor
            SEEK STR(loc_nValor, 12, 2) + loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
        CASE !EMPTY(loc_cBanco)
            SET ORDER TO Cheque
            SEEK loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
        CASE !EMPTY(loc_cAgencia)
            SET ORDER TO Agencia
            SEEK loc_cAgencia + loc_cConta + loc_cCheque
        CASE !EMPTY(loc_cConta)
            SET ORDER TO Conta
            SEEK loc_cConta + loc_cCheque
        CASE !EMPTY(loc_cCheque)
            SET ORDER TO NCheques
            SEEK loc_cCheque
        ENDCASE

        SET NEAR OFF

        THIS.LockScreen = .T.
        THIS.txt_4c_CdContas.Enabled      = .T.
        THIS.txt_4c_DsContas.Enabled      = .T.
        THIS.grd_4c_Dados.Enabled         = .T.
        THIS.txt_4c_TxtFavorecido.Enabled = .T.
        THIS.obj_4c_CmdGok.Enabled        = .T.
        THIS.cnt_4c_Procurar.Enabled      = .F.
        THIS.cnt_4c_Procurar.Visible      = .F.
        THIS.MExibeCheques(.F.)
        THIS.LockScreen = .F.
    ENDPROC

    PROCEDURE ProcurarCancelarClick()
        THIS.LockScreen = .T.
        THIS.txt_4c_CdContas.Enabled      = .T.
        THIS.txt_4c_DsContas.Enabled      = .T.
        THIS.grd_4c_Dados.Enabled         = .T.
        THIS.txt_4c_TxtFavorecido.Enabled = .T.
        THIS.obj_4c_CmdGok.Enabled        = .T.
        THIS.cnt_4c_Procurar.Enabled      = .F.
        THIS.cnt_4c_Procurar.Visible      = .F.
        THIS.MExibeCheques(.F.)
        THIS.LockScreen = .F.
    ENDPROC

    *==========================================================================
    *  Eventos principais dos botoes (mapeamento operacional CRUD)
    *  FormSigPrChr eh OPERACIONAL (processamento de cheques recebidos):
    *   - Incluir     -> ativar container Impchmat (entrada manual de faixa
    *                    de cheques por banco + cheque inicial/final)
    *   - Alterar     -> abrir SigCdPgr para edicao do documento associado
    *   - Visualizar  -> abrir SigReEch (visualizacao/impressao do cheque)
    *   - Excluir     -> excluir cheque cancelado selecionado no grid
    *==========================================================================

    *-- Incluir: ativa container de entrada manual (impchmat) para faixa de cheques
    PROCEDURE BtnIncluirClick()
        TRY
            IF EMPTY(THIS.txt_4c_CdContas.Value)
                MsgAviso("Selecione uma conta antes de incluir cheques.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                THIS.txt_4c_CdContas.SetFocus
                RETURN
            ENDIF
            THIS.this_lChMatIni = .T.
            THIS.AtivarImpChmat()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em Incluir")
        ENDTRY
    ENDPROC

    *-- Alterar: abre SigCdPgr do documento vinculado ao cheque corrente
    PROCEDURE BtnAlterarClick()
        LOCAL loc_nRecno, loc_cEDNs, loc_lTemQuery

        TRY
            IF !USED("CsSigCqChi") OR EOF("CsSigCqChi")
                MsgAviso("Nenhum cheque selecionado para alterar.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            IF CsSigCqChi.NCancelas <> 0
                MsgAviso("Cheque cancelado nao pode ser alterado.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            THIS.LockScreen = .T.
            loc_nRecno = RECNO("CsSigCqChi")
            loc_cEDNs  = CsSigCqChi.emps + CsSigCqChi.dopes + STR(CsSigCqChi.numes, 6)

            loc_lTemQuery = .F.
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
               PEMSTATUS(THIS.this_oBusinessObject, "CursorQuery", 5)
                loc_lTemQuery = THIS.this_oBusinessObject.CursorQuery("SigCdPgr", "", "empdopnums", loc_cEDNs)
            ELSE
                loc_lTemQuery = .T.
            ENDIF

            IF loc_lTemQuery
                DO FORM SigCdPgr WITH LEFT(CsSigCqChi.dopes, 1), .T., ;
                    CsSigCqChi.emps, CsSigCqChi.dopes, CsSigCqChi.numes
                IF TYPE("SigCdPgr") = "O"
                    SigCdPgr.AlwaysOnTop = .T.
                ENDIF
                IF BETWEEN(loc_nRecno, 1, RECCOUNT("CsSigCqChi"))
                    GOTO loc_nRecno IN CsSigCqChi
                ENDIF
                THIS.MExibeCheques(.F.)
            ELSE
                MsgAviso("Documento associado ao cheque nao encontrado.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF

            THIS.LockScreen = .F.
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message, "Erro em Alterar")
        ENDTRY
    ENDPROC

    *-- Visualizar: abre SigReEch em modo CONSULTAR (visualizacao do cheque)
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lCarrega

        TRY
            IF !USED("CsSigCqChi") OR EOF("CsSigCqChi")
                MsgAviso("Nenhum cheque selecionado para visualizar.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            loc_lCarrega = THIS.CarregaConta()
            IF loc_lCarrega
                DO FORM SigReEch WITH CsSigCqChi.emps, CsSigCqChi.dopes, ;
                    CsSigCqChi.numes, "CONSULTAR", CsSigCqChi.ncheques
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em Visualizar")
        ENDTRY
    ENDPROC

    *-- Excluir: exclui cheque cancelado selecionado
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cSQL, loc_nQueryOk, loc_cMensa

        TRY
            IF !USED("CsSigCqChi") OR EOF("CsSigCqChi")
                MsgAviso("Nenhum cheque selecionado para excluir.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            IF CsSigCqChi.NCancelas <> 1
                MsgAviso("Apenas cheques cancelados podem ser exclu" + CHR(237) + "dos.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            IF !THIS.this_lExcluirCheque
                MsgAviso("Acesso negado para exclus" + CHR(227) + "o de cheques.", ;
                         "Acesso Negado")
                RETURN
            ENDIF

            IF MsgConfirma("Deseja realmente excluir o cheque:" + CHR(13) + ;
                           CsSigCqChi.bancos + " / " + CsSigCqChi.agencias + ;
                           " / " + CsSigCqChi.ncontas + " / " + CsSigCqChi.ncheques + " ?", ;
                           "Exclus" + CHR(227) + "o de cheque cancelado")

                PRIVATE pCidChaveDel
                pCidChaveDel = CsSigCqChi.cidchaves
                loc_cSQL     = "DELETE FROM SigCqChi WHERE cidchaves = ?pCidChaveDel"
                loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nQueryOk >= 1
                    THIS.this_oBusinessObject.Commit()
                    loc_cMensa = "Exclus" + CHR(227) + "o do cheque cancelado: " + ;
                                 CsSigCqChi.bancos + "/" + CsSigCqChi.agencias + ;
                                 "/" + CsSigCqChi.ncontas + "/" + CsSigCqChi.ncheques
                    SELECT CsSigCqChi
                    DELETE
                    THIS.grd_4c_Dados.Refresh
                    MsgInfo("Cheque exclu" + CHR(237) + "do com sucesso.", ;
                            "Exclus" + CHR(227) + "o")
                ELSE
                    MsgErro("Falha ao excluir cheque.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em Excluir")
        ENDTRY
    ENDPROC

    *==========================================================================
    *  FASE 8/8 - Metodos auxiliares e consolidacao final
    *==========================================================================

    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
    *  Carrega/atualiza o grid de cheques conforme filtros ativos.
    *--------------------------------------------------------------------------
        THIS.MontaChq(.F.)
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
    *  Alias do botao Processar: recarrega os cheques conforme filtros atuais.
    *--------------------------------------------------------------------------
        THIS.Command2Click()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
    *  Form OPERACIONAL: nao ha CRUD de tabela unica. Confirma transacoes
    *  em aberto e atualiza o grid para refletir o estado atual do cursor.
    *--------------------------------------------------------------------------
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.CommitTransacao()
            ENDIF
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Refresh
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao salvar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
    *  Cancela operacao corrente: fecha containers flutuantes e volta a vista principal.
    *--------------------------------------------------------------------------
        IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5) AND THIS.cnt_4c_Procurar.Visible
            THIS.ProcurarCancelarClick()
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Impchmat", 5) AND THIS.cnt_4c_Impchmat.Visible
            THIS.ImpchmatEncerrarClick()
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Justificativa", 5) AND THIS.cnt_4c_Justificativa.Visible
            THIS.cnt_4c_Justificativa.obj_4c_CmdGconf.Enabled = .F.
            THIS.cnt_4c_Justificativa.Visible = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
    *  Transfere filtros ativos do form para as propriedades do BO.
    *--------------------------------------------------------------------------
        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            RETURN
        ENDIF

        WITH THIS.this_oBusinessObject
            .this_dDtInicial  = THIS.txt_4c_Dt_inicial.Value
            .this_dDtFinal    = THIS.txt_4c_Dt_final.Value
            .this_cCdGrupo    = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
            .this_cDsGrupo    = ALLTRIM(THIS.txt_4c_DsGrupos.Value)
            .this_cCdConta    = ALLTRIM(THIS.txt_4c_CdContas.Value)
            .this_cDsConta    = ALLTRIM(THIS.txt_4c_DsContas.Value)

            *-- Painel Impchmat
            IF PEMSTATUS(THIS, "cnt_4c_Impchmat", 5)
                .this_cBancoMat = ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Banco.Value)
                .this_cChIniMat = ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chini.Value)
                .this_cChFinMat = ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value)
            ENDIF

            *-- Painel Procurar
            IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5)
                .this_cBancoPrc   = ALLTRIM(THIS.cnt_4c_Procurar.txt_4c_Banco.Value)
                .this_cAgenciaPrc = ALLTRIM(THIS.cnt_4c_Procurar.txt_4c_Agencia.Value)
                .this_cContaPrc   = ALLTRIM(THIS.cnt_4c_Procurar.txt_4c_Conta.Value)
                .this_cChequePrc  = ALLTRIM(THIS.cnt_4c_Procurar.txt_4c_Cheque.Value)
                .this_dEmissaoPrc = THIS.cnt_4c_Procurar.txt_4c_Emissao.Value
                .this_nValorPrc   = THIS.cnt_4c_Procurar.txt_4c_Valor.Value
            ENDIF

            *-- Cheque selecionado no grid
            IF USED("CsSigCqChi") AND !EOF("CsSigCqChi")
                .this_cEmps       = NVL(CsSigCqChi.emps, "")
                .this_cDopes      = NVL(CsSigCqChi.dopes, "")
                .this_cNumes      = NVL(STR(CsSigCqChi.numes, 6), "")
                .this_dDatas      = NVL(CsSigCqChi.datas, {})
                .this_cBancos     = NVL(CsSigCqChi.bancos, "")
                .this_cAgencias   = NVL(CsSigCqChi.agencias, "")
                .this_cNcontas    = NVL(CsSigCqChi.ncontas, "")
                .this_cNcheques   = NVL(CsSigCqChi.ncheques, "")
                .this_cContas     = NVL(CsSigCqChi.contas, "")
                .this_nValors     = NVL(CsSigCqChi.valors, 0)
                .this_cFavos      = NVL(CsSigCqChi.favos, "")
                .this_nNcopias    = NVL(CsSigCqChi.ncopias, 0)
                .this_nNemitidos  = NVL(CsSigCqChi.NEmitidos, 0)
                .this_nNcancelas  = NVL(CsSigCqChi.NCancelas, 0)
                .this_nNmarca1s   = NVL(CsSigCqChi.NMarca1s, 0)
                .this_cCidchaves  = NVL(CsSigCqChi.cidchaves, "")
                .this_cJustCanc   = NVL(CsSigCqChi.JustCanc, "")
                .this_cEmpDopNums = NVL(CsSigCqChi.emps, "") + ;
                                    NVL(CsSigCqChi.dopes, "") + ;
                                    NVL(STR(CsSigCqChi.numes, 6), "")
            ENDIF
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
    *  Transfere propriedades do BO para os controles do form.
    *--------------------------------------------------------------------------
        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            RETURN
        ENDIF

        WITH THIS.this_oBusinessObject
            THIS.txt_4c_Dt_inicial.Value   = IIF(EMPTY(.this_dDtInicial), DATE(), .this_dDtInicial)
            THIS.txt_4c_Dt_final.Value     = IIF(EMPTY(.this_dDtFinal), DATE(), .this_dDtFinal)
            THIS.txt_4c_CdGrupos.Value     = .this_cCdGrupo
            THIS.txt_4c_DsGrupos.Value     = .this_cDsGrupo
            THIS.txt_4c_CdContas.Value     = .this_cCdConta
            THIS.txt_4c_DsContas.Value     = .this_cDsConta

            IF !EMPTY(.this_cFavos)
                THIS.txt_4c_TxtFavorecido.Value = .this_cFavos
            ENDIF

            IF PEMSTATUS(THIS, "cnt_4c_Impchmat", 5) AND THIS.cnt_4c_Impchmat.Visible
                THIS.cnt_4c_Impchmat.txt_4c_Banco.Value = .this_cBancoMat
                THIS.cnt_4c_Impchmat.txt_4c_Chini.Value = .this_cChIniMat
                THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value = .this_cChFinMat
            ENDIF

            IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5) AND THIS.cnt_4c_Procurar.Visible
                THIS.cnt_4c_Procurar.txt_4c_Banco.Value   = .this_cBancoPrc
                THIS.cnt_4c_Procurar.txt_4c_Agencia.Value = .this_cAgenciaPrc
                THIS.cnt_4c_Procurar.txt_4c_Conta.Value   = .this_cContaPrc
                THIS.cnt_4c_Procurar.txt_4c_Cheque.Value  = .this_cChequePrc
                THIS.cnt_4c_Procurar.txt_4c_Emissao.Value = IIF(EMPTY(.this_dEmissaoPrc), {}, .this_dEmissaoPrc)
                THIS.cnt_4c_Procurar.txt_4c_Valor.Value   = .this_nValorPrc
            ENDIF
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
    *  Habilita ou desabilita os controles de filtro e o grid.
    *--------------------------------------------------------------------------
        LOCAL loc_lHab

        IF TYPE("par_lHabilitar") = "L"
            loc_lHab = par_lHabilitar
        ELSE
            loc_lHab = .T.
        ENDIF

        THIS.txt_4c_CdGrupos.Enabled       = loc_lHab
        THIS.txt_4c_DsGrupos.Enabled       = loc_lHab
        THIS.txt_4c_CdContas.Enabled       = loc_lHab
        THIS.txt_4c_DsContas.Enabled       = loc_lHab
        THIS.txt_4c_Dt_inicial.Enabled     = loc_lHab
        THIS.txt_4c_Dt_final.Enabled       = loc_lHab
        THIS.cmd_4c_Command2.Enabled       = loc_lHab
        THIS.grd_4c_Dados.Enabled          = loc_lHab
        THIS.txt_4c_TxtFavorecido.Enabled  = loc_lHab
        THIS.obj_4c_CmdGok.Enabled         = loc_lHab

        IF loc_lHab
            THIS.cmd_4c_Tudo1.Visible  = .T.
            THIS.cmd_4c_Apaga1.Visible = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
    *  Limpa os filtros e reseta o grid para estado inicial.
    *--------------------------------------------------------------------------
        THIS.txt_4c_CdGrupos.Value      = ""
        THIS.txt_4c_DsGrupos.Value      = ""
        THIS.txt_4c_CdContas.Value      = ""
        THIS.txt_4c_DsContas.Value      = ""
        THIS.txt_4c_Dt_inicial.Value    = DATE()
        THIS.txt_4c_Dt_final.Value      = DATE()
        THIS.txt_4c_TxtFavorecido.Value = ""

        THIS.this_cAntCdGrupo = ""
        THIS.this_cAntDsGrupo = ""
        THIS.this_cAntCdConta = ""
        THIS.this_cAntDsConta = ""
        THIS.this_dAntDtIni   = {}
        THIS.this_dAntDtFin   = {}

        IF USED("CsSigCqChi")
            ZAP IN CsSigCqChi
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
    *  Ajusta os botoes do CommandGroup conforme o cheque selecionado no grid.
    *--------------------------------------------------------------------------
        THIS.AtualizarEstadoGrid()
    ENDPROC

ENDDEFINE
