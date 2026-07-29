*==============================================================================
* FormCNF.prg - Formulario de Correcao de Notas Fiscais
* Data: 2026-07-29
* Tabela principal: SigMvNfi (PK: cidchaves)
* Legado: SIGCDCNF.SCX (frmcadastro)
* Fase 3/8: Estrutura base - PageFrame, containers, botoes, navegacao
*==============================================================================

DEFINE CLASS FormCNF AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    *-- Original: width=781, height=622 -> novo padrao: 1000x600
    Height       = 600
    Width        = 1000
    AutoCenter   = .T.
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""
    this_cModoAtual      = "LISTA"

    *-- Estado dos filtros (replicando pSeries/pEmisDe/pEmisAte/pOpE/pOpS do legado)
    this_cEmps           = ""   && empresa corrente (go_4c_Sistema.cCodEmpresa)
    this_cSeriesFiltro   = ""   && serie selecionada no filtro
    this_dEmisDeFiltro   = {}   && data inicio do filtro de emissao
    this_dEmisAteFiltro  = {}   && data fim do filtro de emissao
    this_cOpeFiltro      = "A"  && A=Ambas E=Entrada S=Saida
    this_lCancelasFiltro = .F.  && .T. = exibir canceladas tambem

    *==========================================================================
    * Init - inicializacao padrao (FormBase.Init chama InicializarForm)
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - configuracao completa (chamada pelo FormBase.Init)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Corre" + CHR(231) + CHR(227) + "o de Notas Fiscais"

            THIS.this_oBusinessObject = CREATEOBJECT("CNFBO")

            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                THIS.this_cMensagemErro = "Erro ao criar CNFBO"
                MsgErro("Erro ao criar CNFBO", "Erro de inicializa" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- Inicializar empresa com empresa do sistema
                THIS.this_cEmps = ALLTRIM(go_4c_Sistema.cCodEmpresa)

                *-- Criar cursor placeholder para a grade (campo a campo - Fase 4 configura grid)
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados ( ;
                    cidchaves   C(20), ;
                    empdopnums  C(29), ;
                    emps        C(3),  ;
                    dopes       C(20), ;
                    numes       N(6,0), ;
                    nfis        C(6),  ;
                    series      C(8),  ;
                    especienfs  C(6),  ;
                    emis        T,     ;
                    dtsaidas    T,     ;
                    datans      T,     ;
                    operas      C(1),  ;
                    correcs     I,     ;
                    cancelas    I,     ;
                    regs        I,     ;
                    cfis        C(10), ;
                    clfis       C(12), ;
                    clifors     C(20), ;
                    cgcs        C(21), ;
                    totprods    N(14,2), ;
                    totnotas    N(14,2), ;
                    vals        N(14,2), ;
                    vlfretes    N(14,2), ;
                    vlseguros   N(14,2), ;
                    despaces    N(14,2), ;
                    codtrans    C(10), ;
                    fretes      N(1,0), ;
                    placas      C(8),  ;
                    ufplacas    C(2),  ;
                    rclis       C(40), ;
                    descricaos  C(60) ;
                )
                SET NULL OFF

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarBindings()

                *-- Propagar caption para label do cabecalho
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption

                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    IF !THIS.CarregarLista()
                        *-- falha nao impede abertura
                    ENDIF
                ENDIF

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"
                loc_lSucesso                   = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao inicializar FormCNF")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - PageFrame principal (Legado: SIGCDCNF.Pagina)
    * Legado: frmcadastro - PageCount=2, Top varia por heranca
    * Novo: Top=-29 (padrao framework), Width=1000
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = 1000
            .Height    = 629
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: cabecalho + filtros + botoes + grade
    * Legado: cntFiltros (empresa/serie/periodo/optFiltro) + InserirCarta +
    *         AlteraCarta + ImpCarta (top=85) + Grade
    * Compensacao PageFrame: +29 em Top
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho escuro com titulo (cntSombra do legado: Top=2 -> 31)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 17
            .Left      = 12
            .Width     = THIS.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 20
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Botoes de acao personalizados (InserirCarta/AlteraCarta/ImpCarta)
        *-- Legado: top=85 -> compensado=114, left=41/113/185 (esq. da pagina)
        *-- Novo: posicao relativa ao canvas - lado direito sobre o cabecalho
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 370
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_InserirCarta", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_InserirCarta
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
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

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_AlteraCarta", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_AlteraCarta
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 80
            .Top             = 5
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

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_ImpCarta", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_ImpCarta
            .Caption         = "Imprimir"
            .Picture         = gc_4c_CaminhoIcones + "relatorio_imprimir_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 155
            .Top             = 5
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

        *-- Container Saida/Encerrar - padrao canonico (Left=917, Width=90)
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
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
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

        *-- Container de filtros (cntFiltros do legado: top=164, height=48)
        loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
        WITH loc_oPagina.cnt_4c_Filtros
            .Top         = 116
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 48
            .BackStyle   = 1
            .BackColor   = RGB(210, 210, 210)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.ConfigurarFiltros(loc_oPagina)

        *-- Grade de notas fiscais (legado: Grade top=224 left=35 w=736 h=410)
        *-- Novo: top=166 (abaixo dos filtros), largura total, altura ate fundo da pagina
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista
        WITH loc_oGrid
            .Top          = 166
            .Left         = 0
            .Width        = THIS.Width
            .Height       = 461
            .ReadOnly     = .T.
            .ColumnCount  = 4
            .Visible      = .T.
        ENDWITH

        WITH loc_oGrid.Column1
            .ControlSource = "cursor_4c_Dados.nfis"
            .Width         = 70
            .Alignment     = 2
        ENDWITH
        loc_oGrid.Column1.Header1.Caption = "NF N" + CHR(176)

        WITH loc_oGrid.Column2
            .ControlSource = "cursor_4c_Dados.emis"
            .Width         = 95
            .Alignment     = 2
        ENDWITH
        loc_oGrid.Column2.Header1.Caption = "Emiss" + CHR(227) + "o"

        WITH loc_oGrid.Column3
            .ControlSource = "cursor_4c_Dados.totnotas"
            .Width         = 120
            .Alignment     = 2
        ENDWITH
        loc_oGrid.Column3.Header1.Caption = "Total NF"

        WITH loc_oGrid.Column4
            .ControlSource = "cursor_4c_Dados.rclis"
            .Width         = 715
            .Alignment     = 2
        ENDWITH
        loc_oGrid.Column4.Header1.Caption = "Cliente / Fornecedor"

        loc_oGrid.ColumnCount = 3
        loc_oGrid.RecordSource = "cursor_4c_Dados"

        *-- Redefinir ControlSource apos RecordSource (VFP faz auto-bind pela ordem dos campos)
        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.nfis"
        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.emis"
        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.totnotas"
        loc_oGrid.Column1.Header1.Caption = "NF N" + CHR(176)
        loc_oGrid.Column2.Header1.Caption = "Emiss" + CHR(227) + "o"
        loc_oGrid.Column3.Header1.Caption = "Total NF"

        *-- NFs com carta de correcao em vermelho (legado: DynamicForeColor em Grade)
        loc_oGrid.SetAll("DynamicForeColor", ;
            "IIF(cursor_4c_Dados.correcs > 0, RGB(255,0,0), RGB(0,0,0))", "Column")

        THIS.FormatarGridLista(loc_oGrid)

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: campos NF + aba Impostos/Servicos
    * Legado: Dados com Get_dope/Get_nume/Get_nota/etc + Pagina(Impostos+Servicos)
    * Compensacao PageFrame: +29 em Top
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oCab
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPagina.BackColor = RGB(255, 255, 255)

        *-- Container Salva: Confirmar + Cancelar (Grupo_Salva do legado: top=4 -> 33)
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 17
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

        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 80
            .Top             = 5
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

        *-- Container dos campos de cabecalho da NF (Pagina.Dados diretos)
        *-- Legado: campos Say1/Get_dope/etc original top=10-91 dentro de Pagina.Dados
        *-- Container em Page2: top=33 (=4+29), left=15
        *-- Campos internos: top = original_top - 4, left = original_left - 15
        loc_oPagina.AddObject("cnt_4c_DadosCab", "Container")
        loc_oCab = loc_oPagina.cnt_4c_DadosCab
        WITH loc_oCab
            .Top         = 33
            .Left        = 15
            .Width       = 820
            .Height      = 115
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Row 1 esq: Say1 "Operacao" (original top=14, left=72 -> cnt top=10, left=57)
        loc_oCab.AddObject("lbl_4c_SayOpe", "Label")
        WITH loc_oCab.lbl_4c_SayOpe
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o"
            .Top       = 10
            .Left      = 57
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Get_dope (original top=29, left=72, width=150 -> cnt top=25, left=57)
        loc_oCab.AddObject("txt_4c_Dope", "TextBox")
        WITH loc_oCab.txt_4c_Dope
            .Top       = 25
            .Left      = 57
            .Width     = 150
            .Height    = 21
            .MaxLength = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Row 1 dir: Say_Emissao "Data Emissao" (original top=10, left=455 -> cnt top=6, left=440)
        loc_oCab.AddObject("lbl_4c_SayEmissao", "Label")
        WITH loc_oCab.lbl_4c_SayEmissao
            .Caption   = "Data Emiss" + CHR(227) + "o"
            .Top       = 6
            .Left      = 440
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Get_Emissao (original top=25, left=455, width=80 -> cnt top=21, left=440)
        loc_oCab.AddObject("txt_4c_DtEmissao", "TextBox")
        WITH loc_oCab.txt_4c_DtEmissao
            .Top       = 21
            .Left      = 440
            .Width     = 80
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = {}
            .Visible   = .T.
        ENDWITH

        *-- Row 2 esq: Say2 "Numero" (original top=51, left=71 -> cnt top=47, left=56)
        loc_oCab.AddObject("lbl_4c_SayNum", "Label")
        WITH loc_oCab.lbl_4c_SayNum
            .Caption   = "N" + CHR(250) + "mero"
            .Top       = 47
            .Left      = 56
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Get_Numero (original top=66, left=71, width=52 -> cnt top=62, left=56)
        loc_oCab.AddObject("txt_4c_Numes", "TextBox")
        WITH loc_oCab.txt_4c_Numes
            .Top       = 62
            .Left      = 56
            .Width     = 52
            .Height    = 21
            .MaxLength = 8
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Say7 "Serie" (original top=51, left=143 -> cnt top=47, left=128)
        loc_oCab.AddObject("lbl_4c_SaySerie", "Label")
        WITH loc_oCab.lbl_4c_SaySerie
            .Caption   = "S" + CHR(233) + "rie"
            .Top       = 47
            .Left      = 128
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Get_Serie NF (original top=66, left=143, width=34 -> cnt top=62, left=128)
        *-- Atencao: diferente de txt_4c_Serie do filtro (Page1)
        loc_oCab.AddObject("txt_4c_NfSerie", "TextBox")
        WITH loc_oCab.txt_4c_NfSerie
            .Top       = 62
            .Left      = 128
            .Width     = 34
            .Height    = 21
            .MaxLength = 8
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Say4 "NF no" (original top=51, left=196 -> cnt top=47, left=181)
        loc_oCab.AddObject("lbl_4c_SayNfNum", "Label")
        WITH loc_oCab.lbl_4c_SayNfNum
            .Caption   = "NF n" + CHR(176)
            .Top       = 47
            .Left      = 181
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Get_nota (original top=66, left=196, width=52 -> cnt top=62, left=181)
        *-- Legado: When=InList(pcEscolha,'PROCURAR'); LostFocus=SetFocus Salva
        loc_oCab.AddObject("txt_4c_Nota", "TextBox")
        WITH loc_oCab.txt_4c_Nota
            .Top       = 62
            .Left      = 181
            .Width     = 52
            .Height    = 21
            .MaxLength = 6
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Say8 "Especie" (original top=51, left=257 -> cnt top=47, left=242)
        loc_oCab.AddObject("lbl_4c_SayEsp", "Label")
        WITH loc_oCab.lbl_4c_SayEsp
            .Caption   = "Esp" + CHR(233) + "cie"
            .Top       = 47
            .Left      = 242
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Get_Especie (original top=66, left=257, width=53 -> cnt top=62, left=242)
        loc_oCab.AddObject("txt_4c_Especie", "TextBox")
        WITH loc_oCab.txt_4c_Especie
            .Top       = 62
            .Left      = 242
            .Width     = 53
            .Height    = 21
            .MaxLength = 6
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Say6 "Data Saida" (original top=50, left=455 -> cnt top=46, left=440)
        loc_oCab.AddObject("lbl_4c_SaySaida", "Label")
        WITH loc_oCab.lbl_4c_SaySaida
            .Caption   = "Data Sa" + CHR(237) + "da"
            .Top       = 46
            .Left      = 440
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Get_Saidas (original top=65, left=455, width=80 -> cnt top=61, left=440)
        loc_oCab.AddObject("txt_4c_DtSaidas", "TextBox")
        WITH loc_oCab.txt_4c_DtSaidas
            .Top       = 61
            .Left      = 440
            .Width     = 80
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = {}
            .Visible   = .T.
        ENDWITH

        *-- Row 3: Say5 "CFOP :" (original top=95, left=27 -> cnt top=91, left=12)
        loc_oCab.AddObject("lbl_4c_SayCfop", "Label")
        WITH loc_oCab.lbl_4c_SayCfop
            .Caption   = "CFOP :"
            .Top       = 91
            .Left      = 12
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Get_ClFiscal (original top=91, left=71, width=63 -> cnt top=87, left=56)
        loc_oCab.AddObject("txt_4c_ClFiscal", "TextBox")
        WITH loc_oCab.txt_4c_ClFiscal
            .Top       = 87
            .Left      = 56
            .Width     = 63
            .Height    = 21
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Get_DClFiscal (original top=91, left=136, width=407 -> cnt top=87, left=121)
        loc_oCab.AddObject("txt_4c_DClFiscal", "TextBox")
        WITH loc_oCab.txt_4c_DClFiscal
            .Top       = 87
            .Left      = 121
            .Width     = 407
            .Height    = 21
            .MaxLength = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- PageFrame interno (SIGCDCNF.Pagina.Dados.Pagina)
        *-- Legado: top=123, left=15, width=739, height=459, PageCount=2
        *-- Compensacao PageFrame outer (-29 +29 = 0 neste nivel), so top=123+29=152
        loc_oPagina.AddObject("pgf_4c_InnerPage", "PageFrame")
        loc_oPagina.pgf_4c_InnerPage.Top       = 152
        loc_oPagina.pgf_4c_InnerPage.Left      = 15
        loc_oPagina.pgf_4c_InnerPage.Width     = 970
        loc_oPagina.pgf_4c_InnerPage.Height    = 447
        loc_oPagina.pgf_4c_InnerPage.PageCount = 2
        loc_oPagina.pgf_4c_InnerPage.Tabs      = .T.
        loc_oPagina.pgf_4c_InnerPage.Visible   = .T.

        WITH loc_oPagina.pgf_4c_InnerPage
            .Page1.Caption   = "Impostos"
            .Page1.BackColor = RGB(255, 255, 255)
            .Page2.Caption   = "Servi" + CHR(231) + "os"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarAbaImpostos()
        THIS.ConfigurarAbaServicos()
        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarBindings - BINDEVENTs dos botoes e grade
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBindings()
        LOCAL loc_oPg1, loc_oPg2
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Encerrar (Page1)
        BINDEVENT(loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Acoes personalizadas (Page1)
        BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_InserirCarta, "Click", THIS, "BtnInserirCartaClick")
        BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_AlteraCarta,  "Click", THIS, "BtnAlteraCartaClick")
        BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_ImpCarta,     "Click", THIS, "BtnImpCartaClick")

        *-- Grade: selecao de linha atualiza estado dos botoes
        BINDEVENT(loc_oPg1.grd_4c_Lista, "AfterRowColChange", THIS, "GrdListaAfterRowColChange")

        *-- Filtros (Page1)
        LOCAL loc_oCnt
        loc_oCnt = loc_oPg1.cnt_4c_Filtros
        BINDEVENT(loc_oCnt.txt_4c_Emp,    "KeyPress",         THIS, "ValidarEmpresa")
        BINDEVENT(loc_oCnt.txt_4c_Serie,  "KeyPress",         THIS, "ValidarSerie")
        BINDEVENT(loc_oCnt.txt_4c_DtIni,  "KeyPress",         THIS, "ValidarDtIni")
        BINDEVENT(loc_oCnt.txt_4c_DtFim,  "KeyPress",         THIS, "ValidarDtFim")
        BINDEVENT(loc_oCnt.txt_4c_DtFim,  "When",              THIS, "DtFimWhenCheck")
        BINDEVENT(loc_oCnt.opt_4c_Filtro, "InteractiveChange", THIS, "FiltroChanged")

        *-- Salvar/Cancelar (Page2)
        BINDEVENT(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- NF numero: LostFocus move foco para Confirmar (legado: Get_nota.LostFocus -> Salva.SetFocus)
        BINDEVENT(loc_oPg2.cnt_4c_DadosCab.txt_4c_Nota, "KeyPress", THIS, "NotaLostFocus")

        *-- Botao Dados na aba Impostos (abre SigMvExp)
        LOCAL loc_oAbaImp
        loc_oAbaImp = THIS.pgf_4c_Paginas.Page2.pgf_4c_InnerPage.Page1
        BINDEVENT(loc_oAbaImp.cmd_4c_Dados, "Click", THIS, "BtnDadosClick")
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega lista de NFs segundo filtros atuais
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                *-- Repassar filtros para o BO antes de chamar Buscar
                THIS.this_oBusinessObject.this_cEmps           = THIS.this_cEmps
                THIS.this_oBusinessObject.this_cSeriesFiltro   = THIS.this_cSeriesFiltro
                THIS.this_oBusinessObject.this_tEmisDeFiltro   = THIS.this_dEmisDeFiltro
                THIS.this_oBusinessObject.this_tEmisAteFiltro  = THIS.this_dEmisAteFiltro
                THIS.this_oBusinessObject.this_cOpeFiltro      = THIS.this_cOpeFiltro
                THIS.this_oBusinessObject.this_lCancelasFiltro = THIS.this_lCancelasFiltro
                THIS.this_oBusinessObject.this_cNfisDeFiltro   = ""
                THIS.this_oBusinessObject.this_cNfisAteFiltro  = ""

                *-- Buscar requer empresa e serie preenchidos para consultar
                IF !EMPTY(ALLTRIM(THIS.this_cEmps)) AND !EMPTY(ALLTRIM(THIS.this_cSeriesFiltro))
                    IF THIS.this_oBusinessObject.Buscar("")
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 3
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.nfis"
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.emis"
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column3.ControlSource = "cursor_4c_Dados.totnotas"
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
                        loc_lResultado = .T.
                    ELSE
                        loc_lResultado = .F.
                    ENDIF
                ELSE
                    *-- Sem filtros suficientes: lista permanece vazia (nao e erro)
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar lista de NFs")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Navega entre Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) # "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarLista()
                ENDIF
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao alternar p" + CHR(225) + "gina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * GrdListaAfterRowColChange - Habilita/desabilita botoes conforme linha selecionada
    * (BINDEVENT AfterRowColChange exige LPARAMETERS com par_nColIndex)
    *==========================================================================
    PROCEDURE GrdListaAfterRowColChange(par_nColIndex)
        LOCAL loc_lTemCarta
        loc_lTemCarta = .F.

        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_lTemCarta = (NVL(cursor_4c_Dados.correcs, 0) > 0)
            ENDIF

            WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
                .cmd_4c_AlteraCarta.Enabled = loc_lTemCarta
                .cmd_4c_ImpCarta.Enabled    = loc_lTemCarta
                .Visible     = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar bot" + CHR(245) + "es")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnInserirCartaClick - Inserir nova carta de correcao para NF selecionada
    *==========================================================================
    PROCEDURE BtnInserirCartaClick()
        LOCAL loc_lResultado, loc_lProsseguir
        loc_lResultado  = .F.
        loc_lProsseguir = .T.

        TRY
            IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
                   EOF("cursor_4c_Dados")
                    MsgAviso("Selecione uma Nota Fiscal na lista.", ;
                        "Inser" + CHR(231) + CHR(227) + "o de Carta")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    SELECT cursor_4c_Dados
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(cursor_4c_Dados.cidchaves))
                        THIS.this_oBusinessObject.NovoRegistro()
                        THIS.this_cModoAtual = "INCLUIR"
                        THIS.BOParaForm()
                        THIS.HabilitarCampos(.T.)
                    ELSE
                        MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                            "Erro ao carregar NF")
                        loc_lProsseguir = .F.
                    ENDIF
                ELSE
                    THIS.this_cModoAtual = "INCLUIR"
                ENDIF
            ENDIF

            IF loc_lProsseguir
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir carta")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnAlteraCartaClick - Alterar carta de correcao existente
    *==========================================================================
    PROCEDURE BtnAlteraCartaClick()
        LOCAL loc_lResultado, loc_lProsseguir
        loc_lResultado  = .F.
        loc_lProsseguir = .T.

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
               EOF("cursor_4c_Dados")
                MsgAviso("Selecione uma Nota Fiscal na lista.", ;
                    "Altera" + CHR(231) + CHR(227) + "o de Carta")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT cursor_4c_Dados
                IF NVL(cursor_4c_Dados.correcs, 0) = 0
                    MsgAviso("A nota selecionada n" + CHR(227) + "o possui carta de corre" + ;
                        CHR(231) + CHR(227) + "o para alterar.", "Aviso")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(cursor_4c_Dados.cidchaves))
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.T.)
                    THIS.AlternarPagina(2)
                    loc_lResultado = .T.
                ELSE
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                        "Erro ao carregar NF")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao alterar carta")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnImpCartaClick - Imprimir carta de correcao (handler Fase 7)
    * Logica: DO FORM SigCnFCrt (legado) com parametros da NF selecionada
    *==========================================================================
    PROCEDURE BtnImpCartaClick()
        LOCAL loc_lResultado, loc_cCidchaves, loc_cEdns, loc_cSerie
        LOCAL loc_dEmisDe, loc_dEmisAte
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
           EOF("cursor_4c_Dados")
            MsgAviso("Selecione uma Nota Fiscal na lista.", ;
                "Impress" + CHR(227) + "o de Carta")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados

        IF NVL(cursor_4c_Dados.correcs, 0) = 0
            MsgAviso("A nota selecionada n" + CHR(227) + "o possui carta de corre" + ;
                CHR(231) + CHR(227) + "o para imprimir.", "Aviso")
            RETURN .F.
        ENDIF

        TRY
            loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
            loc_cEdns      = ALLTRIM(cursor_4c_Dados.empdopnums)
            loc_cSerie     = ALLTRIM(THIS.this_cSeriesFiltro)
            loc_dEmisDe    = THIS.this_dEmisDeFiltro
            loc_dEmisAte   = THIS.this_dEmisAteFiltro

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
                *-- Impressao via helper do BO (metodo ImprimirCarta adicionado na Fase 7)
                loc_lResultado = THIS.this_oBusinessObject.ImprimirCarta( ;
                    loc_cEdns, loc_cSerie, loc_dEmisDe, loc_dEmisAte)
            ELSE
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                    "Erro ao carregar NF")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao imprimir carta")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - Salvar dados da carta de correcao
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Carta de corre" + CHR(231) + CHR(227) + "o salva com sucesso!", "Sucesso")
                THIS.this_cModoAtual = "LISTA"
                THIS.HabilitarCampos(.F.)
                THIS.AlternarPagina(1)
                loc_lResultado = .T.
            ELSE
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                    "Erro ao salvar carta")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao confirmar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancelar edicao e voltar para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.HabilitarCampos(.F.)
        *-- Re-habilitar Confirmar (pode ter sido desabilitado em modo VISUALIZAR)
        THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = .T.
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * NotaLostFocus - Ao sair do campo NF num, move foco para Confirmar
    * Legado: Get_nota.LostFocus = Grupo_Salva.Salva.SetFocus
    *==========================================================================
    PROCEDURE NotaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        TRY
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao mover foco")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores do form para as propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lResultado, loc_oCab
        loc_lResultado = .F.

        TRY
            loc_oCab = THIS.pgf_4c_Paginas.Page2.cnt_4c_DadosCab

            THIS.this_oBusinessObject.this_cEmps       = THIS.this_cEmps

            *-- Campos display-only do cabecalho (readonly; valores carregados via BOParaForm)
            *-- txt_4c_Nota (nfis) pode ser modificado em modo PROCURAR, mas em INCLUIR/ALTERAR
            *-- a NF ja vem carregada; repassar o valor atual para garantir consistencia
            THIS.this_oBusinessObject.this_cNfis       = ALLTRIM(loc_oCab.txt_4c_Nota.Value)

            *-- Data de saida pode ser ajustada pelo usuario no fluxo de correcao
            IF !EMPTY(loc_oCab.txt_4c_DtSaidas.Value)
                THIS.this_oBusinessObject.this_tDtsaidas = DATETIME( ;
                    YEAR(loc_oCab.txt_4c_DtSaidas.Value), ;
                    MONTH(loc_oCab.txt_4c_DtSaidas.Value), ;
                    DAY(loc_oCab.txt_4c_DtSaidas.Value))
            ELSE
                THIS.this_oBusinessObject.this_tDtsaidas = {}
            ENDIF

            *-- CFOP: readonly no formulario; BO ja tem o valor correto do load
            THIS.this_oBusinessObject.this_cCfis       = ALLTRIM(loc_oCab.txt_4c_ClFiscal.Value)
            THIS.this_oBusinessObject.this_cDescricaos = ALLTRIM(loc_oCab.txt_4c_DClFiscal.Value)

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em FormParaBO")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere propriedades do BO para os campos do form
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lResultado, loc_oCab, loc_oBO, loc_tEmis, loc_tSaida
        loc_lResultado = .F.

        TRY
            loc_oCab = THIS.pgf_4c_Paginas.Page2.cnt_4c_DadosCab
            loc_oBO  = THIS.this_oBusinessObject

            *-- Operacao
            loc_oCab.txt_4c_Dope.Value     = ALLTRIM(loc_oBO.this_cDopes)

            *-- Data Emissao (DateTime -> Date)
            loc_tEmis = loc_oBO.this_tEmis
            IF !EMPTY(loc_tEmis)
                loc_oCab.txt_4c_DtEmissao.Value = DATE(YEAR(loc_tEmis), MONTH(loc_tEmis), DAY(loc_tEmis))
            ELSE
                loc_oCab.txt_4c_DtEmissao.Value = {}
            ENDIF

            *-- Numero, Serie, NF num, Especie
            loc_oCab.txt_4c_Numes.Value    = TRANSFORM(loc_oBO.this_nNumes)
            loc_oCab.txt_4c_NfSerie.Value  = ALLTRIM(loc_oBO.this_cSeries)
            loc_oCab.txt_4c_Nota.Value     = ALLTRIM(loc_oBO.this_cNfis)
            loc_oCab.txt_4c_Especie.Value  = ALLTRIM(loc_oBO.this_cEspecienfs)

            *-- Data Saida (DateTime -> Date)
            loc_tSaida = loc_oBO.this_tDtsaidas
            IF !EMPTY(loc_tSaida)
                loc_oCab.txt_4c_DtSaidas.Value = DATE(YEAR(loc_tSaida), MONTH(loc_tSaida), DAY(loc_tSaida))
            ELSE
                loc_oCab.txt_4c_DtSaidas.Value = {}
            ENDIF

            *-- CFOP e descricao
            loc_oCab.txt_4c_ClFiscal.Value  = ALLTRIM(loc_oBO.this_cCfis)
            loc_oCab.txt_4c_DClFiscal.Value = ALLTRIM(loc_oBO.this_cDescricaos)

            *-- *** Aba Impostos ***
            LOCAL loc_oImp
            loc_oImp = THIS.pgf_4c_Paginas.Page2.pgf_4c_InnerPage.Page1
            loc_oImp.txt_4c_BaseIPI.Value    = loc_oBO.this_nBasecipis
            loc_oImp.txt_4c_ValorIPI.Value   = loc_oBO.this_nValipis
            loc_oImp.txt_4c_BaseICMS.Value   = loc_oBO.this_nBasecicms
            loc_oImp.txt_4c_PercICMS.Value   = loc_oBO.this_nIcms
            loc_oImp.txt_4c_ValorICMS.Value  = loc_oBO.this_nValicms
            loc_oImp.txt_4c_TotalProds.Value = loc_oBO.this_nTotProds
            loc_oImp.txt_4c_TotalNf.Value    = loc_oBO.this_nTotNotas
            loc_oImp.txt_4c_TFrete.Value     = loc_oBO.this_nVlFretes
            loc_oImp.txt_4c_TSeguros.Value   = loc_oBO.this_nVlSeguros
            loc_oImp.txt_4c_DespAces.Value   = loc_oBO.this_nDespAces
            loc_oImp.txt_4c_CodTransp.Value  = ALLTRIM(loc_oBO.this_cCodtrans)
            loc_oImp.txt_4c_TranspNome.Value = ALLTRIM(loc_oBO.this_cTranspNome)
            loc_oImp.txt_4c_TranspEnde.Value = ALLTRIM(loc_oBO.this_cTranspEnde)
            loc_oImp.txt_4c_TranspCida.Value = ALLTRIM(loc_oBO.this_cTranspCida)
            loc_oImp.txt_4c_TranspEsta.Value = ALLTRIM(loc_oBO.this_cTranspEsta)
            loc_oImp.txt_4c_Placa.Value      = ALLTRIM(loc_oBO.this_cPlacas)
            loc_oImp.txt_4c_UfPlaca.Value    = ALLTRIM(loc_oBO.this_cUfPlacas)
            DO CASE
            CASE loc_oBO.this_nFretes = 0
                loc_oImp.txt_4c_TipoFrete.Value = "0 - Emitente"
            CASE loc_oBO.this_nFretes = 1
                loc_oImp.txt_4c_TipoFrete.Value = "1 - Destinat" + CHR(225) + "rio"
            OTHERWISE
                loc_oImp.txt_4c_TipoFrete.Value = TRANSFORM(loc_oBO.this_nFretes)
            ENDCASE
            loc_oImp.txt_4c_Qtdes.Value      = loc_oBO.this_nQtdes
            loc_oImp.txt_4c_EspeVol.Value    = ALLTRIM(loc_oBO.this_cEspes)
            loc_oImp.txt_4c_Marcas.Value     = ALLTRIM(loc_oBO.this_cMarcas)
            loc_oImp.txt_4c_NumerosVol.Value = ALLTRIM(loc_oBO.this_cNumeros)
            loc_oImp.txt_4c_PesoLiq.Value    = loc_oBO.this_nPliqs
            loc_oImp.txt_4c_PesoBruto.Value  = loc_oBO.this_nPbrus

            *-- *** Aba Servicos ***
            LOCAL loc_oSer
            loc_oSer = THIS.pgf_4c_Paginas.Page2.pgf_4c_InnerPage.Page2
            loc_oSer.edt_4c_DescSer.Value  = ALLTRIM(loc_oBO.this_cDescsers)
            loc_oSer.txt_4c_Vtotsers.Value = loc_oBO.this_nVtotsers
            loc_oSer.txt_4c_Perciss.Value  = loc_oBO.this_nPerciss
            loc_oSer.txt_4c_Vtotiss.Value  = loc_oBO.this_nVtotiss

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BOParaForm")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita controles para edicao
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg1, loc_lAtivo
        loc_oPg1  = THIS.pgf_4c_Paginas.Page1
        loc_lAtivo = !par_lHabilitar

        *-- Botoes de acao e encerrar ficam bloqueados durante edicao na Page2
        loc_oPg1.cnt_4c_Botoes.cmd_4c_InserirCarta.Enabled = loc_lAtivo
        loc_oPg1.cnt_4c_Botoes.cmd_4c_AlteraCarta.Enabled  = loc_lAtivo
        loc_oPg1.cnt_4c_Botoes.cmd_4c_ImpCarta.Enabled     = loc_lAtivo
        loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled      = loc_lAtivo
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos do cabecalho da NF
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oCab
        TRY
            loc_oCab = THIS.pgf_4c_Paginas.Page2.cnt_4c_DadosCab
            loc_oCab.txt_4c_Dope.Value      = ""
            loc_oCab.txt_4c_DtEmissao.Value = {}
            loc_oCab.txt_4c_Numes.Value     = ""
            loc_oCab.txt_4c_NfSerie.Value   = ""
            loc_oCab.txt_4c_Nota.Value      = ""
            loc_oCab.txt_4c_Especie.Value   = ""
            loc_oCab.txt_4c_DtSaidas.Value  = {}
            loc_oCab.txt_4c_ClFiscal.Value  = ""
            loc_oCab.txt_4c_DClFiscal.Value = ""

            *-- Aba Impostos
            LOCAL loc_oImpL
            loc_oImpL = THIS.pgf_4c_Paginas.Page2.pgf_4c_InnerPage.Page1
            loc_oImpL.txt_4c_BaseIPI.Value    = 0
            loc_oImpL.txt_4c_ValorIPI.Value   = 0
            loc_oImpL.txt_4c_BaseICMS.Value   = 0
            loc_oImpL.txt_4c_PercICMS.Value   = 0
            loc_oImpL.txt_4c_ValorICMS.Value  = 0
            loc_oImpL.txt_4c_TotalProds.Value = 0
            loc_oImpL.txt_4c_TotalNf.Value    = 0
            loc_oImpL.txt_4c_TFrete.Value     = 0
            loc_oImpL.txt_4c_TSeguros.Value   = 0
            loc_oImpL.txt_4c_DespAces.Value   = 0
            loc_oImpL.txt_4c_CodTransp.Value  = ""
            loc_oImpL.txt_4c_TranspNome.Value = ""
            loc_oImpL.txt_4c_TranspEnde.Value = ""
            loc_oImpL.txt_4c_TranspCida.Value = ""
            loc_oImpL.txt_4c_TranspEsta.Value = ""
            loc_oImpL.txt_4c_Placa.Value      = ""
            loc_oImpL.txt_4c_UfPlaca.Value    = ""
            loc_oImpL.txt_4c_TipoFrete.Value  = ""
            loc_oImpL.txt_4c_Qtdes.Value      = 0
            loc_oImpL.txt_4c_EspeVol.Value    = ""
            loc_oImpL.txt_4c_Marcas.Value     = ""
            loc_oImpL.txt_4c_NumerosVol.Value = ""
            loc_oImpL.txt_4c_PesoLiq.Value    = 0
            loc_oImpL.txt_4c_PesoBruto.Value  = 0

            *-- Aba Servicos
            LOCAL loc_oSerL
            loc_oSerL = THIS.pgf_4c_Paginas.Page2.pgf_4c_InnerPage.Page2
            loc_oSerL.edt_4c_DescSer.Value  = ""
            loc_oSerL.txt_4c_Vtotsers.Value = 0
            loc_oSerL.txt_4c_Perciss.Value  = 0
            loc_oSerL.txt_4c_Vtotiss.Value  = 0

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao limpar campos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
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
            .FontName = "Verdana"
            .FontSize = 8
            .ForeColor         = RGB(90, 90, 90)
            .BackColor         = RGB(255, 255, 255)
            .GridLineColor     = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle    = 2
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 16
            .ScrollBars        = 2
            .GridLines         = 3
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarFiltros - Popula cnt_4c_Filtros com controles de filtro
    * Legado: GetEmp / Get_Serie / DtIni / DtFim / optFiltro
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltros(par_oPagina)
        LOCAL loc_oCnt
        loc_oCnt = par_oPagina.cnt_4c_Filtros

        *-- Label: Empresa (Label2: top=19, left=16, width=57)
        loc_oCnt.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oCnt.lbl_4c_Empresa
            .Caption   = "Empresa :"
            .Top       = 14
            .Left      = 16
            .Width     = 57
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
            .Visible   = .T.
        ENDWITH

        *-- TextBox: Empresa (GetEmp: top=16, left=84, width=31, height=23)
        loc_oCnt.AddObject("txt_4c_Emp", "TextBox")
        WITH loc_oCnt.txt_4c_Emp
            .Top       = 12
            .Left      = 84
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ALLTRIM(THIS.this_cEmps)
            .Visible   = .T.
        ENDWITH

        *-- Label: No. Serie (Say1: top=19, left=138)
        loc_oCnt.AddObject("lbl_4c_Serie", "Label")
        WITH loc_oCnt.lbl_4c_Serie
            .Caption   = "No. S" + CHR(233) + "rie : "
            .Top       = 14
            .Left      = 138
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox: Serie (Get_Serie: top=16, left=208, width=36, height=23)
        loc_oCnt.AddObject("txt_4c_Serie", "TextBox")
        WITH loc_oCnt.txt_4c_Serie
            .Top       = 12
            .Left      = 208
            .Width     = 36
            .Height    = 23
            .MaxLength = 8
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Label: Periodo (Say2: top=19, left=276)
        loc_oCnt.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oCnt.lbl_4c_Periodo
            .Caption   = "Per" + CHR(237) + "odo : "
            .Top       = 14
            .Left      = 276
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox: Data Inicial (DtIni: top=16, left=338, width=80, height=23)
        loc_oCnt.AddObject("txt_4c_DtIni", "TextBox")
        WITH loc_oCnt.txt_4c_DtIni
            .Top       = 12
            .Left      = 338
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = {}
            .Visible   = .T.
        ENDWITH

        *-- Label: separador "a" entre datas (Say3: top=19, left=424, caption="?"/CHR(224))
        loc_oCnt.AddObject("lbl_4c_Sep", "Label")
        WITH loc_oCnt.lbl_4c_Sep
            .Caption   = CHR(224)
            .Top       = 14
            .Left      = 424
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox: Data Final (DtFim: top=16, left=438, width=80, height=23)
        loc_oCnt.AddObject("txt_4c_DtFim", "TextBox")
        WITH loc_oCnt.txt_4c_DtFim
            .Top       = 12
            .Left      = 438
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = {}
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup: Filtro (optFiltro: top=14, left=538, w=183, h=25, buttonCount=3)
        *-- Value=1=Entrada, Value=2=Saida, Value=3=Ambas (default)
        loc_oCnt.AddObject("opt_4c_Filtro", "OptionGroup")
        WITH loc_oCnt.opt_4c_Filtro
            .ButtonCount = 3
            .Top         = 10
            .Left        = 538
            .Width       = 206
            .Height      = 26
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oCnt.opt_4c_Filtro.Buttons(1)
            .Caption   = "Entrada"
            .BackStyle = 0
            .Left      = 5
            .Top       = 4
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(53, 53, 53)
            .Themes    = .F.
        ENDWITH
        WITH loc_oCnt.opt_4c_Filtro.Buttons(2)
            .Caption   = "Sa" + CHR(237) + "da"
            .BackStyle = 0
            .Left      = 74
            .Top       = 4
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(53, 53, 53)
            .Themes    = .F.
        ENDWITH
        WITH loc_oCnt.opt_4c_Filtro.Buttons(3)
            .Caption   = "Ambas"
            .BackStyle = 0
            .Left      = 140
            .Top       = 4
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(53, 53, 53)
            .Themes    = .F.
        ENDWITH
        *-- Default: Ambas (pOpE=[E], pOpS=[S] = comportamento padrao do legado)
        loc_oCnt.opt_4c_Filtro.Value = 3
    ENDPROC

    *==========================================================================
    * ValidarEmpresa - LostFocus de txt_4c_Emp: valida empresa em SigCdEmp
    * Legado: GetEmp.Valid usa fAcessoEmpresa() (nao portada -> substituida)
    *==========================================================================
    PROCEDURE ValidarEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_cEmps, loc_cSQL, loc_nResult
        loc_oCnt  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros
        loc_cEmps = ALLTRIM(loc_oCnt.txt_4c_Emp.Value)

        IF EMPTY(loc_cEmps)
            MsgAviso("Preenchimento Obrigat" + CHR(243) + "rio!!!", "Empresa")
            loc_oCnt.txt_4c_Emp.SetFocus()
            RETURN
        ENDIF

        TRY
            loc_cSQL    = "SELECT CEmps, Razas FROM SigCdEmp WHERE CEmps = " + ;
                EscaparSQL(loc_cEmps)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaEmp") > 0
                THIS.this_cEmps = loc_cEmps
            ELSE
                MsgAviso("Empresa n" + CHR(227) + "o encontrada: " + loc_cEmps, ;
                    "Empresa")
                loc_oCnt.txt_4c_Emp.Value = THIS.this_cEmps
            ENDIF

            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar empresa")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarSerie - LostFocus de txt_4c_Serie: valida em SigCdSer
    * Legado: Get_Serie.Valid usa fwBuscaInt sobre cursor crSigCdSer
    *==========================================================================
    PROCEDURE ValidarSerie(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_cSerie, loc_cSQL, loc_nResult, loc_lEncontrou
        loc_oCnt      = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros
        loc_cSerie    = ALLTRIM(loc_oCnt.txt_4c_Serie.Value)
        loc_lEncontrou = .F.

        IF EMPTY(loc_cSerie)
            THIS.this_cSeriesFiltro = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL    = "SELECT DISTINCT Cods, Descs FROM SigCdSer ORDER BY Cods"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaSer")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaSer") > 0
                SELECT cursor_4c_BuscaSer
                GO TOP
                LOCATE FOR UPPER(ALLTRIM(cursor_4c_BuscaSer.Cods)) == UPPER(loc_cSerie)

                IF FOUND()
                    THIS.this_cSeriesFiltro            = ALLTRIM(cursor_4c_BuscaSer.Cods)
                    loc_oCnt.txt_4c_Serie.Value        = THIS.this_cSeriesFiltro
                    loc_lEncontrou                     = .T.
                ELSE
                    *-- Nao encontrou exato: abrir picker
                    LOCAL loc_oBusca
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaSer"
                        loc_oBusca.this_cTitulo        = "S" + CHR(233) + "ries"
                        loc_oBusca.this_cCampoChave    = "Cods"
                        loc_oBusca.this_cValorInicial  = loc_cSerie
                        loc_oBusca.mAddColuna("Cods",  "XXXXX",              ;
                            "S" + CHR(233) + "rie")
                        loc_oBusca.mAddColuna("Descs", "XXXXXXXXXXXXXXXXXXXX", ;
                            "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()

                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSer")
                            SELECT cursor_4c_BuscaSer
                            THIS.this_cSeriesFiltro     = ALLTRIM(cursor_4c_BuscaSer.Cods)
                            loc_oCnt.txt_4c_Serie.Value = THIS.this_cSeriesFiltro
                            loc_lEncontrou              = .T.
                        ELSE
                            loc_oCnt.txt_4c_Serie.Value = ""
                            THIS.this_cSeriesFiltro     = ""
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaSer")
                USE IN cursor_4c_BuscaSer
            ENDIF

            *-- Se serie valida e datas preenchidas, recarregar lista
            IF loc_lEncontrou AND ;
               !EMPTY(THIS.this_dEmisDeFiltro) AND ;
               !EMPTY(THIS.this_dEmisAteFiltro)
                THIS.CarregarLista()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar s" + CHR(233) + "rie")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarDtIni - LostFocus de txt_4c_DtIni: valida consistencia com DtFim
    * Legado: DtIni.Valid - se DtFim preenchida e DtIni > DtFim, limpar
    *==========================================================================
    PROCEDURE ValidarDtIni(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_dDtIni, loc_dDtFim
        loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros
        loc_dDtIni = loc_oCnt.txt_4c_DtIni.Value
        loc_dDtFim = loc_oCnt.txt_4c_DtFim.Value

        IF !EMPTY(loc_dDtFim) AND !EMPTY(loc_dDtIni) AND loc_dDtIni > loc_dDtFim
            MsgAviso("Data Inv" + CHR(225) + "lida !!", "")
            loc_oCnt.txt_4c_DtIni.Value = {}
            THIS.this_dEmisDeFiltro     = {}
        ELSE
            THIS.this_dEmisDeFiltro = loc_dDtIni
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarDtFim - LostFocus de txt_4c_DtFim: valida e recarrega lista
    * Legado: DtFim.Valid - valida, se serie+datas OK chama Requery
    *==========================================================================
    PROCEDURE ValidarDtFim(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_dDtIni, loc_dDtFim
        loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros
        loc_dDtIni = loc_oCnt.txt_4c_DtIni.Value
        loc_dDtFim = loc_oCnt.txt_4c_DtFim.Value

        IF !EMPTY(loc_dDtFim) AND !EMPTY(loc_dDtIni) AND loc_dDtFim < loc_dDtIni
            MsgAviso("Data Inv" + CHR(225) + "lida !!", "")
            loc_oCnt.txt_4c_DtFim.Value = {}
            THIS.this_dEmisAteFiltro    = {}
            RETURN
        ENDIF

        THIS.this_dEmisAteFiltro = loc_dDtFim

        *-- Se filtros completos, recarregar lista
        IF !EMPTY(THIS.this_cSeriesFiltro) AND ;
           !EMPTY(THIS.this_dEmisDeFiltro) AND ;
           !EMPTY(THIS.this_dEmisAteFiltro)
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *==========================================================================
    * DtFimWhenCheck - When de txt_4c_DtFim: so permite foco se DtIni preenchida
    * Legado: DtFim.When = Return(!Empty(DtIni.Value))
    *==========================================================================
    FUNCTION DtFimWhenCheck()
        LOCAL loc_dDtIni
        loc_dDtIni = {}
        TRY
            loc_dDtIni = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtIni.Value
        CATCH
            loc_lResultado = .T.
        ENDTRY
        RETURN !EMPTY(loc_dDtIni)
    ENDFUNC

    *==========================================================================
    * FiltroChanged - InteractiveChange de opt_4c_Filtro: atualiza e recarrega
    * Legado: optFiltro.InteractiveChange - atualiza pOpE/pOpS e chama Requery
    * Value=1=Entradas, Value=2=Saidas, Value=3=Ambas
    *==========================================================================
    PROCEDURE FiltroChanged()
        LOCAL loc_nOpcao
        TRY
            loc_nOpcao = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.opt_4c_Filtro.Value

            DO CASE
            CASE loc_nOpcao = 1
                THIS.this_cOpeFiltro = "E"
            CASE loc_nOpcao = 2
                THIS.this_cOpeFiltro = "S"
            OTHERWISE
                THIS.this_cOpeFiltro = "A"
            ENDCASE

            *-- Recarregar se filtros completos
            IF !EMPTY(THIS.this_cSeriesFiltro) AND ;
               !EMPTY(THIS.this_dEmisDeFiltro) AND ;
               !EMPTY(THIS.this_dEmisAteFiltro)
                THIS.CarregarLista()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao mudar filtro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarAbaImpostos - Cria controles na aba Impostos do PageFrame interno
    * Legado: SIGCDCNF.Pagina.Dados.Pagina.Impostos
    * Coordenadas originais do SCX (sem compensacao - inner PageFrame usa Tabs=.T.)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaImpostos()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_InnerPage.Page1

        *-- Say17: titulo da secao (top=2, left=5)
        loc_oAba.AddObject("lbl_4c_SecImpostos", "Label")
        WITH loc_oAba.lbl_4c_SecImpostos
            .Caption   = " Impostos "
            .Top       = 2
            .Left      = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Shape1: divisor horizontal (top=20, left=5, width=494, height=2)
        loc_oAba.AddObject("shp_4c_Div1", "Shape")
        WITH loc_oAba.shp_4c_Div1
            .Top         = 20
            .Left        = 5
            .Width       = 494
            .Height      = 2
            .BackColor   = RGB(180, 180, 180)
            .BorderColor = RGB(180, 180, 180)
        ENDWITH

        *-- Labels cabecalho IPI/ICMS (top=26)
        loc_oAba.AddObject("lbl_4c_SayBaseIPI", "Label")
        WITH loc_oAba.lbl_4c_SayBaseIPI
            .Caption   = "Base C" + CHR(225) + "lculo IPI"
            .Top       = 26
            .Left      = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayValorIPI", "Label")
        WITH loc_oAba.lbl_4c_SayValorIPI
            .Caption   = "Valor IPI"
            .Top       = 26
            .Left      = 116
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayBaseICMS", "Label")
        WITH loc_oAba.lbl_4c_SayBaseICMS
            .Caption   = "Base C" + CHR(225) + "lculo ICMS"
            .Top       = 26
            .Left      = 227
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayPercICMS", "Label")
        WITH loc_oAba.lbl_4c_SayPercICMS
            .Caption   = "% ICMS "
            .Top       = 26
            .Left      = 340
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayValorICMS", "Label")
        WITH loc_oAba.lbl_4c_SayValorICMS
            .Caption   = "Valor ICMS"
            .Top       = 26
            .Left      = 394
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Campos IPI/ICMS (top=43)
        loc_oAba.AddObject("txt_4c_BaseIPI", "TextBox")
        WITH loc_oAba.txt_4c_BaseIPI
            .Top      = 43
            .Left     = 5
            .Width    = 107
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        loc_oAba.AddObject("txt_4c_ValorIPI", "TextBox")
        WITH loc_oAba.txt_4c_ValorIPI
            .Top      = 43
            .Left     = 116
            .Width    = 107
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        loc_oAba.AddObject("txt_4c_BaseICMS", "TextBox")
        WITH loc_oAba.txt_4c_BaseICMS
            .Top      = 43
            .Left     = 227
            .Width    = 107
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        loc_oAba.AddObject("txt_4c_PercICMS", "TextBox")
        WITH loc_oAba.txt_4c_PercICMS
            .Top      = 43
            .Left     = 338
            .Width    = 52
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        loc_oAba.AddObject("txt_4c_ValorICMS", "TextBox")
        WITH loc_oAba.txt_4c_ValorICMS
            .Top      = 43
            .Left     = 394
            .Width    = 107
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        *-- Labels Totais (top=67)
        loc_oAba.AddObject("lbl_4c_SayTotProds", "Label")
        WITH loc_oAba.lbl_4c_SayTotProds
            .Caption   = "Total Produtos"
            .Top       = 67
            .Left      = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayTotalNf", "Label")
        WITH loc_oAba.lbl_4c_SayTotalNf
            .Caption   = "Total NFiscal"
            .Top       = 67
            .Left      = 116
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Campos Totais (top=83)
        loc_oAba.AddObject("txt_4c_TotalProds", "TextBox")
        WITH loc_oAba.txt_4c_TotalProds
            .Top      = 83
            .Left     = 5
            .Width    = 107
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        loc_oAba.AddObject("txt_4c_TotalNf", "TextBox")
        WITH loc_oAba.txt_4c_TotalNf
            .Top      = 83
            .Left     = 116
            .Width    = 106
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        *-- Botao Dados (abre SigMvExp): top=17, left=516
        loc_oAba.AddObject("cmd_4c_Dados", "CommandButton")
        WITH loc_oAba.cmd_4c_Dados
            .Caption         = "Dados"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_26.jpg"
            .PicturePosition = 13
            .Top             = 17
            .Left            = 516
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
        ENDWITH

        *-- Say18: "Outros Valores" (top=115, left=5)
        loc_oAba.AddObject("lbl_4c_SayOutrosVal", "Label")
        WITH loc_oAba.lbl_4c_SayOutrosVal
            .Caption   = " Outros Valores "
            .Top       = 115
            .Left      = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Shape3: divisor "Outros Valores" (top=132, left=5, width=494, height=2)
        loc_oAba.AddObject("shp_4c_Div3", "Shape")
        WITH loc_oAba.shp_4c_Div3
            .Top         = 132
            .Left        = 5
            .Width       = 494
            .Height      = 2
            .BackColor   = RGB(180, 180, 180)
            .BorderColor = RGB(180, 180, 180)
        ENDWITH

        *-- Labels Outros Valores (top=137)
        loc_oAba.AddObject("lbl_4c_SayTFrete", "Label")
        WITH loc_oAba.lbl_4c_SayTFrete
            .Caption   = "Valor do Frete"
            .Top       = 137
            .Left      = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayTSeguros", "Label")
        WITH loc_oAba.lbl_4c_SayTSeguros
            .Caption   = "Valor do Seguro"
            .Top       = 137
            .Left      = 119
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayDespAces", "Label")
        WITH loc_oAba.lbl_4c_SayDespAces
            .Caption   = "Despesas Acess" + CHR(243) + "rias"
            .Top       = 137
            .Left      = 233
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Campos Outros Valores (top=153)
        loc_oAba.AddObject("txt_4c_TFrete", "TextBox")
        WITH loc_oAba.txt_4c_TFrete
            .Top      = 153
            .Left     = 5
            .Width    = 105
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        loc_oAba.AddObject("txt_4c_TSeguros", "TextBox")
        WITH loc_oAba.txt_4c_TSeguros
            .Top      = 153
            .Left     = 119
            .Width    = 105
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        loc_oAba.AddObject("txt_4c_DespAces", "TextBox")
        WITH loc_oAba.txt_4c_DespAces
            .Top      = 153
            .Left     = 233
            .Width    = 105
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        *-- Say26: "Transportador" (top=185, left=5)
        loc_oAba.AddObject("lbl_4c_SayTransp", "Label")
        WITH loc_oAba.lbl_4c_SayTransp
            .Caption   = " Transportador "
            .Top       = 185
            .Left      = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Shape4: divisor "Transportador" (top=203, left=5, width=494, height=2)
        loc_oAba.AddObject("shp_4c_Div4", "Shape")
        WITH loc_oAba.shp_4c_Div4
            .Top         = 203
            .Left        = 5
            .Width       = 494
            .Height      = 2
            .BackColor   = RGB(180, 180, 180)
            .BorderColor = RGB(180, 180, 180)
        ENDWITH

        *-- Say20: label "Transportadora" (top=209, left=5)
        loc_oAba.AddObject("lbl_4c_SayTranspNome", "Label")
        WITH loc_oAba.lbl_4c_SayTranspNome
            .Caption   = "Transportadora"
            .Top       = 209
            .Left      = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Codigo transportadora (top=225, left=5, width=82)
        loc_oAba.AddObject("txt_4c_CodTransp", "TextBox")
        WITH loc_oAba.txt_4c_CodTransp
            .Top       = 225
            .Left      = 5
            .Width     = 82
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        *-- Nome transportadora (top=225, left=90, width=377)
        loc_oAba.AddObject("txt_4c_TranspNome", "TextBox")
        WITH loc_oAba.txt_4c_TranspNome
            .Top       = 225
            .Left      = 90
            .Width     = 377
            .Height    = 23
            .MaxLength = 40
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        *-- Say21: "Endereco" (top=251, left=5)
        loc_oAba.AddObject("lbl_4c_SayTranspEnde", "Label")
        WITH loc_oAba.lbl_4c_SayTranspEnde
            .Caption   = "Endere" + CHR(231) + "o"
            .Top       = 251
            .Left      = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Endereco transportadora (top=267, left=5, width=462)
        loc_oAba.AddObject("txt_4c_TranspEnde", "TextBox")
        WITH loc_oAba.txt_4c_TranspEnde
            .Top       = 267
            .Left      = 5
            .Width     = 462
            .Height    = 23
            .MaxLength = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        *-- Labels linha de Cidade/UF/Placa/Frete (top=293)
        loc_oAba.AddObject("lbl_4c_SayCidade", "Label")
        WITH loc_oAba.lbl_4c_SayCidade
            .Caption   = "Cidade"
            .Top       = 293
            .Left      = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayEstado", "Label")
        WITH loc_oAba.lbl_4c_SayEstado
            .Caption   = "UF"
            .Top       = 293
            .Left      = 184
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayPlaca", "Label")
        WITH loc_oAba.lbl_4c_SayPlaca
            .Caption   = "Placa"
            .Top       = 293
            .Left      = 221
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayUfPlaca", "Label")
        WITH loc_oAba.lbl_4c_SayUfPlaca
            .Caption   = "UF"
            .Top       = 293
            .Left      = 303
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayTipoFrete", "Label")
        WITH loc_oAba.lbl_4c_SayTipoFrete
            .Caption   = "Frete"
            .Top       = 293
            .Left      = 337
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Campos Cidade/UF/Placa/Frete (top=309)
        loc_oAba.AddObject("txt_4c_TranspCida", "TextBox")
        WITH loc_oAba.txt_4c_TranspCida
            .Top       = 309
            .Left      = 5
            .Width     = 175
            .Height    = 23
            .MaxLength = 40
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        loc_oAba.AddObject("txt_4c_TranspEsta", "TextBox")
        WITH loc_oAba.txt_4c_TranspEsta
            .Top       = 309
            .Left      = 183
            .Width     = 26
            .Height    = 23
            .MaxLength = 2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        loc_oAba.AddObject("txt_4c_Placa", "TextBox")
        WITH loc_oAba.txt_4c_Placa
            .Top       = 309
            .Left      = 219
            .Width     = 80
            .Height    = 23
            .MaxLength = 8
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        loc_oAba.AddObject("txt_4c_UfPlaca", "TextBox")
        WITH loc_oAba.txt_4c_UfPlaca
            .Top       = 309
            .Left      = 302
            .Width     = 26
            .Height    = 23
            .MaxLength = 2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        loc_oAba.AddObject("txt_4c_TipoFrete", "TextBox")
        WITH loc_oAba.txt_4c_TipoFrete
            .Top       = 309
            .Left      = 336
            .Width     = 132
            .Height    = 23
            .MaxLength = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        *-- Say16: "Volumes Transportados" (top=342, left=5)
        loc_oAba.AddObject("lbl_4c_SayVolumes", "Label")
        WITH loc_oAba.lbl_4c_SayVolumes
            .Caption   = " Volumes Transportados "
            .Top       = 342
            .Left      = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Shape2: divisor "Volumes" (top=360, left=5, width=494, height=2)
        loc_oAba.AddObject("shp_4c_Div2", "Shape")
        WITH loc_oAba.shp_4c_Div2
            .Top         = 360
            .Left        = 5
            .Width       = 494
            .Height      = 2
            .BackColor   = RGB(180, 180, 180)
            .BorderColor = RGB(180, 180, 180)
        ENDWITH

        *-- Labels Volumes (top=364)
        loc_oAba.AddObject("lbl_4c_SayQtdes", "Label")
        WITH loc_oAba.lbl_4c_SayQtdes
            .Caption   = "Qtde."
            .Top       = 364
            .Left      = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayEspe", "Label")
        WITH loc_oAba.lbl_4c_SayEspe
            .Caption   = "Esp" + CHR(233) + "cie"
            .Top       = 364
            .Left      = 59
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayMarcas", "Label")
        WITH loc_oAba.lbl_4c_SayMarcas
            .Caption   = "Marca"
            .Top       = 364
            .Left      = 149
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayNumeros", "Label")
        WITH loc_oAba.lbl_4c_SayNumeros
            .Caption   = "N" + CHR(250) + "mero"
            .Top       = 364
            .Left      = 239
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayPesoLiq", "Label")
        WITH loc_oAba.lbl_4c_SayPesoLiq
            .Caption   = "Peso L" + CHR(237) + "quido"
            .Top       = 364
            .Left      = 329
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayPesoBruto", "Label")
        WITH loc_oAba.lbl_4c_SayPesoBruto
            .Caption   = "Peso Bruto"
            .Top       = 364
            .Left      = 405
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Campos Volumes (top=380)
        loc_oAba.AddObject("txt_4c_Qtdes", "TextBox")
        WITH loc_oAba.txt_4c_Qtdes
            .Top      = 380
            .Left     = 5
            .Width    = 51
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        loc_oAba.AddObject("txt_4c_EspeVol", "TextBox")
        WITH loc_oAba.txt_4c_EspeVol
            .Top       = 380
            .Left      = 59
            .Width     = 87
            .Height    = 21
            .MaxLength = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        loc_oAba.AddObject("txt_4c_Marcas", "TextBox")
        WITH loc_oAba.txt_4c_Marcas
            .Top       = 380
            .Left      = 149
            .Width     = 87
            .Height    = 21
            .MaxLength = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        loc_oAba.AddObject("txt_4c_NumerosVol", "TextBox")
        WITH loc_oAba.txt_4c_NumerosVol
            .Top       = 380
            .Left      = 239
            .Width     = 87
            .Height    = 21
            .MaxLength = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        loc_oAba.AddObject("txt_4c_PesoLiq", "TextBox")
        WITH loc_oAba.txt_4c_PesoLiq
            .Top      = 380
            .Left     = 329
            .Width    = 73
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        loc_oAba.AddObject("txt_4c_PesoBruto", "TextBox")
        WITH loc_oAba.txt_4c_PesoBruto
            .Top      = 380
            .Left     = 405
            .Width    = 73
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarAbaServicos - Cria controles na aba Servicos do PageFrame interno
    * Legado: SIGCDCNF.Pagina.Dados.Pagina.Servicos
    * Coordenadas originais do SCX (sem compensacao - inner PageFrame usa Tabs=.T.)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaServicos()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_InnerPage.Page2

        *-- Say1: "Descricao dos Servicos Prestados :" (top=2, left=7)
        loc_oAba.AddObject("lbl_4c_SayDescSer", "Label")
        WITH loc_oAba.lbl_4c_SayDescSer
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o dos Servi" + CHR(231) + "os Prestados : "
            .Top       = 2
            .Left      = 7
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Memo_desc EditBox (top=18, left=5, width=724, height=144)
        loc_oAba.AddObject("edt_4c_DescSer", "EditBox")
        WITH loc_oAba.edt_4c_DescSer
            .Top      = 18
            .Left     = 5
            .Width    = 724
            .Height   = 144
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = ""
        ENDWITH

        *-- Say2: "Valor Total Servicos :" (top=167, left=15)
        loc_oAba.AddObject("lbl_4c_SayVtotsers", "Label")
        WITH loc_oAba.lbl_4c_SayVtotsers
            .Caption   = "Valor Total Servi" + CHR(231) + "os : "
            .Top       = 167
            .Left      = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Get_vtotser (top=164, left=144, width=136)
        loc_oAba.AddObject("txt_4c_Vtotsers", "TextBox")
        WITH loc_oAba.txt_4c_Vtotsers
            .Top      = 164
            .Left     = 144
            .Width    = 136
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        *-- Say3: "% I.S.S. :" (top=192, left=81)
        loc_oAba.AddObject("lbl_4c_SayPerciss", "Label")
        WITH loc_oAba.lbl_4c_SayPerciss
            .Caption   = "% I.S.S. : "
            .Top       = 192
            .Left      = 81
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Get_perciss (top=189, left=144, width=52)
        loc_oAba.AddObject("txt_4c_Perciss", "TextBox")
        WITH loc_oAba.txt_4c_Perciss
            .Top      = 189
            .Left     = 144
            .Width    = 52
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        *-- Say4: "Valor Total do I.S.S. :" (top=217, left=14)
        loc_oAba.AddObject("lbl_4c_SayVtotiss", "Label")
        WITH loc_oAba.lbl_4c_SayVtotiss
            .Caption   = "Valor Total do I.S.S. : "
            .Top       = 217
            .Left      = 14
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Get_vtotiss (top=214, left=144, width=136)
        loc_oAba.AddObject("txt_4c_Vtotiss", "TextBox")
        WITH loc_oAba.txt_4c_Vtotiss
            .Top      = 214
            .Left     = 144
            .Width    = 136
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnDadosClick - Abre SigMvExp com detalhes das movimentacoes da NF
    * Legado: Dados.Click -> SELECT Dopes FROM SigCdOpe -> DO FORM SigMvExp WITH ...
    *==========================================================================
    PROCEDURE BtnDadosClick()
        LOCAL loc_lResultado, loc_cDopes, loc_nNumes, loc_cEmps, loc_nResult, loc_cSQL
        loc_lResultado = .F.

        TRY
            THIS.Enabled = .F.

            loc_cDopes = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
            loc_nNumes = THIS.this_oBusinessObject.this_nNumes
            loc_cEmps  = THIS.this_cEmps

            IF EMPTY(loc_cDopes)
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o definida.", "Dados")
            ELSE
                loc_cSQL    = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopes)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpe")

                IF loc_nResult > 0 AND USED("cursor_4c_TmpOpe") AND RECCOUNT("cursor_4c_TmpOpe") > 0
                    DO FORM SigMvExp WITH loc_cDopes, "C", loc_nNumes, loc_cEmps, .T.
                    loc_lResultado = .T.
                ELSE
                    MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada.", "Dados")
                ENDIF

                IF USED("cursor_4c_TmpOpe")
                    USE IN cursor_4c_TmpOpe
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir dados da NF")
        ENDTRY

        THIS.Enabled = .T.

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Alias canonico para InserirCarta (inserir carta de correcao)
    * Mapeia o padrao CRUD para este formulario especializado
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.BtnInserirCartaClick()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Alias canonico para AlteraCarta (alterar carta de correcao)
    * Mapeia o padrao CRUD para este formulario especializado
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        THIS.BtnAlteraCartaClick()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualiza NF selecionada em modo somente leitura
    * Legado: pcEscolha='CONSULTAR' -> Page2 com dados da NF (campos bloqueados)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
               EOF("cursor_4c_Dados")
                MsgAviso("Selecione uma Nota Fiscal na lista.", "Visualizar")
            ELSE
                SELECT cursor_4c_Dados

                IF THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(cursor_4c_Dados.cidchaves))
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.F.)
                    *-- Desabilitar Confirmar em modo VISUALIZAR (somente leitura)
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = .F.
                    THIS.AlternarPagina(2)
                    loc_lResultado = .T.
                ELSE
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                        "Erro ao carregar NF")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao visualizar NF")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui carta de correcao da NF selecionada
    * Remove a carta de correcao (correcs=0), mantendo a NF original no sistema
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lResultado, loc_cCidchaves
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
           EOF("cursor_4c_Dados")
            MsgAviso("Selecione uma Nota Fiscal na lista.", ;
                "Excluir Carta de Corre" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados

        IF NVL(cursor_4c_Dados.correcs, 0) = 0
            MsgAviso("A nota selecionada n" + CHR(227) + "o possui carta de corre" + ;
                CHR(231) + CHR(227) + "o para excluir.", "Aviso")
            RETURN .F.
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da carta de corre" + ;
                CHR(231) + CHR(227) + "o desta NF?", ;
                "Excluir Carta")
            RETURN .F.
        ENDIF

        TRY
            loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Carta de corre" + CHR(231) + CHR(227) + "o exclu" + ;
                        CHR(237) + "da com sucesso!", "Sucesso")
                    THIS.CarregarLista()
                    loc_lResultado = .T.
                ELSE
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao excluir")
                ENDIF
            ELSE
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao carregar NF")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, ;
                "Erro ao excluir carta de corre" + CHR(231) + CHR(227) + "o")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Destroy - Limpeza ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega lista com filtros atuais (busca manual)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        IF EMPTY(ALLTRIM(THIS.this_cEmps))
            MsgAviso("Informe a Empresa para pesquisa.", "Buscar")
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_Emp.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cSeriesFiltro))
            MsgAviso("Informe a S" + CHR(233) + "rie para pesquisa.", "Buscar")
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_Serie.SetFocus()
            RETURN
        ENDIF
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Alias canonico para BtnConfirmarClick (salvar dados)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnConfirmarClick()
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estados de botoes conforme modo atual
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lEdicao
        loc_oPg1    = THIS.pgf_4c_Paginas.Page1
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        WITH loc_oPg1.cnt_4c_Botoes
            .cmd_4c_InserirCarta.Enabled = !loc_lEdicao
            .cmd_4c_AlteraCarta.Enabled  = !loc_lEdicao
            .cmd_4c_ImpCarta.Enabled     = !loc_lEdicao
            .Visible     = .T.
        ENDWITH
        loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled = !loc_lEdicao

        WITH loc_oPg2.cnt_4c_Salva
            .cmd_4c_Confirmar.Enabled = loc_lEdicao
            .cmd_4c_Cancelar.Enabled  = .T.
            .Visible     = .T.
        ENDWITH
    ENDPROC

ENDDEFINE
