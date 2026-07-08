*==============================================================================
* Formsigmvcab.prg - Formulario de Movimentacao de Estoque (Cabecalho)
* Data: 2026-03-22
* Tabela: SigMvCab | PK: EmpDopNums (composta: Emps + Dopes + Numes)
* Legado: SIGMVCAB.SCX (frmcadastro, Width=1000, Height=600)
* FASE 4/8 - Grid, botoes CRUD, filtros, indicadores, AlternarPagina
*==============================================================================

DEFINE CLASS Formsigmvcab AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Movimenta" + CHR(231) + CHR(227) + "o de Estoque"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    ClipControls = .F.
    Themes      = .F.
    BorderStyle = 2
    KeyPreview  = .T.

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""    && OBRIGATORIO - nao herdado de FormBase
    this_cModoAtual      = ""    && LISTA | INCLUIR | ALTERAR | VISUALIZAR

    *--------------------------------------------------------------------------
    * Propriedades de controle operacional (legado: form-level custom properties)
    *--------------------------------------------------------------------------
    this_lPlitem          = .T.     && plitem
    this_cPcaixa          = ""      && pcaixa
    this_lPodatamgr5      = .F.     && podatamgr5
    this_cDataabertura    = ""      && dataabertura
    this_lPodatamgr6      = .F.     && podatamgr6
    this_lLibpend         = .F.     && libpend
    this_lCfopsubn        = .F.     && cfopsubn
    this_lCnfliquido      = .F.     && cnfliquido
    this_lRcviss          = .F.     && rcviss
    this_lRcvirf          = .F.     && rcvirf
    this_lRcvinss         = .F.     && rcvinss
    this_lRcvpis          = .F.     && rcvpis
    this_lRcvcofins       = .F.     && rcvcofins
    this_lRcvcsll         = .F.     && rcvcsll
    this_lLiberapend      = .F.     && liberapend
    this_lAltgerente      = .F.     && altgerente
    this_lUsuvendedor     = .F.     && usuvendedor
    this_lChecavd         = .F.     && checavd
    this_lNoccf           = .F.     && noccf
    this_lNocoo           = .F.     && nocoo
    this_lPedido          = .F.     && pedido
    this_lGtecf           = .F.     && gtecf
    this_lTotcanc         = .F.     && totcanc
    this_lPoobjext1       = .F.     && poobjext1
    this_lAntcpro         = .F.     && antcpro
    this_lProdutopai      = .F.     && produtopai
    this_lQtdesmemb       = .F.     && qtdesmemb
    this_lAbriuitem2      = .F.     && abriuitem2
    this_lAbriuitem3      = .F.     && abriuitem3
    this_lBuscaproduto    = .F.     && buscaproduto
    this_lFoco            = .F.     && foco
    this_lCongela         = .F.     && congela
    this_lOldcodbarras    = .F.     && oldcodbarras
    this_lValidok         = .F.     && validok
    this_lDesmembrou      = .F.     && desmembrou
    this_lAntvalu         = .F.     && antvalu
    this_lPreencheu1      = .F.     && preencheu1
    this_lLautpreco       = .F.     && lautpreco
    this_lAntqtd          = .F.     && antqtd
    this_lGeramultipla    = .F.     && geramultipla
    this_lLnovalinha      = .F.     && lnovalinha
    this_lAntqtdbx        = .F.     && antqtdbx
    this_lOldpreco        = .F.     && oldpreco
    this_cCdynbackcolor   = ""      && cdynbackcolor
    this_nNgraderecno     = 0       && ngraderecno
    this_lLwhengetobs     = .F.     && lwhengetobs
    this_cColdcodcors     = ""      && coldcodcors
    this_lLeditacor       = .F.     && leditacor
    this_lLeditatam       = .F.     && leditatam
    this_cColdcodtams     = ""      && coldcodtams
    this_lTpcsg           = .F.     && tpcsg
    this_lInibirpeso      = .F.     && inibirpeso
    this_lMultidefault    = .F.     && multidefault
    this_lNtpopers        = .F.     && ntpopers
    this_lPnrateioitem    = .F.     && pnrateioitem
    this_lMultemps        = .F.     && multemps
    this_lChecouvencs     = .F.     && checouvencs
    this_lNumeratitulo    = .F.     && numeratitulo
    this_lTitbans         = .F.     && titbans
    this_lCfgtitorigem    = .F.     && cfgtitorigem
    this_lCfgtitdestino   = .F.     && cfgtitdestino
    this_lCfgtitvendedor  = .F.     && cfgtitvendedor
    this_lCfgtitresponsavel = .F.   && cfgtitresponsavel
    this_lCfgtitlistavends  = .F.   && cfgtitlistavends
    this_lCfgtitjob       = .F.     && cfgtitjob
    this_lCfgtitpublicidade = .F.   && cfgtitpublicidade
    this_lCfgtitcomissao  = .F.     && cfgtitcomissao
    this_lEditajob        = .F.     && editajob
    this_lImpostof        = .F.     && impostof
    this_lImpostoe        = .F.     && impostoe
    this_lImpostom        = .F.     && impostom
    this_lEtiquetaauto    = .F.     && etiquetaauto
    this_lValidacambio    = .F.     && validacambio
    this_lPlacinserir     = .T.     && placinserir
    this_lPlacexcluir     = .T.     && placexcluir
    this_lPlacalterar     = .T.     && placalterar

    *--------------------------------------------------------------------------
    * Init - Inicializacao do formulario
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao inicial do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Criar instancia do Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("sigmvcabBO")

            IF ISNULL(THIS.this_oBusinessObject)
                THIS.this_cMensagemErro = "Erro ao criar Business Object sigmvcabBO"
                loc_lSucesso = .F.
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Pula CarregarLista() se estiver validando UI (sem conexao SQL)
                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao inicializar Formsigmvcab:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + loException.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura o PageFrame principal (pagina)
    * Legado: pagina Top=-30, Left=0, Width=1004, Height=635, 2 pages
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -30
            .Left      = 0
            .Width     = 1004
            .Height    = 635
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.
            .Themes    = .F.

            *-- Page1 - Lista (legado: pagina.lista)
            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            *-- Page2 - Dados (legado: pagina.dados)
            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Lista)
    * Compensacao +30 aplicada a todos os controles (Top legado + 30)
    * Legado: cntSombra Top=2, grade Top=143, grupo_op Top=0, cntFiltros Top=84
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oBtn
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container de cabecalho (legado: cntSombra Top=2->32, Width=1007, Height=80)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 32
            .Left        = 0
            .Width       = 1007
            .Height      = 80
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Label titulo no cabecalho
        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o de Estoque"
            .Top       = 20
            .Left      = 20
            .Width     = 400
            .Height    = 30
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (legado: grupo_op Left=542, Top=0->30, Width=385, Height=85)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 30
            .Left        = 542
            .Width       = 385
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Inserir (legado: grupo_op.Inserir Left=5, Top=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Inserir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Inserir
            .Top             = 5
            .Left            = 5
            .Width           = 70
            .Height          = 75
            .Caption         = "Inserir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_incluir.jpg"
            .PicturePosition = 1
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Inserir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Consultar (legado: grupo_op.Consultar Left=80, Top=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Consultar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Consultar
            .Top             = 5
            .Left            = 80
            .Width           = 70
            .Height          = 75
            .Caption         = "Consultar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_visualizar.jpg"
            .PicturePosition = 1
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Consultar, "Click", THIS, "BtnConsultarClick")

        *-- Botao Alterar (legado: grupo_op.Alterar Left=155, Top=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Top             = 5
            .Left            = 155
            .Width           = 70
            .Height          = 75
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar.jpg"
            .PicturePosition = 1
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (legado: grupo_op.Excluir Left=230, Top=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Top             = 5
            .Left            = 230
            .Width           = 70
            .Height          = 75
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir.jpg"
            .PicturePosition = 1
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Procurar (legado: grupo_op.Procurar Left=305, Top=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Procurar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Procurar
            .Top             = 5
            .Left            = 305
            .Width           = 70
            .Height          = 75
            .Caption         = "Procurar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_buscar.jpg"
            .PicturePosition = 1
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Procurar, "Click", THIS, "BtnProcurarClick")

        *-- Container botao saida (legado: grupo_saida Left=917, Top=0->30, Width=85, Height=85)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 30
            .Left        = 917
            .Width       = 85
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- Botao Sair (legado: grupo_saida.Sair Left=5, Top=5)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Sair", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Sair
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair.jpg"
            .PicturePosition = 1
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Sair, "Click", THIS, "BtnSairClick")

        *-- Container de filtros (legado: cntFiltros Top=84->114, Left=28, Width=487, Height=56)
        loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
        WITH loc_oPagina.cnt_4c_Filtros
            .Top         = 114
            .Left        = 28
            .Width       = 487
            .Height      = 56
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Sub-container Periodo (legado: Cnt_periodo Top=1, Left=-5, Width=252, Height=52)
        loc_oPagina.cnt_4c_Filtros.AddObject("cnt_4c_Periodo", "Container")
        WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo
            .Top         = 1
            .Left        = -5
            .Width       = 252
            .Height      = 52
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Label Empresa
        loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.lbl_4c_Empresa
            .Caption   = "Empresa :"
            .Top       = 7
            .Left      = 11
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Empresa
        loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_Empresa
            .Top       = 3
            .Left      = 64
            .Width     = 35
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label Periodo
        loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.lbl_4c_Periodo
            .Caption   = "Per" + CHR(237) + "odo :"
            .Top       = 32
            .Left      = 16
            .Width     = 45
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Data Inicial
        loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_DtInicial
            .Top       = 28
            .Left      = 64
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Format    = "K"
            .Visible   = .T.
        ENDWITH

        *-- Label separador
        loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.AddObject("lbl_4c_Separador", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.lbl_4c_Separador
            .Caption   = CHR(150)
            .Top       = 32
            .Left      = 146
            .Width     = 10
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Data Final
        loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_DtFinal
            .Top       = 28
            .Left      = 157
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Format    = "K"
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Ordem (legado: Op_Ordem Left=236, Top=11, Width=198, Height=14, 3 botoes)
        loc_oPagina.cnt_4c_Filtros.AddObject("opt_4c_Ordem", "OptionGroup")
        loc_oPagina.cnt_4c_Filtros.opt_4c_Ordem.ButtonCount = 3
        WITH loc_oPagina.cnt_4c_Filtros.opt_4c_Ordem
            .Top       = 11
            .Left      = 236
            .Width     = 198
            .Height    = 14
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        loc_oPagina.cnt_4c_Filtros.opt_4c_Ordem.Buttons(1).Caption   = "Global"
        loc_oPagina.cnt_4c_Filtros.opt_4c_Ordem.Buttons(1).AutoSize  = .T.
        loc_oPagina.cnt_4c_Filtros.opt_4c_Ordem.Buttons(1).Left      = 0
        loc_oPagina.cnt_4c_Filtros.opt_4c_Ordem.Buttons(1).Top       = 0
        loc_oPagina.cnt_4c_Filtros.opt_4c_Ordem.Buttons(1).FontName  = "Tahoma"
        loc_oPagina.cnt_4c_Filtros.opt_4c_Ordem.Buttons(1).FontSize  = 8
        loc_oPagina.cnt_4c_Filtros.opt_4c_Ordem.Buttons(2).Caption   = "Pendentes"
        loc_oPagina.cnt_4c_Filtros.opt_4c_Ordem.Buttons(2).AutoSize  = .T.
        loc_oPagina.cnt_4c_Filtros.opt_4c_Ordem.Buttons(2).Left      = 60
        loc_oPagina.cnt_4c_Filtros.opt_4c_Ordem.Buttons(2).Top       = 0
        loc_oPagina.cnt_4c_Filtros.opt_4c_Ordem.Buttons(2).FontName  = "Tahoma"
        loc_oPagina.cnt_4c_Filtros.opt_4c_Ordem.Buttons(2).FontSize  = 8
        loc_oPagina.cnt_4c_Filtros.opt_4c_Ordem.Buttons(3).Caption   = "Baixadas"
        loc_oPagina.cnt_4c_Filtros.opt_4c_Ordem.Buttons(3).AutoSize  = .T.
        loc_oPagina.cnt_4c_Filtros.opt_4c_Ordem.Buttons(3).Left      = 135
        loc_oPagina.cnt_4c_Filtros.opt_4c_Ordem.Buttons(3).Top       = 0
        loc_oPagina.cnt_4c_Filtros.opt_4c_Ordem.Buttons(3).FontName  = "Tahoma"
        loc_oPagina.cnt_4c_Filtros.opt_4c_Ordem.Buttons(3).FontSize  = 8

        *-- OptionGroup Pago (legado: op_Pago Left=236, Top=29, Width=183, Height=14, 3 botoes)
        loc_oPagina.cnt_4c_Filtros.AddObject("opt_4c_Pago", "OptionGroup")
        loc_oPagina.cnt_4c_Filtros.opt_4c_Pago.ButtonCount = 3
        WITH loc_oPagina.cnt_4c_Filtros.opt_4c_Pago
            .Top       = 29
            .Left      = 236
            .Width     = 183
            .Height    = 14
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        loc_oPagina.cnt_4c_Filtros.opt_4c_Pago.Buttons(1).Caption   = "Global"
        loc_oPagina.cnt_4c_Filtros.opt_4c_Pago.Buttons(1).AutoSize  = .T.
        loc_oPagina.cnt_4c_Filtros.opt_4c_Pago.Buttons(1).Left      = 0
        loc_oPagina.cnt_4c_Filtros.opt_4c_Pago.Buttons(1).Top       = 0
        loc_oPagina.cnt_4c_Filtros.opt_4c_Pago.Buttons(1).FontName  = "Tahoma"
        loc_oPagina.cnt_4c_Filtros.opt_4c_Pago.Buttons(1).FontSize  = 8
        loc_oPagina.cnt_4c_Filtros.opt_4c_Pago.Buttons(2).Caption   = "N" + CHR(227) + "o Pagas"
        loc_oPagina.cnt_4c_Filtros.opt_4c_Pago.Buttons(2).AutoSize  = .T.
        loc_oPagina.cnt_4c_Filtros.opt_4c_Pago.Buttons(2).Left      = 60
        loc_oPagina.cnt_4c_Filtros.opt_4c_Pago.Buttons(2).Top       = 0
        loc_oPagina.cnt_4c_Filtros.opt_4c_Pago.Buttons(2).FontName  = "Tahoma"
        loc_oPagina.cnt_4c_Filtros.opt_4c_Pago.Buttons(2).FontSize  = 8
        loc_oPagina.cnt_4c_Filtros.opt_4c_Pago.Buttons(3).Caption   = "Pagas"
        loc_oPagina.cnt_4c_Filtros.opt_4c_Pago.Buttons(3).AutoSize  = .T.
        loc_oPagina.cnt_4c_Filtros.opt_4c_Pago.Buttons(3).Left      = 135
        loc_oPagina.cnt_4c_Filtros.opt_4c_Pago.Buttons(3).Top       = 0
        loc_oPagina.cnt_4c_Filtros.opt_4c_Pago.Buttons(3).FontName  = "Tahoma"
        loc_oPagina.cnt_4c_Filtros.opt_4c_Pago.Buttons(3).FontSize  = 8

        *-- Botao Carregar Lista (legado: btnCarregaLista Top=6, Left=442, Width=40, Height=40)
        loc_oPagina.cnt_4c_Filtros.AddObject("cmd_4c_CarregarLista", "CommandButton")
        WITH loc_oPagina.cnt_4c_Filtros.cmd_4c_CarregarLista
            .Top             = 6
            .Left            = 442
            .Width           = 40
            .Height          = 40
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_seta_baixo_20.jpg"
            .ToolTipText     = "Carregar Dados Para a Grade"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.cmd_4c_CarregarLista, "Click", THIS, "BtnCarregarListaClick")

        *-- Container indicadores de status (legado: Botoes Top=124->154, Left=834, Width=138, Height=19)
        loc_oPagina.AddObject("cnt_4c_Indicadores", "Container")
        WITH loc_oPagina.cnt_4c_Indicadores
            .Top         = 154
            .Left        = 834
            .Width       = 138
            .Height      = 19
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- 8 indicadores de status coloridos (legado: Botao1-Botao8)
        THIS.CriarIndicadorStatus(loc_oPagina.cnt_4c_Indicadores, "txt_4c_Ind1", 0,   RGB(255,128,64))
        THIS.CriarIndicadorStatus(loc_oPagina.cnt_4c_Indicadores, "txt_4c_Ind2", 17,  RGB(0,0,255))
        THIS.CriarIndicadorStatus(loc_oPagina.cnt_4c_Indicadores, "txt_4c_Ind3", 34,  RGB(0,255,0))
        THIS.CriarIndicadorStatus(loc_oPagina.cnt_4c_Indicadores, "txt_4c_Ind4", 51,  RGB(249,249,0))
        THIS.CriarIndicadorStatus(loc_oPagina.cnt_4c_Indicadores, "txt_4c_Ind5", 68,  RGB(255,209,164))
        THIS.CriarIndicadorStatus(loc_oPagina.cnt_4c_Indicadores, "txt_4c_Ind6", 85,  RGB(255,255,196))
        THIS.CriarIndicadorStatus(loc_oPagina.cnt_4c_Indicadores, "txt_4c_Ind7", 102, RGB(160,243,231))
        THIS.CriarIndicadorStatus(loc_oPagina.cnt_4c_Indicadores, "txt_4c_Ind8", 119, RGB(192,192,192))

        *-- Criar cursor placeholder para o grid ANTES de criar o grid
        SET NULL ON
        CREATE CURSOR cursor_4c_Lista (;
            cEmps     C(3),  ;
            cDopes    C(6),  ;
            cNumes    C(9),  ;
            dDatas    D,     ;
            cContas   C(20), ;
            cDcontas  C(60), ;
            nValor    N(15,2), ;
            cStatus   C(1),  ;
            cOper     C(6),  ;
            cDoper    C(40)  ;
        )
        SET NULL OFF

        *-- Grid principal (legado: grade Top=143->173, Left=28, Width=944, Height=456)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.ColumnCount   = 0
        loc_oPagina.grd_4c_Lista.RecordSource  = "cursor_4c_Lista"
        loc_oPagina.grd_4c_Lista.ColumnCount   = 10
        WITH loc_oPagina.grd_4c_Lista
            .Top             = 173
            .Left            = 28
            .Width           = 944
            .Height          = 456
            .FontName        = "Tahoma"
            .FontSize        = 8
            .DeleteMark      = .F.
            .RecordMark      = .F.
            .ScrollBars      = 2
            .GridLines       = 0
            .HeaderHeight    = 20
            .RowHeight       = 18
            .ReadOnly        = .T.
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH

        *-- Configurar colunas do grid (FORA do WITH - licao grid headers)
        loc_oPagina.grd_4c_Lista.Column1.ControlSource  = "cursor_4c_Lista.cEmps"
        loc_oPagina.grd_4c_Lista.Column1.Width           = 40
        loc_oPagina.grd_4c_Lista.Column1.Header1.Caption = "Emp"

        loc_oPagina.grd_4c_Lista.Column2.ControlSource  = "cursor_4c_Lista.cDopes"
        loc_oPagina.grd_4c_Lista.Column2.Width           = 55
        loc_oPagina.grd_4c_Lista.Column2.Header1.Caption = "Oper"

        loc_oPagina.grd_4c_Lista.Column3.ControlSource  = "cursor_4c_Lista.cNumes"
        loc_oPagina.grd_4c_Lista.Column3.Width           = 80
        loc_oPagina.grd_4c_Lista.Column3.Header1.Caption = "Numero"

        loc_oPagina.grd_4c_Lista.Column4.ControlSource  = "cursor_4c_Lista.dDatas"
        loc_oPagina.grd_4c_Lista.Column4.Width           = 80
        loc_oPagina.grd_4c_Lista.Column4.Header1.Caption = "Data"

        loc_oPagina.grd_4c_Lista.Column5.ControlSource  = "cursor_4c_Lista.cContas"
        loc_oPagina.grd_4c_Lista.Column5.Width           = 80
        loc_oPagina.grd_4c_Lista.Column5.Header1.Caption = "Conta"

        loc_oPagina.grd_4c_Lista.Column6.ControlSource  = "cursor_4c_Lista.cDcontas"
        loc_oPagina.grd_4c_Lista.Column6.Width           = 200
        loc_oPagina.grd_4c_Lista.Column6.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

        loc_oPagina.grd_4c_Lista.Column7.ControlSource  = "cursor_4c_Lista.nValor"
        loc_oPagina.grd_4c_Lista.Column7.Width           = 100
        loc_oPagina.grd_4c_Lista.Column7.Header1.Caption = "Valor"

        loc_oPagina.grd_4c_Lista.Column8.ControlSource  = "cursor_4c_Lista.cStatus"
        loc_oPagina.grd_4c_Lista.Column8.Width           = 40
        loc_oPagina.grd_4c_Lista.Column8.Header1.Caption = "St"

        loc_oPagina.grd_4c_Lista.Column9.ControlSource  = "cursor_4c_Lista.cOper"
        loc_oPagina.grd_4c_Lista.Column9.Width           = 55
        loc_oPagina.grd_4c_Lista.Column9.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"

        loc_oPagina.grd_4c_Lista.Column10.ControlSource = "cursor_4c_Lista.cDoper"
        loc_oPagina.grd_4c_Lista.Column10.Width          = 200
        loc_oPagina.grd_4c_Lista.Column10.Header1.Caption = "Descr.Oper"

        *-- BINDEVENT para DblClick e KeyPress no grid
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "GridListaDblClick")
        BINDEVENT(loc_oPagina.grd_4c_Lista, "KeyPress", THIS, "GridListaKeyPress")

        *-- Botoes adicionais na pagina lista (legado: Confere, ImpDoc, SubNiveis, cmdGerCsv, FPagto)
        loc_oPagina.AddObject("cmd_4c_Confere", "CommandButton")
        WITH loc_oPagina.cmd_4c_Confere
            .Top     = 600
            .Left    = 28
            .Width   = 80
            .Height  = 25
            .Caption = "Confere"
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes  = .F.
            .Visible = .F.
        ENDWITH

        loc_oPagina.AddObject("cmd_4c_ImpDoc", "CommandButton")
        WITH loc_oPagina.cmd_4c_ImpDoc
            .Top     = 600
            .Left    = 113
            .Width   = 80
            .Height  = 25
            .Caption = "Imp.Doc."
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes  = .F.
            .Visible = .F.
        ENDWITH

        loc_oPagina.AddObject("cmd_4c_SubNiveis", "CommandButton")
        WITH loc_oPagina.cmd_4c_SubNiveis
            .Top     = 600
            .Left    = 198
            .Width   = 80
            .Height  = 25
            .Caption = "SubN" + CHR(237) + "veis"
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes  = .F.
            .Visible = .F.
        ENDWITH

        loc_oPagina.AddObject("cmd_4c_GerCsv", "CommandButton")
        WITH loc_oPagina.cmd_4c_GerCsv
            .Top     = 600
            .Left    = 283
            .Width   = 80
            .Height  = 25
            .Caption = "Gerar CSV"
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes  = .F.
            .Visible = .F.
        ENDWITH

        loc_oPagina.AddObject("cmd_4c_FPagto", "CommandButton")
        WITH loc_oPagina.cmd_4c_FPagto
            .Top     = 600
            .Left    = 368
            .Width   = 80
            .Height  = 25
            .Caption = "F.Pagto"
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes  = .F.
            .Visible = .F.
        ENDWITH

        *-- Label usuario (legado: lb_Usuario)
        loc_oPagina.AddObject("lbl_4c_Usuario", "Label")
        WITH loc_oPagina.lbl_4c_Usuario
            .Top       = 32
            .Left      = 28
            .Width     = 200
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = ""
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * Compensacao +30 aplicada a todos os controles (Top legado + 30)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Salva/Cancelar (legado: grupo_salva Left=840, Top=18->48)
        loc_oPagina.AddObject("cnt_4c_BotoesSalvar", "Container")
        WITH loc_oPagina.cnt_4c_BotoesSalvar
            .Top         = 48
            .Left        = 840
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Salvar
        loc_oPagina.cnt_4c_BotoesSalvar.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesSalvar.cmd_4c_Salvar
            .Top             = 5
            .Left            = 5
            .Width           = 70
            .Height          = 75
            .Caption         = "Salvar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar.jpg"
            .PicturePosition = 1
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesSalvar.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar
        loc_oPagina.cnt_4c_BotoesSalvar.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesSalvar.cmd_4c_Cancelar
            .Top             = 5
            .Left            = 85
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar.jpg"
            .PicturePosition = 1
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesSalvar.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Container de Produto/Leilao (legado: cntProdLeilao Top=133->163, Left=452, Width=550, Height=473)
        loc_oPagina.AddObject("cnt_4c_ProdLeilao", "Container")
        WITH loc_oPagina.cnt_4c_ProdLeilao
            .Top         = 163
            .Left        = 452
            .Width       = 550
            .Height      = 473
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        *-- Conteudo (Fwgrade, pgfPagina, botoes) sera na Fase 4/5/6

        *-- Container de Observacoes (legado: cntObs Top=134->164, Left=460, Width=532, Height=466)
        loc_oPagina.AddObject("cnt_4c_Obs", "Container")
        WITH loc_oPagina.cnt_4c_Obs
            .Top         = 164
            .Left        = 460
            .Width       = 532
            .Height      = 466
            .BackStyle   = 1
            .BorderWidth = 0
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .F.
        ENDWITH
        *-- Conteudo (getCodObs, getDesObs, getObsCabMovs) sera na Fase 5/6

        *-- PageFrame Principal interno (legado: pgfPrincipal Top=135->165, Left=6, Width=447, Height=466)
        *-- 3 paginas: pgContas, pgOperacional, pgInformacoes
        loc_oPagina.AddObject("pgf_4c_Principal", "PageFrame")
        WITH loc_oPagina.pgf_4c_Principal
            .PageCount = 3
            .Top       = 165
            .Left      = 6
            .Width     = 447
            .Height    = 466
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Configurar paginas do pgfPrincipal FORA do WITH (licao #9 - Page1 not found)
        loc_oPagina.pgf_4c_Principal.Page1.FontBold   = .T.
        loc_oPagina.pgf_4c_Principal.Page1.FontName   = "Tahoma"
        loc_oPagina.pgf_4c_Principal.Page1.FontSize   = 8
        loc_oPagina.pgf_4c_Principal.Page1.Caption    = "Contas"
        loc_oPagina.pgf_4c_Principal.Page1.BackColor  = RGB(255, 255, 255)
        loc_oPagina.pgf_4c_Principal.Page1.ForeColor  = RGB(90, 90, 90)

        loc_oPagina.pgf_4c_Principal.Page2.FontBold   = .T.
        loc_oPagina.pgf_4c_Principal.Page2.FontName   = "Tahoma"
        loc_oPagina.pgf_4c_Principal.Page2.FontSize   = 8
        loc_oPagina.pgf_4c_Principal.Page2.Caption    = "Operacional"
        loc_oPagina.pgf_4c_Principal.Page2.BackColor  = RGB(255, 255, 255)
        loc_oPagina.pgf_4c_Principal.Page2.ForeColor  = RGB(90, 90, 90)

        loc_oPagina.pgf_4c_Principal.Page3.FontBold   = .T.
        loc_oPagina.pgf_4c_Principal.Page3.FontName   = "Tahoma"
        loc_oPagina.pgf_4c_Principal.Page3.FontSize   = 8
        loc_oPagina.pgf_4c_Principal.Page3.Caption    = "Informa" + CHR(231) + CHR(245) + "es"
        loc_oPagina.pgf_4c_Principal.Page3.BackColor  = RGB(255, 255, 255)
        loc_oPagina.pgf_4c_Principal.Page3.ForeColor  = RGB(90, 90, 90)

        *-- Containers dentro de pgContas (Page1 do pgfPrincipal)
        THIS.ConfigurarPgContas()

        *-- Containers dentro de pgOperacional (Page2 do pgfPrincipal)
        THIS.ConfigurarPgOperacional()

        *-- Containers dentro de pgInformacoes (Page3 do pgfPrincipal)
        THIS.ConfigurarPgInformacoes()

        *-- GradeDevol (legado: Top=26->56, Left=695, Width=101, Height=100, Visible implicitamente)
        loc_oPagina.AddObject("grd_4c_Devol", "Grid")
        WITH loc_oPagina.grd_4c_Devol
            .ColumnCount     = 1
            .DeleteMark      = .F.
            .HeaderHeight    = 16
            .Height          = 100
            .Left            = 695
            .RecordMark      = .F.
            .ScrollBars      = 2
            .Top             = 56
            .Width           = 101
            .Visible         = .F.
        ENDWITH

        *-- GradeFinanc (legado: Top=26->56, Left=696, Width=102, Height=100, Visible=.F.)
        loc_oPagina.AddObject("grd_4c_Financ", "Grid")
        WITH loc_oPagina.grd_4c_Financ
            .ColumnCount     = 4
            .FontName        = "Courier New"
            .DeleteMark      = .F.
            .GridLines       = 1
            .HeaderHeight    = 16
            .Height          = 100
            .Left            = 696
            .RecordMark      = .F.
            .ScrollBars      = 2
            .Top             = 56
            .Visible         = .F.
            .Width           = 102
        ENDWITH

        *-- GradeOperacao (legado: Top=26->56, Left=695, Width=102, Height=100, Visible=.F.)
        loc_oPagina.AddObject("grd_4c_Operacao", "Grid")
        WITH loc_oPagina.grd_4c_Operacao
            .ColumnCount     = 1
            .FontName        = "Courier New"
            .DeleteMark      = .F.
            .GridLines       = 1
            .HeaderHeight    = 16
            .Height          = 100
            .Left            = 695
            .RecordMark      = .F.
            .ScrollBars      = 2
            .Top             = 56
            .Visible         = .F.
            .Width           = 102
        ENDWITH

        *-- GradeMultiSubN (legado: Top=26->56, Left=695, Width=102, Height=100, Visible=.F.)
        loc_oPagina.AddObject("grd_4c_MultiSubN", "Grid")
        WITH loc_oPagina.grd_4c_MultiSubN
            .ColumnCount     = 1
            .FontName        = "Courier New"
            .DeleteMark      = .F.
            .GridLines       = 1
            .HeaderHeight    = 16
            .Height          = 100
            .Left            = 695
            .RecordMark      = .F.
            .ScrollBars      = 2
            .Top             = 56
            .Visible         = .F.
            .Width           = 102
        ENDWITH

        *-- Shape fundo botoes (legado: shpBtnGs, shpBtnPs)
        loc_oPagina.AddObject("shp_4c_BtnGs", "Shape")
        loc_oPagina.AddObject("shp_4c_BtnPs", "Shape")

        *-- Label TxtCaption (legado: TxtCaption)
        loc_oPagina.AddObject("lbl_4c_TxtCaption", "Label")
        WITH loc_oPagina.lbl_4c_TxtCaption
            .Top       = 30
            .Left      = 10
            .Width     = 400
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 10
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = ""
            .Visible   = .T.
        ENDWITH

        *-- CheckBox OperCred (legado: chkOperCred)
        loc_oPagina.AddObject("chk_4c_OperCred", "CheckBox")
        WITH loc_oPagina.chk_4c_OperCred
            .Value   = 0
            .Visible = .F.
        ENDWITH

        *-- Container TEF (legado: CntTefTxt Top=204->234, Left=60, Width=691, Height=127, Visible=.F.)
        THIS.AddObject("cnt_4c_TefTxt", "Container")
        WITH THIS.cnt_4c_TefTxt
            .Top         = 234
            .Left        = 60
            .Width       = 691
            .Height      = 127
            .SpecialEffect = 0
            .Visible     = .F.
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Botoes adicionais de acao na pagina de dados (Fase 4)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPgContas - Page1 do pgfPrincipal (Contas)
    * Containers: Job, Origem, Destino, Vendedor, Responsavel, ListaVendedor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPgContas()
        LOCAL loc_oPgContas
        loc_oPgContas = THIS.pgf_4c_Paginas.Page2.pgf_4c_Principal.Page1

        *-- Container Job (legado: job)
        loc_oPgContas.AddObject("cnt_4c_Job", "Container")
        WITH loc_oPgContas.cnt_4c_Job
            .Top         = 5
            .Left        = 3
            .Width       = 435
            .Height      = 50
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        *-- Controles do Job serao na Fase 5/6

        *-- Container Origem (legado: Origem)
        loc_oPgContas.AddObject("cnt_4c_Origem", "Container")
        WITH loc_oPgContas.cnt_4c_Origem
            .Top         = 58
            .Left        = 3
            .Width       = 435
            .Height      = 60
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        *-- Controles de Origem serao na Fase 5/6

        *-- Container Destino (legado: Destino)
        loc_oPgContas.AddObject("cnt_4c_Destino", "Container")
        WITH loc_oPgContas.cnt_4c_Destino
            .Top         = 121
            .Left        = 3
            .Width       = 435
            .Height      = 60
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        *-- Controles de Destino serao na Fase 5/6

        *-- Container Vendedor (legado: Vendedor)
        loc_oPgContas.AddObject("cnt_4c_Vendedor", "Container")
        WITH loc_oPgContas.cnt_4c_Vendedor
            .Top         = 184
            .Left        = 3
            .Width       = 435
            .Height      = 60
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        *-- Controles de Vendedor serao na Fase 5/6

        *-- Container Responsavel (legado: Responsavel)
        loc_oPgContas.AddObject("cnt_4c_Responsavel", "Container")
        WITH loc_oPgContas.cnt_4c_Responsavel
            .Top         = 200
            .Left        = 3
            .Width       = 435
            .Height      = 50
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        *-- Controles de Responsavel serao na Fase 5/6

        *-- Container ListaVendedor (legado: ListaVendedor Top=255, Left=3)
        loc_oPgContas.AddObject("cnt_4c_ListaVendedor", "Container")
        WITH loc_oPgContas.cnt_4c_ListaVendedor
            .Top         = 255
            .Left        = 3
            .Width       = 435
            .Height      = 180
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        *-- GradeVendedor sera na Fase 4
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPgOperacional - Page2 do pgfPrincipal (Operacional)
    * Grids: GradeTotal, GradeMobra + campos operacionais + cntResumo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPgOperacional()
        LOCAL loc_oPgOper
        loc_oPgOper = THIS.pgf_4c_Paginas.Page2.pgf_4c_Principal.Page2

        *-- Container Resumo (legado: cntResumo)
        loc_oPgOper.AddObject("cnt_4c_Resumo", "Container")
        WITH loc_oPgOper.cnt_4c_Resumo
            .Top         = 5
            .Left        = 3
            .Width       = 435
            .Height      = 60
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        *-- Controles de Resumo (Get_Valos, Get_ValNDevs, Get_Liquidos) serao na Fase 5/6

        *-- GradeTotal e GradeMobra serao adicionados na Fase 4
        *-- Campos operacionais (getDatas, getCodigo, getNotas, etc.) serao na Fase 5/6
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPgInformacoes - Page3 do pgfPrincipal (Informacoes)
    * Containers: Origem, Destino, cntFPubl + botoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPgInformacoes()
        LOCAL loc_oPgInfo
        loc_oPgInfo = THIS.pgf_4c_Paginas.Page2.pgf_4c_Principal.Page3

        *-- Container Origem (legado: pgInformacoes.Origem)
        loc_oPgInfo.AddObject("cnt_4c_Origem", "Container")
        WITH loc_oPgInfo.cnt_4c_Origem
            .Top         = 5
            .Left        = 3
            .Width       = 220
            .Height      = 80
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        *-- Controles serao na Fase 5/6

        *-- Container Destino (legado: pgInformacoes.Destino)
        loc_oPgInfo.AddObject("cnt_4c_Destino", "Container")
        WITH loc_oPgInfo.cnt_4c_Destino
            .Top         = 5
            .Left        = 225
            .Width       = 220
            .Height      = 80
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        *-- Controles (cmbRegime, etc.) serao na Fase 5/6

        *-- Container Forma Publicidade (legado: cntFPubl)
        loc_oPgInfo.AddObject("cnt_4c_FPubl", "Container")
        WITH loc_oPgInfo.cnt_4c_FPubl
            .Top         = 90
            .Left        = 3
            .Width       = 435
            .Height      = 50
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        *-- Controles (GetCodFPubl, GetDesFPubl) serao na Fase 5/6

        *-- Botoes (Comissao, Titulos, Impostos, Arquivos) serao na Fase 4
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarIndicadorStatus - Cria um textbox indicador de status colorido
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarIndicadorStatus(par_oContainer, par_cNome, par_nLeft, par_nBackColor)
        par_oContainer.AddObject(par_cNome, "TextBox")
        WITH EVALUATE("par_oContainer." + par_cNome)
            .Top           = 2
            .Left          = par_nLeft
            .Width         = 17
            .Height        = 16
            .BorderStyle   = 1
            .SpecialEffect = 1
            .BackColor     = par_nBackColor
            .ReadOnly      = .T.
            .Themes        = .F.
            .TabStop       = .F.
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF par_nPagina < 1 OR par_nPagina > 2
            par_nPagina = 1
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.this_cModoAtual = "LISTA"
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Handler do botao Inserir (PUBLIC para BINDEVENT)
    * Legado: grupo_op.Click(1) - prepara novo registro e vai para Page2
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lOk
        loc_lOk = .T.

        TRY
            *-- Verificar permissao de acesso
            IF NOT THIS.this_lPlacinserir
                MsgAviso("Usu" + CHR(225) + "rio sem permiss" + CHR(227) + "o para incluir registros.")
                loc_lOk = .F.
            ENDIF

            IF loc_lOk
                *-- Preparar BO para novo registro (NovoRegistro chama LimparDados e seta flags)
                THIS.this_oBusinessObject.NovoRegistro()
                THIS.this_oBusinessObject.this_cPcescolha = "INSERIR"

                *-- Definir empresa padrao
                THIS.this_oBusinessObject.this_cEmps = go_4c_Sistema.cCodEmpresa

                *-- Definir data padrao (hoje)
                THIS.this_oBusinessObject.this_dDatas     = DATE()
                THIS.this_oBusinessObject.this_dDatatrans  = DATE()
                THIS.this_oBusinessObject.this_dDatars     = DATE()

                *-- Limpar campos do formulario
                THIS.LimparCampos()

                *-- Modo INCLUIR
                THIS.this_cModoAtual = "INCLUIR"

                *-- Transferir dados iniciais do BO para o form
                THIS.BOParaForm()

                *-- Ir para pagina de dados
                THIS.AlternarPagina(2)

                *-- Habilitar campos para edicao
                THIS.HabilitarCampos(.T.)

                *-- Atualizar caption da pagina dados
                THIS.pgf_4c_Paginas.Page2.lbl_4c_TxtCaption.Caption = ;
                    "Incluindo - " + ALLTRIM(go_4c_Sistema.cCodEmpresa)
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao preparar inclus" + CHR(227) + "o:" + CHR(13) + loException.Message)
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConsultarClick - Handler do botao Consultar (PUBLIC para BINDEVENT)
    * Legado: grupo_op.Click(2) - carrega registro selecionado em modo somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnConsultarClick()
        LOCAL loc_oPagina, loc_cChave, loc_lOk
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_lOk = .F.

        TRY
            IF TYPE("loc_oPagina.grd_4c_Lista.ActiveRow") = "N" AND ;
               loc_oPagina.grd_4c_Lista.ActiveRow > 0

                *-- Obter chave do registro selecionado no grid
                loc_cChave = THIS.ObterChaveDoGrid()

                IF !EMPTY(loc_cChave)
                    *-- Carregar registro completo no BO
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                        THIS.this_oBusinessObject.this_cPcescolha = "CONSULTAR"
                        THIS.this_oBusinessObject.this_lNovoRegistro = .F.

                        *-- Transferir dados do BO para campos do form
                        THIS.BOParaForm()

                        *-- Modo VISUALIZAR (somente leitura)
                        THIS.this_cModoAtual = "VISUALIZAR"

                        *-- Ir para pagina de dados
                        THIS.AlternarPagina(2)

                        *-- Desabilitar campos (somente consulta)
                        THIS.HabilitarCampos(.F.)

                        *-- Atualizar caption
                        THIS.pgf_4c_Paginas.Page2.lbl_4c_TxtCaption.Caption = ;
                            "Consultando - " + ALLTRIM(THIS.this_oBusinessObject.this_cDopes) + ;
                            " N" + CHR(250) + "mero: " + TRANSFORM(THIS.this_oBusinessObject.this_nNumes)

                        loc_lOk = .T.
                    ELSE
                        MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro selecionado.")
                    ENDIF
                ELSE
                    MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel identificar o registro selecionado.")
                ENDIF
            ELSE
                MsgAviso("Selecione um registro na grade para consultar.")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao consultar registro:" + CHR(13) + loException.Message)
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Handler do botao Alterar (PUBLIC para BINDEVENT)
    * Legado: grupo_op.Click(3) - carrega registro e habilita edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oPagina, loc_cChave, loc_lOk
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_lOk = .F.

        TRY
            *-- Verificar permissao de acesso
            IF NOT THIS.this_lPlacalterar
                MsgAviso("Usu" + CHR(225) + "rio sem permiss" + CHR(227) + "o para alterar registros.")
                loc_lOk = .F.
            ELSE
                loc_lOk = .T.
            ENDIF

            IF loc_lOk
                IF TYPE("loc_oPagina.grd_4c_Lista.ActiveRow") = "N" AND ;
                   loc_oPagina.grd_4c_Lista.ActiveRow > 0

                    *-- Obter chave do registro selecionado no grid
                    loc_cChave = THIS.ObterChaveDoGrid()

                    IF !EMPTY(loc_cChave)
                        *-- Carregar registro completo no BO
                        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                            THIS.this_oBusinessObject.this_cPcescolha = "ALTERAR"

                            *-- EditarRegistro() seta flags de edicao no BO
                            THIS.this_oBusinessObject.EditarRegistro()

                            *-- Transferir dados do BO para campos do form
                            THIS.BOParaForm()

                            *-- Modo ALTERAR
                            THIS.this_cModoAtual = "ALTERAR"

                            *-- Ir para pagina de dados
                            THIS.AlternarPagina(2)

                            *-- Habilitar campos para edicao
                            THIS.HabilitarCampos(.T.)

                            *-- Atualizar caption
                            THIS.pgf_4c_Paginas.Page2.lbl_4c_TxtCaption.Caption = ;
                                "Alterando - " + ALLTRIM(THIS.this_oBusinessObject.this_cDopes) + ;
                                " N" + CHR(250) + "mero: " + TRANSFORM(THIS.this_oBusinessObject.this_nNumes)

                        ELSE
                            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro selecionado.")
                        ENDIF
                    ELSE
                        MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel identificar o registro selecionado.")
                    ENDIF
                ELSE
                    MsgAviso("Selecione um registro na grade para alterar.")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao preparar altera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message)
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Handler do botao Excluir (PUBLIC para BINDEVENT)
    * Legado: grupo_op.Click(4) - exclui registro selecionado apos confirmacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oPagina, loc_cChave, loc_lOk
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_lOk = .F.

        TRY
            *-- Verificar permissao de acesso
            IF NOT THIS.this_lPlacexcluir
                MsgAviso("Usu" + CHR(225) + "rio sem permiss" + CHR(227) + "o para excluir registros.")
                loc_lOk = .F.
            ELSE
                loc_lOk = .T.
            ENDIF

            IF loc_lOk
                IF TYPE("loc_oPagina.grd_4c_Lista.ActiveRow") = "N" AND ;
                   loc_oPagina.grd_4c_Lista.ActiveRow > 0

                    *-- Obter chave do registro selecionado no grid
                    loc_cChave = THIS.ObterChaveDoGrid()

                    IF !EMPTY(loc_cChave)
                        *-- Carregar registro completo no BO para confirmacao visual
                        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)

                            *-- Mensagem de confirmacao detalhada
                            LOCAL loc_cMsg
                            loc_cMsg = "Confirma exclus" + CHR(227) + "o do registro?" + CHR(13) + CHR(13) + ;
                                "Opera" + CHR(231) + CHR(227) + "o: " + ;
                                ALLTRIM(THIS.this_oBusinessObject.this_cDopes) + CHR(13) + ;
                                "N" + CHR(250) + "mero: " + ;
                                TRANSFORM(THIS.this_oBusinessObject.this_nNumes) + CHR(13) + ;
                                "Empresa: " + ALLTRIM(THIS.this_oBusinessObject.this_cEmps) + CHR(13) + ;
                                "Valor: " + TRANSFORM(THIS.this_oBusinessObject.this_nValos, "999,999,999.99")

                            IF MsgConfirma(loc_cMsg)
                                THIS.this_oBusinessObject.this_cPcescolha = "EXCLUIR"

                                *-- Iniciar transacao
                                LOCAL loc_nTrans
                                loc_nTrans = SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

                                IF loc_nTrans >= 0
                                    *-- Excluir itens vinculados (SigMvItn)
                                    LOCAL loc_cSQLItens, loc_nResItens
                                    loc_cSQLItens = "DELETE FROM SigMvItn WHERE emps = " + ;
                                        EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cEmps)) + ;
                                        " AND dopes = " + ;
                                        EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cDopes)) + ;
                                        " AND numes = " + ;
                                        FormatarNumeroSQL(THIS.this_oBusinessObject.this_nNumes)
                                    loc_nResItens = SQLEXEC(gnConnHandle, loc_cSQLItens)

                                    *-- Excluir cabecalho
                                    LOCAL loc_lExcluiu
                                    loc_lExcluiu = THIS.this_oBusinessObject.Excluir()

                                    IF loc_lExcluiu
                                        SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.")
                                        THIS.CarregarLista()
                                    ELSE
                                        SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                        MsgErro("Erro ao excluir registro:" + CHR(13) + ;
                                            THIS.this_oBusinessObject.this_cMensagemErro)
                                    ENDIF
                                ELSE
                                    MsgErro("Erro ao iniciar transa" + CHR(231) + CHR(227) + "o de exclus" + CHR(227) + "o.")
                                ENDIF
                            ENDIF
                        ELSE
                            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro para exclus" + CHR(227) + "o.")
                        ENDIF
                    ELSE
                        MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel identificar o registro selecionado.")
                    ENDIF
                ELSE
                    MsgAviso("Selecione um registro na grade para excluir.")
                ENDIF
            ENDIF
        CATCH TO loException
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            MsgErro("Erro ao excluir:" + CHR(13) + loException.Message)
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcurarClick - Handler do botao Procurar (PUBLIC para BINDEVENT)
    * Abre FormBuscaAuxiliar para localizar movimentacao pelo cabecalho
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcurarClick()
        LOCAL loc_oBusca, loc_cChave, loc_cSQL, loc_nRes
        loc_cChave = ""

        TRY
            loc_cSQL = "SELECT TOP 500 empdopnums, emps, dopes," + ;
                       " numes, datas, valos" + ;
                       " FROM SigMvCab" + ;
                       " WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " ORDER BY datas DESC, numes DESC"
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMv")

            IF loc_nRes > 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF !ISNULL(loc_oBusca)
                    loc_oBusca.this_cTitulo = "Buscar Movimenta" + CHR(231) + CHR(227) + "o"
                    loc_oBusca.mSetCursor("cursor_4c_BuscaMv")
                    loc_oBusca.mAddColuna("empdopnums", "Chave",   80)
                    loc_oBusca.mAddColuna("dopes",      "Opera" + CHR(231) + CHR(227) + "o", 100)
                    loc_oBusca.mAddColuna("numes",      "N" + CHR(250) + "mero", 70)
                    loc_oBusca.mAddColuna("datas",      "Data",    80)
                    loc_oBusca.mAddColuna("valos",      "Valor",   90)
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou
                        SELECT cursor_4c_BuscaMv
                        loc_cChave = ALLTRIM(cursor_4c_BuscaMv.empdopnums)
                    ENDIF

                    loc_oBusca = .NULL.
                ENDIF
            ELSE
                MsgErro("Erro ao buscar movimenta" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL())
            ENDIF

            IF USED("cursor_4c_BuscaMv")
                USE IN cursor_4c_BuscaMv
            ENDIF
        CATCH TO loException
            loc_oBusca = .NULL.
            IF USED("cursor_4c_BuscaMv")
                USE IN cursor_4c_BuscaMv
            ENDIF
        ENDTRY

        IF !EMPTY(loc_cChave)
            TRY
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                    THIS.this_oBusinessObject.this_cPcescolha = "CONSULTAR"
                    THIS.this_oBusinessObject.this_lNovoRegistro = .F.
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.AlternarPagina(2)
                    THIS.HabilitarCampos(.F.)
                ELSE
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro selecionado.")
                ENDIF
            CATCH TO loException
                MsgErro("Erro ao carregar registro:" + CHR(13) + loException.Message)
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Handler do botao Sair (PUBLIC para BINDEVENT)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THISFORM.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Handler do botao Salvar (PUBLIC para BINDEVENT)
    * Legado: grupo_salva.Salva.Click - valida, salva e retorna a Page1
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Transferir dados do formulario para o BO
            THIS.FormParaBO()

            *-- Validar campos obrigatorios
            IF EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cDopes))
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria.")
            ELSE
                *-- Guardar flag antes de salvar (Salvar reseta this_lNovoRegistro)
                LOCAL loc_lEraNovoRegistro
                loc_lEraNovoRegistro = THIS.this_oBusinessObject.this_lNovoRegistro

                *-- Iniciar transacao
                LOCAL loc_nTrans
                loc_nTrans = SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

                IF loc_nTrans >= 0
                    *-- Chamar Salvar() do BO (publico - chama Inserir/Atualizar internamente)
                    loc_lSucesso = THIS.this_oBusinessObject.Salvar()

                    IF loc_lSucesso
                        SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")

                        LOCAL loc_cMsgOk
                        IF loc_lEraNovoRegistro
                            loc_cMsgOk = "Registro inclu" + CHR(237) + "do com sucesso."
                        ELSE
                            loc_cMsgOk = "Registro alterado com sucesso."
                        ENDIF
                        MsgInfo(loc_cMsgOk)

                        *-- Recarregar a grade e voltar para Page1
                        THIS.CarregarLista()
                        THIS.AlternarPagina(1)
                    ELSE
                        SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                        MsgErro("Erro ao salvar:" + CHR(13) + ;
                            THIS.this_oBusinessObject.this_cMensagemErro)
                    ENDIF
                ELSE
                    MsgErro("Erro ao iniciar transa" + CHR(231) + CHR(227) + "o.")
                ENDIF
            ENDIF
        CATCH TO loException
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            MsgErro("Erro ao salvar:" + CHR(13) + loException.Message)
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Handler do botao Cancelar (PUBLIC para BINDEVENT)
    * Legado: grupo_salva.Cancelar.Click - cancela operacao e volta para Page1
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_lCancelar
        loc_lCancelar = .T.

        *-- Confirmar cancelamento se estava em modo de edicao
        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            loc_lCancelar = MsgConfirma("Deseja cancelar a opera" + CHR(231) + CHR(227) + "o atual?")
        ENDIF

        IF loc_lCancelar
            SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION")

            *-- Limpar campos e voltar para lista
            THIS.LimparCampos()
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCarregarListaClick - Handler do botao Carregar Lista (PUBLIC para BINDEVENT)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCarregarListaClick()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * GridListaDblClick - Handler DblClick no grid lista (PUBLIC para BINDEVENT)
    *--------------------------------------------------------------------------
    PROCEDURE GridListaDblClick()
        THIS.BtnConsultarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * GridListaKeyPress - Handler KeyPress no grid lista (PUBLIC para BINDEVENT)
    *--------------------------------------------------------------------------
    PROCEDURE GridListaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        DO CASE
            CASE par_nKeyCode = 13   && Enter
                THIS.BtnConsultarClick()
            CASE par_nKeyCode = 46   && Delete
                THIS.BtnExcluirClick()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega a grade principal com dados do SQL Server
    * Legado: Activate pagina 1 - query SigMvCab com filtros de periodo/empresa
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_cEmps, loc_dDtIni, loc_dDtFim
        LOCAL loc_cSQL, loc_nResultado, loc_cWhere
        loc_lSucesso = .F.

        TRY
            *-- Obter valores dos filtros
            LOCAL loc_oPagina
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- Empresa
            loc_cEmps = ""
            IF TYPE("loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_Empresa.Value") = "C"
                loc_cEmps = ALLTRIM(loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_Empresa.Value)
            ENDIF
            IF EMPTY(loc_cEmps)
                loc_cEmps = go_4c_Sistema.cCodEmpresa
            ENDIF

            *-- Datas
            loc_dDtIni = {}
            loc_dDtFim = {}
            IF TYPE("loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_DtInicial.Value") = "D"
                loc_dDtIni = loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_DtInicial.Value
            ENDIF
            IF TYPE("loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_DtFinal.Value") = "D"
                loc_dDtFim = loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_DtFinal.Value
            ENDIF

            *-- Se datas vazias, usar mes corrente
            IF EMPTY(loc_dDtIni)
                loc_dDtIni = DATE(YEAR(DATE()), MONTH(DATE()), 1)
            ENDIF
            IF EMPTY(loc_dDtFim)
                loc_dDtFim = DATE()
            ENDIF

            *-- Atualizar campos de filtro com valores efetivos
            IF TYPE("loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_Empresa.Value") = "C"
                loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_Empresa.Value = loc_cEmps
            ENDIF
            IF TYPE("loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_DtInicial.Value") = "D"
                loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_DtInicial.Value = loc_dDtIni
            ENDIF
            IF TYPE("loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_DtFinal.Value") = "D"
                loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_DtFinal.Value = loc_dDtFim
            ENDIF

            *-- Montar SQL com filtros
            loc_cWhere = " WHERE c.emps = " + EscaparSQL(loc_cEmps)
            loc_cWhere = loc_cWhere + " AND c.datas >= " + FormatarDataSQL(loc_dDtIni)
            loc_cWhere = loc_cWhere + " AND c.datas <= " + FormatarDataSQL(loc_dDtFim)

            IF TYPE("loc_oPagina.cnt_4c_Filtros.opt_4c_Ordem.Value") = "N"
                LOCAL loc_nOrdem
                loc_nOrdem = loc_oPagina.cnt_4c_Filtros.opt_4c_Ordem.Value
                DO CASE
                    CASE loc_nOrdem = 2  && Pendentes
                        loc_cWhere = loc_cWhere + " AND ISNULL(c.chkpagos,0) = 0"
                    CASE loc_nOrdem = 3  && Baixadas
                        loc_cWhere = loc_cWhere + " AND ISNULL(c.chkpagos,0) = 1"
                ENDCASE
            ENDIF

            loc_cSQL = "SELECT c.emps, c.dopes, c.numes," + ;
                       " c.datas, c.contaos, " + ;
                       " ISNULL(cli.Rclis,'') AS dcontas," + ;
                       " c.valos," + ;
                       " CASE WHEN ISNULL(c.lcancelas,0) = 1 THEN 'C'" + ;
                       "      WHEN ISNULL(c.chkpagos,0)  = 1 THEN 'P'" + ;
                       "      ELSE '' END AS status," + ;
                       " c.dopes AS oper," + ;
                       " ISNULL(o.Dopes,'') AS doper" + ;
                       " FROM SigMvCab c" + ;
                       " LEFT JOIN SigCdCli cli ON c.contaos = cli.Iclis" + ;
                       " LEFT JOIN SigCdOpe o ON c.dopes = o.Dopes" + ;
                       loc_cWhere + ;
                       " ORDER BY c.datas DESC, c.numes DESC"

            *-- Executar query em cursor temporario
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Temp")
            IF loc_nResultado >= 0
                *-- Limpar cursor do grid e preencher com dados novos
                SELECT cursor_4c_Lista
                ZAP

                IF USED("cursor_4c_Temp") AND RECCOUNT("cursor_4c_Temp") > 0
                    SELECT cursor_4c_Temp
                    SCAN
                        INSERT INTO cursor_4c_Lista (;
                            cEmps, cDopes, cNumes, dDatas, ;
                            cContas, cDcontas, nValor, cStatus, cOper, cDoper ;
                        ) VALUES (;
                            cursor_4c_Temp.emps, ;
                            cursor_4c_Temp.dopes, ;
                            PADL(TRANSFORM(INT(cursor_4c_Temp.numes)), 9, "0"), ;
                            IIF(VARTYPE(cursor_4c_Temp.datas) = "T", TTOD(cursor_4c_Temp.datas), cursor_4c_Temp.datas), ;
                            cursor_4c_Temp.contaos, ;
                            cursor_4c_Temp.dcontas, ;
                            cursor_4c_Temp.valos, ;
                            cursor_4c_Temp.status, ;
                            cursor_4c_Temp.oper, ;
                            cursor_4c_Temp.doper ;
                        )
                    ENDSCAN
                ENDIF

                IF USED("cursor_4c_Temp")
                    USE IN cursor_4c_Temp
                ENDIF

                SELECT cursor_4c_Lista
                GO TOP

                *-- Atualizar grid
                loc_oPagina.grd_4c_Lista.Refresh()

                *-- Atualizar label de usuario
                IF TYPE("loc_oPagina.lbl_4c_Usuario") = "O"
                    loc_oPagina.lbl_4c_Usuario.Caption = "Usu" + CHR(225) + "rio: " + ;
                        ALLTRIM(gc_4c_UsuarioLogado) + " - " + ;
                        TRANSFORM(RECCOUNT("cursor_4c_Lista")) + " registro(s)"
                ENDIF

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar dados:" + CHR(13) + CapturarErroSQL())
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message)
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChaveDoGrid - Monta chave composta EmpDopNums a partir da linha
    * selecionada no grid da Page1 (cursor_4c_Lista)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChaveDoGrid()
        LOCAL loc_cChave
        loc_cChave = ""

        TRY
            IF USED("cursor_4c_Lista") AND RECCOUNT("cursor_4c_Lista") > 0
                SELECT cursor_4c_Lista
                IF !EOF()
                    loc_cChave = PADR(ALLTRIM(cursor_4c_Lista.cEmps), 3) + ;
                                 PADR(ALLTRIM(cursor_4c_Lista.cDopes), 20) + ;
                                 PADL(ALLTRIM(cursor_4c_Lista.cNumes), 6, "0")
                ENDIF
            ENDIF
        CATCH TO loException
            loc_cChave = ""
        ENDTRY

        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados dos campos do formulario para o BO
    * Legado: Campos do form -> propriedades do TprMvCab cursor
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_oPgDados, loc_oPgContas
        loc_oBO = THIS.this_oBusinessObject
        loc_oPgDados = THIS.pgf_4c_Paginas.Page2

        TRY
            *-- Empresa (sempre a empresa atual se for inclusao)
            IF loc_oBO.this_lNovoRegistro
                loc_oBO.this_cEmps = go_4c_Sistema.cCodEmpresa
            ENDIF

            *-- Operacao (dopes) - campo obrigatorio
            *-- Sera preenchido pelo lookup ou campo de operacao na pagina de dados
            *-- Nesta fase, os campos de texto da pgContas/pgOperacional sao containers vazios
            *-- Os valores ja estarao no BO pois foram setados via lookups

            *-- Atualizar usuario de alteracao
            loc_oBO.this_cUsualts = gc_4c_UsuarioLogado

            *-- Montar chave composta se for novo registro
            IF loc_oBO.this_lNovoRegistro
                *-- Obter proximo numero da operacao
                IF EMPTY(ALLTRIM(loc_oBO.this_cDopes))
                    RETURN
                ENDIF
                LOCAL loc_cSQL, loc_nRes
                loc_cSQL = "SELECT ISNULL(MAX(numes),0) + 1 AS prox" + ;
                    " FROM SigMvCab WHERE emps = " + EscaparSQL(ALLTRIM(loc_oBO.this_cEmps)) + ;
                    " AND dopes = " + EscaparSQL(ALLTRIM(loc_oBO.this_cDopes))
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxNum")
                IF loc_nRes > 0 AND USED("cursor_4c_ProxNum")
                    loc_oBO.this_nNumes = cursor_4c_ProxNum.prox
                    USE IN cursor_4c_ProxNum
                ENDIF
                loc_oBO.MontarChaveComposta()
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormParaBO:" + CHR(13) + loException.Message)
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do BO para os campos do formulario
    * Legado: TprMvCab cursor -> campos do form
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_oPgDados
        loc_oBO = THIS.this_oBusinessObject
        loc_oPgDados = THIS.pgf_4c_Paginas.Page2

        TRY
            *-- Caption principal com operacao e numero
            IF !EMPTY(ALLTRIM(loc_oBO.this_cDopes))
                loc_oPgDados.lbl_4c_TxtCaption.Caption = ;
                    ALLTRIM(loc_oBO.this_cDopes) + ;
                    IIF(loc_oBO.this_nNumes > 0, ;
                        " - N" + CHR(250) + "mero: " + TRANSFORM(loc_oBO.this_nNumes), "")
            ELSE
                loc_oPgDados.lbl_4c_TxtCaption.Caption = ""
            ENDIF

            *-- Os campos detalhados das pgContas, pgOperacional e pgInformacoes
            *-- serao populados na Fase 8 quando os controles internos forem criados
            *-- Nesta fase, a estrutura de containers ja existe mas sem os TextBox internos

        CATCH TO loException
            MsgErro("Erro em BOParaForm:" + CHR(13) + loException.Message)
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos do formulario e reseta BO
    * Legado: LimpaCampos()
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        TRY
            *-- Resetar propriedades do BO
            loc_oBO.this_cEmps             = go_4c_Sistema.cCodEmpresa
            loc_oBO.this_cDopes            = ""
            loc_oBO.this_nNumes            = 0
            loc_oBO.this_cEmpDopNums       = ""
            loc_oBO.this_dDatas            = DATE()
            loc_oBO.this_dDatatrans        = DATE()
            loc_oBO.this_dDatars           = DATE()
            loc_oBO.this_dDtfecha          = {}
            loc_oBO.this_cGrupoos          = ""
            loc_oBO.this_cContaos          = ""
            loc_oBO.this_cGrupods          = ""
            loc_oBO.this_cContads          = ""
            loc_oBO.this_cIclis            = ""
            loc_oBO.this_cGrupovendedors   = ""
            loc_oBO.this_cContavendedors   = ""
            loc_oBO.this_cVends            = ""
            loc_oBO.this_cGrvends          = ""
            loc_oBO.this_cGruporespons     = ""
            loc_oBO.this_cContarespons     = ""
            loc_oBO.this_cGrupojobs        = ""
            loc_oBO.this_cContajobs        = ""
            loc_oBO.this_cJobs             = ""
            loc_oBO.this_nValos            = 0
            loc_oBO.this_nValvars          = 0
            loc_oBO.this_nValdevs          = 0
            loc_oBO.this_nValndevs         = 0
            loc_oBO.this_nValinis          = 0
            loc_oBO.this_nAcres            = 0
            loc_oBO.this_nVars             = 0
            loc_oBO.this_nDesconto         = 0
            loc_oBO.this_nFrete            = 0
            loc_oBO.this_nSeguro           = 0
            loc_oBO.this_nDespaces         = 0
            loc_oBO.this_nIpi              = 0
            loc_oBO.this_nIcms             = 0
            loc_oBO.this_nIss              = 0
            loc_oBO.this_cNotas            = ""
            loc_oBO.this_cSeries           = ""
            loc_oBO.this_cObses            = ""
            loc_oBO.this_nCodobs           = 0
            loc_oBO.this_cCidchaves        = ""
            loc_oBO.this_cOpers            = ""
            loc_oBO.this_cEcfs             = ""
            loc_oBO.this_cMascnum          = ""
            loc_oBO.this_cTabds            = ""
            loc_oBO.this_cLprecos          = ""
            loc_oBO.this_cTpfats           = ""
            loc_oBO.this_cTransps          = ""
            loc_oBO.this_cEmpds            = ""
            loc_oBO.this_cLocals           = ""
            loc_oBO.this_cTpMovs           = ""
            loc_oBO.this_cCodtrans         = ""
            loc_oBO.this_cMeiotrans        = ""
            loc_oBO.this_cCompets          = ""
            loc_oBO.this_cFpubls           = ""
            loc_oBO.this_cDescs            = ""
            loc_oBO.this_cDesc2s           = ""
            loc_oBO.this_lChkbxparcs       = .F.
            loc_oBO.this_lChksubn          = .F.
            loc_oBO.this_lDevols           = .F.
            loc_oBO.this_lCancelas         = .F.
            loc_oBO.this_lChkregister      = .F.

            *-- Limpar caption da pagina dados
            THIS.pgf_4c_Paginas.Page2.lbl_4c_TxtCaption.Caption = ""

        CATCH TO loException
            MsgErro("Erro ao limpar campos:" + CHR(13) + loException.Message)
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos conforme modo de operacao
    * par_lHabilitar : .T. = campos editaveis, .F. = somente leitura
    * Legado: EnabledFields/DisabledFields
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPgDados
        loc_oPgDados = THIS.pgf_4c_Paginas.Page2

        TRY
            *-- Botoes Salvar/Cancelar - Salvar so aparece em INCLUIR/ALTERAR
            IF TYPE("loc_oPgDados.cnt_4c_BotoesSalvar.cmd_4c_Salvar") = "O"
                loc_oPgDados.cnt_4c_BotoesSalvar.cmd_4c_Salvar.Enabled = par_lHabilitar
            ENDIF

            *-- PageFrame principal interno (pgContas, pgOperacional, pgInformacoes)
            IF TYPE("loc_oPgDados.pgf_4c_Principal") = "O"
                loc_oPgDados.pgf_4c_Principal.Enabled = .T.
            ENDIF

            *-- Os controles internos dos containers serao habilitados/desabilitados
            *-- na Fase 8 quando forem criados. Nesta fase, apenas os containers existem.

        CATCH TO loException
            *-- Silenciar erros de controles inexistentes durante fases intermediarias
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Liberacao de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF !ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
