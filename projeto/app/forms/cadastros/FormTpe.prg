*==============================================================================
* FormTpe.prg - Formulario de Cadastro de Tipos de Etiquetas de Produto
* Migrado de: SigCdTpe.SCX (frmcadastro)
* Tabela: SigCdTpe / Chave: ntipos numeric(3,0)
*
* FASE 3/8 - Estrutura Base:
*   PageFrame (Page1=Lista / Page2=Dados) + containers principais vazios.
* FASE 4/8 - Form - Grid e Botoes CRUD (Page1):
*   cnt_4c_Botoes com 5 botoes CRUD (Incluir/Visualizar/Alterar/Excluir/Buscar)
*   + cnt_4c_Saida com cmd_4c_Encerrar (padrao canonico) + grd_4c_Lista (4
*   colunas: ntipos/cetiquetas/nsituas/cordems) + CarregarLista()/AlternarPagina()
*   (PUBLIC - CLAUDE.md #3: TesteAutomatico.prg chama direto de fora da classe).
* FASE 5/8 - Form - Campos Principais Page2 (Parte 1):
*   lbl_4c_Label1+txt_4c_NTipos (Tipo/ntipos), lbl_4c_Label2+txt_4c_CEtiquetas
*   (Descricao/cetiquetas), lbl_4c_Label22+obj_4c_Opt_nSituas (Situacao/nsituas).
*   Compensacao +29 (PageFrame.Top=-29) aplicada aos Tops originais do SCX.
* FASE 6/8 - Form - Campos Restantes e Lookups:
*   Ordem/EtiquetasEspeciais/Observacao (cobs/dobs) + lookup fwBuscaExt->SigCdObs
*   (ValidarCobs/AbrirLookupObs/CobsKeyPress) + validacao ValidarCOrdems.
* FASE 7/8 - Form - Eventos Principais:
*   BINDEVENT dos 4 botoes CRUD de cnt_4c_Botoes + BtnIncluirClick/
*   BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick (PUBLIC - CLAUDE.md #3) +
*   FormParaBO/BOParaForm/HabilitarCampos/LimparCampos como suporte completo
*   (nenhum metodo chamado fica sem implementacao - regra de completude).
* FASE 8/8 - Form - Eventos Auxiliares e Consolidacao Final:
*   BtnBuscarClick (FormBuscaAuxiliar sobre a propria SigCdTpe + LOCATE no
*   grid) + BtnEncerrarClick (THIS.Release()) + BtnSalvarClick (FormParaBO +
*   Salvar sem parametro) + BtnCancelarClick (volta para Lista) +
*   AjustarBotoesPorModo (Confirmar so habilitado em INCLUIR/ALTERAR) +
*   BINDEVENT dos botoes Buscar/Encerrar/Confirmar/Cancelar.
*==============================================================================

DEFINE CLASS FormTpe AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Tipos de Etiquetas de Produto"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject     = .NULL.
    this_cModoAtual          = "LISTA"
    this_nUltimoCobsValidado = 0

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("TpeBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar TpeBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormTpe.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormTpe:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormTpe.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; controles compensam +29 no Top
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaLista - Estrutura completa de Page1 (Lista)
    * Cabecalho (regra #11) + cnt_4c_Botoes (5 botoes CRUD) + cnt_4c_Saida
    * (cmd_4c_Encerrar canonico) + grd_4c_Lista (4 colunas). BINDEVENT dos
    * botoes fica para Fase 7-8, quando os metodos Btn*Click existirem.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado)
        *-- Original: Top=2 (default da classe). Com compensacao +29: Top=31
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
            .Left      = 10
            .Width     = 769
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
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container Botoes CRUD (Grupo_op no legado: Left=344, Top=-1, Width=385, Height=85)
        *-- Canonico: Left=542, Top=29 (-1+29 compensacao), Width=390, Height=85
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (legado Grupo_op.Inserir: Left=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Visualizar (legado Grupo_op.Consultar: Left=80)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Alterar (legado Grupo_op.Alterar: Left=155)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Excluir (legado Grupo_op.Excluir: Left=230)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Buscar (legado Grupo_op.procurar: Left=305)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- BINDEVENT dos 5 botoes CRUD principais + Encerrar
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10, prevalece sobre legado)
        *-- Legado: Grupo_Saida.Left=719, Top=-1 / Sair.Caption default. Canonico: Left=917, Width=90
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

        *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem (Grade no legado)
        *-- Legado: pColuna(ntipos,Tipo,50) + pColuna(cetiquetas,Descricao,280) +
        *--         pColuna(nsituas,Situacao,50) + pColuna(cordems,Ordem,50)
        *-- Posicao canonica (framework_frmcadastro_layout.md): Top=117, Left=26, Width=890
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
        loc_oPagina.grd_4c_Lista.ColumnCount = 4
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 498
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .GridLines          = 3
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH

        loc_oPagina.grd_4c_Lista.Column1.Width = 60
        loc_oPagina.grd_4c_Lista.Column1.Header1.Caption = "Tipo"
        loc_oPagina.grd_4c_Lista.Column2.Width = 550
        loc_oPagina.grd_4c_Lista.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        loc_oPagina.grd_4c_Lista.Column3.Width = 130
        loc_oPagina.grd_4c_Lista.Column3.Header1.Caption = "Situa" + CHR(231) + CHR(227) + "o"
        loc_oPagina.grd_4c_Lista.Column4.Width = 100
        loc_oPagina.grd_4c_Lista.Column4.Header1.Caption = "Ordem"

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Estrutura base de Page2 (Dados)
    * Cabecalho completo (regra #11 - faixa nas duas paginas) + container de
    * botoes de acao ainda VAZIO (Confirmar/Cancelar entram em fase posterior).
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza (identico ao da pagina Lista) - Erro152
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top           = 29
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Caption   = THIS.Caption
                .Top       = 15
                .Left      = 10
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

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
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
        ENDWITH

        *-- Container BotoesAcao (Grupo_Salva legado: Left=5, Top=194 [Page-relative],
        *-- efetivo com compensacao +29). Canonico usado nos demais forms CRUD: Top=33, Left=842
        *-- VAZIO nesta fase: botoes Confirmar/Cancelar entram em fase posterior (campos+eventos)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Label "Tipo :" (Say1 legado: Left=184, Top=109, ForeColor=0,0,0)
        *-- Compensacao PageFrame.Top=-29: 109+29=138
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Tipo :"
            .Left      = 184
            .Top       = 138
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .T.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox "Tipo" (Get_nTipos legado: ntipos numeric(3,0), InputMask="999",
        *-- MaxLength=3, Left=220, Top=106, Width=31; Height=23 como Get_EtqAtivas/Get_MaxEtqs)
        loc_oPagina.AddObject("txt_4c_NTipos", "TextBox")
        WITH loc_oPagina.txt_4c_NTipos
            .Left        = 220
            .Top         = 135
            .Width       = 31
            .Height      = 23
            .InputMask   = "999"
            .MaxLength   = 3
            .Value       = 0
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        *-- Label "Descricao :" (Say2 legado: Left=158, Top=133, ForeColor=0,0,0)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Left      = 158
            .Top       = 162
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .T.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox "Descricao" (Get_cEtiquetas legado: cetiquetas char(30),
        *-- Left=220, Top=131, Width=220; MaxLength=30 conforme schema)
        loc_oPagina.AddObject("txt_4c_CEtiquetas", "TextBox")
        WITH loc_oPagina.txt_4c_CEtiquetas
            .Left        = 220
            .Top         = 160
            .Width       = 220
            .Height      = 23
            .MaxLength   = 30
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        *-- Label "Situacao :" (Say22 legado: Left=163, Top=158, ForeColor=0,0,0)
        loc_oPagina.AddObject("lbl_4c_Label22", "Label")
        WITH loc_oPagina.lbl_4c_Label22
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
            .Left      = 163
            .Top       = 187
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .T.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup "Situacao" (Opt_nSituas legado: nsituas numeric(1,0),
        *-- ControlSource=crSigCdTpe.nSituas, Left=220, Top=156, Width=140, Height=20
        *-- Option1="Ativa" Value=0, Option2="Inativa" Value=1 - transcrito literal)
        loc_oPagina.AddObject("obj_4c_Opt_nSituas", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opt_nSituas
            .ButtonCount   = 2
            .Left          = 220
            .Top           = 185
            .Width         = 140
            .Height        = 20
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        WITH loc_oPagina.obj_4c_Opt_nSituas.Buttons(1)
            .Caption   = "\<Ativa"
            .Value     = 0
            .Left      = 5
            .Top       = 2
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        WITH loc_oPagina.obj_4c_Opt_nSituas.Buttons(2)
            .Caption   = "I\<nativa"
            .Value     = 1
            .Left      = 75
            .Top       = 2
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        *-- Label "Ordem :" (Say3 legado: Left=172, Top=182, ForeColor=0,0,0)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Ordem :"
            .Left      = 172
            .Top       = 211
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .T.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox "Ordem" (Get_cOrdems legado: cordems char(3), InputMask="999",
        *-- Left=220, Top=179, Width=31, MaxLength=3)
        loc_oPagina.AddObject("txt_4c_COrdems", "TextBox")
        WITH loc_oPagina.txt_4c_COrdems
            .Left        = 220
            .Top         = 208
            .Width       = 31
            .Height      = 23
            .InputMask   = "999"
            .MaxLength   = 3
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        *-- Label "Etiquetas Especiais :" (Say4 legado: Left=113, Top=210, ForeColor=0,0,0)
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Etiquetas Especiais :"
            .Left      = 113
            .Top       = 239
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .T.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- ComboBox "Etiquetas Especiais" (cmbetqesp legado: RowSourceType=1,
        *-- RowSource="NENHUMA,TAG MODELO 1", ControlSource=crSigCdTpe.tpespes
        *-- (numeric -> indice 1-based: 1=NENHUMA, 2=TAG MODELO 1),
        *-- Left=220, Top=207, Width=151, Height=24).
        *-- Default ListIndex=1 reproduz o legado: If IsEmpty(tpespes) ->
        *-- cmbetqesp.ListItemId = 1 (equivalente ao ListIndex no fwcombo).
        loc_oPagina.AddObject("cbo_4c_Cmbetqesp", "ComboBox")
        WITH loc_oPagina.cbo_4c_Cmbetqesp
            .Left          = 220
            .Top           = 236
            .Width         = 151
            .Height        = 24
            .Style         = 2
            .RowSourceType = 1
            .RowSource     = "NENHUMA,TAG MODELO 1"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH
        loc_oPagina.cbo_4c_Cmbetqesp.ListIndex = 1

        *-- Label "Observacao :" (Say5 legado: Left=146, Top=239, ForeColor=0,0,0)
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
            .Left      = 146
            .Top       = 268
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .T.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox "Cod. Observacao" (cobs legado: codobs numeric(3,0), InputMask="999",
        *-- Left=220, Top=236, Width=31, MaxLength=3). Lookup fwBuscaExt -> SigCdObs
        *-- (codigos/descrs), transcrito via ValidarCobs()/AbrirLookupObs().
        loc_oPagina.AddObject("txt_4c_Cobs", "TextBox")
        WITH loc_oPagina.txt_4c_Cobs
            .Left        = 220
            .Top         = 265
            .Width       = 31
            .Height      = 23
            .InputMask   = "999"
            .MaxLength   = 3
            .Value       = 0
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        *-- TextBox "Descricao Observacao" (dobs legado: apenas exibicao,
        *-- When retorna .F. - nunca recebe foco/edicao. Left=252, Top=236, Width=220)
        loc_oPagina.AddObject("txt_4c_Dobs", "TextBox")
        WITH loc_oPagina.txt_4c_Dobs
            .Left        = 252
            .Top         = 265
            .Width       = 220
            .Height      = 23
            .Value       = ""
            .ReadOnly    = .T.
            .TabStop     = .F.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        *-- BINDEVENT: Ordem - Valid legado: This.Value = PadL(AllTrim(This.Value), 3)
        BINDEVENT(loc_oPagina.txt_4c_COrdems, "KeyPress", THIS, "ValidarCOrdems")

        *-- BINDEVENT: Observacao - Valid legado abre fwBuscaExt automaticamente
        *-- ao sair do campo preenchido (nao ha F4 no legado, mas DblClick e F4
        *-- sao acrescentados como atalho adicional para o mesmo lookup).
        BINDEVENT(loc_oPagina.txt_4c_Cobs, "KeyPress", THIS, "ValidarCobs")
        BINDEVENT(loc_oPagina.txt_4c_Cobs, "KeyPress", THIS, "CobsKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Cobs, "DblClick", THIS, "AbrirLookupObs")

        *-- Container BotoesAcao - Confirmar/Cancelar (padrao canonico)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ValidarCOrdems - LostFocus de txt_4c_COrdems
    * Transcrito do legado (Get_cOrdems.Valid): This.Value = PadL(AllTrim(This.Value), 3)
    *===========================================================================
    PROCEDURE ValidarCOrdems(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oTxt
        loc_oTxt = THIS.pgf_4c_Paginas.Page2.txt_4c_COrdems

        IF !EMPTY(ALLTRIM(loc_oTxt.Value))
            loc_oTxt.Value = PADL(ALLTRIM(loc_oTxt.Value), 3)
        ENDIF
    ENDPROC

    *===========================================================================
    * CobsKeyPress - KeyPress de txt_4c_Cobs (F4 abre o lookup manualmente)
    * BINDEVENT exige LPARAMETERS com os parametros do evento (CLAUDE.md #3).
    *===========================================================================
    PROCEDURE CobsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupObs()
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarCobs - LostFocus de txt_4c_Cobs
    * Transcrito do legado (cobs.Valid): se o valor mudou e nao esta vazio,
    * abre fwBuscaExt (aqui: FormBuscaAuxiliar Modo 1) automaticamente.
    * Guarda contra reabertura em toda perda de foco sem mudanca (Problema 45).
    *===========================================================================
    PROCEDURE ValidarCobs(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_nValor

        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_nValor  = loc_oPagina.txt_4c_Cobs.Value

        IF loc_nValor == THIS.this_nUltimoCobsValidado
            RETURN
        ENDIF
        THIS.this_nUltimoCobsValidado = loc_nValor

        IF loc_nValor = 0
            loc_oPagina.txt_4c_Dobs.Value = ""
        ELSE
            THIS.AbrirLookupObs()
        ENDIF
    ENDPROC

    *===========================================================================
    * AbrirLookupObs - Lookup completo de Observacao (SigCdObs.codigos/descrs)
    * Transcrito do legado (cobs.Valid):
    *   xBrox = CreateObject('fwBuscaExt', poDataMgr.pnIdConn, 'SigCdObs',
    *       'crListaRemota', 'codigos', This.Value, 'Observacao', .T.)
    *   Se nao achou exato -> mostra grid; senao preenche direto.
    *   Se ESC (LastKey=27) -> limpa ambos os campos.
    *===========================================================================
    PROCEDURE AbrirLookupObs()
        LOCAL loc_oPagina, loc_oBusca, loc_nCodigo

        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_nCodigo = loc_oPagina.txt_4c_Cobs.Value

        IF loc_nCodigo = 0
            loc_oPagina.txt_4c_Dobs.Value = ""
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdObs", "cursor_4c_BuscaObs", "codigos", ;
            TRANSFORM(loc_nCodigo), "Observa" + CHR(231) + CHR(227) + "o")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaObs")
                loc_oPagina.txt_4c_Cobs.Value = cursor_4c_BuscaObs.codigos
                loc_oPagina.txt_4c_Dobs.Value = ALLTRIM(TratarNulo(cursor_4c_BuscaObs.descrs, "C"))
            ELSE
                loc_oPagina.txt_4c_Cobs.Value = 0
                loc_oPagina.txt_4c_Dobs.Value = ""
            ENDIF

            THIS.this_nUltimoCobsValidado = loc_oPagina.txt_4c_Cobs.Value

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaObs")
            USE IN cursor_4c_BuscaObs
        ENDIF
    ENDPROC

    *===========================================================================
    * LimparCampos - Restaura Page2 para os valores padrao de um novo registro
    * Transcrito do legado (padrao do Framework): nsituas=0 (Ativa), tpespes=
    * NENHUMA (ListIndex=1), demais campos vazios/zerados.
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_NTipos.Value        = 0
        loc_oPagina.txt_4c_CEtiquetas.Value    = ""
        loc_oPagina.obj_4c_Opt_nSituas.Value   = 0
        loc_oPagina.txt_4c_COrdems.Value       = ""
        loc_oPagina.cbo_4c_Cmbetqesp.ListIndex = 1
        loc_oPagina.txt_4c_Cobs.Value          = 0
        loc_oPagina.txt_4c_Dobs.Value          = ""

        THIS.this_nUltimoCobsValidado = 0
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores de Page2 para as propriedades this_* do BO
    * Chamado antes de THIS.this_oBusinessObject.Salvar() (Fase 8).
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_nTipos     = loc_oPagina.txt_4c_NTipos.Value
        THIS.this_oBusinessObject.this_cEtiquetas = ALLTRIM(loc_oPagina.txt_4c_CEtiquetas.Value)
        THIS.this_oBusinessObject.this_nSituas    = loc_oPagina.obj_4c_Opt_nSituas.Value
        THIS.this_oBusinessObject.this_cOrdems    = ALLTRIM(loc_oPagina.txt_4c_COrdems.Value)
        THIS.this_oBusinessObject.this_nTpEspes   = loc_oPagina.cbo_4c_Cmbetqesp.ListIndex
        THIS.this_oBusinessObject.this_nCodObs    = loc_oPagina.txt_4c_Cobs.Value
        THIS.this_oBusinessObject.this_nPadrao    = 0
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere as propriedades this_* do BO para os campos Page2
    * Chamado apos CarregarPorCodigo() (BtnAlterarClick/BtnVisualizarClick).
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_NTipos.Value      = THIS.this_oBusinessObject.this_nTipos
        loc_oPagina.txt_4c_CEtiquetas.Value  = THIS.this_oBusinessObject.this_cEtiquetas
        loc_oPagina.obj_4c_Opt_nSituas.Value = THIS.this_oBusinessObject.this_nSituas
        loc_oPagina.txt_4c_COrdems.Value     = THIS.this_oBusinessObject.this_cOrdems

        IF THIS.this_oBusinessObject.this_nTpEspes >= 1 AND THIS.this_oBusinessObject.this_nTpEspes <= 2
            loc_oPagina.cbo_4c_Cmbetqesp.ListIndex = THIS.this_oBusinessObject.this_nTpEspes
        ELSE
            loc_oPagina.cbo_4c_Cmbetqesp.ListIndex = 1
        ENDIF

        loc_oPagina.txt_4c_Cobs.Value = THIS.this_oBusinessObject.this_nCodObs
        THIS.this_nUltimoCobsValidado = THIS.this_oBusinessObject.this_nCodObs

        IF THIS.this_oBusinessObject.this_nCodObs > 0
            loc_oPagina.txt_4c_Dobs.Value = THIS.this_oBusinessObject.BuscarDescricaoObs(THIS.this_oBusinessObject.this_nCodObs)
        ELSE
            loc_oPagina.txt_4c_Dobs.Value = ""
        ENDIF
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita os campos de Page2 conforme o modo
    * Transcrito do legado: Get_nTipos.When = InList(pcEscolha,'INSERIR','PROCURAR')
    * (Tipo so editavel na INCLUSAO); Get_cEtiquetas.When = InList('INSERIR',
    * 'ALTERAR') (demais campos editaveis em INCLUIR/ALTERAR, bloqueados em
    * VISUALIZAR). cmd_4c_Confirmar acompanha o mesmo flag (nunca habilitado
    * em modo VISUALIZAR).
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lHabilitarCodigo

        loc_oPagina          = THIS.pgf_4c_Paginas.Page2
        loc_lHabilitarCodigo = par_lHabilitar AND THIS.this_cModoAtual == "INCLUIR"

        loc_oPagina.txt_4c_NTipos.Enabled      = loc_lHabilitarCodigo
        loc_oPagina.txt_4c_CEtiquetas.Enabled  = par_lHabilitar
        loc_oPagina.obj_4c_Opt_nSituas.Enabled = par_lHabilitar
        loc_oPagina.txt_4c_COrdems.Enabled     = par_lHabilitar
        loc_oPagina.cbo_4c_Cmbetqesp.Enabled   = par_lHabilitar
        loc_oPagina.txt_4c_Cobs.Enabled        = par_lHabilitar
        loc_oPagina.txt_4c_Dobs.Enabled        = .F.

        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Botao Incluir (Page1)
    * PUBLIC (CLAUDE.md regra #3): TesteAutomatico.prg chama direto de fora
    * da classe. Transcrito do legado (Grupo_op.Inserir -> pcEscolha='INSERIR'):
    * limpa campos, habilita edicao total e navega para Page2.
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.txt_4c_NTipos.SetFocus()
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Botao Alterar (Page1)
    * PUBLIC (CLAUDE.md regra #3). Le o registro selecionado no grid,
    * carrega do banco (CarregarPorCodigo), prepara o BO para UPDATE
    * (EditarRegistro) e navega para Page2 com os campos preenchidos.
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_nCodigo

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para alterar.")
        ELSE
            loc_nCodigo = cursor_4c_Dados.ntipos

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Botao Visualizar (Page1)
    * PUBLIC (CLAUDE.md regra #3). Transcrito do legado (Grupo_op.Consultar ->
    * pcEscolha='CONSULTAR'): carrega o registro, mostra Page2 somente leitura.
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_nCodigo

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para visualizar.")
        ELSE
            loc_nCodigo = cursor_4c_Dados.ntipos

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Botao Excluir (Page1)
    * PUBLIC (CLAUDE.md regra #3). Confirma com o usuario (MsgConfirma retorna
    * LOGICAL - regra #7), carrega o registro selecionado e delega a exclusao
    * ao BO (Excluir() PUBLIC, chama ExecutarExclusao() internamente - regra
    * do BusinessBase). Falha de gravacao ja eh reportada pelo BO (regra #20);
    * o ELSE aqui so cobre o caso de this_lErroExibido = .F.
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_nCodigo, loc_cEtiqueta

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para excluir.")
        ELSE
            loc_nCodigo   = cursor_4c_Dados.ntipos
            loc_cEtiqueta = ALLTRIM(TratarNulo(cursor_4c_Dados.cetiquetas, "C"))

            IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do Tipo de Etiqueta " + ;
                    ALLTRIM(TRANSFORM(loc_nCodigo)) + " - " + loc_cEtiqueta + "?", "Excluir")

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Confirmar")
                        THIS.CarregarLista()
                    ELSE
                        IF !THIS.this_oBusinessObject.this_lErroExibido
                            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o registro.", "Confirmar")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Botao Buscar (Page1)
    * PUBLIC (CLAUDE.md regra #3). Abre FormBuscaAuxiliar sobre a propria
    * tabela SigCdTpe (chave ntipos) e localiza o registro escolhido no grid.
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_nCodigo
        loc_nCodigo = 0

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdTpe", "cursor_4c_BuscaTpe", "ntipos", "", ;
                "Buscar Tipo de Etiqueta")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("ntipos", "", "Tipo")
                loc_oBusca.mAddColuna("cetiquetas", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpe")
                    SELECT cursor_4c_BuscaTpe
                    loc_nCodigo = cursor_4c_BuscaTpe.ntipos
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaTpe")
                USE IN cursor_4c_BuscaTpe
            ENDIF

            IF loc_nCodigo > 0 AND USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR ntipos = loc_nCodigo
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormTpe.BtnBuscarClick")
            IF USED("cursor_4c_BuscaTpe")
                USE IN cursor_4c_BuscaTpe
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario (cnt_4c_Saida.cmd_4c_Encerrar)
    * PUBLIC: BINDEVENT requer metodo publico (CLAUDE.md regra #3 / Problema 17)
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Confirma a gravacao de Page2 (Incluir/Alterar)
    * PUBLIC: BINDEVENT requer metodo publico. Salvar() SEM parametro - o BO
    * decide INSERT/UPDATE por this_lNovoRegistro (regra #4 do guia).
    * Falha de gravacao ja e reportada pelo BusinessBase (regra #20 CLAUDE.md).
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "Confirmar")
            THIS.AlternarPagina(1)
        ELSE
            IF !THIS.this_oBusinessObject.this_lErroExibido
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao/visualizacao e volta para a lista
    * PUBLIC: BINDEVENT requer metodo publico.
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta Confirmar/Cancelar conforme this_cModoAtual
    * Confirmar so fica habilitado em INCLUIR/ALTERAR (nunca em VISUALIZAR -
    * ver Problema 40/CLAUDE.md sobre cmd_4c_Confirmar.Enabled por modo).
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_lEditando
        loc_oPagina   = THIS.pgf_4c_Paginas.Page2
        loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
            ENDIF
            IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega dados no Grid da Page1
    * PUBLIC (CLAUDE.md regra #3): TesteAutomatico.prg chama este metodo direto
    * de fora da classe.
    * OBRIGATORIO: ControlSource e Header1.Caption redefinidos APOS RecordSource
    * (RecordSource reseta ambos - Problema 2/48 do guia de migracao).
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF !THIS.this_oBusinessObject.Buscar("")
                    loc_lResultado = .F.
                ELSE
                    *-- RecordSource reseta ControlSource/Headers - redefinir SEMPRE apos
                    loc_oGrid.RecordSource = ""
                    loc_oGrid.RecordSource = "cursor_4c_Dados"

                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.ntipos"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.cetiquetas"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.nsituas"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.cordems"

                    loc_oGrid.Column1.Width = 60
                    loc_oGrid.Column2.Width = 550
                    loc_oGrid.Column3.Width = 130
                    loc_oGrid.Column4.Width = 100

                    loc_oGrid.Column1.Header1.Caption = "Tipo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column3.Header1.Caption = "Situa" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column4.Header1.Caption = "Ordem"

                    *-- Transcrito do legado (SIGCDTPE.Init):
                    *-- .SetAll('DynamicForeColor','RGB(Iif(crSigCdTpe.nSituas # 1, 255, 0),0,0)','Column')
                    loc_oGrid.SetAll("DynamicForeColor", ;
                        "RGB(IIF(cursor_4c_Dados.nsituas # 1, 255, 0), 0, 0)", "Column")

                    THIS.FormatarGridLista(loc_oGrid)

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormTpe.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * PUBLIC (CLAUDE.md regra #3): TesteAutomatico.prg chama este metodo direto
    * de fora da classe.
    * Ao voltar para Page1, recarrega a lista.
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        ELSE
            MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid de lista (FontName/FontSize)
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
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

    *===========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
