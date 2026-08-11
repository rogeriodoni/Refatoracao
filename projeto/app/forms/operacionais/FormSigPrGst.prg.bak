*==============================================================================
* FormSigPrGst.prg - Geracao de Movimentacoes de Estoque
*
* Tipo: OPERACIONAL - layout flat customizado (sem PageFrame)
* Migrado de: SIGPRGST.SCX
* Fase 8/8 COMPLETO.
*
* Este formulario e aberto por outro formulario pai que passa seus cursores
* (csCabec, csItens, CsEstPe, CrSigCdNec) no workspace global.
* Recebe referencia ao formulario pai via parametro par_oFormPai.
*==============================================================================

DEFINE CLASS FormSigPrGst AS FormBase

    *-- Propriedades visuais (copiadas exatamente do original SIGPRGST)
    Height       = 600
    Width        = 1000
    AutoCenter   = .T.
    BorderStyle  = 2
    TitleBar     = 0
    ShowWindow = 1
    ControlBox   = .F.
    Movable      = .F.
    KeyPreview   = .T.
    WindowType   = 1
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Referencias do formulario pai
    this_oFormPai   = .NULL.   && Formulario que abriu este sub-form
    this_cPcEscolha = ""       && Escolha de processamento herdada do pai
    this_cGrupoOper = ""       && Grupo de operacao (legado: grupooper)

    *-- Business Object
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""

    *==========================================================================
    PROCEDURE Init(par_oFormPai)
    *==========================================================================
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            *-- Armazenar referencia do formulario pai ANTES de DODEFAULT
            IF VARTYPE(par_oFormPai) = "O"
                THIS.this_oFormPai = par_oFormPai
            ENDIF
            THIS.this_cGrupoOper = SPACE(10)

            *-- DODEFAULT chama FormBase.Init -> InicializarForm
            loc_lResultado = DODEFAULT()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGstBO")
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigPrGst.", "Erro")
            ELSE
                *-- Definir Caption antes de ConfigurarCabecalho (labels usam THIS.Caption)
                THIS.Caption = "Gera" + CHR(231) + CHR(227) + "o de Movimenta" + CHR(231) + ;
                               CHR(245) + "es de Estoque"

                *-- Imagem de fundo e titulo
                THIS.ConfigurarPageFrame()

                *-- Cabecalho cinza escuro com titulo
                THIS.ConfigurarCabecalho()

                *-- Shape decorativo separador
                THIS.ConfigurarSeparador()

                *-- Botoes operacionais: Confirmar + Encerrar
                THIS.ConfigurarBotoes()

                *-- Grades de cabecalho e itens (Fase 4)
                THIS.ConfigurarGrids()

                *-- Propriedades visuais dos Text1 das colunas dos grids (Fase 5)
                THIS.ConfigurarPaginaDados()

                *-- Tornar controles visiveis (exceto os que gerenciam Visible proprios)
                THIS.TornarControlesVisiveis()

                *-- Vincular eventos de botoes e grade
                THIS.ConfigurarBINDEVENTs()

                *-- Navegacao inicial dos cursores e refresh das grades
                THIS.CarregarDados()

                *-- Propagar titulo para labels do cabecalho
                THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro FormSigPrGst.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - OPERACIONAL: sem PageFrame, fundo via Picture
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container escuro com titulo (cntSombra original)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Visible     = .T.
            .Top         = 0
            .Left        = 0
            .Width       = 1100
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100,100,100)

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .AutoSize      = .F.
                .BackStyle     = 0
                .Caption       = THIS.Caption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width
                .ForeColor     = RGB(0,0,0)
                .Visible       = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .AutoSize   = .F.
                .BackStyle  = 0
                .Caption    = THIS.Caption
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = THIS.Width
                .ForeColor  = RGB(255,255,255)
                .Visible    = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarSeparador - Shape decorativo entre grid de cabecalho e botoes
    *   Original: ShpP2 em Top=11, Left=819, Width=21, Height=37
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarSeparador
        THIS.AddObject("shp_4c_ShpP2", "Shape")
        WITH THIS.shp_4c_ShpP2
            .Top           = 11
            .Left          = 819
            .Width         = 21
            .Height        = 37
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136,189,188)
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Botoes operacionais Confirmar (CmdGrava) e Encerrar
    *   CmdGrava  original: Top=3, Left=850, Picture=geral_disco2_60.jpg
    *   CmdCancela original: Top=3, Left=925, Picture=cadastro_sair_60.jpg, Cancel=.T.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes
        THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH THIS.cmd_4c_Confirmar
            .Top             = 3
            .Left            = 850
            .Width           = 75
            .Height          = 75
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
            .Themes          = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 3
            .Left            = 925
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .Themes          = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrids - Grade de cabecalho (GrdCab) e de itens (GrdIte)
    *   Fase 4: implementacao completa com cursores csCabec/csItens
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrids
        THIS.ConfigurarGrdCab()
        THIS.ConfigurarGrdIte()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Alias operacional para ConfigurarGrids
    *   Este form OPERACIONAL nao tem PageFrame Lista/Dados; a "pagina de
    *   listagem" equivale as duas grades (cabecalho + itens). Delegar aqui
    *   mantem compatibilidade com o pipeline generico de forms CRUD.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
        THIS.ConfigurarGrids()
    ENDPROC

    *==========================================================================
    * AlternarPagina - Em forms OPERACIONAIS sem PageFrame, "alternar" equivale
    *   a re-sincronizar a navegacao dos cursores csCabec/csItens e refresh
    *   das grades. Compativel com a assinatura do pipeline (par_nPagina).
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    * ConfigurarGrdCab - Grade de cabecalho (Fase 4)
    *   Original: Top=95, Left=11, Width=798, Height=194, ColumnCount=7
    *   Colunas: Emp | Grupo Origem | Conta Origem | Conta Destino | Grupo Destino | Confirmacao | Movimentacao
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrdCab
        LOCAL loc_oGrid

        *-- Garantir alias aberto antes de vincular ControlSource/RecordSource
        IF !USED("csCabec")
            CREATE CURSOR csCabec (Emps C(3), EmpDs C(40), Dopes C(20), ;
                Numes N(6,0), MascNum C(10), GrupoOs C(10), ContaOs C(10), ;
                GrupoDs C(10), ContaDs C(10), Gerado C(2), GerEmps C(3), ;
                GerDopes C(20), GerNumes N(6,0), EmpDopNums C(29), ;
                EmpDnPs C(33), Datars D)
        ENDIF

        THIS.AddObject("grd_4c_Cab", "Grid")
        THIS.grd_4c_Cab.ColumnCount      = 7
        THIS.grd_4c_Cab.RecordSourceType = 1
        THIS.grd_4c_Cab.RecordSource     = "csCabec"
        WITH THIS.grd_4c_Cab
            .Top              = 95
            .Left             = 11
            .Width            = 798
            .Height           = 194
            .FontName         = "Verdana"
            .FontSize         = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing   = .F.
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .HeaderHeight     = 15
            .ReadOnly         = .T.
            .RowHeight        = 16
            .ScrollBars       = 2
            .TabStop          = .F.
            .GridLineColor    = RGB(238,238,238)
            .Visible          = .T.

            *-- Coluna 1: Emp (Width=35, ColumnOrder=1)
            .Column1.Width       = 35
            .Column1.ColumnOrder = 1
            .Column1.Movable     = .F.
            .Column1.Resizable   = .F.
            .Column1.ReadOnly    = .T.
            .Column1.FontSize    = 8
            .Column1.Header1.Caption   = "Emp"
            .Column1.Header1.Alignment = 2
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.ForeColor = RGB(0,0,0)

            *-- Coluna 2: Grupo Origem (Width=100, ColumnOrder=3)
            .Column2.Width       = 100
            .Column2.ColumnOrder = 3
            .Column2.Movable     = .F.
            .Column2.Resizable   = .F.
            .Column2.ReadOnly    = .T.
            .Column2.FontSize    = 8
            .Column2.Header1.Caption   = "Grupo Origem"
            .Column2.Header1.Alignment = 2
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.ForeColor = RGB(0,0,0)

            *-- Coluna 3: Conta Origem (Width=100, ColumnOrder=4)
            .Column3.Width       = 100
            .Column3.ColumnOrder = 4
            .Column3.Movable     = .F.
            .Column3.Resizable   = .F.
            .Column3.ReadOnly    = .T.
            .Column3.FontSize    = 8
            .Column3.Header1.Caption   = "Conta Origem"
            .Column3.Header1.Alignment = 2
            .Column3.Header1.FontName  = "Tahoma"
            .Column3.Header1.ForeColor = RGB(0,0,0)

            *-- Coluna 4: Conta Destino (Width=100, ColumnOrder=5)
            .Column4.Width       = 100
            .Column4.ColumnOrder = 5
            .Column4.Movable     = .F.
            .Column4.Resizable   = .F.
            .Column4.ReadOnly    = .T.
            .Column4.FontSize    = 8
            .Column4.Header1.Caption   = "Conta Destino"
            .Column4.Header1.Alignment = 2
            .Column4.Header1.FontName  = "Tahoma"
            .Column4.Header1.ForeColor = RGB(0,0,0)

            *-- Coluna 5: Grupo Destino (Width=100, ColumnOrder=6)
            .Column5.Width       = 100
            .Column5.ColumnOrder = 6
            .Column5.Movable     = .F.
            .Column5.Resizable   = .F.
            .Column5.ReadOnly    = .T.
            .Column5.FontSize    = 8
            .Column5.Header1.Caption   = "Grupo Destino"
            .Column5.Header1.Alignment = 2
            .Column5.Header1.FontName  = "Tahoma"
            .Column5.Header1.ForeColor = RGB(0,0,0)

            *-- Coluna 6: Confirmacao (Width=100, ColumnOrder=7, verde/bold)
            .Column6.Width       = 100
            .Column6.ColumnOrder = 7
            .Column6.Movable     = .F.
            .Column6.Resizable   = .F.
            .Column6.ReadOnly    = .T.
            .Column6.FontSize    = 8
            .Column6.FontBold    = .T.
            .Column6.Alignment   = 2
            .Column6.ForeColor   = RGB(0,128,0)
            .Column6.Header1.Caption   = "Confirma" + CHR(231) + CHR(227) + "o"
            .Column6.Header1.Alignment = 2
            .Column6.Header1.FontName  = "Tahoma"
            .Column6.Header1.ForeColor = RGB(0,0,0)

            *-- Coluna 7: Movimentacao (Width=225, ColumnOrder=2)
            .Column7.Width       = 225
            .Column7.ColumnOrder = 2
            .Column7.Movable     = .F.
            .Column7.Resizable   = .F.
            .Column7.ReadOnly    = .T.
            .Column7.FontSize    = 8
            .Column7.Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
            .Column7.Header1.Alignment = 2
            .Column7.Header1.FontName  = "Tahoma"
            .Column7.Header1.ForeColor = RGB(0,0,0)

            *-- ControlSource e DynamicBackColor (vincula ao cursor csCabec)
            .Column1.ControlSource = "csCabec.EmpDs"
            .Column2.ControlSource = "csCabec.GrupoOs"
            .Column3.ControlSource = "csCabec.ContaOs"
            .Column4.ControlSource = "csCabec.ContaDs"
            .Column5.ControlSource = "csCabec.GrupoDs"
            .Column6.ControlSource = "csCabec.Gerado"
            .Column7.ControlSource = "csCabec.Dopes"
            .SetAll("DynamicBackColor", ;
                "IIF(EMPTY(csCabec.Gerado), RGB(255,255,255), RGB(255,255,204))", ;
                "Column")
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrdIte - Grade de itens (Fase 4)
    *   Original: Top=295, Left=10, Width=980, Height=289, ColumnCount=7
    *   Colunas: [seq] | Produto | Descricao | M | Pr.Unit. | Quantidade | Total
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrdIte
        *-- Garantir alias aberto antes de vincular ControlSource/RecordSource
        IF !USED("csItens")
            CREATE CURSOR csItens (CItens N(6,0), CPros C(20), DPros C(65), ;
                Moedas C(3), Units N(15,5), Qtds N(15,3), Totas N(15,2), ;
                EmpDopNums C(29))
        ENDIF

        THIS.AddObject("grd_4c_Ite", "Grid")
        THIS.grd_4c_Ite.ColumnCount      = 7
        THIS.grd_4c_Ite.RecordSourceType = 1
        THIS.grd_4c_Ite.RecordSource     = "csItens"
        WITH THIS.grd_4c_Ite
            .Top              = 295
            .Left             = 10
            .Width            = 980
            .Height           = 289
            .FontName         = "Verdana"
            .FontSize         = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing   = .F.
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .HeaderHeight     = 15
            .ReadOnly         = .T.
            .RowHeight        = 16
            .ScrollBars       = 2
            .TabStop          = .F.
            .GridLineColor    = RGB(238,238,238)
            .Visible          = .T.

            *-- Coluna 1: [sequencial CItens] (Width=36, ColumnOrder=1)
            .Column1.Width       = 36
            .Column1.ColumnOrder = 1
            .Column1.Movable     = .F.
            .Column1.Resizable   = .F.
            .Column1.ReadOnly    = .T.
            .Column1.FontSize    = 8
            .Column1.Header1.Caption   = ""
            .Column1.Header1.Alignment = 2
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.ForeColor = RGB(0,0,0)

            *-- Coluna 2: Produto - CPros (Width=120, ColumnOrder=2)
            .Column2.Width       = 120
            .Column2.ColumnOrder = 2
            .Column2.Movable     = .F.
            .Column2.Resizable   = .F.
            .Column2.ReadOnly    = .T.
            .Column2.FontSize    = 8
            .Column2.Header1.Caption   = "Produto"
            .Column2.Header1.Alignment = 2
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.ForeColor = RGB(0,0,0)

            *-- Coluna 3: Descricao do Produto - DPros (Width=403, ColumnOrder=3)
            .Column3.Width       = 403
            .Column3.ColumnOrder = 3
            .Column3.Movable     = .F.
            .Column3.Resizable   = .F.
            .Column3.ReadOnly    = .T.
            .Column3.FontSize    = 8
            .Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o do Produto"
            .Column3.Header1.Alignment = 2
            .Column3.Header1.FontName  = "Tahoma"
            .Column3.Header1.ForeColor = RGB(0,0,0)

            *-- Coluna 4: M - Moedas (Width=23, ColumnOrder=4)
            .Column4.Width       = 23
            .Column4.ColumnOrder = 4
            .Column4.Movable     = .F.
            .Column4.Resizable   = .F.
            .Column4.ReadOnly    = .T.
            .Column4.FontSize    = 8
            .Column4.Header1.Caption   = "M"
            .Column4.Header1.Alignment = 2
            .Column4.Header1.FontName  = "Tahoma"
            .Column4.Header1.ForeColor = RGB(0,0,0)

            *-- Coluna 5: Preco Unitario - Units (Width=130, ColumnOrder=5)
            .Column5.Width       = 130
            .Column5.ColumnOrder = 5
            .Column5.Movable     = .F.
            .Column5.Resizable   = .F.
            .Column5.ReadOnly    = .T.
            .Column5.FontSize    = 8
            .Column5.Header1.Caption   = "Pr. Unit."
            .Column5.Header1.Alignment = 2
            .Column5.Header1.FontName  = "Tahoma"
            .Column5.Header1.ForeColor = RGB(0,0,0)

            *-- Coluna 6: Quantidade - Qtds (Width=100, ColumnOrder=6)
            .Column6.Width       = 100
            .Column6.ColumnOrder = 6
            .Column6.Movable     = .F.
            .Column6.Resizable   = .F.
            .Column6.ReadOnly    = .T.
            .Column6.FontSize    = 8
            .Column6.Header1.Caption   = "Quantidade"
            .Column6.Header1.Alignment = 2
            .Column6.Header1.FontName  = "Tahoma"
            .Column6.Header1.ForeColor = RGB(0,0,0)

            *-- Coluna 7: Total - Totas (Width=130, ColumnOrder=7)
            .Column7.Width       = 130
            .Column7.ColumnOrder = 7
            .Column7.Movable     = .F.
            .Column7.Resizable   = .F.
            .Column7.ReadOnly    = .T.
            .Column7.FontSize    = 8
            .Column7.Header1.Caption   = "Total"
            .Column7.Header1.Alignment = 2
            .Column7.Header1.FontName  = "Tahoma"
            .Column7.Header1.ForeColor = RGB(0,0,0)

            *-- ControlSource (vincula ao cursor csItens)
            .Column1.ControlSource = "csItens.CItens"
            .Column2.ControlSource = "csItens.CPros"
            .Column3.ControlSource = "csItens.DPros"
            .Column4.ControlSource = "csItens.Moedas"
            .Column5.ControlSource = "csItens.Units"
            .Column6.ControlSource = "csItens.Qtds"
            .Column7.ControlSource = "csItens.Totas"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Fase 5/8: propriedades visuais Text1 dos grids
    *   Para este form OPERACIONAL flat (sem Page2), esta fase configura as
    *   propriedades dos controles Text1 dentro das colunas dos grids, conforme
    *   as propriedades definidas no SCX original (BorderStyle=0, Margin=0,
    *   ForeColor, BackColor), e aplica HighlightColors canonicos em ambos.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados
        THIS.ConfigurarTextosGrdCab()
        THIS.ConfigurarTextosGrdIte()
    ENDPROC

    *==========================================================================
    * ConfigurarTextosGrdCab - Propriedades Text1 de GrdCab + HighlightColors
    *   Original SCX: Text1.BorderStyle=0, Margin=0, ForeColor=0,0,0
    *   BackColor=255,255,255 em todos; Column6.Text1 FontBold=.T. Alignment=2
    *   ForeColor=0,128,0
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarTextosGrdCab
        WITH THIS.grd_4c_Cab
            *-- Propriedades comuns a todos os Text1 das colunas
            .SetAll("BorderStyle",   0,                  "Text")
            .SetAll("Margin",        0,                  "Text")
            .SetAll("ForeColor",     RGB(0,0,0),         "Text")
            .SetAll("BackColor",     RGB(255,255,255),   "Text")

            *-- HighlightColors canonicos do grid
            .HighlightBackColor = RGB(255,255,255)
            .HighlightForeColor = RGB(15,41,104)
            .HighlightStyle     = 2

            *-- Coluna 6 (Confirmacao): Text1 verde+bold - SetAll sobrescreveu, restaurar aqui
            WITH .Column6
                .FontBold  = .T.
                .Alignment = 2
                .ForeColor = RGB(0,128,0)
            ENDWITH
            WITH .Column6.Text1
                .ForeColor = RGB(0,128,0)
                .FontBold  = .T.
                .Alignment = 2
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarTextosGrdIte - Propriedades Text1 de GrdIte + HighlightColors
    *   Original SCX: Text1.BorderStyle=0, Margin=0, ForeColor=0,0,0
    *   BackColor=255,255,255 em todos
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarTextosGrdIte
        WITH THIS.grd_4c_Ite
            *-- Propriedades comuns a todos os Text1 das colunas
            .SetAll("BorderStyle",   0,                  "Text")
            .SetAll("Margin",        0,                  "Text")
            .SetAll("ForeColor",     RGB(0,0,0),         "Text")
            .SetAll("BackColor",     RGB(255,255,255),   "Text")

            *-- HighlightColors canonicos do grid
            .HighlightBackColor = RGB(255,255,255)
            .HighlightForeColor = RGB(15,41,104)
            .HighlightStyle     = 2
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis
    *   Para este form OPERACIONAL nao ha containers que devem comecar ocultos.
    *   LOOP nao e usado para nenhum container (todos devem ficar visiveis).
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        IF PCOUNT() = 0
            par_oContainer = THIS
        ENDIF

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) # "O"
                LOOP
            ENDIF

            IF PEMSTATUS(loc_oControl, "Visible", 5)
                loc_oControl.Visible = .T.
            ENDIF

            *-- Recursar em containers e pageframes
            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
               loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * CarregarDados - Inicializa posicionamento de cursores e refresh das grades
    *   Equivalente ao bloco de navegacao de cursores do Init() original:
    *   GO TOP em csCabec, SET KEY TO csCabec.EmpDopNums em csItens, GO TOP.
    *==========================================================================
    PROCEDURE CarregarDados
        IF USED("csCabec")
            SELECT csCabec
            GO TOP
        ENDIF

        IF USED("csItens") AND USED("csCabec") AND !EOF("csCabec")
            SELECT csItens
            SET KEY TO csCabec.EmpDopNums
            GO TOP
            SELECT csCabec
        ENDIF

        IF VARTYPE(THIS.grd_4c_Cab) = "O"
            THIS.grd_4c_Cab.Refresh()
        ENDIF

        IF VARTYPE(THIS.grd_4c_Ite) = "O"
            THIS.grd_4c_Ite.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * ProcessaPeriodo - Stub para nao gerar erro em chamadas do SigMvCab
    *   Original SIGPRGST: "Rotina Criada Apenas Para Nao Gerar Erro Nas
    *   Chamadas do SigMvCab." ? SigMvCab pode chamar ThisForm.ParentForm.ProcessaPeriodo
    *==========================================================================
    PROCEDURE ProcessaPeriodo(par_P1, par_P2, par_P3)
        RETURN .T.
    ENDPROC

    *==========================================================================
    * GrdCabAfterRowColChange - Atualiza GrdIte ao mudar linha no GrdCab
    *   Original: seleciona csItens com SET KEY TO csCabec.EmpDopNums + Refresh
    *==========================================================================
    PROCEDURE GrdCabAfterRowColChange(par_nColIndex)
        IF USED("csItens") AND USED("csCabec") AND !EOF("csCabec")
            SELECT csItens
            SET KEY TO csCabec.EmpDopNums
            GO TOP
            THIS.grd_4c_Ite.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - Verifica selecao e chama GerarPedido no BO
    *   Original: CmdGrava.Click - valida EOF, chama GerarPedido, abre SigMvCab
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF !USED("csCabec") OR EOF("csCabec")
                MsgAviso("Selecione um pedido na grade e tente novamente.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_lResultado = THIS.this_oBusinessObject.GerarPedido()
                IF loc_lResultado AND !EMPTY(ALLTRIM(csCabec.Gerado))
                    DO FORM SigMvCab WITH ;
                        csCabec.GerDopes, csCabec.GerNumes, csCabec.GerEmps, ;
                        .T., 3, THIS, .F., .T.
                ENDIF
                THIS.grd_4c_Cab.Refresh()
                THIS.grd_4c_Ite.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro Confirmar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Verifica pedidos nao confirmados antes de fechar
    *   Original: CmdCancela.Click - conta registros com Gerado vazio, confirma
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_lResultado, loc_nFal, loc_oErro
        loc_lResultado = .F.

        TRY
            *-- Verificar pedidos nao gerados
            IF USED("csCabec")
                SELECT Emps, Dopes, Numes ;
                    FROM csCabec ;
                    WHERE EMPTY(Gerado) ;
                    INTO CURSOR cursor_4c_NaoGerados
                loc_nFal = RECCOUNT("cursor_4c_NaoGerados")
                USE IN cursor_4c_NaoGerados
            ELSE
                loc_nFal = 0
            ENDIF

            IF loc_nFal > 0
                IF !MsgConfirma("Existem " + ALLTRIM(STR(loc_nFal, 10)) + ;
                    " Opera" + CHR(231) + CHR(245) + "es N" + CHR(227) + "o Confirmadas!" + ;
                    CHR(13) + "Tem Certeza Que N" + CHR(227) + "o Deseja Gerar Esses Pedidos?", ;
                    "Aten" + CHR(231) + CHR(227) + "o!!!")
                    loc_lResultado = .F.
                ELSE
                    *-- Log de cancelamento
                    IF USED("CrSigCdNec") AND !EOF("CrSigCdNec") AND ;
                       TYPE("CrSigCdNec.Dopps") != "U"
                        =fGravarLog("T", ALLTRIM(CrSigCdNec.Dopps), "AUTOMATICO", ;
                            "A Gera" + CHR(231) + CHR(227) + "o de " + ;
                            ALLTRIM(STR(loc_nFal, 10)) + ;
                            " Opera" + CHR(231) + CHR(227) + "o Foi Cancelada Sem Confirma" + ;
                            CHR(231) + CHR(227) + "o")
                    ENDIF
                    THIS.Release()
                ENDIF
            ELSE
                THIS.Release()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro Encerrar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBINDEVENTs - Vincular eventos de botoes (chamado em Fase 7/8)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs
        BINDEVENT(THIS.cmd_4c_Confirmar,  "Click",              THIS, "BtnConfirmarClick")
        BINDEVENT(THIS.cmd_4c_Encerrar,   "Click",              THIS, "BtnEncerrarClick")
        BINDEVENT(THIS.grd_4c_Cab, "AfterRowColChange", THIS, "GrdCabAfterRowColChange")
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Alias CRUD para OPERACIONAL: incluir = gerar novo
    *   pedido de movimentacao a partir da linha selecionada no GrdCab.
    *   Delega para BtnConfirmarClick (mesma logica do CmdGrava original).
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.BtnConfirmarClick()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Alias CRUD para OPERACIONAL: alterar = re-confirmar
    *   a geracao do pedido da linha selecionada. Delega para BtnConfirmarClick.
    *   O legado nao tem "alterar" separado; GerarPedido no BO ja checa
    *   csCabec.Gerado e reprocessa somente pedidos ainda nao gerados.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        THIS.BtnConfirmarClick()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Alias CRUD para OPERACIONAL: visualizar = re-sincronizar
    *   cursores csCabec/csItens (SET KEY TO csCabec.EmpDopNums + GO TOP) e
    *   forcar refresh das grades. Nao abre nenhum picker adicional; o proprio
    *   layout do form (grid superior + grid inferior) ja e a visualizacao.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Alias CRUD para OPERACIONAL: delega para BtnEncerrarClick
    *   que verifica operacoes nao confirmadas (Gerado vazio) e solicita
    *   MsgConfirma antes de fechar (comportamento do CmdCancela original).
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *==========================================================================
    * CarregarLista - Alias de compatibilidade com pipeline CRUD
    *   Para OPERACIONAL: equivale a sincronizar e atualizar as grades.
    *==========================================================================
    PROCEDURE CarregarLista
        THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    * FormParaBO - Popula BO com dados do registro corrente de csCabec
    *   Para OPERACIONAL sem campos editaveis no form, transfere o contexto
    *   do cursor para o BO (usado por auditoria e geracao de pedido).
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO
        IF USED("csCabec") AND !EOF("csCabec")
            THIS.this_oBusinessObject.CarregarDoCursor("csCabec")
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Atualiza grades a partir do estado atual do BO/cursores
    *   Para OPERACIONAL: forca refresh das grades sem reposicionar cursores.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm
        IF VARTYPE(THIS.grd_4c_Cab) = "O"
            THIS.grd_4c_Cab.Refresh()
        ENDIF
        IF VARTYPE(THIS.grd_4c_Ite) = "O"
            THIS.grd_4c_Ite.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Para OPERACIONAL: grades sao sempre ReadOnly
    *   Mantido para compatibilidade com pipeline; nao ha controles editaveis.
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        IF VARTYPE(THIS.grd_4c_Cab) = "O"
            THIS.grd_4c_Cab.ReadOnly = .T.
        ENDIF
        IF VARTYPE(THIS.grd_4c_Ite) = "O"
            THIS.grd_4c_Ite.ReadOnly = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Para OPERACIONAL: forca refresh das grades
    *   Nao ha campos de entrada para limpar; apenas atualiza visualizacao.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos
        IF VARTYPE(THIS.grd_4c_Cab) = "O"
            THIS.grd_4c_Cab.Refresh()
        ENDIF
        IF VARTYPE(THIS.grd_4c_Ite) = "O"
            THIS.grd_4c_Ite.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Para OPERACIONAL: habilita Confirmar e Encerrar.
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo
        IF VARTYPE(THIS.cmd_4c_Confirmar) = "O"
            THIS.cmd_4c_Confirmar.Enabled = .T.
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Encerrar) = "O"
            THIS.cmd_4c_Encerrar.Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Alias CRUD para OPERACIONAL: buscar = sincronizar grades
    *   Reposiciona cursores e forca refresh das duas grades.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Alias CRUD para OPERACIONAL: salvar = confirmar geracao
    *   Delega para BtnConfirmarClick (mesma logica do CmdGrava original).
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnConfirmarClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Alias CRUD para OPERACIONAL: cancelar = encerrar
    *   Delega para BtnEncerrarClick com checagem de pedidos nao confirmados.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy
    *==========================================================================
        THIS.this_oFormPai = .NULL.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
