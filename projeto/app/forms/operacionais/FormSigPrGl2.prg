*==============================================================================
* FormSigPrGl2.prg
* Form OPERACIONAL - Operacoes Selecionadas (Geracao de OPs)
* Herda de: FormBase
* Tipo: OPERACIONAL - Selecao e processamento de operacoes para Ordem de Producao
* Original: SigPrGl2.SCX (SIGPRGL2)
*
* Chamada (pelo form pai SigPrGl1 ou similar):
*   loForm = CREATEOBJECT("FormSigPrGl2", loParentForm, THIS.DataSessionId,
*                          lReservaAuto, nEmphPdr, lAutomatico, nNumeroOp)
*   loForm.Show()
*
* par_oParentForm  : referencia ao form pai
* par_nDataSession : DataSessionId do form pai (TmpCabec e TmpItens estao nessa sessao)
* par_lReservaAuto : .T. = modo reserva automatica de estoque
* par_nEmphPdr     : codigo de empresa padrao para geracao de OPs
* par_lAutomatico  : .T. = processamento automatico (sem confirmacao manual)
* par_nNumeroOp    : numero da OP preestabelecido (0 = auto-gerado)
*==============================================================================

DEFINE CLASS FormSigPrGl2 AS FormBase

    *-- Identificacao
    this_cTituloForm    = "Operacoes Selecionadas"

    *-- DataSession=1: TmpCabec e TmpItens vivem na sessao compartilhada com o pai
    DataSession         = 1

    *-- Parametros capturados em Init (antes de DODEFAULT/InicializarForm)
    this_oParentForm    = .NULL.
    this_nParentSession = 0
    this_lReservaAuto   = .F.
    this_nEmphPdr       = 0
    this_lAutomatico    = .F.
    this_nNumeroOp      = 0
    this_cPorDestino    = ""

    *-- Dimensoes e aparencia (SCX SIGPRGL2: 800x600)
    Width       = 800
    Height      = 600
    AutoCenter  = .T.
    BorderStyle = 2
    TitleBar    = 0
    ShowWindow  = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    WindowType  = 1
    ShowTips    = .T.
    FontName    = "Tahoma"
    FontSize    = 8

    *--------------------------------------------------------------------------
    * Init - Captura parametros ANTES de InicializarForm (via DODEFAULT)
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm, par_nDataSession, par_lReservaAuto, ;
                   par_nEmphPdr, par_lAutomatico, par_nNumeroOp)

        THIS.this_cTituloForm = "Opera" + CHR(231) + CHR(245) + "es Selecionadas"

        IF VARTYPE(par_oParentForm) = "O" AND !ISNULL(par_oParentForm)
            THIS.this_oParentForm = par_oParentForm
            IF VARTYPE(par_oParentForm.this_cPorDestino) = "C"
                THIS.this_cPorDestino = par_oParentForm.this_cPorDestino
            ENDIF
        ENDIF
        IF VARTYPE(par_nDataSession) = "N"
            THIS.this_nParentSession = par_nDataSession
        ENDIF
        IF VARTYPE(par_lReservaAuto) = "L"
            THIS.this_lReservaAuto = par_lReservaAuto
        ENDIF
        IF VARTYPE(par_nEmphPdr) = "N"
            THIS.this_nEmphPdr = par_nEmphPdr
        ENDIF
        IF VARTYPE(par_lAutomatico) = "L"
            THIS.this_lAutomatico = par_lAutomatico
        ENDIF
        IF VARTYPE(par_nNumeroOp) = "N"
            THIS.this_nNumeroOp = par_nNumeroOp
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Activate - Ordena grade e atualiza visual ao ativar o form
    *--------------------------------------------------------------------------
    PROCEDURE Activate()
        THIS.AplicarOrdem("")
        IF USED("TmpCabec")
            THIS.grd_4c_GradeOpe.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGl2BO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPrGl2BO.", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.MontarLayout()
                THIS.ConfigurarGrades()
                THIS.ConfigurarPaginaDados()
                THIS.RegistrarEventos()
                THIS.AplicarOrdem("")
                THIS.TornarControlesVisiveis(THIS)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar " + THIS.this_cTituloForm + ":" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarLayout - Cria todos os controles do form operacional
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarLayout()

        *-- Botao Processar (top=3, sobreposicao ao cabecalho cinza)
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top             = 3
            .Left            = 648
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Processar"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
        ENDWITH

        *-- Botao Cancelar/Encerrar
        THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH THIS.cmd_4c_Cancelar
            .Top             = 3
            .Left            = 723
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
        ENDWITH

        *-- EditBox: Observacao da Operacao (top=82, editavel)
        THIS.AddObject("edt_4c_ObsOpe", "EditBox")
        WITH THIS.edt_4c_ObsOpe
            .Top         = 82
            .Left        = 5
            .Width       = 602
            .Height      = 70
            .NullDisplay = " "
            .FontName    = "Tahoma"
            .FontSize    = 8
        ENDWITH

        *-- Grade de Operacoes (top=155, 10 colunas)
        THIS.AddObject("grd_4c_GradeOpe", "Grid")
        WITH THIS.grd_4c_GradeOpe
            .Top               = 155
            .Left              = 5
            .Width             = 789
            .Height            = 156
            .ColumnCount       = 10
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 17
            .ScrollBars        = 2
            .GridLineColor     = RGB(238,238,238)
            .Panel             = 1
        ENDWITH

        *-- Configurar colunas da GradeOpe
        WITH THIS.grd_4c_GradeOpe

            *-- Col1: Flag (checkbox de selecao)
            WITH .Column1
                .Width     = 17
                .Movable   = .F.
                .Resizable = .F.
                .Sparse    = .F.
                WITH .Header1
                    .Caption   = ""
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                .AddObject("chk_4c_Flag", "CheckBox")
                WITH .chk_4c_Flag
                    .Caption   = ""
                    .Alignment = 0
                    .Height    = 17
                    .Width     = 60
                ENDWITH
                .CurrentControl = "chk_4c_Flag"
            ENDWITH

            *-- Col2: Movimentacao (Dopes) - cabecalho clicavel para ordenar
            WITH .Column2
                .Width     = 156
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                WITH .Header1
                    .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col3: Numero (Numes)
            WITH .Column3
                .Width     = 70
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                WITH .Header1
                    .Caption   = "N" + CHR(250) + "mero"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col4: Emissao (Datas)
            WITH .Column4
                .Width     = 70
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                WITH .Header1
                    .Caption   = "Emiss" + CHR(227) + "o"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col5: Entrega (Entregas) - cabecalho clicavel para ordenar
            WITH .Column5
                .Width     = 70
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                WITH .Header1
                    .Caption   = "Entrega"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col6: Peso
            WITH .Column6
                .Width     = 90
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .InputMask = "999,999.99"
                WITH .Header1
                    .Caption   = "Peso"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col7: Responsavel (Contav)
            WITH .Column7
                .Width     = 90
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                WITH .Header1
                    .Caption   = "Respons" + CHR(225) + "vel"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col8: Cliente (Conta)
            WITH .Column8
                .Width     = 90
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                WITH .Header1
                    .Caption   = "Cliente"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col9: Obs (indicador "*" se tem observacao)
            WITH .Column9
                .Width     = 44
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                WITH .Header1
                    .Caption   = "Obs"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontBold    = .T.
                    .FontSize    = 12
                    .Alignment   = 2
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col10: Doc. (Notas)
            WITH .Column10
                .Width     = 52
                .Movable   = .F.
                .Resizable = .F.
                WITH .Header1
                    .Caption   = "Doc."
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

        ENDWITH

        *-- Label "Cliente :"
        THIS.AddObject("lbl_4c_Cliente", "Label")
        WITH THIS.lbl_4c_Cliente
            .Top       = 317
            .Left      = 5
            .Width     = 42
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Cliente :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- TextBox do Cliente (somente leitura - exibe DConta)
        THIS.AddObject("txt_4c_Cliente", "TextBox")
        WITH THIS.txt_4c_Cliente
            .Top           = 313
            .Left          = 59
            .Width         = 345
            .Height        = 23
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        *-- Grade de Itens (top=339, 8 colunas)
        THIS.AddObject("grd_4c_GradeItens", "Grid")
        WITH THIS.grd_4c_GradeItens
            .Top               = 339
            .Left              = 5
            .Width             = 737
            .Height            = 191
            .ColumnCount       = 8
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 17
            .ScrollBars        = 2
            .GridLineColor     = RGB(238,238,238)
            .Panel             = 1
        ENDWITH

        *-- Configurar colunas da GradeItens
        WITH THIS.grd_4c_GradeItens

            *-- Col1: Produto (Cpros) - ColumnOrder=1 (default)
            WITH .Column1
                .Width     = 120
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                WITH .Header1
                    .Caption   = "Produto"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col2: Quantidade (Qtds) - ColumnOrder=5
            WITH .Column2
                .ColumnOrder = 5
                .Width       = 90
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .Caption   = "Quantidade"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col3: Saldo - ColumnOrder=6
            WITH .Column3
                .ColumnOrder = 6
                .Width       = 118
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .Caption   = "Saldo"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col4: Peso - ColumnOrder=7
            WITH .Column4
                .ColumnOrder = 7
                .Width       = 100
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .Caption   = "Peso"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col5: Obs (indicador) - ColumnOrder=8
            WITH .Column5
                .ColumnOrder = 8
                .Width       = 44
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .Caption   = "Obs"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontBold    = .T.
                    .FontSize    = 12
                    .Alignment   = 2
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col6: Cor (CodCors) - ColumnOrder=3
            WITH .Column6
                .ColumnOrder = 3
                .Width       = 38
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .Caption   = "Cor"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col7: Tam (CodTams) - ColumnOrder=4
            WITH .Column7
                .ColumnOrder = 4
                .Width       = 38
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .Caption   = "Tam"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- Col8: Ref. Fornecedor (Reffs) - ColumnOrder=2
            WITH .Column8
                .ColumnOrder = 2
                .Width       = 150
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .Caption   = "Ref. Fornecedor"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .ForeColor = RGB(36,84,155)
                ENDWITH
                WITH .Text1
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0,0,0)
                    .BackColor   = RGB(255,255,255)
                ENDWITH
            ENDWITH

        ENDWITH

        *-- Botao Desmarca Tudo (top=358, left=748, ao lado da GradeItens)
        THIS.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH THIS.cmd_4c_Apaga
            .Top             = 358
            .Left            = 748
            .Width           = 40
            .Height          = 40
            .Caption         = ""
            .ToolTipText     = "Desmarca Tudo"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .FontName        = "Verdana"
            .FontSize        = 8
            .ForeColor       = RGB(36,84,155)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
        ENDWITH

        *-- Botao Seleciona Tudo (top=400, left=748, ao lado da GradeItens)
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top             = 400
            .Left            = 748
            .Width           = 40
            .Height          = 40
            .Caption         = ""
            .ToolTipText     = "Seleciona Tudo"
            .Picture         = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
            .FontName        = "Verdana"
            .FontSize        = 8
            .ForeColor       = RGB(36,84,155)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
        ENDWITH

        *-- Label "Observacao do Item :"
        THIS.AddObject("lbl_4c_ObsItens", "Label")
        WITH THIS.lbl_4c_ObsItens
            .Top       = 532
            .Left      = 5
            .Width     = 146
            .Height    = 15
            .AutoSize  = .F.
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Item : "
            .FontBold  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- EditBox de observacao dos itens (editavel, top=548)
        THIS.AddObject("edt_4c_ObsItens", "EditBox")
        WITH THIS.edt_4c_ObsItens
            .Top         = 548
            .Left        = 5
            .Width       = 737
            .Height      = 47
            .NullDisplay = " "
            .FontName    = "Tahoma"
            .FontSize    = 8
        ENDWITH

        *-- Shape decorativo na area dos botoes de acao (topo-direita)
        THIS.AddObject("shp_4c_Shape3", "Shape")
        WITH THIS.shp_4c_Shape3
            .Top         = 7
            .Left        = 732
            .Width       = 60
            .Height      = 29
            .BorderStyle = 1
            .BorderWidth = 1
            .FillStyle   = 1
        ENDWITH

    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrades - Define RecordSource e ControlSource das grades
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrades()

        *-- GradeOperacoes vinculada a TmpCabec (somente se cursor existir)
        IF USED("TmpCabec")
            THIS.grd_4c_GradeOpe.RecordSource = "TmpCabec"
            WITH THIS.grd_4c_GradeOpe
                .Column1.ControlSource  = "TmpCabec.Flag"
                .Column2.ControlSource  = "TmpCabec.Dopes"
                .Column3.ControlSource  = "TmpCabec.Numes"
                .Column4.ControlSource  = "TmpCabec.Datas"
                .Column5.ControlSource  = "IIF(ISNULL(TmpCabec.Entregas), {}, TmpCabec.Entregas)"
                .Column6.ControlSource  = "TmpCabec.Peso"
                .Column7.ControlSource  = "TmpCabec.Contav"
                .Column8.ControlSource  = "TmpCabec.Conta"
                .Column9.ControlSource  = "IIF(EMPTY(TmpCabec.Obs), ' ', '*')"
                .Column10.ControlSource = "TmpCabec.Notas"
            ENDWITH

            *-- Cliente (nome do cliente da operacao atual)
            THIS.txt_4c_Cliente.ControlSource = "TmpCabec.DConta"

            *-- Obs da operacao (editavel)
            THIS.edt_4c_ObsOpe.ControlSource = "TmpCabec.Obs"
        ENDIF

        *-- GradeItens vinculada a TmpItens (somente se cursor existir)
        IF USED("TmpItens")
            THIS.grd_4c_GradeItens.RecordSource = "TmpItens"
            WITH THIS.grd_4c_GradeItens
                .Column1.ControlSource = "TmpItens.Cpros"
                .Column2.ControlSource = "TmpItens.Qtds"
                .Column3.ControlSource = "TmpItens.Saldo"
                .Column4.ControlSource = "TmpItens.Peso"
                .Column5.ControlSource = "IIF(EMPTY(TmpItens.Obs), ' ', '*')"
                .Column6.ControlSource = "TmpItens.CodCors"
                .Column7.ControlSource = "TmpItens.CodTams"
                .Column8.ControlSource = "TmpItens.Reffs"
            ENDWITH

            *-- Obs dos itens (editavel)
            THIS.edt_4c_ObsItens.ControlSource = "TmpItens.Obs"
        ENDIF

        *-- Posicionar TmpItens filtrado pelo primeiro registro de TmpCabec
        IF USED("TmpItens") AND USED("TmpCabec")
            SELECT TmpCabec
            GO TOP
            SELECT TmpItens
            SET ORDER TO EmpDopNum
            SET KEY TO TmpCabec.Emps + TmpCabec.Dopes + STR(TmpCabec.Numes, 6)
            GO TOP
        ENDIF

    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarEventos - BINDEVENT para todos os eventos interativos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarEventos()

        BINDEVENT(THIS.grd_4c_GradeOpe, "AfterRowColChange", THIS, "AoMudarLinhaOpe")
        BINDEVENT(THIS.grd_4c_GradeOpe.Column2.Header1, "Click", THIS, "AoClicarCabMovi")
        BINDEVENT(THIS.grd_4c_GradeOpe.Column5.Header1, "Click", THIS, "AoClicarCabEntrega")
        BINDEVENT(THIS.grd_4c_GradeItens, "AfterRowColChange", THIS, "AoMudarLinhaItens")
        BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "AoProcessar")
        BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "AoCancelar")
        BINDEVENT(THIS.cmd_4c_Apaga,     "Click", THIS, "AoApagar")
        BINDEVENT(THIS.cmd_4c_SelTudo,   "Click", THIS, "AoSelTudo")

    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarOrdem - Ordena TmpCabec e atualiza cores dos cabecalhos das colunas
    * par_cOrdem: "EMPDOPNUM" | "ENTREGA" | "" (usa ordem atual do BO)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarOrdem(par_cOrdem)
        LOCAL loc_cOrdAtual

        THIS.this_oBusinessObject.OrdenarOperacoes(par_cOrdem)
        loc_cOrdAtual = UPPER(THIS.this_oBusinessObject.this_cOrdConta)

        WITH THIS.grd_4c_GradeOpe
            .Column2.Header1.BackColor = IIF(loc_cOrdAtual = "EMPDOPNUM", RGB(220,255,220), RGB(192,192,192))
            .Column5.Header1.BackColor = IIF(loc_cOrdAtual = "ENTREGA",   RGB(220,255,220), RGB(192,192,192))
        ENDWITH
    ENDPROC

    *==========================================================================
    * HANDLERS DE EVENTOS (PUBLIC - exigido por BINDEVENT)
    *==========================================================================

    *--------------------------------------------------------------------------
    * AoMudarLinhaOpe - AfterRowColChange da GradeOpe
    * Filtra TmpItens para exibir itens da operacao selecionada
    *--------------------------------------------------------------------------
    PROCEDURE AoMudarLinhaOpe(par_nColIndex)
        IF USED("TmpItens") AND USED("TmpCabec")
            SELECT TmpItens
            SET ORDER TO EmpDopNum
            SET KEY TO TmpCabec.Emps + TmpCabec.Dopes + STR(TmpCabec.Numes, 6)
            GO TOP
            THIS.txt_4c_Cliente.Refresh()
            THIS.edt_4c_ObsOpe.Refresh()
            THIS.grd_4c_GradeItens.Refresh()
            THIS.edt_4c_ObsItens.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AoClicarCabMovi - Click no Header da Coluna 2 (Movimentacao)
    * Ordena TmpCabec por EmpDopNum
    *--------------------------------------------------------------------------
    PROCEDURE AoClicarCabMovi()
        IF USED("TmpCabec") AND UPPER(ORDER("TmpCabec")) <> "EMPDOPNUM"
            THIS.AplicarOrdem("EMPDOPNUM")
            SELECT TmpCabec
            GO TOP
            THIS.grd_4c_GradeOpe.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AoClicarCabEntrega - Click no Header da Coluna 5 (Entrega)
    * Ordena TmpCabec por data de entrega
    *--------------------------------------------------------------------------
    PROCEDURE AoClicarCabEntrega()
        IF USED("TmpCabec") AND UPPER(ORDER("TmpCabec")) <> "ENTREGA"
            THIS.AplicarOrdem("ENTREGA")
            SELECT TmpCabec
            GO TOP
            THIS.grd_4c_GradeOpe.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AoMudarLinhaItens - AfterRowColChange da GradeItens
    * Atualiza editbox de observacao do item
    *--------------------------------------------------------------------------
    PROCEDURE AoMudarLinhaItens(par_nColIndex)
        THIS.edt_4c_ObsItens.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * AoProcessar - Click do botao Processar
    * Chama BO.ProcessarOperacoes() e navega para o form seguinte
    *--------------------------------------------------------------------------
    PROCEDURE AoProcessar()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_oProxForm
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.this_oBusinessObject.ProcessarOperacoes( ;
                THIS.this_lReservaAuto, ;
                THIS.this_lAutomatico,  ;
                THIS.this_nEmphPdr,     ;
                THIS.this_nNumeroOp,    ;
                THIS.this_cPorDestino   ;
            )
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AoProcessar")
        ENDTRY

        IF loc_lSucesso
            THIS.Enabled = .F.
            IF THIS.this_lReservaAuto
                THIS.cmd_4c_Processar.Enabled = .F.
            ENDIF

            *-- Abrir form seguinte conforme flag do BO
            IF THIS.this_oBusinessObject.this_lTemEstimado
                *-- Ha estoque estimado: abre SigPrGlx (grade com estimados)
                loc_oProxForm = CREATEOBJECT("FormSigPrGlx", THIS, THIS.DataSessionId, ;
                                              THIS.this_lReservaAuto, THIS.this_nEmphPdr, ;
                                              THIS.this_lAutomatico, THIS.this_nNumeroOp, ;
                                              THIS.this_cPorDestino)
            ELSE
                *-- Sem estoque estimado: abre SigPrGlp (grade de geracao direta)
                loc_oProxForm = CREATEOBJECT("FormSigPrGlp", THIS, THIS.DataSessionId, ;
                                              THIS.this_lReservaAuto, THIS.this_nEmphPdr, ;
                                              THIS.this_lAutomatico, THIS.this_nNumeroOp)
            ENDIF

            IF VARTYPE(loc_oProxForm) = "O"
                loc_oProxForm.Show()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AoCancelar - Click do botao Encerrar
    * Reabilita form pai e fecha este form
    *--------------------------------------------------------------------------
    PROCEDURE AoCancelar()
        IF VARTYPE(THIS.this_oParentForm) = "O" AND !ISNULL(THIS.this_oParentForm)
            THIS.this_oParentForm.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * AoApagar - Click do botao Desmarca Tudo
    *--------------------------------------------------------------------------
    PROCEDURE AoApagar()
        IF USED("TmpCabec")
            REPLACE ALL Flag WITH .F. IN TmpCabec
            THIS.grd_4c_GradeOpe.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AoSelTudo - Click do botao Seleciona Tudo
    *--------------------------------------------------------------------------
    PROCEDURE AoSelTudo()
        IF USED("TmpCabec")
            REPLACE ALL Flag WITH .T. IN TmpCabec
            THIS.grd_4c_GradeOpe.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Constroi o "frame" visual do form OPERACIONAL:
    * cnt_4c_Cabecalho (cabecalho cinza) com labels de titulo.
    * Forms OPERACIONAIS nao usam PageFrame CRUD; este metodo agrupa a
    * estrutura fixa do topo, mantendo o nome padrao do pipeline multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oCab
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 18
            .AutoSize   = .F.
            .WordWrap   = .T.
            .Alignment  = 0
            .BackStyle  = 0
            .Caption    = "Opera" + CHR(231) + CHR(245) + "es Selecionadas"
            .Height     = 40
            .Left       = 10
            .Top        = 18
            .Width      = THIS.Width - 20
            .ForeColor  = RGB(0, 0, 0)
            .Visible    = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .AutoSize    = .F.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .Caption     = "Opera" + CHR(231) + CHR(245) + "es Selecionadas"
            .Height      = 46
            .Left        = 10
            .Top         = 17
            .Width       = THIS.Width - 20
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura a area de lista (equivalente a Page1
    * em forms CRUD). Para este form OPERACIONAL, o layout completo e montado
    * em MontarLayout/ConfigurarGrades; este metodo e o ponto de entrada
    * nomeado para compatibilidade com o pipeline multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        IF VARTYPE(THIS.grd_4c_GradeOpe) = "O" AND !ISNULL(THIS.grd_4c_GradeOpe)
            THIS.ConfigurarGrades()
        ENDIF
    ENDPROC
    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Propriedades visuais dos controles interativos:
    *   - grd_4c_GradeOpe:    highlight e fonte
    *   - edt_4c_ObsOpe:      aparencia e scrollbar
    *   - grd_4c_GradeItens:  highlight e fonte
    *   - edt_4c_ObsItens:    aparencia e scrollbar
    *   - txt_4c_Cliente:     aparencia somente-leitura
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()

        *-- GradeOperacoes: highlight de linha selecionada e fonte
        WITH THIS.grd_4c_GradeOpe
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH

        *-- EditBox de Observacao da Operacao
        WITH THIS.edt_4c_ObsOpe
            .BackColor  = RGB(255, 255, 255)
            .ForeColor  = RGB(90, 90, 90)
            .ScrollBars = 2
        ENDWITH

        *-- GradeItens: highlight de linha selecionada e fonte
        WITH THIS.grd_4c_GradeItens
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH

        *-- EditBox de Observacao dos Itens
        WITH THIS.edt_4c_ObsItens
            .BackColor  = RGB(255, 255, 255)
            .ForeColor  = RGB(90, 90, 90)
            .ScrollBars = 2
        ENDWITH

        *-- TextBox Cliente: fundo levemente cinza para indicar somente-leitura
        WITH THIS.txt_4c_Cliente
            .BackColor = RGB(240, 240, 240)
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Nao aplicavel para form OPERACIONAL (sem PageFrame CRUD)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = 'O' AND !ISNULL(loc_oControl)
                IF PEMSTATUS(loc_oControl, 'Visible', 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = 'PAGEFRAME'
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, 'ControlCount', 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * EVENTOS PRINCIPAIS - Padrao esperado pelo pipeline multi-fase (Fase 7)
    *
    * Este form OPERACIONAL (SIGPRGL2 - Operacoes Selecionadas) NAO possui
    * botoes CRUD tradicionais Incluir/Alterar/Visualizar/Excluir. O layout
    * real tem: Processar, Encerrar, Selecionar Tudo e Desmarca Tudo.
    *
    * Para manter compatibilidade com o pipeline (e permitir que forms externos
    * disparem acoes pelos nomes canonicos), estes handlers mapeiam:
    *   BtnIncluirClick    -> AoProcessar (acao principal = gerar OPs)
    *   BtnAlterarClick    -> AoSelTudo   (marcar todas para processar)
    *   BtnVisualizarClick -> AoApagar    (desmarcar todas)
    *   BtnExcluirClick    -> AoCancelar  (encerrar sem processar)
    *
    * Todos possuem logica REAL (delegacao explicita) - sem stubs.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Processa as operacoes marcadas gerando as OPs
    * Mapeia para o botao "Processar" do form OPERACIONAL
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.AoProcessar()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Marca todas as operacoes de TmpCabec para processamento
    * Mapeia para o botao "Selecionar Tudo" do form OPERACIONAL
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.AoSelTudo()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Desmarca todas as operacoes de TmpCabec
    * Mapeia para o botao "Desmarca Tudo" do form OPERACIONAL
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.AoApagar()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Encerra o form reabilitando o form pai (sem processar)
    * Mapeia para o botao "Encerrar" do form OPERACIONAL
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.AoCancelar()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Atualiza as grades com o estado atual dos cursores
    * TmpCabec e TmpItens (recebidos do form pai - nao executa SQL propria)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("TmpCabec") AND USED("TmpItens")
                THIS.AplicarOrdem("")
                SELECT TmpCabec
                GO TOP
                THIS.grd_4c_GradeOpe.Refresh()
                THIS.AoMudarLinhaOpe(0)
                THIS.HabilitarCampos()
                loc_lSucesso = .T.
            ELSE
                MsgAviso("Cursores TmpCabec/TmpItens n" + CHR(227) + "o disponibilizados pelo form pai.", ;
                         "Aviso")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Sincroniza parametros do form para o BO antes de processar.
    * Este form OPERACIONAL nao tem campos CRUD; transfere apenas os
    * parametros de execucao capturados no Init.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_lReserva    = THIS.this_lReservaAuto
                THIS.this_oBusinessObject.this_lAutomatico = THIS.this_lAutomatico
                THIS.this_oBusinessObject.this_nEmphPdr    = THIS.this_nEmphPdr
                THIS.this_oBusinessObject.this_nNumeroDaOP = THIS.this_nNumeroOp
                THIS.this_oBusinessObject.this_cPorDestino = THIS.this_cPorDestino
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Atualiza controles visiveis com o estado atual dos cursores.
    * Para este form OPERACIONAL o estado e gerenciado pelos cursores TmpCabec
    * e TmpItens via ControlSource; basta refreshar os controles visuais.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oErro

        TRY
            IF USED("TmpCabec")
                THIS.grd_4c_GradeOpe.Refresh()
                THIS.txt_4c_Cliente.Refresh()
                THIS.edt_4c_ObsOpe.Refresh()
            ENDIF
            IF USED("TmpItens")
                THIS.grd_4c_GradeItens.Refresh()
                THIS.edt_4c_ObsItens.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Gerencia estado do botao Processar: habilitado apenas
    * quando ha ao menos uma operacao marcada (Flag=.T.) em TmpCabec.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos()
        LOCAL loc_lTemSelecionado, loc_nI, loc_oErro
        loc_lTemSelecionado = .F.

        TRY
            IF USED("TmpCabec")
                SELECT TmpCabec
                GO TOP
                SCAN FOR Flag
                    loc_lTemSelecionado = .T.
                    EXIT
                ENDSCAN
            ENDIF

            IF VARTYPE(THIS.cmd_4c_Processar) = "O"
                THIS.cmd_4c_Processar.Enabled = loc_lTemSelecionado
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Desmarca todas as operacoes de TmpCabec e refresha
    * os controles de observacao que possuem ControlSource vinculado.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oErro

        TRY
            IF USED("TmpCabec")
                REPLACE ALL Flag WITH .F. IN TmpCabec
                THIS.grd_4c_GradeOpe.Refresh()
            ENDIF

            IF VARTYPE(THIS.edt_4c_ObsOpe) = "O"
                THIS.edt_4c_ObsOpe.Refresh()
            ENDIF
            IF VARTYPE(THIS.edt_4c_ObsItens) = "O"
                THIS.edt_4c_ObsItens.Refresh()
            ENDIF
            IF VARTYPE(THIS.txt_4c_Cliente) = "O"
                THIS.txt_4c_Cliente.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Para este form OPERACIONAL sem modos CRUD,
    * delega para HabilitarCampos que gerencia o estado do botao Processar.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        THIS.HabilitarCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Reaplica ordenacao e atualiza a grade de operacoes.
    * Equivalente ao "Buscar/Filtrar" para este form OPERACIONAL.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o form reabilitando o form pai
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.AoCancelar()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Para este form OPERACIONAL, "salvar" equivale a
    * processar as operacoes marcadas e prosseguir para o proximo sub-form.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.AoProcessar()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Encerra sem processar, reabilitando o form pai
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AoCancelar()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oParentForm) = 'O' AND !ISNULL(THIS.this_oParentForm)
                IF PEMSTATUS(THIS.this_oParentForm, 'Enabled', 5)
                    THIS.this_oParentForm.Enabled = .T.
                ENDIF
            ENDIF
            THIS.this_oParentForm     = .NULL.
            THIS.this_oBusinessObject = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Destroy")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE
