*============================================================================
* FormSigPdAco.prg - Acompanhamento de Material por Grupo
* Tipo: OPERACIONAL - Relatorio de saldos de estoque por grupo de material
* Tabelas: SigMvEst, SigCdPro, SigMvCab, SigMvItn, SigCdGrp, SigCdPam, SigCdEmp
* Fase 8/8: Form - COMPLETO (todos os metodos implementados)
*   CRUD-equivalents: BtnIncluirClick, BtnAlterarClick, BtnVisualizarClick,
*                     BtnExcluirClick (delegacao para operacoes do relatorio)
*   Operacionais: BtnProcessarClick, BtnCmdRpviewClick, BtnCmdRpPrintClick,
*                 BtnCmdGprocessaClick, ArquivosInteractiveChange, Activate
*   Auxiliares: BtnBuscarClick, BtnEncerrarClick, BtnSalvarClick,
*               BtnCancelarClick, CarregarLista, AjustarBotoesPorModo,
*               HabilitarCampos, LimparCampos, FormParaBO, BOParaForm
*============================================================================

DEFINE CLASS FormSigPdAco AS FormBase

    *-- Layout pixel-perfect do legado SIGPDACO
    Width            = 800
    Height           = 600
    AutoCenter       = .T.
    BorderStyle      = 2
    TitleBar         = 0
    ControlBox       = .F.
    Closable         = .F.
    MaxButton        = .F.
    MinButton        = .F.
    Movable          = .F.
    WindowType       = 1
    ShowWindow       = 1
    DataSession      = 2
    Themes           = .F.
    KeyPreview       = .T.
    ClipControls     = .F.
    ZoomBox          = .F.
    ContinuousScroll = .F.
    Caption          = "Acompanhamento de Material por Grupo"
    Picture          = "..\framework\imagens\new_background.jpg"

    *-- Estado do form
    this_oBusinessObject = .NULL.
    this_lProcessamento  = .F.

    *==========================================================================
    * Init
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Constroi o form: BO + cursores base + containers
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        *-- Modo teste: pula setup completo (evita erros de Grid/ForeColor sem banco)
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPdAcoBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                *-- Configura aparencia base do form (OPERACIONAL sem PageFrame)
                THIS.ConfigurarPageFrame()

                *-- Cria cursores locais csRel + csCab (sem SQL, sempre executar)
                THIS.this_oBusinessObject.CriarCursorRelatorio()

                *-- Carrega parametros operacionais de SigCdPam (requer SQL)
                IF TYPE("gb_4c_ValidandoUI") != "L" .OR. !gb_4c_ValidandoUI
                    THIS.this_oBusinessObject.CarregarParametros()
                ENDIF

                THIS.ConfigurarCabecalho()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarAguarde()

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SigPdAcoBO.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Aparencia base do form (OPERACIONAL sem PageFrame)
    * Forms OPERACIONAIS nao tem PageFrame Page1/Page2 como CRUD.
    * Este metodo apenas define propriedades visuais globais do form.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.BackColor  = RGB(212, 208, 200)
        THIS.ScrollBars = 0
        THIS.ShowTips   = .T.
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
    ENDPROC

    *==========================================================================
    * AlternarPagina - Form OPERACIONAL plano: sem alternancia de paginas
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container escuro com titulo (equivale a cntSombra)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCnt = THIS.cnt_4c_Cabecalho
        WITH loc_oCnt
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCnt.lbl_4c_LblSombra
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Acompanhamento de Material por Grupo"
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCnt.lbl_4c_LblTitulo
            .Top       = 17
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Acompanhamento de Material por Grupo"
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarAguarde - Container de espera (Visible=.F., toggled por Processar)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAguarde()
        LOCAL loc_oCnt
        THIS.AddObject("cnt_4c_Aguarde", "Container")
        loc_oCnt = THIS.cnt_4c_Aguarde
        WITH loc_oCnt
            .Top           = 287
            .Left          = 117
            .Width         = 516
            .Height        = 139
            .SpecialEffect = 0
            .Visible       = .F.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .Top       = 28
            .Left      = 206
            .Width     = 105
            .Height    = 29
            .FontBold  = .T.
            .FontSize  = 14
            .Caption   = "Aguarde..."
            .ForeColor = RGB(255, 0, 0)
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .Top       = 79
            .Left      = 135
            .Width     = 242
            .Height    = 27
            .FontBold  = .T.
            .FontSize  = 14
            .Caption   = "Processando Dados ......"
            .ForeColor = RGB(0, 0, 160)
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *   EXCETO containers/controles com Visible=.F. intencional
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                *-- Controles que devem permanecer ocultos ate acao do usuario
                IF INLIST(UPPER(loc_oControl.Name), ;
                          "CNT_4C_AGUARDE",    ;
                          "CNT_4C_CABECALHO",  ;
                          "SHP_4C_SHPRP",      ;
                          "CMD_4C_CMDRPVIEW",  ;
                          "CMD_4C_CMDRPPRINT")
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) .AND. ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Activate - Processa dados na primeira ativacao do form
    *==========================================================================
    PROCEDURE Activate()
        DODEFAULT()
        IF !THIS.this_lProcessamento
            THIS.BtnProcessarClick()
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura layout operacional: grid + botoes + filtros
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oGrd

        *-- Container de fundo para area de botoes de relatorio (oculto ate processar)
        *-- Shape nao suporta ForeColor; Container suporta e evita "Property FORECOLOR is not found"
        THIS.AddObject("shp_4c_ShpRp", "Container")
        WITH THIS.shp_4c_ShpRp
            .Top         = 7
            .Left        = 552
            .Width       = 229
            .Height      = 110
            .BackStyle   = 1
            .BackColor   = RGB(136, 189, 188)
            .Visible     = .F.
        ENDWITH

        *-- Botao Processar (sempre visivel apos TornarControlesVisiveis)
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top             = 3
            .Left            = 500
            .Width           = 75
            .Height          = 75
            .Caption         = "Processar"
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
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")

        *-- Botao Visualizar relatorio em tela (oculto ate processar)
        THIS.AddObject("cmd_4c_CmdRpview", "CommandButton")
        WITH THIS.cmd_4c_CmdRpview
            .Top             = 3
            .Left            = 650
            .Width           = 75
            .Height          = 75
            .Caption         = "V" + CHR(237) + "deo"
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
            .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .Visible         = .F.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_CmdRpview, "Click", THIS, "BtnCmdRpviewClick")

        *-- Botao Imprimir relatorio (oculto ate processar)
        THIS.AddObject("cmd_4c_CmdRpPrint", "CommandButton")
        WITH THIS.cmd_4c_CmdRpPrint
            .Top             = 3
            .Left            = 575
            .Width           = 75
            .Height          = 75
            .Caption         = "Impressora"
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
            .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .Visible         = .F.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_CmdRpPrint, "Click", THIS, "BtnCmdRpPrintClick")

        *-- Container de saida canonico (cnt_4c_Saida) com botao Encerrar
        THIS.AddObject("cnt_4c_Saida", "Container")
        WITH THIS.cnt_4c_Saida
            .Top         = 0
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cnt_4c_Saida.cmd_4c_Encerrar
            .Left            = 5
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnCmdGprocessaClick")

        *-- Listbox de grupos para filtro (Arquivos no legado)
        THIS.AddObject("obj_4c_Arquivos", "ListBox")
        WITH THIS.obj_4c_Arquivos
            .Top           = 122
            .Left          = 84
            .Width         = 169
            .Height        = 79
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .RowSourceType = 1
            .Sorted        = .T.
        ENDWITH
        BINDEVENT(THIS.obj_4c_Arquivos, "InteractiveChange", THIS, "ArquivosInteractiveChange")

        *-- Label "Grupos :" (Label7 no legado)
        THIS.AddObject("lbl_4c_Label7", "Label")
        WITH THIS.lbl_4c_Label7
            .Top       = 124
            .Left      = 34
            .Width     = 48
            .Height    = 15
            .Caption   = "Grupos :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        *-- Grid principal (GrdF no legado) - 10 colunas mapeadas para csRel
        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrd = THIS.grd_4c_Dados
        WITH loc_oGrd
            .Top                = 205
            .Left               = 34
            .Width              = 732
            .Height             = 272
            .FontName           = "Verdana"
            .FontSize           = 8
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
        ENDWITH
        loc_oGrd.RecordSourceType   = 1
        loc_oGrd.ColumnCount        = 10
        loc_oGrd.RecordSource       = "csRel"
        loc_oGrd.HighlightBackColor = RGB(255, 255, 255)
        loc_oGrd.HighlightForeColor = RGB(15, 41, 104)
        loc_oGrd.HighlightStyle     = 2

        *-- Colunas: ControlSource + Header + Width (ordem identica ao csRel original)
        WITH loc_oGrd
            .Column1.ControlSource   = "csRel.Mat2s"
            .Column1.Width           = 80
            .Column1.Alignment       = 0
            .Column1.Header1.Caption = "Material"

            .Column2.ControlSource   = "csRel.Dcompo2s"
            .Column2.Width           = 130
            .Column2.Alignment       = 0
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

            .Column3.ControlSource   = "csRel.CUnis"
            .Column3.Width           = 27
            .Column3.Alignment       = 2
            .Column3.Header1.Caption = "Unid"

            .Column4.ControlSource   = "csRel.QtdMins"
            .Column4.Width           = 63
            .Column4.Alignment       = 2
            .Column4.Header1.Caption = "Qt.Minima"

            .Column5.ControlSource   = "csRel.Qtds"
            .Column5.Width           = 63
            .Column5.Alignment       = 2
            .Column5.Header1.Caption = "Saldo Atual"

            .Column6.ControlSource   = "csRel.QtdReqs"
            .Column6.Width           = 65
            .Column6.Alignment       = 2
            .Column6.Header1.Caption = "Requisi" + CHR(231) + CHR(227) + "o"

            .Column7.ControlSource   = "csRel.QtdPedcs"
            .Column7.Width           = 65
            .Column7.Alignment       = 2
            .Column7.Header1.Caption = "Ped.Compra"

            .Column8.ControlSource   = "csRel.QtdComps"
            .Column8.Width           = 65
            .Column8.Alignment       = 2
            .Column8.Header1.Caption = "Compra"

            .Column9.ControlSource   = "csRel.QtdEmphs"
            .Column9.Width           = 65
            .Column9.Alignment       = 2
            .Column9.Header1.Caption = "Empenho"

            .Column10.ControlSource   = "csRel.QtdPfins"
            .Column10.Width           = 70
            .Column10.Alignment       = 2
            .Column10.Header1.Caption = "Pos.Final *"
        ENDWITH

        *-- Propriedades visuais pixel-perfect (BackColor por coluna, ReadOnly, DynamicForeColor)
        THIS.ConfigurarGrdDados(loc_oGrd)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Rodape com notas explicativas
    *   Form OPERACIONAL nao tem Page2/Dados como CRUD. Este metodo agrupa
    *   os labels explicativos do calculo de Pos.Final exibidos abaixo do grid.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Label3: formula de Pos.Final (rodape pixel-perfect do legado)
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 487
            .Left      = 117
            .Width     = 585
            .Height    = 15
            .Caption   = "( * ) Pos.Final = Saldo Atual + Requisi" + CHR(231) + CHR(227) + "o + " + ;
                         "Ped.Compra + Compra - Empenho - Qt.M" + CHR(237) + "nima"
            .FontName  = "Tahoma"
            .FontBold  = .T.
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        *-- Label4: nota sobre marcadores [*] (peso medio)
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Top       = 507
            .Left      = 118
            .Width     = 372
            .Height    = 15
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o = [ * ]   Calculado pelo Peso M" + CHR(233) + "dio do Material"
            .FontName  = "Tahoma"
            .FontBold  = .T.
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inicia novo processamento (gera relatorio do zero)
    *   Form OPERACIONAL: "Incluir" equivale a iniciar nova geracao de relatorio
    *   resetando o estado anterior e executando processamento completo.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_lProcessamento = .F.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lProcessamento = .F.
        ENDIF
        THIS.shp_4c_ShpRp.Visible      = .F.
        THIS.cmd_4c_CmdRpview.Visible  = .F.
        THIS.cmd_4c_CmdRpPrint.Visible = .F.
        THIS.BtnProcessarClick()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Atualiza dados do relatorio (re-processamento)
    *   Form OPERACIONAL: "Alterar" equivale a atualizar/re-processar os dados
    *   mantendo o estado de processamento ja realizado.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        IF !THIS.this_lProcessamento
            THIS.BtnProcessarClick()
        ELSE
            LOCAL loc_lSucesso, loc_oErro
            loc_lSucesso = .F.

            THIS.cnt_4c_Aguarde.Visible = .T.
            THIS.cnt_4c_Aguarde.ZOrder(0)
            THIS.Refresh

            TRY
                loc_lSucesso = THIS.this_oBusinessObject.Atualizar(THIS.obj_4c_Arquivos)
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro")
            ENDTRY

            THIS.cnt_4c_Aguarde.Visible = .F.

            IF loc_lSucesso
                IF THIS.obj_4c_Arquivos.ListCount > 0 .AND. ;
                   !EMPTY(THIS.obj_4c_Arquivos.Value)
                    THIS.ArquivosInteractiveChange()
                ENDIF
                THIS.grd_4c_Dados.Refresh
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualiza o relatorio em tela
    *   Form OPERACIONAL: "Visualizar" equivale ao preview do relatorio gerado.
    *   Exige que o processamento ja tenha sido executado.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        IF !THIS.this_lProcessamento .OR. !USED("csRel") .OR. RECCOUNT("csRel") = 0
            MsgAviso("Execute o processamento antes de visualizar o relat" + CHR(243) + "rio.", "Aviso")
            RETURN
        ENDIF
        THIS.BtnCmdRpviewClick()
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Limpa dados do relatorio (reset)
    *   Form OPERACIONAL: "Excluir" equivale a limpar o cursor csRel e resetar
    *   o estado de processamento, ocultando botoes de visualizacao/impressao.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        IF !MsgConfirma("Deseja realmente limpar os dados do relat" + CHR(243) + "rio?", "Confirma" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF USED("csRel")
            SELECT csRel
            ZAP
        ENDIF

        THIS.this_lProcessamento = .F.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lProcessamento = .F.
        ENDIF

        THIS.shp_4c_ShpRp.Visible      = .F.
        THIS.cmd_4c_CmdRpview.Visible  = .F.
        THIS.cmd_4c_CmdRpPrint.Visible = .F.
        THIS.grd_4c_Dados.Refresh
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - Processa dados e popula grid
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        THIS.cnt_4c_Aguarde.Visible = .T.
        THIS.cnt_4c_Aguarde.ZOrder(0)
        THIS.Refresh

        TRY
            IF THIS.this_lProcessamento
                loc_lSucesso = THIS.this_oBusinessObject.Atualizar(THIS.obj_4c_Arquivos)
            ELSE
                loc_lSucesso = THIS.this_oBusinessObject.Inserir(THIS.obj_4c_Arquivos)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        THIS.cnt_4c_Aguarde.Visible = .F.

        IF loc_lSucesso
            THIS.this_lProcessamento = .T.
            THIS.AplicarDynamicForeColor()

            IF USED("csRel") .AND. RECCOUNT("csRel") > 0
                *-- Seleciona primeiro grupo da lista e filtra o grid (padrao original)
                IF THIS.obj_4c_Arquivos.ListCount > 0
                    THIS.obj_4c_Arquivos.ListIndex = 1
                    THIS.ArquivosInteractiveChange()
                ENDIF
                THIS.grd_4c_Dados.Refresh
                THIS.shp_4c_ShpRp.Visible     = .T.
                THIS.cmd_4c_CmdRpview.Visible  = .T.
                THIS.cmd_4c_CmdRpPrint.Visible = .T.
                THIS.obj_4c_Arquivos.SetFocus
            ELSE
                MsgAviso("N" + CHR(227) + "o Existe Movimenta" + CHR(231) + CHR(227) + "o!!!", "Aviso")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCmdRpviewClick - Exibe relatorio em tela (Preview)
    *==========================================================================
    PROCEDURE BtnCmdRpviewClick()
        LOCAL loc_cSub, loc_cRelatorio
        loc_cSub       = ""
        loc_cRelatorio = gc_4c_CaminhoReports + "RelSigPdAco.frx"

        IF !EMPTY(THIS.obj_4c_Arquivos.Value)
            loc_cSub = ALLTRIM(THIS.obj_4c_Arquivos.Value)
        ENDIF

        THIS.this_oBusinessObject.AtualizarCabecalhoRelatorio(loc_cSub)

        IF FILE(loc_cRelatorio)
            REPORT FORM (loc_cRelatorio) PREVIEW NOCONSOLE
        ELSE
            MsgAviso("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + loc_cRelatorio, ;
                     "Relat" + CHR(243) + "rio")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCmdRpPrintClick - Imprime relatorio na impressora
    *==========================================================================
    PROCEDURE BtnCmdRpPrintClick()
        LOCAL loc_cSub, loc_cRelatorio
        loc_cSub       = ""
        loc_cRelatorio = gc_4c_CaminhoReports + "RelSigPdAco.frx"

        IF !EMPTY(THIS.obj_4c_Arquivos.Value)
            loc_cSub = ALLTRIM(THIS.obj_4c_Arquivos.Value)
        ENDIF

        THIS.this_oBusinessObject.AtualizarCabecalhoRelatorio(loc_cSub)

        IF FILE(loc_cRelatorio)
            REPORT FORM (loc_cRelatorio) TO PRINTER PROMPT NOCONSOLE
        ELSE
            MsgAviso("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + loc_cRelatorio, ;
                     "Relat" + CHR(243) + "rio")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCmdGprocessaClick - Encerra o formulario
    *   par_nButton: indice do botao clicado no CommandGroup (sempre 1)
    *==========================================================================
    PROCEDURE BtnCmdGprocessaClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * ArquivosInteractiveChange - Filtra grid pelo grupo selecionado no listbox
    *==========================================================================
    PROCEDURE ArquivosInteractiveChange()
        LOCAL loc_cGrupo

        IF VARTYPE(THIS.obj_4c_Arquivos) = "O" .AND. ;
           !EMPTY(THIS.obj_4c_Arquivos.Value)
            loc_cGrupo = ALLTRIM(LEFT(THIS.obj_4c_Arquivos.Value, 3))
            THIS.this_oBusinessObject.FiltrarPorGrupo(loc_cGrupo)
            THIS.grd_4c_Dados.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * AplicarDynamicForeColor - Aplica DynamicForeColor nas colunas do grid
    *   Chamado apos processamento de dados (nao durante init) para evitar
    *   "Property FORECOLOR is not found" em colunas de grid criadas em runtime.
    *==========================================================================
    PROTECTED PROCEDURE AplicarDynamicForeColor()
        LOCAL loc_cDynExpr, loc_i, loc_oGrd
        loc_cDynExpr = "IIF(csRel.Flags .AND. csRel.Seqs <> [2], RGB(255,0,0), " + ;
                       "IIF(csRel.Seqs = [2], RGB(0,0,255), RGB(0,0,0)))"
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            loc_oGrd = THIS.grd_4c_Dados
            FOR loc_i = 1 TO loc_oGrd.ColumnCount
                loc_oGrd.Columns(loc_i).DynamicForeColor = loc_cDynExpr
            ENDFOR
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarGrdDados - Propriedades visuais pixel-perfect das colunas do grid
    *   BackColor por coluna, ReadOnly/Movable/Resizable, Text1 props
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrdDados(par_oGrd)
        LOCAL loc_oGrd
        loc_oGrd = par_oGrd

        *-- Coluna 1: Material (laranja - destaque)
        WITH loc_oGrd.Column1
            .ReadOnly   = .T.
            .Movable    = .F.
            .Resizable  = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Text1.BackColor   = RGB(255, 197, 138)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
        ENDWITH

        *-- Coluna 2: Descricao (branco)
        WITH loc_oGrd.Column2
            .ReadOnly   = .T.
            .Movable    = .F.
            .Resizable  = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Text1.BackColor   = RGB(255, 255, 255)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
        ENDWITH

        *-- Coluna 3: Unidade (branco)
        WITH loc_oGrd.Column3
            .ReadOnly   = .T.
            .Movable    = .F.
            .Resizable  = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Text1.BackColor   = RGB(255, 255, 255)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
        ENDWITH

        *-- Coluna 4: Qt.Minima (azul claro)
        WITH loc_oGrd.Column4
            .ReadOnly   = .T.
            .Movable    = .F.
            .Resizable  = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Text1.BackColor   = RGB(201, 204, 248)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
        ENDWITH

        *-- Coluna 5: Saldo Atual (amarelo claro)
        WITH loc_oGrd.Column5
            .ReadOnly   = .T.
            .Movable    = .F.
            .Resizable  = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Text1.BackColor   = RGB(255, 255, 196)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
        ENDWITH

        *-- Coluna 6: Requisicao (ciano claro)
        WITH loc_oGrd.Column6
            .ReadOnly   = .T.
            .Movable    = .F.
            .Resizable  = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Text1.BackColor   = RGB(223, 255, 255)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
        ENDWITH

        *-- Coluna 7: Ped.Compra (rosa claro - Format=Z, editavel para transferencia)
        WITH loc_oGrd.Column7
            .Movable    = .F.
            .Resizable  = .F.
            .Format     = "Z"
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Text1.BackColor   = RGB(255, 234, 255)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
        ENDWITH

        *-- Coluna 8: Compra (pessego claro)
        WITH loc_oGrd.Column8
            .ReadOnly   = .T.
            .Movable    = .F.
            .Resizable  = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Text1.BackColor   = RGB(255, 235, 215)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
        ENDWITH

        *-- Coluna 9: Empenho (vermelho claro)
        WITH loc_oGrd.Column9
            .ReadOnly   = .T.
            .Movable    = .F.
            .Resizable  = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Text1.BackColor   = RGB(255, 202, 202)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
        ENDWITH

        *-- Coluna 10: Pos.Final (verde claro)
        WITH loc_oGrd.Column10
            .Movable    = .F.
            .Resizable  = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Text1.BackColor   = RGB(220, 255, 220)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
        ENDWITH

    ENDPROC

    *==========================================================================
    * Destroy - Libera BO e cursores do form
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        LOCAL loc_aCursores(3), loc_i
        loc_aCursores(1) = "csRel"
        loc_aCursores(2) = "csCab"
        loc_aCursores(3) = "dbCabecalho"

        FOR loc_i = 1 TO 3
            IF USED(loc_aCursores(loc_i))
                USE IN (loc_aCursores(loc_i))
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Aciona processamento ou re-filtro do grid
    *   Form OPERACIONAL: se ainda nao processado, executa BtnProcessarClick.
    *   Se ja processado, re-aplica o filtro do grupo selecionado no listbox.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        IF !THIS.this_lProcessamento
            THIS.BtnProcessarClick()
        ELSE
            THIS.ArquivosInteractiveChange()
            THIS.grd_4c_Dados.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Encerra o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Atualiza cabecalho do relatorio com grupo selecionado
    *   Form OPERACIONAL: nao ha registros editaveis para persistir no banco.
    *   Transfere o grupo ativo como subtitulo para o cursor csCab do relatorio.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_cSub
        loc_cSub = ""

        IF THIS.this_lProcessamento .AND. VARTYPE(THIS.this_oBusinessObject) = "O"
            IF VARTYPE(THIS.obj_4c_Arquivos) = "O" .AND. ;
               !EMPTY(THIS.obj_4c_Arquivos.Value)
                loc_cSub = ALLTRIM(THIS.obj_4c_Arquivos.Value)
            ENDIF
            THIS.this_oBusinessObject.AtualizarCabecalhoRelatorio(loc_cSub)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela processamento atual e reseta o form
    *   Form OPERACIONAL: limpa o cursor csRel, o listbox de grupos e reseta
    *   o flag de processamento para permitir novo ciclo.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        IF THIS.this_lProcessamento
            IF !MsgConfirma("Deseja cancelar o processamento atual?", ;
                            "Confirma" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
        ENDIF

        THIS.LimparCampos()
    ENDPROC

    *==========================================================================
    * CarregarLista - Atualiza exibicao do grid com dados do cursor csRel
    *   Form OPERACIONAL: nao executa SQL. Aplica filtro de grupo ativo se
    *   houver um selecionado no listbox; caso contrario, remove filtro.
    *==========================================================================
    PROCEDURE CarregarLista()
        IF !USED("csRel")
            RETURN
        ENDIF

        IF VARTYPE(THIS.obj_4c_Arquivos) = "O" .AND. ;
           !EMPTY(THIS.obj_4c_Arquivos.Value)
            THIS.ArquivosInteractiveChange()
        ELSE
            SELECT csRel
            SET ORDER TO TAG GruMat
            SET KEY TO
            GO TOP
        ENDIF

        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Gerencia visibilidade de botoes conforme estado
    *   Form OPERACIONAL: mostra/oculta os botoes de relatorio (Video,
    *   Impressora, ShpRp) de acordo com o estado de processamento atual.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lProcessado
        loc_lProcessado = THIS.this_lProcessamento .AND. ;
                          USED("csRel") .AND. RECCOUNT("csRel") > 0

        IF VARTYPE(THIS.shp_4c_ShpRp) = "O"
            THIS.shp_4c_ShpRp.Visible = loc_lProcessado
        ENDIF
        IF VARTYPE(THIS.cmd_4c_CmdRpview) = "O"
            THIS.cmd_4c_CmdRpview.Visible = loc_lProcessado
        ENDIF
        IF VARTYPE(THIS.cmd_4c_CmdRpPrint) = "O"
            THIS.cmd_4c_CmdRpPrint.Visible = loc_lProcessado
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita controles conforme estado
    *   Form OPERACIONAL: controla o listbox de grupos (apenas quando ha
    *   dados processados). Botao Processar permanece sempre habilitado.
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        IF VARTYPE(THIS.obj_4c_Arquivos) = "O"
            THIS.obj_4c_Arquivos.Enabled = par_lHabilitar
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Processar) = "O"
            THIS.cmd_4c_Processar.Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa dados processados e reseta estado do form
    *   Form OPERACIONAL: zera cursor csRel, limpa listbox, oculta botoes de
    *   relatorio e reseta flags de processamento no form e no BO.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        IF USED("csRel")
            SELECT csRel
            SET KEY TO
            ZAP
        ENDIF

        IF USED("csCab")
            SELECT csCab
            ZAP
            APPEND BLANK
        ENDIF

        IF VARTYPE(THIS.obj_4c_Arquivos) = "O"
            THIS.obj_4c_Arquivos.Clear()
        ENDIF

        THIS.this_lProcessamento = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lProcessamento = .F.
            THIS.this_oBusinessObject.this_cGrupoAtual    = ""
        ENDIF

        THIS.AjustarBotoesPorModo()

        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere estado do form para o Business Object
    *   Form OPERACIONAL: transfere o grupo selecionado no listbox e o
    *   subtitulo derivado para as propriedades correspondentes do BO.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        *-- Grupo selecionado no listbox -> BO
        IF VARTYPE(THIS.obj_4c_Arquivos) = "O" .AND. ;
           !EMPTY(THIS.obj_4c_Arquivos.Value)
            THIS.this_oBusinessObject.this_cGrupoAtual = ;
                ALLTRIM(LEFT(THIS.obj_4c_Arquivos.Value, 3))
        ELSE
            THIS.this_oBusinessObject.this_cGrupoAtual = ""
        ENDIF

        *-- Subtitulo do relatorio = grupo ativo
        THIS.this_oBusinessObject.this_cSubTitulo = ;
            THIS.this_oBusinessObject.this_cGrupoAtual
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere estado do Business Object para o form
    *   Form OPERACIONAL: sincroniza selecao do listbox de grupos com o
    *   filtro ativo no BO e reaplica o filtro no cursor csRel.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_cGrupo, loc_i

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        *-- Sincroniza selecao do listbox com grupo ativo no BO
        IF !EMPTY(THIS.this_oBusinessObject.this_cGrupoAtual) .AND. ;
           VARTYPE(THIS.obj_4c_Arquivos) = "O" .AND. ;
           THIS.obj_4c_Arquivos.ListCount > 0
            loc_cGrupo = ALLTRIM(THIS.this_oBusinessObject.this_cGrupoAtual)
            FOR loc_i = 1 TO THIS.obj_4c_Arquivos.ListCount
                IF UPPER(LEFT(ALLTRIM(THIS.obj_4c_Arquivos.List(loc_i)), 3)) = UPPER(loc_cGrupo)
                    THIS.obj_4c_Arquivos.ListIndex = loc_i
                    EXIT
                ENDIF
            ENDFOR
        ENDIF

        *-- Reaplica filtro de grupo no cursor csRel
        IF !EMPTY(THIS.this_oBusinessObject.this_cGrupoAtual)
            THIS.this_oBusinessObject.FiltrarPorGrupo(THIS.this_oBusinessObject.this_cGrupoAtual)
        ENDIF
    ENDPROC

ENDDEFINE
