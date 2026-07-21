*==============================================================================
* FormSIGPRVTX.prg - Importacao de SKUs via planilha Excel (VTX)
* Tipo: OPERACIONAL (flat - sem PageFrame)
* Migrado de SIGPRVTX.SCX
* Tabela: sigprvtx | PK: cidchaves | Cursor grade: cursor_4c_Grade
*==============================================================================
DEFINE CLASS FormSIGPRVTX AS FormBase

    *-- Propriedades visuais (identicas ao legado SIGPRVTX, escaladas 800->1000)
    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    TitleBar     = 0
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Closable     = .F.
    ShowTips     = .T.
    KeyPreview   = .T.
    BorderStyle  = 2
    DataSession  = 1
    WindowType   = 1
    ShowWindow   = 1
    FontName     = "Tahoma"
    FontSize     = 8

    this_oBusinessObject = .NULL.

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *==========================================================================
        THIS.BackColor = RGB(100, 100, 100)
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
        IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_cTitulo
        loc_lSucesso = .F.

        TRY
            *-- Cursor placeholder da grade (mesma estrutura usada em MontaGrade)
            SET NULL ON
            CREATE CURSOR cursor_4c_Grade (;
                skuid    C(10)  NULL, ;
                nomesku  C(100) NULL, ;
                skuativo C(3)   NULL, ;
                refsku   C(40)  NULL)
            SET NULL OFF
            SELECT cursor_4c_Grade
            INDEX ON skuid TAG skuid
            GO TOP

            *-- Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRVTXBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SIGPRVTXBO", "Erro")
            ENDIF

            *-- Aparencia base do form (fundo new_background)
            THIS.ConfigurarPageFrame()

            *-- Cabecalho cinza escuro com titulo (equivalente ao cntSombra legado)
            THIS.ConfigurarCabecalho()

            *-- Botoes principais topo-direito: Salvar + Encerrar
            THIS.ConfigurarBotoesPrincipais()

            *-- Area de entrada de dados: shape + label + textbox planilha + botao selecionar
            *-- (equivalente conceitual a "Page2/Dados" para form OPERACIONAL flat)
            THIS.ConfigurarPaginaDados()

            *-- Area de resultado/lista: grid de SKUs importados + botoes Limpar/Processar
            THIS.ConfigurarPaginaLista()

            *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
            THIS.TornarControlesVisiveis()

            *-- Titulo do formulario (CHR: Importacao = Importa+231+227+o)
            loc_cTitulo = "Importa" + CHR(231) + CHR(227) + "o de SKUs (VTX)"
            THIS.Caption = loc_cTitulo
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo

            *-- BINDEVENT para KeyPress no nivel do form (ESC fecha)
            BINDEVENT(THIS, "KeyPress", THIS, "FormKeyPress")

            *-- Conecta grade ao cursor vazio inicial
            THIS.MontaGrade()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *==========================================================================
        LOCAL loc_oCab
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho

        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize   = .F.
            .FontName   = "Tahoma"
            .FontSize   = 18
            .FontBold   = .T.
            .WordWrap   = .T.
            .BackStyle  = 0
            .Caption    = ""
            .Height     = 40
            .Left       = 10
            .Top        = 18
            .Width      = THIS.Width - 20
            .ForeColor  = RGB(0, 0, 0)
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize   = .F.
            .FontName   = "Tahoma"
            .FontSize   = 18
            .FontBold   = .T.
            .WordWrap   = .T.
            .BackStyle  = 0
            .Caption    = ""
            .Height     = 46
            .Left       = 10
            .Top        = 17
            .Width      = THIS.Width - 20
            .ForeColor  = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesPrincipais()
    *-- Equivalente ao Grupo_Botao legado (cmdok=Salvar + cmdsair=Encerrar)
    *-- Posicionado no topo-direito: Left=840, Width=160, right=1000
    *==========================================================================
        LOCAL loc_oCmg
        THIS.AddObject("cmg_4c_Principal", "CommandGroup")
        loc_oCmg = THIS.cmg_4c_Principal

        WITH loc_oCmg
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Height        = 85
            .Left          = 840
            .Top           = -2
            .Width         = 160
            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Caption    = "\<Salvar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH
            WITH .Buttons(2)
                .Top        = 5
                .Left       = 80
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Caption    = "Encerrar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH
        ENDWITH

        *-- BINDEVENT para click do CommandGroup principal
        BINDEVENT(THIS.cmg_4c_Principal, "Click", THIS, "CmgPrincipalClick")
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
    *==========================================================================
        LOCAL loc_nI, loc_oObjeto, loc_oParent

        IF PCOUNT() < 1 OR VARTYPE(par_oContainer) != "O"
            loc_oParent = THIS
        ELSE
            loc_oParent = par_oContainer
        ENDIF

        FOR loc_nI = 1 TO loc_oParent.ControlCount
            loc_oObjeto = loc_oParent.Controls(loc_nI)
            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *-- Area de entrada de dados: shape decorativo + label "Planilha:" +
    *-- textbox do caminho da planilha + botao "..." para selecionar arquivo.
    *-- Form OPERACIONAL flat (sem PageFrame): esta e a metade "input"
    *-- do layout do legado SIGPRVTX (Shape1 + Say4 + GetPlanilha + cmdgetp).
    *==========================================================================
        LOCAL loc_oBtn

        *-- Shape decorativo ao redor da area de selecao de planilha
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top           = 82
            .Left          = 38
            .Width         = 632
            .Height        = 52
            .Curvature     = 0
            .SpecialEffect = 1
            .FillStyle     = 1
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
        ENDWITH

        *-- Label "Planilha:" (Say4 legado: top=84, left=133)
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Top       = 87
            .Left      = 166
            .Width     = 61
            .Height    = 15
            .Caption   = "Planilha:"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
        ENDWITH

        *-- TextBox para caminho da planilha (GetPlanilha legado: top=101, left=133, w=336)
        THIS.AddObject("txt_4c_Planilha", "TextBox")
        WITH THIS.txt_4c_Planilha
            .Top         = 105
            .Left        = 166
            .Width       = 420
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ReadOnly    = .T.
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
        ENDWITH

        *-- Botao para selecionar arquivo (cmdgetp legado: top=86, left=471, w=65, h=44)
        THIS.AddObject("cmd_4c_GetPlanilha", "CommandButton")
        loc_oBtn = THIS.cmd_4c_GetPlanilha
        WITH loc_oBtn
            .Top             = 89
            .Left            = 589
            .Width           = 81
            .Height          = 44
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
            .FontName        = "Verdana"
            .FontSize        = 8
            .Themes          = .T.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(36, 84, 155)
            .ToolTipText     = "Selecionar planilha Excel"
            .MousePointer    = 15
        ENDWITH

        *-- Vincula evento do botao de selecao de arquivo (integracao area Dados)
        BINDEVENT(THIS.cmd_4c_GetPlanilha, "Click", THIS, "CmdGetPlanilhaClick")
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *-- Area de resultado/lista: grade de SKUs importados + botoes Processar/Limpar.
    *-- Form OPERACIONAL flat (sem PageFrame): esta e a metade "resultado"
    *-- do layout do legado SIGPRVTX (Grade + cmdProcessar + cmdLimpar).
    *==========================================================================
        LOCAL loc_oGrid, loc_oBtn

        *-- Botao Limpar (cmdLimpar legado: top=3, left=498, w=75, h=75)
        THIS.AddObject("cmd_4c_Limpar", "CommandButton")
        loc_oBtn = THIS.cmd_4c_Limpar
        WITH loc_oBtn
            .Top             = 3
            .Left            = 623
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Limpar"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .MousePointer    = 15
            .SpecialEffect   = 0
            .ToolTipText     = "Limpar grade e campo planilha"
        ENDWITH

        *-- Botao Processar/Importar (cmdProcessar legado: top=3, left=573, w=75, h=75)
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        loc_oBtn = THIS.cmd_4c_Processar
        WITH loc_oBtn
            .Top             = 3
            .Left            = 716
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Processar"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .MousePointer    = 15
            .SpecialEffect   = 0
            .ToolTipText     = "Importar planilha Excel para a grade"
        ENDWITH

        *-- Grade principal (Grade legado: top=133, left=30, w=725, h=435)
        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados
        WITH loc_oGrid
            .Top                = 138
            .Left               = 12
            .Width              = 976
            .Height             = 450
            .ColumnCount        = 4
            .RecordMark         = .F.
            .DeleteMark         = .F.
            .ReadOnly           = .T.
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .RowHeight          = 16
            .ScrollBars         = 2
            .FontName           = "Tahoma"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
        ENDWITH

        *-- Vincula eventos dos botoes de acao da area lista/resultado
        BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "CmdProcessarClick")
        BINDEVENT(THIS.cmd_4c_Limpar,    "Click", THIS, "CmdLimparClick")
    ENDPROC

    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
    *-- Form OPERACIONAL flat: sem alternancia de paginas
    *==========================================================================
        RETURN
    ENDPROC

    *==========================================================================
    PROCEDURE CmgPrincipalClick()
    *-- Handler: Buttons(1)=Salvar/Processar DB, Buttons(2)=Encerrar
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_nBotao
        loc_nBotao = THIS.cmg_4c_Principal.Value

        IF loc_nBotao = 1
            TRY
                IF !USED("cursor_4c_Grade") OR RECCOUNT("cursor_4c_Grade") = 0
                    MsgAviso("Nenhum registro para atualiza" + CHR(231) + CHR(227) + "o.", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    IF MsgConfirma("Deseja atualizar as informa" + CHR(231) + CHR(245) + "es?")
                        loc_lSucesso = THIS.this_oBusinessObject.ProcessarGrade("cursor_4c_Grade")
                        IF loc_lSucesso
                            THIS.LimpaGrade()
                            MsgInfo("Dados atualizados com sucesso.", "Sucesso")
                        ELSE
                            MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                                "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
            ENDTRY
        ELSE
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE CmdGetPlanilhaClick()
    *-- Abre dialogo de selecao de arquivo Excel (cmdgetp.Click legado)
    *==========================================================================
        LOCAL loc_cArquivo
        loc_cArquivo = GETFILE("xls", "Planilha", "Importar")
        IF !EMPTY(loc_cArquivo)
            THIS.txt_4c_Planilha.Value = loc_cArquivo
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE CmdProcessarClick()
    *-- Importa planilha para cursor_4c_Grade e atualiza grade
    *==========================================================================
        IF EMPTY(THIS.txt_4c_Planilha.Value)
            MsgAviso("Planilha n" + CHR(227) + "o informada.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF THIS.ImportarPlanilha(THIS.txt_4c_Planilha.Value)
            THIS.MontaGrade()
            THIS.txt_4c_Planilha.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE CmdLimparClick()
    *-- Limpa grade e campo planilha (cmdLimpar.Click legado)
    *==========================================================================
        THIS.LimpaGrade()
        IF VARTYPE(THIS.txt_4c_Planilha) = "O"
            THIS.txt_4c_Planilha.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ImportarPlanilha(par_cArquivo)
    *-- Le arquivo Excel via ImpExcelDriver e popula cursor_4c_Grade
    *-- Replica logica do metodo Processamento() do form legado SIGPRVTX
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSkuId, loc_cNomeSku, loc_cSkuAtivo, loc_cRefSku
        loc_lSucesso = .F.

        TRY
            IF !FILE(par_cArquivo)
                MsgAviso("Arquivo n" + CHR(227) + "o encontrado:" + CHR(13) + par_cArquivo, ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- Fecha cursores de execucao anterior
                IF USED("Planilha")
                    USE IN Planilha
                ENDIF
                IF USED("xlResults")
                    USE IN xlResults
                ENDIF

                *-- Limpa cursor da grade antes de reimportar
                IF USED("cursor_4c_Grade")
                    SELECT cursor_4c_Grade
                    ZAP
                ENDIF

                *-- ImpExcelDriver (Framework) cria cursor xlResults com os dados do XLS
                IF ImpExcelDriver(par_cArquivo)
                    IF USED("xlResults")
                        *-- Copia xlResults para cursor Planilha com nome fixo
                        SELECT * FROM xlResults INTO CURSOR Planilha READWRITE
                        IF USED("xlResults")
                            USE IN xlResults
                        ENDIF

                        SELECT Planilha
                        GO TOP
                        SCAN
                            loc_cSkuId    = ALLTRIM(NVL(TRANSFORM(skuid),    ""))
                            loc_cNomeSku  = ALLTRIM(NVL(TRANSFORM(nomesku),  ""))
                            loc_cSkuAtivo = ALLTRIM(NVL(TRANSFORM(skuativo), ""))
                            loc_cRefSku   = ALLTRIM(NVL(TRANSFORM(refsku),   ""))

                            IF !EMPTY(loc_cSkuId)
                                *-- Inserir somente se nao houver duplicata por skuid
                                IF !SEEK(loc_cSkuId, "cursor_4c_Grade", "skuid")
                                    INSERT INTO cursor_4c_Grade ;
                                        (skuid, nomesku, skuativo, refsku) ;
                                        VALUES (;
                                            LEFT(loc_cSkuId,    10), ;
                                            LEFT(loc_cNomeSku, 100), ;
                                            LEFT(loc_cSkuAtivo,  3), ;
                                            LEFT(loc_cRefSku,   40))
                                ENDIF
                                SELECT Planilha
                            ENDIF
                        ENDSCAN

                        USE IN Planilha
                        SELECT cursor_4c_Grade
                        GO TOP
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Erro ao criar cursor da planilha (xlResults n" + ;
                            CHR(227) + "o foi criado).", "Erro")
                    ENDIF
                ELSE
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel ler a planilha." + ;
                        CHR(13) + "Verifique se o arquivo n" + CHR(227) + "o est" + ;
                        CHR(225) + " em uso por outro processo.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE MontaGrade()
    *-- Conecta grd_4c_Dados ao cursor_4c_Grade e (re)define colunas+cabecalhos
    *-- Equivalente ao metodo MontaGrade() do form legado SIGPRVTX
    *==========================================================================
        LPARAMETERS par_cGrupo
        LOCAL loc_oGrid
        IF VARTYPE(THIS.grd_4c_Dados) != "O"
            RETURN
        ENDIF
        IF !USED("cursor_4c_Grade")
            RETURN
        ENDIF

        loc_oGrid = THIS.grd_4c_Dados
        loc_oGrid.RecordSource = ""
        SELECT cursor_4c_Grade
        GO TOP
        loc_oGrid.ColumnCount  = 4
        loc_oGrid.RecordSource = "cursor_4c_Grade"

        WITH loc_oGrid
            .Column1.ControlSource    = "cursor_4c_Grade.skuid"
            .Column1.Width            = 94
            .Column1.ReadOnly         = .T.
            .Column1.Movable          = .F.
            .Column1.Resizable        = .F.
            .Column1.Header1.Caption  = "SKU ID"
            .Column1.Header1.FontName = "Tahoma"
            .Column1.Header1.FontBold = .T.

            .Column2.ControlSource    = "cursor_4c_Grade.nomesku"
            .Column2.Width            = 539
            .Column2.ReadOnly         = .T.
            .Column2.Movable          = .F.
            .Column2.Resizable        = .F.
            .Column2.Header1.Caption  = "Nome SKU"
            .Column2.Header1.FontName = "Tahoma"
            .Column2.Header1.FontBold = .T.

            .Column3.ControlSource    = "cursor_4c_Grade.skuativo"
            .Column3.Width            = 94
            .Column3.ReadOnly         = .T.
            .Column3.Movable          = .F.
            .Column3.Resizable        = .F.
            .Column3.Header1.Caption  = "SKU Ativo"
            .Column3.Header1.FontName = "Tahoma"
            .Column3.Header1.FontBold = .T.

            .Column4.ControlSource    = "cursor_4c_Grade.refsku"
            .Column4.Width            = 249
            .Column4.ReadOnly         = .T.
            .Column4.Header1.Caption  = "Referencia SKU"
            .Column4.Header1.FontName = "Tahoma"
            .Column4.Header1.FontBold = .T.

            .Refresh()
        ENDWITH
    ENDPROC

    *==========================================================================
    PROCEDURE LimpaGrade()
    *-- Zap cursor_4c_Grade e reconecta grade (LimpaGrade() do legado)
    *==========================================================================
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.RecordSource = ""
        ENDIF

        IF USED("cursor_4c_Grade")
            SELECT cursor_4c_Grade
            ZAP
        ENDIF

        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.ColumnCount  = 4
            THIS.grd_4c_Dados.RecordSource = "cursor_4c_Grade"
            WITH THIS.grd_4c_Dados
                .Column1.ControlSource = "cursor_4c_Grade.skuid"
                .Column2.ControlSource = "cursor_4c_Grade.nomesku"
                .Column3.ControlSource = "cursor_4c_Grade.skuativo"
                .Column4.ControlSource = "cursor_4c_Grade.refsku"
                .Refresh()
            ENDWITH
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE FormKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *-- Handler de KeyPress do form: ESC fecha o formulario
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 27
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnIncluirClick()
    *-- Acao INCLUIR (form OPERACIONAL VTX): importar novo lote de SKUs da
    *-- planilha Excel para a grade. Se nao ha planilha selecionada, abre o
    *-- dialogo de selecao antes de importar.
    *==========================================================================
        LOCAL loc_cArquivo
        IF VARTYPE(THIS.txt_4c_Planilha) != "O"
            RETURN
        ENDIF

        IF EMPTY(THIS.txt_4c_Planilha.Value)
            loc_cArquivo = GETFILE("xls", "Planilha", "Importar")
            IF EMPTY(loc_cArquivo)
                RETURN
            ENDIF
            THIS.txt_4c_Planilha.Value = loc_cArquivo
        ENDIF

        IF THIS.ImportarPlanilha(THIS.txt_4c_Planilha.Value)
            THIS.MontaGrade()
            THIS.txt_4c_Planilha.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnAlterarClick()
    *-- Acao ALTERAR (form OPERACIONAL VTX): persistir a grade importada no
    *-- banco (equivalente ao Buttons(1) de Grupo_Botao legado - DELETE + INSERT
    *-- em SigPrVtx). Corresponde ao "Salvar" do CommandGroup principal.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_lProsseguir
        loc_lSucesso   = .F.
        loc_lProsseguir = .F.

        TRY
            IF !USED("cursor_4c_Grade") OR RECCOUNT("cursor_4c_Grade") = 0
                MsgAviso("Nenhum registro para atualiza" + CHR(231) + CHR(227) + "o.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF MsgConfirma("Deseja atualizar as informa" + CHR(231) + CHR(245) + "es?")
                    loc_lProsseguir = .T.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_lSucesso = THIS.this_oBusinessObject.ProcessarGrade("cursor_4c_Grade")
                IF loc_lSucesso
                    THIS.LimpaGrade()
                    MsgInfo("Dados atualizados com sucesso.", "Sucesso")
                ELSE
                    MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnVisualizarClick()
    *-- Acao VISUALIZAR (form OPERACIONAL VTX): recarrega a grade a partir dos
    *-- SKUs ja persistidos em SigPrVtx (equivalente a "refresh" do estado
    *-- atual do banco). Popula cursor_4c_Grade via BO e reata o grid.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgAviso("Business Object n" + CHR(227) + "o inicializado.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- Fecha cursor local para o BO poder recria-lo com dados do banco
                IF USED("cursor_4c_Grade") AND VARTYPE(THIS.grd_4c_Dados) = "O"
                    THIS.grd_4c_Dados.RecordSource = ""
                    SELECT cursor_4c_Grade
                    USE
                ENDIF

                loc_lSucesso = THIS.this_oBusinessObject.CarregarGrade("cursor_4c_Grade")
                IF loc_lSucesso
                    THIS.MontaGrade()
                    IF USED("cursor_4c_Grade") AND RECCOUNT("cursor_4c_Grade") = 0
                        MsgAviso("Nenhum SKU cadastrado em SigPrVtx.", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                    ENDIF
                ELSE
                    MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnExcluirClick()
    *-- Acao EXCLUIR (form OPERACIONAL VTX): limpa a grade importada e o campo
    *-- de planilha. Nao apaga registros do banco - apenas descarta o lote em
    *-- staging que ainda nao foi persistido (equivalente ao botao Limpar).
    *==========================================================================
        IF !USED("cursor_4c_Grade") OR RECCOUNT("cursor_4c_Grade") = 0
            MsgAviso("Grade j" + CHR(225) + " est" + CHR(225) + " vazia.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF !MsgConfirma("Deseja limpar a grade importada?")
            RETURN
        ENDIF

        THIS.LimpaGrade()
        IF VARTYPE(THIS.txt_4c_Planilha) = "O"
            THIS.txt_4c_Planilha.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnBuscarClick()
    *-- Busca/recarrega registros do banco (SKUs ja persistidos em sigprvtx)
    *==========================================================================
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnEncerrarClick()
    *-- Fecha o formulario
    *==========================================================================
        THIS.Release()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnSalvarClick()
    *-- Salva a grade importada no banco (DELETE + INSERT em sigprvtx)
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro

        TRY
            IF !USED("cursor_4c_Grade") OR RECCOUNT("cursor_4c_Grade") = 0
                MsgAviso("Nenhum registro para atualiza" + CHR(231) + CHR(227) + "o.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF MsgConfirma("Deseja atualizar as informa" + CHR(231) + CHR(245) + "es?")
                    loc_lSucesso = THIS.this_oBusinessObject.ProcessarGrade("cursor_4c_Grade")
                    IF loc_lSucesso
                        THIS.LimparCampos()
                        MsgInfo("Dados atualizados com sucesso.", "Sucesso")
                    ELSE
                        MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnCancelarClick()
    *-- Cancela importacao em andamento: limpa grade e campo de planilha
    *==========================================================================
        IF USED("cursor_4c_Grade") AND RECCOUNT("cursor_4c_Grade") > 0
            IF !MsgConfirma("Deseja cancelar a importa" + CHR(231) + CHR(227) + "o e limpar a grade?")
                RETURN
            ENDIF
        ENDIF
        THIS.LimparCampos()
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarLista()
    *-- Carrega os SKUs ja persistidos em sigprvtx para exibicao na grade
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgAviso("Business Object n" + CHR(227) + "o inicializado.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF VARTYPE(THIS.grd_4c_Dados) = "O"
                    THIS.grd_4c_Dados.RecordSource = ""
                ENDIF

                IF USED("cursor_4c_Grade")
                    SELECT cursor_4c_Grade
                    USE
                ENDIF

                loc_lSucesso = THIS.this_oBusinessObject.CarregarGrade("cursor_4c_Grade")
                IF loc_lSucesso
                    THIS.MontaGrade()
                    IF USED("cursor_4c_Grade") AND RECCOUNT("cursor_4c_Grade") = 0
                        MsgAviso("Nenhum SKU cadastrado em sigprvtx.", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                    ENDIF
                ELSE
                    MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
    *-- Popula o BO com dados do formulario (OPERACIONAL: informa cursor da grade)
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cPlanilha = THIS.txt_4c_Planilha.Value
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
    *-- Atualiza formulario com dados do BO (OPERACIONAL: reconecta grade)
    *==========================================================================
        THIS.MontaGrade()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
    *-- Habilita ou desabilita campos de entrada (form OPERACIONAL: sempre ativo)
    *==========================================================================
        LOCAL loc_lHab
        IF PCOUNT() < 1
            loc_lHab = .T.
        ELSE
            loc_lHab = par_lHabilitar
        ENDIF

        IF VARTYPE(THIS.txt_4c_Planilha) = "O"
            THIS.txt_4c_Planilha.ReadOnly = !loc_lHab
        ENDIF
        IF VARTYPE(THIS.cmd_4c_GetPlanilha) = "O"
            THIS.cmd_4c_GetPlanilha.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Processar) = "O"
            THIS.cmd_4c_Processar.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Limpar) = "O"
            THIS.cmd_4c_Limpar.Enabled = loc_lHab
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
    *-- Limpa campo de planilha e esvazia a grade
    *==========================================================================
        IF VARTYPE(THIS.txt_4c_Planilha) = "O"
            THIS.txt_4c_Planilha.Value = ""
        ENDIF
        THIS.LimpaGrade()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
    *-- Form OPERACIONAL flat: sem modos (INCLUIR/ALTERAR/VISUALIZAR)
    *-- Todos os botoes permanecem habilitados
    *==========================================================================
        THIS.HabilitarCampos(.T.)
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        IF USED("cursor_4c_Grade")
            USE IN cursor_4c_Grade
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
