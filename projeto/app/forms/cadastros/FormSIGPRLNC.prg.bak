*==============================================================================
* FormSIGPRLNC.prg - Formulario de Cadastro de Lancamentos de Conta Corrente
* Tabela: SigClLan (grupos, contas, cocos - lancamentos/ocorrencias por conta)
* Herdado de: FormBase (arquitetura em camadas - PILAR 3)
*==============================================================================
DEFINE CLASS FormSIGPRLNC AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity: Width=1000, Height=600 do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Lancamentos"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Business Object e modo de operacao
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *-- Estado do registro selecionado na Page1 para carregar em Page2
    this_cGrupoAtual     = ""
    this_cContaAtual     = ""
    this_cGruContasAtual = ""

    *-- Guarda de reentrancia dos lookups (regra #37/#47): FormBuscaAuxiliar eh
    *-- MODAL, tira o foco e redispara o proprio LostFocus - sem a flag abrem
    *-- DOIS dialogos. Liberada em wrapper fino, imune a RETURN antecipado.
    this_lEmLookup       = .F.

    *--------------------------------------------------------------------------
    * Init - DODEFAULT() ja chama InicializarForm() via FormBase.Init()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao completa do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Criar cursor local para lista de ocorrencias (equivalente ao csSigClLan do legado)
            IF USED("cursor_4c_OcoLocal")
                USE IN cursor_4c_OcoLocal
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_OcoLocal (Grupos C(10), Contas C(10), Cocos C(2), descs C(30))
            SET NULL OFF
            INDEX ON Cocos TAG Cocos

            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRLNCBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar SIGPRLNCBO", "Erro Cr" + CHR(237) + "tico")
            ELSE
                THIS.Caption = "Cadastro de Lan" + CHR(231) + "amentos"

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    IF !THIS.CarregarLista()
                        *-- Falha ao carregar nao impede abertura do formulario
                    ENDIF
                ENDIF

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormSIGPRLNC:" + CHR(13) + ;
                        "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                        loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Top        = -29
            .Left       = 0
            .Width      = 1003
            .Height     = 629
            .PageCount  = 2
            .Tabs       = .F.
            .Visible    = .T.

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD e grid de lancamentos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho escuro (cntSombra: Top=2+29=31)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = "Cadastro de Lan" + CHR(231) + "amentos"
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 40
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Cadastro de Lan" + CHR(231) + "amentos"
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 46
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (Left=542, Top=29 - 5 botoes: Incluir Visualizar Alterar Excluir Buscar)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 385
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container saida canonico (Left=917, Width=90, cmd_4c_Encerrar 75x75)
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de lancamentos: Grupos/Contas distintos de SigClLan
        *-- Geometria transcrita dos overrides do SCX legado (Pagina.Lista.Grade):
        *-- Top=101 / Left=29 / Width=940 / Height=480; Top recebe +29 da
        *-- compensacao do PageFrame (pgf_4c_Paginas.Top = -29) -> 101+29 = 130.
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 130
            .Left               = 29
            .Width              = 940
            .Height             = 480
            .ColumnCount        = 3
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
            .Visible            = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: campos de identificacao (Grupo/Conta) e botoes
    * Fase 5/8: Container botoes + labels/textboxes de Grupo e Conta
    *--------------------------------------------------------------------------
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



        *-- Container botoes de acao (Grupo_Salva do dump: Left=844, Top=-3, AutoSize)
        *-- Left/Width transcritos do dump + canonico cnt_4c_Salva do framework
        *-- (Left=842..844, Width=160, Height=85, Top na faixa 29..33).
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 844
            .Width       = 160
            .Height      = 85
            .BackStyle = 0
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .TabIndex    = 10
            .Visible     = .T.
        ENDWITH

        *-- Botao Salvar (Grupo_Salva.Salva: Left=5, Top=5)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
            .Caption         = "Salvar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (Grupo_Salva.Cancelar: Left=80, Top=5)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            *-- Grupo_Salva.Cancelar do legado - "Encerrar" eh o botao de SAIDA da
            *-- pagina Lista (cmd_4c_Encerrar/regra #10), nao este.
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Label "Grupo : " (Say2: Top=130+29=159, Left=257, TabIndex=1)
        *-- Say da classe 'say' eh AutoSize/esquerda: o dump nao declara Width nem
        *-- Alignment, entao Alignment fica 0 (regra #23) - NAO inventar Alignment=1.
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Grupo : "
            .Top       = 159
            .Left      = 257
            .Width     = 80
            .Height    = 18
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Grupo (Get_Grupos: Top=127+29=156, Left=300, Width=80, TabIndex=2)
        *-- Format="K" transcrito do dump (regra #49). InputMask="" no dump eh
        *-- override VAZIO do Form Designer - NAO transcrever.
        *-- MaxLength vem da COLUNA do schema (SigClLan.grupos char(10)), nunca
        *-- do Width em pixels (regra #19).
        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Value         = ""
            .Top           = 156
            .Left          = 300
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .Format        = "K"
            .MaxLength     = 10
            .TabIndex      = 2
            .Visible       = .T.
        ENDWITH
        *-- O legado valida/abre o picker no Valid do campo, ou seja ao SAIR dele.
        *-- Ligado a "KeyPress" (como estava) o handler so rodava com Enter/Tab e
        *-- sair com o MOUSE nunca validava: a descricao ficava vazia e o codigo
        *-- invalido passava. Evento certo eh LostFocus (regra #47).
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "LostFocus", THIS, "ValidarGrupoLostFocus")
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "GrupoKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "DblClick", THIS, "GrupoDblClick")
        *-- O When legado eh reavaliado a CADA chegada de foco: esvaziar o codigo
        *-- tem de REABRIR o campo de descricao, e preenche-lo tem de fecha-lo.
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "InteractiveChange", THIS, "AtualizarCamposDescricao")

        *-- TextBox Descricao do Grupo (Get_Desc_Gru: Top=127+29=156, Left=382, Width=360, TabIndex=3)
        *-- MaxLength = SigCdGcr.descrs char(40)
        loc_oPagina.AddObject("txt_4c_Desc_Gru", "TextBox")
        WITH loc_oPagina.txt_4c_Desc_Gru
            .Value         = ""
            .Top           = 156
            .Left          = 382
            .Width         = 360
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .Format        = "K"
            .MaxLength     = 40
            .TabIndex      = 3
            .ReadOnly      = .T.     && estado INICIAL (modo LISTA) - ver AtualizarCamposDescricao
            .Visible       = .T.
        ENDWITH
        *-- O legado NAO deixa a descricao travada para sempre: o Get_Desc_Gru tem
        *-- When = IsEmpty(get_grupos.value) AND Inlist(pcEscolha, "PROCURAR") e um
        *-- Valid proprio que chama fAcessoContab(...) - ou seja, o campo eh uma
        *-- SEGUNDA porta de entrada do grupo, nao um rotulo. ReadOnly fixo apagava
        *-- essa funcionalidade. Quem reavalia a condicao do When eh
        *-- AtualizarCamposDescricao() (regra #45: dependencia num metodo unico).
        BINDEVENT(loc_oPagina.txt_4c_Desc_Gru, "LostFocus", THIS, "ValidarDescGrupoLostFocus")
        BINDEVENT(loc_oPagina.txt_4c_Desc_Gru, "KeyPress",  THIS, "DescGrupoKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Desc_Gru, "DblClick",  THIS, "DescGrupoDblClick")

        *-- Label "Conta : " (Say3: Top=155+29=184, Left=257, TabIndex=4)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Conta : "
            .Top       = 184
            .Left      = 257
            .Width     = 80
            .Height    = 18
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 4
            .Visible   = .T.
        ENDWITH

        *-- TextBox Conta (Get_Contas: Top=152+29=181, Left=300, Width=80, TabIndex=5)
        *-- MaxLength = SigClLan.contas char(10)
        loc_oPagina.AddObject("txt_4c_Contas", "TextBox")
        WITH loc_oPagina.txt_4c_Contas
            .Value         = ""
            .Top           = 181
            .Left          = 300
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .Format        = "K"
            .MaxLength     = 10
            .TabIndex      = 5
            .Visible       = .T.
        ENDWITH
        *-- Lookup no LostFocus, nao no KeyPress - ver comentario do txt_4c_Grupo
        BINDEVENT(loc_oPagina.txt_4c_Contas, "LostFocus", THIS, "ValidarContaLostFocus")
        BINDEVENT(loc_oPagina.txt_4c_Contas, "KeyPress", THIS, "ContaKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Contas, "DblClick", THIS, "ContaDblClick")
        BINDEVENT(loc_oPagina.txt_4c_Contas, "InteractiveChange", THIS, "AtualizarCamposDescricao")

        *-- TextBox Descricao da Conta (Get_Desc_Con: Top=152+29=181, Left=382, Width=360, TabIndex=6)
        *-- MaxLength = SigCdCli.rclis char(50)
        loc_oPagina.AddObject("txt_4c_Desc_Con", "TextBox")
        WITH loc_oPagina.txt_4c_Desc_Con
            .Value         = ""
            .Top           = 181
            .Left          = 382
            .Width         = 360
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .Format        = "K"
            .MaxLength     = 50
            .TabIndex      = 6
            .ReadOnly      = .T.     && estado INICIAL (modo LISTA) - ver AtualizarCamposDescricao
            .Visible       = .T.
        ENDWITH
        *-- Get_Desc_Con.When = IsEmpty(get_contas.value) AND
        *-- Inlist(pcEscolha, "INSERIR", "PROCURAR"); o Valid chama
        *-- fAcessoContas(Usuar, get_grupos.value, 'D', ...) - busca pela
        *-- DESCRICAO (pTip='D') e FILTRADA pelo grupo corrente (pGrp).
        BINDEVENT(loc_oPagina.txt_4c_Desc_Con, "LostFocus", THIS, "ValidarDescContaLostFocus")
        BINDEVENT(loc_oPagina.txt_4c_Desc_Con, "KeyPress",  THIS, "DescContaKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Desc_Con, "DblClick",  THIS, "DescContaDblClick")

        *-- Botao Inserir Ocorrencia (inserir: Top=335+29=364, Left=629, 40x40)
        loc_oPagina.AddObject("cmd_4c_InserirOco", "CommandButton")
        WITH loc_oPagina.cmd_4c_InserirOco
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
            .PicturePosition = 7
            .Top             = 364
            .Left            = 629
            .Width           = 40
            .Height          = 40
            .FontName        = "Arial"
            .FontSize        = 9
            .FontBold        = .T.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(0, 128, 0)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .ToolTipText     = "Inserir"
            .TabIndex        = 8
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_InserirOco, "Click", THIS, "BtnInserirOcoClick")

        *-- Botao Excluir Ocorrencia (excluir: Top=375+29=404, Left=629, 40x40)
        loc_oPagina.AddObject("cmd_4c_ExcluirOco", "CommandButton")
        WITH loc_oPagina.cmd_4c_ExcluirOco
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 7
            .Top             = 404
            .Left            = 629
            .Width           = 40
            .Height          = 40
            .FontName        = "Arial"
            .FontSize        = 9
            .FontBold        = .T.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(255, 0, 0)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .ToolTipText     = "Excluir"
            .TabIndex        = 9
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_ExcluirOco, "Click", THIS, "BtnExcluirOcoClick")

        *-- Grid de Ocorrencias (Gradeoco: Top=181+29=210, Left=300, Width=324, Height=403)
        LOCAL loc_oGrid
        loc_oPagina.AddObject("grd_4c_Ocorrencias", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Ocorrencias
        loc_oGrid.ColumnCount = 3
        loc_oGrid.RecordSource = "cursor_4c_OcoLocal"
        loc_oGrid.ColumnCount  = 2
        WITH loc_oGrid
            .Top                = 210
            .Left               = 300
            .Width              = 324
            .Height             = 403
            .FontName           = "Verdana"
            .FontSize           = 8
            .Panel              = 1
            .RowHeight          = 16
            .TabIndex           = 7
            .ScrollBars         = 2
            .GridLines          = 3
            .GridLineColor      = RGB(238, 238, 238)
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .Visible            = .T.

            .Column1.ControlSource     = "cursor_4c_OcoLocal.Cocos"
            .Column1.Width             = 70
            .Column1.Movable           = .F.
            .Column1.Resizable         = .F.
            .Column1.Visible           = .T.
            .Column1.Sparse            = .F.
            .Column1.Header1.Caption   = "Ocorr" + CHR(234) + "ncia"
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Column1.Text1.FontName    = "Verdana"
            .Column1.Text1.FontSize    = 8
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin      = 0

            .Column2.ControlSource     = "cursor_4c_OcoLocal.descs"
            .Column2.Width             = 220
            .Column2.Movable           = .F.
            .Column2.Resizable         = .F.
            .Column2.ReadOnly          = .T.
            .Column2.Visible           = .T.
            .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.FontSize  = 8
            .Column2.Header1.Alignment = 2
            .Column2.Text1.FontName    = "Verdana"
            .Column2.Text1.FontSize    = 8
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin      = 0
            .Column2.Text1.ReadOnly    = .T.
        ENDWITH

        *-- Celula Ocorrencia com Valid PROPRIO (legado: Gradeoco.Column2.Text1.Valid
        *-- abre o fwBuscaExt). Antes a validacao estava num BINDEVENT de
        *-- AfterRowColChange, que recebe a coluna de DESTINO: ao sair da Ocorrencia
        *-- chegava 2 e o picker nunca abria (Erro191). BINDEVENT em Valid de
        *-- TextBox de Column nao eh confiavel -> classe com o evento embutido.
        loc_oGrid.Column1.AddObject("txt_4c_Ocorrencia", "TextBoxOcorrencia_4c")
        WITH loc_oGrid.Column1.txt_4c_Ocorrencia
            .FontName    = "Verdana"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .MaxLength   = 2        && SigClLan.cocos char(2)
            .Visible     = .T.
        ENDWITH
        loc_oGrid.Column1.CurrentControl = "txt_4c_Ocorrencia"   && regra #18
        loc_oGrid.Column1.Sparse         = .F.

        *-- Estado inicial dos campos de descricao conforme o When legado
        THIS.AtualizarCamposDescricao()

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Busca lancamentos distintos e vincula ao grd_4c_Lista
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oGrid
        loc_lSucesso = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (grupos C(10), contas C(10), cocos C(2), ;
                                               cidchaves C(20), grucontas C(20))
                SET NULL OFF
                loc_lSucesso = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    *-- RecordSource e ColumnCount ANTES do WITH (Problema 48/36)
                    loc_oGrid.ColumnCount = 4
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 3

                    *-- Colunas do legado (Init): Grupos / Contas / Cocos ("Operacao"), 80px cada
                    WITH loc_oGrid
                        .Column1.ControlSource   = "cursor_4c_Dados.grupos"
                        .Column1.Width           = 80
                        .Column1.Header1.Caption = "Grupos"

                        .Column2.ControlSource   = "cursor_4c_Dados.contas"
                        .Column2.Width           = 80
                        .Column2.Header1.Caption = "Contas"

                        .Column3.ControlSource   = "cursor_4c_Dados.cocos"
                        .Column3.Width           = 80
                        .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                    ENDWITH

                    THIS.FormatarGridLista(loc_oGrid)
                    THIS.AjustarBotoesPorModo()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormSIGPRLNC.CarregarLista: " + loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (lista) e Page2 (dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            *-- Regra #40: o modo eh normalizado AQUI, no FUNIL, nao em cada caller.
            *-- Toda chamada de AlternarPagina(1) deste form eh caminho de VOLTA
            *-- (Salvar / Cancelar); sem repor o modo, AjustarBotoesPorModo
            *-- trabalharia com "INSERIR"/"ALTERAR" ja de volta na Lista.
            THIS.this_cModoAtual = "LISTA"
            THIS.CarregarLista()
        ELSE
            *-- repintar com a Page2 JA visivel (Refresh em pagina oculta nao pinta)
            THIS.AtualizarGradeOcorrencias()
        ENDIF

        *-- Fora do ramo de sucesso do CarregarLista: se o Buscar do BO falhar, os
        *-- botoes da Lista ainda precisam terminar num estado coerente (regra #40).
        THIS.AjustarBotoesPorModo()

        loc_lSucesso = .T.
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Aplica formatacao visual uniforme ao grid da Page1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPaginaDados - Carrega campos de identificacao e ocorrencias na Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarPaginaDados(par_cGruContas)
        LOCAL loc_lSucesso, loc_oPagina, loc_cGrupos, loc_cContas
        loc_lSucesso = .F.
        loc_oPagina  = THIS.pgf_4c_Paginas.Page2
        loc_cGrupos  = ALLTRIM(LEFT(par_cGruContas, 10))
        loc_cContas  = ALLTRIM(RIGHT(par_cGruContas, 10))

        TRY
            *-- Preencher campos de identificacao (criados na Fase 5)
            IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
                loc_oPagina.txt_4c_Grupo.Value = loc_cGrupos
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c_Contas", 5)
                loc_oPagina.txt_4c_Contas.Value = loc_cContas
            ENDIF

            *-- Carregar descricoes via SQL
            THIS.IniciarDescricoes()
            THIS.AtualizarCamposDescricao()

            *-- Carregar ocorrencias no cursor local (grid vinculado na Fase 6)
            IF USED("cursor_4c_OcoLocal")
                ZAP IN cursor_4c_OcoLocal
            ENDIF

            IF THIS.this_oBusinessObject.BuscarOcorrencias(par_cGruContas)
                *-- Copiar ocorrencias do cursor SQL para cursor local (preserva grid)
                IF USED("cursor_4c_Ocorrencias") AND RECCOUNT("cursor_4c_Ocorrencias") > 0
                    SELECT cursor_4c_Ocorrencias
                    GO TOP
                    DO WHILE !EOF()
                        SELECT cursor_4c_OcoLocal
                        APPEND BLANK
                        REPLACE Grupos WITH ALLTRIM(cursor_4c_Ocorrencias.grupos)
                        REPLACE Contas WITH ALLTRIM(cursor_4c_Ocorrencias.contas)
                        REPLACE Cocos  WITH ALLTRIM(cursor_4c_Ocorrencias.cocos)
                        REPLACE descs  WITH ALLTRIM(cursor_4c_Ocorrencias.descs)
                        SELECT cursor_4c_Ocorrencias
                        SKIP
                    ENDDO
                ENDIF
                loc_lSucesso = .T.
            ENDIF
            THIS.AtualizarGradeOcorrencias()
        CATCH TO loException
            MsgErro("Erro em CarregarPaginaDados: " + loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarGradeOcorrencias - Go Top + Refresh da grade de ocorrencias
    * Popular o cursor (ZAP + APPEND) NAO repinta a grade: com o form ja aberto,
    * Visualizar/Alterar enchia cursor_4c_OcoLocal e a grade continuava vazia
    * (Erro192, regra #21). Legado: "GradeOco.Refresh()" no Grupo_op.Click.
    * Chamado em TODO caminho que popula o cursor e ao exibir a Page2.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarGradeOcorrencias()
        IF USED("cursor_4c_OcoLocal")
            GO TOP IN cursor_4c_OcoLocal
        ENDIF
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Ocorrencias", 5)
            THIS.pgf_4c_Paginas.Page2.grd_4c_Ocorrencias.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Zera propriedades do BO e campos da Page2 para modo de inclusao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cGrupos    = ""
        THIS.this_oBusinessObject.this_cContas    = ""
        THIS.this_oBusinessObject.this_cCocos     = ""
        THIS.this_oBusinessObject.this_cCidChaves = ""
        THIS.this_oBusinessObject.this_cGruContas = ""

        IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
            loc_oPagina.txt_4c_Grupo.Value    = ""
            loc_oPagina.txt_4c_Desc_Gru.Value = ""
            loc_oPagina.txt_4c_Contas.Value   = ""
            loc_oPagina.txt_4c_Desc_Con.Value = ""
        ENDIF

        IF USED("cursor_4c_OcoLocal")
            ZAP IN cursor_4c_OcoLocal
        ENDIF
        THIS.AtualizarGradeOcorrencias()
        THIS.AtualizarCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Navega para Page2 em modo de inclusao de novo grupo+conta
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual      = "INSERIR"
        THIS.this_cGrupoAtual     = ""
        THIS.this_cContaAtual     = ""
        THIS.this_cGruContasAtual = ""
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Navega para Page2 em modo consulta (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cGrupos, loc_cContas, loc_cGruContas
        loc_cGrupos    = ""
        loc_cContas    = ""
        loc_cGruContas = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            SELECT cursor_4c_Dados
            loc_cGrupos    = ALLTRIM(grupos)
            loc_cContas    = ALLTRIM(contas)
            loc_cGruContas = ALLTRIM(grucontas)
        ELSE
            MsgAviso("Selecione um registro na lista.", "Selecionar")
            RETURN
        ENDIF

        THIS.this_cModoAtual      = "PROCURAR"
        THIS.this_cGrupoAtual     = loc_cGrupos
        THIS.this_cContaAtual     = loc_cContas
        THIS.this_cGruContasAtual = loc_cGruContas
        THIS.HabilitarCampos(.T.)

        THIS.CarregarPaginaDados(loc_cGruContas)
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Navega para Page2 em modo de alteracao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cGrupos, loc_cContas, loc_cGruContas
        loc_cGrupos    = ""
        loc_cContas    = ""
        loc_cGruContas = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            SELECT cursor_4c_Dados
            loc_cGrupos    = ALLTRIM(grupos)
            loc_cContas    = ALLTRIM(contas)
            loc_cGruContas = ALLTRIM(grucontas)
        ELSE
            MsgAviso("Selecione um registro na lista.", "Selecionar")
            RETURN
        ENDIF

        THIS.this_cModoAtual      = "ALTERAR"
        THIS.this_cGrupoAtual     = loc_cGrupos
        THIS.this_cContaAtual     = loc_cContas
        THIS.this_cGruContasAtual = loc_cGruContas
        THIS.HabilitarCampos(.T.)

        THIS.CarregarPaginaDados(loc_cGruContas)
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui todos os lancamentos do grupo+conta selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cGrupos, loc_cContas, loc_cCocos, loc_cCidChaves, loc_lConfirmar
        loc_cGrupos    = ""
        loc_cContas    = ""
        loc_cCocos     = ""
        loc_cCidChaves = ""
        loc_lConfirmar = .F.

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            SELECT cursor_4c_Dados
            loc_cGrupos    = ALLTRIM(grupos)
            loc_cContas    = ALLTRIM(contas)
            loc_cCocos     = ALLTRIM(cocos)
            loc_cCidChaves = ALLTRIM(cidchaves)
        ELSE
            MsgAviso("Selecione um registro na lista.", "Selecionar")
            RETURN
        ENDIF

        *-- Legado: a lista mostra UMA linha por lancamento e Excluir remove apenas o
        *-- registro corrente (chave cidchaves). Excluir o grupo+conta inteiro fica
        *-- por conta de Alterar (remover as ocorrencias) — Erro148.
        loc_lConfirmar = MsgConfirma("Confirma a exclus" + CHR(227) + "o do lan" + CHR(231) + "amento" + CHR(13) + ;
                                     "grupo '" + loc_cGrupos + "' / conta '" + loc_cContas + ;
                                     "' / opera" + CHR(231) + CHR(227) + "o '" + loc_cCocos + "'?", ;
                                     "Confirmar Exclus" + CHR(227) + "o")

        IF loc_lConfirmar
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Lan" + CHR(231) + "amento exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                    THIS.CarregarLista()
                ENDIF
            ELSE
                MsgErro("Erro ao carregar lan" + CHR(231) + "amento para exclus" + CHR(227) + "o.", "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega a lista aplicando filtro atual
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salva ocorrencias do grupo+conta (modo INSERIR/ALTERAR)
    *                  ou habilita grid de pesquisa (modo PROCURAR)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina, loc_cGrupos, loc_cContas, loc_cGruContas
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cGrupos = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        loc_cContas = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)

        IF THIS.this_cModoAtual = "PROCURAR"
            IF !EMPTY(loc_cGrupos) AND EMPTY(loc_cContas)
                MsgAviso("Aten" + CHR(231) + CHR(227) + "o ! Para pesquisar " + CHR(233) + ;
                         " necess" + CHR(225) + "rio escolher tamb" + CHR(233) + "m a Conta.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPagina.txt_4c_Contas.SetFocus
                RETURN
            ENDIF
            *-- Recarregar ocorrencias para o grupo+conta informado
            loc_cGruContas = PADR(loc_cGrupos, 10) + PADR(loc_cContas, 10)
            THIS.this_cGruContasAtual = loc_cGruContas
            THIS.CarregarPaginaDados(loc_cGruContas)
            *-- Habilitar grid para visualizacao (criado na Fase 6)
            IF PEMSTATUS(loc_oPagina, "grd_4c_Ocorrencias", 5)
                loc_oPagina.grd_4c_Ocorrencias.Enabled = .T.
            ENDIF
            RETURN
        ENDIF

        IF INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
            IF EMPTY(loc_cGrupos)
                MsgAviso("Obrigat" + CHR(243) + "rio Informar o Grupo", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPagina.txt_4c_Grupo.SetFocus
                RETURN
            ENDIF
            IF EMPTY(loc_cContas)
                MsgAviso("Obrigat" + CHR(243) + "rio Informar a Conta", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPagina.txt_4c_Contas.SetFocus
                RETURN
            ENDIF

            *-- O registro deste cadastro E a associacao grupo+conta+ocorrencia: sem
            *-- nenhuma ocorrencia preenchida nao ha o que gravar. Antes o Salvar
            *-- seguia adiante, o BO nao inseria nada e mesmo assim era exibido
            *-- "Lancamentos salvos com sucesso!" (Erro148). Em ALTERAR a lista vazia
            *-- continua valida: significa remover todas as ocorrencias do grupo+conta.
            IF THIS.this_cModoAtual = "INSERIR" AND THIS.ContarOcorrenciasPreenchidas() = 0
                MsgAviso("Informe ao menos uma ocorr" + CHR(234) + "ncia antes de gravar.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                IF PEMSTATUS(loc_oPagina, "grd_4c_Ocorrencias", 5) AND ;
                        loc_oPagina.grd_4c_Ocorrencias.Enabled
                    loc_oPagina.grd_4c_Ocorrencias.SetFocus
                ENDIF
                RETURN
            ENDIF

            *-- Espelha a ficha no BO antes de gravar. SalvarOcorrencias recebe
            *-- grupo/conta por parametro, mas ObterChavePrimaria (auditoria) le as
            *-- PROPERTIES - sem isto a auditoria sairia com a chave do registro
            *-- anterior. FormParaBO eh o override do hook PROTECTED do FormBase.
            THIS.FormParaBO()

            *-- 4o parametro: lista vazia so eh aceita em ALTERAR (remove todas as ocorrencias)
            IF THIS.this_oBusinessObject.SalvarOcorrencias(loc_cGrupos, loc_cContas, ;
                    "cursor_4c_OcoLocal", (THIS.this_cModoAtual = "ALTERAR"))
                MsgInfo("Lan" + CHR(231) + "amentos salvos com sucesso!", "Sucesso")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ContarOcorrenciasPreenchidas - Quantas linhas do cursor local tem Cocos
    * preenchido (as unicas que o BO grava em SigClLan)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ContarOcorrenciasPreenchidas()
        LOCAL loc_nTotal, loc_nPonteiro
        loc_nTotal = 0

        IF !USED("cursor_4c_OcoLocal")
            RETURN 0
        ENDIF

        SELECT cursor_4c_OcoLocal
        loc_nPonteiro = IIF(RECCOUNT("cursor_4c_OcoLocal") > 0, RECNO(), 0)
        COUNT TO loc_nTotal FOR !EMPTY(ALLTRIM(cursor_4c_OcoLocal.Cocos))

        IF loc_nPonteiro > 0 AND loc_nPonteiro <= RECCOUNT("cursor_4c_OcoLocal")
            GO loc_nPonteiro IN cursor_4c_OcoLocal
        ENDIF

        RETURN loc_nTotal
    ENDFUNC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela a operacao e volta para a lista (Page1)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual      = "LISTA"
        THIS.this_cGrupoAtual     = ""
        THIS.this_cContaAtual     = ""
        THIS.this_cGruContasAtual = ""
        IF USED("cursor_4c_OcoLocal")
            ZAP IN cursor_4c_OcoLocal
        ENDIF
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * IniciarDescricoes - Carrega descricoes de Grupo (SigCdGcr) e Conta (SigCdCli)
    * Equivalente ao procedure inicdesc do legado
    *--------------------------------------------------------------------------
    PROCEDURE IniciarDescricoes()
        LOCAL loc_oPagina, loc_cGrupo, loc_cConta, loc_nRes, loc_cSQL
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF NOT PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
            RETURN
        ENDIF

        loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        loc_cConta = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)

        *-- Busca descricao do grupo em SigCdGcr (Codigos/Descrs com 'r')
        IF !EMPTY(loc_cGrupo)
            TRY
                loc_cSQL = "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
                IF USED("cursor_4c_TmpGrupo")
                    USE IN cursor_4c_TmpGrupo
                ENDIF
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpGrupo")
                IF loc_nRes >= 0 AND USED("cursor_4c_TmpGrupo") AND RECCOUNT("cursor_4c_TmpGrupo") > 0
                    SELECT cursor_4c_TmpGrupo
                    loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
                ELSE
                    loc_oPagina.txt_4c_Desc_Gru.Value = ""
                ENDIF
            CATCH TO loException
                MsgErro("Erro ao carregar descri" + CHR(231) + CHR(227) + "o do grupo: " + loException.Message, "Erro")
            ENDTRY
            IF USED("cursor_4c_TmpGrupo")
                USE IN cursor_4c_TmpGrupo
            ENDIF
        ELSE
            loc_oPagina.txt_4c_Desc_Gru.Value = ""
        ENDIF

        *-- Busca descricao da conta em SigCdCli (Iclis/Rclis)
        IF !EMPTY(loc_cConta)
            TRY
                loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta)
                IF USED("cursor_4c_TmpConta")
                    USE IN cursor_4c_TmpConta
                ENDIF
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpConta")
                IF loc_nRes >= 0 AND USED("cursor_4c_TmpConta") AND RECCOUNT("cursor_4c_TmpConta") > 0
                    SELECT cursor_4c_TmpConta
                    loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
                ELSE
                    loc_oPagina.txt_4c_Desc_Con.Value = ""
                ENDIF
            CATCH TO loException
                MsgErro("Erro ao carregar descri" + CHR(231) + CHR(227) + "o da conta: " + loException.Message, "Erro")
            ENDTRY
            IF USED("cursor_4c_TmpConta")
                USE IN cursor_4c_TmpConta
            ENDIF
        ELSE
            loc_oPagina.txt_4c_Desc_Con.Value = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupoLostFocus - Valida/lookup do codigo de Grupo ao sair do campo
    * Substitui fAcessoContab() do legado usando SQL + FormBuscaAuxiliar
    *
    * Wrapper FINO: o corpo tem RETURN antecipado (campo vazio) e o picker eh
    * MODAL - setar/limpar a flag no proprio corpo deixaria ela ligada para
    * sempre nesse caminho, matando o lookup pelo resto da vida do form.
    * Liberar aqui eh imune a RETURN (regra #47).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupoLostFocus
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarGrupoLostFocusExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupoLostFocusExec - Corpo da validacao de Grupo
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupoLostFocusExec
        LOCAL loc_oPagina, loc_cGrupo, loc_cSQL, loc_nRes, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)

        IF EMPTY(loc_cGrupo)
            loc_oPagina.txt_4c_Desc_Gru.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")

            IF loc_nRes >= 0 AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
                SELECT cursor_4c_BuscaGrupo
                loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
                loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
            ELSE
                IF USED("cursor_4c_BuscaGrupo")
                    USE IN cursor_4c_BuscaGrupo
                ENDIF
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cGrupo, ;
                    "Grupo de Conta Corrente")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
                        SELECT cursor_4c_BuscaGrupo
                        loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
                        loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
                    ELSE
                        *-- Regra #50: dispensar o picker NAO eh erro. O codigo
                        *-- DIGITADO fica (o legado nunca limpa: o Valid do
                        *-- Get_Grupos so chama fAcessoContab). Apagar aqui obriga
                        *-- o usuario a redigitar e ainda perde o prefixo LIKE da
                        *-- proxima abertura. Limpar SO a descricao.
                        loc_oPagina.txt_4c_Desc_Gru.Value = ""
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao validar grupo: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarContaLostFocus - Valida/lookup do codigo de Conta ao sair do campo
    * Substitui fAcessoContas() do legado usando SQL + FormBuscaAuxiliar
    * Wrapper FINO pelo mesmo motivo do ValidarGrupoLostFocus (regra #47).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarContaLostFocus
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarContaLostFocusExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarContaLostFocusExec - Corpo da validacao de Conta
    *--------------------------------------------------------------------------
    PROCEDURE ValidarContaLostFocusExec
        LOCAL loc_oPagina, loc_cConta, loc_cSQL, loc_nRes, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cConta  = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)

        IF EMPTY(loc_cConta)
            loc_oPagina.txt_4c_Desc_Con.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta)
            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")

            IF loc_nRes >= 0 AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
                SELECT cursor_4c_BuscaConta
                loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
                loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
            ELSE
                IF USED("cursor_4c_BuscaConta")
                    USE IN cursor_4c_BuscaConta
                ENDIF
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdCli", "cursor_4c_BuscaConta", "Iclis", loc_cConta, ;
                    "Conta Corrente")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Iclis",  "", "Conta")
                        loc_oBusca.mAddColuna("Rclis",  "", "Nome")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
                        SELECT cursor_4c_BuscaConta
                        loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
                        loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
                    ELSE
                        *-- Regra #50: idem Grupo. O legado (Get_Contas.Valid) so
                        *-- AVISA "Conta Invalida (Acesso Negado)!!" quando
                        *-- fAcessoContas recusa - nunca apaga o que foi digitado.
                        loc_oPagina.txt_4c_Desc_Con.Value = ""
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao validar conta: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos e botoes de acordo com o modo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lEditarIdentif, loc_lEditarOco
        loc_oPagina        = THIS.pgf_4c_Paginas.Page2
        loc_lEditarIdentif = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INSERIR", "PROCURAR")
        loc_lEditarOco     = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")

        IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
            loc_oPagina.txt_4c_Grupo.Enabled = loc_lEditarIdentif
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Contas", 5)
            loc_oPagina.txt_4c_Contas.Enabled = loc_lEditarIdentif
        ENDIF
        *-- Descricoes NAO sao sempre read-only: o legado as abre como 2a porta de
        *-- entrada (When de Get_Desc_Gru/Get_Desc_Con). Condicao num lugar so.
        THIS.AtualizarCamposDescricao()

        *-- Grid de ocorrencias: editavel apenas em INSERIR/ALTERAR
        IF PEMSTATUS(loc_oPagina, "grd_4c_Ocorrencias", 5)
            IF loc_lEditarOco
                loc_oPagina.grd_4c_Ocorrencias.ReadOnly = .F.
                loc_oPagina.grd_4c_Ocorrencias.Enabled  = .T.
                *-- Grid.ReadOnly propaga para as colunas: repor DEPOIS. Descricao
                *-- nao eh digitavel (legado: Column1.Text1.When = .F.)
                loc_oPagina.grd_4c_Ocorrencias.Column1.ReadOnly = .F.
                loc_oPagina.grd_4c_Ocorrencias.Column2.ReadOnly = .T.
            ELSE
                loc_oPagina.grd_4c_Ocorrencias.ReadOnly = .T.
                loc_oPagina.grd_4c_Ocorrencias.Enabled  = .F.
            ENDIF
        ENDIF

        *-- Botoes inserir/excluir de ocorrencias: visiveis apenas em INSERIR/ALTERAR
        IF PEMSTATUS(loc_oPagina, "cmd_4c_InserirOco", 5)
            loc_oPagina.cmd_4c_InserirOco.Visible = loc_lEditarOco
        ENDIF
        IF PEMSTATUS(loc_oPagina, "cmd_4c_ExcluirOco", 5)
            loc_oPagina.cmd_4c_ExcluirOco.Visible = loc_lEditarOco
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOcorrenciaGrade - Valid da celula Ocorrencia (TextBoxOcorrencia_4c)
    * Transcreve Gradeoco.Column2.Text1.Valid do legado: so age se o valor mudou;
    * lookup em SigCcCco (exato -> picker); ESC limpa; duplicidade limpa e
    * mantem o foco na celula. PUBLIC: chamado pelo Valid do TextBox (Erro191).
    * O valor digitado esta em par_oTxt.Value - o cursor so recebe DEPOIS do Valid.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOcorrenciaGrade(par_oTxt)
        LOCAL loc_cCocos, loc_cSQL, loc_nRes, loc_lRetorno
        LOCAL loc_cCocosOk, loc_cDescsOk, loc_oBusca
        LOCAL loc_nPonteiro, loc_lDuplicado
        loc_lRetorno = .T.

        IF !USED("cursor_4c_OcoLocal") OR EOF("cursor_4c_OcoLocal")
            RETURN .T.
        ENDIF

        loc_cCocos = ALLTRIM(par_oTxt.Value)

        *-- Legado: IF This.Value = ThisForm.CodAnt -> RETURN
        IF loc_cCocos == ALLTRIM(par_oTxt.this_cValorAnterior)
            RETURN .T.
        ENDIF

        SELECT cursor_4c_OcoLocal

        *-- Cocos vazio: limpar descs e sair
        IF EMPTY(loc_cCocos)
            REPLACE descs WITH ""
            RETURN .T.
        ENDIF

        loc_cCocosOk = ""
        loc_cDescsOk = ""

        TRY
            loc_cSQL = "SELECT Cods, Descs FROM SigCcCco WHERE Cods = " + EscaparSQL(loc_cCocos)
            IF USED("cursor_4c_BuscaCoco")
                USE IN cursor_4c_BuscaCoco
            ENDIF
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCoco")

            IF loc_nRes >= 0 AND USED("cursor_4c_BuscaCoco") AND RECCOUNT("cursor_4c_BuscaCoco") > 0
                SELECT cursor_4c_BuscaCoco
                loc_cCocosOk = ALLTRIM(Cods)
                loc_cDescsOk = ALLTRIM(Descs)
            ELSE
                *-- Pattern A canonico (Erro114/Pattern #166): a SQL fica no caller e o
                *-- picker recebe um cursor JA populado. O Pattern B (CREATEOBJECT com
                *-- parametros) fechava o cursor quando nem o codigo exato nem o prefixo
                *-- batiam, e a janela "Selecao" abria vazia, sem colunas e sem explicacao
                *-- (Erro149). Aqui: prefixo em Cods OU Descs -> fallback mostrando tudo
                *-- -> aviso explicito quando nao ha ocorrencia cadastrada.
                IF USED("cursor_4c_BuscaCoco")
                    USE IN cursor_4c_BuscaCoco
                ENDIF

                loc_cSQL = "SELECT Cods, Descs FROM SigCcCco" + ;
                           " WHERE Cods LIKE "  + EscaparSQL(loc_cCocos + "%") + ;
                           " OR Descs LIKE " + EscaparSQL(loc_cCocos + "%") + ;
                           " ORDER BY Cods"
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCoco")

                *-- Fallback SHOW-ALL: prefixo nao bateu, mas pode haver outras ocorrencias
                IF loc_nRes >= 0 AND USED("cursor_4c_BuscaCoco") AND RECCOUNT("cursor_4c_BuscaCoco") = 0
                    USE IN cursor_4c_BuscaCoco
                    loc_cSQL = "SELECT Cods, Descs FROM SigCcCco ORDER BY Cods"
                    loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCoco")
                ENDIF

                IF loc_nRes >= 0 AND USED("cursor_4c_BuscaCoco") AND RECCOUNT("cursor_4c_BuscaCoco") > 0
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.DefinirCursor("cursor_4c_BuscaCoco", "Cods", "Descs", ;
                            "Sele" + CHR(231) + CHR(227) + "o")
                        *-- DefinirCursor titula as colunas com o nome do campo; repor os
                        *-- titulos do legado (fwBuscaExt: 'Codigo' / 'Descricao')
                        loc_oBusca.this_nColunas = 0
                        loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")

                        IF loc_oBusca.Mostrar()
                            loc_cCocosOk = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                            loc_cDescsOk = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
                        ELSE
                            loc_cCocosOk = ""
                            loc_cDescsOk = ""
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                ELSE
                    MsgAviso("Nenhuma ocorr" + CHR(234) + "ncia cadastrada.", ;
                             "Sele" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF

            *-- Verificar duplicidade de cocos no cursor local
            SELECT cursor_4c_OcoLocal
            loc_nPonteiro  = RECNO()
            loc_lDuplicado = .F.

            IF !EMPTY(loc_cCocosOk)
                SET ORDER TO Cocos
                IF SEEK(PADR(loc_cCocosOk, 2))
                    IF RECNO() != loc_nPonteiro
                        loc_lDuplicado = .T.
                    ENDIF
                ENDIF
                SET ORDER TO
                GO loc_nPonteiro
            ENDIF

            *-- O TextBox grava no ControlSource DEPOIS do Valid: o .Value tem de
            *-- receber o mesmo que o cursor, senao o texto digitado volta por cima
            IF loc_lDuplicado
                MsgAviso("J" + CHR(225) + " existe um registro com este grupo, conta e ocorr" + CHR(234) + "ncia ...", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                REPLACE Cocos WITH ""
                REPLACE descs WITH ""
                par_oTxt.Value = ""
                loc_lRetorno   = .F.     && legado: Return 0 - fica na celula
            ELSE
                REPLACE Cocos WITH loc_cCocosOk
                REPLACE descs WITH loc_cDescsOk
                par_oTxt.Value = loc_cCocosOk
            ENDIF
            par_oTxt.this_cValorAnterior = par_oTxt.Value

            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Ocorrencias", 5)
                THIS.pgf_4c_Paginas.Page2.grd_4c_Ocorrencias.Column2.Refresh()
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao validar ocorr" + CHR(234) + "ncia: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaCoco")
            USE IN cursor_4c_BuscaCoco
        ENDIF

        RETURN loc_lRetorno
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInserirOcoClick - Insere linha em branco no cursor de ocorrencias
    *--------------------------------------------------------------------------
    PROCEDURE BtnInserirOcoClick()
        LOCAL loc_oPagina, loc_cGrupos, loc_cContas
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF NOT INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
            RETURN
        ENDIF

        IF NOT PEMSTATUS(loc_oPagina, "grd_4c_Ocorrencias", 5)
            RETURN
        ENDIF

        loc_cGrupos = ""
        loc_cContas = ""
        IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
            loc_cGrupos = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
            loc_cContas = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
        ENDIF

        TRY
            SELECT cursor_4c_OcoLocal
            APPEND BLANK
            REPLACE Grupos WITH loc_cGrupos
            REPLACE Contas WITH loc_cContas
            loc_oPagina.grd_4c_Ocorrencias.Refresh()
            loc_oPagina.grd_4c_Ocorrencias.Column1.SetFocus
        CATCH TO loException
            MsgErro("Erro ao inserir ocorr" + CHR(234) + "ncia: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirOcoClick - Exclui linha corrente do cursor de ocorrencias
    * Mantem ao menos uma linha em branco para nova entrada (padrao legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirOcoClick()
        LOCAL loc_oPagina, loc_cGrupos, loc_cContas
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF NOT INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
            RETURN
        ENDIF

        IF NOT PEMSTATUS(loc_oPagina, "grd_4c_Ocorrencias", 5)
            RETURN
        ENDIF

        IF NOT USED("cursor_4c_OcoLocal") OR RECCOUNT("cursor_4c_OcoLocal") = 0
            RETURN
        ENDIF

        loc_cGrupos = ""
        loc_cContas = ""
        IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
            loc_cGrupos = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
            loc_cContas = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
        ENDIF

        TRY
            SELECT cursor_4c_OcoLocal
            DELETE
            GO BOTTOM
            IF EOF()
                APPEND BLANK
                REPLACE Grupos WITH loc_cGrupos
                REPLACE Contas WITH loc_cContas
            ENDIF
            loc_oPagina.grd_4c_Ocorrencias.Refresh()
            loc_oPagina.grd_4c_Ocorrencias.Column1.SetFocus
        CATCH TO loException
            MsgErro("Erro ao excluir ocorr" + CHR(234) + "ncia: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrupoKeyPress - Handler KeyPress de txt_4c_Grupo: F4 abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GrupoDblClick - Handler DblClick de txt_4c_Grupo
    *--------------------------------------------------------------------------
    PROCEDURE GrupoDblClick()
        THIS.AbrirLookupGrupo()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGrupo - Abre FormBuscaAuxiliar para Grupo (SigCdGcr)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupGrupo()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        IF NOT PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
            RETURN
        ENDIF
        IF NOT loc_oPagina.txt_4c_Grupo.Enabled
            RETURN
        ENDIF

        *-- Guarda de reentrancia SAVE/RESTORE (regra #47): este funil tambem eh
        *-- chamado de F4/DblClick enquanto o LostFocus pode estar no ar; clear
        *-- fixo liberaria a flag cedo demais e abriria um 2o picker.
        *-- Setada DEPOIS dos RETURN de guarda acima, por isso nao trava ligada.
        LOCAL loc_oBusca, loc_lEmLookupAnt
        loc_lEmLookupAnt    = THIS.this_lEmLookup
        THIS.this_lEmLookup = .T.

        TRY
            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", "", ;
                "Grupo de Conta Corrente")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
                    SELECT cursor_4c_BuscaGrupo
                    loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
                    loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao abrir lookup de Grupo: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF

        THIS.this_lEmLookup = loc_lEmLookupAnt
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaKeyPress - Handler KeyPress de txt_4c_Contas: F4 abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE ContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaDblClick - Handler DblClick de txt_4c_Contas
    *--------------------------------------------------------------------------
    PROCEDURE ContaDblClick()
        THIS.AbrirLookupConta()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupConta - Abre FormBuscaAuxiliar para Conta (SigCdCli)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupConta()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        IF NOT PEMSTATUS(loc_oPagina, "txt_4c_Contas", 5)
            RETURN
        ENDIF
        IF NOT loc_oPagina.txt_4c_Contas.Enabled
            RETURN
        ENDIF

        *-- Guarda de reentrancia SAVE/RESTORE - ver AbrirLookupGrupo (regra #47)
        LOCAL loc_oBusca, loc_lEmLookupAnt
        loc_lEmLookupAnt    = THIS.this_lEmLookup
        THIS.this_lEmLookup = .T.

        TRY
            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaConta", "Iclis", "", ;
                "Conta Corrente")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Iclis",  "", "Conta")
                loc_oBusca.mAddColuna("Rclis",  "", "Nome")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
                    SELECT cursor_4c_BuscaConta
                    loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
                    loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao abrir lookup de Conta: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF

        THIS.this_lEmLookup = loc_lEmLookupAnt
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarCamposDescricao - Reavalia o "When" legado dos campos de descricao
    *
    * Legado:
    *   Get_Desc_Gru.When = IsEmpty(get_grupos.value) AND Inlist(pcEscolha,"PROCURAR")
    *   Get_Desc_Con.When = IsEmpty(get_contas.value) AND Inlist(pcEscolha,"INSERIR","PROCURAR")
    *
    * O When eh reavaliado pelo VFP a CADA chegada de foco. Aqui a condicao mora
    * num metodo PUBLIC unico (regra #45), chamado em TODO caminho que mexe nos
    * codigos: fim do ConfigurarPaginaDados, HabilitarCampos, LimparCampos,
    * CarregarPaginaDados, os lookups e o InteractiveChange dos codigos.
    * PUBLIC porque eh alvo de BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarCamposDescricao()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Desc_Gru", 5)
            loc_oPagina.txt_4c_Desc_Gru.ReadOnly = !THIS.DescGrupoPodeDigitar()
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Desc_Con", 5)
            loc_oPagina.txt_4c_Desc_Con.ReadOnly = !THIS.DescContaPodeDigitar()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DescGrupoPodeDigitar - Condicao do Get_Desc_Gru.When legado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION DescGrupoPodeDigitar()
        LOCAL loc_oPagina, loc_lPode
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_lPode   = .F.

        IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
            loc_lPode = EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)) AND ;
                        INLIST(THIS.this_cModoAtual, "PROCURAR")
        ENDIF

        RETURN loc_lPode
    ENDFUNC

    *--------------------------------------------------------------------------
    * DescContaPodeDigitar - Condicao do Get_Desc_Con.When legado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION DescContaPodeDigitar()
        LOCAL loc_oPagina, loc_lPode
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_lPode   = .F.

        IF PEMSTATUS(loc_oPagina, "txt_4c_Contas", 5)
            loc_lPode = EMPTY(ALLTRIM(loc_oPagina.txt_4c_Contas.Value)) AND ;
                        INLIST(THIS.this_cModoAtual, "INSERIR", "PROCURAR")
        ENDIF

        RETURN loc_lPode
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDescGrupoLostFocus - Valid de Get_Desc_Gru (2a porta de entrada)
    *
    * Wrapper FINO (regra #47): o corpo tem RETURN antecipado e o picker eh MODAL;
    * setar/limpar a flag dentro do corpo a deixaria ligada nesses caminhos,
    * matando o lookup pelo resto da vida do form.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDescGrupoLostFocus
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarDescGrupoLostFocusExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDescGrupoLostFocusExec - Corpo do Valid de Get_Desc_Gru
    *
    * Legado: fAcessoContab(Usuar, 'C', this.value, get_grupos, get_desc_gru).
    * O pTip = "C" do legado busca por SigCdGcr.Codigos (ver utils\functions.prg:
    * "pTip - Tipo busca: C=Codigo, D=Descricao") - TRANSCRITO como esta, sem
    * reescrever para "D" (regra #17). Eh divergencia PROPOSITAL do legado em
    * relacao ao Get_Desc_Con, que passa "D"; o efeito util eh o mesmo porque o
    * FormBuscaAuxiliar cai no fallback show-all quando nada casa, e a escolha no
    * picker preenche codigo + descricao.
    * fAcessoContab/fAcessoContas NAO servem como handler de lookup: elas
    * auto-populam o primeiro registro sem o usuario escolher.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDescGrupoLostFocusExec
        LOCAL loc_oPagina, loc_cTexto, loc_cSQL, loc_nRes, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Campo ReadOnly ainda RECEBE foco e dispara LostFocus: reavaliar o When
        IF NOT THIS.DescGrupoPodeDigitar()
            RETURN
        ENDIF

        loc_cTexto = ALLTRIM(loc_oPagina.txt_4c_Desc_Gru.Value)
        IF EMPTY(loc_cTexto)
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cTexto)
            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")

            IF loc_nRes >= 0 AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
                SELECT cursor_4c_BuscaGrupo
                loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
                loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
            ELSE
                IF USED("cursor_4c_BuscaGrupo")
                    USE IN cursor_4c_BuscaGrupo
                ENDIF
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cTexto, ;
                    "Grupo de Conta Corrente")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    *-- Nada escolhido: o texto digitado FICA (regra #50) - o legado
                    *-- nao avisa nem limpa; limpar deixaria o usuario sem saida.
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
                        SELECT cursor_4c_BuscaGrupo
                        loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
                        loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o do grupo: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF

        *-- Codigo preenchido -> o When fecha o campo de descricao
        THIS.AtualizarCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * DescGrupoKeyPress - F4 no campo de descricao abre o picker de Grupo
    *--------------------------------------------------------------------------
    PROCEDURE DescGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupDescGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DescGrupoDblClick - Handler DblClick de txt_4c_Desc_Gru
    *--------------------------------------------------------------------------
    PROCEDURE DescGrupoDblClick()
        THIS.AbrirLookupDescGrupo()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDescGrupo - Picker de Grupo acionado pelo campo de descricao
    * So age quando o When legado permite digitar ali; o picker em si eh o mesmo
    * do campo de codigo (AbrirLookupGrupo), que ja traz a guarda SAVE/RESTORE.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDescGrupo()
        IF NOT THIS.DescGrupoPodeDigitar()
            RETURN
        ENDIF
        THIS.AbrirLookupGrupo()
        THIS.AtualizarCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDescContaLostFocus - Valid de Get_Desc_Con (2a porta de entrada)
    * Wrapper FINO pelo mesmo motivo do ValidarDescGrupoLostFocus (regra #47).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDescContaLostFocus
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarDescContaLostFocusExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDescContaLostFocusExec - Corpo do Valid de Get_Desc_Con
    *
    * Legado: fAcessoContas(Usuar, get_grupos.value, 'D', this.value,
    *                       get_contas, get_desc_con)
    * - pTip = "D" -> busca pela DESCRICAO (SigCdCli.rclis)
    * - pGrp = get_grupos.value -> a consulta eh FILTRADA pelo grupo corrente
    *   ("And a.Grupos = <grupo>" em utils\functions.prg), por isso o filtro
    *   adicional do FormBuscaAuxiliar (9o argumento).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDescContaLostFocusExec
        LOCAL loc_oPagina, loc_cTexto, loc_cGrupo, loc_cFiltro
        LOCAL loc_cSQL, loc_nRes, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF NOT THIS.DescContaPodeDigitar()
            RETURN
        ENDIF

        loc_cTexto = ALLTRIM(loc_oPagina.txt_4c_Desc_Con.Value)
        IF EMPTY(loc_cTexto)
            RETURN
        ENDIF

        loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        loc_cFiltro = ""
        IF !EMPTY(loc_cGrupo)
            loc_cFiltro = "grupos = " + EscaparSQL(PADR(loc_cGrupo, 10))
        ENDIF

        TRY
            loc_cSQL = "SELECT Iclis, Rclis FROM SigCdCli" + ;
                       " WHERE RTRIM(Rclis) = " + EscaparSQL(loc_cTexto)
            IF !EMPTY(loc_cFiltro)
                loc_cSQL = loc_cSQL + " AND " + loc_cFiltro
            ENDIF
            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")

            IF loc_nRes >= 0 AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") = 1
                SELECT cursor_4c_BuscaConta
                loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
                loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
            ELSE
                IF USED("cursor_4c_BuscaConta")
                    USE IN cursor_4c_BuscaConta
                ENDIF
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdCli", "cursor_4c_BuscaConta", "Rclis", loc_cTexto, ;
                    "Conta Corrente", .F., .F., loc_cFiltro)
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Iclis", "", "Conta")
                        loc_oBusca.mAddColuna("Rclis", "", "Nome")
                        loc_oBusca.Show()
                    ENDIF
                    *-- Nada escolhido: o texto digitado FICA (regra #50)
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
                        SELECT cursor_4c_BuscaConta
                        loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
                        loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o da conta: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF

        THIS.AtualizarCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * DescContaKeyPress - F4 no campo de descricao abre o picker de Conta
    *--------------------------------------------------------------------------
    PROCEDURE DescContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupDescConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DescContaDblClick - Handler DblClick de txt_4c_Desc_Con
    *--------------------------------------------------------------------------
    PROCEDURE DescContaDblClick()
        THIS.AbrirLookupDescConta()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDescConta - Picker de Conta acionado pelo campo de descricao
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDescConta()
        IF NOT THIS.DescContaPodeDigitar()
            RETURN
        ENDIF
        THIS.AbrirLookupConta()
        THIS.AtualizarCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Percorre controles recursivamente definindo Visible=.T.
    *--------------------------------------------------------------------------
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

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores dos campos da Page2 para as propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF NOT PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
            RETURN
        ENDIF

        THIS.this_oBusinessObject.this_cGrupos    = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        THIS.this_oBusinessObject.this_cContas    = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
        THIS.this_oBusinessObject.this_cGruContas = PADR(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value), 10) + ;
                                                    PADR(ALLTRIM(loc_oPagina.txt_4c_Contas.Value), 10)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para os campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF NOT PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
            RETURN
        ENDIF

        loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
        loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cContas)
        loc_oPagina.txt_4c_Desc_Gru.Value = ""
        loc_oPagina.txt_4c_Desc_Con.Value = ""
        THIS.IniciarDescricoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes de Page1 conforme dados
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_lTemRegistro
        loc_oPagina      = THIS.pgf_4c_Paginas.Page1
        loc_lTemRegistro = USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0

        IF NOT PEMSTATUS(loc_oPagina, "cnt_4c_Botoes", 5)
            RETURN
        ENDIF

        IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
            loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir.Enabled = .T.
        ENDIF
        IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
            loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
        ENDIF
        IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
            loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
        ENDIF
        IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
            loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro
        ENDIF
        IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
            loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar.Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera o Business Object e chama destruicao da classe pai
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        *-- O form NAO declara DataSession = 2, entao roda na sessao CORRENTE: os
        *-- cursores criados aqui SOBREVIVEM ao Release e ficariam abertos na
        *-- sessao global, colidindo na proxima abertura da tela.
        TRY
            IF USED("cursor_4c_OcoLocal")
                USE IN cursor_4c_OcoLocal
            ENDIF
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_Ocorrencias")
                USE IN cursor_4c_Ocorrencias
            ENDIF
            IF USED("cursor_4c_TmpGrupo")
                USE IN cursor_4c_TmpGrupo
            ENDIF
            IF USED("cursor_4c_TmpConta")
                USE IN cursor_4c_TmpConta
            ENDIF
            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF
            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
            IF USED("cursor_4c_BuscaCoco")
                USE IN cursor_4c_BuscaCoco
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSIGPRLNC.Destroy")
        ENDTRY

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

*==============================================================================
* TextBoxOcorrencia_4c - celula Ocorrencia da grd_4c_Ocorrencias (Erro191)
* Transcreve Gradeoco.Column2.Text1 do legado: When guarda o valor anterior
* (ThisForm.CodAnt) e Valid delega ao form. Eventos embutidos na classe porque
* BINDEVENT em Valid de TextBox dentro de Column nao dispara de forma confiavel.
*==============================================================================
DEFINE CLASS TextBoxOcorrencia_4c AS TextBox
    this_cValorAnterior = ""

    PROCEDURE When()
        THIS.this_cValorAnterior = NVL(THIS.Value, "")
        RETURN .T.
    ENDPROC

    PROCEDURE Valid()
        LOCAL loc_lRetorno
        loc_lRetorno = .T.
        IF PEMSTATUS(THISFORM, "ValidarOcorrenciaGrade", 5)
            loc_lRetorno = THISFORM.ValidarOcorrenciaGrade(THIS)
        ENDIF
        RETURN loc_lRetorno
    ENDPROC
ENDDEFINE
