*==============================================================================
* FormSigPrPcp.prg - Priorizacao de Operacoes para Planejamento de Producao
* Tipo: OPERACIONAL - layout flat customizado (sem PageFrame)
* Migrado de: SIGPRPCP.SCX
* Fase 8/8 - COMPLETO: Todos os metodos implementados
*
* OBJETOS MIGRADOS (100%):
*   cnt_4c_Sombra + lbl_4c_Sombra + lbl_4c_Titulo  (cntSombra do legado)
*   grd_4c_Dados  (Grade 6 colunas - grade principal de selecao)
*   grd_4c_Itens  (GradeItem 4 colunas - itens da OP selecionada)
*   cmd_4c_Confirmar (Salva), cmd_4c_Cancelar (Sair)
*   txt_4c_Info (Text1 - identificacao da OP), lbl_4c_Cliente, txt_4c_Cliente
*   lbl_4c_Ordenacao, cbo_4c_Ordenacao (Cmb_Concilia - ordenacao da grade)
*   lbl_4c_TabDica (Label1 - dica TAB)
*   shp_4c_Shape4 + img_4c_FigJpg (foto do produto - Visible=.F. por padrao)
*
* NOTA: Nenhum campo de lookup (F4/F5) - original tem todos os campos
* somente-leitura ou preenchidos programaticamente via AfterRowColChange.
* Os uticos campos editaveis sao Column1 (Priors) da grade principal.
*==============================================================================

