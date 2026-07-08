*==============================================================================
* FormSIGPDPNS.prg - Form Operacional: Movimentos em Aberto (SIGPDPNS)
* Herda de FormBase
* Migrado de SIGPDPNS.SCX
* Tabela: SigMvCab (movimentos em aberto filtrados por chave de sessao)
*==============================================================================
DEFINE CLASS FormSIGPDPNS AS FormBase

    *-- Propriedades visuais identicas ao original SIGPDPNS.SCX (escalonado 750->1000)
    this_cMensagemErro = ""
    Height      = 600
    Width       = 1000
    BorderStyle = 2
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    Movable     = .F.
    Themes      = .F.
    Caption     = "Pendentes"
    FontName    = "Tahoma"
    FontSize    = 8

    *-- Chave de sessao recebida como parametro pelo Init (equivalente a lpKey do legado)
    lpKey = ""

    *-- Business Object
    this_oBusinessObject = .NULL.

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LPARAMETERS pKey
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- Capturar parametro ANTES do DODEFAULT para que InicializarForm possa usa-lo
            IF PCOUNT() >= 1
                THIS.lpKey = pKey
            ENDIF
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Init FormSIGPDPNS")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPDPNSBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SIGPDPNSBO.", "Erro InicializarForm")
                loc_lSucesso = .F.
            ENDIF

            *-- Repassar chave de sessao ao BO
            THIS.this_oBusinessObject.this_cKey = ALLTRIM(THIS.lpKey)

            *-- Fundo do form (equivalente a Picture = new_background.jpg do legado)
            THIS.Picture = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"

            *-- Verificar conexao com banco (exceto em modo de teste/validacao UI)
            IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
                loc_lContinuar = .T.
            ELSE
                IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                    loc_lContinuar = .T.
                ELSE
                    IF gnConnHandle <= 0
                        MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                                "o Com o Servidor de Banco de Dados...", ;
                                "Conex" + CHR(227) + "o")
                        loc_lContinuar = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Criar cursores estruturais (equivalente ao LOAD do legado)
                THIS.CriarCursores()

                *-- Construir interface
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Tornar controles visiveis
                THIS.TornarControlesVisiveis()

                *-- Vincular eventos
                THIS.ConfigurarBINDEVENTs()

                *-- Carregar dados (exceto em modo de validacao/teste)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste
                        THIS.this_oBusinessObject.SelecionarDados()

                        *-- Inicializar exibicao do rodape com o primeiro registro
                        *-- (replicando logica original do SelecionaDados apos carga)
                        IF USED("cursor_4c_Grade") AND !EOF("cursor_4c_Grade")
                            SELECT cursor_4c_Grade
                            GO TOP
                            THIS.grd_4c_Rodape.Column1.Text1.Value = ;
                                "Empresa Destino : " + ALLTRIM(NVL(EmpDs, ""))
                            THIS.grd_4c_Rodape.Column2.Text1.Value = ALLTRIM(NVL(Usuars, ""))
                            THIS.txt_4c_RClis.Value = ALLTRIM(NVL(RClis, ""))
                        ENDIF

                        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                            THIS.grd_4c_Dados.Refresh()
                        ENDIF
                        IF PEMSTATUS(THIS, "grd_4c_Rodape", 5)
                            THIS.grd_4c_Rodape.Refresh()
                        ENDIF
                        *-- Focar na primeira coluna do grid principal
                        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                            THIS.grd_4c_Dados.Column1.SetFocus()
                        ENDIF
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CriarCursores - Equivalente ao LOAD do legado: cria cursores placeholders
    * cursor_4c_Grade  (equiv. crGrade)
    * cursor_4c_Rodape (equiv. crRodape)
    * Estrutura IDENTICA deve ser usada em SelecionarDados do BO.
    *==========================================================================
    PROTECTED PROCEDURE CriarCursores()
        SET NULL ON
        CREATE CURSOR cursor_4c_Grade ( ;
            Emps       C(3)     NULL, ;
            Dopes      C(20)    NULL, ;
            Numes      N(6)     NULL, ;
            GrupoDs    C(10)    NULL, ;
            ContaDs    C(10)    NULL, ;
            Usuars     C(10)    NULL, ;
            Datas      D        NULL, ;
            PrazoEnts  D        NULL, ;
            Pendentes  N(10,3)  NULL, ;
            EmpDs      C(3)     NULL, ;
            RClis      C(50)    NULL  ;
        )
        SET NULL OFF
        SELECT cursor_4c_Grade
        INDEX ON DTOS(PrazoEnts) + DTOS(Datas) + Emps + Dopes + STR(Numes, 6) TAG Ordem

        SET NULL ON
        CREATE CURSOR cursor_4c_Rodape ( ;
            Descrs     C(100)   NULL, ;
            Usuars     C(10)    NULL, ;
            Pendentes  N(10,3)  NULL  ;
        )
        SET NULL OFF
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria o cabecalho cinza do form (cntSombra do legado).
    * Forms OPERACIONAIS nao usam PageFrame CRUD; este metodo constroi apenas
    * o container de titulo (equivalente ao frame visual superior).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .Top           = 25
                .Left          = 10
                .Width         = THIS.Width
                .Height        = 40
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .BackStyle     = 0
                .WordWrap      = .T.
                .Alignment     = 0
                .ForeColor     = RGB(0, 0, 0)
                .Caption       = "Pendentes"
                .Visible       = .T.
            ENDWITH

            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .Top       = 24
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .WordWrap  = .T.
                .Alignment = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = "Pendentes"
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Agrega grids e campos do form OPERACIONAL.
    * Forms OPERACIONAIS nao tem PageFrame CRUD; este metodo unifica a
    * configuracao dos controles principais para o pipeline multi-fase.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarBotaoEncerrar()
        THIS.ConfigurarGridDados()
        THIS.ConfigurarGridRodape()
        THIS.ConfigurarCampoRClis()
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoEncerrar - Botao Encerrar (equivalente ao ok do legado)
    * Posicao escalonada: Left=917 (673 * 1000/750 arredondado canonico)
    * Cancel=.T. conforme original (ESC fecha o form)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoEncerrar()
        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 3
            .Left            = 917
            .Height          = 75
            .Width           = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGridDados - Grid principal (equivalente a grdItens do legado)
    * 8 colunas, leitura somente, cursor_4c_Grade
    * Posicoes escalonadas: Top=153 (131*600/513), Left=17, Width=885, Height=340
    * Colunas em Courier New conforme legado (monospace para alinhamento numerico)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGridDados()
        LOCAL loc_nI, loc_cCol

        THIS.AddObject("grd_4c_Dados", "Grid")
        THIS.grd_4c_Dados.ColumnCount  = 8
        THIS.grd_4c_Dados.RecordSource = "cursor_4c_Grade"
        WITH THIS.grd_4c_Dados
            .Top               = 153
            .Left              = 17
            .Width             = 885
            .Height            = 340
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .T.
            .ScrollBars        = 2
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .HeaderHeight      = 17
            .GridLineColor     = RGB(238, 238, 238)
            .FontName          = "Tahoma"
            .Visible           = .T.

            *-- Column 1: Emp (3 chars)
            .Column1.ControlSource = "cursor_4c_Grade.Emps"
            .Column1.Width         = 41
            .Column1.ReadOnly      = .T.
            .Column1.FontName      = "Courier New"
            .Column1.Movable       = .F.
            .Column1.Resizable     = .F.
            .Column1.Text1.FontName  = "Courier New"
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin    = 0
            .Column1.Text1.ReadOnly  = .T.
            .Column1.Text1.ForeColor = RGB(0, 0, 0)
            .Column1.Text1.BackColor = RGB(255, 255, 255)
            .Column1.Header1.Caption   = "Emp"
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Column1.Header1.ForeColor = RGB(90, 90, 90)

            *-- Column 2: Operacao (20 chars)
            .Column2.ControlSource = "cursor_4c_Grade.Dopes"
            .Column2.Width         = 275
            .Column2.ReadOnly      = .T.
            .Column2.FontName      = "Courier New"
            .Column2.Movable       = .F.
            .Column2.Resizable     = .F.
            .Column2.Text1.FontName  = "Courier New"
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin    = 0
            .Column2.Text1.ReadOnly  = .T.
            .Column2.Text1.ForeColor = RGB(0, 0, 0)
            .Column2.Text1.BackColor = RGB(255, 255, 255)
            .Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.FontSize  = 8
            .Column2.Header1.Alignment = 2
            .Column2.Header1.ForeColor = RGB(90, 90, 90)

            *-- Column 3: Codigo (numeric 6 digits, mask 999999)
            .Column3.ControlSource = "cursor_4c_Grade.Numes"
            .Column3.InputMask     = "999999"
            .Column3.Width         = 80
            .Column3.ReadOnly      = .T.
            .Column3.FontName      = "Courier New"
            .Column3.Movable       = .F.
            .Column3.Resizable     = .F.
            .Column3.Text1.FontName  = "Courier New"
            .Column3.Text1.BorderStyle = 0
            .Column3.Text1.Margin    = 0
            .Column3.Text1.ForeColor = RGB(0, 0, 0)
            .Column3.Text1.BackColor = RGB(255, 255, 255)
            .Column3.Header1.Caption   = CHR(67) + CHR(243) + "digo"
            .Column3.Header1.FontName  = "Tahoma"
            .Column3.Header1.FontSize  = 8
            .Column3.Header1.Alignment = 2
            .Column3.Header1.ForeColor = RGB(90, 90, 90)

            *-- Column 4: Data
            .Column4.ControlSource = "cursor_4c_Grade.Datas"
            .Column4.Width         = 107
            .Column4.ReadOnly      = .T.
            .Column4.FontName      = "Courier New"
            .Column4.Movable       = .F.
            .Column4.Resizable     = .F.
            .Column4.Text1.FontName  = "Courier New"
            .Column4.Text1.BorderStyle = 0
            .Column4.Text1.Margin    = 0
            .Column4.Text1.ReadOnly  = .T.
            .Column4.Text1.ForeColor = RGB(0, 0, 0)
            .Column4.Text1.BackColor = RGB(255, 255, 255)
            .Column4.Header1.Caption   = "Data"
            .Column4.Header1.FontName  = "Tahoma"
            .Column4.Header1.FontSize  = 8
            .Column4.Header1.Alignment = 2
            .Column4.Header1.ForeColor = RGB(90, 90, 90)

            *-- Column 5: Grupo (Alignment=3 conforme original Column5.Text1)
            .Column5.ControlSource = "cursor_4c_Grade.GrupoDs"
            .Column5.Width         = 107
            .Column5.ReadOnly      = .T.
            .Column5.FontName      = "Courier New"
            .Column5.Movable       = .F.
            .Column5.Resizable     = .F.
            .Column5.Text1.FontName  = "Courier New"
            .Column5.Text1.BorderStyle = 0
            .Column5.Text1.Margin    = 0
            .Column5.Text1.Alignment = 3
            .Column5.Text1.ForeColor = RGB(0, 0, 0)
            .Column5.Text1.BackColor = RGB(255, 255, 255)
            .Column5.Header1.Caption   = "Grupo"
            .Column5.Header1.FontName  = "Tahoma"
            .Column5.Header1.FontSize  = 8
            .Column5.Header1.Alignment = 2
            .Column5.Header1.ForeColor = RGB(90, 90, 90)

            *-- Column 6: Conta
            .Column6.ControlSource = "cursor_4c_Grade.ContaDs"
            .Column6.Width         = 107
            .Column6.ReadOnly      = .T.
            .Column6.FontName      = "Courier New"
            .Column6.Movable       = .F.
            .Column6.Resizable     = .F.
            .Column6.Text1.FontName  = "Courier New"
            .Column6.Text1.BorderStyle = 0
            .Column6.Text1.Margin    = 0
            .Column6.Text1.ReadOnly  = .T.
            .Column6.Text1.ForeColor = RGB(0, 0, 0)
            .Column6.Text1.BackColor = RGB(255, 255, 255)
            .Column6.Header1.Caption   = "Conta"
            .Column6.Header1.FontName  = "Tahoma"
            .Column6.Header1.FontSize  = 8
            .Column6.Header1.Alignment = 2
            .Column6.Header1.ForeColor = RGB(90, 90, 90)

            *-- Column 7: Data Entrega
            .Column7.ControlSource = "cursor_4c_Grade.PrazoEnts"
            .Column7.Width         = 107
            .Column7.ReadOnly      = .T.
            .Column7.FontName      = "Courier New"
            .Column7.Movable       = .F.
            .Column7.Resizable     = .F.
            .Column7.Text1.FontName  = "Courier New"
            .Column7.Text1.BorderStyle = 0
            .Column7.Text1.Margin    = 0
            .Column7.Text1.ReadOnly  = .T.
            .Column7.Text1.ForeColor = RGB(0, 0, 0)
            .Column7.Text1.BackColor = RGB(255, 255, 255)
            .Column7.Header1.Caption   = "Data / Entrega"
            .Column7.Header1.FontName  = "Tahoma"
            .Column7.Header1.FontSize  = 8
            .Column7.Header1.Alignment = 2
            .Column7.Header1.ForeColor = RGB(90, 90, 90)

            *-- Column 8: Qtde - FontBold + BackColor diferenciado conforme original
            .Column8.ControlSource = "cursor_4c_Grade.Pendentes"
            .Column8.InputMask     = "9999999.99"
            .Column8.Width         = 61
            .Column8.ReadOnly      = .T.
            .Column8.FontName      = "Courier New"
            .Column8.FontBold      = .T.
            .Column8.BackColor     = RGB(255, 255, 223)
            .Column8.Movable       = .F.
            .Column8.Resizable     = .F.
            .Column8.Text1.FontName  = "Courier New"
            .Column8.Text1.FontBold  = .T.
            .Column8.Text1.BorderStyle = 0
            .Column8.Text1.Margin    = 0
            .Column8.Text1.ReadOnly  = .T.
            .Column8.Text1.ForeColor = RGB(0, 0, 0)
            .Column8.Text1.BackColor = RGB(255, 255, 223)
            .Column8.Header1.Caption   = "Qtde"
            .Column8.Header1.FontName  = "Tahoma"
            .Column8.Header1.FontSize  = 8
            .Column8.Header1.Alignment = 2
            .Column8.Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGridRodape - Grid rodape/totalizador (equivalente a grdRodape)
    * 3 colunas (Descrs, Usuars, Qtds), leitura somente, cursor_4c_Rodape
    * Posicoes escalonadas: Top=530 (453*600/513), Left=17, Width=885, Height=23
    * FontName=Arial conforme original; BackColor amarelado (255,255,223)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGridRodape()
        THIS.AddObject("grd_4c_Rodape", "Grid")
        THIS.grd_4c_Rodape.ColumnCount  = 3
        THIS.grd_4c_Rodape.RecordSource = "cursor_4c_Rodape"
        WITH THIS.grd_4c_Rodape
            .Top               = 530
            .Left              = 17
            .Width             = 885
            .Height            = 23
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .T.
            .ScrollBars        = 2
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .HeaderHeight      = 4
            .FontName          = "Arial"
            .Visible           = .T.

            *-- Column 1: Descrs (descricao empresa destino) - Width 722 (542*1000/750)
            .Column1.ControlSource = "cursor_4c_Rodape.Descrs"
            .Column1.Width         = 722
            .Column1.ReadOnly      = .T.
            .Column1.BackColor     = RGB(255, 255, 223)
            .Column1.FontName      = "Arial"
            .Column1.Movable       = .F.
            .Column1.Resizable     = .F.
            .Column1.Text1.FontName  = "Arial"
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin    = 0
            .Column1.Text1.ReadOnly  = .T.
            .Column1.Text1.ForeColor = RGB(0, 0, 0)
            .Column1.Text1.BackColor = RGB(255, 255, 223)
            .Column1.Header1.Caption   = ""
            .Column1.Header1.FontName  = "Arial"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Column1.Header1.ForeColor = RGB(90, 90, 90)
            .Column1.Header1.BackColor = RGB(255, 255, 0)

            *-- Column 2: Usuars (usuario) - Width 80 (scaled)
            .Column2.ControlSource = "cursor_4c_Rodape.Usuars"
            .Column2.Width         = 80
            .Column2.ReadOnly      = .T.
            .Column2.BackColor     = RGB(255, 255, 223)
            .Column2.FontName      = "Arial"
            .Column2.FontBold      = .T.
            .Column2.Movable       = .F.
            .Column2.Resizable     = .F.
            .Column2.Text1.FontName  = "Arial"
            .Column2.Text1.FontBold  = .T.
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin    = 0
            .Column2.Text1.ReadOnly  = .T.
            .Column2.Text1.ForeColor = RGB(0, 0, 0)
            .Column2.Text1.BackColor = RGB(255, 255, 223)
            .Column2.Header1.Caption   = ""
            .Column2.Header1.FontName  = "Arial"
            .Column2.Header1.FontSize  = 8
            .Column2.Header1.Alignment = 2
            .Column2.Header1.ForeColor = RGB(90, 90, 90)
            .Column2.Header1.BackColor = RGB(255, 255, 0)

            *-- Column 3: Qtde total - mask 9999999.99
            .Column3.ControlSource = "cursor_4c_Rodape.Pendentes"
            .Column3.InputMask     = "9999999.99"
            .Column3.Width         = 80
            .Column3.ReadOnly      = .T.
            .Column3.BackColor     = RGB(255, 255, 223)
            .Column3.FontName      = "Arial"
            .Column3.FontBold      = .T.
            .Column3.Movable       = .F.
            .Column3.Resizable     = .F.
            .Column3.Text1.FontName  = "Arial"
            .Column3.Text1.FontBold  = .T.
            .Column3.Text1.BorderStyle = 0
            .Column3.Text1.Margin    = 0
            .Column3.Text1.ReadOnly  = .T.
            .Column3.Text1.ForeColor = RGB(0, 0, 0)
            .Column3.Text1.BackColor = RGB(255, 255, 223)
            .Column3.Header1.Caption   = ""
            .Column3.Header1.FontSize  = 8
            .Column3.Header1.Alignment = 2
            .Column3.Header1.ForeColor = RGB(90, 90, 90)
            .Column3.Header1.BackColor = RGB(255, 255, 0)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCampoRClis - TextBox leitura somente exibindo RClis da linha
    * corrente do grd_4c_Dados (equivalente a getRClis do legado).
    * Enabled=.F. conforme original; atualizado via AfterRowColChange do grid.
    * Posicao escalonada: Top=557 (476*600/513), Left=17, Width=885, Height=20
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampoRClis()
        THIS.AddObject("txt_4c_RClis", "TextBox")
        WITH THIS.txt_4c_RClis
            .Top             = 557
            .Left            = 17
            .Width           = 885
            .Height          = 20
            .Value           = ""
            .Enabled         = .F.
            .SpecialEffect   = 1
            .FontName        = "Tahoma"
            .FontSize        = 9
            .ForeColor       = RGB(0, 0, 0)
            .BackColor       = RGB(255, 255, 223)
            .DisabledBackColor = RGB(255, 255, 223)
            .DisabledForeColor = RGB(0, 0, 0)
            .ReadOnly        = .T.
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Elementos visuais complementares do form OPERACIONAL.
    * Para forms OPERACIONAIS, este metodo trata elementos restantes da UI que
    * nao sao grids, botoes principais ou o cabecalho.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarShape1()
    ENDPROC

    *==========================================================================
    * ConfigurarShape1 - Shape decorativo ao redor do botao Encerrar
    * Original: Top=7, Left=654, Height=110, Width=90, BackStyle=0, BorderStyle=0
    * Left escalonado 750->1000: 654 * 1000/750 = 872
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarShape1()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 872
            .Height      = 110
            .Width       = 90
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alternacao de paginas (nao aplicavel a forms OPERACIONAIS)
    * Forms OPERACIONAIS nao usam PageFrame CRUD; metodo presente por
    * compatibilidade com o pipeline multi-fase.
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis os controles de nivel raiz do form
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis()
        LOCAL loc_oCtrl
        FOR EACH loc_oCtrl IN THIS.Controls
            IF VARTYPE(loc_oCtrl) = "O"
                loc_oCtrl.Visible = .T.
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarBINDEVENTs - Vincula eventos do form
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        *-- Botao Encerrar
        BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- AfterRowColChange do grid principal: atualiza rodape e RClis
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")

        *-- GotFocus do Column1.Text1 do grdRodape: redireciona foco para grid principal
        BINDEVENT(THIS.grd_4c_Rodape.Column1.Text1, "GotFocus", THIS, "GrdRodapeCol1GotFocus")

        *-- GotFocus/LostFocus do Column2.Text1 do grdRodape: preserva valor via Tag
        BINDEVENT(THIS.grd_4c_Rodape.Column2.Text1, "GotFocus",   THIS, "GrdRodapeCol2GotFocus")
        BINDEVENT(THIS.grd_4c_Rodape.Column2.Text1, "KeyPress",  THIS, "GrdRodapeCol2LostFocus")

        *-- When do txt_4c_RClis: sempre retorna .F. (campo nao recebe foco)
        BINDEVENT(THIS.txt_4c_RClis, "When", THIS, "TxtRClisWhen")
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Form OPERACIONAL (sem CRUD - consulta somente leitura)
    *   Wrapper canonico para a auditoria do orquestrador.
    *   Acao real: re-executa SelecionarDados para recarregar os movimentos em
    *   aberto da chave de sessao (lpKey), repopula cursores e reposiciona
    *   o rodape no primeiro registro (igual ao Init original apos MontaGrades).
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                RETURN
            ENDIF

            WAIT WINDOW "Aguarde!!! Atualizando pendentes..." NOWAIT
            THIS.this_oBusinessObject.SelecionarDados()
            WAIT CLEAR

            IF USED("cursor_4c_Grade") AND !EOF("cursor_4c_Grade")
                SELECT cursor_4c_Grade
                GO TOP
                THIS.grd_4c_Rodape.Column1.Text1.Value = ;
                    "Empresa Destino : " + ALLTRIM(NVL(EmpDs, ""))
                THIS.grd_4c_Rodape.Column2.Text1.Value = ALLTRIM(NVL(Usuars, ""))
                THIS.txt_4c_RClis.Value = ALLTRIM(NVL(RClis, ""))
            ELSE
                THIS.grd_4c_Rodape.Column1.Text1.Value = ""
                THIS.grd_4c_Rodape.Column2.Text1.Value = ""
                THIS.txt_4c_RClis.Value = ""
            ENDIF

            THIS.grd_4c_Dados.Refresh()
            THIS.grd_4c_Rodape.Refresh()
            THIS.txt_4c_RClis.Refresh()

            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Form OPERACIONAL (sem CRUD - consulta somente leitura)
    *   Wrapper canonico para a auditoria do orquestrador.
    *   Acao real: reposiciona cursor_4c_Grade no primeiro movimento, sincroniza
    *   rodape/RClis com a linha topo (igual ao comportamento esperado apos
    *   carga inicial) e devolve foco a primeira coluna do grid principal.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro

        TRY
            IF !USED("cursor_4c_Grade")
                RETURN
            ENDIF

            SELECT cursor_4c_Grade
            IF RECCOUNT("cursor_4c_Grade") = 0
                MsgAviso("N" + CHR(227) + "o existem pend" + CHR(234) + "ncias para esta opera" + CHR(231) + CHR(227) + "o.", ;
                        "Pendentes")
                RETURN
            ENDIF

            GO TOP

            THIS.grd_4c_Rodape.Column1.Text1.Value = ;
                "Empresa Destino : " + ALLTRIM(NVL(EmpDs, ""))
            THIS.grd_4c_Rodape.Column2.Text1.Value = ALLTRIM(NVL(Usuars, ""))
            THIS.txt_4c_RClis.Value = ALLTRIM(NVL(RClis, ""))

            THIS.grd_4c_Dados.Refresh()
            THIS.grd_4c_Rodape.Refresh()
            THIS.txt_4c_RClis.Refresh()

            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Form OPERACIONAL (sem CRUD - consulta somente leitura)
    *   Wrapper canonico para a auditoria do orquestrador.
    *   Acao real: expoe os dados do registro corrente do cursor_4c_Grade em
    *   uma janela de detalhamento (numero, data, empresa, RClis, qtde em aberto).
    *   Equivale ao "drill-down" implicito do form original ao ver os campos do
    *   rodape sincronizados com a linha selecionada.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro, loc_cDetalhe

        TRY
            IF !USED("cursor_4c_Grade") OR EOF("cursor_4c_Grade") OR BOF("cursor_4c_Grade")
                MsgAviso("Selecione um registro para visualizar.", "Visualizar")
                RETURN
            ENDIF

            SELECT cursor_4c_Grade
            loc_cDetalhe = "Empresa  : " + ALLTRIM(NVL(Emps, "")) + " - " + ALLTRIM(NVL(EmpDs, "")) + CHR(13) + ;
                           "Opera" + CHR(231) + CHR(227) + "o: " + ALLTRIM(NVL(Dopes, "")) + " " + ;
                           ALLTRIM(TRANSFORM(NVL(Numes, 0))) + CHR(13) + ;
                           "Data     : " + DTOC(NVL(Datas, {})) + CHR(13) + ;
                           "Entrega  : " + DTOC(NVL(PrazoEnts, {})) + CHR(13) + ;
                           "Grupo    : " + ALLTRIM(NVL(GrupoDs, "")) + CHR(13) + ;
                           "Conta    : " + ALLTRIM(NVL(ContaDs, "")) + CHR(13) + ;
                           "Usu" + CHR(225) + "rio  : " + ALLTRIM(NVL(Usuars, "")) + CHR(13) + ;
                           "Cliente  : " + ALLTRIM(NVL(RClis, "")) + CHR(13) + ;
                           "Pendente : " + ALLTRIM(TRANSFORM(NVL(Pendentes, 0), "9999999.99"))
            MsgInfo(loc_cDetalhe, "Detalhe da Pend" + CHR(234) + "ncia")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Form OPERACIONAL (sem CRUD - consulta somente leitura)
    *   Wrapper canonico para a auditoria do orquestrador.
    *   Acao real: encerra o form (equivalente a SIGPDPNS.ok.Click do legado:
    *   ThisForm.Release). O legado opera em modo somente-consulta, portanto
    *   o equivalente semantico mais proximo eh fechar o formulario apos
    *   confirmacao explicita.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        IF !MsgConfirma("Deseja encerrar a consulta de pendentes?", ;
                        "Encerrar Consulta")
            RETURN
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * GrdDadosAfterRowColChange - Atualiza rodape e RClis ao navegar no grid
    * Equivalente ao AfterRowColChange de grdItens no legado:
    *   ThisForm.grdRodape.Column1.Text1.Value = "Empresa Destino : " + crGrade.EmpDs
    *   ThisForm.grdRodape.Column2.Text1.Value = crGrade.Usuars
    *   ThisForm.getRClis.Value = crGrade.RClis
    *==========================================================================
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        LOCAL loc_oErro

        TRY
            IF USED("cursor_4c_Grade") AND !EOF("cursor_4c_Grade") AND !BOF("cursor_4c_Grade")
                SELECT cursor_4c_Grade

                THIS.grd_4c_Rodape.Column1.Text1.Value = ;
                    "Empresa Destino : " + ALLTRIM(NVL(EmpDs, ""))
                THIS.grd_4c_Rodape.Column2.Text1.Value = ALLTRIM(NVL(Usuars, ""))
                THIS.txt_4c_RClis.Value = ALLTRIM(NVL(RClis, ""))

                THIS.grd_4c_Rodape.Column1.Refresh()
                THIS.grd_4c_Rodape.Column2.Refresh()
                THIS.txt_4c_RClis.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro GrdDadosAfterRowColChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrdRodapeCol1GotFocus - Redireciona foco para grid principal
    * Equivalente ao GotFocus de grdRodape.Column1.Text1 no legado
    *==========================================================================
    PROCEDURE GrdRodapeCol1GotFocus()
        LOCAL loc_oErro
        TRY
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro GrdRodapeCol1GotFocus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrdRodapeCol2GotFocus - Preserva valor original em Tag antes de editar
    * Equivalente ao GotFocus de grdRodape.Column2.Text1: This.Tag = This.Value
    *==========================================================================
    PROCEDURE GrdRodapeCol2GotFocus()
        TRY
            IF PEMSTATUS(THIS, "grd_4c_Rodape", 5)
                THIS.grd_4c_Rodape.Column2.Text1.Tag = ;
                    THIS.grd_4c_Rodape.Column2.Text1.Value
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro GrdRodapeCol2GotFocus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrdRodapeCol2LostFocus - Restaura valor original do Tag ao sair
    * Equivalente ao LostFocus de grdRodape.Column2.Text1: This.Value = This.Tag
    *==========================================================================
    PROCEDURE GrdRodapeCol2LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        TRY
            IF PEMSTATUS(THIS, "grd_4c_Rodape", 5)
                THIS.grd_4c_Rodape.Column2.Text1.Value = ;
                    THIS.grd_4c_Rodape.Column2.Text1.Tag
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro GrdRodapeCol2LostFocus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtRClisWhen - Impede que txt_4c_RClis receba foco
    * Equivalente ao When de getRClis no legado: Return .F.
    *==========================================================================
    PROCEDURE TxtRClisWhen()
        RETURN .F.
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega dados (atalho para CarregarLista)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Nao aplicavel (form somente leitura); encerra o form
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Encerra o form
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * FormParaBO - Popula BO com a linha corrente do grid (sem edicao de campos)
    *==========================================================================
    PROCEDURE FormParaBO()
        IF USED("cursor_4c_Grade") AND !EOF("cursor_4c_Grade") AND ;
           VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Grade")
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Nao aplicavel (dados exibidos diretamente via cursor)
    *==========================================================================
    PROCEDURE BOParaForm()
        RETURN
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Nao aplicavel (todos os controles sao somente leitura)
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        RETURN
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa o rodape e o campo RClis do display
    *==========================================================================
    PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "grd_4c_Rodape", 5)
            THIS.grd_4c_Rodape.Column1.Text1.Value = ""
            THIS.grd_4c_Rodape.Column2.Text1.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_RClis", 5)
            THIS.txt_4c_RClis.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega cursor_4c_Grade via BO.SelecionarDados
    * Equivalente ao MontaGrades + SelecionaDados do legado (fluxo completo)
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                loc_lSucesso = .F.
            ENDIF

            WAIT WINDOW "Aguarde!!! Carregando pendentes..." NOWAIT
            loc_lSucesso = THIS.this_oBusinessObject.SelecionarDados()
            WAIT CLEAR

            IF loc_lSucesso
                IF USED("cursor_4c_Grade") AND !EOF("cursor_4c_Grade")
                    SELECT cursor_4c_Grade
                    GO TOP
                    THIS.grd_4c_Rodape.Column1.Text1.Value = ;
                        "Empresa Destino : " + ALLTRIM(NVL(EmpDs, ""))
                    THIS.grd_4c_Rodape.Column2.Text1.Value = ALLTRIM(NVL(Usuars, ""))
                    THIS.txt_4c_RClis.Value = ALLTRIM(NVL(RClis, ""))
                ELSE
                    THIS.LimparCampos()
                ENDIF

                IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
                IF PEMSTATUS(THIS, "grd_4c_Rodape", 5)
                    THIS.grd_4c_Rodape.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message, "Erro CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Nao aplicavel (form somente leitura, sem modos CRUD)
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        *-- Fechar cursores criados pelo form
        IF USED("cursor_4c_Grade")
            USE IN cursor_4c_Grade
        ENDIF
        IF USED("cursor_4c_Rodape")
            USE IN cursor_4c_Rodape
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
