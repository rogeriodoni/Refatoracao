*==============================================================================
* FormPzo.prg - Form Operacional: Prazo e Conta de Entrega por Operacao
* SCX Origem: SigCdPzo.SCX
* Herda de: FormBase
* Tipo: OPERACIONAL - modal, flat layout, sub-form de movimentacao
*
* Chamada: DO FORM FormPzo WITH par_oFormPai
*   par_oFormPai: referencia ao form pai (ex: FormSigAtCrp)
*   Cursores necessarios no pai: TprMvCab, CrSigCdOpe, CrSigMvNfi, crTpmMvItn, TprMvCabG
*
* Fluxo:
*   Init armazena referencia ao pai -> DODEFAULT() chama InicializarForm
*   InicializarForm cria BO, inicializa CsPrazE e constroi interface plana
*   EncerrarClick valida prazos/fretes via BO.Confirmar() e fecha o form
*==============================================================================

DEFINE CLASS FormPzo AS FormBase

    *-- Propriedades visuais (pixel-perfect SCX original - PILAR 1)
    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    Caption      = "Prazo / Conta de Entrega"
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    Movable      = .F.
    ClipControls = .F.
    KeyPreview   = .T.
    Themes       = .F.
    BorderStyle  = 2
    DataSession  = 1

    *-- Referencia ao form pai e BO
    this_oFormPai        = .NULL.
    this_oBusinessObject = .NULL.

    *==========================================================================
    * Init - Armazena referencia ao form pai antes de DODEFAULT
    *==========================================================================
    PROCEDURE Init(par_oFormPai)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        loc_lResultado = DODEFAULT()
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria BO, inicializa CsPrazE e constroi interface
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            *-- Instanciar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("PzoBO")
            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Erro ao criar PzoBO. VARTYPE retornou: " + ;
                        VARTYPE(THIS.this_oBusinessObject), "FormPzo.InicializarForm")
            ELSE
                *-- Obter modo de edicao do form pai
                IF VARTYPE(THIS.this_oFormPai) = "O"
                    IF VARTYPE(THIS.this_oFormPai.this_cModoAtual) = "C" AND ;
                       !EMPTY(THIS.this_oFormPai.this_cModoAtual)
                        THIS.this_oBusinessObject.this_cEscolha = ;
                            THIS.this_oFormPai.this_cModoAtual
                    ENDIF
                ENDIF

                *-- Sem form pai (teste automatico): nao inicializar dados
                IF VARTYPE(THIS.this_oFormPai) <> "O"
                    loc_lSucesso = .T.
                ELSE
                    *-- Inicializar dados via BO (cria CsPrazE e demais cursores auxiliares)
                    IF THIS.this_oBusinessObject.InicializarDados(THIS.this_oFormPai)

                        *-- Indexar TprMvCabG por Abrevs para os SEEKs na navegacao
                        IF USED("TprMvCabG")
                            SELECT TprMvCabG
                            INDEX ON Abrevs TAG Abrevs
                        ENDIF

                        *-- Construir interface plana (sem PageFrame)
                        THIS.ConfigurarCabecalho()
                        THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                        THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
                        THIS.ConfigurarPaginaLista()
                        THIS.ConfigurarBotaoEncerrar()
                        THIS.BindEventos()

                        *-- Atualizar totais iniciais na tela (usando totais da NF do pai)
                        THIS.txt_4c_FrtT.Value  = THIS.this_oBusinessObject.this_nFrtTotal
                        THIS.txt_4c_FrtI.Value  = THIS.this_oBusinessObject.this_nFrtInformado
                        THIS.txt_4c_DespT.Value = THIS.this_oBusinessObject.this_nDespTotal
                        THIS.txt_4c_DespI.Value = THIS.this_oBusinessObject.this_nDespInformado
                        THIS.txt_4c_SegT.Value  = THIS.this_oBusinessObject.this_nSegTotal
                        THIS.txt_4c_SegI.Value  = THIS.this_oBusinessObject.this_nSegInformado

                        *-- Posicionar na primeira linha e atualizar containers
                        IF USED("CsPrazE") AND RECCOUNT("CsPrazE") > 0
                            SELECT CsPrazE
                            GO TOP
                            THIS.AtualizarLinhaGrid(1)
                        ENDIF

                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormPzo.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container escuro com titulo do form
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt
        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra
        WITH loc_oCnt
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCnt.lbl_4c_Sombra
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .AutoSize      = .F.
            .Caption       = "Prazo / Conta de Entrega"
            .Height        = 40
            .Left          = 10
            .Top           = 18
            .Width         = 769
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCnt.lbl_4c_Titulo
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 18
            .WordWrap   = .T.
            .Alignment  = 0
            .BackStyle  = 0
            .AutoSize   = .F.
            .Caption    = "Prazo / Conta de Entrega"
            .Height     = 46
            .Left       = 10
            .Top        = 17
            .Width      = 769
            .ForeColor  = RGB(255, 255, 255)
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Orquestra lado LISTA: grid, entrega e binding
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        *-- 1. Grid de operacoes (estrutura de colunas)
        THIS.ConfigurarGrid()

        *-- 2. Campos suplementares/DADOS (totais + observacao)
        THIS.ConfigurarPaginaDados()

        *-- 3. Container de entrega (inicialmente oculto ate selecao de linha)
        THIS.ConfigurarContainerEntrega()

        *-- 4. Conectar grid ao cursor CsPrazE (RecordSource + ControlSources)
        THIS.ConfigurarGridDados()

        *-- 5. Formas decorativas (Shape1/3/4/5 do original SCX)
        THIS.ConfigurarFormas()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Campos DADOS parte 1 (totais + observacao)
    *   Forma OPERACIONAL sem PageFrame - agrega os controles de dados abaixo
    *   do grid: area de totais Frete/Desp/Seguro + container de observacao
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Area de totais (Frete/Despesas Acessorias/Seguro): 6 labels + 6 textboxes
        THIS.ConfigurarAreaTotais()

        *-- Container de observacao (codigo + memo, oculto ate selecao de linha)
        THIS.ConfigurarContainerObservacao()
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna visibilidade dos paineis suplementares por linha
    *   par_nDtEntrs : valor do campo DtEntrs da operacao corrente
    *   par_nDigObs  : valor do campo DigObs da operacao corrente
    *==========================================================================
    FUNCTION AlternarPagina(par_nDtEntrs, par_nDigObs)
        LOCAL loc_nDtEntrs, loc_nDigObs
        loc_nDtEntrs = IIF(VARTYPE(par_nDtEntrs) = "N", par_nDtEntrs, 0)
        loc_nDigObs  = IIF(VARTYPE(par_nDigObs)  = "N", par_nDigObs,  0)

        *-- Entrega visivel quando DtEntrs IN (3,4,5,6) - tipos de entrega com destinatario
        THIS.cnt_4c_Entrega.Visible    = INLIST(loc_nDtEntrs, 3, 4, 5, 6)

        *-- Observacao visivel quando DigObs IN (1,3) - digitacao de observacao permitida
        THIS.cnt_4c_Observacao.Visible = INLIST(loc_nDigObs, 1, 3)

        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * ConfigurarGrid - Grid principal mostrando CsPrazE por operacao
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid, loc_oCol

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados

        WITH loc_oGrid
            .Top               = 89
            .Left              = 7
            .Width             = 889
            .Height            = 246
            .ColumnCount       = 5
            .FontName          = "Verdana"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .HeaderHeight      = 20
            .RowHeight         = 16
            .ScrollBars        = 2
            .SplitBar          = .F.
            .GridLineColor     = RGB(238, 238, 238)
            .Themes            = .F.
            .Visible           = .T.
        ENDWITH

        *-- Column1: Movimentacao (Dopes) - somente leitura
        loc_oCol = loc_oGrid.Column1
        WITH loc_oCol
            .ColumnOrder      = 1
            .Width            = 290
            .ReadOnly         = .T.
            .FontName         = "Verdana"
            .FontSize         = 8
        ENDWITH
        loc_oCol.Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
        loc_oCol.Header1.FontName  = "Verdana"
        loc_oCol.Header1.FontSize  = 8
        loc_oCol.Header1.Alignment = 2
        loc_oCol.Text1.BorderStyle = 0
        loc_oCol.Text1.Margin      = 0
        loc_oCol.Text1.ReadOnly    = .T.
        loc_oCol.Text1.ForeColor   = RGB(0, 0, 0)
        loc_oCol.Text1.BackColor   = RGB(255, 255, 255)

        *-- Column2: Prazo de Entrega (Prazos) - editavel quando DtEntrs IN (1,4,6)
        loc_oCol = loc_oGrid.Column2
        WITH loc_oCol
            .ColumnOrder          = 2
            .Width                = 113
            .FontName             = "Verdana"
            .FontSize             = 8
            .DynamicReadOnly      = "!INLIST(CsPrazE.DtEntrs, 1, 4, 6)"
        ENDWITH
        loc_oCol.Header1.Caption       = "Data"
        loc_oCol.Header1.FontName      = "Verdana"
        loc_oCol.Header1.FontSize      = 8
        loc_oCol.Header1.Alignment     = 2
        loc_oCol.Text1.StrictDateEntry = 0
        loc_oCol.Text1.BorderStyle     = 0
        loc_oCol.Text1.Format          = "E"
        loc_oCol.Text1.InputMask       = "99/99/9999"
        loc_oCol.Text1.Margin          = 0
        loc_oCol.Text1.MaxLength       = 10
        loc_oCol.Text1.ForeColor       = RGB(0, 0, 0)
        loc_oCol.Text1.BackColor       = RGB(255, 255, 255)

        *-- Column3: Frete (VlFretes) - editavel quando nFiscals IN (1,2)
        loc_oCol = loc_oGrid.Column3
        WITH loc_oCol
            .ColumnOrder      = 3
            .Width            = 150
            .InputMask        = "999,999,999.99"
            .FontName         = "Verdana"
            .FontSize         = 8
            .DynamicReadOnly  = "!INLIST(CsPrazE.nFiscals, 1, 2)"
        ENDWITH
        loc_oCol.Header1.Caption   = "Frete"
        loc_oCol.Header1.FontName  = "Verdana"
        loc_oCol.Header1.FontSize  = 8
        loc_oCol.Header1.Alignment = 2
        loc_oCol.Text1.BorderStyle = 0
        loc_oCol.Text1.Margin      = 0
        loc_oCol.Text1.ForeColor   = RGB(0, 0, 0)
        loc_oCol.Text1.BackColor   = RGB(255, 255, 255)

        *-- Column4: Despesas Acessorias (DespAces) - editavel quando nFiscals IN (1,2)
        loc_oCol = loc_oGrid.Column4
        WITH loc_oCol
            .ColumnOrder      = 4
            .Width            = 150
            .InputMask        = "999,999,999.99"
            .FontName         = "Verdana"
            .FontSize         = 8
            .DynamicReadOnly  = "!INLIST(CsPrazE.nFiscals, 1, 2)"
        ENDWITH
        loc_oCol.Header1.Caption   = "Despesas Acess" + CHR(243) + "rias"
        loc_oCol.Header1.FontName  = "Verdana"
        loc_oCol.Header1.FontSize  = 8
        loc_oCol.Header1.Alignment = 2
        loc_oCol.Text1.BorderStyle = 0
        loc_oCol.Text1.Margin      = 0
        loc_oCol.Text1.ForeColor   = RGB(0, 0, 0)
        loc_oCol.Text1.BackColor   = RGB(255, 255, 255)

        *-- Column5: Seguro (VlSeguros) - editavel quando nFiscals IN (1,2)
        loc_oCol = loc_oGrid.Column5
        WITH loc_oCol
            .ColumnOrder      = 5
            .Width            = 150
            .InputMask        = "999,999,999.99"
            .FontName         = "Verdana"
            .FontSize         = 8
            .DynamicReadOnly  = "!INLIST(CsPrazE.nFiscals, 1, 2)"
        ENDWITH
        loc_oCol.Header1.Caption   = "Seguro"
        loc_oCol.Header1.FontName  = "Verdana"
        loc_oCol.Header1.FontSize  = 8
        loc_oCol.Header1.Alignment = 2
        loc_oCol.Text1.BorderStyle = 0
        loc_oCol.Text1.Margin      = 0
        loc_oCol.Text1.ForeColor   = RGB(0, 0, 0)
        loc_oCol.Text1.BackColor   = RGB(255, 255, 255)
    ENDPROC

    *==========================================================================
    * ConfigurarGridDados - Define RecordSource/ControlSources e coloracao
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGridDados()
        LOCAL loc_oGrid
        LOCAL loc_cDynFc, loc_nQtdSc, loc_nVez, loc_nCor
        loc_oGrid = THIS.grd_4c_Dados

        loc_oGrid.RecordSource     = "CsPrazE"
        loc_oGrid.RecordSourceType = 1
        loc_oGrid.Column1.ControlSource = "CsPrazE.Dopes"
        loc_oGrid.Column2.ControlSource = "CsPrazE.Prazos"
        loc_oGrid.Column3.ControlSource = "CsPrazE.VlFretes"
        loc_oGrid.Column4.ControlSource = "CsPrazE.DespAces"
        loc_oGrid.Column5.ControlSource = "CsPrazE.VlSeguros"
        loc_oGrid.Refresh()

        *-- Coloracao dinamica por grupo de operacao (nCors diferencia grupos)
        IF USED("CsPedidos")
            loc_cDynFc = ""
            loc_nQtdSc = 0
            loc_nVez   = 0
            SELECT CsPedidos
            SET ORDER TO nCors
            GO TOP
            SCAN
                loc_nCor   = CsPedidos.nCors
                loc_cDynFc = loc_cDynFc + "Iif(InList(CsPrazE.Abrevs,"
                loc_nQtdSc = loc_nQtdSc + 1
                SCAN WHILE nCors = loc_nCor
                    IF loc_nVez > 0
                        loc_cDynFc = loc_cDynFc + ","
                    ENDIF
                    loc_cDynFc = loc_cDynFc + "'" + ALLTRIM(Abrevs) + "'"
                    loc_nVez   = loc_nVez + 1
                ENDSCAN
                SKIP -1
                loc_cDynFc = loc_cDynFc + ")," + ALLTRIM(STR(loc_nCor)) + ","
                loc_nVez = 0
            ENDSCAN
            SET ORDER TO Abrevs
            IF loc_nQtdSc > 0
                loc_cDynFc = loc_cDynFc + "0" + REPLICATE(")", loc_nQtdSc)
                loc_oGrid.SetAll("DynamicForeColor", loc_cDynFc, "Column")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarAreaTotais - Labels e TextBoxes de Frete/Desp.Acess/Seguro
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAreaTotais()
        *-- Background da area de totais
        THIS.AddObject("cnt_4c_BgTotais", "Container")
        WITH THIS.cnt_4c_BgTotais
            .Top         = 342
            .Left        = 7
            .Width       = 889
            .Height      = 73
            .BackStyle   = 1
            .BackColor   = RGB(188, 201, 254)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- === FRETE ===
        THIS.AddObject("lbl_4c_FrtTit", "Label")
        WITH THIS.lbl_4c_FrtTit
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Frete"
            .Left      = 44
            .Top       = 347
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_FrtTot", "Label")
        WITH THIS.lbl_4c_FrtTot
            .AutoSize  = .T.
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Total"
            .Left      = 44
            .Top       = 372
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_FrtT", "TextBox")
        WITH THIS.txt_4c_FrtT
            .FontBold  = .T.
            .Alignment = 3
            .Value     = 0
            .Height    = 23
            .InputMask = "9999,999.99"
            .Left      = 44
            .Top       = 385
            .Width     = 95
            .ForeColor = RGB(0, 0, 0)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_FrtInf", "Label")
        WITH THIS.lbl_4c_FrtInf
            .AutoSize  = .T.
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Informado"
            .Left      = 142
            .Top       = 372
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_FrtI", "TextBox")
        WITH THIS.txt_4c_FrtI
            .FontBold  = .T.
            .Alignment = 3
            .Value     = 0
            .Height    = 23
            .InputMask = "9999,999.99"
            .Left      = 142
            .Top       = 385
            .Width     = 95
            .ForeColor = RGB(0, 0, 0)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- === DESPESAS ACESSORIAS ===
        THIS.AddObject("lbl_4c_DespTit", "Label")
        WITH THIS.lbl_4c_DespTit
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Despesas Acess" + CHR(243) + "rias"
            .Left      = 315
            .Top       = 347
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_DespTot", "Label")
        WITH THIS.lbl_4c_DespTot
            .AutoSize  = .T.
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Total"
            .Left      = 315
            .Top       = 372
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DespT", "TextBox")
        WITH THIS.txt_4c_DespT
            .FontBold  = .T.
            .Alignment = 3
            .Value     = 0
            .Height    = 23
            .InputMask = "9999,999.99"
            .Left      = 315
            .Top       = 385
            .Width     = 95
            .ForeColor = RGB(0, 0, 0)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_DespInf", "Label")
        WITH THIS.lbl_4c_DespInf
            .AutoSize  = .T.
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Informado"
            .Left      = 413
            .Top       = 372
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DespI", "TextBox")
        WITH THIS.txt_4c_DespI
            .FontBold  = .T.
            .Alignment = 3
            .Value     = 0
            .Height    = 23
            .InputMask = "9999,999.99"
            .Left      = 413
            .Top       = 385
            .Width     = 95
            .ForeColor = RGB(0, 0, 0)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- === SEGURO ===
        THIS.AddObject("lbl_4c_SegTit", "Label")
        WITH THIS.lbl_4c_SegTit
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Seguro"
            .Left      = 586
            .Top       = 347
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_SegTot", "Label")
        WITH THIS.lbl_4c_SegTot
            .AutoSize  = .T.
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Total"
            .Left      = 586
            .Top       = 372
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_SegT", "TextBox")
        WITH THIS.txt_4c_SegT
            .FontBold  = .T.
            .Alignment = 3
            .Value     = 0
            .Height    = 23
            .InputMask = "9999,999.99"
            .Left      = 586
            .Top       = 385
            .Width     = 95
            .ForeColor = RGB(0, 0, 0)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_SegInf", "Label")
        WITH THIS.lbl_4c_SegInf
            .AutoSize  = .T.
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Informado"
            .Left      = 684
            .Top       = 372
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_SegI", "TextBox")
        WITH THIS.txt_4c_SegI
            .FontBold  = .T.
            .Alignment = 3
            .Value     = 0
            .Height    = 23
            .InputMask = "9999,999.99"
            .Left      = 684
            .Top       = 385
            .Width     = 95
            .ForeColor = RGB(0, 0, 0)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerObservacao - cnt_4c_Observacao (Top=422, H=105)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerObservacao()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Observacao", "Container")
        loc_oCnt = THIS.cnt_4c_Observacao
        WITH loc_oCnt
            .Top         = 422
            .Left        = 7
            .Width       = 889
            .Height      = 105
            .BackStyle   = 1
            .BackColor   = RGB(188, 201, 254)
            .BorderWidth = 1
            .Visible     = .F.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_TitObs", "Label")
        WITH loc_oCnt.lbl_4c_TitObs
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = " Observa" + CHR(231) + CHR(227) + "o "
            .Left      = 5
            .Top       = 4
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Codigo da observacao
        loc_oCnt.AddObject("txt_4c_CodObs", "TextBox")
        WITH loc_oCnt.txt_4c_CodObs
            .Alignment = 3
            .Value     = 0
            .Height    = 24
            .InputMask = "999"
            .Left      = 10
            .Margin    = 0
            .Top       = 21
            .Width     = 32
            .Visible   = .T.
        ENDWITH

        *-- Texto da observacao
        loc_oCnt.AddObject("txt_4c_Obs", "EditBox")
        WITH loc_oCnt.txt_4c_Obs
            .Height     = 77
            .Left       = 43
            .Top        = 21
            .Width      = 838
            .ScrollBars = 2
            .ReadOnly   = .T.
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerEntrega - cnt_4c_Entrega (Top=534, H=59)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerEntrega()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Entrega", "Container")
        loc_oCnt = THIS.cnt_4c_Entrega
        WITH loc_oCnt
            .Top         = 534
            .Left        = 7
            .Width       = 889
            .Height      = 59
            .BackStyle   = 1
            .BackColor   = RGB(188, 201, 254)
            .BorderWidth = 1
            .Visible     = .F.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_TitEnt", "Label")
        WITH loc_oCnt.lbl_4c_TitEnt
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = " Entrega "
            .Left      = 6
            .Top       = 3
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblConta", "Label")
        WITH loc_oCnt.lbl_4c_LblConta
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Conta"
            .Left      = 10
            .Top       = 19
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Campo conta de entrega (ControlSource vincula direto ao cursor)
        loc_oCnt.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oCnt.txt_4c_Conta
            .FontName      = "Arial"
            .FontSize      = 8
            .ControlSource = "CsPrazE.ContaEs"
            .Height        = 21
            .Left          = 10
            .Margin        = 0
            .MaxLength     = 10
            .SpecialEffect = 1
            .Top           = 33
            .Width         = 72
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblCpf", "Label")
        WITH loc_oCnt.lbl_4c_LblCpf
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "CPF / CNPJ"
            .Height    = 15
            .Left      = 84
            .Top       = 19
            .Width     = 56
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Cpf", "TextBox")
        WITH loc_oCnt.txt_4c_Cpf
            .FontName      = "Arial"
            .FontSize      = 8
            .Height        = 21
            .Left          = 84
            .Margin        = 0
            .MaxLength     = 20
            .SpecialEffect = 1
            .Top           = 33
            .Width         = 131
            .ReadOnly      = .F.
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblNome", "Label")
        WITH loc_oCnt.lbl_4c_LblNome
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Nome"
            .Height    = 15
            .Left      = 217
            .Top       = 19
            .Width     = 29
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oCnt.txt_4c_DConta
            .FontName      = "Arial"
            .FontSize      = 8
            .Height        = 21
            .Left          = 217
            .Margin        = 0
            .MaxLength     = 50
            .SpecialEffect = 1
            .Top           = 33
            .Width         = 300
            .ReadOnly      = .F.
            .Visible       = .T.
        ENDWITH

        *-- Botao de selecao do local de entrega
        loc_oCnt.AddObject("btn_4c_EntLocal", "CommandButton")
        WITH loc_oCnt.btn_4c_EntLocal
            .Top           = 11
            .Left          = 521
            .Width         = 43
            .Height        = 43
            .Caption       = ""
            .Picture       = gc_4c_CaminhoIcones + "geral_calendario_26.jpg"
            .ToolTipText   = "Local de Entrega <F2>"
            .SpecialEffect = 1
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoEncerrar - cnt_4c_Saida com cmd_4c_Encerrar (canonico)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoEncerrar()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Saida", "Container")
        loc_oCnt = THIS.cnt_4c_Saida
        WITH loc_oCnt
            .Top         = 3
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Encerrar
            .Top         = 5
            .Left        = 5
            .Width       = 75
            .Height      = 75
            .Caption     = "Encerrar"
            .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .ToolTipText = "[ESC] Encerrar"
            .Cancel      = .T.
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * BindEventos - Conecta eventos dos controles a metodos do form
    *==========================================================================
    PROTECTED PROCEDURE BindEventos()
        *-- Grid: navegacao de linha atualiza containers de entrega/observacao
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "AtualizarLinhaGrid")

        *-- Campos numericos do grid: recalcular totais ao sair
        BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "LostFocus", THIS, "AtualizarTotaisNaTela")
        BINDEVENT(THIS.grd_4c_Dados.Column4.Text1, "LostFocus", THIS, "AtualizarTotaisNaTela")
        BINDEVENT(THIS.grd_4c_Dados.Column5.Text1, "LostFocus", THIS, "AtualizarTotaisNaTela")

        *-- Conta de entrega: validar e preencher CPF/Nome ao sair
        BINDEVENT(THIS.cnt_4c_Entrega.txt_4c_Conta, "LostFocus", THIS, "ValidarConta")

        *-- Codigo da observacao: buscar descricao ao sair
        BINDEVENT(THIS.cnt_4c_Observacao.txt_4c_CodObs, "LostFocus", THIS, "ValidarObservacao")

        *-- Botao Encerrar: confirmar e fechar
        BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "EncerrarClick")

        *-- Botao local de entrega: abrir FormEnd
        BINDEVENT(THIS.cnt_4c_Entrega.btn_4c_EntLocal, "Click", THIS, "EntLocalClick")

        *-- CPF/CNPJ e Nome: KeyPress (Enter/Tab/F4) para lookup
        BINDEVENT(THIS.cnt_4c_Entrega.txt_4c_Cpf,    "KeyPress", THIS, "ValidarCpf")
        BINDEVENT(THIS.cnt_4c_Entrega.txt_4c_DConta, "KeyPress", THIS, "ValidarDConta")
    ENDPROC

    *==========================================================================
    * AtualizarLinhaGrid - AfterRowColChange: atualiza containers por operacao
    *==========================================================================
    FUNCTION AtualizarLinhaGrid(par_nColIndex)
        LOCAL loc_cDopes, loc_cConta

        IF !USED("CsPrazE")
            RETURN
        ENDIF
        SELECT CsPrazE
        loc_cDopes = ALLTRIM(CsPrazE.Dopes)

        IF THIS.this_oBusinessObject.CarregarInfoLinhaGrid(loc_cDopes)
            *-- Alternar visibilidade dos paineis suplementares
            THIS.AlternarPagina(THIS.this_oBusinessObject.this_nDtEntrsOpe, ;
                                THIS.this_oBusinessObject.this_nDigObs)

            *-- Atualizar campos de conta de entrega
            loc_cConta = ALLTRIM(NVL(CsPrazE.ContaEs, ""))
            IF !EMPTY(loc_cConta)
                IF THIS.this_oBusinessObject.CarregarInfoConta(loc_cConta, ;
                        THIS.this_oBusinessObject.this_nChCtEntrs)
                    THIS.cnt_4c_Entrega.txt_4c_Cpf.Value    = ;
                        THIS.this_oBusinessObject.this_cGetCpf
                    THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ;
                        THIS.this_oBusinessObject.this_cGetDConta
                ENDIF
            ELSE
                THIS.cnt_4c_Entrega.txt_4c_Cpf.Value    = ""
                THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ""
            ENDIF
        ENDIF

        *-- Atualizar campos de observacao (SEEK no TprMvCabG indexado por Abrevs)
        IF USED("TprMvCabG")
            IF SEEK(CsPrazE.Abrevs, "TprMvCabG", "Abrevs")
                THIS.cnt_4c_Observacao.txt_4c_CodObs.Value = NVL(TprMvCabG.CodObs, 0)
                THIS.cnt_4c_Observacao.txt_4c_Obs.Value    = ALLTRIM(NVL(TprMvCabG.Obses, ""))
            ELSE
                THIS.cnt_4c_Observacao.txt_4c_CodObs.Value = 0
                THIS.cnt_4c_Observacao.txt_4c_Obs.Value    = ""
            ENDIF
        ENDIF

        THIS.Refresh
        SELECT CsPrazE
    ENDPROC

    *==========================================================================
    * AtualizarTotaisNaTela - LostFocus colunas numericas: recalcula totais
    *==========================================================================
    FUNCTION AtualizarTotaisNaTela()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.AtualizarTotais()
                THIS.txt_4c_FrtT.Value  = THIS.this_oBusinessObject.this_nFrtTotal
                THIS.txt_4c_FrtI.Value  = THIS.this_oBusinessObject.this_nFrtInformado
                THIS.txt_4c_DespT.Value = THIS.this_oBusinessObject.this_nDespTotal
                THIS.txt_4c_DespI.Value = THIS.this_oBusinessObject.this_nDespInformado
                THIS.txt_4c_SegT.Value  = THIS.this_oBusinessObject.this_nSegTotal
                THIS.txt_4c_SegI.Value  = THIS.this_oBusinessObject.this_nSegInformado
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormPzo.AtualizarTotaisNaTela")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarConta - LostFocus txt_4c_Conta: busca e valida conta de entrega
    *==========================================================================
    FUNCTION ValidarConta()
        LOCAL loc_cConta, loc_lOk
        loc_cConta = ALLTRIM(THIS.cnt_4c_Entrega.txt_4c_Conta.Value)

        IF EMPTY(loc_cConta)
            THIS.cnt_4c_Entrega.txt_4c_Cpf.Value       = ""
            THIS.cnt_4c_Entrega.txt_4c_DConta.Value    = ""
            THIS.cnt_4c_Entrega.txt_4c_Cpf.ReadOnly    = .F.
            THIS.cnt_4c_Entrega.txt_4c_DConta.ReadOnly = .F.
            IF USED("CsPrazE")
                REPLACE ContaEs WITH "" IN CsPrazE
            ENDIF
            RETURN
        ENDIF

        loc_lOk = THIS.this_oBusinessObject.CarregarInfoConta(loc_cConta, ;
                      THIS.this_oBusinessObject.this_nChCtEntrs)
        IF loc_lOk
            THIS.cnt_4c_Entrega.txt_4c_Conta.Value     = THIS.this_oBusinessObject.this_cGetConta
            THIS.cnt_4c_Entrega.txt_4c_Cpf.Value       = THIS.this_oBusinessObject.this_cGetCpf
            THIS.cnt_4c_Entrega.txt_4c_DConta.Value    = THIS.this_oBusinessObject.this_cGetDConta
            THIS.cnt_4c_Entrega.txt_4c_Cpf.ReadOnly    = .T.
            THIS.cnt_4c_Entrega.txt_4c_DConta.ReadOnly = .T.
        ELSE
            THIS.cnt_4c_Entrega.txt_4c_Conta.Value     = ""
            THIS.cnt_4c_Entrega.txt_4c_Cpf.Value       = ""
            THIS.cnt_4c_Entrega.txt_4c_DConta.Value    = ""
            THIS.cnt_4c_Entrega.txt_4c_Cpf.ReadOnly    = .F.
            THIS.cnt_4c_Entrega.txt_4c_DConta.ReadOnly = .F.
            IF USED("CsPrazE")
                REPLACE ContaEs WITH "" IN CsPrazE
            ENDIF
            THIS.AbrirBuscaConta(loc_cConta)
        ENDIF
        THIS.cnt_4c_Entrega.Refresh
    ENDPROC

    *==========================================================================
    * ValidarObservacao - LostFocus txt_4c_CodObs: busca descricao em SigCdObs
    *==========================================================================
    FUNCTION ValidarObservacao()
        LOCAL loc_nCodObs, loc_cDopes

        IF !USED("CsPrazE")
            RETURN
        ENDIF
        loc_nCodObs = THIS.cnt_4c_Observacao.txt_4c_CodObs.Value
        loc_cDopes  = ALLTRIM(CsPrazE.Dopes)

        IF loc_nCodObs = 0
            THIS.cnt_4c_Observacao.txt_4c_Obs.Value = ""
            IF USED("TprMvCabG") AND SEEK(CsPrazE.Abrevs, "TprMvCabG", "Abrevs")
                REPLACE CodObs WITH 0, Obses WITH "" IN TprMvCabG
            ENDIF
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarInfoObservacao(loc_nCodObs, loc_cDopes)
            THIS.cnt_4c_Observacao.txt_4c_CodObs.Value = ;
                THIS.this_oBusinessObject.this_nCodObs
            THIS.cnt_4c_Observacao.txt_4c_Obs.Value    = ;
                THIS.this_oBusinessObject.this_cObsEs
            IF USED("TprMvCabG") AND SEEK(CsPrazE.Abrevs, "TprMvCabG", "Abrevs")
                REPLACE CodObs WITH THIS.this_oBusinessObject.this_nCodObs, ;
                        Obses  WITH THIS.this_oBusinessObject.this_cObsEs ;
                        IN TprMvCabG
            ENDIF
        ELSE
            THIS.cnt_4c_Observacao.txt_4c_CodObs.Value = 0
            THIS.cnt_4c_Observacao.txt_4c_Obs.Value    = ""
        ENDIF
        THIS.cnt_4c_Observacao.Refresh
    ENDPROC

    *==========================================================================
    * EntLocalClick - Botao btn_4c_EntLocal: abre FormEnd para selecionar local
    *==========================================================================
    FUNCTION EntLocalClick()
        LOCAL loc_oErro, loc_cSQL, loc_nResult, loc_lContinuar
        LOCAL loc_cIClis, loc_cGrupo, loc_cNome, loc_nLocal
        loc_lContinuar = .T.

        TRY
            IF !USED("CsPrazE")
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                loc_cIClis = ALLTRIM(NVL(CsPrazE.ContaEs, ""))
                IF EMPTY(loc_cIClis)
                    MsgAviso("Informe a Conta de Entrega antes de selecionar o Local.", ;
                             "Aviso")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Buscar dados do cliente para abrir FormEnd
                loc_cSQL = "SELECT Grupos, IClis, RClis FROM SigCdCli WHERE IClis = '" + ;
                           ALLTRIM(loc_cIClis) + "'"
                IF USED("crTSigDCompCli")
                    USE IN crTSigDCompCli
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTSigDCompCli")
                IF loc_nResult >= 1
                    SELECT crTSigDCompCli
                    GO TOP
                    loc_cGrupo = ALLTRIM(NVL(crTSigDCompCli.Grupos, ""))
                    loc_cNome  = ALLTRIM(NVL(crTSigDCompCli.RClis,  ""))
                    loc_nLocal = NVL(CsPrazE.LocalEnts, 0)

                    DO FORM FormEnd WITH ;
                        loc_cGrupo, loc_cIClis, loc_cNome, ;
                        THIS.this_oBusinessObject.this_cEscolha, .NULL., loc_nLocal
                ENDIF
                IF USED("crTSigDCompCli")
                    USE IN crTSigDCompCli
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormPzo.EntLocalClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarCpf - KeyPress txt_4c_Cpf: valida CPF/CNPJ e preenche Conta/Nome
    * Dispara em Enter(13), Tab(9) ou F4(115)
    *==========================================================================
    FUNCTION ValidarCpf(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCpf, loc_cCpfFmt, loc_nLen, loc_cSQL, loc_nResult, loc_oErro
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        loc_cCpf = ALLTRIM(THIS.cnt_4c_Entrega.txt_4c_Cpf.Value)
        IF EMPTY(loc_cCpf)
            RETURN
        ENDIF

        *-- Remover formatacao (pontos, tracinho, barra)
        loc_cCpf = STRTRAN(STRTRAN(STRTRAN(loc_cCpf, ".", ""), "-", ""), "/", "")
        loc_nLen = LEN(ALLTRIM(loc_cCpf))
        IF loc_nLen <= 11
            loc_cCpfFmt = TRANSFORM(loc_cCpf, "@R 999.999.999-99")
        ELSE
            loc_cCpfFmt = TRANSFORM(loc_cCpf, "@R 99.999.999/9999-99")
        ENDIF
        THIS.cnt_4c_Entrega.txt_4c_Cpf.Value = loc_cCpfFmt

        TRY
            loc_cSQL = "SELECT TOP 1 IClis, RClis, Cpfs FROM SigCdCli WHERE " + ;
                       "RTRIM(Cpfs) = " + EscaparSQL(ALLTRIM(loc_cCpfFmt))
            IF USED("cursor_4c_BuscaCpf")
                USE IN cursor_4c_BuscaCpf
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCpf")

            IF loc_nResult >= 1 AND !EOF("cursor_4c_BuscaCpf")
                SELECT cursor_4c_BuscaCpf
                GO TOP
                THIS.cnt_4c_Entrega.txt_4c_Conta.Value  = ALLTRIM(NVL(cursor_4c_BuscaCpf.IClis, ""))
                THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ALLTRIM(NVL(cursor_4c_BuscaCpf.RClis,  ""))
                IF USED("CsPrazE")
                    REPLACE ContaEs WITH ALLTRIM(cursor_4c_BuscaCpf.IClis) IN CsPrazE
                ENDIF
                loc_lSucesso = .T.
            ENDIF
            IF USED("cursor_4c_BuscaCpf")
                USE IN cursor_4c_BuscaCpf
            ENDIF

            IF !loc_lSucesso
                THIS.AbrirBuscaCpf(loc_cCpfFmt)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormPzo.ValidarCpf")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirBuscaCpf - Abre FormBuscaAuxiliar filtrado por CPF (Pattern A)
    *==========================================================================
    FUNCTION AbrirBuscaCpf(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_oForm, loc_oErro

        TRY
            *-- SQL filtrado por CPF ou codigo (starts-with)
            loc_cSQL = "SELECT IClis AS IClis, Cpfs AS Cpfs, RClis AS RClis " + ;
                       "FROM SigCdCli WHERE RTRIM(Cpfs) LIKE " + ;
                       EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                       " OR RTRIM(IClis) LIKE " + ;
                       EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                       " ORDER BY Cpfs"
            IF USED("cursor_4c_BuscaCpf")
                USE IN cursor_4c_BuscaCpf
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCpf")
            IF loc_nResult < 1 OR RECCOUNT("cursor_4c_BuscaCpf") = 0
                IF USED("cursor_4c_BuscaCpf")
                    USE IN cursor_4c_BuscaCpf
                ENDIF
                *-- Fallback: lista completa
                SQLEXEC(gnConnHandle, ;
                    "SELECT IClis AS IClis, Cpfs AS Cpfs, RClis AS RClis FROM SigCdCli ORDER BY Cpfs", ;
                    "cursor_4c_BuscaCpf")
            ENDIF

            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.this_cCursorDestino = "cursor_4c_BuscaCpf"
                loc_oForm.DefinirCursor("cursor_4c_BuscaCpf", "IClis", "Cpfs", ;
                    "Busca por CPF / CNPJ")
                IF loc_oForm.Mostrar()
                    THIS.cnt_4c_Entrega.txt_4c_Cpf.Value   = ALLTRIM(loc_oForm.cDescricaoSelecionada)
                    THIS.cnt_4c_Entrega.txt_4c_Conta.Value = ALLTRIM(loc_oForm.cCodigoSelecionado)
                    IF !EMPTY(loc_oForm.cCodigoSelecionado)
                        THIS.this_oBusinessObject.CarregarInfoConta( ;
                            ALLTRIM(loc_oForm.cCodigoSelecionado), ;
                            THIS.this_oBusinessObject.this_nChCtEntrs)
                        THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ;
                            THIS.this_oBusinessObject.this_cGetDConta
                        IF USED("CsPrazE")
                            REPLACE ContaEs WITH ALLTRIM(loc_oForm.cCodigoSelecionado) IN CsPrazE
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaCpf")
                USE IN cursor_4c_BuscaCpf
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormPzo.AbrirBuscaCpf")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarDConta - KeyPress txt_4c_DConta: busca cliente por nome
    * Dispara em Enter(13), Tab(9) ou F4(115)
    *==========================================================================
    FUNCTION ValidarDConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cDConta, loc_cSQL, loc_nResult, loc_oForm, loc_oErro
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        loc_cDConta = ALLTRIM(THIS.cnt_4c_Entrega.txt_4c_DConta.Value)
        IF EMPTY(loc_cDConta)
            RETURN
        ENDIF

        TRY
            *-- Busca exata por nome (RClis)
            loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE " + ;
                       "RTRIM(RClis) = " + EscaparSQL(loc_cDConta)
            IF USED("cursor_4c_BuscaDConta")
                USE IN cursor_4c_BuscaDConta
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaDConta")

            IF loc_nResult >= 1 AND !EOF("cursor_4c_BuscaDConta")
                SELECT cursor_4c_BuscaDConta
                GO TOP
                THIS.cnt_4c_Entrega.txt_4c_Conta.Value  = ALLTRIM(NVL(cursor_4c_BuscaDConta.IClis, ""))
                THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ALLTRIM(NVL(cursor_4c_BuscaDConta.RClis, ""))
                IF USED("CsPrazE")
                    REPLACE ContaEs WITH ALLTRIM(cursor_4c_BuscaDConta.IClis) IN CsPrazE
                ENDIF
                THIS.this_oBusinessObject.CarregarInfoConta( ;
                    ALLTRIM(cursor_4c_BuscaDConta.IClis), ;
                    THIS.this_oBusinessObject.this_nChCtEntrs)
                THIS.cnt_4c_Entrega.txt_4c_Cpf.Value = THIS.this_oBusinessObject.this_cGetCpf
                loc_lSucesso = .T.
            ENDIF
            IF USED("cursor_4c_BuscaDConta")
                USE IN cursor_4c_BuscaDConta
            ENDIF

            IF !loc_lSucesso
                *-- Busca parcial por nome (starts-with) + picker
                loc_cSQL = "SELECT IClis AS IClis, RClis AS RClis FROM SigCdCli " + ;
                           "WHERE RTRIM(RClis) LIKE " + EscaparSQL(loc_cDConta + "%") + ;
                           " ORDER BY RClis"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaDConta")
                IF loc_nResult < 1 OR RECCOUNT("cursor_4c_BuscaDConta") = 0
                    IF USED("cursor_4c_BuscaDConta")
                        USE IN cursor_4c_BuscaDConta
                    ENDIF
                    SQLEXEC(gnConnHandle, ;
                        "SELECT IClis AS IClis, RClis AS RClis FROM SigCdCli ORDER BY RClis", ;
                        "cursor_4c_BuscaDConta")
                ENDIF
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.this_cCursorDestino = "cursor_4c_BuscaDConta"
                    loc_oForm.DefinirCursor("cursor_4c_BuscaDConta", "IClis", "RClis", ;
                        "Busca de Contas")
                    IF loc_oForm.Mostrar()
                        THIS.cnt_4c_Entrega.txt_4c_Conta.Value  = ALLTRIM(loc_oForm.cCodigoSelecionado)
                        THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ALLTRIM(loc_oForm.cDescricaoSelecionada)
                        IF !EMPTY(loc_oForm.cCodigoSelecionado)
                            IF USED("CsPrazE")
                                REPLACE ContaEs WITH ALLTRIM(loc_oForm.cCodigoSelecionado) IN CsPrazE
                            ENDIF
                            THIS.this_oBusinessObject.CarregarInfoConta( ;
                                ALLTRIM(loc_oForm.cCodigoSelecionado), ;
                                THIS.this_oBusinessObject.this_nChCtEntrs)
                            THIS.cnt_4c_Entrega.txt_4c_Cpf.Value = THIS.this_oBusinessObject.this_cGetCpf
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaDConta")
                    USE IN cursor_4c_BuscaDConta
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormPzo.ValidarDConta")
        ENDTRY
    ENDPROC

    *==========================================================================
    * EncerrarClick - Botao Encerrar: valida, grava e fecha o form
    *==========================================================================
    FUNCTION EncerrarClick()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF THIS.this_oBusinessObject.Confirmar()
                    THIS.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormPzo.EncerrarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirBuscaConta - Pattern A: abre FormBuscaAuxiliar para SigCdCli
    *   par_cFiltro: valor digitado (prefixo para filtro LIKE)
    *==========================================================================
    FUNCTION AbrirBuscaConta(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_oForm, loc_oErro
        LOCAL loc_cFiltro
        loc_cFiltro = IIF(VARTYPE(par_cFiltro) = "C", ALLTRIM(par_cFiltro), "")

        TRY
            *-- SQL filtrado por codigo ou nome (starts-with)
            IF EMPTY(loc_cFiltro)
                loc_cSQL = "SELECT IClis AS IClis, RClis AS RClis FROM SigCdCli ORDER BY IClis"
            ELSE
                loc_cSQL = "SELECT IClis AS IClis, RClis AS RClis FROM SigCdCli " + ;
                           "WHERE RTRIM(IClis) LIKE " + EscaparSQL(loc_cFiltro + "%") + ;
                           " OR RTRIM(RClis) LIKE " + EscaparSQL(loc_cFiltro + "%") + ;
                           " ORDER BY IClis"
            ENDIF

            IF USED("cursor_4c_BuscaCli")
                USE IN cursor_4c_BuscaCli
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli")
            IF loc_nResult < 1 OR RECCOUNT("cursor_4c_BuscaCli") = 0
                IF USED("cursor_4c_BuscaCli")
                    USE IN cursor_4c_BuscaCli
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT IClis AS IClis, RClis AS RClis FROM SigCdCli ORDER BY IClis", ;
                    "cursor_4c_BuscaCli")
            ENDIF

            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.this_cCursorDestino = "cursor_4c_BuscaCli"
                loc_oForm.DefinirCursor("cursor_4c_BuscaCli", "IClis", "RClis", ;
                    "Busca de Contas de Entrega")
                IF loc_oForm.Mostrar()
                    THIS.cnt_4c_Entrega.txt_4c_Conta.Value  = ALLTRIM(loc_oForm.cCodigoSelecionado)
                    THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ALLTRIM(loc_oForm.cDescricaoSelecionada)
                    IF !EMPTY(loc_oForm.cCodigoSelecionado)
                        IF USED("CsPrazE")
                            REPLACE ContaEs WITH ALLTRIM(loc_oForm.cCodigoSelecionado) IN CsPrazE
                        ENDIF
                        THIS.this_oBusinessObject.CarregarInfoConta( ;
                            ALLTRIM(loc_oForm.cCodigoSelecionado), ;
                            THIS.this_oBusinessObject.this_nChCtEntrs)
                        THIS.cnt_4c_Entrega.txt_4c_Cpf.Value = THIS.this_oBusinessObject.this_cGetCpf
                    ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaCli")
                USE IN cursor_4c_BuscaCli
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormPzo.AbrirBuscaConta")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarFormas - Shapes decorativos (bordas e separadores)
    *   Shape5: borda ao redor do botao Encerrar (Top=7, Left=903, 86x86)
    *   Shape1: linha separadora Frete (Top=365, Left=44, 194x2)
    *   Shape3: linha separadora Desp.Acess (Top=365, Left=315, 194x2)
    *   Shape4: linha separadora Seguro (Top=365, Left=586, 194x2)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFormas()
        *-- Borda decorativa ao redor do container Encerrar
        THIS.AddObject("shp_4c_Shape5", "Shape")
        WITH THIS.shp_4c_Shape5
            .Top         = 7
            .Left        = 903
            .Width       = 86
            .Height      = 86
            .ShapeType   = 0
            .FillStyle   = 1
            .BorderColor = RGB(53, 53, 53)
            .BorderWidth = 2
            .Visible     = .T.
        ENDWITH

        *-- Linha separadora horizontal abaixo do label "Total" da area Frete
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 365
            .Left        = 44
            .Width       = 194
            .Height      = 2
            .ShapeType   = 0
            .FillStyle   = 0
            .BackColor   = RGB(90, 90, 90)
            .BorderColor = RGB(90, 90, 90)
            .BorderWidth = 1
            .Visible     = .T.
        ENDWITH

        *-- Linha separadora horizontal abaixo do label "Total" da area Despesas
        THIS.AddObject("shp_4c_Shape3", "Shape")
        WITH THIS.shp_4c_Shape3
            .Top         = 365
            .Left        = 315
            .Width       = 194
            .Height      = 2
            .ShapeType   = 0
            .FillStyle   = 0
            .BackColor   = RGB(90, 90, 90)
            .BorderColor = RGB(90, 90, 90)
            .BorderWidth = 1
            .Visible     = .T.
        ENDWITH

        *-- Linha separadora horizontal abaixo do label "Total" da area Seguro
        THIS.AddObject("shp_4c_Shape4", "Shape")
        WITH THIS.shp_4c_Shape4
            .Top         = 365
            .Left        = 586
            .Width       = 194
            .Height      = 2
            .ShapeType   = 0
            .FillStyle   = 0
            .BackColor   = RGB(90, 90, 90)
            .BorderColor = RGB(90, 90, 90)
            .BorderWidth = 1
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Insere nova linha em CsPrazE (novo prazo/conta)
    * Adiciona registro em branco herdando Dopes/Abrevs da linha corrente
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro, loc_cDopes, loc_cAbrevs, loc_dPrazoBase
        LOCAL loc_nDtEntrs, loc_nFiscals, loc_cContaEs

        TRY
            IF !USED("CsPrazE")
                MsgAviso("Cursor de prazos nao esta disponivel.", "Aviso")
                RETURN
            ENDIF

            *-- Capturar valores da linha corrente para herdar
            SELECT CsPrazE
            loc_cDopes    = ALLTRIM(NVL(CsPrazE.Dopes,    ""))
            loc_cAbrevs   = ALLTRIM(NVL(CsPrazE.Abrevs,   ""))
            loc_dPrazoBase= NVL(CsPrazE.Prazos, DATETIME())
            loc_nDtEntrs  = NVL(CsPrazE.DtEntrs,  0)
            loc_nFiscals  = NVL(CsPrazE.nFiscals, 0)
            loc_cContaEs  = ALLTRIM(NVL(CsPrazE.ContaEs, ""))

            *-- Adicionar linha em branco herdando contexto
            APPEND BLANK IN CsPrazE
            REPLACE CsPrazE.Dopes     WITH loc_cDopes    ;
                    CsPrazE.Abrevs    WITH loc_cAbrevs   ;
                    CsPrazE.Prazos    WITH loc_dPrazoBase;
                    CsPrazE.DtEntrs   WITH loc_nDtEntrs  ;
                    CsPrazE.nFiscals  WITH loc_nFiscals  ;
                    CsPrazE.nMinEnts  WITH 0             ;
                    CsPrazE.nMaxEnts  WITH 0             ;
                    CsPrazE.VlFretes  WITH 0             ;
                    CsPrazE.DespAces  WITH 0             ;
                    CsPrazE.VlSeguros WITH 0             ;
                    CsPrazE.ContaEs   WITH loc_cContaEs  ;
                    CsPrazE.LocalEnts WITH 0             ;
                    CsPrazE.LocEntObs WITH 0             ;
                    CsPrazE.ContaEs   WITH loc_cContaEs  IN CsPrazE

            *-- Reposicionar grid na nova linha e atualizar totais/paineis
            THIS.grd_4c_Dados.Refresh
            THIS.AtualizarLinhaGrid(1)
            THIS.AtualizarTotaisNaTela()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormPzo.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Habilita edicao da linha corrente do grid CsPrazE
    * Posiciona foco na primeira coluna editavel e atualiza paineis suplementares
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro

        TRY
            IF !USED("CsPrazE") OR RECCOUNT("CsPrazE") = 0
                MsgAviso("Nenhum prazo disponivel para alteracao.", "Aviso")
                RETURN
            ENDIF

            SELECT CsPrazE
            IF EOF() OR BOF()
                GO TOP
            ENDIF

            *-- Marcar modo edicao no BO (usado por Confirmar)
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cEscolha = "ALTERAR"
            ENDIF

            *-- Atualizar paineis suplementares para a linha atual
            THIS.AtualizarLinhaGrid(1)

            *-- Colocar foco na primeira coluna editavel (Frete)
            THIS.grd_4c_Dados.SetFocus
            THIS.grd_4c_Dados.ActiveColumn = 1
            IF PEMSTATUS(THIS.grd_4c_Dados.Columns(1), "CurrentControl", 5)
                THIS.grd_4c_Dados.Columns(1).Text1.SetFocus
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormPzo.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Modo somente-leitura: bloqueia grid e campos editaveis
    * Atualiza paineis suplementares mostrando dados da linha corrente
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro

        TRY
            IF !USED("CsPrazE") OR RECCOUNT("CsPrazE") = 0
                MsgAviso("Nenhum prazo disponivel para visualizacao.", "Aviso")
                RETURN
            ENDIF

            SELECT CsPrazE
            IF EOF() OR BOF()
                GO TOP
            ENDIF

            *-- Marcar modo visualizacao no BO
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cEscolha = "VISUALIZAR"
            ENDIF

            *-- Bloquear edicao no grid (todas as colunas ReadOnly)
            THIS.grd_4c_Dados.ReadOnly = .T.

            *-- Bloquear campos do painel de entrega e observacao
            THIS.cnt_4c_Entrega.txt_4c_Conta.ReadOnly    = .T.
            THIS.cnt_4c_Entrega.txt_4c_DConta.ReadOnly   = .T.
            THIS.cnt_4c_Entrega.txt_4c_Cpf.ReadOnly      = .T.
            THIS.cnt_4c_Observacao.txt_4c_CodObs.ReadOnly= .T.
            THIS.cnt_4c_Observacao.txt_4c_Obs.ReadOnly   = .T.

            *-- Refrescar paineis suplementares para exibir dados
            THIS.AtualizarLinhaGrid(1)
            THIS.AtualizarTotaisNaTela()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormPzo.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Remove linha corrente de CsPrazE apos confirmacao
    * Apos exclusao reposiciona no primeiro registro e atualiza totais
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro, loc_cDopes

        TRY
            IF !USED("CsPrazE") OR RECCOUNT("CsPrazE") = 0
                MsgAviso("Nenhum prazo disponivel para exclusao.", "Aviso")
                RETURN
            ENDIF

            SELECT CsPrazE
            IF EOF() OR BOF()
                GO TOP
            ENDIF

            loc_cDopes = ALLTRIM(NVL(CsPrazE.Dopes, ""))

            IF !MsgConfirma("Confirma a exclusao do prazo da operacao " + ;
                            loc_cDopes + " ?", "Confirmacao")
                RETURN
            ENDIF

            *-- Marcar registro para exclusao e purgar do cursor
            DELETE IN CsPrazE
            SET DELETED ON
            PACK

            *-- Reposicionar e atualizar interface
            SELECT CsPrazE
            IF RECCOUNT("CsPrazE") > 0
                GO TOP
                THIS.grd_4c_Dados.Refresh
                THIS.AtualizarLinhaGrid(1)
            ELSE
                THIS.cnt_4c_Entrega.txt_4c_Conta.Value     = ""
                THIS.cnt_4c_Entrega.txt_4c_DConta.Value    = ""
                THIS.cnt_4c_Entrega.txt_4c_Cpf.Value       = ""
                THIS.cnt_4c_Observacao.txt_4c_CodObs.Value = 0
                THIS.cnt_4c_Observacao.txt_4c_Obs.Value    = ""
            ENDIF

            THIS.AtualizarTotaisNaTela()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormPzo.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Reposiciona no primeiro registro e atualiza grid e totais
    *==========================================================================
    FUNCTION CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED("CsPrazE")
            SELECT CsPrazE
            IF RECCOUNT("CsPrazE") > 0
                GO TOP
                THIS.grd_4c_Dados.Refresh
                THIS.AtualizarLinhaGrid(1)
                THIS.AtualizarTotaisNaTela()
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormParaBO - Copia linha corrente do CsPrazE e containers para o BO
    *   (grid edita cursor diretamente via ControlSource; aqui capturamos
    *    os campos auxiliares visiveis nos containers suplementares)
    *==========================================================================
    FUNCTION FormParaBO()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !USED("CsPrazE")
                loc_lSucesso = .F.
            ENDIF

            SELECT CsPrazE
            THIS.this_oBusinessObject.this_cDopes     = ALLTRIM(NVL(CsPrazE.Dopes,    ""))
            THIS.this_oBusinessObject.this_cAbrevs    = ALLTRIM(NVL(CsPrazE.Abrevs,   ""))
            THIS.this_oBusinessObject.this_dPrazos    = IIF(ISNULL(CsPrazE.Prazos), DTOT({}), CsPrazE.Prazos)
            THIS.this_oBusinessObject.this_nDtEntrs   = NVL(CsPrazE.DtEntrs,   0)
            THIS.this_oBusinessObject.this_nMinEnts   = NVL(CsPrazE.nMinEnts,  0)
            THIS.this_oBusinessObject.this_nMaxEnts   = NVL(CsPrazE.nMaxEnts,  0)
            THIS.this_oBusinessObject.this_nVlFretes  = NVL(CsPrazE.VlFretes,  0)
            THIS.this_oBusinessObject.this_nFiscals   = NVL(CsPrazE.nFiscals,  0)
            THIS.this_oBusinessObject.this_nLocalEnts = NVL(CsPrazE.LocalEnts, 0)
            THIS.this_oBusinessObject.this_cContaEs   = ALLTRIM(NVL(CsPrazE.ContaEs,  ""))
            THIS.this_oBusinessObject.this_nLocEntObs = NVL(CsPrazE.LocEntObs, 0)
            THIS.this_oBusinessObject.this_nDespAces  = NVL(CsPrazE.DespAces,  0)
            THIS.this_oBusinessObject.this_nVlSeguros = NVL(CsPrazE.VlSeguros, 0)

            *-- Container de entrega (quando visivel)
            IF THIS.cnt_4c_Entrega.Visible
                THIS.this_oBusinessObject.this_cGetConta  = ;
                    ALLTRIM(THIS.cnt_4c_Entrega.txt_4c_Conta.Value)
                THIS.this_oBusinessObject.this_cGetCpf    = ;
                    ALLTRIM(THIS.cnt_4c_Entrega.txt_4c_Cpf.Value)
                THIS.this_oBusinessObject.this_cGetDConta = ;
                    ALLTRIM(THIS.cnt_4c_Entrega.txt_4c_DConta.Value)
            ENDIF

            *-- Container de observacao (quando visivel)
            IF THIS.cnt_4c_Observacao.Visible
                THIS.this_oBusinessObject.this_nCodObs = ;
                    THIS.cnt_4c_Observacao.txt_4c_CodObs.Value
                THIS.this_oBusinessObject.this_cObsEs  = ;
                    ALLTRIM(THIS.cnt_4c_Observacao.txt_4c_Obs.Value)
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormPzo.FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BOParaForm - Copia propriedades do BO de volta para os controles do form
    *==========================================================================
    FUNCTION BOParaForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Totalizadores do rodape
            THIS.txt_4c_FrtT.Value  = THIS.this_oBusinessObject.this_nFrtTotal
            THIS.txt_4c_FrtI.Value  = THIS.this_oBusinessObject.this_nFrtInformado
            THIS.txt_4c_DespT.Value = THIS.this_oBusinessObject.this_nDespTotal
            THIS.txt_4c_DespI.Value = THIS.this_oBusinessObject.this_nDespInformado
            THIS.txt_4c_SegT.Value  = THIS.this_oBusinessObject.this_nSegTotal
            THIS.txt_4c_SegI.Value  = THIS.this_oBusinessObject.this_nSegInformado

            *-- Container de entrega
            IF THIS.cnt_4c_Entrega.Visible
                THIS.cnt_4c_Entrega.txt_4c_Conta.Value  = ;
                    THIS.this_oBusinessObject.this_cGetConta
                THIS.cnt_4c_Entrega.txt_4c_Cpf.Value    = ;
                    THIS.this_oBusinessObject.this_cGetCpf
                THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ;
                    THIS.this_oBusinessObject.this_cGetDConta
            ENDIF

            *-- Container de observacao
            IF THIS.cnt_4c_Observacao.Visible
                THIS.cnt_4c_Observacao.txt_4c_CodObs.Value = ;
                    THIS.this_oBusinessObject.this_nCodObs
                THIS.cnt_4c_Observacao.txt_4c_Obs.Value    = ;
                    THIS.this_oBusinessObject.this_cObsEs
            ENDIF

            THIS.Refresh()
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormPzo.BOParaForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita controles conforme modo
    *   par_cModo: "INSERIR" | "ALTERAR" | "VISUALIZAR"
    *==========================================================================
    PROCEDURE HabilitarCampos(par_cModo)
        LOCAL loc_lEditar
        loc_lEditar = !INLIST(UPPER(ALLTRIM(par_cModo)), "VISUALIZAR")

        *-- Grid: somente-leitura em modo VISUALIZAR
        THIS.grd_4c_Dados.ReadOnly = !loc_lEditar

        *-- Container de entrega
        THIS.cnt_4c_Entrega.txt_4c_Conta.ReadOnly    = !loc_lEditar
        THIS.cnt_4c_Entrega.txt_4c_Cpf.ReadOnly      = !loc_lEditar
        THIS.cnt_4c_Entrega.txt_4c_DConta.ReadOnly   = !loc_lEditar
        THIS.cnt_4c_Entrega.btn_4c_EntLocal.Enabled  = loc_lEditar

        *-- Container de observacao (codigo editavel; texto sempre readonly pois e lookup)
        THIS.cnt_4c_Observacao.txt_4c_CodObs.ReadOnly = !loc_lEditar
        THIS.cnt_4c_Observacao.txt_4c_Obs.ReadOnly    = .T.
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa campos dos containers suplementares (entrega/obs)
    *==========================================================================
    PROCEDURE LimparCampos()
        THIS.cnt_4c_Entrega.txt_4c_Conta.Value     = ""
        THIS.cnt_4c_Entrega.txt_4c_Cpf.Value       = ""
        THIS.cnt_4c_Entrega.txt_4c_DConta.Value    = ""
        THIS.cnt_4c_Observacao.txt_4c_CodObs.Value = 0
        THIS.cnt_4c_Observacao.txt_4c_Obs.Value    = ""
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta ReadOnly do grid conforme modo de edicao
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo(par_cModo)
        LOCAL loc_cModo
        loc_cModo = UPPER(ALLTRIM(IIF(VARTYPE(par_cModo) = "C", par_cModo, "")))

        IF EMPTY(loc_cModo) AND VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cModo = UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cEscolha))
        ENDIF

        THIS.HabilitarCampos(loc_cModo)
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega o grid e atualiza totais (refresh)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Valida prazos/fretes e fecha o form (delega ao BO)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.EncerrarClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Sincroniza campos dos containers com BO e atualiza totais
    *   (grid ja edita CsPrazE via ControlSource; aqui persiste auxiliares)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oErro

        TRY
            IF THIS.FormParaBO()
                THIS.AtualizarTotaisNaTela()
                THIS.AjustarBotoesPorModo("")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormPzo.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Desfaz edicoes nos containers e recarrega da linha
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro

        TRY
            THIS.LimparCampos()

            IF USED("CsPrazE") AND RECCOUNT("CsPrazE") > 0
                SELECT CsPrazE
                THIS.AtualizarLinhaGrid(1)
            ENDIF

            THIS.grd_4c_Dados.ReadOnly = .F.
            THIS.HabilitarCampos(IIF(VARTYPE(THIS.this_oBusinessObject) = "O", ;
                THIS.this_oBusinessObject.this_cEscolha, "ALTERAR"))

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormPzo.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Libera cursores locais e BO
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro
        TRY
            IF USED("CsPrazE")
                USE IN CsPrazE
            ENDIF
            IF USED("CsPedidos")
                USE IN CsPedidos
            ENDIF
            IF USED("CsPed")
                USE IN CsPed
            ENDIF
            IF USED("CsPedAnt")
                USE IN CsPedAnt
            ENDIF
            IF USED("crTodosOpe2")
                USE IN crTodosOpe2
            ENDIF
            IF USED("CsPedOpe2")
                USE IN CsPedOpe2
            ENDIF
            IF USED("Itens")
                USE IN Itens
            ENDIF
            IF USED("LocTmpOpe")
                USE IN LocTmpOpe
            ENDIF
            IF USED("crLocalObs")
                USE IN crLocalObs
            ENDIF
            IF USED("cursor_4c_BuscaCpf")
                USE IN cursor_4c_BuscaCpf
            ENDIF
            IF USED("cursor_4c_BuscaDConta")
                USE IN cursor_4c_BuscaDConta
            ENDIF
            IF USED("cursor_4c_BuscaCli")
                USE IN cursor_4c_BuscaCli
            ENDIF
            THIS.this_oBusinessObject = .NULL.
            THIS.this_oFormPai        = .NULL.
        CATCH TO loc_oErro
            *-- Destruicao nao bloqueia saida
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE
