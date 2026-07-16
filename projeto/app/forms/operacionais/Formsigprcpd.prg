*==============================================================================
* FORMSIGPRCPD.PRG - Formulario Operacional: Capacidade Produtiva
* Tipo: OPERACIONAL (flat - sem PageFrame CRUD, layout customizado)
* Migrado de SIGPRCPD.SCX
*
* Pilares:
*   UX   -> layout identico ao legado (800x600 - popup modal sem titlebar)
*   BD   -> cursores cursor_4c_Dados (zTmpPcpOp), cursor_4c_Capacidade
*   CODE -> arquitetura em camadas (FormBase / sigprcpdBO)
*
* CHAMADA:
*   loForm = CREATEOBJECT("Formsigprcpd", cFase, cUnidade, dData, nCodigo)
*   loForm.Show()
*   par_cFase    = Fase/Setor (char)
*   par_cUnidade = Unidade de producao (char, vazio = todas)
*   par_dData    = Data de referencia (date)
*   par_nCodigo  = codigos PK de SigCdPcz (numeric)
*==============================================================================

DEFINE CLASS Formsigprcpd AS FormBase

    *-- Propriedades visuais (identicas ao legado)
    Height      = 600
    Width       = 800
    BorderStyle = 2
    AutoCenter  = .T.
    Caption     = "Capacidade Produtiva"
    TitleBar    = 0
    ShowWindow = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    Movable     = .F.
    ClipControls = .F.
    DataSession  = 2
    WindowType   = 1

    *-- Parametros recebidos pelo Init (espelho de RESERVED3 do legado)
    this_nCodigo   = 0    && codigos PK de SigCdPcz
    this_cSetor    = ""   && Fase/Setor
    this_cUnidade  = ""   && Unidade de producao (vazio = todas)
    this_dData     = {}   && Data de referencia

    *-- Variaveis de estado
    this_cModoAtual = "CONSULTA"

    *==========================================================================
    PROCEDURE Init
    *==========================================================================
        LPARAMETERS par_cFase, par_cUnidade, par_dData, par_nCodigo

        *-- Armazenar parametros ANTES de DODEFAULT() para que InicializarForm
        *-- tenha acesso a eles via THIS.*
        IF VARTYPE(par_cFase) = "C"
            THIS.this_cSetor = ALLTRIM(par_cFase)
        ENDIF
        IF VARTYPE(par_cUnidade) = "C"
            THIS.this_cUnidade = ALLTRIM(par_cUnidade)
        ENDIF
        IF VARTYPE(par_dData) = "D"
            THIS.this_dData = par_dData
        ENDIF
        IF VARTYPE(par_nCodigo) = "N"
            THIS.this_nCodigo = par_nCodigo
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Fundo do form (identico ao legado: new_background.jpg)
            THIS.ConfigurarPageFrame()

            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("sigprcpdBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar sigprcpdBO.", "Erro Formsigprcpd")
            ELSE
                *-- Cabecalho cinza superior (cntSombra do legado)
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Container de filtros (Container1 do legado: Fase/Data)
                THIS.ConfigurarContainer1()

                *-- Container de capacidade (Container2 do legado: Cap/Utz/Sld)
                THIS.ConfigurarContainer2()

                *-- Area principal do form (grade + botao Encerrar)
                *-- Agregado em ConfigurarPaginaLista por convencao do pipeline
                THIS.ConfigurarPaginaLista()

                *-- Area de detalhe do produto (labels/textboxes abaixo da grade)
                THIS.ConfigurarDetalhesProduto()

                *-- Tornar controles visiveis (AddObject cria Visible=.F.)
                THIS.TornarControlesVisiveis()

                *-- Guard: pular carregamento de dados se validando UI sem conexao SQL
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF gnConnHandle > 0
                        THIS.CarregarDados()
                    ELSE
                        MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", ;
                                "Erro Formsigprcpd")
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar Formsigprcpd: " + loc_oErro.Message + ;
                    " Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " Proc=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
    *==========================================================================
        LOCAL loc_cImgFundo
        *-- Form OPERACIONAL flat (sem PageFrame CRUD)
        *-- Configura picture de fundo identico ao legado
        loc_cImgFundo = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
        IF FILE(loc_cImgFundo)
            THIS.Picture = loc_cImgFundo
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
    *==========================================================================
        LOCAL loc_nW
        loc_nW = THIS.Width

        *-- Container cabecalho cinza (cntSombra do legado)
        *-- Propriedades originais: Top=1, Left=1, Width=800, Height=80
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top        = 1
            .Left       = 1
            .Width      = loc_nW - 2
            .Height     = 80
            .BackStyle  = 1
            .BackColor  = RGB(100, 100, 100)
            .BorderWidth = 0

            *-- Label sombra (texto escuro, deslocado 1px para efeito profundidade)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize  = .F.
                .Width     = loc_nW - 2
                .Height    = 40
                .Top       = 18
                .Left      = 10
                .Caption   = "Capacidade Produtiva"
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .WordWrap  = .T.
                .Alignment = 0
            ENDWITH

            *-- Label titulo (branco sobre cinza)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .Width     = loc_nW - 2
                .Height    = 46
                .Top       = 17
                .Left      = 10
                .Caption   = "Capacidade Produtiva"
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .WordWrap  = .T.
                .Alignment = 0
            ENDWITH
        ENDWITH
        THIS.cnt_4c_Cabecalho.Visible = .T.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainer1
    *==========================================================================
        *-- Container de filtros: Fase e Data (Container1 do legado)
        *-- Propriedades originais: Top=104, Left=8, Width=278, Height=36
        THIS.AddObject("cnt_4c_Container1", "Container")
        WITH THIS.cnt_4c_Container1
            .Top          = 104
            .Left         = 8
            .Width        = 278
            .Height       = 36
            .BackStyle    = 0
            .BorderWidth  = 0
            .SpecialEffect = 0

            *-- Label "Fase :"
            .AddObject("lbl_4c_Fase", "Label")
            WITH .lbl_4c_Fase
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Fase :"
                .Height    = 17
                .Left      = 2
                .Top       = 8
                .Width     = 40
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- TextBox Fase (somente leitura, preenche em CarregarDados)
            .AddObject("txt_4c_Fase", "TextBox")
            WITH .txt_4c_Fase
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Height    = 23
                .Left      = 44
                .Top       = 5
                .Width     = 100
                .BackColor = RGB(255, 198, 140)
                .ReadOnly  = .T.
                .Value     = ""
            ENDWITH

            *-- Label "Data :"
            .AddObject("lbl_4c_Data", "Label")
            WITH .lbl_4c_Data
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Data :"
                .Height    = 17
                .Left      = 147
                .Top       = 9
                .Width     = 40
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- TextBox Data (somente leitura, preenche em CarregarDados)
            .AddObject("txt_4c_Data", "TextBox")
            WITH .txt_4c_Data
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Height    = 23
                .Left      = 189
                .Top       = 5
                .Width     = 72
                .BackColor = RGB(255, 198, 140)
                .ReadOnly  = .T.
                .Value     = {}
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainer2
    *==========================================================================
        *-- Container de capacidade: Cap / Utz / Sld (Container2 do legado)
        *-- Propriedades originais: Top=104, Left=288, Width=504, Height=36
        THIS.AddObject("cnt_4c_Container2", "Container")
        WITH THIS.cnt_4c_Container2
            .Top          = 104
            .Left         = 288
            .Width        = 504
            .Height       = 36
            .BackStyle    = 0
            .BorderWidth  = 0
            .SpecialEffect = 0

            *-- Label "Capacidade:"
            .AddObject("lbl_4c_Capacidade", "Label")
            WITH .lbl_4c_Capacidade
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Capacidade:"
                .Height    = 15
                .Left      = 9
                .Top       = 10
                .Width     = 70
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- TextBox Capacidade (somente leitura)
            .AddObject("txt_4c_Cap", "TextBox")
            WITH .txt_4c_Cap
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Height    = 23
                .InputMask = "99999"
                .Left      = 81
                .Top       = 5
                .Width     = 63
                .BackColor = RGB(255, 216, 176)
                .ReadOnly  = .T.
                .Value     = 0
            ENDWITH

            *-- Label "Min" (apos Capacidade)
            .AddObject("lbl_4c_MinCap", "Label")
            WITH .lbl_4c_MinCap
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Min"
                .Height    = 15
                .Left      = 147
                .Top       = 10
                .Width     = 22
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Label "Utilizado:"
            .AddObject("lbl_4c_Utilizado", "Label")
            WITH .lbl_4c_Utilizado
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Utilizado:"
                .Height    = 15
                .Left      = 194
                .Top       = 10
                .Width     = 54
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- TextBox Utilizado (somente leitura)
            .AddObject("txt_4c_Utz", "TextBox")
            WITH .txt_4c_Utz
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Height    = 23
                .InputMask = "99999"
                .Left      = 250
                .Top       = 5
                .Width     = 63
                .BackColor = RGB(255, 216, 176)
                .ReadOnly  = .T.
                .Value     = 0
            ENDWITH

            *-- Label "Min" (apos Utilizado)
            .AddObject("lbl_4c_MinUtz", "Label")
            WITH .lbl_4c_MinUtz
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Min"
                .Height    = 15
                .Left      = 316
                .Top       = 9
                .Width     = 22
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Label "Saldo : "
            .AddObject("lbl_4c_Saldo", "Label")
            WITH .lbl_4c_Saldo
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Saldo : "
                .Height    = 15
                .Left      = 366
                .Top       = 10
                .Width     = 42
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- TextBox Saldo (somente leitura)
            .AddObject("txt_4c_Sld", "TextBox")
            WITH .txt_4c_Sld
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Height    = 23
                .InputMask = "99999"
                .Left      = 410
                .Top       = 5
                .Width     = 63
                .BackColor = RGB(255, 216, 176)
                .ReadOnly  = .T.
                .Value     = 0
            ENDWITH

            *-- Label "Min" (apos Saldo)
            .AddObject("lbl_4c_MinSld", "Label")
            WITH .lbl_4c_MinSld
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Min"
                .Height    = 15
                .Left      = 476
                .Top       = 9
                .Width     = 22
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoEncerrar
    *==========================================================================
        *-- Botao Encerrar (Sair do legado: Top=4, Left=725, Cancel=.T.)
        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top            = 4
            .Left           = 725
            .Width          = 75
            .Height         = 75
            .Caption        = "Encerrar"
            .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel         = .T.
            .FontName       = "Tahoma"
            .FontSize       = 8
            .FontBold       = .T.
            .FontItalic     = .T.
            .ForeColor      = RGB(90, 90, 90)
            .BackColor      = RGB(255, 255, 255)
            .Themes         = .T.
            .SpecialEffect  = 0
            .PicturePosition = 13
            .WordWrap       = .T.
            .AutoSize       = .F.
            .MousePointer   = 15
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis
    *==========================================================================
        LPARAMETERS par_oContainer
        LOCAL loc_oContainer, loc_i, loc_oControl

        IF VARTYPE(par_oContainer) = "O"
            loc_oContainer = par_oContainer
        ELSE
            loc_oContainer = THIS
        ENDIF

        FOR loc_i = 1 TO loc_oContainer.ControlCount
            loc_oControl = loc_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                *-- Recursao para sub-containers
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    *-- img_4c_FigJpg e shp_4c_Shape4 sao flutuantes: iniciam Visible=.F.
                    *-- e ficam visiveis apenas quando ha foto do produto
                    *-- cnt_4c_Cabecalho gerencia propria visibilidade em ConfigurarCabecalho
                    IF !INLIST(LOWER(loc_oControl.Name), "img_4c_figjpg", "shp_4c_shape4", "cnt_4c_cabecalho")
                        loc_oControl.Visible = .T.
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarDados
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.this_oBusinessObject.CarregarDados(;
                THIS.this_nCodigo, ;
                THIS.this_cSetor, ;
                THIS.this_cUnidade, ;
                THIS.this_dData)

            IF loc_lSucesso
                *-- Preencher Container1: Fase e Data
                THIS.cnt_4c_Container1.txt_4c_Fase.Value = THIS.this_cSetor
                THIS.cnt_4c_Container1.txt_4c_Data.Value = THIS.this_dData

                *-- Preencher Container2: Capacidade, Utilizado, Saldo
                THIS.cnt_4c_Container2.txt_4c_Cap.Value = THIS.this_oBusinessObject.this_nCapacidade
                THIS.cnt_4c_Container2.txt_4c_Utz.Value = THIS.this_oBusinessObject.this_nUtilizado
                THIS.cnt_4c_Container2.txt_4c_Sld.Value = THIS.this_oBusinessObject.this_nSaldo

                *-- Bind do grid (ColumnCount ANTES de RecordSource - regra critica)
                THIS.grd_4c_Dados.ColumnCount  = 8
                THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"

                *-- Configurar colunas (APOS RecordSource para evitar reset de headers)
                *-- ColumnOrder=1 em Column8: Unidade Prod. aparece primeiro (identico ao legado)
                WITH THIS.grd_4c_Dados
                    WITH .Column1
                        .ColumnOrder   = 2
                        .Width         = 80
                        .Alignment     = 2
                        .Movable       = .F.
                        .Resizable     = .F.
                        .ReadOnly      = .T.
                        .ControlSource = "cursor_4c_Dados.Nenvs"
                        .Header1.Caption   = "Envelope"
                        .Header1.FontName  = "Tahoma"
                        .Header1.FontSize  = 8
                        .Header1.Alignment = 2
                        .Header1.ForeColor = RGB(0, 0, 0)
                    ENDWITH
                    WITH .Column2
                        .ColumnOrder   = 3
                        .Width         = 100
                        .Movable       = .F.
                        .Resizable     = .F.
                        .ReadOnly      = .T.
                        .ControlSource = "cursor_4c_Dados.Nops"
                        .Header1.Caption   = "O.P."
                        .Header1.FontName  = "Tahoma"
                        .Header1.FontSize  = 8
                        .Header1.Alignment = 2
                    ENDWITH
                    WITH .Column3
                        .ColumnOrder   = 4
                        .Width         = 24
                        .Alignment     = 2
                        .Movable       = .F.
                        .Resizable     = .F.
                        .ReadOnly      = .T.
                        .ControlSource = "cursor_4c_Dados.Seqs"
                        .Header1.Caption   = "Seq"
                        .Header1.FontName  = "Tahoma"
                        .Header1.FontSize  = 8
                        .Header1.Alignment = 2
                    ENDWITH
                    WITH .Column4
                        .ColumnOrder   = 5
                        .Width         = 65
                        .Alignment     = 2
                        .Movable       = .F.
                        .Resizable     = .F.
                        .ReadOnly      = .T.
                        .InputMask     = "9999.99"
                        .ControlSource = "cursor_4c_Dados.TempoReal"
                        .Header1.Caption   = "Minutos"
                        .Header1.FontName  = "Tahoma"
                        .Header1.FontSize  = 8
                        .Header1.Alignment = 2
                    ENDWITH
                    WITH .Column5
                        .ColumnOrder   = 6
                        .Width         = 95
                        .Movable       = .F.
                        .Resizable     = .F.
                        .ReadOnly      = .T.
                        .ControlSource = "cursor_4c_Dados.Cpros"
                        .Header1.Caption   = "Produto"
                        .Header1.FontName  = "Tahoma"
                        .Header1.FontSize  = 8
                        .Header1.Alignment = 2
                    ENDWITH
                    WITH .Column6
                        .ColumnOrder   = 7
                        .Width         = 190
                        .Movable       = .F.
                        .Resizable     = .F.
                        .ReadOnly      = .T.
                        .ControlSource = "cursor_4c_Dados.Pedido"
                        .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
                        .Header1.FontName  = "Tahoma"
                        .Header1.FontSize  = 8
                        .Header1.Alignment = 2
                    ENDWITH
                    WITH .Column7
                        .ColumnOrder   = 8
                        .Width         = 165
                        .Movable       = .F.
                        .Resizable     = .F.
                        .ReadOnly      = .T.
                        .ControlSource = "cursor_4c_Dados.cliente"
                        .Header1.Caption   = "Cliente"
                        .Header1.FontName  = "Tahoma"
                        .Header1.FontSize  = 8
                        .Header1.Alignment = 2
                    ENDWITH
                    WITH .Column8
                        .ColumnOrder   = 1
                        .Width         = 80
                        .Alignment     = 3
                        .Movable       = .F.
                        .Resizable     = .F.
                        .ReadOnly      = .T.
                        .ControlSource = "cursor_4c_Dados.UniPrdts"
                        .Header1.Caption   = "Unidade Prod."
                        .Header1.FontName  = "Tahoma"
                        .Header1.FontSize  = 8
                        .Header1.Alignment = 2
                    ENDWITH

                    *-- Prioridade: itens com Priors < 999990 aparecem em azul (identico ao legado)
                    .SetAll("DynamicForeColor", ;
                        "IIF(cursor_4c_Dados.Priors < 999990, RGB(0,0,255), RGB(0,0,0))", ;
                        "Column")

                    .Refresh
                ENDWITH

                *-- Preencher campos de detalhe do primeiro registro e focar grid
                IF RECCOUNT("cursor_4c_Dados") > 0
                    THIS.GrdDadosAfterRowColChange(1)
                ENDIF
                IF THIS.Visible
                    THIS.grd_4c_Dados.SetFocus
                ENDIF
            ELSE
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar os dados de capacidade produtiva.", ;
                         "Aviso")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar dados: " + loc_oErro.Message + ;
                    " Ln=" + TRANSFORM(loc_oErro.LineNo), "Erro Formsigprcpd")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE CmdEncerrarClick
    *==========================================================================
        THIS.Release()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnIncluirClick
    *==========================================================================
        *-- Form OPERACIONAL de consulta de Capacidade Produtiva (read-only):
        *-- recarrega os dados do banco (efeito de "refresh completo" da grade).
        *-- Equivalente a repetir a chamada do menu com os mesmos parametros.
        IF VARTYPE(THIS.this_oBusinessObject) != "O" OR gnConnHandle <= 0
            RETURN
        ENDIF
        THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnAlterarClick
    *==========================================================================
        *-- Form OPERACIONAL de consulta (read-only): recarrega os dados do
        *-- banco. Identico a BtnIncluirClick por semantica de viewer.
        IF VARTYPE(THIS.this_oBusinessObject) != "O" OR gnConnHandle <= 0
            RETURN
        ENDIF
        THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnVisualizarClick
    *==========================================================================
        *-- Reposiciona no primeiro registro da grade e re-renderiza detalhes
        *-- do produto (foto, descricao, cliente, tempo do envelope) para a
        *-- linha corrente. Util quando o preview fica dessincronizado apos
        *-- scroll rapido ou LockScreen.
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        GO TOP
        THIS.grd_4c_Dados.Refresh()
        THIS.GrdDadosAfterRowColChange(1)
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnExcluirClick
    *==========================================================================
        *-- Form OPERACIONAL de consulta (read-only): encerra a janela.
        *-- Alias de CmdEncerrarClick (mesmo comportamento do botao Encerrar).
        THIS.Release()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
    *==========================================================================
        *-- Form OPERACIONAL flat (sem PageFrame CRUD). Agrega os controles
        *-- do "view principal": grade de envelopes/O.P. + botao Encerrar.
        *-- Detalhes do produto sao configurados em ConfigurarDetalhesProduto.
        THIS.ConfigurarGrade()
        THIS.ConfigurarBotaoEncerrar()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina
    *==========================================================================
        LPARAMETERS par_nPagina
        *-- Form OPERACIONAL flat: nao possui multiplas paginas. O parametro
        *-- eh aceito por compatibilidade com o padrao CRUD do pipeline; a
        *-- unica acao util eh recarregar os dados da grade (equivalente a
        *-- voltar para a "lista") quando solicitado.
        IF VARTYPE(par_nPagina) = "N" AND par_nPagina = 1
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND gnConnHandle > 0
                THIS.CarregarDados()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade
    *==========================================================================
        *-- Grade principal (Grade do legado): 8 colunas, layout identico ao SCX
        *-- Top=139, Left=0, Width=801, Height=310, ColumnCount=8
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top              = 139
            .Left             = 0
            .Width            = 801
            .Height           = 310
            .ColumnCount      = 8
            .FontName         = "Arial"
            .FontSize         = 8
            .ForeColor        = RGB(90, 90, 90)
            .BackColor        = RGB(255, 255, 255)
            .GridLineColor    = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle   = 2
            .RecordMark       = .F.
            .DeleteMark       = .F.
            .RowHeight        = 16
            .ScrollBars       = 2
            .ReadOnly         = .T.
        ENDWITH
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarDetalhesProduto
    *==========================================================================
        *-- Shape4: borda ao redor da foto do produto (inicialmente oculto)
        THIS.AddObject("shp_4c_Shape4", "Shape")
        WITH THIS.shp_4c_Shape4
            .Top       = 455
            .Left      = 456
            .Width     = 148
            .Height    = 109
            .BackStyle = 1
            .BackColor = RGB(200, 200, 200)
            .Visible   = .F.
        ENDWITH

        *-- FigJpg: imagem do produto decodificada de base64 (inicialmente oculta)
        THIS.AddObject("img_4c_FigJpg", "Image")
        WITH THIS.img_4c_FigJpg
            .Top     = 457
            .Left    = 459
            .Width   = 143
            .Height  = 105
            .Stretch = 1
            .Visible = .F.
        ENDWITH

        *-- Label "Quantidade" (Say1 do legado)
        THIS.AddObject("lbl_4c_LblQtde", "Label")
        WITH THIS.lbl_4c_LblQtde
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Quantidade"
            .Top       = 455
            .Left      = 11
            .Width     = 74
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox Quantidade (Get_qtde do legado) - SigCdPco.qtds
        THIS.AddObject("txt_4c_Qtde", "TextBox")
        WITH THIS.txt_4c_Qtde
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Height    = 23
            .InputMask = "99999.999"
            .Left      = 9
            .Top       = 468
            .Width     = 74
            .BackColor = RGB(255, 255, 198)
            .ReadOnly  = .T.
            .Value     = 0
        ENDWITH

        *-- Label "Descricao Produto" (Say2 do legado)
        THIS.AddObject("lbl_4c_LblDescr", "Label")
        WITH THIS.lbl_4c_LblDescr
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o Produto"
            .Top       = 455
            .Left      = 92
            .Width     = 120
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox Descricao Produto (Get_descr do legado) - populado por CarregarFotoProduto
        THIS.AddObject("txt_4c_Descr", "TextBox")
        WITH THIS.txt_4c_Descr
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Height    = 23
            .Left      = 90
            .Top       = 468
            .Width     = 345
            .BackColor = RGB(255, 255, 198)
            .ForeColor = RGB(0, 0, 0)
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        *-- Label "Cliente" (Say3 do legado)
        THIS.AddObject("lbl_4c_LblCliente", "Label")
        WITH THIS.lbl_4c_LblCliente
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Cliente"
            .Top       = 494
            .Left      = 11
            .Width     = 50
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox Cliente (Get_Cliente do legado) - cursor_4c_Dados.Rclis
        THIS.AddObject("txt_4c_Cliente", "TextBox")
        WITH THIS.txt_4c_Cliente
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Height    = 23
            .Left      = 9
            .Top       = 507
            .Width     = 425
            .BackColor = RGB(255, 255, 221)
            .ForeColor = RGB(0, 0, 0)
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        *-- Label "Tempo Total do Envelope" (Say4 do legado)
        THIS.AddObject("lbl_4c_LblTEnv", "Label")
        WITH THIS.lbl_4c_LblTEnv
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Tempo Total do Envelope"
            .Top       = 532
            .Left      = 11
            .Width     = 130
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox Tempo Envelope (Get_tEnv do legado) - cursor_4c_Dados.TempU
        THIS.AddObject("txt_4c_TEnv", "TextBox")
        WITH THIS.txt_4c_TEnv
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Height    = 23
            .InputMask = "99999"
            .Left      = 9
            .Top       = 545
            .Width     = 74
            .BackColor = RGB(255, 255, 198)
            .ForeColor = RGB(0, 0, 0)
            .ReadOnly  = .T.
            .Value     = 0
        ENDWITH

        *-- Label "[ Operacao com Prioridade ]" (Label1 do legado)
        THIS.AddObject("lbl_4c_Prioridade", "Label")
        WITH THIS.lbl_4c_Prioridade
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "[ Opera" + CHR(231) + CHR(227) + "o com Prioridade ]"
            .Top       = 457
            .Left      = 617
            .Width     = 160
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
    ENDPROC

    *==========================================================================
    PROCEDURE GrdDadosAfterRowColChange
    *==========================================================================
        LPARAMETERS par_nColIndex
        LOCAL loc_oErro, loc_cCpros
        loc_cCpros = ""

        TRY
            THIS.LockScreen = .T.

            *-- Limpar campos de detalhe e foto antes de preencher
            THIS.img_4c_FigJpg.Visible = .F.
            THIS.img_4c_FigJpg.Picture = ""
            THIS.shp_4c_Shape4.Visible = .F.
            THIS.txt_4c_Descr.Value    = ""
            THIS.txt_4c_Qtde.Value     = 0
            THIS.txt_4c_Cliente.Value  = ""
            THIS.txt_4c_TEnv.Value     = 0

            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cCpros = ALLTRIM(NVL(Cpros, ""))

                *-- Preencher campos de detalhe da linha corrente
                THIS.txt_4c_Qtde.Value    = NVL(Qtds, 0)
                THIS.txt_4c_Cliente.Value = ALLTRIM(NVL(Rclis, ""))
                THIS.txt_4c_TEnv.Value    = NVL(TempU, 0)

                *-- Carregar foto e descricao do produto via BO
                IF !EMPTY(loc_cCpros) AND VARTYPE(THIS.this_oBusinessObject) = "O"
                    THIS.this_oBusinessObject.CarregarFotoProduto(loc_cCpros)

                    THIS.txt_4c_Descr.Value = ;
                        ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDescricaoProduto, ""))

                    IF !EMPTY(THIS.this_oBusinessObject.this_cFotoArquivo) AND ;
                       FILE(THIS.this_oBusinessObject.this_cFotoArquivo)
                        THIS.img_4c_FigJpg.Picture = THIS.this_oBusinessObject.this_cFotoArquivo
                        THIS.img_4c_FigJpg.Visible = .T.
                        THIS.shp_4c_Shape4.Visible  = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar detalhes da linha: " + loc_oErro.Message + ;
                    " Ln=" + TRANSFORM(loc_oErro.LineNo), "Erro Formsigprcpd")
        ENDTRY

        THIS.LockScreen = .F.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados
    *==========================================================================
        *-- Form OPERACIONAL flat: nao possui Page2/Dados separada.
        *-- Os controles de "detalhe" (Qtde, Descr, Cliente, TEnv, FigJpg,
        *-- Shape4, Prioridade) sao criados em ConfigurarDetalhesProduto(),
        *-- chamado diretamente por InicializarForm(). Metodo presente por
        *-- compatibilidade com o padrao multi-fase do pipeline (Fase 5/8);
        *-- nao cria controles (evitar AddObject duplicado).
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarLista
    *==========================================================================
        *-- Form OPERACIONAL: alias de CarregarDados (compatibilidade pipeline)
        THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    PROCEDURE BOParaForm
    *==========================================================================
        *-- Popula campos de exibicao a partir do BO e do cursor corrente
        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        THIS.cnt_4c_Container1.txt_4c_Fase.Value = THIS.this_cSetor
        THIS.cnt_4c_Container1.txt_4c_Data.Value = THIS.this_dData

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.cnt_4c_Container2.txt_4c_Cap.Value = THIS.this_oBusinessObject.this_nCapacidade
            THIS.cnt_4c_Container2.txt_4c_Utz.Value = THIS.this_oBusinessObject.this_nUtilizado
            THIS.cnt_4c_Container2.txt_4c_Sld.Value = THIS.this_oBusinessObject.this_nSaldo
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE FormParaBO
    *==========================================================================
        *-- Form OPERACIONAL read-only: sem campos editaveis para transferir ao BO
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROCEDURE HabilitarCampos
    *==========================================================================
        LPARAMETERS par_lHabilitar
        *-- Form OPERACIONAL: todos os campos sao ReadOnly - sem controles a habilitar
    ENDPROC

    *==========================================================================
    PROCEDURE LimparCampos
    *==========================================================================
        *-- Limpa todos os campos de exibicao do form
        THIS.cnt_4c_Container1.txt_4c_Fase.Value = ""
        THIS.cnt_4c_Container1.txt_4c_Data.Value = {}
        THIS.cnt_4c_Container2.txt_4c_Cap.Value  = 0
        THIS.cnt_4c_Container2.txt_4c_Utz.Value  = 0
        THIS.cnt_4c_Container2.txt_4c_Sld.Value  = 0
        THIS.txt_4c_Descr.Value    = ""
        THIS.txt_4c_Qtde.Value     = 0
        THIS.txt_4c_Cliente.Value  = ""
        THIS.txt_4c_TEnv.Value     = 0
        THIS.img_4c_FigJpg.Visible = .F.
        THIS.img_4c_FigJpg.Picture = ""
        THIS.shp_4c_Shape4.Visible = .F.
    ENDPROC

    *==========================================================================
    PROCEDURE AjustarBotoesPorModo
    *==========================================================================
        LPARAMETERS par_cModo
        *-- Form OPERACIONAL flat (sem botoes CRUD): sem ajuste de botoes por modo
    ENDPROC

    *==========================================================================
    PROCEDURE BtnEncerrarClick
    *==========================================================================
        THIS.Release()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnBuscarClick
    *==========================================================================
        *-- Recarrega os dados do banco (refresh da grade de capacidade produtiva)
        IF VARTYPE(THIS.this_oBusinessObject) != "O" OR gnConnHandle <= 0
            RETURN
        ENDIF
        THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnSalvarClick
    *==========================================================================
        *-- Form OPERACIONAL read-only: sem acao de salvar
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROCEDURE BtnCancelarClick
    *==========================================================================
        *-- Form OPERACIONAL: cancelar = encerrar o visualizador
        THIS.Release()
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