DEFINE CLASS FormSigPrPcp AS FormBase

    *-- Propriedades visuais (copiadas exatamente do original SIGPRPCP)
    Height       = 600
    Width        = 800
    Caption      = "Prioriza" + CHR(231) + CHR(227) + "o de Opera" + CHR(231) + CHR(245) + "es para Planejamento de Produ" + CHR(231) + CHR(227) + "o"
    AutoCenter   = .T.
    BorderStyle  = 2
    TitleBar     = 0
    DataSession  = 2
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    ShowTips     = .T.
    KeyPreview   = .T.

    *-- Estado / Negocio
    this_oBusinessObject = .NULL.
    this_cArquivoTempImg = ""

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        *-- DataSession=2 reseta SET DATE/CENTURY (regra 9.4)
        SET DATE TO BRITISH
        SET CENTURY ON
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrPcpBO")
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigPrPcpBO.", "Erro")
            ELSE
                THIS.this_cArquivoTempImg = SYS(2023) + "\SigPrPcp.jpg"

                *-- Tentar carregar configuracao do sistema (continua mesmo se BD indisponivel)
                IF !THIS.this_oBusinessObject.ObterConfiguracaoPam()
                    MsgErro("Falha ao carregar configura" + CHR(231) + CHR(227) + "o do sistema (SigCdPam).", "Erro")
                ENDIF

                *-- Criar cursor base para dados PCP (zTmppPcp do legado)
                SET NULL ON
                CREATE CURSOR cursor_4c_PcpDados ( ;
                    Priors    N(6)    NULL, ;
                    Nenvs     N(10)   NULL, ;
                    Nops      N(10)   NULL, ;
                    Emps      C(3)    NULL, ;
                    Dopes     C(20)   NULL, ;
                    Numes     N(6)    NULL, ;
                    Contas    C(10)   NULL, ;
                    Rclis     C(40)   NULL, ;
                    PrazoEnts T       NULL, ;
                    Cpros     C(14)   NULL, ;
                    Qtds      N(9,3)  NULL, ;
                    aPriors   N(6)    NULL  ;
                )
                SET NULL OFF

                *-- Processar OPs (cursor fica vazio se BD indisponivel)
                IF !THIS.this_oBusinessObject.Processar("cursor_4c_PcpDados")
                    MsgErro("Erro no Processamento dos Dados...", "Erro")
                ENDIF

                *-- Criar cursor de selecao consolidado (zTmpSelecao do legado)
                SET NULL ON
                SELECT DISTINCT Emps, Dopes, Numes, Contas, Rclis, ;
                                PrazoEnts, Priors, aPriors ;
                    FROM cursor_4c_PcpDados ;
                    INTO CURSOR cursor_4c_Selecao READWRITE
                SET NULL OFF

                *-- Indexar cursor de selecao para ordenacao
                SELECT cursor_4c_Selecao
                INDEX ON Emps + Dopes + STR(Numes,6) TAG EmpdopNum
                INDEX ON DTOS(PrazoEnts) + Emps + Dopes + STR(Numes,6) TAG Entrega
                INDEX ON Contas TAG Cliente
                INDEX ON STR(Priors,6) + Emps + Dopes + STR(Numes,6) TAG Prioridade
                SET ORDER TO Entrega

                *-- Indexar cursor de dados PCP para RELATION
                SELECT cursor_4c_PcpDados
                INDEX ON Emps + Dopes + STR(Numes,6) TAG EmpdopNum
                GO TOP

                *-- Estabelecer relacao entre cursores (como SET RELATION do legado)
                SELECT cursor_4c_Selecao
                GO TOP
                SET RELATION TO Emps + Dopes + STR(Numes,6) INTO cursor_4c_PcpDados

                *-- Montar interface visual
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarControlesAuxiliares()
                THIS.ConfigurarImagemProduto()
                THIS.TornarControlesVisiveis()

                *-- Propagar titulo para labels do cabecalho
                THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Carregar dados nos grids e vincular eventos
                THIS.CarregarGrades()
                THIS.VincularEventos()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro FormSigPrPcp.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - OPERACIONAL: sem PageFrame, fundo via Picture
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
        THIS.Picture      = gc_4c_CaminhoBase + "..\..\..\Framework\imagens\new_background.jpg"
        THIS.ClipControls = .F.
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container escuro com titulo (cntSombra do legado)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Visible     = .T.
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100,100,100)
        ENDWITH
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
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
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
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
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles do form visiveis recursivamente
    * NOTA: img_4c_FigJpg e shp_4c_Shape4 sao excluidos (Visible=.F. por default)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis
        LOCAL loc_nI, loc_oObj
        FOR loc_nI = 1 TO THIS.ControlCount
            loc_oObj = THIS.Controls(loc_nI)
            IF VARTYPE(loc_oObj) = "O"
                IF INLIST(UPPER(loc_oObj.Name), "IMG_4C_FIGJPG", "SHP_4C_SHAPE4")
                    LOOP
                ENDIF
                IF PEMSTATUS(loc_oObj, "Visible", 5)
                    loc_oObj.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oObj, "ControlCount", 5) AND loc_oObj.ControlCount > 0
                    THIS.TornarSubControlesVisiveis(loc_oObj)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * TornarSubControlesVisiveis - Recursao interna de TornarControlesVisiveis
    *==========================================================================
    PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObj
        IF !PEMSTATUS(par_oContainer, "ControlCount", 5)
            RETURN
        ENDIF
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObj = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oObj) = "O"
                IF PEMSTATUS(loc_oObj, "Visible", 5)
                    loc_oObj.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oObj, "ControlCount", 5) AND loc_oObj.ControlCount > 0
                    THIS.TornarSubControlesVisiveis(loc_oObj)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Monta a "lista" (grade principal Dados + grade Itens
    * + container de botoes de acao) equivalente a Page1 do padrao CRUD.
    * Em forms OPERACIONAIS sem PageFrame, este metodo consolida a configuracao
    * da area principal de trabalho (grids + botoes canonicos Confirmar/Sair).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
        *-- Grade principal (Grade do legado) - lado esquerdo, 6 colunas
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top           = 110
            .Left          = 0
            .Width         = 469
            .Height        = 398
            .ColumnCount   = 6
            .FontName      = "Tahoma"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .ReadOnly      = .T.
            .RowHeight     = 16
            .ScrollBars    = 2
            .GridLineColor = RGB(238,238,238)
            .Visible       = .T.

            WITH .Column1
                .Width             = 50
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .F.
                .Header1.Caption   = "Prioridade"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0,0,0)
                .Text1.InputMask   = "999999"
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            WITH .Column2
                .Width             = 31
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .Header1.Caption   = "Emp"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0,0,0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            WITH .Column3
                .Width             = 150
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0,0,0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            WITH .Column4
                .Width             = 52
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .Header1.Caption   = "Codigo"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0,0,0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            WITH .Column5
                .Width             = 80
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .Header1.Caption   = "Cliente"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0,0,0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            WITH .Column6
                .Width             = 80
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .Header1.Caption   = "Prazo.Entrega"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0,0,0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH
        ENDWITH

        *-- Grade de itens (GradeItem do legado) - lado direito, 4 colunas
        THIS.AddObject("grd_4c_Itens", "Grid")
        WITH THIS.grd_4c_Itens
            .Top           = 131
            .Left          = 470
            .Width         = 329
            .Height        = 325
            .ColumnCount   = 4
            .FontName      = "Tahoma"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .ReadOnly      = .T.
            .RowHeight     = 16
            .ScrollBars    = 2
            .GridLineColor = RGB(238,238,238)
            .Visible       = .T.

            WITH .Column1
                .Width             = 80
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .Header1.Caption   = "Envelope"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0,0,0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            WITH .Column2
                .Width             = 80
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .Header1.Caption   = "O.P."
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0,0,0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            WITH .Column3
                .Width             = 108
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .Header1.Caption   = "Produto"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0,0,0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            WITH .Column4
                .Width              = 52
                .Movable            = .F.
                .Resizable          = .F.
                .ReadOnly           = .T.
                .Header1.Caption    = "Qtde"
                .Header1.Alignment  = 2
                .Header1.ForeColor  = RGB(0,0,0)
                .Text1.InputMask    = "9999.99"
                .Text1.BorderStyle  = 0
                .Text1.Margin       = 0
                .Text1.ForeColor    = RGB(0,0,0)
                .Text1.BackColor    = RGB(255,255,255)
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Cria botoes Confirmar e Cancelar
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes
        *-- Botao Confirmar (Salva do legado)
        THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH THIS.cmd_4c_Confirmar
            .Top        = 3
            .Left       = 650
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .WordWrap   = .F.
            .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .Caption    = "Confirmar"
            .ForeColor  = RGB(90,90,90)
            .BackColor  = RGB(255,255,255)
            .Themes           = .T.
            .Visible    = .T.
        ENDWITH

        *-- Botao Cancelar/Sair (Sair do legado)
        THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH THIS.cmd_4c_Cancelar
            .Top        = 3
            .Left       = 725
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .WordWrap   = .F.
            .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .Cancel     = .T.
            .Caption    = "Encerrar"
            .ForeColor  = RGB(90,90,90)
            .BackColor  = RGB(255,255,255)
            .Themes           = .T.
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Controles de exibicao auxiliares (equivalente a
    * "Page2 Dados" nos forms CRUD). Para este form OPERACIONAL sem PageFrame,
    * agrupa os controles de exibicao de contexto da operacao selecionada:
    * txt_4c_Info (identificacao da OP), lbl_4c_Cliente e txt_4c_Cliente.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados
        *-- Caixa de identificacao da operacao selecionada (Text1 do legado)
        *-- Exibe: "EMP OPERACAO NUMES" ao navegar na grade principal
        THIS.AddObject("txt_4c_Info", "TextBox")
        WITH THIS.txt_4c_Info
            .Top         = 110
            .Left        = 470
            .Width       = 329
            .Height      = 21
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Alignment   = 2
            .ForeColor   = RGB(0,0,0)
            .BackColor   = RGB(0,128,255)
            .ReadOnly    = .T.
            .BorderStyle = 0
            .Value       = ""
            .Visible     = .T.
        ENDWITH

        *-- Label "Cliente" (Say3 do legado)
        THIS.AddObject("lbl_4c_Cliente", "Label")
        WITH THIS.lbl_4c_Cliente
            .AutoSize   = .T.
            .FontBold   = .F.
            .FontItalic = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "Cliente"
            .Left       = 23
            .Top        = 515
            .ForeColor  = RGB(90,90,90)
            .Visible    = .T.
        ENDWITH

        *-- Caixa do cliente (Get_Cliente do legado - somente leitura, preenchida via Grade)
        THIS.AddObject("txt_4c_Cliente", "TextBox")
        WITH THIS.txt_4c_Cliente
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Height      = 23
            .Left        = 60
            .Top         = 512
            .Width       = 411
            .ForeColor   = RGB(0,0,0)
            .BackColor   = RGB(255,255,221)
            .ReadOnly    = .T.
            .BorderStyle = 0
            .Value       = ""
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarControlesAuxiliares - Cria controles de filtros e ordenacao
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarControlesAuxiliares
        *-- Label "Ordenacao" (lbl_lancamentos do legado)
        THIS.AddObject("lbl_4c_Ordenacao", "Label")
        WITH THIS.lbl_4c_Ordenacao
            .AutoSize   = .T.
            .FontBold   = .F.
            .FontItalic = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "Ordena" + CHR(231) + CHR(227) + "o :"
            .Left       = 16
            .Top        = 545
            .ForeColor  = RGB(90,90,90)
            .Visible    = .T.
        ENDWITH

        *-- ComboBox de ordenacao (Cmb_Concilia do legado)
        THIS.AddObject("cbo_4c_Ordenacao", "ComboBox")
        WITH THIS.cbo_4c_Ordenacao
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 0
            .Style         = 2
            .Height        = 24
            .Left          = 80
            .Top           = 540
            .Width         = 140
            .Visible       = .T.
        ENDWITH

        *-- Label de dica TAB (Label1 do legado)
        THIS.AddObject("lbl_4c_TabDica", "Label")
        WITH THIS.lbl_4c_TabDica
            .AutoSize   = .T.
            .FontBold   = .F.
            .FontItalic = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "[ < TAB > para mudar de Grade ] "
            .Left       = 306
            .Top        = 545
            .ForeColor  = RGB(90,90,90)
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarImagemProduto - Cria shape e imagem do produto (ocultos por padrao)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarImagemProduto
        *-- Shape de fundo (Shape4 do legado)
        THIS.AddObject("shp_4c_Shape4", "Shape")
        WITH THIS.shp_4c_Shape4
            .Top         = 461
            .Left        = 480
            .Width       = 148
            .Height      = 109
            .BackStyle   = 0
            .BorderColor = RGB(90,90,90)
            .Visible     = .F.
        ENDWITH

        *-- Imagem do produto (FigJpg do legado)
        THIS.AddObject("img_4c_FigJpg", "Image")
        WITH THIS.img_4c_FigJpg
            .Stretch = 1
            .Top     = 463
            .Left    = 483
            .Width   = 143
            .Height  = 105
            .Visible = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * CarregarGrades - Configura RecordSource/ControlSource e popula combo
    *==========================================================================
    PROTECTED PROCEDURE CarregarGrades
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Selecao") OR !USED("cursor_4c_PcpDados")
                MsgErro("Cursores de dados n" + CHR(227) + "o inicializados.", "Erro")
            ELSE
                *-- Vincular grade principal ao cursor de selecao
                THIS.grd_4c_Dados.ColumnCount  = 6
                THIS.grd_4c_Dados.RecordSource = "cursor_4c_Selecao"
                WITH THIS.grd_4c_Dados
                    .Column1.ControlSource = "cursor_4c_Selecao.Priors"
                    .Column2.ControlSource = "cursor_4c_Selecao.Emps"
                    .Column3.ControlSource = "cursor_4c_Selecao.Dopes"
                    .Column4.ControlSource = "cursor_4c_Selecao.Numes"
                    .Column5.ControlSource = "cursor_4c_Selecao.Contas"
                    .Column6.ControlSource = "cursor_4c_Selecao.PrazoEnts"
                    .Refresh()
                ENDWITH

                *-- Vincular grade de itens ao cursor de dados PCP
                THIS.grd_4c_Itens.ColumnCount  = 4
                THIS.grd_4c_Itens.RecordSource = "cursor_4c_PcpDados"
                WITH THIS.grd_4c_Itens
                    .Column1.ControlSource = "cursor_4c_PcpDados.Nenvs"
                    .Column2.ControlSource = "cursor_4c_PcpDados.Nops"
                    .Column3.ControlSource = "cursor_4c_PcpDados.Cpros"
                    .Column4.ControlSource = "cursor_4c_PcpDados.Qtds"
                    .Refresh()
                ENDWITH

                *-- Popular combo de ordenacao (itens sem acento, como no legado)
                WITH THIS.cbo_4c_Ordenacao
                    .Clear()
                    .AddItem("Operacao")
                    .AddItem("Cliente")
                    .AddItem("Prazo Entrega")
                    .AddItem("Prioridade")
                    .Value = "Prazo Entrega"
                ENDWITH

                *-- Posicionar e atualizar painel de info
                SELECT cursor_4c_PcpDados
                GO TOP
                SELECT cursor_4c_Selecao
                GO TOP
                THIS.grd_4c_Dados.SetFocus()
                THIS.GrdDadosAfterRowColChange(1)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro FormSigPrPcp.CarregarGrades")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * VincularEventos - Estabelece BINDEVENTs para eventos dos controles
    *==========================================================================
    PROTECTED PROCEDURE VincularEventos
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
        BINDEVENT(THIS.grd_4c_Itens, "AfterRowColChange", THIS, "GrdItensAfterRowColChange")
        BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "GrdDadosCol1LostFocus")
        BINDEVENT(THIS.grd_4c_Itens.Column1.Text1, "KeyPress", THIS, "GrdItensCol1LostFocus")
        BINDEVENT(THIS.cbo_4c_Ordenacao, "InteractiveChange", THIS, "CboOrdenacaoInteractiveChange")
        BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna foco entre a grade principal (1) e a grade de
    * itens (2). Em OPERACIONAL sem PageFrame, este metodo cumpre o papel do
    * <TAB> descrito no rodape do form legado ("[ <TAB> para mudar de Grade ]").
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        loc_nPagina = IIF(VARTYPE(par_nPagina) = "N" AND par_nPagina > 0, par_nPagina, 1)
        DO CASE
            CASE loc_nPagina = 1
                IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                    THIS.grd_4c_Dados.SetFocus()
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
            CASE loc_nPagina = 2
                IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
                    THIS.grd_4c_Itens.SetFocus()
                    THIS.grd_4c_Itens.Refresh()
                ENDIF
        ENDCASE
    ENDPROC

    *==========================================================================
    * GrdDadosAfterRowColChange - Atualiza paineis ao mudar linha na grade principal
    *==========================================================================
    PROCEDURE GrdDadosAfterRowColChange
        LPARAMETERS par_nColIndex
        IF !USED("cursor_4c_Selecao")
            RETURN
        ENDIF
        THIS.LockScreen = .T.
        SELECT cursor_4c_Selecao
        THIS.txt_4c_Cliente.Value = NVL(cursor_4c_Selecao.Rclis, "")
        THIS.txt_4c_Cliente.Refresh()
        SELECT cursor_4c_PcpDados
        GO TOP
        THIS.grd_4c_Itens.Refresh()
        THIS.img_4c_FigJpg.Visible = .F.
        THIS.img_4c_FigJpg.Picture = ""
        SELECT cursor_4c_Selecao
        THIS.txt_4c_Info.Value = NVL(cursor_4c_Selecao.Emps, "") + " " + ;
            ALLTRIM(NVL(cursor_4c_Selecao.Dopes, "")) + " " + ;
            STR(NVL(cursor_4c_Selecao.Numes, 0), 6)
        THIS.LockScreen = .F.
    ENDPROC

    *==========================================================================
    * GrdItensAfterRowColChange - Carrega foto do produto ao mudar linha nos itens
    *==========================================================================
    PROCEDURE GrdItensAfterRowColChange
        LPARAMETERS par_nColIndex
        LOCAL loc_cCpros
        IF !USED("cursor_4c_PcpDados")
            RETURN
        ENDIF
        THIS.LockScreen = .T.
        THIS.img_4c_FigJpg.Visible = .F.
        THIS.img_4c_FigJpg.Picture = ""
        THIS.shp_4c_Shape4.Visible = .F.
        SELECT cursor_4c_PcpDados
        IF !EOF("cursor_4c_PcpDados")
            loc_cCpros = NVL(cursor_4c_PcpDados.Cpros, "")
            IF !EMPTY(loc_cCpros)
                IF THIS.this_oBusinessObject.ObterImagemProduto(loc_cCpros, THIS.this_cArquivoTempImg)
                    THIS.img_4c_FigJpg.Picture = THIS.this_cArquivoTempImg
                    THIS.img_4c_FigJpg.Visible = .T.
                    THIS.shp_4c_Shape4.Visible = .T.
                ENDIF
            ENDIF
        ENDIF
        SELECT cursor_4c_PcpDados
        THIS.LockScreen = .F.
    ENDPROC

    *==========================================================================
    * GrdDadosCol1LostFocus - TAB na coluna Prioridade salta para grade de itens
    *==========================================================================
    PROCEDURE GrdDadosCol1LostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF LASTKEY() = 9
            THIS.grd_4c_Itens.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * GrdItensCol1LostFocus - TAB na coluna Envelope retorna para grade principal
    *==========================================================================
    PROCEDURE GrdItensCol1LostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF LASTKEY() = 9
            THIS.grd_4c_Dados.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * CboOrdenacaoInteractiveChange - Reordena grade principal ao mudar combo
    *==========================================================================
    PROCEDURE CboOrdenacaoInteractiveChange
        IF !USED("cursor_4c_Selecao")
            RETURN
        ENDIF
        SELECT cursor_4c_Selecao
        SET RELATION TO
        SET ORDER TO
        DO CASE
            CASE ALLTRIM(THIS.cbo_4c_Ordenacao.Value) = "Prazo Entrega"
                SET ORDER TO Entrega
            CASE ALLTRIM(THIS.cbo_4c_Ordenacao.Value) = "Cliente"
                SET ORDER TO Cliente
            CASE ALLTRIM(THIS.cbo_4c_Ordenacao.Value) = "Operacao"
                SET ORDER TO EmpDopNum
            CASE ALLTRIM(THIS.cbo_4c_Ordenacao.Value) = "Prioridade"
                SET ORDER TO Prioridade
        ENDCASE
        SELECT cursor_4c_Selecao
        SET RELATION TO Emps + Dopes + STR(Numes,6) INTO cursor_4c_PcpDados
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - Grava prioridades no banco (Salva.Click do legado)
    *==========================================================================
    PROCEDURE BtnConfirmarClick
        IF !USED("cursor_4c_Selecao")
            MsgAviso("Dados de sele" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "veis.")
            RETURN
        ENDIF
        IF !MsgConfirma("Confirma Grava" + CHR(231) + CHR(227) + "o dos Dados!!!")
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.GravarPrioridades("cursor_4c_Selecao")
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Confirma abandono da priorizacao (Sair.Click do legado)
    *==========================================================================
    PROCEDURE BtnCancelarClick
        IF MsgConfirma("Deseja Realmente abandonar Prioriza" + CHR(231) + CHR(227) + "o")
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Ativa edicao de prioridades (foco na grade principal)
    * Mapeamento OPERACIONAL: "incluir" = iniciar entrada de dados de prioridade
    * na coluna Priors da grade principal, posicionando no topo da lista.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            IF !USED("cursor_4c_Selecao") OR RECCOUNT("cursor_4c_Selecao") = 0
                MsgAviso("N" + CHR(227) + "o existem opera" + CHR(231) + CHR(245) + ;
                         "es para priorizar.", "Aviso")
                RETURN
            ENDIF
            SELECT cursor_4c_Selecao
            GO TOP
            THIS.grd_4c_Dados.Refresh()
            THIS.GrdDadosAfterRowColChange(1)
            THIS.grd_4c_Dados.SetFocus()
            THIS.grd_4c_Dados.ActivateCell(1, 1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnIncluir")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Edita prioridade da linha selecionada na grade principal
    * Mapeamento OPERACIONAL: "alterar" = editar a coluna Priors da linha corrente
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro, loc_nLinha
        TRY
            IF !USED("cursor_4c_Selecao") OR RECCOUNT("cursor_4c_Selecao") = 0
                MsgAviso("N" + CHR(227) + "o existem opera" + CHR(231) + CHR(245) + ;
                         "es para alterar.", "Aviso")
                RETURN
            ENDIF
            SELECT cursor_4c_Selecao
            IF EOF() OR BOF()
                GO TOP
            ENDIF
            loc_nLinha = THIS.grd_4c_Dados.RelativeRow
            IF loc_nLinha < 1
                loc_nLinha = 1
            ENDIF
            THIS.grd_4c_Dados.SetFocus()
            THIS.grd_4c_Dados.ActivateCell(loc_nLinha, 1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnAlterar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Recarrega/reprocessa dados dos grids do zero
    * Mapeamento OPERACIONAL: "visualizar" = refresh completo (reprocessa PCP)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            IF !MsgConfirma("Recarregar todos os dados descarta as altera" + ;
                            CHR(231) + CHR(245) + "es n" + CHR(227) + "o gravadas." + ;
                            CHR(13) + "Confirma?")
                RETURN
            ENDIF
            THIS.LockScreen = .T.

            *-- Encerrar relacao e cursores para reprocessar
            IF USED("cursor_4c_Selecao")
                SELECT cursor_4c_Selecao
                SET RELATION TO
                USE IN cursor_4c_Selecao
            ENDIF
            IF USED("cursor_4c_PcpDados")
                USE IN cursor_4c_PcpDados
            ENDIF

            *-- Recriar cursor base
            SET NULL ON
            CREATE CURSOR cursor_4c_PcpDados ( ;
                Priors    N(6)    NULL, ;
                Nenvs     N(10)   NULL, ;
                Nops      N(10)   NULL, ;
                Emps      C(3)    NULL, ;
                Dopes     C(20)   NULL, ;
                Numes     N(6)    NULL, ;
                Contas    C(10)   NULL, ;
                Rclis     C(40)   NULL, ;
                PrazoEnts T       NULL, ;
                Cpros     C(14)   NULL, ;
                Qtds      N(9,3)  NULL, ;
                aPriors   N(6)    NULL  ;
            )
            SET NULL OFF

            IF THIS.this_oBusinessObject.Processar("cursor_4c_PcpDados")
                *-- Recriar cursor de selecao consolidado
                SET NULL ON
                SELECT DISTINCT Emps, Dopes, Numes, Contas, Rclis, ;
                                PrazoEnts, Priors, aPriors ;
                    FROM cursor_4c_PcpDados ;
                    INTO CURSOR cursor_4c_Selecao READWRITE
                SET NULL OFF

                *-- Reindexar
                SELECT cursor_4c_Selecao
                INDEX ON Emps + Dopes + STR(Numes,6) TAG EmpdopNum
                INDEX ON DTOS(PrazoEnts) + Emps + Dopes + STR(Numes,6) TAG Entrega
                INDEX ON Contas TAG Cliente
                INDEX ON STR(Priors,6) + Emps + Dopes + STR(Numes,6) TAG Prioridade
                SET ORDER TO Entrega

                SELECT cursor_4c_PcpDados
                INDEX ON Emps + Dopes + STR(Numes,6) TAG EmpdopNum
                GO TOP

                SELECT cursor_4c_Selecao
                GO TOP
                SET RELATION TO Emps + Dopes + STR(Numes,6) INTO cursor_4c_PcpDados

                *-- Revincular grids aos cursores recriados
                THIS.CarregarGrades()
                MsgInfo("Dados recarregados com sucesso.", "Visualizar")
            ELSE
                MsgErro("Falha ao reprocessar dados PCP.", "Erro Visualizar")
            ENDIF

            THIS.LockScreen = .F.
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnVisualizar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Zera prioridade da linha selecionada (Priors = 0)
    * Mapeamento OPERACIONAL: "excluir" = remover a prioridade (voltar ao default)
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro
        TRY
            IF !USED("cursor_4c_Selecao") OR RECCOUNT("cursor_4c_Selecao") = 0
                MsgAviso("N" + CHR(227) + "o existem opera" + CHR(231) + CHR(245) + ;
                         "es para atualizar.", "Aviso")
                RETURN
            ENDIF
            SELECT cursor_4c_Selecao
            IF EOF() OR BOF()
                MsgAviso("Selecione uma linha na grade antes de zerar a prioridade.", ;
                         "Aviso")
                RETURN
            ENDIF
            IF NVL(cursor_4c_Selecao.Priors, 0) = 0
                MsgAviso("A prioridade desta opera" + CHR(231) + CHR(227) + ;
                         "o j" + CHR(225) + " est" + CHR(225) + " zerada.", "Aviso")
                RETURN
            ENDIF
            IF !MsgConfirma("Zerar prioridade da opera" + CHR(231) + CHR(227) + "o selecionada?")
                RETURN
            ENDIF
            REPLACE cursor_4c_Selecao.Priors WITH 0
            THIS.grd_4c_Dados.Refresh()
            THIS.GrdDadosAfterRowColChange(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnExcluir")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega os grids (wrapper publico de CarregarGrades)
    *==========================================================================
    PROCEDURE CarregarLista()
        THIS.CarregarGrades()
    ENDPROC

    *==========================================================================
    * FormParaBO - Carrega propriedades do BO a partir da linha corrente do cursor
    *==========================================================================
    PROCEDURE FormParaBO()
        IF USED("cursor_4c_Selecao") AND !EOF("cursor_4c_Selecao")
            THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Selecao")
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Atualiza controles de exibicao a partir das props do BO
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject
        THIS.txt_4c_Info.Value    = ALLTRIM(loc_oBO.this_cEmps) + " " + ;
                                    ALLTRIM(loc_oBO.this_cDopes) + " " + ;
                                    STR(loc_oBO.this_nNumes, 6)
        THIS.txt_4c_Cliente.Value = loc_oBO.this_cRclis
        THIS.txt_4c_Info.Refresh()
        THIS.txt_4c_Cliente.Refresh()
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita controles conforme disponibilidade
    *==========================================================================
    PROCEDURE HabilitarCampos()
        LOCAL loc_lTemDados
        loc_lTemDados = USED("cursor_4c_Selecao") AND RECCOUNT("cursor_4c_Selecao") > 0
        IF PEMSTATUS(THIS, "cmd_4c_Confirmar", 5)
            THIS.cmd_4c_Confirmar.Enabled = loc_lTemDados
        ENDIF
        IF PEMSTATUS(THIS, "cbo_4c_Ordenacao", 5)
            THIS.cbo_4c_Ordenacao.Enabled = loc_lTemDados
        ENDIF
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Enabled = loc_lTemDados
        ENDIF
        IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
            THIS.grd_4c_Itens.Enabled = loc_lTemDados
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa controles de exibicao e oculta imagem do produto
    *==========================================================================
    PROCEDURE LimparCampos()
        THIS.txt_4c_Info.Value    = ""
        THIS.txt_4c_Cliente.Value = ""
        THIS.img_4c_FigJpg.Visible  = .F.
        THIS.img_4c_FigJpg.Picture  = ""
        THIS.shp_4c_Shape4.Visible  = .F.
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita botao Confirmar apenas se houver dados
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lTemDados
        loc_lTemDados = USED("cursor_4c_Selecao") AND RECCOUNT("cursor_4c_Selecao") > 0
        IF PEMSTATUS(THIS, "cmd_4c_Confirmar", 5)
            THIS.cmd_4c_Confirmar.Enabled = loc_lTemDados
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Volta ao topo da grade principal e reposiciona painel
    * Mapeamento OPERACIONAL: "buscar" = posicionar no inicio da lista
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oErro
        TRY
            IF !USED("cursor_4c_Selecao") OR RECCOUNT("cursor_4c_Selecao") = 0
                MsgAviso("N" + CHR(227) + "o existem opera" + CHR(231) + CHR(245) + "es para exibir.")
                RETURN
            ENDIF
            SELECT cursor_4c_Selecao
            GO TOP
            THIS.grd_4c_Dados.Refresh()
            THIS.GrdDadosAfterRowColChange(1)
            THIS.grd_4c_Dados.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnBuscar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Alias de BtnConfirmarClick (padrao FormBase)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnConfirmarClick()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Alias de BtnCancelarClick (padrao FormBase canonico)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.BtnCancelarClick()
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        *-- Encerrar relacao entre cursores antes de fechar
        IF USED("cursor_4c_Selecao")
            SELECT cursor_4c_Selecao
            SET RELATION TO
            USE IN cursor_4c_Selecao
        ENDIF
        IF USED("cursor_4c_PcpDados")
            USE IN cursor_4c_PcpDados
        ENDIF
        *-- Remover arquivo temporario de imagem de produto
        IF !EMPTY(THIS.this_cArquivoTempImg) AND FILE(THIS.this_cArquivoTempImg)
            ERASE (THIS.this_cArquivoTempImg)
        ENDIF
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
