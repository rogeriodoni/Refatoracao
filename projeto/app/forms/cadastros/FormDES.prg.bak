*==============================================================================
* FormDES.prg - Cadastro de Cotas de Desconto por Periodo
* Tabela : sigcddes | PK: codigo | Tipo: CRUD (frmcadastro)
* Fase 8/8 - FORM: Eventos Auxiliares e Consolidacao Final
* Metodos completos: Init/InicializarForm/ConfigurarPageFrame/ConfigurarPaginaLista/
*   ConfigurarPaginaDados/CarregarLista/AlternarPagina/FormParaBO/BOParaForm/
*   HabilitarCampos/LimparCampos/AjustarBotoesPorModo/TornarControlesVisiveis/
*   FormatarGridLista/ValidarEmps/RecalcularPdes/ImportaPlan/BtnEncerrarClick/
*   BtnIncluirClick/BtnVisualizarClick/BtnAlterarClick/BtnExcluirClick/
*   BtnBuscarClick/BtnBtncarregarClick/BtnConfirmarClick/BtnCancelarClick
*==============================================================================

DEFINE CLASS FormDES AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Cotas de Desconto por per" + CHR(237) + "odo"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_cFiltroEmps     = ""    && Filtro de empresa para o grid

    *==========================================================================
    * Init
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loException
            MsgErro("Erro em FormDES.Init:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado pelo FormBase.Init()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("DESBO")

            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Erro ao criar DESBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaDados()

                IF TYPE("gb_4c_ValidandoUI") <> "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormDES.InicializarForm:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(255, 255, 255)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(255, 255, 255)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: Cabecalho + Botoes CRUD + Grid
    * Legado: cntSombra.Top=1, Grupo_op.Left=538 Width=389, Grade.Top=131 Left=12
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza escuro (cntSombra do legado)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 12
            .Width     = THIS.Width
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes CRUD (Grupo_op do legado - Left=538, Width=389)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        =  542
            .Width       = 389
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Visualizar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Alterar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Excluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Buscar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Container Encerrar - padrao canonico (PREVALECE sobre PILAR 1)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao especial Carrega Cotas (legado: btncarregar, top=4+29=33, left=467)
        *-- Inicia oculto (Visible=.F.) conforme legado
        loc_oPagina.AddObject("cmd_4c_Btncarregar", "CommandButton")
        WITH loc_oPagina.cmd_4c_Btncarregar
            .Caption         = "Carrega Cotas"
            .PicturePosition = 13
            .Top             = 33
            .Left            = 467
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .F.    && Inicia oculto conforme legado
        ENDWITH

        *-- Grid de lista (legado: grade.Top=131 left=12, compensado +29)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 160
            .Left               = 12
            .Width              = 890
            .Height             = 460
            .ColumnCount        = 6
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH

        *-- Larguras das colunas (captions definidos em CarregarLista apos RecordSource)
        loc_oPagina.grd_4c_Lista.Column1.Width = 100
        loc_oPagina.grd_4c_Lista.Column2.Width = 75
        loc_oPagina.grd_4c_Lista.Column3.Width = 75
        loc_oPagina.grd_4c_Lista.Column4.Width = 75
        loc_oPagina.grd_4c_Lista.Column5.Width = 100
        loc_oPagina.grd_4c_Lista.Column6.Width = 100

        *-- BINDEVENTs - metodos PUBLIC para funcionar com BINDEVENT
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPagina.cmd_4c_Btncarregar,               "Click", THIS, "BtnBtncarregarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: Botoes + Todos os Campos
    * Legado: Grupo_Salva.Left=819, Top=9+29=38
    * Campos: Codigo, Emps, Dtini, Dtfin, Valmeta, Valcota, Valdes, Pdes
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Salvar/Cancelar (Grupo_Salva do legado - Left=819, Top=38)
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top         = 38
            .Left        = 819
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salvar)
        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Cancelar
        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- PARTE 1: Campos Codigo, Empresa, Dt Inicio, Dt Final
        *-- Posicoes do legado (layout.json) + compensacao PageFrame +29

        *-- Label Codigo (Say7: top=126+29=155, left=445, caption="Codigo :")
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 155
            .Left      = 445
            .Width     = 80
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo (getcodigo: top=121+29=150, left=492, width=80)
        *-- Sempre somente leitura (When=.F. no legado, auto-gerado pelo sistema)
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value       = ""
            .Top         = 150
            .Left        = 492
            .Width       = 80
            .Height      = 24
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Enabled     = .F.
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH

        *-- Label Empresa (Say1: top=153+29=182, left=437, caption="Empresa : ")
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Empresa :"
            .Top       = 182
            .Left      = 437
            .Width     = 80
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Empresa (getEmps: top=148+29=177, left=492, width=33)
        *-- Editavel apenas no modo INCLUIR (When=INLIST(pcEscolha,'INSERIR'))
        *-- MaxLength=3 pois SigCdEmp.Cemps = char(3)
        loc_oPagina.AddObject("txt_4c_Emps", "TextBox")
        WITH loc_oPagina.txt_4c_Emps
            .Value       = ""
            .Top         = 177
            .Left        = 492
            .Width       = 33
            .Height      = 24
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .MaxLength   = 3
            .Enabled     = .F.
            .Visible     = .T.
        ENDWITH

        *-- Label Data Inicial (Say5: top=180+29=209, left=425, caption="Data Inicial : ")
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Data Inicial :"
            .Top       = 209
            .Left      = 425
            .Width     = 92
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Data Inicial (getDtini: top=175+29=204, left=492, width=80)
        *-- Editavel apenas no modo INCLUIR
        loc_oPagina.AddObject("txt_4c_Dtini", "TextBox")
        WITH loc_oPagina.txt_4c_Dtini
            .Value       = {}
            .Top         = 204
            .Left        = 492
            .Width       = 80
            .Height      = 24
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .InputMask   = "99/99/9999"
            .Enabled     = .F.
            .Visible     = .T.
        ENDWITH

        *-- Label Data Final (Say6: top=207+29=236, left=430, caption="Data Final : ")
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Data Final :"
            .Top       = 236
            .Left      = 430
            .Width     = 87
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Data Final (GetDtfin: top=202+29=231, left=492, width=80)
        *-- Editavel apenas no modo INCLUIR
        loc_oPagina.AddObject("txt_4c_Dtfin", "TextBox")
        WITH loc_oPagina.txt_4c_Dtfin
            .Value       = {}
            .Top         = 231
            .Left        = 492
            .Width       = 80
            .Height      = 24
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .InputMask   = "99/99/9999"
            .Enabled     = .F.
            .Visible     = .T.
        ENDWITH

        *-- PARTE 2: Campos de valores monetarios e percentual

        *-- Label Meta de Vendas (Say3: top=234+29=263, left=401)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Meta de Vendas :"
            .Top       = 263
            .Left      = 401
            .Width     = 110
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Meta de Vendas (GetValmeta: top=229+29=258, left=492, width=126)
        *-- Editavel em INCLUIR e ALTERAR
        loc_oPagina.AddObject("txt_4c_Valmeta", "TextBox")
        WITH loc_oPagina.txt_4c_Valmeta
            .Value         = 0
            .Top           = 258
            .Left          = 492
            .Width         = 126
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .BorderStyle   = 1
            .InputMask     = "99,999,999.99"
            .Alignment     = 3
            .SpecialEffect = 1
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label Cota Desconto $ (Say2: top=261+29=290, left=398)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Cota Desconto $ :"
            .Top       = 290
            .Left      = 398
            .Width     = 113
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Cota Desconto $ (getvalcota: top=256+29=285, left=492, width=126)
        *-- Editavel em INCLUIR e ALTERAR
        loc_oPagina.AddObject("txt_4c_Valcota", "TextBox")
        WITH loc_oPagina.txt_4c_Valcota
            .Value         = 0
            .Top           = 285
            .Left          = 492
            .Width         = 126
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .BorderStyle   = 1
            .InputMask     = "99,999,999.99"
            .Alignment     = 3
            .SpecialEffect = 1
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label Desconto Aplicado $ (Say8: top=288+29=317, left=381)
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Desconto Aplicado $ :"
            .Top       = 317
            .Left      = 381
            .Width     = 130
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Desconto Aplicado $ (getvaldes: top=283+29=312, left=492, width=126)
        *-- Sempre somente leitura (registrado pelo sistema quando descontos sao aplicados)
        loc_oPagina.AddObject("txt_4c_Valdes", "TextBox")
        WITH loc_oPagina.txt_4c_Valdes
            .Value         = 0
            .Top           = 312
            .Left          = 492
            .Width         = 126
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .BorderStyle   = 1
            .InputMask     = "99,999,999.99"
            .Alignment     = 3
            .SpecialEffect = 1
            .Enabled       = .F.
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Label Cota Desconto % (Say4: top=315+29=344, left=393)
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Cota Desconto % :"
            .Top       = 344
            .Left      = 393
            .Width     = 116
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Cota Desconto % (getpdes: top=310+29=339, left=492, width=126)
        *-- Sempre somente leitura (calculado: valcota/valmeta*100)
        loc_oPagina.AddObject("txt_4c_Pdes", "TextBox")
        WITH loc_oPagina.txt_4c_Pdes
            .Value         = 0
            .Top           = 339
            .Left          = 492
            .Width         = 126
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .BorderStyle   = 1
            .InputMask     = "999.99"
            .Alignment     = 3
            .SpecialEffect = 1
            .Enabled       = .F.
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- BINDEVENTs dos botoes de Page2
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- BINDEVENT Empresa: validar ao perder foco
        BINDEVENT(loc_oPagina.txt_4c_Emps, "KeyPress", THIS, "ValidarEmps")

        *-- BINDEVENT Valmeta/Valcota: recalcular % ao sair do campo
        *-- Legado: GetValmeta.Valid e getvalcota.Valid atualizam getpdes
        BINDEVENT(loc_oPagina.txt_4c_Valmeta, "LostFocus", THIS, "RecalcularPdes")
        BINDEVENT(loc_oPagina.txt_4c_Valcota, "LostFocus", THIS, "RecalcularPdes")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ValidarEmps - Valida codigo de empresa ao sair do campo
    * Substitui fAcessoEmpresa() (nao portada) - verifica se Cemps existe em SigCdEmp
    *==========================================================================
    PROCEDURE ValidarEmps(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cEmps, loc_cSQL, loc_nRes, loc_lResultado
        loc_lResultado = .F.

        IF !PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5)
            RETURN
        ENDIF

        loc_oPg2  = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
            RETURN
        ENDIF

        loc_cEmps = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)

        IF EMPTY(loc_cEmps)
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp" + ;
                       " WHERE Cemps = " + EscaparSQL(loc_cEmps)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaEmp")

            IF loc_nRes > 0 AND USED("cursor_4c_ValidaEmp")
                IF RECCOUNT("cursor_4c_ValidaEmp") = 0
                    MsgAviso("Empresa '" + loc_cEmps + "' n" + CHR(227) + "o encontrada.", "")
                    loc_oPg2.txt_4c_Emps.Value = ""
                    loc_oPg2.txt_4c_Emps.SetFocus()
                ENDIF
                USE IN cursor_4c_ValidaEmp
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ValidarEmps:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_ValidaEmp")
                USE IN cursor_4c_ValidaEmp
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega cursor cursor_4c_Lista e vincula ao Grid
    * DESBO.Buscar() retorna: codigo, emps, dtini, dtfin, valmeta, valcota,
    *   valdes, usualts, dtalts
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF !THIS.this_oBusinessObject.Buscar(THIS.this_cFiltroEmps)
                loc_lResultado = .F.
            ELSE
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    loc_oGrid.ColumnCount = 6
                    loc_oGrid.RecordSource = "cursor_4c_Lista"

                    *-- ControlSources APOS RecordSource (previne auto-bind sobrescrever)
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Lista.codigo"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Lista.emps"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Lista.dtini"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Lista.dtfin"
                    loc_oGrid.Column5.ControlSource = "cursor_4c_Lista.valmeta"
                    loc_oGrid.Column6.ControlSource = "cursor_4c_Lista.valdes"

                    *-- Captions APOS ControlSource (RecordSource reseta os captions)
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Empresa"
                    loc_oGrid.Column3.Header1.Caption = "Dt Inicio"
                    loc_oGrid.Column4.Header1.Caption = "Dt final"
                    loc_oGrid.Column5.Header1.Caption = "Vr Meta"
                    loc_oGrid.Column6.Header1.Caption = "Vr Desconto"

                    THIS.FormatarGridLista(loc_oGrid)
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarLista:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) <> "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro em AlternarPagina:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * EXCECAO: cmd_4c_Btncarregar inicia oculto (Visible=.F. conforme legado)
    * EXCECAO: cnt_4c_Cabecalho gerencia propria visibilidade (nao deve ser forcado)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP, loc_cNome

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_cNome = UPPER(loc_oObjeto.Name)

                *-- Pular controles que devem iniciar ocultos ou gerenciam propria visibilidade
                *-- Recursao antes do LOOP para que filhos ainda sejam processados
                IF INLIST(loc_cNome, "CMD_4C_BTNCARREGAR", "CNT_4C_CABECALHO")
                    IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fechar formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Incluir novo registro
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Emps", 5)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Emps.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN
        ENDIF

        SELECT cursor_4c_Lista
        loc_cCodigo = ALLTRIM(cursor_4c_Lista.codigo)

        IF EMPTY(loc_cCodigo)
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)

            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Alterar registro selecionado
    * Legado: emps/dtini/dtfin nao editaveis apos criacao (When=INSERIR only)
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN
        ENDIF

        SELECT cursor_4c_Lista
        loc_cCodigo = ALLTRIM(cursor_4c_Lista.codigo)

        IF EMPTY(loc_cCodigo)
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)

            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Valmeta", 5)
                THIS.pgf_4c_Paginas.Page2.txt_4c_Valmeta.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Excluir registro selecionado
    * Regra de negocio (DESBO): exclusao bloqueada se valdes > 0 (cota usada)
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lConfirma
        loc_cCodigo = ""
        loc_lConfirma = .F.

        IF !USED("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN
        ENDIF

        SELECT cursor_4c_Lista
        loc_cCodigo = ALLTRIM(cursor_4c_Lista.codigo)

        IF EMPTY(loc_cCodigo)
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro?" + ;
                CHR(13) + "C" + CHR(243) + "digo: " + loc_cCodigo, ;
                "Excluir")

            IF loc_lConfirma
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Filtrar grid por empresa
    * Legado: LocateCursor por emps - equivalente: recarregar filtrado
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cEmps
        loc_cEmps = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", "", ;
                "Buscar Empresa")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "d")
                loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                    SELECT cursor_4c_BuscaEmp
                    loc_cEmps = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF

            THIS.this_cFiltroEmps = loc_cEmps
            THIS.CarregarLista()
        CATCH TO loException
            MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBtncarregarClick - Importar planilha Excel de cotas
    *==========================================================================
    PROCEDURE BtnBtncarregarClick()
        LOCAL loc_lResultado
        loc_lResultado = THIS.ImportaPlan()

        IF loc_lResultado
            MsgInfo("Planilha importada com sucesso.", "")
            THIS.CarregarLista()
        ELSE
            MsgAviso("A Planilha n" + CHR(227) + "o foi importada.", "Aviso")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - Salvar registro (chama Inserir ou Atualizar via BO)
    * Legado: fSalvar em Salva.Click - valida campos, faz INSERT/UPDATE e volta lista
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        TRY
            IF THIS.this_cModoAtual = "VISUALIZAR"
                THIS.AlternarPagina(1)
                THIS.this_cModoAtual = "LISTA"
            ELSE
                IF THIS.FormParaBO()
                    IF THIS.this_oBusinessObject.Salvar()
                        MsgInfo("Registro salvo com sucesso!", "")
                        THIS.this_cModoAtual = "LISTA"
                        THIS.AlternarPagina(1)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BtnConfirmarClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancelar edicao e voltar para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        CATCH TO loException
            MsgErro("Erro em BtnCancelarClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita Confirmar conforme modo atual
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lVisualizar
        loc_lVisualizar = (THIS.this_cModoAtual = "VISUALIZAR")

        IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_Salva", 5)
            RETURN
        ENDIF

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
            loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = !loc_lVisualizar
        ENDIF

        IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Cancelar", 5)
            loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos conforme modo
    * Legado: getEmps/getDtini/GetDtfin.When = INLIST(pcEscolha,'INSERIR')
    *         getpdes/getvaldes/getcodigo.When = .F. (sempre somente leitura)
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lModoIncluir

        IF !PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5)
            RETURN
        ENDIF

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_lModoIncluir = (THIS.this_cModoAtual = "INCLUIR")

        *-- Codigo: sempre somente leitura (auto-gerado pelo sistema)
        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
            loc_oPg2.txt_4c_Codigo.Enabled = .F.
        ENDIF

        *-- Empresa, Dt Inicio, Dt Final: editavel SOMENTE no modo INCLUIR
        IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
            loc_oPg2.txt_4c_Emps.Enabled = (par_lHabilitar AND loc_lModoIncluir)
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Dtini", 5)
            loc_oPg2.txt_4c_Dtini.Enabled = (par_lHabilitar AND loc_lModoIncluir)
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Dtfin", 5)
            loc_oPg2.txt_4c_Dtfin.Enabled = (par_lHabilitar AND loc_lModoIncluir)
        ENDIF

        *-- Valmeta e Valcota: editavel em INCLUIR e ALTERAR
        IF PEMSTATUS(loc_oPg2, "txt_4c_Valmeta", 5)
            loc_oPg2.txt_4c_Valmeta.Enabled = par_lHabilitar
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Valcota", 5)
            loc_oPg2.txt_4c_Valcota.Enabled = par_lHabilitar
        ENDIF

        *-- Pdes e Valdes: sempre somente leitura (calculados/registrados pelo sistema)
        IF PEMSTATUS(loc_oPg2, "txt_4c_Pdes", 5)
            loc_oPg2.txt_4c_Pdes.Enabled = .F.
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Valdes", 5)
            loc_oPg2.txt_4c_Valdes.Enabled = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2

        IF !PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5)
            RETURN
        ENDIF

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
            loc_oPg2.txt_4c_Codigo.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
            loc_oPg2.txt_4c_Emps.Value    = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Dtini", 5)
            loc_oPg2.txt_4c_Dtini.Value   = {}
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Dtfin", 5)
            loc_oPg2.txt_4c_Dtfin.Value   = {}
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Valmeta", 5)
            loc_oPg2.txt_4c_Valmeta.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Valcota", 5)
            loc_oPg2.txt_4c_Valcota.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Valdes", 5)
            loc_oPg2.txt_4c_Valdes.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Pdes", 5)
            loc_oPg2.txt_4c_Pdes.Value    = 0
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores dos campos do form para o BO
    *==========================================================================
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_oPg2, loc_lResultado
        loc_lResultado = .F.

        IF !PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5)
            RETURN .F.
        ENDIF

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
                THIS.this_oBusinessObject.this_cEmps    = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Dtini", 5)
                THIS.this_oBusinessObject.this_dDtini   = loc_oPg2.txt_4c_Dtini.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Dtfin", 5)
                THIS.this_oBusinessObject.this_dDtfin   = loc_oPg2.txt_4c_Dtfin.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Valmeta", 5)
                THIS.this_oBusinessObject.this_nValmeta = loc_oPg2.txt_4c_Valmeta.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Valcota", 5)
                THIS.this_oBusinessObject.this_nValcota = loc_oPg2.txt_4c_Valcota.Value
            ENDIF

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro em FormParaBO:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * BOParaForm - Transfere valores do BO para os campos do form
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_nValmeta, loc_nValcota

        IF !PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5)
            RETURN
        ENDIF

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
                loc_oPg2.txt_4c_Codigo.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
                loc_oPg2.txt_4c_Emps.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Dtini", 5)
                loc_oPg2.txt_4c_Dtini.Value   = THIS.this_oBusinessObject.this_dDtini
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Dtfin", 5)
                loc_oPg2.txt_4c_Dtfin.Value   = THIS.this_oBusinessObject.this_dDtfin
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Valmeta", 5)
                loc_oPg2.txt_4c_Valmeta.Value = THIS.this_oBusinessObject.this_nValmeta
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Valcota", 5)
                loc_oPg2.txt_4c_Valcota.Value = THIS.this_oBusinessObject.this_nValcota
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Valdes", 5)
                loc_oPg2.txt_4c_Valdes.Value  = THIS.this_oBusinessObject.this_nValdes
            ENDIF

            *-- Calcular e exibir percentual de desconto
            loc_nValmeta = THIS.this_oBusinessObject.this_nValmeta
            loc_nValcota = THIS.this_oBusinessObject.this_nValcota
            IF PEMSTATUS(loc_oPg2, "txt_4c_Pdes", 5)
                loc_oPg2.txt_4c_Pdes.Value = IIF(loc_nValmeta = 0, 0.00, ;
                    loc_nValcota / loc_nValmeta * 100)
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BOParaForm:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * RecalcularPdes - Recalcula percentual de desconto ao mudar valmeta/valcota
    * Legado: getpdes.Value = IIF(valmeta=0, 0.00, valcota/valmeta*100)
    * Chamado via BINDEVENT InteractiveChange de txt_4c_Valmeta e txt_4c_Valcota
    *==========================================================================
    PROCEDURE RecalcularPdes()
        LOCAL loc_oPg2, loc_nValmeta, loc_nValcota
        loc_nValmeta = 0
        loc_nValcota = 0

        IF !PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5)
            RETURN
        ENDIF

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF PEMSTATUS(loc_oPg2, "txt_4c_Valmeta", 5)
                loc_nValmeta = loc_oPg2.txt_4c_Valmeta.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Valcota", 5)
                loc_nValcota = loc_oPg2.txt_4c_Valcota.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Pdes", 5)
                loc_oPg2.txt_4c_Pdes.Value = IIF(loc_nValmeta = 0, 0.00, ;
                    loc_nValcota / loc_nValmeta * 100)
            ENDIF
        CATCH TO loException
            MsgErro("Erro em RecalcularPdes:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ImportaPlan - Importa planilha Excel com cotas de desconto
    * Legado: usa ImpExcelDriver (funcao do framework Fortyus)
    * Layout planilha: col1=empresa(N), col2=periodo YYMM(C), col3=cota(N)
    *==========================================================================
    PROTECTED FUNCTION ImportaPlan()
        LOCAL loc_lcArq, loc_lResultado, loc_lcEmp
        LOCAL loc_lcMes, loc_lnCota, loc_lcField
        LOCAL loc_lcAno, loc_lcMesNum, loc_ldIni, loc_ldFin
        loc_lResultado = .F.

        *-- GETFILE fora do TRY (dialogo nativo, sem risco de excecao VFP)
        loc_lcArq = GETFILE("xls*")

        IF EMPTY(loc_lcArq)
            RETURN .F.
        ENDIF

        TRY
            IF !ImpExcelDriver(loc_lcArq, "Cota Desconto")
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a planilha." + CHR(13) + ;
                    "Verifique se o arquivo e a aba 'Cota Desconto' est" + CHR(227) + "o corretos.", "Aviso")
                loc_lResultado = .F.
            ELSE
                IF !USED("xlResults")
                MsgAviso("Planilha vazia ou formato inv" + CHR(225) + "lido.", "Aviso")
                loc_lResultado = .F.
            ELSE
                SELECT xlResults
                GO TOP

                SCAN
                    *-- Coluna 1: empresa (numerico)
                    loc_lcField = FIELD(1)
                    loc_lcEmp = ALLTRIM(STR(IIF(INLIST(VARTYPE(&loc_lcField), "N"), &loc_lcField, 0)))

                    *-- Coluna 2: periodo YYMM (caracter, ex: "2601" = jan/2026)
                    loc_lcField = FIELD(2)
                    loc_lcMes = PADL(ALLTRIM(IIF(INLIST(VARTYPE(&loc_lcField), "C", "M"), &loc_lcField, "")), 6, "0")

                    *-- Coluna 3: valor da cota
                    loc_lcField = FIELD(3)
                    loc_lnCota = IIF(INLIST(VARTYPE(&loc_lcField), "N"), &loc_lcField, 0)

                    IF !EMPTY(loc_lcEmp) AND LEN(ALLTRIM(loc_lcMes)) >= 4
                        *-- Extrair ano (2 digitos) e mes dos 4 ultimos chars apos padding
                        loc_lcAno    = SUBSTR(loc_lcMes, 3, 2)
                        loc_lcMesNum = RIGHT(loc_lcMes, 2)

                        loc_ldIni = DATE(2000 + VAL(loc_lcAno), VAL(loc_lcMesNum), 1)
                        loc_ldFin = GOMONTH(loc_ldIni, 1) - 1

                        THIS.this_oBusinessObject.NovoRegistro()
                        THIS.this_oBusinessObject.this_cEmps    = loc_lcEmp
                        THIS.this_oBusinessObject.this_dDtini   = loc_ldIni
                        THIS.this_oBusinessObject.this_dDtfin   = loc_ldFin
                        THIS.this_oBusinessObject.this_nValmeta = 0
                        THIS.this_oBusinessObject.this_nValcota = loc_lnCota
                        THIS.this_oBusinessObject.Salvar()
                    ENDIF
                ENDSCAN

                IF USED("xlResults")
                    USE IN xlResults
                ENDIF

                loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ImportaPlan:" + CHR(13) + loException.Message, "Erro")
            IF USED("xlResults")
                USE IN xlResults
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE
