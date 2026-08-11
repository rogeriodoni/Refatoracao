*==============================================================================
* FormSigPrIbb.prg - Form Operacional: Impressao de Boleto Bancario
* Migrado de SIGPRIBB.SCX
* Herda de FormBase
* Tabelas: SigMvCab / SigMvPar / SigCnFBl / SigCdOpe / SigCdCli / SigOpFp
* Tipo: OPERACIONAL - recebe EmpDopNum como parametro na abertura
*
* Pilares:
*   UX   -> layout PIXEL-PERFECT identico ao legado (Width=1000, Height=700)
*   BD   -> Schema IDENTICO (SigMvCab, SigMvPar, SigCnFBl, etc.)
*   CODE -> arquitetura em camadas (FormBase / SigPrIbbBO)
*==============================================================================

DEFINE CLASS FormSigPrIbb AS FormBase

    *-- Dimensoes e propriedades visuais (extraidas do SCX original)
    Height      = 700
    Width       = 1000
    BorderStyle = 2
    AutoCenter  = .T.
    ShowTips    = .T.
    Caption     = "Impress" + CHR(227) + "o de Boleto Banc" + CHR(225) + "rio"
    ShowWindow = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    Movable     = .F.
    TitleBar    = 0
    WindowState = 0
    WindowType  = 1
    DataSession = 2

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Chave composta (29 chars): Emps[1-3] + Dopes[4-23] + Numes[24-29]
    this_cEmpDopNum = ""
    this_cEmps      = ""
    this_cDopes     = ""
    this_cNumes     = ""

    *==========================================================================
    * Init - Recebe EmpDopNum como parametro (par_cEmpDopNum = pEdn no legado)
    * DataSession=2: DODEFAULT chama FormBase.Init que executa SET DATE BRITISH
    *==========================================================================
    PROCEDURE Init()
        LPARAMETERS par_cEmpDopNum, par_cFrm

        IF TYPE("par_cEmpDopNum") = "C" AND !EMPTY(ALLTRIM(par_cEmpDopNum))
            THIS.this_cEmpDopNum = PADR(ALLTRIM(par_cEmpDopNum), 29)
        ELSE
            THIS.this_cEmpDopNum = SPACE(29)
        ENDIF

        THIS.this_cEmps  = ALLTRIM(SUBSTR(THIS.this_cEmpDopNum,  1,  3))
        THIS.this_cDopes = ALLTRIM(SUBSTR(THIS.this_cEmpDopNum,  4, 20))
        THIS.this_cNumes = ALLTRIM(SUBSTR(THIS.this_cEmpDopNum, 24,  6))

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Configura aparencia base do form (OPERACIONAL)
    * Este form NAO usa PageFrame (layout customizado com grid + editboxes),
    * mas mantemos o nome do metodo por convencao da arquitetura.
    * Define fundo, fontes e cores base antes de criar os controles.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.BackColor = RGB(212, 208, 200)
        THIS.ScrollBars = 0
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)

        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = NEWOBJECT("SigPrIbbBO", ;
                gc_4c_CaminhoClasses + "SigPrIbbBO.prg")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SigPrIbbBO", "Inicializa" + CHR(231) + CHR(227) + "o")
            ELSE
                IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                    THIS.ConfigurarPageFrame()
                    THIS.ConfigurarCabecalho()
                    THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                    THIS.ConfigurarPaginaLista()
                    THIS.ConfigurarPaginaDados()
                    THIS.TornarControlesVisiveis()
                    loc_lSucesso = .T.
                ELSE
                    IF gnConnHandle <= 0
                        MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                                "o Com o Servidor de Banco de Dados...", ;
                                "Conex" + CHR(227) + "o")
                    ELSE
                        THIS.this_oBusinessObject.this_cEmpDopNum = THIS.this_cEmpDopNum

                        THIS.this_oBusinessObject.InicializarCursores()

                        THIS.ConfigurarPageFrame()
                        THIS.ConfigurarCabecalho()
                        THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                        THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                        THIS.ConfigurarPaginaLista()
                        THIS.ConfigurarPaginaDados()
                        THIS.MontarGrade()
                        THIS.SelecionarDadosForm()
                        THIS.TornarControlesVisiveis()

                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container escuro superior (cntSombra do legado)
    * Top=0, Left=0, Width=1008, Height=80, BackColor=RGB(100,100,100)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt
        LOCAL loc_cTitulo
        loc_cTitulo = "Impress" + CHR(227) + "o de Boleto Banc" + CHR(225) + "rio"

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCnt = THIS.cnt_4c_Cabecalho

        WITH loc_oCnt
            .Top         = 0
            .Left        = 0
            .Width       = 1008
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = loc_cTitulo
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .Width     = THIS.Width
                .ForeColor = RGB(0, 0, 0)
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize    = .F.
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .Alignment   = 0
                .BackStyle   = 0
                .Caption     = loc_cTitulo
                .Height      = 46
                .Left        = 10
                .Top         = 17
                .Width       = THIS.Width
                .ForeColor   = RGB(255, 255, 255)
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * par_oContainer: container a iterar (default = THIS se nao informado)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_nP, loc_oControl, loc_oBase

        IF TYPE("par_oContainer") = "O" AND !ISNULL(par_oContainer)
            loc_oBase = par_oContainer
        ELSE
            loc_oBase = THIS
        ENDIF

        FOR loc_i = 1 TO loc_oBase.ControlCount
            loc_oControl = loc_oBase.Controls(loc_i)

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
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos e chama DODEFAULT
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
           !ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Cria controles visuais do form OPERACIONAL
    * Shape decorativo, botoes, textboxes de identificacao, grid,
    * editboxes de texto e textbox de total.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        *-- Shape decorativo no canto superior direito (Shape1 no legado)
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 9
            .Left        = 820
            .Height      = 110
            .Width       = 173
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
        ENDWITH

        *-- Botao Encerrar (ok no legado)
        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top         = 3
            .Left        = 922
            .Height      = 75
            .Width       = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel      = .T.
            .Caption     = "Encerrar"
            .TabIndex    = 11
            .ToolTipText = "[ESC] Sair"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes           = .T.
        ENDWITH

        *-- Botao Imprimir (btnImprimir no legado)
        THIS.AddObject("cmd_4c_BtnImprimir", "CommandButton")
        WITH THIS.cmd_4c_BtnImprimir
            .Top         = 3
            .Left        = 846
            .Height      = 75
            .Width       = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Picture     = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
            .Caption     = "\<Imprimir"
            .TabIndex    = 10
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes           = .T.
        ENDWITH

        *-- TextBox Empresa (getEmps no legado) - somente exibicao
        THIS.AddObject("txt_4c_Emps", "TextBox")
        WITH THIS.txt_4c_Emps
            .FontName          = "Tahoma"
            .FontSize          = 11
            .BorderStyle       = 1
            .Enabled           = .F.
            .Height            = 27
            .Left              = 7
            .SpecialEffect     = 1
            .TabIndex          = 2
            .Top               = 101
            .Width             = 44
            .Value             = THIS.this_cEmps
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(245, 251, 136)
            .DisabledBackColor = RGB(245, 251, 136)
            .DisabledForeColor = RGB(36, 84, 155)
            .MaxLength   = 3
        ENDWITH

        *-- TextBox Operacao (getDopes no legado) - somente exibicao
        THIS.AddObject("txt_4c_Dopes", "TextBox")
        WITH THIS.txt_4c_Dopes
            .FontName          = "Tahoma"
            .FontSize          = 11
            .BorderStyle       = 1
            .Enabled           = .F.
            .Height            = 27
            .Left              = 57
            .SpecialEffect     = 1
            .TabIndex          = 3
            .Top               = 101
            .Width             = 288
            .Value             = THIS.this_cDopes
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(245, 251, 136)
            .DisabledBackColor = RGB(245, 251, 136)
            .DisabledForeColor = RGB(36, 84, 155)
        ENDWITH

        *-- TextBox Numero da movimentacao (getNumes no legado) - somente exibicao
        THIS.AddObject("txt_4c_Numes", "TextBox")
        WITH THIS.txt_4c_Numes
            .FontName          = "Tahoma"
            .FontSize          = 11
            .BorderStyle       = 1
            .Enabled           = .F.
            .Height            = 27
            .Left              = 352
            .SpecialEffect     = 1
            .TabIndex          = 4
            .Top               = 101
            .Width             = 80
            .Value             = THIS.this_cNumes
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(245, 251, 136)
            .DisabledBackColor = RGB(245, 251, 136)
            .DisabledForeColor = RGB(36, 84, 155)
        ENDWITH

        *-- Grid de parcelas (grdItens no legado)
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .ColumnCount       = 4
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .HeaderHeight      = 22
            .Height            = 520
            .Left              = 7
            .ReadOnly          = .T.
            .RecordMark        = .F.
            .RowHeight         = 16
            .ScrollBars        = 2
            .TabIndex          = 5
            .Top               = 138
            .Width             = 425
            .GridLineColor     = RGB(238, 238, 238)
        ENDWITH

        *-- Label "Texto de Responsabilidade do Cedente" (Label31 no legado)
        THIS.AddObject("lbl_4c_Label31", "Label")
        WITH THIS.lbl_4c_Label31
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Texto de Responsabilidade do Cedente "
            .Height    = 15
            .Left      = 444
            .Top       = 438
            .Width     = 260
            .TabIndex  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- EditBox Texto do Cedente (getTxtCds no legado)
        THIS.AddObject("obj_4c_GetTxtCds", "EditBox")
        WITH THIS.obj_4c_GetTxtCds
            .FontName      = "Tahoma"
            .BorderStyle   = 1
            .Height        = 201
            .Left          = 444
            .SpecialEffect = 1
            .TabIndex      = 9
            .Top           = 455
            .Width         = 548
            IF USED("cursor_4c_Grade")
                .ControlSource = "cursor_4c_Grade.CTxtCds"
            ENDIF
        ENDWITH

        *-- TextBox Total das parcelas (getTotal no legado) - somente exibicao
        THIS.AddObject("txt_4c_Total", "TextBox")
        WITH THIS.txt_4c_Total
            .FontName          = "Tahoma"
            .BorderStyle       = 1
            .Enabled           = .F.
            .Height            = 23
            .Left              = 262
            .SpecialEffect     = 1
            .TabIndex          = 3
            .Top               = 657
            .Width             = 150
            .Value             = 0
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .DisabledBackColor = RGB(224, 253, 254)
        ENDWITH

        *-- BINDEVENTs
        BINDEVENT(THIS.grd_4c_Dados,       "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
        BINDEVENT(THIS.cmd_4c_Encerrar,    "Click",             THIS, "CmdEncerrarClick")
        BINDEVENT(THIS.cmd_4c_BtnImprimir, "Click",             THIS, "CmdImprimirClick")
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Painel direito Parte 1: Local de Pagamento
    * Equivalentes legados: Label3 (lbl_4c_Label3) e getLocals (obj_4c_GetLocals)
    * OPERACIONAL: nao ha Page2; este metodo adiciona a primeira metade do
    * painel de detalhe localizado a direita do grid (Left>=444).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Label "Local de Pagamento" (Label3 no legado)
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Local de Pagamento "
            .Height    = 15
            .Left      = 444
            .Top       = 211
            .Width     = 150
            .TabIndex  = 6
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- EditBox Local de Pagamento (getLocals no legado)
        THIS.AddObject("obj_4c_GetLocals", "EditBox")
        WITH THIS.obj_4c_GetLocals
            .FontName      = "Tahoma"
            .BorderStyle   = 1
            .Height        = 201
            .Left          = 444
            .SpecialEffect = 1
            .TabIndex      = 7
            .Top           = 228
            .Width         = 548
            IF USED("cursor_4c_Grade")
                .ControlSource = "cursor_4c_Grade.CLocals"
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * MontarGrade - Configura RecordSource, ControlSource, headers e estilos
    * das colunas de grd_4c_Dados. Equivalente a MontaGrades do legado.
    *==========================================================================
    PROTECTED PROCEDURE MontarGrade()
        LOCAL loc_oGrd, loc_nI
        loc_oGrd = THIS.grd_4c_Dados

        loc_oGrd.ColumnCount  = 4
        loc_oGrd.RecordSource = "cursor_4c_Grade"

        WITH loc_oGrd
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .T.
            .ScrollBars        = 2
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.

            .Column1.ControlSource = "cursor_4c_Grade.FPags"
            .Column2.ControlSource = "cursor_4c_Grade.Parcs"
            .Column2.InputMask     = "99"
            .Column3.ControlSource = "cursor_4c_Grade.Vencs"
            .Column4.ControlSource = "cursor_4c_Grade.Valos"
            .Column4.InputMask     = "9999999.99"

            .Column1.Width     = 120
            .Column1.BackColor = RGB(245, 251, 136)

            .Column2.Width     = 31
            .Column2.Alignment = 2
            .Column2.FontBold  = .T.

            .Column3.Width     = 100

            .Column4.Width     = 150

            *-- Headers redefinidos apos RecordSource (evita reset dos captions)
            .Column1.Header1.Caption   = "Condi" + CHR(231) + CHR(227) + "o Pagto."
            .Column1.Header1.ForeColor = RGB(90, 90, 90)
            .Column1.Header1.BackColor = RGB(255, 255, 223)
            .Column1.Header1.Alignment = 2

            .Column2.Header1.Caption   = "X"
            .Column2.Header1.ForeColor = RGB(90, 90, 90)
            .Column2.Header1.BackColor = RGB(255, 255, 223)
            .Column2.Header1.Alignment = 2

            .Column3.Header1.Caption   = "Vencimento"
            .Column3.Header1.ForeColor = RGB(90, 90, 90)
            .Column3.Header1.BackColor = RGB(255, 255, 223)
            .Column3.Header1.Alignment = 2

            .Column4.Header1.Caption   = "Valor"
            .Column4.Header1.ForeColor = RGB(90, 90, 90)
            .Column4.Header1.BackColor = RGB(255, 255, 223)
            .Column4.Header1.Alignment = 2

            *-- Fonte Courier New conforme legado (monospace para alinhamento)
            .Column1.Text1.FontName    = "Courier New"
            .Column1.Text1.ForeColor   = RGB(0, 0, 0)
            .Column1.Text1.BackColor   = RGB(245, 251, 136)
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin      = 0
            .Column1.Text1.ReadOnly    = .T.

            .Column2.Text1.FontName    = "Courier New"
            .Column2.Text1.FontBold    = .T.
            .Column2.Text1.Alignment   = 2
            .Column2.Text1.ForeColor   = RGB(0, 0, 0)
            .Column2.Text1.BackColor   = RGB(255, 255, 255)
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin      = 0
            .Column2.Text1.ReadOnly    = .T.

            .Column3.Text1.FontName    = "Courier New"
            .Column3.Text1.ForeColor   = RGB(0, 0, 0)
            .Column3.Text1.BackColor   = RGB(255, 255, 255)
            .Column3.Text1.BorderStyle = 0
            .Column3.Text1.Margin      = 0

            .Column4.Text1.FontName    = "Courier New"
            .Column4.Text1.ForeColor   = RGB(0, 0, 0)
            .Column4.Text1.BackColor   = RGB(255, 255, 255)
            .Column4.Text1.BorderStyle = 0
            .Column4.Text1.Margin      = 0

            FOR loc_nI = 1 TO .ColumnCount
                .Columns(loc_nI).Movable   = .F.
                .Columns(loc_nI).Resizable = .F.
                .Columns(loc_nI).ReadOnly  = .T.
                .Columns(loc_nI).FontName  = "Courier New"
            ENDFOR

            .Refresh
        ENDWITH

        *-- Garante ControlSource dos EditBoxes pos-RecordSource (defensivo)
        IF VARTYPE(THIS.obj_4c_GetLocals) = "O"
            THIS.obj_4c_GetLocals.ControlSource = "cursor_4c_Grade.CLocals"
            THIS.obj_4c_GetLocals.Refresh
        ENDIF
        IF VARTYPE(THIS.obj_4c_GetTxtCds) = "O"
            THIS.obj_4c_GetTxtCds.ControlSource = "cursor_4c_Grade.CTxtCds"
            THIS.obj_4c_GetTxtCds.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * SelecionarDadosForm - Chama BO.SelecionarDados e atualiza exibicao
    *==========================================================================
    PROTECTED PROCEDURE SelecionarDadosForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.this_oBusinessObject.SelecionarDados(THIS.this_cEmpDopNum)

            IF loc_lSucesso
                IF VARTYPE(THIS.txt_4c_Total) = "O"
                    THIS.txt_4c_Total.Value = THIS.this_oBusinessObject.this_nTotal
                    THIS.txt_4c_Total.Refresh
                ENDIF

                IF USED("cursor_4c_Grade") AND RECCOUNT("cursor_4c_Grade") > 0
                    GO TOP IN cursor_4c_Grade
                ENDIF

                IF VARTYPE(THIS.grd_4c_Dados) = "O"
                    THIS.grd_4c_Dados.Refresh
                    TRY
                        THIS.grd_4c_Dados.Column1.SetFocus
                    CATCH
                    ENDTRY
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SelecionarDadosForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AlternarPagina - Convencao da arquitetura (OPERACIONAL sem PageFrame)
    *==========================================================================
    PROCEDURE AlternarPagina()
        LPARAMETERS par_nPagina
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Convencao arquitetural (OPERACIONAL sem CRUD)
    * SIGPRIBB nao possui operacao Incluir: recebe EmpDopNum ja existente
    * como parametro no Init e apenas imprime o boleto. Metodo mantido por
    * conformidade com o pipeline; roteado para CmdImprimirClick que eh a
    * unica operacao ativa neste form.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        RETURN THIS.CmdImprimirClick()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Convencao arquitetural (OPERACIONAL sem CRUD)
    * SIGPRIBB nao permite alterar o boleto: os dados vem de SigMvCab/SigMvPar
    * (movimentacao ja consolidada). Roteado para CmdImprimirClick para manter
    * a paridade funcional (unica acao possivel sobre a parcela selecionada).
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        RETURN THIS.CmdImprimirClick()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Convencao arquitetural (OPERACIONAL sem CRUD)
    * A visualizacao dos dados da parcela ocorre no proprio grid quando o form
    * abre; navegacao entre parcelas eh feita via grd_4c_Dados.AfterRowColChange
    * que ja atualiza os EditBoxes de Local de Pagamento e Texto do Cedente.
    * Reseleciona a primeira parcela e refresca a exibicao.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        IF USED("cursor_4c_Grade") AND RECCOUNT("cursor_4c_Grade") > 0
            GO TOP IN cursor_4c_Grade
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh
            ENDIF
            IF VARTYPE(THIS.obj_4c_GetLocals) = "O"
                THIS.obj_4c_GetLocals.Refresh
            ENDIF
            IF VARTYPE(THIS.obj_4c_GetTxtCds) = "O"
                THIS.obj_4c_GetTxtCds.Refresh
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Convencao arquitetural (OPERACIONAL sem CRUD)
    * SIGPRIBB nao permite excluir boleto/parcela: essas operacoes pertencem
    * ao modulo de Movimentacao (SigMvCab/SigMvPar). Este form apenas imprime.
    * A unica "saida" possivel eh fechar o form via CmdEncerrarClick.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        RETURN THIS.CmdEncerrarClick()
    ENDPROC

    *==========================================================================
    * GrdDadosAfterRowColChange - Atualiza editboxes ao navegar no grid
    * Handler de BINDEVENT AfterRowColChange do grd_4c_Dados
    *==========================================================================
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)

        IF USED("cursor_4c_Grade")
            SELECT cursor_4c_Grade
        ENDIF

        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh
        ENDIF
        THIS.Refresh
        IF VARTYPE(THIS.obj_4c_GetLocals) = "O"
            THIS.obj_4c_GetLocals.Refresh
        ENDIF
        IF VARTYPE(THIS.obj_4c_GetTxtCds) = "O"
            THIS.obj_4c_GetTxtCds.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE CmdEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * CmdImprimirClick - Confirma e imprime boleto da parcela corrente no grid
    * Equivalente a btnImprimir.Click do legado
    *==========================================================================
    PROCEDURE CmdImprimirClick()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Grade") AND !EOF("cursor_4c_Grade")
                IF MsgConfirma("Confirma a Impress" + CHR(227) + "o do Boleto Banc" + ;
                               CHR(225) + "rio da Condi" + CHR(231) + CHR(227) + ;
                               "o de Pagamento:" + CHR(13) + CHR(13) + ;
                               ALLTRIM(cursor_4c_Grade.FPags) + " - Parcela: " + ;
                               ALLTRIM(STR(cursor_4c_Grade.Parcs, 2)), ;
                               "Confirma" + CHR(231) + CHR(227) + "o")
                    loc_lSucesso = THIS.this_oBusinessObject.Imprimir()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro Imprimir Boleto")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *==========================================================================
    * BtnEncerrarClick - Convencao arquitetural: fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        RETURN THIS.CmdEncerrarClick()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega dados da movimentacao do banco de dados
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        RETURN THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva edicoes de Local de Pagamento e Texto do Cedente
    * na tabela SigCnFBl para a parcela corrente sem imprimir o boleto.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Grade") OR EOF("cursor_4c_Grade")
                MsgAviso("Selecione uma parcela antes de salvar.")
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.this_oBusinessObject.Atualizar()

            IF loc_lSucesso
                MsgInfo("Configura" + CHR(231) + CHR(227) + "o de boleto salva com sucesso.")
            ELSE
                IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                            "Erro ao Salvar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnSalvarClick")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicoes e recarrega dados originais do banco
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.CarregarLista()

            IF loc_lSucesso
                IF VARTYPE(THIS.grd_4c_Dados) = "O"
                    THIS.grd_4c_Dados.Refresh
                ENDIF
                IF VARTYPE(THIS.obj_4c_GetLocals) = "O"
                    THIS.obj_4c_GetLocals.Refresh
                ENDIF
                IF VARTYPE(THIS.obj_4c_GetTxtCds) = "O"
                    THIS.obj_4c_GetTxtCds.Refresh
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnCancelarClick")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega parcelas disponiveis para impressao de boleto
    * Equivalente ao SelecionarDados do legado (chamado no Init).
    *==========================================================================
    PROCEDURE CarregarLista()
        RETURN THIS.SelecionarDadosForm()
    ENDPROC

    *==========================================================================
    * FormParaBO - Sincroniza campos do form para o BO (OPERACIONAL)
    * Os editboxes sao ligados ao cursor_4c_Grade via ControlSource, portanto
    * os dados ja estao no cursor. Apenas atualiza a propriedade de controle
    * no BO para que Atualizar() possa ler corretamente.
    *==========================================================================
    PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        THIS.this_oBusinessObject.this_cEmpDopNum = THIS.this_cEmpDopNum
        THIS.this_oBusinessObject.this_cEmps      = THIS.this_cEmps
        THIS.this_oBusinessObject.this_cDopes     = THIS.this_cDopes
        THIS.this_oBusinessObject.this_cNumes     = THIS.this_cNumes

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - Atualiza exibicao do form a partir dos dados do BO/cursor
    *==========================================================================
    PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        IF VARTYPE(THIS.txt_4c_Total) = "O"
            THIS.txt_4c_Total.Value = THIS.this_oBusinessObject.this_nTotal
            THIS.txt_4c_Total.Refresh
        ENDIF

        IF VARTYPE(THIS.txt_4c_Emps) = "O"
            THIS.txt_4c_Emps.Value = THIS.this_cEmps
            THIS.txt_4c_Emps.Refresh
        ENDIF

        IF VARTYPE(THIS.txt_4c_Dopes) = "O"
            THIS.txt_4c_Dopes.Value = THIS.this_cDopes
            THIS.txt_4c_Dopes.Refresh
        ENDIF

        IF VARTYPE(THIS.txt_4c_Numes) = "O"
            THIS.txt_4c_Numes.Value = THIS.this_cNumes
            THIS.txt_4c_Numes.Refresh
        ENDIF

        IF USED("cursor_4c_Grade") AND RECCOUNT("cursor_4c_Grade") > 0
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh
            ENDIF
            IF VARTYPE(THIS.obj_4c_GetLocals) = "O"
                THIS.obj_4c_GetLocals.Refresh
            ENDIF
            IF VARTYPE(THIS.obj_4c_GetTxtCds) = "O"
                THIS.obj_4c_GetTxtCds.Refresh
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Controla estado dos controles (OPERACIONAL: display-only)
    * Textboxes de identificacao: sempre desabilitados (somente exibicao)
    * EditBoxes de configuracao: habilitados apenas quando ha parcelas no grid
    *==========================================================================
    PROCEDURE HabilitarCampos()
        LOCAL loc_lTemParcelas
        loc_lTemParcelas = USED("cursor_4c_Grade") AND RECCOUNT("cursor_4c_Grade") > 0

        IF VARTYPE(THIS.txt_4c_Emps) = "O"
            THIS.txt_4c_Emps.Enabled = .F.
        ENDIF
        IF VARTYPE(THIS.txt_4c_Dopes) = "O"
            THIS.txt_4c_Dopes.Enabled = .F.
        ENDIF
        IF VARTYPE(THIS.txt_4c_Numes) = "O"
            THIS.txt_4c_Numes.Enabled = .F.
        ENDIF
        IF VARTYPE(THIS.txt_4c_Total) = "O"
            THIS.txt_4c_Total.Enabled = .F.
        ENDIF

        IF VARTYPE(THIS.obj_4c_GetLocals) = "O"
            THIS.obj_4c_GetLocals.ReadOnly = !loc_lTemParcelas
        ENDIF
        IF VARTYPE(THIS.obj_4c_GetTxtCds) = "O"
            THIS.obj_4c_GetTxtCds.ReadOnly = !loc_lTemParcelas
        ENDIF

        IF VARTYPE(THIS.cmd_4c_BtnImprimir) = "O"
            IF loc_lTemParcelas
                THIS.cmd_4c_BtnImprimir.Themes = .F.
            ELSE
                THIS.cmd_4c_BtnImprimir.Themes = .F.
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Reseta campos de exibicao do form
    *==========================================================================
    PROCEDURE LimparCampos()
        IF VARTYPE(THIS.txt_4c_Total) = "O"
            THIS.txt_4c_Total.Value = 0
            THIS.txt_4c_Total.Refresh
        ENDIF

        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh
        ENDIF
        IF VARTYPE(THIS.obj_4c_GetLocals) = "O"
            THIS.obj_4c_GetLocals.Value = ""
            THIS.obj_4c_GetLocals.Refresh
        ENDIF
        IF VARTYPE(THIS.obj_4c_GetTxtCds) = "O"
            THIS.obj_4c_GetTxtCds.Value = ""
            THIS.obj_4c_GetTxtCds.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - OPERACIONAL: sem modos CRUD; metodo de convencao
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

ENDDEFINE
